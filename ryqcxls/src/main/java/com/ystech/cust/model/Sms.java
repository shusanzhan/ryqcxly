package com.ystech.cust.model;

// Generated 2014-7-26 17:16:01 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Sms generated by hbm2java
 */
public class Sms implements java.io.Serializable {

	private Integer dbid;
	private String sendPersonName;
	private Integer userId;
	private String mobilePhone;
	private String customerName;
	private String content;
	private Integer sendStatus;
	private Date createTime;
	private Date modifyTime;

	public Sms() {
	}

	public Sms(String sendPersonName, String mobilePhone, String content,
			Integer sendStatus, Date createTime, Date modifyTime) {
		this.sendPersonName = sendPersonName;
		this.mobilePhone = mobilePhone;
		this.content = content;
		this.sendStatus = sendStatus;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getSendPersonName() {
		return this.sendPersonName;
	}

	public void setSendPersonName(String sendPersonName) {
		this.sendPersonName = sendPersonName;
	}

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getSendStatus() {
		return this.sendStatus;
	}

	public void setSendStatus(Integer sendStatus) {
		this.sendStatus = sendStatus;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

}
