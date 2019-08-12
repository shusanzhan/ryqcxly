package com.ystech.cust.model;

// Generated 2014-5-12 9:48:35 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Turncustomerrecord generated by hbm2java
 */
public class TurnCustomerRecord implements java.io.Serializable {

	private Integer dbid;
	private String customerIds;
	private String customerName;
	//原来销售人员
	private Integer reBussiStaffId;
	private String reBussiStaff;
	//目标销售人员
	private Integer tarBussiStaffId;
	private String tarBussiStaff;
	private Date createTime;
	private String note;
	private Integer operatorId;
	private String operatorName;

	public TurnCustomerRecord() {
	}

	public TurnCustomerRecord(String customerIds, String customerName,
			String reBuf, String bu, Date createTime, String note,
			Integer operatorId, String operatorName) {
		this.customerIds = customerIds;
		this.customerName = customerName;
		this.createTime = createTime;
		this.note = note;
		this.operatorId = operatorId;
		this.operatorName = operatorName;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getCustomerIds() {
		return this.customerIds;
	}

	public void setCustomerIds(String customerIds) {
		this.customerIds = customerIds;
	}

	public String getCustomerName() {
		return this.customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}


	public String getReBussiStaff() {
		return reBussiStaff;
	}

	public void setReBussiStaff(String reBussiStaff) {
		this.reBussiStaff = reBussiStaff;
	}

	public String getTarBussiStaff() {
		return tarBussiStaff;
	}

	public void setTarBussiStaff(String tarBussiStaff) {
		this.tarBussiStaff = tarBussiStaff;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getOperatorId() {
		return this.operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Integer getReBussiStaffId() {
		return reBussiStaffId;
	}

	public void setReBussiStaffId(Integer reBussiStaffId) {
		this.reBussiStaffId = reBussiStaffId;
	}

	public Integer getTarBussiStaffId() {
		return tarBussiStaffId;
	}

	public void setTarBussiStaffId(Integer tarBussiStaffId) {
		this.tarBussiStaffId = tarBussiStaffId;
	}
	
}
