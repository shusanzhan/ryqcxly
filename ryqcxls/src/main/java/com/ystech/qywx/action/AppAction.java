package com.ystech.qywx.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppMenu;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.AppManageImpl;
import com.ystech.qywx.service.AppMenuManageImpl;
import com.ystech.qywx.service.AppUtil;
import com.ystech.qywx.service.QywxAccountManageImpl;

@Component("appAction")
@Scope("prototype")
public class AppAction extends BaseController{
	private App app;
	private AppManageImpl appManageImpl;
	private AppMenu appMenu;
	private AppMenuManageImpl appMenuManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AppUtil appUtil;
	public AppMenu getAppMenu() {
		return appMenu;
	}
	public void setAppMenu(AppMenu appMenu) {
		this.appMenu = appMenu;
	}
	@Resource
	public void setAppMenuManageImpl(AppMenuManageImpl appMenuManageImpl) {
		this.appMenuManageImpl = appMenuManageImpl;
	}
	public App getApp() {
		return app;
	}
	public void setApp(App app) {
		this.app = app;
	}
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAppUtil(AppUtil appUtil) {
		this.appUtil = appUtil;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String username = request.getParameter("title");
		try{
			 Page<App> page= appManageImpl.pagedQuerySql(pageNo, pageSize, App.class, "select * from qywx_app", new Object[]{});
			 request.setAttribute("page", page);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "list";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "edit";
	}
	/**
	 * 功能描述：同步远程应用
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synApp() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			boolean status = appUtil.updateApp();
			if(status==false){
				renderErrorMsg(new Throwable("同步应用失败，请确认"),"");
				return ;
			}
			if(status==true){
				renderMsg("/app/queryList", "同步应用成功");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderErrorMsg(new Throwable("同步应用失败，请确认"),"");
		return;
	}
	/**
	 * 功能描述：同步远程用户数据
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			boolean status = appUtil.createOrUpdateUser();
			if(status==false){
				renderErrorMsg(new Throwable("同步应用用户失败，请确认"),"");
				return ;
			}
			if(status==true){
				renderMsg("/app/queryList", "同步应用用户成功");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderErrorMsg(new Throwable("同步应用用户失败，请确认"),"");
		return;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			App app2 = appManageImpl.get(dbid);
			request.setAttribute("app", app2);
		}
		return "edit";
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
		//slide.setBussiId(currentBussi);
		try{
			appManageImpl.save(app);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/app/queryList", "保存数据成功！");
		return ;
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					appManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("未选中数据！"), "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/app/queryList"+query, "删除数据成功！");
		return;
	}
	
}
