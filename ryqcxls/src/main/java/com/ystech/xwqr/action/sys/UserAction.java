package com.ystech.xwqr.action.sys;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.security.service.UserDetailsManageImpl;
import com.ystech.core.util.Md5;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.service.AddressUtil;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.Role;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.RoleManageImpl;
import com.ystech.xwqr.service.sys.SystemInfoMangeImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
@Component("userAction")
@Scope("prototype")
public class UserAction extends BaseController{
	private User user;
	private UserManageImpl userManageImpl;
	private RoleManageImpl roleManageImpl;
	private UserDetailsManageImpl userDetailsManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	private AddressUtil addressUtil;
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setRoleManageImpl(RoleManageImpl roleManageImpl) {
		this.roleManageImpl = roleManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setUserDetailsManageImpl(UserDetailsManageImpl userDetailsManageImpl) {
		this.userDetailsManageImpl = userDetailsManageImpl;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	@Resource
	public void setAddressUtil(AddressUtil addressUtil) {
		this.addressUtil = addressUtil;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		try{
			HttpServletRequest request = this.getRequest();
			List<User> user = userManageImpl.executeSql("select * from sys_User where password='' ", null);
			for (User user2 : user) {
				String calcMD5 = Md5.calcMD5("123456{"+user2.getUserId()+"}");
				user2.setPassword(calcMD5);
				userManageImpl.save(user2);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "add";
	}
	/**
	 * 功能描述：用户管理列表
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
		Integer userType = ParamUtil.getIntParam(request, "userType", -1);
		Integer userState = ParamUtil.getIntParam(request, "userState", 1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String departmentIds=null;
			if(departmentId>0){
				Department department = departmentManageImpl.get(departmentId);
				/*String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
				r*/
				//request.setAttribute("departmentSelect", departmentSelect);
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
			}else{
				//String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
				//request.setAttribute("departmentSelect", departmentSelect);
			}
			Page<User> page=null;
			String hql="select * from sys_user where 1=1 and adminType="+User.ADMINTYPEADCOMM+ " and enterpriseId=? ";
			List params=new ArrayList();
			params.add(enterprise.getDbid());
			if(null!=userId&&userId.trim().length()>0){
				hql=hql+" and userId like ? ";
				params.add("%"+userId+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				hql=hql+" and realName like ?";
				params.add("%"+userName+"%");
			}
			if(userType>0){
				hql=hql+" and userType=? ";
				params.add(userType);
			}
			if(userState>0){
				hql=hql+" and userState=? ";
				params.add(userState);
			}
			if(null!=departmentIds){
				hql=hql+" and departmentId in("+departmentIds+")";
			}
			page = userManageImpl.pagedQuerySql(pageNo, pageSize,User.class,hql,params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
		}
		return "list";
	}
	/**
	 * 功能描述：保存用户信息
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		String[] departmentIds = request.getParameterValues("departmentIds");
		String[] positIds = request.getParameterValues("positionIds");
		String[] posiNames = request.getParameterValues("positionNames");
		if(null!=departmentIds&&departmentIds.length>0){
			if(departmentIds.length>1){
				renderErrorMsg(new Throwable("只能选择一个部门，请选择部门"), "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("请选择部门信息"), "");
			return ;
		}
		String positionIds="";
		String positionNames="";
		if(null!=positIds&&positIds.length>0){
			int i=0;
			for (String positId : positIds) {
				positionIds=positionIds+positId+",";
				positionNames=positionNames+posiNames[i]+",";
				i++;
			}
		}else{
			renderErrorMsg(new Throwable("请选岗位信息"), "");
			return ;
		}
		try{
			//用户配置信息
			SystemInfo systemInfo=null;
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos){
				systemInfo=systemInfos.get(0);
			}
			user.setPositionIds(positionIds);
			user.setPositionNames(positionNames);
			//保存用户信息
			String calcMD5 = Md5.calcMD5("123456{"+user.getUserId()+"}");
			Integer dbid = user.getDbid();
			String depIs = departmentIds[0];
			if(null!=depIs){
				Department department = departmentManageImpl.get(Integer.parseInt(depIs));
				user.setDepartment(department);
				/*User manager = department.getManager();
				user.setParent(manager);*/
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null!=dbid&&dbid>0){
				User user2 = userManageImpl.get(dbid);
				user2.setEmail(user.getEmail());
				user2.setMobilePhone(user.getMobilePhone());
				user2.setPhone(user.getPhone());
				user2.setWechatId(user.getWechatId());
				user2.setRealName(user.getRealName());
				user2.setUserId(user.getUserId());
				user2.setDepartment(user.getDepartment());
				user2.setQq(user.getQq());
				user2.setPositionIds(user.getPositionIds());
				user2.setParent(user.getParent());
				user2.setBussiType(user.getBussiType());
				user2.setEnterprise(enterprise);
				user2.setPositionNames(user.getPositionNames());
				userManageImpl.save(user2);
				
				
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean status = addressUtil.updateUser(user2);
						if(status==false){
							renderMsg("/user/queryList", "保存数据成功,但用户同步微信企业号失败！");
							return ;
						}
					}
				}
			}else{
				user.setPassword(calcMD5);
				user.setEnterprise(enterprise);
				user.setUserState(1);
				user.setApprovalCpidStatus(User.APPROVALCOMM);
				user.setAdminType(User.ADMINTYPEADCOMM);
				user.setQueryOtherDataStatus(User.QUERYCOMM);
				user.setSysWeixinStatus(User.SYNCOMM);
				user.setAttentionStatus(User.ATTATIONSTATUSDEFUAL);
				userManageImpl.save(user);
				
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean status = addressUtil.createUser(user);
						if(status==false){
							renderMsg("/user/queryList", "保存数据成功,但用户同步微信企业号失败！");
							return ;
						}else{
							user.setSysWeixinStatus(User.SYNYYES);
							userManageImpl.save(user);
						}
					}
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return; 
		}
		renderMsg("/user/queryList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：编辑用户信息
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		if(dbid>0){
			User user = userManageImpl.get(dbid);
			request.setAttribute("user", user);
		}
		return "edit";
	}
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
					User user = userManageImpl.get(dbid);
					if(user.getUserId().equals("super")){
						renderErrorMsg(new Throwable("管理员不能删除！"), "");
						return ;
					}
					userManageImpl.deleteById(dbid);
					SystemInfo systemInfo = systemInfoMangeImpl.getSystemInfo();
					//同步用户资料到微信判断
					if(null!=systemInfo){
						if(systemInfo.getWxUserStatus()==2){
							boolean stopUser = addressUtil.deleteUser(user);
							if(stopUser==false){
								renderMsg("/user/queryList"+query, "删除数据成功,同步微信端数据失败！");
								return ;
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}
		}
		
		renderMsg("/user/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：个人设置-设置用户信息
	 * @return
	 * @throws Exception
	 */
	public String editSelf() throws Exception {
		User user = SecurityUserHolder.getCurrentUser();
		HttpServletRequest request = this.getRequest();
		if(null!=user&&user.getDbid()>0){
			User user2 = userManageImpl.get(user.getDbid());
			request.setAttribute("user", user2);
		}
		return "editSelf";
	}
	/**
	 * 功能描述：保存用户信息
	 * @throws Exception
	 */
	public void saveEditSelf() throws Exception {
		try{
			//保存用户信息
			Integer dbid = user.getDbid();
			User user2 = userManageImpl.get(dbid);
			user2.setEmail(user.getEmail());
			user2.setMobilePhone(user.getMobilePhone());
			user2.setPhone(user.getPhone());
			user2.setRealName(user.getRealName());
			user2.setQq(user.getQq());
			user2.setWechatId(user.getWechatId());
			user2.setUserId(user.getUserId());
			userManageImpl.save(user2);
			this.getRequest().getSession().setAttribute("user", user2);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/user/editSelf", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：修改密码
	 * @return
	 * @throws Exception
	 */
	public String modifyPassword() throws Exception {
		User user = SecurityUserHolder.getCurrentUser();
		HttpServletRequest request = this.getRequest();
		if(null!=user&&user.getDbid()>0){
			User user2 = userManageImpl.get(user.getDbid());
			request.setAttribute("user", user2);
		}
		return "modifyPassword";
	}
	/**
	 * 功能描述：修改密码
	 * @return
	 * @throws Exception
	 */
	public void updateModifyPassword() throws Exception {
		HttpServletRequest request = getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		String oldPassword = request.getParameter("oldPassword");
		String password = request.getParameter("password");
		if(null==oldPassword||oldPassword.trim().length()<=0){
			renderErrorMsg(new Throwable("输入旧密码错误！"), "");
			return ;
		}
		if(null==password||password.trim().length()<=0){
			renderErrorMsg(new Throwable("密码输入错误！"), "");
			return ;
		}
		try{
			if (dbid>0) {
				User user2 = userManageImpl.get(dbid);
				String password2 = user2.getPassword();
				String calcMD5 = Md5.calcMD5(oldPassword+"{"+user2.getUserId()+"}");
				if(password2.equals(calcMD5)){
					user2.setPassword(Md5.calcMD5(password+"{"+user2.getUserId()+"}"));
					userManageImpl.save(user2);
				}else{
					renderErrorMsg(new Throwable("旧密码输入错误！"), "");
					return ;	
				}
			} else {
				renderErrorMsg(new Throwable("操作数据错误！"), "");
				return ;
			}	
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("操作数据错误！"), "");
			return ;
		}
		renderMsg("/user/modifyPassword", "修改密码成功！");
		return ;
	}
	/**系统配置角色**/
	public String userRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				User user2=userManageImpl.get(dbid);
				request.setAttribute("user2",user2);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "userRole";
	}
	/**
	 * 功能描述：启用或者停用用户
	 */
	public void stopOrStartUser() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		String query = ParamUtil.getQueryUrl(request);
		try{
			if(dbid>0){
				User user2 = userManageImpl.get(dbid);
				Integer userState = user2.getUserState();
				if(null!=userState){
					if(userState==1){
						user2.setUserState(2);
					}else if(userState==2){
						user2.setUserState(1);
					}
				}
				userManageImpl.save(user2);
				SystemInfo systemInfo = systemInfoMangeImpl.getSystemInfo();
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean stopUser = addressUtil.stopUser(user2);
						if(stopUser==false){
							renderMsg("/user/queryList"+query, "设置成功,同步微信端数据失败！");
							return ;
						}
					}
				}
				
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		
		renderMsg("/user/queryList"+query, "设置成功！");
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void resetPassword() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try{
			if(dbid>0){
				User user2 = userManageImpl.get(dbid);
				String password = Md5.calcMD5("123456{"+user2.getUserId()+"}");
				user2.setPassword(password);
				userManageImpl.save(user2);
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		String query = ParamUtil.getQueryUrl(request);
		if(type==1){
			renderMsg("/user/queryList"+query, "设置成功！");
		}else{
			renderMsg("/userBussi/queryBussiList"+query, "设置成功！");
		}
	}
	public void validateUser() {
		HttpServletRequest request = this.getRequest();
		String userId =null;
		userId=request.getParameter("user.userId");
		List<User> users=null;
		if(null!=userId&&userId.trim().length()>0){
			users = userManageImpl.findBy("userId", userId);
		}else{
			renderText("系统已经存在该用户了!请换一个用户ID!");//输入的账户类型不匹配！
			return ;
		}
		
		if (null!=users&&users.size()>0) {
			renderText("系统已经存在该用户了!请换一个用户ID!");//已经注册，请直接登录！
		}else{
			renderText("success");//
		}
		
	}
	
	public void saveUserRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		//合同审批权限
		Integer approvalCpidStatus = ParamUtil.getIntParam(request, "approvalCpidStatus", -1);
		Integer[] roleIds = ParamUtil.getIntArray(request, "id");
		Set<Role> roles=new HashSet<Role>();
		try{
			if(dbid>0){
				User user2 = userManageImpl.get(dbid);
				roles.clear();
				if(null!=roleIds&&roleIds.length>0){
					for (Integer roId : roleIds) {
						Role role = roleManageImpl.get(roId);
						roles.add(role);
					}
				}
				if(approvalCpidStatus>0){
					user2.setApprovalCpidStatus(approvalCpidStatus);
				}else{
					user2.setApprovalCpidStatus(User.APPROVALCOMM);
				}
				user2.setRoles(roles);
				userManageImpl.save(user2);
				userDetailsManageImpl.loadUserByUsername(user2.getUserId());
				renderMsg("/user/queryList", user2.getUserId()+"分配角色成功！");
			}
			else{
				renderErrorMsg(new Throwable("请选择分配权限用户"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		return ;
	}
	public void userRoleJson() throws JSONException {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			user=userManageImpl.get(dbid);
			Set<Role> roles = user.getRoles();
			JSONArray makeJson = makeJson(roles,user);
			renderJson(makeJson.toString());
			return ;
		}
		renderJson("1");
		return ;
	}
	private JSONArray makeJson(Set<Role> roles,User user) throws JSONException{
		List<Role> roList = roleManageImpl.find("from Role where state=? and userType=?", new Object[]{1,user.getAdminType()});
		JSONArray jsonArray=null;
		if(null!=roList&&roList.size()>0){
			jsonArray=new JSONArray();
			for (Role role : roList) {
				JSONObject object=new JSONObject();
				object.put("dbid", role.getDbid());
				object.put("name", role.getName());
				if(null!=roles&&roles.size()>0){
					for (Role role2 : roles) {
						if(role.getDbid()==role2.getDbid()){
							object.put("checked", true);
							break;
						}
					}
				}
				jsonArray.put(object);
			}
		}
		return jsonArray;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String pingyin = request.getParameter("q");
			System.out.println("pingyinpingyinpingyin"+pingyin);
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}else{
			}
			List<User> users=new ArrayList<User>();
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(null==currentUser){
				currentUser = getSessionUser();
			}
			if(null==currentUser){
				return ;
			}
			String sql="select * from sys_user where 1=1 ";
			if(currentUser.getUserId().contains("super")||currentUser.getUserId().contains("zhaochendi")){
				
			}else{
				if(null==enterprise){
					enterprise = currentUser.getEnterprise();
				}
				if(null!=enterprise){
					sql=sql+" and enterpriseId="+enterprise.getDbid();
				}else{
					return ;
				}
			}
			sql=sql+" and (userId like ?  or realName like ? ) ";
			users= userManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			if(null==users||users.size()<=0){
				users = userManageImpl.getAll();
			}
			JSONArray  array=new JSONArray();
			if(null!=users&&users.size()>0){
				for (User user : users) {
					JSONObject object=new JSONObject();
					object.put("dbid", user.getDbid());
					object.put("name", user.getRealName());
					object.put("userId", user.getUserId());
					object.put("mobilePhone", user.getMobilePhone());
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxSendUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}else{
			}
			List<User> users=new ArrayList<User>();
			String sql="select * from user where 1=1 ";
			sql=sql+" and (userId like ?  or realName like ? ) ";
			users= userManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			if(null==users||users.size()<=0){
				users = userManageImpl.getAll();
			}
			JSONArray  array=new JSONArray();
			if(null!=users&&users.size()>0){
				for (User user : users) {
					JSONObject object=new JSONObject();
					object.put("dbid", user.getDbid());
					object.put("name", user.getRealName());
					object.put("userId", user.getUserId());
					object.put("mobilePhone", user.getMobilePhone());
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return;
	}
}
