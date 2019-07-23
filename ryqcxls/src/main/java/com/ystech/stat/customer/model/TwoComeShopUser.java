package com.ystech.stat.customer.model;

public class TwoComeShopUser extends TwoComeShopComm{
	public Integer dbid;
	public String userName;

	public Integer getDbid() {
		return dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}
