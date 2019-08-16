package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerTrackCount;
import com.ystech.cust.model.CustomerTrackStatic;
import com.ystech.cust.service.CustomerTrackStaticManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

@Component("qywxComprehensiveStaticAction")
@Scope("prototype")
public class QywxComprehensiveStaticAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	private CustomerTrackStaticManageImpl customerTrackStaticManageImpl;
	private CustomerTractUtile customerTractUtile;
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCustomerTrackStaticManageImpl(
			CustomerTrackStaticManageImpl customerTrackStaticManageImpl) {
		this.customerTrackStaticManageImpl = customerTrackStaticManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	/**
	 * 功能描述：监控当日数据
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String today() throws Exception {
		HttpServletRequest request = this.getRequest();
		//领导查询类型1、总经理；2、区域经理；3、销售副总
		String role = request.getParameter("role");
		String startTime = request.getParameter("startTime");
		try {
			User sessionUser = getSessionUser();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			String start=null;
			if(null==startTime){
				start=format.format(new Date());
			}else{
				start=startTime;
			}
			Enterprise enterprise = sessionUser.getEnterprise();
			List<Enterprise> enterprisess = new ArrayList<Enterprise>();
			enterprisess.add(enterprise);
			request.setAttribute("enterprisess", enterprisess);
			
			Map<String, List<CustomerTrackStatic>> map=new HashMap<String, List<CustomerTrackStatic>>();
			List<CustomerTrackStatic>	customerTrackStatics= customerTrackStaticManageImpl.findByDate(start, enterprise.getDbid(),null);
			map.put(enterprise.getDbid()+"",customerTrackStatics);
			request.setAttribute("map", map);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "today";
	}
	
	/**
	* 功能描述：经销商回访统计分析
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String queryCustomerTrackCountList(){
		HttpServletRequest request = getRequest();
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userName=request.getParameter("userName");
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Date start=null;
		Date end=null;
		try {
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			User currentUser = getSessionUser();
			String enterpriseIds="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				enterpriseIds=currentUser.getCompnayIds();
			}else{
				enterpriseIds=enterpriseIds+currentUser.getEnterprise().getDbid()+"";
			}
			List<Enterprise> enterprises=null;
			if(null!=enterpriseIds){
				enterprises = enterpriseManageImpl.executeSql("select * from sys_Enterprise where dbid in("+enterpriseIds+")", null);
			}else{
				enterprises = enterpriseManageImpl.getAll();
			}
			Enterprise enterprise = currentUser.getEnterprise();
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			List<CustomerTrackCount> customerTrackCounts = customerTractUtile.querySalerCustomerTrackCount(beginDate, endDate, userName, enterpriseId);
			request.setAttribute("customerTrackCounts", customerTrackCounts);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "customerTrackCountList";
	}
	
	/**
	 * 查询公司新
	 * @param role
	 * @param currentUser
	 * @return
	 */
	private List<Enterprise> findEnterprise(String role,User currentUser){
		//总经理
		String sql="select * from sys_enterprise where 1=1 ";
		//区域经理
		if(role.equals("am")){
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and dbid in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and dbid in("+currentUser.getEnterprise().getDbid()+")";
			}
		}
		//销售经理
		if(role.equals("sm")){
			sql=sql+" and dbid in("+currentUser.getEnterprise().getDbid()+")";
		}
		
		List<Enterprise> enterprises = enterpriseManageImpl.executeSql(sql, null);
		return enterprises;
	}
}
