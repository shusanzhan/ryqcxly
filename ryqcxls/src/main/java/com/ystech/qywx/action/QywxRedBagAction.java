package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.service.AppUserManageImpl;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

@Component("qywxRedBagAction")
@Scope("prototype")
public class QywxRedBagAction extends BaseController{
	private AppUserManageImpl appUserManageImpl;
	private RedBagManageImpl redBagManageImpl;

	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}

	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myRedBag() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			User sessionUser = getSessionUser();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			request.setAttribute("monthDay", start.subSequence(5, 7));
			String sql="select * from qywx_redBag where DATE_FORMAT(createDate,'%Y-%m')='"+start+"' and userId="+sessionUser.getDbid()+" and turnBackStatus="+RedBag.SUCCESS;
			List<RedBag> redBags = redBagManageImpl.executeSql(sql, null);
			request.setAttribute("redBags", redBags);
			String totalNumSql="select sum(redBagMoney) as totalNum from qywx_redBag where DATE_FORMAT(createDate,'%Y-%m')='"+start+"' and userId="+sessionUser.getDbid()+" and turnBackStatus="+RedBag.SUCCESS;
			Object count = redBagManageImpl.countBySql(totalNumSql);
			request.setAttribute("count", count);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myRedBag";
	}
	/**
	 * 功能描述：红包列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String redBagSort() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			User sessionUser = getSessionUser();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			request.setAttribute("monthDay", start.subSequence(5, 7));
			Enterprise enterprise = sessionUser.getEnterprise();
			List<RedBag> redBags = redBagManageImpl.findb(start,enterprise);
			request.setAttribute("redBags", redBags);
			request.setAttribute("user", sessionUser);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "redBagSort";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String sendBag() throws Exception {
		HttpServletRequest request = this.getRequest();
		User sessionUser = getSessionUser();
		try {
			String realName = sessionUser.getRealName();
			/*if(!realName.equals("赵晨笛")){
				return "error";
			}*/
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "sendBag";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveSendBag() throws Exception {
		HttpServletRequest request = this.getRequest();
		String remark = request.getParameter("remark");
		Float money = ParamUtil.getFloatParam(request, "money", -1);
		String userId = request.getParameter("userId");
		try {
			User sessionUser = getSessionUser();
			String realName = sessionUser.getRealName();
			if(!realName.equals("赵晨笛")){
				renderErrorMsg(new Throwable("您无发红包权限"), "");
				return ;
			}
			List<AppUser> appUsers = appUserManageImpl.executeSql("select * from qywx_appUser apu,sys_user us where us.dbid=apu.userId and us.userId=? and apu.appId=51", userId);
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
			RedBag	redBag=new RedBag();
			redBag.setActName("领导奖励红包");
			redBag.setRemark(remark);
			redBag.setWishing(remark);
			
			redBag.setRedBagMoney(money.doubleValue());
			redBag.setOpenId(appUser.getOpenId());
			User user2 = appUser.getUser();
			if(null!=user2.getDepartment()){
				redBag.setDepartmentId(user2.getDepartment().getDbid());
			}
			String billNo = getBillNo();
			List<RedBag> redBags = redBagManageImpl.findBy("billno", billNo);
			if(null!=redBags&&redBags.size()>0){
				billNo=getBillNo();
			}
			redBag.setBillno(billNo);
			redBag.setAppId(appUser.getRedBagAppId());
			redBag.setCreateDate(new Date());
			redBag.setCreator(sessionUser.getRealName());
			redBag.setCustomerId(null);
			redBag.setOpenId(appUser.getOpenId());
			redBag.setSendTime(new Date());
			redBag.setTurnBackStatus(RedBag.COMM);
			User user = appUser.getUser();
			if(null!=user){
				if(null!=user.getEnterprise()){
					redBag.setEnterprise(user.getEnterprise());
				}
				redBag.setRecipientId(user.getDbid());
				redBag.setRecipientName(user.getRealName());
			}
			String remoteAddr = request.getRemoteAddr();
			redBag.setIp(remoteAddr);
			redBag.setNote(remark);
			redBag.setNum(1);
			redBagManageImpl.save(redBag);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("发送失败！"), "");
			return ;
		}
		renderMsg("/qywxRedBag/sendBag", "发送红包成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String mySendBag() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			User sessionUser = getSessionUser();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			request.setAttribute("monthDay", start.subSequence(5, 7));
			String sql="select * from qywx_redBag where DATE_FORMAT(createDate,'%Y-%m')='"+start+"' and creator='"+sessionUser.getRealName()+"'";
			List<RedBag> redBags = redBagManageImpl.executeSql(sql, null);
			request.setAttribute("redBags", redBags);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "mySendBag";
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
