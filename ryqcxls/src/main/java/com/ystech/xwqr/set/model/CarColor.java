package com.ystech.xwqr.set.model;


// Generated 2014-2-22 16:01:27 by Hibernate Tools 4.0.0

/**
 * Buycartarget generated by hbm2java
 */
public class CarColor implements java.io.Serializable {
	public static int STATUSSTOP=2;
	public static int STATUSCOMM=1;
	private Integer dbid;
	private String name;
	private String note;
	private Integer brandId;
	private CarSeriy carseries;
	private Integer status;
	private Integer enterpriseId;
	public CarColor() {
	}

	public CarColor(String name, String note) {
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

	public CarSeriy getCarseries() {
		return carseries;
	}

	public void setCarseries(CarSeriy carseries) {
		this.carseries = carseries;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}