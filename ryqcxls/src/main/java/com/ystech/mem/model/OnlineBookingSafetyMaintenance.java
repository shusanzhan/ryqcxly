package com.ystech.mem.model;

// Generated 2014-3-12 20:19:19 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Onlinesafety generated by hbm2java
 */
public class OnlineBookingSafetyMaintenance extends OnlineBooking implements java.io.Serializable {

	private String driveringNum;
	private Date buyCarDate;

	public OnlineBookingSafetyMaintenance() {
	}


	public OnlineBookingSafetyMaintenance(int dbid, Integer driveringNum, Date buyCarDate) {
		this.buyCarDate = buyCarDate;
	}


	public String getDriveringNum() {
		return driveringNum;
	}


	public void setDriveringNum(String driveringNum) {
		this.driveringNum = driveringNum;
	}


	public Date getBuyCarDate() {
		return this.buyCarDate;
	}

	public void setBuyCarDate(Date buyCarDate) {
		this.buyCarDate = buyCarDate;
	}

}
