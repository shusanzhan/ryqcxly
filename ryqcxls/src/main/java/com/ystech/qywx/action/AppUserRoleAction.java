package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.AppUserRole;
import com.ystech.qywx.model.AppUserRolePer;
import com.ystech.qywx.service.AppUserRoleManageImpl;
import com.ystech.qywx.service.AppUserRolePerManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("appUserRoleAction")
@Scope("prototype")
public class AppUserRoleAction extends BaseController{
	private DepartmentManageImpl departmentManageImpl;
	private AppUserRoleManageImpl appUserRoleManageImpl;
	private UserManageImpl userManageImpl;
	private AppUserRolePerManageImpl appUserRolePerManageImpl;
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setAppUserRoleManageImpl(AppUserRoleManageImpl appUserRoleManageImpl) {
		this.appUserRoleManageImpl = appUserRoleManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setAppUserRolePerManageImpl(
			AppUserRolePerManageImpl appUserRolePerManageImpl) {
		this.appUserRolePerManageImpl = appUserRolePerManageImpl;
	}
	/**
	 * 功能描述：商家用户管理列表
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		try{
			String departmentIds=null;
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String hql="select * from qywx_appUserRole appUser,sys_User us where 1=1 and appUser.userDbid=us.dbid ";
			if(!currentUser.getUserId().contains("super")){
				hql=hql+" and us.enterpriseId="+enterprise.getDbid();
			}
			List params=new ArrayList();
			if(null!=userId&&userId.trim().length()>0){
				hql=hql+" and appUser.userId like ? ";
				params.add("%"+userId+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				hql=hql+" and appUser.realName like ?";
				params.add("%"+userName+"%");
			}
			if(departmentId>0){
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				hql=hql+" and appUser.departmentId in("+departmentIds+")";
				request.setAttribute("departmentId", departmentId);
			}
			Page<AppUserRole> page = appUserRoleManageImpl.pagedQuerySql(pageNo, pageSize,AppUserRole.class,hql,params.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：添加
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		User currentUser = SecurityUserHolder.getCurrentUser();
		try {
			Enterprise enterprise2 = currentUser.getEnterprise();
			if(currentUser.getUserId().contains("super")){
				Department parent = departmentManageImpl.get(Department.ROOT);
				String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise2.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
			}else{
				String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise2.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
		//添加类型 按部门添加、按用户添加
		Integer addType = ParamUtil.getIntParam(request, "addType", 1);
		//用户ID
		Integer userDbid = ParamUtil.getIntParam(request, "userDbid", 1);
		//部门Id
		Integer depId = ParamUtil.getIntParam(request, "depId", 1);
		//部门百分比
		Integer depUserPer = ParamUtil.getIntParam(request, "depUserPer", 1);
		//用户百分比
		Integer userPer = ParamUtil.getIntParam(request, "userPer", 1);
		try {
			if(addType==1){
				User user = userManageImpl.get(userDbid);
				List<AppUserRole> appUserRoles = appUserRoleManageImpl.findBy("user.dbid", user.getDbid());
				if(null!=appUserRoles&&appUserRoles.size()>0){
					renderErrorMsg(new Throwable("保存失败，系统中已经存在【"+user.getRealName()+"】权限"), "");
					return ;
				}
				AppUserRole appUserRole=new AppUserRole();
				appUserRole.setDepartment(user.getDepartment());
				appUserRole.setUser(user);
				appUserRole.setUserId(user.getUserId());
				appUserRole.setUserName(user.getRealName());
				appUserRole.setUserPer(userPer);
				appUserRoleManageImpl.save(appUserRole);
				saveAppUserRolePer(appUserRole);
			}
			if(addType==2){
				List<User> users = userManageImpl.findBy("department.dbid", depId);
				for (User user : users) {
					List<AppUserRole> appUserRoles = appUserRoleManageImpl.findBy("user.dbid", user.getDbid());
					if(null==appUserRoles||appUserRoles.size()<=0){
						AppUserRole appUserRole=new AppUserRole();
						appUserRole.setDepartment(user.getDepartment());
						appUserRole.setUser(user);
						appUserRole.setUserId(user.getUserId());
						appUserRole.setUserName(user.getRealName());
						appUserRole.setUserPer(depUserPer);
						appUserRoleManageImpl.save(appUserRole);
						saveAppUserRolePer(appUserRole);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return;
		}
		renderMsg("/appUserRole/queryList", "保存权限成功");
		return;
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	private void saveAppUserRolePer(AppUserRole appUserRole) throws Exception {
		HttpServletRequest request = this.getRequest();
		String[] appUserRolePerIds = request.getParameterValues("appUserRolePerId");
		String[] appUserDbids = request.getParameterValues("appUserDbid");
		String[] pers = request.getParameterValues("per");
		String[] nums = request.getParameterValues("num");
		try {
			//编辑数据
			if(null!=appUserRolePerIds&&appUserRolePerIds.length>0){
				int i=0;
				//修改appUserRolePer
				for (String appUserRolePerId : appUserRolePerIds) {
					if(null!=appUserRolePerId&&appUserRolePerId.trim().length()>0){
						int dbid = Integer.parseInt(appUserRolePerId);
						AppUserRolePer appUserRolePer = appUserRolePerManageImpl.get(dbid);
						if(null!=appUserRolePer){
							String appUserDbid = appUserDbids[i];
							int userDbid = Integer.parseInt(appUserDbid);
							User user = userManageImpl.get(userDbid);
							appUserRolePer.setAppUserRole(appUserRole);
							if(null!=user){
								appUserRolePer.setUser(user);
								appUserRolePer.setUserName(user.getRealName());
							}
							String per = pers[i];
							if(null!=per&&per.trim().length()>0){
								int perInt = Integer.parseInt(per);
								appUserRolePer.setPer(perInt);
							}else{
								appUserRolePer.setPer(0);
							}
							String num = nums[i];
							if(null!=num&&num.trim().length()>0){
								int numInt = Integer.parseInt(num);
								appUserRolePer.setNum(numInt);
							}else{
								appUserRolePer.setNum(0);
							}
							appUserRolePerManageImpl.save(appUserRolePer);
						}
					}
					i++;
				}
				//添加新数据
				if(i<appUserDbids.length){
					for (int j = i; j < appUserDbids.length; j++) {
						String appUserDbid = appUserDbids[j];
						if(null!=appUserDbid&&appUserDbid.trim().length()>0){
							int userDbid = Integer.parseInt(appUserDbid);
							User user = userManageImpl.get(userDbid);
							AppUserRolePer appUserRolePer=new AppUserRolePer();
							appUserRolePer.setAppUserRole(appUserRole);
							appUserRolePer.setUser(user);
							appUserRolePer.setUserName(user.getRealName());
							String per = pers[i];
							if(null!=per&&per.trim().length()>0){
								int perInt = Integer.parseInt(per);
								appUserRolePer.setPer(perInt);
							}else{
								appUserRolePer.setPer(0);
							}
							String num = nums[i];
							if(null!=num&&num.trim().length()>0){
								int numInt = Integer.parseInt(num);
								appUserRolePer.setNum(numInt);
							}else{
								appUserRolePer.setNum(0);
							}
							appUserRolePerManageImpl.save(appUserRolePer);
						}
					}
				}
			}else{
				//第一次添加appUserRolePer
				int i=0;
				for (String appUserDbid : appUserDbids) {
					if(null!=appUserDbid&&appUserDbid.trim().length()>0){
						int userDbid = Integer.parseInt(appUserDbid);
						User user = userManageImpl.get(userDbid);
						AppUserRolePer appUserRolePer=new AppUserRolePer();
						appUserRolePer.setAppUserRole(appUserRole);
						appUserRolePer.setUser(user);
						appUserRolePer.setUserName(user.getRealName());
						String per = pers[i];
						if(null!=per&&per.trim().length()>0){
							int perInt = Integer.parseInt(per);
							appUserRolePer.setPer(perInt);
						}else{
							appUserRolePer.setPer(0);
						}
						String num = nums[i];
						if(null!=num&&num.trim().length()>0){
							int numInt = Integer.parseInt(num);
							appUserRolePer.setNum(numInt);
						}else{
							appUserRolePer.setNum(0);
						}
						appUserRolePerManageImpl.save(appUserRolePer);
					}
					i++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	
	/**
	 * 功能描述：编辑
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String editSingle() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			AppUserRole appUserRole = appUserRoleManageImpl.get(dbid);
			request.setAttribute("appUserRole", appUserRole);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "editSingle";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveSingle() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer userPer = ParamUtil.getIntParam(request, "userPer", -1);
		try {
			AppUserRole appUserRole = appUserRoleManageImpl.get(dbid);
			appUserRole.setUserPer(userPer);
			appUserRoleManageImpl.save(appUserRole);
			
			saveAppUserRolePer(appUserRole);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/appUserRole/queryList", "保存数据成功");
		return;
	}
	/**
	 * 功能描述：编辑
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String editSingleRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		try {
			User user = userManageImpl.get(userId);
			if(null!=user){
				List<AppUserRole> appUserRoles = appUserRoleManageImpl.findBy("user.dbid", user.getDbid());
				if(null!=appUserRoles&&appUserRoles.size()>0){
					AppUserRole appUserRole = appUserRoles.get(0);
					request.setAttribute("appUserRole", appUserRole);
				}
				request.setAttribute("user", user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "editSingleRole";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveEditSingleRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		//用户ID
		Integer userDbid = ParamUtil.getIntParam(request, "userDbid", 1);
		//用户百分比
		Integer userPer = ParamUtil.getIntParam(request, "userPer", 1);
		
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid<0){
				User user = userManageImpl.get(userDbid);
				List<AppUserRole> appUserRoles = appUserRoleManageImpl.findBy("user.dbid", user.getDbid());
				if(null!=appUserRoles&&appUserRoles.size()>0){
					renderErrorMsg(new Throwable("保存失败，系统中已经存在【"+user.getRealName()+"】权限"), "");
					return ;
				}
				AppUserRole appUserRole=new AppUserRole();
				appUserRole.setDepartment(user.getDepartment());
				appUserRole.setUser(user);
				appUserRole.setUserId(user.getUserId());
				appUserRole.setUserName(user.getRealName());
				appUserRole.setUserPer(userPer);
				appUserRoleManageImpl.save(appUserRole);
				saveAppUserRolePer(appUserRole);
			}else{
				AppUserRole appUserRole = appUserRoleManageImpl.get(dbid);
				appUserRole.setUserPer(userPer);
				appUserRoleManageImpl.save(appUserRole);
				saveAppUserRolePer(appUserRole);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/userBussi/queryBussiList", "设置权限成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void deleteAppUserRolePer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "appUserRolePerId", -1);
		try {
			appUserRolePerManageImpl.deleteById(dbid);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("","删除数据成功");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	/**
	 * 功能描述：删除用户信息
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		String query = ParamUtil.getQueryUrl(request);
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					appUserRoleManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}
		}
		renderMsg("/appUserRole/queryList"+query, "删除数据成功！");
		return;
	}
}
