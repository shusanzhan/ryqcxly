package com.ystech.xwqr.set.model;

// Generated 2015-1-9 9:56:39 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * SetChargeitem generated by hbm2java
 */
public class ChargeItem implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private Integer netTowType;
	private Integer orderNum;
	private String note;
	private Date createDate;
	private Date modifyDate;
	private String jym;
	private Integer defaultPrice;

	public ChargeItem() {
	}

	public ChargeItem(String name, Integer orderNum, String note,
			Date createDate, Date modifyDate) {
		this.name = name;
		this.orderNum = orderNum;
		this.note = note;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
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

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
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

	public Integer getNetTowType() {
		return netTowType;
	}

	public void setNetTowType(Integer netTowType) {
		this.netTowType = netTowType;
	}

	public String getJym() {
		return jym;
	}

	public void setJym(String jym) {
		this.jym = jym;
	}

	public Integer getDefaultPrice() {
		return defaultPrice;
	}

	public void setDefaultPrice(Integer defaultPrice) {
		this.defaultPrice = defaultPrice;
	}
	
}
