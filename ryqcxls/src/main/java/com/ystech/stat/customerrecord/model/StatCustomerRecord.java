package com.ystech.stat.customerrecord.model;

public class StatCustomerRecord {
	//类型
	private Integer dbid;
	private String name;
	//当月线索总数
	private Integer monthNum;
	//当月简单线索数
	private Integer monthCreateFolderNum;
	//当天线索数据
	private Integer todayNum;
	//当天线索创建档案数
	private Integer todayCreateFolderNum;
	public Integer getMonthNum() {
		return monthNum;
	}
	public void setMonthNum(Integer monthNum) {
		this.monthNum = monthNum;
	}
	public Integer getMonthCreateFolderNum() {
		return monthCreateFolderNum;
	}
	public void setMonthCreateFolderNum(Integer monthCreateFolderNum) {
		this.monthCreateFolderNum = monthCreateFolderNum;
	}
	public Integer getTodayNum() {
		return todayNum;
	}
	public void setTodayNum(Integer todayNum) {
		this.todayNum = todayNum;
	}
	public Integer getTodayCreateFolderNum() {
		return todayCreateFolderNum;
	}
	public void setTodayCreateFolderNum(Integer todayCreateFolderNum) {
		this.todayCreateFolderNum = todayCreateFolderNum;
	}
	public Integer getDbid() {
		return dbid;
	}
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
