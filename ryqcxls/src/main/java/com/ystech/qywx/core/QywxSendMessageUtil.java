package com.ystech.qywx.core;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.LogUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppDepartment;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.MessageTemplate;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.AppDepartmentManageImpl;
import com.ystech.qywx.service.AppUserManageImpl;
import com.ystech.qywx.service.MessageTemplateManageImpl;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("qywxSendMessageUtil")
public class QywxSendMessageUtil {
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private MessageTemplateManageImpl messageTemplateManageImpl;
	private AppDepartmentManageImpl appDepartmentManageImpl;
	private UserManageImpl userManageImpl;
	private AppUserManageImpl appUserManageImpl;
	@Resource
	public void setAppDepartmentManageImpl(
			AppDepartmentManageImpl appDepartmentManageImpl) {
		this.appDepartmentManageImpl = appDepartmentManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setMessageTemplateManageImpl(
			MessageTemplateManageImpl messageTemplateManageImpl) {
		this.messageTemplateManageImpl = messageTemplateManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	/**
	 * 功能描述：发送微信通知信息
	 * @param message
	 * @param accessTokenManageImpl
	 * @param appid
	 * @param appsecret
	 */
	 public  void sendMessge(String message,App app){
		 try {
			 QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			 AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), app.getSecurity(),app.getAppId());
	    	if(null!=accessToken){
	    		String sendurl=QywxUtil.SNED_URL.replace("ACESSTOKEN", accessToken.getAccessToken());
	    		JSONObject httpRequest2 = QywxUtil.httpRequest(sendurl, "POST", message);
	    		System.out.println(httpRequest2.toString());
	    	}else{
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		}
	 }
	/**
	 * 功能描述：发送微信通知信息(发送个单个人）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void sendMessageSingle(String toUserParam,String url,String dis,String type,HttpServletRequest request) throws Exception {
		try {
			//信息接受人员
			//信息接受人员
			List<MessageTemplate> messageTemplates =messageTemplateManageImpl.executeSql("select * from qywx_MessageTemplate mt,qywx_MessageTemplateType mtt where mt.MessageTemplateTypeId=mtt.dbid and mtt.name=?",new Object[]{type});
			if(null!=messageTemplates&&messageTemplates.size()>0){
				MessageTemplate messageTemplate = messageTemplates.get(0);
				String message = getMessage(toUserParam,null,url, dis, messageTemplate,request);
				LogUtil.error(message);
				sendMessge(message,messageTemplate.getApp());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	/**
	 * 功能描述：发送微信通知信息(发送到多人或组织）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void sendMessagePart(String url,String dis,String type,HttpServletRequest request) throws Exception {
		try {
			//信息接受人员
			List<MessageTemplate> messageTemplates =messageTemplateManageImpl.executeSql("select * from qywx_MessageTemplate mt,qywx_MessageTemplateType mtt where mt.MessageTemplateTypeId=mtt.dbid and mtt.name=?",new Object[]{type});
			if(null!=messageTemplates&&messageTemplates.size()>0){
				MessageTemplate messageTemplate = messageTemplates.get(0);
				String party = getParty(messageTemplate);
				String user = getUser(messageTemplate);
				String message = getMessage(user,party,url, dis,messageTemplate,request);
				sendMessge(message,messageTemplate.getApp());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	/**
	 * 
	 * @param toUserParam:信息接受人员
	 * @param url：通知点击连接
	 * @param dis：通知信息描述
	 * @param type：信息模板
	 * @return
	 */
	private String getMessage(String touser,String toparty,String url,String dis,MessageTemplate messageTemplate,HttpServletRequest request){
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
		String message="{" +
    			"   \"touser\": \""+touser+"\","+
    			"   \"toparty\":\""+toparty+"\"," +
    			"   \"totag\": \" \"," +
    			"   \"msgtype\": \"news\"," +
    			"   \"agentid\": \""+messageTemplate.getApp().getAppId()+"\"," +
    			"   \"news\": {"+
    			"       \"articles\":["+
    			"            {"+
    			"                \"title\": \""+messageTemplate.getMessageTemplateType().getName()+"\","+
    			"                \"description\": \""+dis+"\"," +
    			"                \"url\": \""+basePath+url+"\","+
    			"                \"picurl\": \""+basePath+messageTemplate.getPicurl()+"\""+
    			"            }"+    
    			"        ]"+
    			"    }" +
    			"   \"safe\":\"0\"}";
		return message;
	}
	/**
	 * 功能描述：获取接受信息方数据（部门数据）
	 * @param type
	 * @return
	 */
	private String getParty(MessageTemplate messageTemplate){
		String buff=new String();
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null==enterprise){
				return "";
			}
			if(null==messageTemplate){
				return "";
			}
			App app = messageTemplate.getApp();
			//获取配置应用列表
			List<AppDepartment> appDepartments = appDepartmentManageImpl.find("from AppDepartment where app.dbid=? and enterprise.dbid=? ", new Object[]{app.getDbid(),enterprise.getDbid()});
			if(null!=appDepartments){
				for (AppDepartment appDepartment : appDepartments) {
					Department department = appDepartment.getDepartment();
					if(null!=department){
						buff=buff+department+"|";
					}
				}
			}
			if(buff.length()>0){
				buff=buff.substring(0, buff.length()-1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return buff;
	}
	/**
	 * 功能描述：获取配置应用人员权限列表
	 * @param type
	 * @return
	 */
	private String getUser(MessageTemplate messageTemplate){
		String buff=new String();
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null==enterprise){
				return "";
			}
			//信息接受人员
			if(null==messageTemplate){
				return "";
			}
			App app = messageTemplate.getApp();
			//获取配置人员权限列表
			List<AppUser> appusers = appUserManageImpl.find("from AppUser where app.dbid=? and enterprise.dbid=? ", new Object[]{app.getDbid(),enterprise.getDbid()});
			if(null!=appusers){
				for (AppUser appUser : appusers) {
					User user = appUser.getUser();
					if(null!=user){
						buff=buff+appUser.getUser().getUserId()+"|";
					}
				}
			}
			if(buff.length()>0){
				buff=buff.substring(0, buff.length()-1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return buff;
	}
}
