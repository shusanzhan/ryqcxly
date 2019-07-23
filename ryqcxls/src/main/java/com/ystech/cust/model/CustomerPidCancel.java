package com.ystech.cust.model;

// Generated 2014-5-31 14:45:03 by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Customerpidcancel generated by hbm2java
 */
public class CustomerPidCancel implements java.io.Serializable {

	private Integer dbid;
	private String note;
	private Date createDate;
	private CustomerPidBookingRecord customerPidBookingRecord;
	private Set approvalRecordPidBookingRecords = new HashSet(0);
	public CustomerPidCancel() {
	}

	public CustomerPidCancel(Integer customerPid, String note, Date createDate) {
		this.note = note;
		this.createDate = createDate;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
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

	public CustomerPidBookingRecord getCustomerPidBookingRecord() {
		return customerPidBookingRecord;
	}

	public void setCustomerPidBookingRecord(
			CustomerPidBookingRecord customerPidBookingRecord) {
		this.customerPidBookingRecord = customerPidBookingRecord;
	}

	public Set getApprovalRecordPidBookingRecords() {
		return approvalRecordPidBookingRecords;
	}

	public void setApprovalRecordPidBookingRecords(
			Set approvalRecordPidBookingRecords) {
		this.approvalRecordPidBookingRecords = approvalRecordPidBookingRecords;
	}


}