package com.ystech.cust.model;

// Generated 2014-2-27 15:28:43 by Hibernate Tools 4.0.0

/**
 * Infofrormdetail generated by hbm2java
 */
public class InfoFromDetail implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String note;
	private Integer enterpriseId;
	public InfoFromDetail() {
	}

	public InfoFromDetail(String name, String note) {
		this.name = name;
		this.note = note;
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

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
}