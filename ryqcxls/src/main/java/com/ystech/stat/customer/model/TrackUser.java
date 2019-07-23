package com.ystech.stat.customer.model;

/**
 * 功能描述：销售顾问回访统计
 * @author Administrator
 *
 */
public class TrackUser extends TrackComm{
	public Integer userId;
	public String userName;
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

}
