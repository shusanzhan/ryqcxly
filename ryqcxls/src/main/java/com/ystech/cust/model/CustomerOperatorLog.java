package com.ystech.cust.model;

// Generated 2016-4-6 11:11:00 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Customeroperatorlog generated by hbm2java
 */
public class CustomerOperatorLog implements java.io.Serializable {

	private Integer dbid;
	private String type;
	private String note;
	private String operator;
	private Date operateDate;
	private Integer customerId;

	public CustomerOperatorLog() {
	}

	public CustomerOperatorLog(String type, String note, String operator,
			Date operateDate, Integer factoryId) {
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

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

}