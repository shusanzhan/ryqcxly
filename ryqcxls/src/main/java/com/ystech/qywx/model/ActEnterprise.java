package com.ystech.qywx.model;

// Generated 2016-7-26 10:40:22 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * QywxActenterprise generated by hbm2java
 */
public class ActEnterprise implements java.io.Serializable {
	public static Integer COMM=1;
	public static Integer STOP=2;
	private Integer dbid;
	private Act act;
	private String name;
	private String note;
	private Date createDate;
	private Date modifyDate;
	//是否启用上下级 发红包权限
	private Integer levelStatus;
	//是否启用、停用
	private Integer ssStatus;
	private Integer enterpriseId;
	private String wishing;
	private String remark;

	public ActEnterprise() {
	}

	public ActEnterprise(int dbid) {
		this.dbid = dbid;
	}

	public ActEnterprise(int dbid, Act qywxAct, String name,
			String note, Date createDate, Date modifyDate, Integer enterpriseId) {
		this.dbid = dbid;
		this.name = name;
		this.note = note;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.enterpriseId = enterpriseId;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
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

	public Integer getEnterpriseId() {
		return this.enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Act getAct() {
		return act;
	}

	public void setAct(Act act) {
		this.act = act;
	}

	public Integer getLevelStatus() {
		return levelStatus;
	}

	public void setLevelStatus(Integer levelStatus) {
		this.levelStatus = levelStatus;
	}

	public Integer getSsStatus() {
		return ssStatus;
	}

	public void setSsStatus(Integer ssStatus) {
		this.ssStatus = ssStatus;
	}

	public String getWishing() {
		return wishing;
	}

	public void setWishing(String wishing) {
		this.wishing = wishing;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
