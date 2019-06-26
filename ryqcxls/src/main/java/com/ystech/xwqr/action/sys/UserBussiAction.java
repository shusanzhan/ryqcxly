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
import com.ystech.core.security.service.UserDetailsManageImpl;
import com.ystech.core.util.Md5;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.service.AddressUtil;
import com.ystech.qywx.service.AppUserManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.Role;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.RoleManageImpl;
import com.ystech.xwqr.service.sys.SystemInfoMangeImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("userBussiAction")
@Scope("prototype")
public class UserBussiAction extends BaseController{
	private Enterprise enterprise;
	private User user;
	private UserManageImpl userManageImpl;
	private RoleManageImpl roleManageImpl;
	private UserDetailsManageImpl userDetailsManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private AreaManageImpl areaManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	private AppUserManageImpl appUserManageImpl;
	private AddressUtil addressUtil;
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setRoleManageImpl(RoleManageImpl roleManageImpl) {
		this.roleManageImpl = roleManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Resource
	public void setUserDetailsManageImpl(UserDetailsManageImpl userDetailsManageImpl) {
		this.userDetailsManageImpl = userDetailsManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	public Enterprise getEnterprise() {
		return enterprise;
	}
	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	@Resource
	public void setAddressUtil(AddressUtil addressUtil) {
		this.addressUtil = addressUtil;
	}
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	/**
	 * 功能描述：商家用户管理列表
	 * @return
	 * @throws Exception
	 */
	public String queryBussiList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer adminType = ParamUtil.getIntParam(request, "adminType", -1);
		Integer userState = ParamUtil.getIntParam(request, "userState", 1);
		try{
			String departmentIds=null;
			
			Page<User> page=null;
			String hql="select * from sys_user where 1=1 ";
			List params=new ArrayList();
			if(null!=userId&&userId.trim().length()>0){
				hql=hql+" and userId like ? ";
				params.add("%"+userId+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				hql=hql+" and realName like ?";
				params.add("%"+userName+"%");
			}
			if(adminType>0){
				hql=hql+" and adminType=? ";
				params.add(adminType);
			}
			if(userState>0){
				hql=hql+" and userState=? ";
				params.add(userState);
			}
			if(departmentId>0){
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				hql=hql+" and departmentId in("+departmentIds+")";
				request.setAttribute("departmentId", departmentId);
			}
			page = userManageImpl.pagedQuerySql(pageNo, pageSize,User.class,hql,params.toArray());
			List<User> result = page.getResult();
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "bussiList";
	}
	/**
	 * 功能描述：添加商家用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				User user = userManageImpl.get(dbid);
				request.setAttribute("user", user);
				List<Enterprise> enterprises = enterpriseManageImpl.getAll();
				request.setAttribute("enterprises", enterprises);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：添加商家用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			request.setAttribute("enterprises", enterprises);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "add";
	}
	/**
	 * 功能描述：添加普通用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String addComm() throws Exception {
		try{
			HttpServletRequest request = this.getRequest();
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			request.setAttribute("enterprises", enterprises);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "addComm";
	}
	/**
	 * 功能描述：编辑普通用户
	 * @return
	 * @throws Exception
	 */
	public String editComm() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				User user = userManageImpl.get(dbid);
				request.setAttribute("user", user);
			}
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			request.setAttribute("enterprises", enterprises);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "editComm";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveAddBussi() throws Exception {
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
		try {
			//用户配置信息
			SystemInfo systemInfo=null;
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos){
				systemInfo=systemInfos.get(0);
			}
			
			user.setPositionIds(positionIds);
			user.setPositionNames(positionNames);
			String depIs = departmentIds[0];
			if(null!=depIs){
				Department department = departmentManageImpl.get(Integer.parseInt(depIs));
				user.setDepartment(department);
			}
			//保存用户信息
			String calcMD5 = Md5.calcMD5("123456{"+user.getUserId()+"}");
			Integer dbid = user.getDbid();
			if(null!=dbid&&dbid>0){
				User user2 = userManageImpl.get(dbid);
				user2.setEmail(user.getEmail());
				user2.setMobilePhone(user.getMobilePhone());
				user2.setPhone(user.getPhone());
				user2.setRealName(user.getRealName());
				user2.setUserId(user.getUserId());
				user2.setCompanyName(user.getCompanyName());
				user2.setDepartment(user.getDepartment());
				user2.setPositionNames(user.getPositionNames());
				user2.setPositionIds(user.getPositionIds());
				user2.setBussiType(user.getBussiType());
				user2.setQq(user.getQq());
				user2.setWechatId(user.getWechatId());
				userManageImpl.save(user2);
				//大于1，填写部门信息
				if(null!=user2.getDepartment()){
					//更新单位信息
					Department department = user2.getDepartment();
					Enterprise enterprise2 = department.getEnterprise();
					if(null!=enterprise2){
						enterprise2.setUserId(user2.getDbid());
						enterpriseManageImpl.save(enterprise2);
						
						user2.setEnterprise(enterprise2);
						userManageImpl.save(user2);
					}
				}
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean status = addressUtil.updateUser(user2);
						if(status==false){
							renderMsg("/userBussi/queryBussiList", "保存数据成功,但用户同步微信企业号失败！");
							return ;
						}
					}
				}
			}else{
				user.setPassword(calcMD5);
				//设置状态为 
				user.setUserState(1);
				user.setAdminType(User.ADMINTYPEADMIN);
				user.setApprovalCpidStatus(User.APPROVALCOMM);
				user.setQueryOtherDataStatus(User.QUERYCOMM);
				user.setSysWeixinStatus(User.SYNCOMM);
				user.setAttentionStatus(User.ATTATIONSTATUSDEFUAL);
				userManageImpl.save(user);
				
				//大于1，填写部门信息
				if(null!=user.getDepartment()){
					//更新单位信息
					Department department = user.getDepartment();
					Enterprise enterprise2 = department.getEnterprise();
					if(null!=enterprise2){
						enterprise2.setUserId(user.getDbid());
						enterpriseManageImpl.save(enterprise2);
						
						user.setEnterprise(enterprise2);
						userManageImpl.save(user);
					}
				}
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean status = addressUtil.createUser(user);
						if(status==false){
							renderMsg("/userBussi/queryBussiList", "保存数据成功,但用户同步微信企业号失败！");
							return ;
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("保存数据失败"), "");
			return ;
		}
		renderMsg("/userBussi/queryBussiList", "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：保存普通用户信息
	 * @throws Exception
	 */
	public void saveComm() throws Exception {
		HttpServletRequest request = this.getRequest();
		String[] departmentIds = request.getParameterValues("departmentIds");
		String[] positIds = request.getParameterValues("positionIds");
		String[] posiNames = request.getParameterValues("positionNames");
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
	    Integer type = ParamUtil.getIntParam(request, "type", -1);
		if(null!=departmentIds&&departmentIds.length>0){
			if(departmentIds.length>1){
				renderErrorMsg(new Throwable("只能选择一个部门，请选择部门"), "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("请选择部门信息"), "");
			return ;
		}
		if(enterpriseId<0){
			renderErrorMsg(new Throwable("请选所属分店"), "");
			return ;
		}
		if(parentId<0){
			renderErrorMsg(new Throwable("直属领导为空，请填写上级领导"), "");
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
		String message="保存数据成功！";
		try{
			//用户配置信息
			SystemInfo systemInfo=null;
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos){
				systemInfo=systemInfos.get(0);
			}
			User parent = userManageImpl.get(parentId);
			
			user.setPositionIds(positionIds);
			user.setPositionNames(positionNames);
			Enterprise enterprise2 = enterpriseManageImpl.get(enterpriseId);
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
				user2.setParent(parent);
				user2.setEnterprise(enterprise2);
				user2.setPositionNames(user.getPositionNames());
				user2.setBussiType(user.getBussiType());
				userManageImpl.save(user2);
				
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean status = addressUtil.updateUser(user2);
						if(status==false){
							message="保存数据成功,但用户同步微信企业号失败！";
						}
					}
				}
			}else{
				user.setParent(parent);
				user.setPassword(calcMD5);
				user.setEnterprise(enterprise2);
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
							message="保存数据成功,但用户同步微信企业号失败！";
						}
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return; 
		}
		if(type==1){
			renderMsg("/userBussi/queryBussiList", message);
		}
		if(type==2){
			renderMsg("/userBussi/userRoleAdd?dbid="+user.getDbid(), message);
		}
		return ;
	}
	/**系统配置角色**/
	public String userRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			if(dbid>0){
				User user2=userManageImpl.get(dbid);
				request.setAttribute("user2", user2);
				String compnayIds = user2.getCompnayIds();
				if(null!=compnayIds&&compnayIds.trim().length()>0){
					String[] compnayArrarys = compnayIds.split(",");
					request.setAttribute("compnayArrarys", compnayArrarys);
				}
			}
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			request.setAttribute("enterprises", enterprises);
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos&&systemInfos.size()>0){
				SystemInfo systemInfo = systemInfos.get(0);
				request.setAttribute("systemInfo", systemInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return "userRole";
	}
	/**系统配置角色**/
	public String userRoleAdd() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			if(dbid>0){
				User user2=userManageImpl.get(dbid);
				request.setAttribute("user2", user2);
				String compnayIds = user2.getCompnayIds();
				if(null!=compnayIds&&compnayIds.trim().length()>0){
					String[] compnayArrarys = compnayIds.split(",");
					request.setAttribute("compnayArrarys", compnayArrarys);
				}
			}
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			request.setAttribute("enterprises", enterprises);
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos&&systemInfos.size()>0){
				SystemInfo systemInfo = systemInfos.get(0);
				request.setAttribute("systemInfo", systemInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		
		return "userRoleAdd";
	}
	/**
	 * 功能描述：保存用户权限
	 * 参数描述：
	 * 逻辑描述：
	 * @param user
	 */
	public void saveUserRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		//合同审批权限
		Integer approvalCpidStatus = ParamUtil.getIntParam(request, "approvalCpidStatus", -1);
		//查询其他公司数据权限
		Integer queryOtherDataStatus = ParamUtil.getIntParam(request, "queryOtherDataStatus", -1);
		//利润审批权限金额
		Integer approvalMoney = ParamUtil.getIntParam(request, "approvalMoney", 0);
		//领导自己审批自己权限
		Integer selfApproval = ParamUtil.getIntParam(request, "selfApproval", -1);
		Integer[] roleIds = ParamUtil.getIntArray(request, "id");
		Integer[] companyIds = ParamUtil.getIntArray(request, "companyId");
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
				user2.setRoles(roles);
				//设置查询其他公司数据权限
				if(null!=companyIds&&companyIds.length>0){
					String compIds=new String();
					for (Integer companyId : companyIds) {
						compIds=compIds+companyId+",";
					}
					int lastIndexOf = compIds.lastIndexOf(",");
					String substring = compIds.substring(0, lastIndexOf);
					user2.setCompnayIds(substring);
				}
				if(approvalCpidStatus>0){
					user2.setApprovalCpidStatus(approvalCpidStatus);
				}else{
					user2.setApprovalCpidStatus(User.APPROVALCOMM);
				}
				if(queryOtherDataStatus>0){
					user2.setQueryOtherDataStatus(queryOtherDataStatus);
				}else{
					user2.setQueryOtherDataStatus(User.QUERYCOMM);
				}
				if(selfApproval>0){
					user2.setSelfApproval(selfApproval);
				}else{
					user2.setSelfApproval(User.QUERYCOMM);
				}
				if(approvalMoney==0){
					user2.setApprovalMoney(0);
				}else{
					user2.setApprovalMoney(approvalMoney);
				}
				userManageImpl.save(user2);
				userDetailsManageImpl.loadUserByUsername(user2.getUserId());
				if(type==1){
					renderMsg("/userBussi/queryBussiList", user2.getUserId()+"权限分配成功！");
				}
				if(type==2){
					renderMsg("/userBussi/wechatRole?userId="+user2.getDbid(), user2.getUserId()+"权限分配成功！");
				}
			}else{
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
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String wechatRole() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		try {
			User user2 = userManageImpl.get(userId);
			request.setAttribute("user", user2);
			if(null!=user2){
				List<AppUser> appUsers = appUserManageImpl.findBy("user.dbid", user2.getDbid());
				if(null!=appUsers&&appUsers.size()>0){
					AppUser appUser = appUsers.get(0);
					request.setAttribute("appUser", appUser);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "wechatRole";
	}
	/**
	 * 功能描述：删除用户
	 * 参数描述：
	 * 逻辑描述：
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				//用户配置信息
				SystemInfo systemInfo=null;
				List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
				if(null!=systemInfos){
					systemInfo=systemInfos.get(0);
				}
				for (Integer dbid : dbids) {
					User user = userManageImpl.get(dbid);
					if(user.getUserId().equals("super")){
						renderErrorMsg(new Throwable("超级管理员不能删除！"), "");
						return ;
					}
					userManageImpl.deleteById(dbid);
					//同步用户资料到微信判断
					if(null!=systemInfo){
						if(systemInfo.getWxUserStatus()==2){
							//删除微信用户
							addressUtil.deleteUser(user);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/userBussi/queryBussiList"+query, "删除数据成功！");
		return;
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
	 * @param memberInfo2
	 */
	private String areaSelect(Area area) {
		StringBuffer buffer=new StringBuffer();
		if(null!=area){
			String treePath = area.getTreePath();
			String[] split = treePath.split(",");
			if(split.length>1){
				//父节点
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				if(null!=areas&&areas.size()>0){
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas) {
						if(ar.getDbid()==Integer.parseInt(split[1])){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
				for (int i=2; i<split.length ; i++) {
					List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[i-1]));
					if(null!=areas2&&areas2.size()>0){
						buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
						buffer.append("<option>请选择...</option>");
						for (Area ar : areas2) {
							if(ar.getDbid()==Integer.parseInt(split[i])){
								buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}else{
								buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}
						}
						buffer.append("</select> ");
					}
				}
				//最后一个下拉框
				List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[split.length-1]));
				if(null!=areas2&&areas2.size()>0){
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas2) {
						if(ar.getDbid()==area.getDbid()){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
			}
		}else{
			return null;
		}
		return buffer.toString();
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
							renderMsg("/userBussi/queryBussiList"+query, "设置成功,同步微信端数据失败！");
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
		
		renderMsg("/userBussi/queryBussiList"+query, "设置成功！");
	}
}
