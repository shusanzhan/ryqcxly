/**
 * 
 */
package com.ystech.xwqr.action.sys;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.service.DepartmentWexinUtil;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.SystemInfoMangeImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

/**
 * @author shusanzhan
 * @date 2013-5-23
 */
@Component("departmentAction")
@Scope("prototype")
public class DepartmentAction extends BaseController{
	private Department department;
	private DepartmentManageImpl departmentManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private UserManageImpl userManageImpl;
	private DepartmentWexinUtil departmentWexinUtil;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	public Department getDepartment() {
		return department;
	}
	public void setDepartment(Department department) {
		this.department = department;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setDepartmentWexinUtil(DepartmentWexinUtil departmentWexinUtil) {
		this.departmentWexinUtil = departmentWexinUtil;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	/**
	 * 功能描述：部门树页面
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		return "list";
	}
	
	/**
	 * 功能描述：添加部门信息
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if (dbid > 0) {
			Department department = departmentManageImpl.get(dbid);
			request.setAttribute("department", department);
			
			Enterprise enterprise = department.getEnterprise();
			request.setAttribute("enterprise", enterprise);
		}
		return "edit";
	}
	/**
	 * 功能描述：部门信息保存
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		Integer manager = ParamUtil.getIntParam(request,"managerId", -1);
		Integer enterpriseId = ParamUtil.getIntParam(request,"enterpriseId", -1);
		try {
			if(parentId<0){
				renderErrorMsg(new Throwable("请选择上级部门"), "");
				return ;
			}
			if(manager>0){
				User user = userManageImpl.get(manager);
				department.setManager(user);
			}
			//用户配置信息
			SystemInfo systemInfo=null;
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos){
				systemInfo=systemInfos.get(0);
			}
			if (null!=department.getDbid()&&department.getDbid()>0) {
				//编辑资料
				Department parent=null;
				Department department2 = departmentManageImpl.get(department.getDbid());
				if(parentId>0){
					 parent = departmentManageImpl.get(parentId);
					 //如果父节点不为空，并且父节点不为根节点
					 if(null!=parent&&parent.getDbid()!=(int)Department.ROOT){
						 department2.setEnterprise(parent.getEnterprise());
					 }
				}
				department2.setDiscription(department.getDiscription());
				department2.setFax(department.getFax());
				department2.setManager(department.getManager());
				department2.setName(department.getName());
				department2.setParent(parent);
				department2.setPhone(department.getPhone());
				department2.setSuqNo(department.getSuqNo());
				department2.setType(department.getType());
				department2.setBussiType(department.getBussiType());
				departmentManageImpl.save(department2);
				
				
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean createDepartment = departmentWexinUtil.updateDepartment(department2);
						if(createDepartment==false){
							renderMsg("/department/list?parentId="+parentId, "保存数据成功,但同步部门微信企业号失败！");
							return ;
						}
					}
				}
			}
			else{
				//第一次创建部门
				Department parent = departmentManageImpl.get(parentId);
				department.setParent(parent);
				 //如果父节点不为空，并且父节点不为根节点
				if(null!=parent&&parent.getDbid()!=(int)Department.ROOT){
					department.setEnterprise(parent.getEnterprise());
				}
				departmentManageImpl.save(department);
				
				//同步用户资料到微信判断
				if(null!=systemInfo){
					if(systemInfo.getWxUserStatus()==2){
						boolean createDepartment = departmentWexinUtil.createDepartment(department);
						if(createDepartment==false){
							renderMsg("/department/list?parentId="+parentId, "保存数据成功,但同步部门微信企业号失败！");
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
		
		renderMsg("/department/list?parentId="+parentId, "保存数据成功！",department.getDbid());
		return ;
	}
	/*保存数据成功处理机制 */
	public void renderMsg(String url,String message,Integer depId){
		JSONArray jsonArray=new JSONArray();
		JSONObject jsonObject=new JSONObject();
		try {
			jsonObject.put("mark", "0");
			jsonObject.put("url",  getRequest().getContextPath()+url);
			jsonObject.put("message", message);
			jsonObject.put("depId", depId);
		} catch (JSONException e) {
			e.printStackTrace();
			log.error("保存数据成功！返回提示信息转换成JSON数据是发生错误！");
		}
		jsonArray.put(jsonObject);
		renderJson(jsonArray.toString());
	}
	/**
	 * 功能描述：删除部门信息
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Department department2 = departmentManageImpl.get(dbid);
			departmentManageImpl.deleteById(dbid);
			//同步删除微信端部门
			SystemInfo systemInfo = systemInfoMangeImpl.getSystemInfo();
			if(null!=systemInfo){
				if(systemInfo.getWxUserStatus()==2){
					boolean createDepartment = departmentWexinUtil.deleteDepartment(department2);
					if(createDepartment==false){
						renderMsg("", "删除数据成功,但同步部门微信企业号失败！");
						return ;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("", "删除数据成功！");
		return;
	}
	public void getDepartmentByDbid() throws Exception{
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			JSONObject object=new JSONObject();
			Department department2 = departmentManageImpl.get(dbid);
			if(null!=department2){
				object.put("dbid", department2.getDbid());
				object.put("name", department2.getName());
				object.put("phone", department2.getPhone());
				object.put("fax", department2.getFax());
				if(null!=department2.getManager())
					object.put("manager", department2.getManager().getRealName());
				object.put("suqNo", department2.getSuqNo());
				object.put("discription", department2.getDiscription());
				renderJson(object.toString());
			}else{
				renderText("error");
				return ;
			}
		}
		else{
			renderText("error");
			return ;
		}
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderNum() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		try {
			List<Department> departments=null;
			if(parentId<=0){
				departments = departmentManageImpl.find("from Department where parent.dbid is NUll order by suqNo", null);
			}else{
				departments = departmentManageImpl.find("from Department where parent.dbid=? order by suqNo", parentId);
			}
			request.setAttribute("departments", departments);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "orderNum";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOrderNum() throws Exception {
		HttpServletRequest request = this.getRequest();
		String[] dbids = request.getParameterValues("dbid");
		String[] orderNos = request.getParameterValues("orderNo");
		int parentId=0;
		try {
			int i=0;
			for (String dbid : dbids) {
				Integer d = Integer.parseInt(dbid);
				Department department = departmentManageImpl.get(d);
				if(null!=orderNos[i]&&orderNos[i].trim().length()>0){
					department.setSuqNo(Integer.parseInt(orderNos[i]));
				}
				departmentManageImpl.save(department);
				i++;
				parentId=department.getParentId();
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		renderMsg("/department/list?parentId="+parentId, "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：前台拖拽更新资源
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void updateParent() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		try {
			if(dbid>0){
				Department department2 = departmentManageImpl.get(dbid);
				Department parent = departmentManageImpl.get(parentId);
				department2.setParent(parent);
				departmentManageImpl.save(department2);
				/*Set<Department> children = department2.getChildren();
				if (children.size()>0) {
					for (Department chi : children) {
						chi.setMenu(resource2.getMenu()+1);
						resourceManageImpl.save(chi);
					}
				}*/
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("", "更新数据成功！");
		return ;
	}
	/**
	 * 功能描述：部门树生成JSON串
	 * 逻辑描述：默认绑定一颗根节点，更节点的父节点为0
	 */
	public void editResourceJson() {
		try {
			JSONObject jsonObject=null;
			JSONArray array=new JSONArray();
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise company = SecurityUserHolder.getEnterprise();
			if(null==currentUser.getDepartment()||currentUser.getDepartment().getDbid()==1){
				Department department2 = departmentManageImpl.get(1);
				jsonObject=new JSONObject();
				jsonObject = makeJSONSuperObject(department2);
				if(jsonObject!=null){
					array.put(jsonObject);
				}
			}else{
				/*Department department2 = departmentManageImpl.findUnique("from Department where dbid=?", company.getDepartment().getDbid());
				if(null!=department2){
					jsonObject=new JSONObject();
					jsonObject = makeJSONObject(department2);
					if(jsonObject!=null){
						array.put(jsonObject);
					}
				}*/
			}
			renderJson(array.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	/**
	 *功能描述： 将传入的对象转化为JSON数据格式
	 * 部门树：根节点，具有子结构节点，子节点
	 * @throws JSONException
	 */
	private JSONObject makeJSONObject(Department department) throws JSONException {
		JSONObject jObject = new JSONObject();
		List<Department> children = departmentManageImpl.find("from Department where parent.dbid=? order by suqNo",	new Object[] { department.getDbid() });
		if (null != children && children.size() > 0) {// 如果子部门不空
			if (department.getParent() != null&&department.getParent().getDbid()>0) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			} else{
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}
			
			jObject.put("id", department.getDbid());
			jObject.put("name", department.getName());
			jObject.put("open", true);
			jObject.put("children", makeJSONChildren(children));
			return jObject;
		} else {
			if (department.getParent() != null&&department.getParent().getDbid()>0) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}
			jObject.put("id", department.getDbid());
			jObject.put("name", department.getName());
			jObject.put("children", "");
			return jObject;
		}
	}
	/**
	 * 将部门数据生成可以编辑的JSON格式
	 * **/
	private JSONArray makeJSONChildren(List<Department> children)throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (Department department : children) {
			JSONObject subJSONjObject = makeJSONObject(department);
			jsonArray.put(subJSONjObject);
		}
		return jsonArray;
	}
	/**
	 *功能描述： 将传入的对象转化为JSON数据格式
	 * 部门树：根节点，具有子结构节点，子节点
	 * @throws JSONException
	 */
	private JSONObject makeJSONSuperObject(Department department) throws JSONException {
		JSONObject jObject = new JSONObject();
		List<Department> children = departmentManageImpl.find("from Department where parent.dbid=?  order by suqNo",	new Object[] { department.getDbid()});
		if (null != children && children.size() > 0) {// 如果子部门不空
			if (department.getParent() ==null) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/1_open.png");// 菜单阶段
				jObject.put("root", "root");
				jObject.put("open", true);
			} else{
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
				jObject.put("open", false);
			}
			
			jObject.put("id", department.getDbid());
			jObject.put("name", department.getName());
			jObject.put("children", makeJSONSuperChildren(children));
			return jObject;
		} else {
			if (department.getParent() ==null) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/1_open.png");// 根节点
				jObject.put("root", "root");
			}else{
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}
			jObject.put("id", department.getDbid());
			jObject.put("name", department.getName());
			jObject.put("children", "");
			return jObject;
		}
	}
	/**
	 * 将部门数据生成可以编辑的JSON格式
	 * **/
	private JSONArray makeJSONSuperChildren(List<Department> children)throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (Department department : children) {
			JSONObject subJSONjObject = makeJSONSuperObject(department);
			jsonArray.put(subJSONjObject);
		}
		return jsonArray;
	}
	//////////////////////////////////////////////////////生成人员数/////////////////////////////////////////////////
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String departmentUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		try {
				Department department2 = departmentManageImpl.get(1);
				JSONObject userJson = getJsonUser(department2);
				System.out.println("======="+userJson.toString());
				request.setAttribute("userJson", userJson);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "departmentUser";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void updateUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		try {
			User parent = userManageImpl.get(parentId);
			User user = userManageImpl.get(dbid);
			user.setParent(parent);
			userManageImpl.save(user);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	private JSONObject getJsonUser(Department department2) throws JSONException{
		JSONObject jObject=new JSONObject();
		if (department2.getParent() ==null) {
			jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/1_open.png");// 根节点
			jObject.put("root", "root");
		}else{
			jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
		}
		jObject.put("id", department2.getDbid()+"d");
		jObject.put("name", department2.getName());
		jObject.put("open", true);
		JSONArray array2=new JSONArray();
		List<User> users = userManageImpl.find("from User where userState=1 and parent.dbid is null ",null);
		for (User user : users) {
			JSONObject makeJSONUser = makeJSONUser(user);
			array2.put(makeJSONUser);
		}
		jObject.put("children",array2);
		return jObject;
	}
	/**
	 *功能描述： 将传入的对象转化为JSON数据格式
	 * 部门树：根节点，具有子结构节点，子节点
	 * @throws JSONException
	 */
	private JSONObject makeJSONUser(User user) throws JSONException {
		JSONObject jObject = new JSONObject();
		List<User> children = userManageImpl.find("from User where parent.dbid=? and userState=1",	new Object[] {user.getDbid()});
		if (null != children && children.size() > 0) {// 如果子部门不空
			if (user.getParent() ==null) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			} else{
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}
			
			jObject.put("id", user.getDbid());
			jObject.put("name", user.getRealName());
			jObject.put("open", true);
			jObject.put("children", makeJSONUserChild(children));
			return jObject;
		} else {
			if (user.getParent() ==null) {
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}else{
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
			}
			jObject.put("id", user.getDbid());
			jObject.put("name", user.getRealName());
			jObject.put("children", "");
			return jObject;
		}
	}
	/**
	 * 将部门数据生成可以编辑的JSON格式
	 * **/
	private JSONArray makeJSONUserChild(List<User> children)throws JSONException {
		JSONArray jsonArray = new JSONArray();
		for (User user : children) {
			JSONObject subJSONjObject = makeJSONUser(user);
			jsonArray.put(subJSONjObject);
		}
		return jsonArray;
	}
}
