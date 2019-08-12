package com.ystech.qywx.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.qywx.core.ErrorMessage;
import com.ystech.qywx.core.ErrorMessageUtil;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;

@Component("departmentWexinUtil")
public class DepartmentWexinUtil {
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	/**
	 * 功能描述：创建微信数据
	 * @param department
	 * @return
	 */
	public  boolean createDepartment(Department department){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String department_create_url = QywxUtil.department_create_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String josnDepartment = getDepartmentJson(department);
			JSONObject httpRequest = QywxUtil.httpRequest(department_create_url, "POST", josnDepartment);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
			// TODO: handle exception
		}
	}
	/**
	 * 功能描述：创建微信数据
	 * @param department
	 * @return
	 */
	public  boolean createDepartmentBatch(Department department,String department_create_url){
		try {
			String josnDepartment = getDepartmentJson(department);
			JSONObject httpRequest = QywxUtil.httpRequest(department_create_url, "POST", josnDepartment);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
			// TODO: handle exception
		}
	}
	/**
	 * 功能描述：更新微信企业号部门数据
	 * @param department
	 * @return
	 */
	public  boolean updateDepartment(Department department){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String department_update_url = QywxUtil.department_update_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String josnDepartment = getDepartmentJson(department);
			JSONObject httpRequest = QywxUtil.httpRequest(department_update_url, "POST", josnDepartment);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	/**
	 * 功能描述：更新微信企业号部门数据
	 * @param department
	 * @return
	 */
	public  boolean updateDepartmentBatch(Department department,String department_update_url){
		try {
			String josnDepartment = getDepartmentJson(department);
			JSONObject httpRequest = QywxUtil.httpRequest(department_update_url, "POST", josnDepartment);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	/**
	 * 功能描述：更新微信企业号部门数据
	 * @param department
	 * @return
	 */
	public  boolean deleteDepartment(Department department){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String department_delete_url = QywxUtil.department_delete_url.replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("ID",department.getDbid()+"");
			JSONObject httpRequest = QywxUtil.httpRequest(department_delete_url, "GET", null);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	/**
	 * 功能描述：获取微信端部门数据
	 * @return
	 */
	public List<Department> getList(){
		try {
			List<Department> departments=new ArrayList<Department>();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String department_list_url = QywxUtil.department_list_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			JSONObject httpRequest = QywxUtil.httpRequest(department_list_url, "GET", null);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					JSONArray jsonArray = httpRequest.getJSONArray("department");
					for (Object object : jsonArray) {
						JSONObject jsonObject=(JSONObject) object;
						Department department=new Department();
						department.setDbid(jsonObject.getInt("id"));
						department.setName(jsonObject.getString("name"));
						department.setParentId(jsonObject.getInt("parentid"));
						department.setSuqNo(jsonObject.getInt("order"));
						departments.add(department);
					}
					return departments;
				}else{
					return null;
				}
			}else{
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	/**
	 * 同步部门数据
	 * @return
	 */
	public boolean synDepartment(){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			List<Department> remoteDepartments=new ArrayList<Department>();
			List<Department> localDepartments=new ArrayList<Department>();
			//第一步获取微信平台的部门列表
			List<Department> departments = getList();
			//本地数据
			List<Department> departments2 = departmentManageImpl.getAll();
			//第二步：对比数据
			compareDep(departments,departments2,remoteDepartments,localDepartments);
			//第三部：已有数据进行更新
			if(remoteDepartments.size()>0){
				String department_update_url = QywxUtil.department_update_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
				for (Department department : departments2) {
					boolean status = updateDepartmentBatch(department,department_update_url);
					if(status==false){
						System.err.println("部门："+department.getDbid()+",部门名称："+department.getName()+",更新数据失败");
					}
				}
			}
			//第四百：无数据的进行创建
			if(localDepartments.size()>0){
				String department_update_url = QywxUtil.department_create_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
				for (Department department : localDepartments) {
					boolean status = createDepartmentBatch(department,department_update_url);
					if(status==false){
						System.err.println("部门："+department.getDbid()+",部门名称："+department.getName()+",创建数据失败");
					}
				}
			}
			return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	/**
	 * 功能描述：对比远程数据和本地数据差异，并记录下差异数据
	 * @param redepartments
	 * @param lodepartments2
	 * @param remoteDepartments
	 * @param localDepartments
	 */
	private void compareDep(List<Department> redepartments,
			List<Department> lodepartments2, List<Department> remoteDepartments,
			List<Department> localDepartments) {
		if(null!=redepartments&&redepartments.size()>0){
			for (Department department : lodepartments2) {
				boolean status=false;
				for (Department department2 : redepartments) {
					if(department.getDbid()==(int)department2.getDbid()){
						status=true;
						break;
					}
				}
				if(status==false){
					localDepartments.add(department);
				}
				if(status==true){
					remoteDepartments.add(department);
				}
			}
		}else{
			for (Department department : lodepartments2) {
				localDepartments.add(department);
			}
		}
	}
	/**
	 * 功能描述：部门信息转为json
	 * @param department
	 * @return
	 */
	private String getDepartmentJson(Department department){
		if(null!=department){
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("id", department.getDbid());
			jsonObject.put("name", department.getName());
			if(null!=department.getParentId()&&department.getParentId()>0){
				jsonObject.put("parentid",department.getParentId());
			}
			else{
				jsonObject.put("parentid",1);
			}
			jsonObject.put("order", department.getSuqNo());
			return jsonObject.toString();
		}
		return null;
	}
}
