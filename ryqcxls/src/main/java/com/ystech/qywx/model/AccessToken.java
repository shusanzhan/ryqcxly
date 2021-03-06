package com.ystech.qywx.model;

// Generated 2015-2-13 17:49:08 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * QywxAccesstoken generated by hbm2java
 */
public class AccessToken implements java.io.Serializable {

	private Integer dbid;
	private String accessToken;
	private Date addtime;
	private Integer expiresIn;
	private String jsapiTicket;
	private Integer appId;

	public AccessToken() {
	}

	public AccessToken(String accessToken, Date addtime, Integer expiresIn) {
		this.accessToken = accessToken;
		this.addtime = addtime;
		this.expiresIn = expiresIn;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getAccessToken() {
		return this.accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public Date getAddtime() {
		return this.addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public Integer getExpiresIn() {
		return this.expiresIn;
	}

	public void setExpiresIn(Integer expiresIn) {
		this.expiresIn = expiresIn;
	}

	public String getJsapiTicket() {
		return jsapiTicket;
	}

	public void setJsapiTicket(String jsapiTicket) {
		this.jsapiTicket = jsapiTicket;
	}

	public Integer getAppId() {
		return appId;
	}

	public void setAppId(Integer appId) {
		this.appId = appId;
	}
	
}
