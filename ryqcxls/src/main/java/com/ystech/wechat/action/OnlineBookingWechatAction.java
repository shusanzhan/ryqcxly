/**
 * 
 */
package com.ystech.wechat.action;

import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.MemberCarInfo;
import com.ystech.mem.model.OnlineBooking;
import com.ystech.mem.model.OnlineBookingExamined;
import com.ystech.mem.model.OnlineBookingOldCarChanage;
import com.ystech.mem.model.OnlineBookingSafetyMaintenance;
import com.ystech.mem.service.MemberCarInfoManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.OnlineBookingExaminedManageImpl;
import com.ystech.mem.service.OnlineBookingManageImpl;
import com.ystech.mem.service.OnlineBookingOldCarChanageManageImpl;
import com.ystech.mem.service.OnlineBookingSafetyMaintenanceManageImpl;
import com.ystech.weixin.core.util.WeixinCommon;
import com.ystech.weixin.core.util.WeixinUtil;
import com.ystech.weixin.model.WeixinAccesstoken;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.weixin.model.template.WeixinSendTemplateMessageUtil;
import com.ystech.weixin.service.WeixinAccesstokenManageImpl;
import com.ystech.weixin.service.WeixinAccountManageImpl;
import com.ystech.weixin.service.WeixinGzuserinfoManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-3-14
 */
@Component("onlineBookingWechatAction")
@Scope("prototype")
public class OnlineBookingWechatAction extends BaseController{
	private OnlineBooking onlineBooking;
	private OnlineBookingExamined onlineBookingExamined;
	private OnlineBookingSafetyMaintenance onlineBookingSafetyMaintenance;
	private OnlineBookingOldCarChanage onlineBookingOldCarChanage;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private OnlineBookingManageImpl onlineBookingManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private OnlineBookingExaminedManageImpl onlineBookingExaminedManageImpl;
	private OnlineBookingSafetyMaintenanceManageImpl onlineBookingSafetyMaintenanceManageImpl;
	private OnlineBookingOldCarChanageManageImpl onlineBookingOldCarChanageManageImpl;
	private MemberManageImpl memberManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private MemberCarInfoManageImpl memberCarInfoManageImpl;
	private WeixinAccesstokenManageImpl weixinAccesstokenManageImpl;
	private WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl;
	private String url;
	public OnlineBooking getOnlineBooking() {
		return onlineBooking;
	}
	public void setOnlineBooking(OnlineBooking onlineBooking) {
		this.onlineBooking = onlineBooking;
	}

	public OnlineBookingManageImpl getOnlineBookingManageImpl() {
		return onlineBookingManageImpl;
	}
	@Resource
	public void setWeixinAccesstokenManageImpl(WeixinAccesstokenManageImpl weixinAccesstokenManageImpl) {
		this.weixinAccesstokenManageImpl = weixinAccesstokenManageImpl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public OnlineBookingExamined getOnlineBookingExamined() {
		return onlineBookingExamined;
	}
	public void setOnlineBookingExamined(OnlineBookingExamined onlineBookingExamined) {
		this.onlineBookingExamined = onlineBookingExamined;
	}
	public OnlineBookingSafetyMaintenance getOnlineBookingSafetyMaintenance() {
		return onlineBookingSafetyMaintenance;
	}
	public void setOnlineBookingSafetyMaintenance(
			OnlineBookingSafetyMaintenance onlineBookingSafetyMaintenance) {
		this.onlineBookingSafetyMaintenance = onlineBookingSafetyMaintenance;
	}
	public OnlineBookingOldCarChanage getOnlineBookingOldCarChanage() {
		return onlineBookingOldCarChanage;
	}
	public void setOnlineBookingOldCarChanage(
			OnlineBookingOldCarChanage onlineBookingOldCarChanage) {
		this.onlineBookingOldCarChanage = onlineBookingOldCarChanage;
	}
	@Resource
	public void setOnlineBookingManageImpl(
			OnlineBookingManageImpl onlineBookingManageImpl) {
		this.onlineBookingManageImpl = onlineBookingManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
	}
	@Resource
	public void setOnlineBookingExaminedManageImpl(
			OnlineBookingExaminedManageImpl onlineBookingExaminedManageImpl) {
		this.onlineBookingExaminedManageImpl = onlineBookingExaminedManageImpl;
	}
	@Resource
	public void setOnlineBookingSafetyMaintenanceManageImpl(
			OnlineBookingSafetyMaintenanceManageImpl onlineBookingSafetyMaintenanceManageImpl) {
		this.onlineBookingSafetyMaintenanceManageImpl = onlineBookingSafetyMaintenanceManageImpl;
	}
	@Resource
	public void setMemberCarInfoManageImpl(MemberCarInfoManageImpl memberCarInfoManageImpl) {
		this.memberCarInfoManageImpl = memberCarInfoManageImpl;
	}
	@Resource
	public void setOnlineBookingOldCarChanageManageImpl(
			OnlineBookingOldCarChanageManageImpl onlineBookingOldCarChanageManageImpl) {
		this.onlineBookingOldCarChanageManageImpl = onlineBookingOldCarChanageManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setWeixinAccountManageImpl(
			WeixinAccountManageImpl weixinAccountManageImpl) {
		this.weixinAccountManageImpl = weixinAccountManageImpl;
	}
	@Resource
	public void setWeixinGzuserinfoManageImpl(
			WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl) {
		this.weixinGzuserinfoManageImpl = weixinGzuserinfoManageImpl;
	}
	/**
	 * 功能描述：年审预约
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String onlineBookingEaxmined() throws Exception {
		HttpServletRequest request = getRequest();
		Integer memberCarInfoId = ParamUtil.getIntParam(request, "memberCarInfoId", -1);
		try{
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			Member member = getMember();
			request.setAttribute("member", member);
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/onlineBookingWechat/onlineBookingEaxmined");
				request.setAttribute("member", member);
				return "jionIn";
			}
			
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			
			if(memberCarInfoId>0){
				MemberCarInfo memberCarInfo = memberCarInfoManageImpl.get(memberCarInfoId);
				request.setAttribute("memberCarInfo", memberCarInfo);
			}else{
				List<MemberCarInfo> memberCarInfos = memberCarInfoManageImpl.findBy("member.dbid", member.getDbid());
				if(null!=memberCarInfos&&memberCarInfos.size()>1){
					request.setAttribute("memberCarInfos", memberCarInfos);
					request.setAttribute("type", 1);
					request.setAttribute("url", "/onlineBookingWechat/onlineBookingEaxmined");
					return "selectCarMaster";
				}
				if(null==memberCarInfos||memberCarInfos.size()<=0){
					MemberCarInfo memberCarInfo =new MemberCarInfo();
					memberCarInfo.setCar(member.getCar());
					memberCarInfo.setCarPlate(member.getCarNo());
					memberCarInfo.setName(member.getName());
					memberCarInfo.setMobilePhone(member.getMobilePhone());
					request.setAttribute("memberCarInfo", memberCarInfo);
				}
				if(memberCarInfos.size()==1){
					request.setAttribute("memberCarInfo", memberCarInfos.get(0));
				}
				
			}
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("status", CarSeriy.STATUSCOMM);
			request.setAttribute("carSeriys", carSeriys);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "onlineBookingExamined";
	}
	/**
	 * 功能描述： 微信端续保年审
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveOnlineBookingEaxmined() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Member member = getMember();
			if(null==member){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;
			}
			Enterprise enterprise = getEnterprise();
			if(null==enterprise){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;	
			}
			Integer carSeriy = ParamUtil.getIntParam(request, "carSeriy", -1);
			if(carSeriy>0){
				CarSeriy carSeriy2 = carSeriyManageImpl.get(carSeriy);
				onlineBookingExamined.setCarSeriy(carSeriy2.getName());
			}
			String carModel2 =request.getParameter("carModel");
			onlineBookingExamined.setCarModel(carModel2);
			onlineBookingExamined.setCreateTime(new Date());
			onlineBookingExamined.setStatus(OnlineBooking.NORMALL);
			onlineBookingExamined.setIsCustomer(false);
			onlineBookingExamined.setIsMember(false);
			onlineBookingExamined.setIsMessage(false);
			onlineBookingExamined.setServiceType(1);
			onlineBookingExamined.setEnterpriseId(enterprise.getDbid());
			WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
			if(weixinGzuserinfo!=null){
				onlineBookingExamined.setMicroId(weixinGzuserinfo.getNickname());
			}
			onlineBookingExamined.setMember(member);
			onlineBookingExaminedManageImpl.save(onlineBookingExamined);
			
			//更新会员预约次数
			updateMemberOnlineNum(member,onlineBookingExamined);
			//保存发送信息
			saveMessage(onlineBookingExamined,member);
			
			//发送微信通知
			List<WeixinAccount> weixinAccounts = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid());
			if(null!=weixinAccounts&&weixinAccounts.size()>0){
				WeixinAccount weixinAccount = weixinAccounts.get(0);
				WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
				WeixinSendTemplateMessageUtil.send_template_onlineBooking(accessToken, onlineBookingExamined, weixinGzuserinfo, enterprise);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(new Throwable("保存数据失败！"), "/onlineBookingWechat/error");
			return ;
		}
		renderMsg("/onlineBookingWechat/success", "您已预约成功！我们将尽快安排人员联系您！");
		return ;
	}
	
	
	/**
	* 功能描述：选择预约方式
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String selectSMMethold() throws Exception {
		HttpServletRequest request = getRequest();
		//根据微信ID获取会员信息，提供前台判断绑定会员资料
		Member member = getMember();
		request.setAttribute("member", member);
		if(null==member){
			return "weixinNullError";
		}
		if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
			setUrl("/onlineBookingWechat/selectSMMethold");
			request.setAttribute("member", member);
			return "jionIn";
		}
		return "selectSMMethold";
	}
	/**
	 * 功能描述：协议跳转
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String agreenment() throws Exception {
		HttpServletRequest request = getRequest();
		//根据微信ID获取会员信息，提供前台判断绑定会员资料
		Member member = getMember();
		request.setAttribute("member", member);
		if(null==member){
			return "weixinNullError";
		}
		if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
			setUrl("/onlineBookingWechat/selectSMMethold");
			request.setAttribute("member", member);
			return "jionIn";
		}
		return "agreenment";
	}
	/**
	 * 功能描述：选择取车地址
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String selectAddress() throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Member member = getMember();
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/onlineBookingWechat/selectSMMethold");
				request.setAttribute("member", member);
				return "jionIn";
			}
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			request.setAttribute("member", member);
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			WeixinAccount weixinAccount = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid()).get(0);
			WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
			WeixinCommon weixinCommon = getWeixinCommon("/onlineBookingWechat/selectAddress",accessToken,weixinAccount);
			request.setAttribute("weixinCommon", weixinCommon);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "selectAddress";
	}
	/**
	 * 功能描述：保险维修
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String onlineBookingSM() throws Exception {
		HttpServletRequest request = getRequest();
		Integer memberCarInfoId = ParamUtil.getIntParam(request, "memberCarInfoId", -1);
		Integer serviceType = ParamUtil.getIntParam(request, "serviceType", 1);
		try{
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			Member member = getMember();
			request.setAttribute("member", member);
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/onlineBookingWechat/onlineBookingSM");
				request.setAttribute("member", member);
				return "jionIn";
			}
			if(memberCarInfoId>0){
				MemberCarInfo memberCarInfo = memberCarInfoManageImpl.get(memberCarInfoId);
				request.setAttribute("memberCarInfo", memberCarInfo);
			}else{
				List<MemberCarInfo> memberCarInfos = memberCarInfoManageImpl.findBy("member.dbid", member.getDbid());
				if(null!=memberCarInfos&&memberCarInfos.size()>1){
					request.setAttribute("memberCarInfos", memberCarInfos);
					request.setAttribute("type", 2);
					request.setAttribute("url", "/onlineBookingWechat/onlineBookingSM");
					return "selectCarMaster";
				}
				if(null==memberCarInfos||memberCarInfos.size()<=0){
					MemberCarInfo memberCarInfo =new MemberCarInfo();
					memberCarInfo.setCar(member.getCar());
					memberCarInfo.setCarPlate(member.getCarNo());
					memberCarInfo.setName(member.getName());
					memberCarInfo.setMobilePhone(member.getMobilePhone());
					request.setAttribute("memberCarInfo", memberCarInfo);
				}
				if(memberCarInfos.size()==1){
					request.setAttribute("memberCarInfo", memberCarInfos.get(0));
				}
				
			}
			
			if (serviceType==2) {
				String address = request.getParameter("address");
				String title = request.getParameter("title");
				if(null!=address){
					String decode = URLDecoder.decode(address, "UTF-8");
					request.setAttribute("address", decode);
				}
				if(null!=title){
					String decode = URLDecoder.decode(title, "UTF-8");
					request.setAttribute("title", decode);
				}
			}
			
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.getAll();
			request.setAttribute("carSeriys", carSeriys);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "onlineBookingSafetyMaintenance";
	}
	/**
	 * 功能描述： 微信端续保养维修
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveOnlineBookingSM() throws Exception {
		HttpServletRequest request = getRequest();
		Integer serviceType = ParamUtil.getIntParam(request, "serviceType", -1);
		try{
			Member member = getMember();
			if(null==member){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;
			}
			Enterprise enterprise = getEnterprise();
			if(null==enterprise){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;	
			}
			Integer carSeriy = ParamUtil.getIntParam(request, "carSeriy", -1);
			if(carSeriy>0){
				CarSeriy carSeriy2 = carSeriyManageImpl.get(carSeriy);
				onlineBookingSafetyMaintenance.setCarSeriy(carSeriy2.getName());
			}
			String carModel2 =request.getParameter("carModel");
			onlineBookingSafetyMaintenance.setCarModel(carModel2);
			onlineBookingSafetyMaintenance.setCreateTime(new Date());
			onlineBookingSafetyMaintenance.setStatus(OnlineBooking.NORMALL);
			onlineBookingSafetyMaintenance.setIsCustomer(false);
			onlineBookingSafetyMaintenance.setIsMember(false);
			onlineBookingSafetyMaintenance.setIsMessage(false);
			onlineBookingSafetyMaintenance.setEnterpriseId(enterprise.getDbid());
			onlineBookingSafetyMaintenance.setMember(member);
			if(serviceType==2){
				String address = request.getParameter("address");
				onlineBookingSafetyMaintenance.setAddress(address);
				String title = request.getParameter("title");
				onlineBookingSafetyMaintenance.setAddressTitle(title);
				String point = request.getParameter("point");
				onlineBookingSafetyMaintenance.setPoint(point);
				String startDate = request.getParameter("startDate");
				onlineBookingSafetyMaintenance.setStartTime(startDate);
				String endDate = request.getParameter("endDate");
				onlineBookingSafetyMaintenance.setEndTime(endDate);
			}
			onlineBookingSafetyMaintenance.setServiceType(serviceType);
			WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
			if(weixinGzuserinfo!=null){
				onlineBookingSafetyMaintenance.setMicroId(weixinGzuserinfo.getNickname());
			}
			onlineBookingSafetyMaintenanceManageImpl.save(onlineBookingSafetyMaintenance);
			
			updateMemberOnlineNum(member,onlineBookingSafetyMaintenance);
			//保存发送信息
			saveMessage(onlineBookingSafetyMaintenance,member);
			
			//发送微信通知
			List<WeixinAccount> weixinAccounts = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid());
			if(null!=weixinAccounts&&weixinAccounts.size()>0){
				WeixinAccount weixinAccount = weixinAccounts.get(0);
				WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
				WeixinSendTemplateMessageUtil.send_template_onlineBooking(accessToken, onlineBookingSafetyMaintenance, weixinGzuserinfo, enterprise);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(new Throwable("保存数据失败！"), "/onlineBookingWechat/error");
			return ;
		}
		renderMsg("/onlineBookingWechat/success", "您已预约成功！我们将尽快安排人员联系您！");
		return ;
	}
	/**
	 * 功能描述：旧车置换
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String onlineBookingOCC() throws Exception {
		HttpServletRequest request = getRequest();
		Integer memberCarInfoId = ParamUtil.getIntParam(request, "memberCarInfoId", -1);
		try{
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			Member member = getMember();
			request.setAttribute("member", member);
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/onlineBookingWechat/onlineBookingOCC");
				request.setAttribute("member", member);
				return "jionIn";
			}
			
			if(memberCarInfoId>0){
				MemberCarInfo memberCarInfo = memberCarInfoManageImpl.get(memberCarInfoId);
				request.setAttribute("memberCarInfo", memberCarInfo);
			}else{
				List<MemberCarInfo> memberCarInfos = memberCarInfoManageImpl.findBy("member.dbid", member.getDbid());
				if(null!=memberCarInfos&&memberCarInfos.size()>1){
					request.setAttribute("memberCarInfos", memberCarInfos);
					request.setAttribute("type", 3);
					request.setAttribute("url", "/onlineBookingWechat/onlineBookingOCC");
					return "selectCarMaster";
				}
				if(null==memberCarInfos||memberCarInfos.size()<=0){
					MemberCarInfo memberCarInfo =new MemberCarInfo();
					memberCarInfo.setCar(member.getCar());
					memberCarInfo.setCarPlate(member.getCarNo());
					memberCarInfo.setName(member.getName());
					memberCarInfo.setMobilePhone(member.getMobilePhone());
					request.setAttribute("memberCarInfo", memberCarInfo);
				}
				if(memberCarInfos.size()==1){
					request.setAttribute("memberCarInfo", memberCarInfos.get(0));
				}
				
			}
			List<CarSeriy> carSeriys = carSeriyManageImpl.getAll();
			request.setAttribute("carSeriys", carSeriys);
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "onlineBookingOldCarChanage";
	}
	
	/**
	 * 功能描述： 微信端续保养维修
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveOnlineBookingOCC() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Member member = getMember();
			if(null==member){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;
			}
			Enterprise enterprise = getEnterprise();
			if(null==enterprise){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;	
			}
			Integer carSeriy = ParamUtil.getIntParam(request, "carSeriy", -1);
			if(carSeriy>0){
				CarSeriy carSeriy2 = carSeriyManageImpl.get(carSeriy);
				onlineBookingOldCarChanage.setCarSeriy(carSeriy2.getName());
			}
			String carModel2 =request.getParameter("carModel");
			onlineBookingOldCarChanage.setCarModel(carModel2);
			onlineBookingOldCarChanage.setCreateTime(new Date());
			onlineBookingOldCarChanage.setStatus(OnlineBooking.NORMALL);
			onlineBookingOldCarChanage.setIsCustomer(false);
			onlineBookingOldCarChanage.setIsMember(false);
			onlineBookingOldCarChanage.setIsMessage(false);
			onlineBookingOldCarChanage.setServiceType(1);
			onlineBookingOldCarChanage.setEnterpriseId(enterprise.getDbid());
			onlineBookingOldCarChanage.setMember(member);
			WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
			if(weixinGzuserinfo!=null){
				onlineBookingOldCarChanage.setMicroId(weixinGzuserinfo.getNickname());
			}
			onlineBookingOldCarChanageManageImpl.save(onlineBookingOldCarChanage);
			
			updateMemberOnlineNum(member,onlineBookingOldCarChanage);
			//保存发送信息
			saveMessage(onlineBookingOldCarChanage,member);
			
			//发送微信通知
			List<WeixinAccount> weixinAccounts = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid());
			if(null!=weixinAccounts&&weixinAccounts.size()>0){
				WeixinAccount weixinAccount = weixinAccounts.get(0);
				WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
				WeixinSendTemplateMessageUtil.send_template_onlineBooking(accessToken, onlineBookingOldCarChanage, weixinGzuserinfo, enterprise);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(new Throwable("保存数据失败！"), "/onlineBookingWechat/error");
			return ;
		}
		renderMsg("/onlineBookingWechat/success", "您已预约成功！我们将尽快安排人员联系您！");
		return ;
	}
	/**
	 * 功能描述：试乘试驾
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String onlineBooking() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			Member member = getMember();
			request.setAttribute("member", member);
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/onlineBookingWechat/onlineBooking");
				request.setAttribute("member", member);
				return "jionIn";
			}
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=? order by orderNum",new Object[]{5,CarSeriy.STATUSCOMM});
			request.setAttribute("carSeriys", carSeriys);
			
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "onlineBooking";
	}
	/**
	 * 功能描述： 微信端在线提交预约
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveOnlineBooking() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Member member = getMember();
			if(null==member){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;
			}
			Enterprise enterprise = getEnterprise();
			if(null==enterprise){
				renderErrorMsg(new Throwable("预约失败，请退出当前页面重新进入"), "");
				return ;	
			}
			Integer carSeriy = ParamUtil.getIntParam(request, "carSeriy", -1);
			Integer carModel = ParamUtil.getIntParam(request, "carModel", -1);
			if(carSeriy>0){
				CarSeriy carSeriy2 = carSeriyManageImpl.get(carSeriy);
				onlineBooking.setCarSeriy(carSeriy2.getName());
			}
			if(carModel>0){
				CarModel carModel2 = carModelManageImpl.get(carModel);
				onlineBooking.setCarModel(carModel2.getName());
			}
			onlineBooking.setCreateTime(new Date());
			onlineBooking.setStatus(OnlineBooking.NORMALL);
			onlineBooking.setIsCustomer(false);
			onlineBooking.setIsMember(false);
			onlineBooking.setIsMessage(false);
			onlineBooking.setServiceType(1);
			onlineBooking.setEnterpriseId(enterprise.getDbid());
			onlineBooking.setMember(member);
			WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
			if(weixinGzuserinfo!=null){
				onlineBooking.setMicroId(weixinGzuserinfo.getNickname());
			}
			onlineBookingManageImpl.save(onlineBooking);
			updateMemberOnlineNum(member,onlineBooking);
			//保存发送信息
			saveMessage(onlineBooking,member);
			
			//发送微信通知
			List<WeixinAccount> weixinAccounts = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid());
			if(null!=weixinAccounts&&weixinAccounts.size()>0){
				WeixinAccount weixinAccount = weixinAccounts.get(0);
				WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
				WeixinSendTemplateMessageUtil.send_template_onlineBooking(accessToken, onlineBooking, weixinGzuserinfo, enterprise);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(new Throwable("保存数据失败！"), "/onlineBookingWechat/error");
			return ;
		}
		renderMsg("/onlineBookingWechat/success", "您已预约成功！我们将尽快安排人员联系您！");
		return ;
	}
	/**
	* 功能描述：
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String success() throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
		} catch (Exception e) {
		}
		return "success";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String error() throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
		} catch (Exception e) {
		}
		return "error";
	}
	/**
	 * 保存通知信息
	 * @param booking
	 */
	private void saveMessage(OnlineBooking booking,Member member){
		MessageUtile messageUtile=new MessageUtile();
		
		String type="";
		if(booking.getBookingType().equals("1")){
			type="试乘试驾";
		}
		if(booking.getBookingType().equals("2")){
			type="保养维修";
		}
		if(booking.getBookingType().equals("3")){
			type="续保年审";
		}
		if(booking.getBookingType().equals("4")){
			type="旧车置换";
		}
		String title=booking.getName()+type;
		String url="/onlineBooking/dealWithOnlineBooking?dbid="+booking.getDbid();
		String content="";
		content=booking.getName()+"预约"+DateUtil.format(booking.getBookingDate())+"["+type+"]，预约车型";
		
		if(null!=booking.getCarSeriy()&&booking.getCarSeriy().trim().length()>0){
			content=content+booking.getCarSeriy();
		}
		if(null!=booking.getCarModel()&&booking.getCarModel().trim().length()>0){
			content=content+booking.getCarModel();
		}
		if(null!=member){
			Integer onlineBookingNum = member.getOnlineBookingNum();
			if(onlineBookingNum>1){
				content=content+",已预约【"+onlineBookingNum+"】次,";
			}
		}
		messageUtile.sendMessage(title, content, url);
	}
	
	
	/**
	 * @param request
	 */
	private Member getMember() {
		String wechatId = getWechatId();
		if(null!=wechatId){
			List<Member> members = memberManageImpl.findBy("microId", wechatId);
			if(null!=members&&members.size()>0){
				return members.get(0);
			}
		}
		return null;
	}
	/**
	 * 获取关注用户当前公司信息
	 * @param request
	 */
	private Enterprise  getEnterprise() {
		String wechatId = getWechatId();
		List<WeixinGzuserinfo> weixinGzuserinfos = weixinGzuserinfoManageImpl.findBy("openid", wechatId);
		if(null!=weixinGzuserinfos&&weixinGzuserinfos.size()>0){
			WeixinGzuserinfo weixinGzuserinfo = weixinGzuserinfos.get(0);
			if(null!=weixinGzuserinfo&&null!=weixinGzuserinfo.getEnterpriseId()){
				Enterprise enterprise = enterpriseManageImpl.get(weixinGzuserinfo.getEnterpriseId());
				return enterprise;
			}
		}
		return null;
	}
	/**
	 * 功能描述：更新会员预约次数
	 * @param microId
	 */
	private void updateMemberOnlineNum(Member member1,OnlineBooking onlineBooking) {
			Member member = memberManageImpl.get(member1.getDbid());
			Integer onlineBookingNum = member.getOnlineBookingNum();
			if(null!=onlineBookingNum&&onlineBookingNum>=0){
				onlineBookingNum=onlineBookingNum+1;
			}else{
				onlineBookingNum=new Integer(1);
			}
			member.setOnlineBookingNum(onlineBookingNum);
			String car = member.getCar();
			if(null==car||car.trim().length()<=0){
				String carModel = onlineBooking.getCarModel();
				if(null!=carModel){
					member.setCar(carModel);
				}
			}
			String carNo = member.getCarNo();
			if(null==carNo||carNo.trim().length()<=0){
				String carplate = onlineBooking.getCarPlate();
				if(null!=carplate){
					member.setCarNo(carplate);
				}
			}
			memberManageImpl.save(member);
	}
}
