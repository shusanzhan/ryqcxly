package com.ystech.xwqr.set.model;

// Generated 2016-4-9 23:29:06 by Hibernate Tools 4.0.0

/**
 * SetCarmodelimage generated by hbm2java
 */
public class CarSeriyImage implements java.io.Serializable {

	private Integer dbid;
	private Integer carSeriyId;
	private String url;
	private Integer orderNum;

	public CarSeriyImage() {
	}

	public CarSeriyImage(Integer carModelId, String url, Integer orderNum) {
		this.url = url;
		this.orderNum = orderNum;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getCarSeriyId() {
		return carSeriyId;
	}

	public void setCarSeriyId(Integer carSeriyId) {
		this.carSeriyId = carSeriyId;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

}