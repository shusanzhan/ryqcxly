package com.ystech.cust.model;

// Generated 2014-8-16 10:45:55 by Hibernate Tools 4.0.0

/**
 * Distributorbuff generated by hbm2java
 */
public class DistributorBuff implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String mobilePhone;
	private Integer distributorId;

	public DistributorBuff() {
	}

	public DistributorBuff(String name, String mobilePhone,
			Integer distributorId) {
		this.name = name;
		this.mobilePhone = mobilePhone;
		this.distributorId = distributorId;
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

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public Integer getDistributorId() {
		return this.distributorId;
	}

	public void setDistributorId(Integer distributorId) {
		this.distributorId = distributorId;
	}

}
