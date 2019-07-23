package com.ystech.cust.model;

import com.ystech.xwqr.set.model.Brand;

// Generated 2014-2-18 19:48:26 by Hibernate Tools 4.0.0

/**
 * Industry generated by hbm2java
 */
public class Industry implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private Brand brand;
	private String note;

	public Industry() {
	}

	public Industry(String name, String note) {
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
	
}
