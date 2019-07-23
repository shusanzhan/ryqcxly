package com.ystech.qywx.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.service.AppManageImpl;
import com.ystech.qywx.service.AppUserManageImpl;
import com.ystech.qywx.service.AppUserUtil;

@Component("appUserAction")
@Scope("prototype")
public class AppUserAction extends BaseController{
	private AppManageImpl appManageImpl;
	private AppUserManageImpl appUserManageImpl;
	private AppUserUtil appUserUtil;
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	@Resource
	public void setAppUserUtil(AppUserUtil appUserUtil) {
		this.appUserUtil = appUserUtil;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer appId = ParamUtil.getIntParam(request, "dbid", -1);
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			App app = appManageImpl.get(appId);
			request.setAttribute("app", app);
			String sql="select * from qywx_appUser where appId="+appId;
			Page<AppUser> page = appUserManageImpl.pagedQuerySql(pageNo, pageSize, AppUser.class, sql,null);
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：生成OPENId
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOpenId() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer appId = ParamUtil.getIntParam(request, "appId", -1);
		Integer appUserId = ParamUtil.getIntParam(request, "appUserId", -1);
		try {
			AppUser appUser = appUserManageImpl.get(appUserId);
			App app = appManageImpl.get(appId);
			appUser  = appUserUtil.convert_to_openid(appUser, app);
			if(appUser.getStatus()==(int)AppUser.STATUSCOMM){
				renderErrorMsg(new Throwable("转换openId失败"), "");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/appUser/list?dbid="+appId, "转换openId 成功！");
		return;
	}
	/**
	 * 功能描述：批量生产OpenId
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void bachOpenId() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer appId = ParamUtil.getIntParam(request, "appId", -1);
		try{
			App app = appManageImpl.get(appId);
			String sql="select * from qywx_appUser where appId="+appId+" and status="+AppUser.STATUSCOMM;
			List<AppUser> appUsers = appUserManageImpl.executeSql(sql, null);
			for (AppUser appUser2 : appUsers) {
				appUserUtil.convert_to_openid(appUser2, app);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/appUser/list?dbid="+appId, "转换openId 成功！");
		return;
	}
}
