package com.ystech.cust.model;

// Generated 2014-2-18 19:25:28 by Hibernate Tools 4.0.0

/**
 * Nation generated by hbm2java
 */
public class Nation implements java.io.Serializable {

	private Integer dbid;
	private String name;

	public Nation() {
	}

	public Nation(String name) {
		this.name = name;
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

}
