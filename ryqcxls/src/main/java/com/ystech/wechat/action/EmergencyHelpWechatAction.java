/**
 * 
 */
package com.ystech.wechat.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.EmergencyHelp;
import com.ystech.mem.model.Member;
import com.ystech.mem.service.EmergencyHelpManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.weixin.core.util.Configure;
import com.ystech.weixin.core.util.WeixinCommon;
import com.ystech.weixin.core.util.WeixinUtil;
import com.ystech.weixin.model.WeixinAccesstoken;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.weixin.service.WeixinAccesstokenManageImpl;
import com.ystech.weixin.service.WeixinAccountManageImpl;
import com.ystech.weixin.service.WeixinGzuserinfoManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.MessageManageImpl;

/**
 * @author shusanzhan
 * @date 2014-3-18
 */
@Component("emergencyHelpWechatAction")
@Scope("prototype")
public class EmergencyHelpWechatAction extends BaseController{
	private EmergencyHelp emergencyHelp;
	private EmergencyHelpManageImpl emergencyHelpManageImpl;
	private MessageManageImpl messageManageImpl;
	private MemberManageImpl memberManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private WeixinAccesstokenManageImpl weixinAccesstokenManageImpl;
	private WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl;
	private String url;
	public EmergencyHelp getEmergencyHelp() {
		return emergencyHelp;
	}
	public void setEmergencyHelp(EmergencyHelp emergencyHelp) {
		this.emergencyHelp = emergencyHelp;
	}
	@Resource
	public void setEmergencyHelpManageImpl(
			EmergencyHelpManageImpl emergencyHelpManageImpl) {
		this.emergencyHelpManageImpl = emergencyHelpManageImpl;
	}
	@Resource
	public void setMessageManageImpl(MessageManageImpl messageManageImpl) {
		this.messageManageImpl = messageManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setWeixinAccesstokenManageImpl(WeixinAccesstokenManageImpl weixinAccesstokenManageImpl) {
		this.weixinAccesstokenManageImpl = weixinAccesstokenManageImpl;
	}
	@Resource
	public void setWeixinAccountManageImpl(
			WeixinAccountManageImpl weixinAccountManageImpl) {
		this.weixinAccountManageImpl = weixinAccountManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setWeixinGzuserinfoManageImpl(
			WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl) {
		this.weixinGzuserinfoManageImpl = weixinGzuserinfoManageImpl;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String emergencyHelp() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Member member = getMember();
			if(null==member){
				return "weixinNullError";
			}
			if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
				setUrl("/emergencyHelpWechat/emergencyHelp");
				request.setAttribute("member", member);
				return "jionIn";
			}
			//根据微信ID获取会员信息，提供前台判断绑定会员资料
			request.setAttribute("member", member);
			Enterprise enterprise = getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			WeixinAccount weixinAccount = weixinAccountManageImpl.findBy("enterpriseId", enterprise.getDbid()).get(0);
			if(Configure.prostatus==2){
				WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
				WeixinCommon weixinCommon = getWeixinCommon("/emergencyHelpWechat/emergencyHelp",accessToken,weixinAccount);
				request.setAttribute("weixinCommon", weixinCommon);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "emergencyHelp";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
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
			String coordinates = request.getParameter("coordinates");
			String address = request.getParameter("address1");
			String title = request.getParameter("title");
			EmergencyHelp emergencyHelp=new EmergencyHelp();
			emergencyHelp.setCoordinates(coordinates);
			emergencyHelp.setAddress(address);
			emergencyHelp.setTitle(title);
			emergencyHelp.setMember(member);
			emergencyHelp.setPhone(member.getMobilePhone());
			emergencyHelp.setStatus(false);
			emergencyHelp.setCreateTime(new Date());
			emergencyHelp.setMember(member);
			emergencyHelp.setEnterpriseId(enterprise.getDbid());
			emergencyHelpManageImpl.save(emergencyHelp);
			
			//保存提示信息
			saveMessage(emergencyHelp);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/emergencyHelpWechat/success", "您已预约成功！我们将尽快安排人员联系您！");
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
	 * 保存通知信息
	 * @param booking
	 */
	private void saveMessage(EmergencyHelp emergencyHelp){
		String title=emergencyHelp.getAddress();
		String url="/emergencyHelp/edit?dbid="+emergencyHelp.getDbid();
		String content="";
		content=emergencyHelp.getAddress()+""+DateUtil.format(emergencyHelp.getCreateTime())+"发起了紧急救援，请相关负责人情况联系！";
		MessageUtile messageUtile=new MessageUtile();
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
}
