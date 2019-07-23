package com.ystech.cust.model;

import java.util.Date;

public class CustomerRecordSet implements java.io.Serializable {
	private Integer dbid;
	private Date createDate;
	private Date modifyDate;
	//续保强制险返利
	private Integer hour;
	private Integer enterpriseId;
	private String note;
	public CustomerRecordSet(){
		
	}
	/**
	 * @return the dbid
	 */
	public Integer getDbid() {
		return dbid;
	}
	/**
	 * @param dbid the dbid to set
	 */
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	/**
	 * @return the createDate
	 */
	public Date getCreateDate() {
		return createDate;
	}
	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	/**
	 * @return the modifyDate
	 */
	public Date getModifyDate() {
		return modifyDate;
	}
	/**
	 * @param modifyDate the modifyDate to set
	 */
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	/**
	 * @return the hour
	 */
	public Integer getHour() {
		return hour;
	}
	/**
	 * @param hour the hour to set
	 */
	public void setHour(Integer hour) {
		this.hour = hour;
	}
	/**
	 * @return the enterpriseId
	 */
	public Integer getEnterpriseId() {
		return enterpriseId;
	}
	/**
	 * @param enterpriseId the enterpriseId to set
	 */
	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	/**
	 * @return the note
	 */
	public String getNote() {
		return note;
	}
	/**
	 * @param note the note to set
	 */
	public void setNote(String note) {
		this.note = note;
	}
	
}
