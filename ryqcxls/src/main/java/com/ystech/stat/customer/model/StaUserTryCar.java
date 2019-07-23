package com.ystech.stat.customer.model;

/**
 * 功能描述：试乘试驾销售顾问统计
 * @author Administrator
 *
 */
public class StaUserTryCar extends TryCarComm{
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
