/**
 * 
 */
package com.ystech.cust.model;

/**
 * 功能描述：超时统计分类
 * @author shusanzhan
 * @date 2014-7-5
 */
public class OverTimeUserCount {
	private Integer customerId;
	private String name;
	private Integer theNextDayTimeOutNum;
	private Integer trackingTimeOutNum;
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
