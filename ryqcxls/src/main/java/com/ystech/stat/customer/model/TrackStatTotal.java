package com.ystech.stat.customer.model;

public class TrackStatTotal {
	//销售顾问Id
	public Integer dbid;
	//销售顾问名字
	public String realName;
	//总创建客户
	public Integer createNum;
	//总回访客户
	public Integer trackNum;
	//平均回访频次
	public Float trackAvgNum;

	public Integer getDbid() {
		return dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Integer getCreateNum() {
		return createNum;
	}

	public void setCreateNum(Integer createNum) {
		this.createNum = createNum;
	}

	public Integer getTrackNum() {
		return trackNum;
	}

	public void setTrackNum(Integer trackNum) {
		this.trackNum = trackNum;
	}

	public Float getTrackAvgNum() {
		return trackAvgNum;
	}

	public void setTrackAvgNum(Float trackAvgNum) {
		this.trackAvgNum = trackAvgNum;
	}
}
