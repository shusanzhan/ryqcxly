package com.ystech.mem.model;
// Generated 2015-12-20 12:48:42 by Hibernate Tools 4.0.0.Final

/**
 * PllmSSpreadgroup generated by hbm2java
 */
public class SpreadGroup implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String note;
	private Spread spread;

	public SpreadGroup() {
	}

	public SpreadGroup(String name, String note, Integer spreadId) {
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

	public Spread getSpread() {
		return spread;
	}

	public void setSpread(Spread spread) {
		this.spread = spread;
	}


}
