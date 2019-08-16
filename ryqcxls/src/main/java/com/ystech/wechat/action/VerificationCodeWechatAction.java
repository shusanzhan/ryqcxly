package com.ystech.wechat.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ucpaas.restDemo.SendMessage;
import com.ystech.agent.model.VerificationCode;
import com.ystech.agent.service.VerificationCodeManageImpl;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Member;
import com.ystech.mem.service.MemberManageImpl;

@Component("verificationCodeWechatAction")
@Scope("prototype")
public class VerificationCodeWechatAction extends BaseController{
	private VerificationCodeManageImpl verificationCodeManageImpl;
	private MemberManageImpl memberManageImpl;
	@Resource
	public void setVerificationCodeManageImpl(
			VerificationCodeManageImpl verificationCodeManageImpl) {
		this.verificationCodeManageImpl = verificationCodeManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}

	/**
	 * 想待验证手机发送验证码信息
	 */
	public void sendMobileMessage(){
		HttpServletRequest request = this.getRequest();
		String mobile = request.getParameter("mobile");
		try {
			Member member = getMemberBy();
			if(null==member){
				renderErrorMsg(new Exception("无关注会员信息，请退出后在进入"), "");
				return ;
			}
			boolean status = memberManageImpl.validateMobilePhone(mobile,member.getDbid());
			if (status) {
				renderText("2");//已经注册，请直接登录！
				return ;
			}
			if(null!=mobile&&mobile.trim().length()>0){
				String ranNumber = getRanNumber();
				//发送手机短信
				SendMessage.sendSM(mobile, ranNumber);
				//存入数据库
				VerificationCode verificationCode=new VerificationCode();
				verificationCode.setMobile(mobile);
				verificationCode.setVerificationCode(ranNumber);
				verificationCode.setCreateTime(new Date());
				verificationCodeManageImpl.save(verificationCode);
			}else{
				renderErrorMsg(new Exception("未绑定电话号码"), "");
				return ;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			renderErrorMsg(new Exception("未绑定电话号码"), "");
			return ;
		}
		renderMsg("", "");
		return ;
	}
	/**
	 * 功能描述：生成验证码
	 * @return
	 */
	public static String getRanNumber() {
		double number=Math.random(); 
		number = Math.ceil(number*10000); 
		String str = String.valueOf((int)number); 
		while(str.length()<4){ 
			str = "0"+str; 
		} 
		return str; 
	}
	/**
	 * @param request
	 */
	private Member getMemberBy() {
		String wechatId = getWechatId();
		if(null!=wechatId){
			List<Member> members = memberManageImpl.findBy("microId", wechatId);
			if(null!=members&&members.size()>0){
				return members.get(0);
			}
		}
		return null;
	}
}
