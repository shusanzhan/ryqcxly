package com.ystech.stat.customer.model;

/**
 * 功能描述：来店客户销售顾问统计
 * @author Administrator
 *
 */
public class FlowUser extends FlowComm{
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
