package com.ystech.qywx.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppMenu;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.AppManageImpl;
import com.ystech.qywx.service.AppMenuManageImpl;
import com.ystech.qywx.service.AppMenuUtil;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.weixin.core.common.Button;
import com.ystech.weixin.core.common.CommonButton;
import com.ystech.weixin.core.common.ComplexButton;
import com.ystech.weixin.core.common.Menu;
import com.ystech.weixin.core.common.ViewButton;
@Component("appMenuAction")
@Scope("prototype")
public class AppMenuAction extends BaseController{
	private String message;
	private AppMenu appMenu;
	private AppManageImpl appManageImpl;
	private AppMenuManageImpl appMenuManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AppMenuUtil appMenuUtil;
	public AppMenu getAppMenu() {
		return appMenu;
	}
	public void setAppMenu(AppMenu appMenu) {
		this.appMenu = appMenu;
	}
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setAppMenuManageImpl(AppMenuManageImpl appMenuManageImpl) {
		this.appMenuManageImpl = appMenuManageImpl;
	}
	@Resource
	public void setAppMenuUtil(AppMenuUtil appMenuUtil) {
		this.appMenuUtil = appMenuUtil;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer appDbid = ParamUtil.getIntParam(request, "appDbid", -1);
		try{
			App app = appManageImpl.get(appDbid);
			List<AppMenu> appMenus = appMenuManageImpl.find("from AppMenu where app.dbid=? and parent.dbid IS NULL order by orders", new Object[]{app.getDbid()});
			request.setAttribute("appMenus", appMenus);
			request.setAttribute("app", app);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer appDbid = ParamUtil.getIntParam(request, "appDbid", -1);
		try{
			App app = appManageImpl.get(appDbid);
			request.setAttribute("app", app);
			String productCateGorySelect = appMenuManageImpl.getProductCateGorySelect(app.getDbid(),null);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer appDbid = ParamUtil.getIntParam(request, "appDbid", -1);
		try{
			App app = appManageImpl.get(appDbid);
			if(dbid>0){
				AppMenu appMenu2 = appMenuManageImpl.get(dbid);
				String productCateGorySelect = appMenuManageImpl.getProductCateGorySelect(app.getDbid(),appMenu2.getParent());
				request.setAttribute("productCateGorySelect", productCateGorySelect);
				request.setAttribute("appMenu", appMenu2);
			}else{
				String productCateGorySelect = appMenuManageImpl.getProductCateGorySelect(app.getDbid(),null);
				request.setAttribute("productCateGorySelect", productCateGorySelect);
			}
			request.setAttribute("app", app);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parendId = ParamUtil.getIntParam(request, "parentId", -1);
		Integer appDbid = ParamUtil.getIntParam(request, "appDbid", -1);
		try{
				App app = appManageImpl.get(appDbid);
				AppMenu parent=null;
				if(parendId>0){
					parent = appMenuManageImpl.get(parendId);
					appMenu.setParent(parent);
				}
				if(null==appMenu.getDbid()){
					appMenu.setKeyValue("12");
				}
				appMenu.setApp(app);
				if(null==appMenu.getDbid()||appMenu.getDbid()<0){
					//第一添加数据 保存
					appMenuManageImpl.save(appMenu);
				}else{
					AppMenu appMenu2 = appMenuManageImpl.get(appMenu.getDbid());
					appMenu2.setApp(appMenu.getApp());
					appMenu2.setName(appMenu.getName());
					appMenu2.setOrders(appMenu.getOrders());
					appMenu2.setParent(appMenu.getParent());
					appMenu2.setType(appMenu.getType());
					appMenu2.setUrl(appMenu.getUrl());
					appMenuManageImpl.save(appMenu2);
				}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		
		renderMsg("/appMenu/queryList?appDbid="+appDbid, "保存数据成功！");
		return ;
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(null!=dbid&&dbid>0){
			try {
					List<AppMenu> childs = appMenuManageImpl.findBy("parent.dbid", dbid);
					if(null!=childs&&childs.size()>0){
						renderErrorMsg(new Throwable("该数据有子级分类，请先删除子级分类在删除数据！"), "");
						return ;
					}else{
						appMenuManageImpl.deleteById(dbid);
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
		renderMsg("/appMenu/queryList"+query+"&parentMenu=1", "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：同步微信菜单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void sameMenu()  {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			App app = appManageImpl.get(dbid);
			JSONObject jsonMenu = createMenu(app);
			try {
				boolean status = appMenuUtil.createAppMenu(app, jsonMenu.toString());
				if(status==true){
					message = "同步菜单信息数据成功！";
					renderMsg("",message);
					return ;
				}
				if(status==true){
					message = "同步菜单信息数据失败！同步自定义菜单URL地址不正确。";
					renderMsg("",message);
					return ;
				}
				
			} catch (Exception e) {
				message = "同步菜单信息数据失败！";
				e.printStackTrace();
			}finally{
				System.out.println(""+message);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderErrorMsg(new Throwable("同步菜单失败！"), "");
		return ;
	}
	/**
	 * 功能描述：通过应用程序ID购车菜单栏
	 * @param appId
	 * @return
	 */
	private JSONObject createMenu(App app) {
		String hql = "from AppMenu where parent.dbid is null and app.dbid = "+ app.getDbid() + "  order by  orders asc";
		List<AppMenu> menuList = appMenuManageImpl.find(hql, null);
		Menu menu = new Menu();
		Button firstArr[] = new Button[menuList.size()];
		for (int a = 0; a < menuList.size(); a++) {
			AppMenu entity = menuList.get(a);
			String hqls = "from AppMenu where parent.dbid = '" + entity.getDbid()	+ "' and app.dbid = '" + app.getDbid()
					+ "'  order by  orders asc";
			List<AppMenu> childList = appMenuManageImpl.find(hqls, null);
			if (childList.size() == 0) {
				if("view".equals(entity.getType())){
					ViewButton viewButton = new ViewButton();
					viewButton.setName(entity.getName());
					viewButton.setType(entity.getType());
					viewButton.setUrl(entity.getUrl());
					firstArr[a] = viewButton;
				}else if("click".equals(entity.getType())){
					CommonButton cb = new CommonButton();
					cb.setKey(entity.getDbid()+"P");
					cb.setName(entity.getName());
					cb.setType(entity.getType());
					firstArr[a] = cb;
				}
			} else {
				ComplexButton complexButton = new ComplexButton();
				complexButton.setName(entity.getName());
				Button[] secondARR = new Button[childList.size()];
				for (int i = 0; i < childList.size(); i++) {
					AppMenu children = childList.get(i);
					String type = children.getType();
					if ("view".equals(type)) {
						ViewButton viewButton = new ViewButton();
						viewButton.setName(children.getName());
						viewButton.setType(children.getType());
						viewButton.setUrl(children.getUrl());
						secondARR[i] = viewButton;

					} else if ("click".equals(type)) {
						CommonButton cb1 = new CommonButton();
						cb1.setName(children.getName());
						cb1.setType(children.getType());
						cb1.setKey(children.getDbid()+"P");
						secondARR[i] = cb1;
					}

				}
				complexButton.setSub_button(secondARR);
				firstArr[a] = complexButton;
			}
		}
		menu.setButton(firstArr);
		JSONObject jsonMenu = JSONObject.fromObject(menu);
		return jsonMenu;
	}
	/**
	 * 功能描述：删除微信菜单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void deleteWechatMenu() throws Exception {
		Integer dbid = ParamUtil.getIntParam(getRequest(), "dbid", -1);
		try {
			App app = appManageImpl.get(dbid);
			boolean status = appMenuUtil.deleteAppMenu(app);
			if(status==true){
				message = "同步菜单信息数据成功！";
			}else{
				message="同步菜单信息数据失败！";
			}
			renderMsg("",message);
			return ;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
	}

}
