package com.ystech.cust.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerTrackStatic;
import com.ystech.cust.service.CustomerTrackStaticManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("customerTrackStaticAction")
@Scope("prototype")
public class CustomerTrackStaticAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	private CustomerTrackStaticManageImpl customerTrackStaticManageImpl;
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCustomerTrackStaticManageImpl(
			CustomerTrackStaticManageImpl customerTrackStaticManageImpl) {
		this.customerTrackStaticManageImpl = customerTrackStaticManageImpl;
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
			List<Enterprise> enterprisess = findEnterprise(role, sessionUser);
			request.setAttribute("enterprisess", enterprisess);
			
			Enterprise enterprise = sessionUser.getEnterprise();
			Map<String, List<CustomerTrackStatic>> map=new HashMap<String, List<CustomerTrackStatic>>();
			List<CustomerTrackStatic> customerTrackStatics=null;
			customerTrackStatics=customerTrackStaticManageImpl.findByDate(start, enterprise.getDbid(), null);
			map.put(enterprise.getDbid()+"",customerTrackStatics);
			request.setAttribute("map", map);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "today";
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
