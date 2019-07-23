package com.ystech.cust.model;

// Generated 2015-8-15 16:14:00 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Customerimageapprove generated by hbm2java
 */
public class CustomerImageApprove implements java.io.Serializable {

	private Integer dbid;
	private Integer customerId;
	private Date appDate;
	private String appPerson;
	private String dis;

	public CustomerImageApprove() {
	}

	public CustomerImageApprove(Integer customerId, Date appDate,
			String appPerson, String dis) {
		this.customerId = customerId;
		this.appDate = appDate;
		this.appPerson = appPerson;
		this.dis = dis;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Date getAppDate() {
		return this.appDate;
	}

	public void setAppDate(Date appDate) {
		this.appDate = appDate;
	}

	public String getAppPerson() {
		return this.appPerson;
	}

	public void setAppPerson(String appPerson) {
		this.appPerson = appPerson;
	}

	public String getDis() {
		return this.dis;
	}

	public void setDis(String dis) {
		this.dis = dis;
	}

}
