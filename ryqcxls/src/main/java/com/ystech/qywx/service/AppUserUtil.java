package com.ystech.qywx.service;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;

import com.ystech.qywx.core.ErrorMessage;
import com.ystech.qywx.core.ErrorMessageUtil;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.QywxAccount;

@Component("appUserUtil")
public class AppUserUtil {
	private AppUserManageImpl appUserManageImpl;
	private AppManageImpl appManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	/**
	 * 
	 * @param appUser
	 * @param app
	 * @return
	 */
	public AppUser convert_to_openid(AppUser appUser,App app){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String agent_list_url = QywxUtil.convert_to_openid.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String json="{\"userid\": \"R"+appUser.getUser().getUserId()+"\",\"agentid\":"+app.getAppId()+"}";
			JSONObject httpRequest = QywxUtil.httpRequest(agent_list_url, "POST", json);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					String openId = httpRequest.getString("openid");
					appUser.setOpenId(openId);
					String appid = httpRequest.getString("appid");
					appUser.setRedBagAppId(appid);
					appUser.setStatus(AppUser.STATUSSYN);
				}else{
					appUser.setStatus(AppUser.STATUSCOMM);
				}
			}else{
				appUser.setStatus(AppUser.STATUSCOMM);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		appUserManageImpl.save(appUser);
		return appUser;
	}
}
