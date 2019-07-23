/**
 * 
 */
package com.ystech.cust.model;

/**
 * 功能描述：超时统计分类
 * @author shusanzhan
 * @date 2014-7-5
 */
public class OverTimeCount {
	private Integer userId;
	private String userName;
	private Integer theNextDayTimeOutNum;
	private Integer trackingTimeOutNum;
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
	public Integer getTheNextDayTimeOutNum() {
		return theNextDayTimeOutNum;
	}
	public void setTheNextDayTimeOutNum(Integer theNextDayTimeOutNum) {
		this.theNextDayTimeOutNum = theNextDayTimeOutNum;
	}
	public Integer getTrackingTimeOutNum() {
		return trackingTimeOutNum;
	}
	public void setTrackingTimeOutNum(Integer trackingTimeOutNum) {
		this.trackingTimeOutNum = trackingTimeOutNum;
	}
	
}
