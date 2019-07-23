package com.ystech.stat.customer.model;

public class CustUser {
	public Integer bussiStaffId;//用户ID
	public Integer totalNum;//统计量
	public String bussiStaff;//用户名称
	public CustUser(){
		
	}
	public Integer getBussiStaffId() {
		return bussiStaffId;
	}
	public void setBussiStaffId(Integer bussiStaffId) {
		this.bussiStaffId = bussiStaffId;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public String getBussiStaff() {
		return bussiStaff;
	}
	public void setBussiStaff(String bussiStaff) {
		this.bussiStaff = bussiStaff;
	}
	
}
