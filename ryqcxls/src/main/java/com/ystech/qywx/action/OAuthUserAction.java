package com.ystech.qywx.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;
import com.ystech.xwqr.service.sys.UserManageImpl;
@Component("oAuthUserAction")
@Scope("prototype")
public class OAuthUserAction extends BaseController{
	private UserManageImpl userManageImpl;
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void oauthUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String code = request.getParameter("code");
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	
}
