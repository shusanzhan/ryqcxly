package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.core.ParamBuildUtile;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.model.ScanPayReqData;
import com.ystech.qywx.model.ScanPayRespData;
import com.ystech.qywx.service.AppUserManageImpl;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.qywx.service.ScanPayReqDataManageImpl;
import com.ystech.qywx.service.ScanPayRespDataManageImpl;
import com.ystech.qywx.service.SendRedBagUtil;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

@Component("redBagAction")
@Scope("prototype")
public class RedBagAction extends BaseController{
	private RedBagManageImpl redBagManageImpl;
	private AppUserManageImpl appUserManageImpl;
	private SendRedBagUtil sendRedBagUtil;
	private ScanPayReqDataManageImpl scanPayReqDataManageImpl;
	private ScanPayRespDataManageImpl scanPayRespDataManageImpl;
	public RedBagManageImpl getRedBagManageImpl() {
		return redBagManageImpl;
	}
	@Resource
	public void setSendRedBagUtil(SendRedBagUtil sendRedBagUtil) {
		this.sendRedBagUtil = sendRedBagUtil;
	}

	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}

	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	@Resource
	public void setScanPayReqDataManageImpl(
			ScanPayReqDataManageImpl scanPayReqDataManageImpl) {
		this.scanPayReqDataManageImpl = scanPayReqDataManageImpl;
	}
	@Resource
	public void setScanPayRespDataManageImpl(
			ScanPayRespDataManageImpl scanPayRespDataManageImpl) {
		this.scanPayRespDataManageImpl = scanPayRespDataManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from qywx_RedBag where 1=1 ";
			List params=new ArrayList();
			if(!currentUser.getUserId().equals("super")){
				if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
					sql=sql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
				}else{
					sql=sql+" and enterpriseId="+enterprise.getDbid();
				}
			}
			Page<RedBag> page = redBagManageImpl.pagedQuerySql(pageNo, pageSize,RedBag.class,sql, new Object[]{});
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String report() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer customerType = ParamUtil.getIntParam(request, "customerType", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String departmentIds=null;
			/*if(departmentId>0){
				Department department = departmentManageImpl.get(departmentId);
				String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
			}else{
				String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
			}*/
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from qywx_RedBag where 1=1 and turnBackStatus=?";
			List params=new ArrayList();
			params.add(RedBag.SUCCESS);
			if(!currentUser.getUserId().equals("super")){
				if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
					sql=sql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
				}else{
					sql=sql+" and enterpriseId="+enterprise.getDbid();
				}
			}
			if(null!=start){
				sql=sql+" AND createDate>='"+DateUtil.format(start) +"' ";
			}
			if(null!=end){
				sql=sql+" AND createDate<='"+DateUtil.format(end) +"' ";
			}
			List<RedBag> redBags = redBagManageImpl.executeSql(sql, params.toArray());
			request.setAttribute("redBags", redBags);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "report";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewWechat() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			RedBag redBag = redBagManageImpl.get(dbid);
			request.setAttribute("redBag", redBag);
			List<ScanPayReqData> scanPayReqDatas = scanPayReqDataManageImpl.findBy("redBagId", dbid);
			if(null!=scanPayReqDatas&&scanPayReqDatas.size()>0){
				ScanPayReqData scanPayReqData = scanPayReqDatas.get(0);
				request.setAttribute("scanPayReqData", scanPayReqData);
				List<ScanPayRespData> scanPayRespDatas = scanPayRespDataManageImpl.findBy("scanPayReqData.dbid", scanPayReqData.getDbid());
				if(null!=scanPayRespDatas&&scanPayRespDatas.size()>0){
					ScanPayRespData scanPayRespData = scanPayRespDatas.get(0);
					request.setAttribute("scanPayRespData", scanPayRespData);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewWechat";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		String userId = request.getParameter("userId");
		String actName = request.getParameter("actName");
		String remark = request.getParameter("remark");
		String wishing = request.getParameter("wishing");
		Float redBagMoney = ParamUtil.getFloatParam(request, "redBagMoney", -1);
		try {
			List<AppUser> appUsers = appUserManageImpl.executeSql("select * from qywx_appUser apu,user us where us.dbid=apu.userId and us.userId=? and apu.appId=51", userId);
			if(null==appUsers||appUsers.size()<=0){
				renderErrorMsg(new Throwable("无对应的userID"), "");
				return ;
			}
			AppUser appUser = appUsers.get(0);
			Integer status = appUser.getStatus();
			if(status==(int)AppUser.STATUSCOMM){
				renderErrorMsg(new Throwable("useriId还未同步转换"), "");
				return ;
			}
			RedBag redBag=new RedBag();
			redBag.setActName(actName);
			redBag.setRemark(remark);
			redBag.setWishing(wishing);
			redBag.setRedBagMoney(redBagMoney.doubleValue());
			redBag.setOpenId(appUser.getOpenId());
			String billNo = getBillNo();
			redBag.setBillno(billNo);
			String remoteAddr = request.getRemoteAddr();
			redBag.setIp(remoteAddr);
			redBag.setAppId(appUser.getRedBagAppId());
			User user = appUser.getUser();
			if(null!=user){
				redBag.setEnterprise(user.getEnterprise());
			}
			redBagManageImpl.save(redBag);
			
			
			//构造发送红包参数
			ScanPayReqData scanPayReqData = ParamBuildUtile.builtParamsScanPayReqData(redBag);
			scanPayReqDataManageImpl.save(scanPayReqData);
		    sendRedBagUtil.sendRedBag(scanPayReqData);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	private String getBillNo(){
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd");
		String format = f.format(new Date());
		String time = "" + System.currentTimeMillis();
		int beginIndex = time.length() - 10;
		int endIndex = time.length();
		String substring = time.substring(beginIndex, endIndex);
		return format+substring;
	}
}
