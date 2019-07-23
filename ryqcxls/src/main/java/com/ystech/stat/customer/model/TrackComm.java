package com.ystech.stat.customer.model;

import com.ystech.stat.model.core.StaDateNum;

public class TrackComm extends StaDateNum{
	//待回访量
	public Integer waitNum;
	//待回访数据中-已经回访数据
	public Integer waitTrackEdNum;
	//待回访-回访百分比
	public Float trackPer;
	//回访总数据（包含销售顾问主动回复数据+（客户流失+客户做订单）关闭任务回访）
	public Integer trackAllNum;
	//回访量
	public Integer trackNum;
	//回访量中超时数据
	public Integer trackOverTimeNum;
	//回访超时率
	public Float trackOverPer;
	public Integer getWaitNum() {
		return waitNum;
	}
	public void setWaitNum(Integer waitNum) {
		this.waitNum = waitNum;
	}
	public Integer getWaitTrackEdNum() {
		return waitTrackEdNum;
	}
	public void setWaitTrackEdNum(Integer waitTrackEdNum) {
		this.waitTrackEdNum = waitTrackEdNum;
	}
	public Float getTrackPer() {
		return trackPer;
	}
	public void setTrackPer(Float trackPer) {
		this.trackPer = trackPer;
	}
	public Integer getTrackAllNum() {
		return trackAllNum;
	}
	public void setTrackAllNum(Integer trackAllNum) {
		this.trackAllNum = trackAllNum;
	}
	public Integer getTrackNum() {
		return trackNum;
	}
	public void setTrackNum(Integer trackNum) {
		this.trackNum = trackNum;
	}
	public Integer getTrackOverTimeNum() {
		return trackOverTimeNum;
	}
	public void setTrackOverTimeNum(Integer trackOverTimeNum) {
		this.trackOverTimeNum = trackOverTimeNum;
	}
	public Float getTrackOverPer() {
		return trackOverPer;
	}
	public void setTrackOverPer(Float trackOverPer) {
		this.trackOverPer = trackOverPer;
	}
}
