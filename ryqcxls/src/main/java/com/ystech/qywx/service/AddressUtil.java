package com.ystech.qywx.service;

import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.qywx.core.ErrorMessage;
import com.ystech.qywx.core.ErrorMessageUtil;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("addressUtil")
public class AddressUtil  {
	private AccessTokenManageImpl accessTokenManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private UserManageImpl userManageImpl;
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	 * 功能描述：同步用户资料指微信平台
	 * @param user
	 * @return
	 */
	public  boolean synUser(){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			//创建用户列表
			List<User>  createusers= userManageImpl.executeSql("select * from sys_user where wechatId is not null and userState=1 AND adminType=2 and wechatId!='' and sysWeixinStatus="+User.SYNCOMM, null);
			//更新用户列表
			List<User>  updateusers= userManageImpl.executeSql("select * from sys_user where wechatId is not null and userState=1 AND adminType=2 and wechatId!='' and sysWeixinStatus="+User.SYNYYES, null);
			if(null!=createusers&&createusers.size()>0){
				String user_create_url = QywxUtil.user_create_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
				for (User user : createusers) {
					boolean createUserUrl = createUserUrl(user, user_create_url);
					if(createUserUrl==false){
						System.out.println("用户："+user.getRealName()+",创建失败！");
					}
				}
			}
			if(null!=updateusers&&updateusers.size()>0){
				String user_update_url = QywxUtil.user_update_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
				for (User user : updateusers) {
					boolean updateUserUrl = updateUserUrl(user, user_update_url);
					if(updateUserUrl==false){
						System.out.println("用户："+user.getRealName()+",更新失败！");
					}
				}
			}
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 功能描述：创建用户
	 * @param user
	 * @return
	 */
	public  boolean createUser(User user){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.user_create_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String josnUser = josnUser(user);
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", josnUser);
			System.out.println("====="+httpRequest.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					user.setSysWeixinStatus(User.SYNYYES);
					userManageImpl.save(user);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * 功能描述：创建用户
	 * @param user
	 * @return
	 */
	public  boolean createUserUrl(User user,String user_create_url){
		try {
			String josnUser = josnUser(user);
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", josnUser);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					user.setSysWeixinStatus(User.SYNYYES);
					userManageImpl.save(user);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * 功能描述：更新用户资料
	 * @param user
	 * @return
	 */
	public  boolean updateUser(User user){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_update_url = QywxUtil.user_update_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String josnUser = josnUser(user);
			JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "POST", josnUser);
			System.err.println("========="+httpRequest.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					user.setSysWeixinStatus(User.SYNYYES);
					userManageImpl.save(user);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * 功能描述：更新用户资料
	 * @param user
	 * @return
	 */
	public  boolean updateUserUrl(User user,String user_update_url){
		try {
			String josnUser = josnUser(user);
			JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "POST", josnUser);
			System.err.println("==========="+httpRequest.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					user.setSysWeixinStatus(User.SYNYYES);
					userManageImpl.save(user);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * 功能描述：停用用户资料
	 * @param user
	 * @return
	 */
	public  boolean stopUser(User user){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_update_url = QywxUtil.user_update_url.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			String josnUser = josnUser(user);
			JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "POST", josnUser);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					user.setAttentionStatus(User.ATTATONSTOP);
					userManageImpl.save(user);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
			return false;
		}
	}
	/**
	 * 功能描述：更新用户资料(同步用户关注状态）
	 * @param user
	 * @return
	 */
	public  User getUser(User user){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_update_url = QywxUtil.user_get_url.replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("USERID","R"+user.getUserId());
			JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "GET", null);
			if(null!=httpRequest){
				if(null!=httpRequest){
					ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
					if(errorMessage.getErrcode().equals("0")){
						Integer status = (Integer)httpRequest.get("status");
						//关注
						if(status==1){
							user.setAttentionStatus(User.ATTATIONED);
						}
						//禁用
						if(status==2){
							user.setAttentionStatus(User.ATTATONSTOP);
						}
						//未关注
						if(status==4){
							user.setAttentionStatus(User.ATTATIONSTATUSDEFUAL);
						}
						userManageImpl.save(user);
						return user;
					}else{
						return null;
					}
				}else{
					return null;
				}
			}
		}catch (Exception e) {
			return null;
		}
		return null;
	}
	/**
	 * 功能描述：同步用户的关注状态
	 * @param user
	 * @return
	 */
	public  boolean synDataUserAttention(){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String hql="select * from sys_user where 1=1 ";
			hql=hql+" and userState=1";
			List<User> users = userManageImpl.executeSql(hql, null);
			if(null!=users&&users.size()>0){
				int i=0;
				for (User user2 : users) {
					i++;
					String user_update_url = QywxUtil.user_get_url.replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("USERID", "R"+user2.getUserId());
					JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "GET", null);
					if(null!=httpRequest){
						if(null!=httpRequest){
							ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
							if(errorMessage.getErrcode().equals("0")){
								Integer status = (Integer)httpRequest.get("status");
								//关注
								if(status==1){
									user2.setAttentionStatus(User.ATTATIONED);
								}
								//禁用
								if(status==2){
									user2.setAttentionStatus(User.ATTATONSTOP);
								}
								//未关注
								if(status==4){
									user2.setAttentionStatus(User.ATTATIONSTATUSDEFUAL);
								}
								userManageImpl.save(user2);
							}else{
								System.err.println(i+"号用户"+user2.getRealName()+":同步关注用户失败");
							}
						}else{
							System.err.println(i+"号用户"+user2.getRealName()+":同步关注用户失败");
						}
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 功能描述：删除用户资料
	 * @param user
	 * @return
	 */
	public  boolean deleteUser(User user){
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_update_url = QywxUtil.user_delete_url.replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("USERID", "R"+user.getUserId());
			JSONObject httpRequest = QywxUtil.httpRequest(user_update_url, "GET", null);
			if(null!=httpRequest){
				if(null!=httpRequest){
					ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
					if(errorMessage.getErrcode().equals("0")){
						return true;
					}
				}
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 功能描述：用户转换为json字符串
	 * @param user
	 * @return
	 */
	private String josnUser(User user){
		if(null!=user){
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("userid","R"+user.getUserId());
			jsonObject.put("name", user.getRealName());
			if(null!=user.getDepartment()){
				jsonObject.put("department","["+user.getDepartment().getDbid()+"]");
			}
			jsonObject.put("mobile", user.getMobilePhone());
			jsonObject.put("position", user.getPositionNames());
			jsonObject.put("email", user.getEmail());
			String sex = user.getSex();
			if(null!=sex){
				if(sex=="男"){
					jsonObject.put("gender", "1");
				}
				if(sex=="女"){
					jsonObject.put("gender", "2");
				}
			}else{
				jsonObject.put("gender", "1");
			}
			//用户是否已经停用
			Integer userState = user.getUserState();
			//启用状态
			if(userState==1){
				jsonObject.put("enable", 1);
			}
			//停用状态
			if(userState==2){
				jsonObject.put("enable", 0);
			}
			jsonObject.put("weixinid", user.getWechatId());
			return jsonObject.toString();
		}
		return null;
	}
}
