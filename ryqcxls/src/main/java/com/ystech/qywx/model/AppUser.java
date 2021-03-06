package com.ystech.qywx.model;

// Generated 2016-5-31 17:18:22 by Hibernate Tools 4.0.0

import java.util.Date;

import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

/**
 * QywxAppuser generated by hbm2java
 */
public class AppUser implements java.io.Serializable {
	public static Integer STATUSCOMM=1;
	public static Integer STATUSSYN=2;

	private Integer dbid;
	private User user;
	private Enterprise enterprise;
	private Date createDate;
	private Date modifyDate;
	private App app;
	private String openId;
	private String redBagAppId;
	//是否通过userid转换成openid接口：1、为默认；2、已结转换
	private Integer status;

	public AppUser() {
	}

	public AppUser(Integer userId, Integer enterpriseId, Date createDate,
			Date modifyDate, Integer appId) {
		this.createDate = createDate;
		this.modifyDate = modifyDate;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}


	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return this.modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public App getApp() {
		return app;
	}

	public void setApp(App app) {
		this.app = app;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getRedBagAppId() {
		return redBagAppId;
	}

	public void setRedBagAppId(String redBagAppId) {
		this.redBagAppId = redBagAppId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	


}
