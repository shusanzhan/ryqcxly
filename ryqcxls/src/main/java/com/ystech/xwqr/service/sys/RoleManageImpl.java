package com.ystech.xwqr.service.sys;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.core.ErrorMessage;
import com.ystech.qywx.core.ErrorMessageUtil;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.xwqr.model.sys.Role;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.TagRole;
import com.ystech.xwqr.model.sys.TagRoleUser;
import com.ystech.xwqr.model.sys.User;
@Component("roleManageImpl")
public class RoleManageImpl extends HibernateEntityDao<Role>{
	protected Logger log = Logger.getLogger(BaseController.class);
	
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private SystemInfoMangeImpl  systemInfoMangeImpl;
	
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	/**
	 * 保存角色
	 */
	public void saveRole(Role role){
		Integer dbid = role.getDbid();
		if(dbid==null){
			role.setCreateTime(new Date());
			role.setModifyTime(new Date());
			save(role);
		}else{
			Role role2 = get(dbid);
			role2.setModifyTime(new Date());
			role2.setName(role.getName());
			role2.setRoleType(role.getRoleType());
			role2.setState(role.getState());
			save(role2);
		}
		//同步
		boolean synQywx = systemInfoMangeImpl.isSynQywx();
		if(synQywx){
			if(dbid==null){
				createTag(role);
			}
			else{
				//createTag(role);
				updateTag(role);
			}
		}
	}
	/**
	 * 功能描述：删除标签
	 * @param roleId
	 */
	public void deleteById(int roleId){
		Role role = get(roleId);
		delete(role);
		//同步
		boolean synQywx = systemInfoMangeImpl.isSynQywx();
		if(synQywx){
			deleteTag(role);
		}
	}
	/**
	 * 功能描述：创建角色-标签到企业微信
	 * @param role
	 * @return
	 */
	private boolean createTag(Role role){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.tag_create.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			TagRole tagRole=new TagRole(role);
			JSONObject fromObject = JSONObject.fromObject(tagRole);
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", fromObject.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					role.setSysWeixinStatus(User.SYNYYES);
					save(role);
					return true;
				}else{
					log.error("role to tag create 失败，接口发生异常，异常内容："+errorMessage.getErrmsg());
					return false;
				}
			}else{
				log.error("role to tag create 失败，接口发生异常，异常内容null ");
				return false;
			}
		} catch (Exception e) {
			log.error("role to tag create 失败，系统抛出异常");
			return false;
		}
	}
	/**
	 * 功能描述：更改角色-标签到企业微信
	 * @param role
	 * @return
	 */
	private boolean updateTag(Role role){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.tag_update.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			TagRole tagRole=new TagRole(role);
			JSONObject fromObject = JSONObject.fromObject(tagRole);
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", fromObject.toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					log.error("role to tag update 失败，接口发生异常，异常内容："+errorMessage.getErrmsg());
					return false;
				}
			}else{
				log.error("role to tag update 失败，接口发生异常，异常内容null ");
				return false;
			}
		} catch (Exception e) {
			log.error("role to tag update 失败，系统抛出异常");
			return false;
		}
	}
	/**
	 * 功能描述：删除角色-标签到企业微信
	 * @param role
	 * @return
	 */
	private boolean deleteTag(Role role){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.tag_delete.replace("ACCESS_TOKEN", accessToken.getAccessToken()).replace("TAGID",role.getDbid()+"");
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", null);
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					log.error("role to tag update 失败，接口发生异常，异常内容："+errorMessage.getErrmsg());
					return false;
				}
			}else{
				log.error("role to tag update 失败，接口发生异常，异常内容null ");
				return false;
			}
		} catch (Exception e) {
			log.error("role to tag update 失败，系统抛出异常");
			return false;
		}
	}
	/**
	 * 功能描述：同步角色-标签-用户
	 * @param role
	 * @param users
	 * @return
	 */
	public boolean addTagUsers(Role role,List<User> users){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.tag_addtagusers.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			TagRoleUser tagRoleUser=new TagRoleUser(role, users);
			System.out.println("JSON:"+JSONObject.fromObject(tagRoleUser).toString());
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", JSONObject.fromObject(tagRoleUser).toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					log.error("role to tag update 失败，接口发生异常，异常内容："+errorMessage.getErrmsg());
					return false;
				}
			}else{
				log.error("role to tag update 失败，接口发生异常，异常内容null ");
				return false;
			}
		} catch (Exception e) {
			log.error("role to tag update 失败，系统抛出异常");
			return false;
		}
	}
	/**
	 * 功能描述：同步角色-标签-用户
	 * @param role
	 * @param users
	 * @return
	 */
	public boolean delTagUsers(Role role,List<User> users){
		try {
			QywxAccount qywxAccount = qywxAccountManageImpl.findUnique("from QywxAccount", null);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(), qywxAccount.getSecurity(),qywxAccount.getAppId());
			String user_create_url = QywxUtil.tag_addtagusers.replace("ACCESS_TOKEN", accessToken.getAccessToken());
			TagRoleUser tagRoleUser=new TagRoleUser(role, users);
			JSONObject httpRequest = QywxUtil.httpRequest(user_create_url, "POST", JSONObject.fromObject(tagRoleUser).toString());
			if(null!=httpRequest){
				ErrorMessage errorMessage = ErrorMessageUtil.paraseErrorMessage(httpRequest);
				if(errorMessage.getErrcode().equals("0")){
					return true;
				}else{
					log.error("role to tag update 失败，接口发生异常，异常内容："+errorMessage.getErrmsg());
					return false;
				}
			}else{
				log.error("role to tag update 失败，接口发生异常，异常内容null ");
				return false;
			}
		} catch (Exception e) {
			log.error("role to tag update 失败，系统抛出异常");
			return false;
		}
	}
	
}
