package com.ystech.agent.model;

import java.util.Date;

// Generated 2013-1-5 19:21:45 by Hibernate Tools 4.0.0

/**
 * Verificationcode generated by hbm2java
 */
public class VerificationCode implements java.io.Serializable {

	private Integer dbid;
	private String mobile;
	private String verificationCode;
	private Date createTime;

	public VerificationCode() {
	}

	public VerificationCode(String mobile, String verificationCode) {
		this.mobile = mobile;
		this.verificationCode = verificationCode;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getVerificationCode() {
		return this.verificationCode;
	}

	public void setVerificationCode(String verificationCode) {
		this.verificationCode = verificationCode;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}