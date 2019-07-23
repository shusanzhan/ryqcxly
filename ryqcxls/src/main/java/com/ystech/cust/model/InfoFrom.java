package com.ystech.cust.model;

import com.ystech.xwqr.set.model.Brand;

// Generated 2014-2-18 21:01:08 by Hibernate Tools 4.0.0

/**
 * Constellation generated by hbm2java
 */
public class InfoFrom implements java.io.Serializable {
	public static final int SELFNO=1;
	public static final int SELFYES=2;
	private Integer dbid;
	private String name;
	//品牌
	private Brand brand;
	//是否自由点
	private Integer self;
	//类型分类
	private String type;
	
	private String note;
	private Integer enterpriseId;
	public InfoFrom() {
	}

	public InfoFrom(String name, String note) {
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

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Integer getSelf() {
		return self;
	}

	public void setSelf(Integer self) {
		this.self = self;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	

}