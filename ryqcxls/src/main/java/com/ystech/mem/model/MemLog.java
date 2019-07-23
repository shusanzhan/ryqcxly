package com.ystech.mem.model;

// Generated 2016-2-29 10:22:00 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * FinOperatorlog generated by hbm2java
 */
public class MemLog implements java.io.Serializable {

	private Integer dbid;
	private String type;
	private String note;
	private String operator;
	private Date operateDate;
	private Integer memberId;

	public MemLog() {
	}

	public MemLog(String type, String note, String operator,
			Date operateDate, Integer finCustomerId) {
		this.type = type;
		this.note = note;
		this.operator = operator;
		this.operateDate = operateDate;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getOperator() {
		return this.operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Date getOperateDate() {
		return this.operateDate;
	}

	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}



}
