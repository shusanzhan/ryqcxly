package com.ystech.qywx.service;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.qywx.core.ErrorMessage;
import com.ystech.qywx.core.ErrorMessageUtil;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("appMenuUtil")
public class AppMenuUtil {
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AppMenuManageImpl appMenuManageImpl;
	private AppManageImpl appManageImpl;
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setAppMenuManageImpl(AppMenuManageImpl appMenuManageImpl) {
		this.appMenuManageImpl = appMenuManageImpl;
	}
	/**
	 * 功能描述：创建应用菜单
	 * @param app
	 * @param menus
	 * @return
	 */
	public boolean createAppMenu(App app,String menus){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), app.getSecurity(),app.getAppId());
			String url = QywxUtil.menu_create_url.replace("ACCESS_TOKEN",accessToken.getAccessToken()).replace("AGENTID", app.getAppId()+"");
			JSONObject jsonObject =QywxUtil.httpRequest(url, "POST", menus);
			if(null!=jsonObject){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(jsonObject);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	/**
	 * 功能描述：删除应用程序的菜单
	 * @param app
	 * @return
	 */
	public boolean deleteAppMenu(App app){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), app.getSecurity(),app.getAppId());
			String url = QywxUtil.menu_delete_url.replace("ACCESS_TOKEN",accessToken.getAccessToken()).replace("AGENTID", app.getAppId()+"");
			JSONObject jsonObject = QywxUtil.httpRequest(url, "GET", null);
			if(null!=jsonObject){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(jsonObject);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return false;
	}
}
