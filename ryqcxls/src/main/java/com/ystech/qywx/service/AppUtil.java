package com.ystech.qywx.service;

import java.util.ArrayList;
import java.util.Date;
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
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.AppDepartment;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("appUtil")
public class AppUtil {
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private UserManageImpl userManageImpl;
	private AppManageImpl appManageImpl;
	private AppUserManageImpl appUserManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private AppDepartmentManageImpl appDepartmentManageImpl;
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
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setAppDepartmentManageImpl(
			AppDepartmentManageImpl appDepartmentManageImpl) {
		this.appDepartmentManageImpl = appDepartmentManageImpl;
	}
	/**
	 * 功能描述：同步用户资料指微信平台
	 * @param user
	 * @return
	 */
	public  boolean updateApp(){
		try {
			List<App> list = getList();
			if(null!=list&&list.size()>0){
				for (App app : list) {
					App app2 = appManageImpl.findUniqueBy("appId", app.getAppId());
					if(null!=app2){
						app2.setName(app.getName());
						app2.setRound_logo_url(app.getRound_logo_url());
						app2.setSquare_logo_url(app.getSquare_logo_url());
						appManageImpl.save(app2);
					}else{
						appManageImpl.save(app);
					}
				}
			}
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	private List<App> getList(){
		List<App> apps=new ArrayList<App>();
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String agent_list_url = QywxUtil.agent_list_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			JSONObject httpRequest = QywxUtil.httpRequest(agent_list_url, "GET", null);
			System.out.println("erro+++++"+httpRequest.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					JSONArray jsonArray = httpRequest.getJSONArray("agentlist");
					for (Object object : jsonArray) {
						App app=new App();
						JSONObject jsonObject= (JSONObject) object;
						app.setAppId(jsonObject.getInt("agentid"));
						app.setName(jsonObject.getString("name"));
						app.setSquare_logo_url(jsonObject.getString("square_logo_url"));
						//app.setRound_logo_url(jsonObject.getString("round_logo_url"));
						apps.add(app);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return apps;
	}
	/**
	 * 功能描述：创建和更新数据
	 * @return
	 */
	public  boolean createOrUpdateUser(){
		try {
			List<App> localAppList = getLocalAppList();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			for (App app : localAppList) {
				String agent_get_url = QywxUtil.agent_get_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
				agent_get_url=agent_get_url.replace("AGENTID", app.getAppId()+"");
				JSONObject jsonObject = QywxUtil.httpRequest(agent_get_url, "GET", null);
				System.out.println("agentId:"+app.getAppId()+" ===========jsoBje:"+jsonObject.toString());
				if(null!=jsonObject){
					ErrorMessage paraseErrorMessage = ErrorMessageUtil.paraseErrorMessage(jsonObject);
					if(paraseErrorMessage.getErrcode().equals("0")){
						//创建用户
						createAppUser(app, jsonObject);
						
						//创建部门数据
						createAppDepartment(app, jsonObject);
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
	 * 功能描述：创建用户数据
	 * @param app
	 * @param jsonObject
	 */
	private void createAppUser(App app,JSONObject jsonObject){
		JSONObject jsonObject2 = jsonObject.getJSONObject("allow_userinfos");
		JSONArray userJsonArray = jsonObject2.getJSONArray("user");
		try {
			if(null!=userJsonArray){
				for (Object object : userJsonArray) {
					 JSONObject userObj= (JSONObject) object;
					 String userid = (String) userObj.get("userid");
					 AppUser appUser2 = appUserManageImpl.findUnique("from AppUser where user.userId=? and app.dbid=? ",new Object[]{userid,app.getDbid()});
					 if(null!=appUser2){
						 appUser2.setApp(app);
						 appUser2.setModifyDate(new Date());
						 appUserManageImpl.save(appUser2);
					 }else{
						 User user = userManageImpl.findUniqueBy("userId", userid);
						 if(null!=user){
							 AppUser appUser=new AppUser();
							 appUser.setEnterprise(user.getEnterprise());
							 appUser.setApp(app);
							 appUser.setUser(user);
							 appUser.setCreateDate(new Date());
							 appUser.setModifyDate(new Date());
							 appUser.setStatus(AppUser.STATUSCOMM);
							 appUserManageImpl.save(appUser);
						 }
					 }
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：创建应用部门数据
	 * @param app
	 * @param jsonObject
	 */
	private void createAppDepartment(App app,JSONObject jsonObject){
		JSONObject jsonObject2 = jsonObject.getJSONObject("allow_partys");
		try {
			String partyids = jsonObject2.getString("partyid");
			System.out.println("===============appId:"+app.getDbid()+" partyids: "+partyids);
			if(null!=partyids&&partyids.trim().length()>0){
				partyids=partyids.replace("[", "").replace("]", "");
				String[] partIds = partyids.split(",");
				if(null!=partIds&&partIds.length>0){
					for (String depId : partIds) {
						if(null!=depId&&depId.trim().length()>0){
							int departmentId = Integer.parseInt(depId);
							AppDepartment appDepartment = appDepartmentManageImpl.findUnique("from AppDepartment where department.dbid=? and app.dbid=? ",new Object[]{departmentId,app.getDbid()});
							if(null!=appDepartment){
								appDepartment.setModifyDate(new Date());
								appDepartmentManageImpl.save(appDepartment);
							}else{
								AppDepartment appDepartment2=new AppDepartment();
								Department department = departmentManageImpl.get(departmentId);
								appDepartment2.setApp(app);
								appDepartment2.setCreateDate(new Date());
								appDepartment2.setDepartment(department);
								appDepartment2.setModifyDate(new Date());
								appDepartment2.setEnterprise(department.getEnterprise());
								appDepartmentManageImpl.save(appDepartment2);
							}
						}
					}
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：获取本地应用列表
	 * @return
	 */
	private List<App> getLocalAppList(){
		List<App> apps = appManageImpl.getAll();
		return apps;
	}
}
