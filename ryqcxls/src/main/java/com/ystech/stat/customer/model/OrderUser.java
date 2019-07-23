package com.ystech.stat.customer.model;

/**
 * 功能描述：来店客户销售顾问统计
 * @author Administrator
 *
 */
public class OrderUser extends OrderComm{
	public Integer dbid;
	public String bussiStaff;
	
	public Integer getDbid() {
		return dbid;
	}
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	public String getBussiStaff() {
		return bussiStaff;
	}
	public void setBussiStaff(String bussiStaff) {
		this.bussiStaff = bussiStaff;
	}

}
