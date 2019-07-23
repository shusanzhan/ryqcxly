package com.ystech.stat.model;
// Generated 2018-9-21 14:52:38 by Hibernate Tools 4.0.0.Final

import java.util.Date;

/**
 * StaCustcomp generated by hbm2java
 */
public class StaCustComp implements java.io.Serializable {

	private Integer dbid;
	//分公司ID
	private Integer entId;
	//分公司名称
	private String entName;
	//部门ID
	private Integer depId;
	//部门名称
	private String depName;
	//业务员名称
	private String userName;
	//数据类型：1、分公司数据；2、部门数据；3、业务员数据
	private Integer itemType;
	//业务员Id
	private Integer userId;
	//总登记客户
	private Integer recordNum;
	//月新登记客户
	private Integer recordMonthNum;
	//月基盘客户
	private Integer recordOverplusNum;
	//月净增客户；月新等级客户-月流失客户
	private Integer recordMonthAddNum;
	//总流失客户
	private Integer flowNum;
	//流失率
	private Float flowPer;
	//月流失客户
	private Integer flowMonthNum;
	//月流失率
	private Float flowMonthPer;
	//到店客户
	private Integer comeShopNum;
	//到店率
	private Float comeShopPer;
	//月到店客户
	private Integer comeShopMonthNum;
	//约到店率
	private Float comeShopMonthPer;
	//到店成交客户
	private Integer comeShopSucessNum;
	//到店成交率
	private Float comeShopSucessPer;
	//月到店客户
	private Integer comeShopMonthSuccessNum;
	//月到店成交率
	private Float comeShopMonthSuccessPer;
	//二次到店数
	private Integer twoTimesComeShopNum;
	//二次到店率
	private Float twoTimesComeShopPer;
	//月二次到店数据
	private Integer twoTimesComeShopMonthNum;
	//月二次到店率 月二次到店数据/月到店客户
	private Float twoTimesComeShopMonthPer;
	//二次到店成交数
	private Integer twoTimesComeShopSucessNum;
	//二次到店成交率
	private Float twoTimesComeShopSucessPer;
	//月二次到店成交数
	private Integer twoTimesComeShopMonthSucessNum;
	//月二次到店成交率
	private Float twoTimesComeShopMonthSucessPer;
	//试驾客户
	private Integer tryCarNum;
	//试驾率
	private Float tryCarPer;
	//每月试驾客户
	private Integer tryCarMonthNum;
	//每月试驾率
	private Float tryCarMonthPer;
	//试驾成交客户
	private Integer tryCarSuccessNum;
	//试驾成交率
	private Float tryCarSucessPer;
	//每月试驾成交客户
	private Integer tryCarMonthSuccessNum;
	//每月试驾成交率
	private Float tryCarMonthSuccessPer;
	//成交客户数
	private Integer customerSuccessNum;
	//客户成交率
	private Float customerSuccessPer;
	//每月客户成交数
	private Integer customerMonthSuccessNum;
	//每月客户成交率
	private Float customerMonthSuccessPer;
	//回访量
	private Integer trackNum;
	//平均回访量
	private Float trackAva;
	//超时回访量
	private Integer trackOverTimeNum;
	//超时回访率
	private Float trackOverTimePer;
	//创建时间
	private Date createDate;
	//月回访量
	private Integer trackMonthNum;
	//月回访超时量
	private Integer trackMonthOverTimeNum;
	//月回访超时率
	private Float trackMonthOverTimePer;

	public StaCustComp() {
	}

	public StaCustComp(Integer entId, String entName, Integer depId, String userName, String depName, Integer itemType,
			Integer userId, Integer recordNum, Integer recordMonthNum, Integer recordOverplusNum,
			Integer recordMonthAddNum, Integer flowNum, Float flowPer, Integer flowMonthNum, Float flowMonthPer,
			Integer comeShopNum, Float comeShopPer, Integer comeShopMonthNum, Float comeShopMonthPer,
			Integer comeShopSucessNum, Float comeShopSucessPer, Integer comeShopMonthSuccessNum,
			Float comeShopMonthSuccessPer, Integer twoTimesComeShopNum, Float twoTimesComeShopPer,
			Integer twoTimesComeShopMonthNum, Float twoTimesComeShopMonthPer, Integer twoTimesComeShopSucessNum,
			Float twoTimesComeShopSucessPer, Integer twoTimesComeShopMonthSucessNum,
			Float twoTimesComeShopMonthSucessPer, Integer tryCarNum, Float tryCarPer, Integer tryCarMonthNum,
			Float tryCarMonthPer, Integer tryCarSuccessNum, Float tryCarSucessPer, Integer tryCarMonthSuccessNum,
			Float tryCarMonthSuccessPer, Integer customerSuccessNum, Float customerSuccessPer,
			Integer customerMonthSuccessNum, Float customerMonthSuccessPer, Integer trackNum, Float trackAva,
			Integer trackOverTimeNum, Float trackOverTimePer, Date createDate, Integer trackMonthNum,
			Integer trackMonthOverTimeNum, Float trackMonthOverTimePer) {
		this.entId = entId;
		this.entName = entName;
		this.depId = depId;
		this.userName = userName;
		this.depName = depName;
		this.itemType = itemType;
		this.userId = userId;
		this.recordNum = recordNum;
		this.recordMonthNum = recordMonthNum;
		this.recordOverplusNum = recordOverplusNum;
		this.recordMonthAddNum = recordMonthAddNum;
		this.flowNum = flowNum;
		this.flowPer = flowPer;
		this.flowMonthNum = flowMonthNum;
		this.flowMonthPer = flowMonthPer;
		this.comeShopNum = comeShopNum;
		this.comeShopPer = comeShopPer;
		this.comeShopMonthNum = comeShopMonthNum;
		this.comeShopMonthPer = comeShopMonthPer;
		this.comeShopSucessNum = comeShopSucessNum;
		this.comeShopSucessPer = comeShopSucessPer;
		this.comeShopMonthSuccessNum = comeShopMonthSuccessNum;
		this.comeShopMonthSuccessPer = comeShopMonthSuccessPer;
		this.twoTimesComeShopNum = twoTimesComeShopNum;
		this.twoTimesComeShopPer = twoTimesComeShopPer;
		this.twoTimesComeShopMonthNum = twoTimesComeShopMonthNum;
		this.twoTimesComeShopMonthPer = twoTimesComeShopMonthPer;
		this.twoTimesComeShopSucessNum = twoTimesComeShopSucessNum;
		this.twoTimesComeShopSucessPer = twoTimesComeShopSucessPer;
		this.twoTimesComeShopMonthSucessNum = twoTimesComeShopMonthSucessNum;
		this.twoTimesComeShopMonthSucessPer = twoTimesComeShopMonthSucessPer;
		this.tryCarNum = tryCarNum;
		this.tryCarPer = tryCarPer;
		this.tryCarMonthNum = tryCarMonthNum;
		this.tryCarMonthPer = tryCarMonthPer;
		this.tryCarSuccessNum = tryCarSuccessNum;
		this.tryCarSucessPer = tryCarSucessPer;
		this.tryCarMonthSuccessNum = tryCarMonthSuccessNum;
		this.tryCarMonthSuccessPer = tryCarMonthSuccessPer;
		this.customerSuccessNum = customerSuccessNum;
		this.customerSuccessPer = customerSuccessPer;
		this.customerMonthSuccessNum = customerMonthSuccessNum;
		this.customerMonthSuccessPer = customerMonthSuccessPer;
		this.trackNum = trackNum;
		this.trackAva = trackAva;
		this.trackOverTimeNum = trackOverTimeNum;
		this.trackOverTimePer = trackOverTimePer;
		this.createDate = createDate;
		this.trackMonthNum = trackMonthNum;
		this.trackMonthOverTimeNum = trackMonthOverTimeNum;
		this.trackMonthOverTimePer = trackMonthOverTimePer;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getEntId() {
		return this.entId;
	}

	public void setEntId(Integer entId) {
		this.entId = entId;
	}

	public String getEntName() {
		return this.entName;
	}

	public void setEntName(String entName) {
		this.entName = entName;
	}

	public Integer getDepId() {
		return this.depId;
	}

	public void setDepId(Integer depId) {
		this.depId = depId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDepName() {
		return this.depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public Integer getItemType() {
		return this.itemType;
	}

	public void setItemType(Integer itemType) {
		this.itemType = itemType;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getRecordNum() {
		return this.recordNum;
	}

	public void setRecordNum(Integer recordNum) {
		this.recordNum = recordNum;
	}

	public Integer getRecordMonthNum() {
		return this.recordMonthNum;
	}

	public void setRecordMonthNum(Integer recordMonthNum) {
		this.recordMonthNum = recordMonthNum;
	}

	public Integer getRecordOverplusNum() {
		return this.recordOverplusNum;
	}

	public void setRecordOverplusNum(Integer recordOverplusNum) {
		this.recordOverplusNum = recordOverplusNum;
	}

	public Integer getRecordMonthAddNum() {
		return this.recordMonthAddNum;
	}

	public void setRecordMonthAddNum(Integer recordMonthAddNum) {
		this.recordMonthAddNum = recordMonthAddNum;
	}

	public Integer getFlowNum() {
		return this.flowNum;
	}

	public void setFlowNum(Integer flowNum) {
		this.flowNum = flowNum;
	}

	public Float getFlowPer() {
		return this.flowPer;
	}

	public void setFlowPer(Float flowPer) {
		this.flowPer = flowPer;
	}

	public Integer getFlowMonthNum() {
		return this.flowMonthNum;
	}

	public void setFlowMonthNum(Integer flowMonthNum) {
		this.flowMonthNum = flowMonthNum;
	}

	public Float getFlowMonthPer() {
		return this.flowMonthPer;
	}

	public void setFlowMonthPer(Float flowMonthPer) {
		this.flowMonthPer = flowMonthPer;
	}

	public Integer getComeShopNum() {
		return this.comeShopNum;
	}

	public void setComeShopNum(Integer comeShopNum) {
		this.comeShopNum = comeShopNum;
	}

	public Float getComeShopPer() {
		return this.comeShopPer;
	}

	public void setComeShopPer(Float comeShopPer) {
		this.comeShopPer = comeShopPer;
	}

	public Integer getComeShopMonthNum() {
		return this.comeShopMonthNum;
	}

	public void setComeShopMonthNum(Integer comeShopMonthNum) {
		this.comeShopMonthNum = comeShopMonthNum;
	}

	public Float getComeShopMonthPer() {
		return this.comeShopMonthPer;
	}

	public void setComeShopMonthPer(Float comeShopMonthPer) {
		this.comeShopMonthPer = comeShopMonthPer;
	}

	public Integer getComeShopSucessNum() {
		return this.comeShopSucessNum;
	}

	public void setComeShopSucessNum(Integer comeShopSucessNum) {
		this.comeShopSucessNum = comeShopSucessNum;
	}

	public Float getComeShopSucessPer() {
		return this.comeShopSucessPer;
	}

	public void setComeShopSucessPer(Float comeShopSucessPer) {
		this.comeShopSucessPer = comeShopSucessPer;
	}

	public Integer getComeShopMonthSuccessNum() {
		return this.comeShopMonthSuccessNum;
	}

	public void setComeShopMonthSuccessNum(Integer comeShopMonthSuccessNum) {
		this.comeShopMonthSuccessNum = comeShopMonthSuccessNum;
	}

	public Float getComeShopMonthSuccessPer() {
		return this.comeShopMonthSuccessPer;
	}

	public void setComeShopMonthSuccessPer(Float comeShopMonthSuccessPer) {
		this.comeShopMonthSuccessPer = comeShopMonthSuccessPer;
	}

	public Integer getTwoTimesComeShopNum() {
		return this.twoTimesComeShopNum;
	}

	public void setTwoTimesComeShopNum(Integer twoTimesComeShopNum) {
		this.twoTimesComeShopNum = twoTimesComeShopNum;
	}

	public Float getTwoTimesComeShopPer() {
		return this.twoTimesComeShopPer;
	}

	public void setTwoTimesComeShopPer(Float twoTimesComeShopPer) {
		this.twoTimesComeShopPer = twoTimesComeShopPer;
	}

	public Integer getTwoTimesComeShopMonthNum() {
		return this.twoTimesComeShopMonthNum;
	}

	public void setTwoTimesComeShopMonthNum(Integer twoTimesComeShopMonthNum) {
		this.twoTimesComeShopMonthNum = twoTimesComeShopMonthNum;
	}

	public Float getTwoTimesComeShopMonthPer() {
		return this.twoTimesComeShopMonthPer;
	}

	public void setTwoTimesComeShopMonthPer(Float twoTimesComeShopMonthPer) {
		this.twoTimesComeShopMonthPer = twoTimesComeShopMonthPer;
	}

	public Integer getTwoTimesComeShopSucessNum() {
		return this.twoTimesComeShopSucessNum;
	}

	public void setTwoTimesComeShopSucessNum(Integer twoTimesComeShopSucessNum) {
		this.twoTimesComeShopSucessNum = twoTimesComeShopSucessNum;
	}

	public Float getTwoTimesComeShopSucessPer() {
		return this.twoTimesComeShopSucessPer;
	}

	public void setTwoTimesComeShopSucessPer(Float twoTimesComeShopSucessPer) {
		this.twoTimesComeShopSucessPer = twoTimesComeShopSucessPer;
	}

	public Integer getTwoTimesComeShopMonthSucessNum() {
		return this.twoTimesComeShopMonthSucessNum;
	}

	public void setTwoTimesComeShopMonthSucessNum(Integer twoTimesComeShopMonthSucessNum) {
		this.twoTimesComeShopMonthSucessNum = twoTimesComeShopMonthSucessNum;
	}

	public Float getTwoTimesComeShopMonthSucessPer() {
		return this.twoTimesComeShopMonthSucessPer;
	}

	public void setTwoTimesComeShopMonthSucessPer(Float twoTimesComeShopMonthSucessPer) {
		this.twoTimesComeShopMonthSucessPer = twoTimesComeShopMonthSucessPer;
	}

	public Integer getTryCarNum() {
		return this.tryCarNum;
	}

	public void setTryCarNum(Integer tryCarNum) {
		this.tryCarNum = tryCarNum;
	}

	public Float getTryCarPer() {
		return this.tryCarPer;
	}

	public void setTryCarPer(Float tryCarPer) {
		this.tryCarPer = tryCarPer;
	}

	public Integer getTryCarMonthNum() {
		return this.tryCarMonthNum;
	}

	public void setTryCarMonthNum(Integer tryCarMonthNum) {
		this.tryCarMonthNum = tryCarMonthNum;
	}

	public Float getTryCarMonthPer() {
		return this.tryCarMonthPer;
	}

	public void setTryCarMonthPer(Float tryCarMonthPer) {
		this.tryCarMonthPer = tryCarMonthPer;
	}

	public Integer getTryCarSuccessNum() {
		return this.tryCarSuccessNum;
	}

	public void setTryCarSuccessNum(Integer tryCarSuccessNum) {
		this.tryCarSuccessNum = tryCarSuccessNum;
	}

	public Float getTryCarSucessPer() {
		return this.tryCarSucessPer;
	}

	public void setTryCarSucessPer(Float tryCarSucessPer) {
		this.tryCarSucessPer = tryCarSucessPer;
	}

	public Integer getTryCarMonthSuccessNum() {
		return this.tryCarMonthSuccessNum;
	}

	public void setTryCarMonthSuccessNum(Integer tryCarMonthSuccessNum) {
		this.tryCarMonthSuccessNum = tryCarMonthSuccessNum;
	}

	public Float getTryCarMonthSuccessPer() {
		return this.tryCarMonthSuccessPer;
	}

	public void setTryCarMonthSuccessPer(Float tryCarMonthSuccessPer) {
		this.tryCarMonthSuccessPer = tryCarMonthSuccessPer;
	}

	public Integer getCustomerSuccessNum() {
		return this.customerSuccessNum;
	}

	public void setCustomerSuccessNum(Integer customerSuccessNum) {
		this.customerSuccessNum = customerSuccessNum;
	}

	public Float getCustomerSuccessPer() {
		return this.customerSuccessPer;
	}

	public void setCustomerSuccessPer(Float customerSuccessPer) {
		this.customerSuccessPer = customerSuccessPer;
	}

	public Integer getCustomerMonthSuccessNum() {
		return this.customerMonthSuccessNum;
	}

	public void setCustomerMonthSuccessNum(Integer customerMonthSuccessNum) {
		this.customerMonthSuccessNum = customerMonthSuccessNum;
	}

	public Float getCustomerMonthSuccessPer() {
		return this.customerMonthSuccessPer;
	}

	public void setCustomerMonthSuccessPer(Float customerMonthSuccessPer) {
		this.customerMonthSuccessPer = customerMonthSuccessPer;
	}

	public Integer getTrackNum() {
		return this.trackNum;
	}

	public void setTrackNum(Integer trackNum) {
		this.trackNum = trackNum;
	}

	public Float getTrackAva() {
		return this.trackAva;
	}

	public void setTrackAva(Float trackAva) {
		this.trackAva = trackAva;
	}

	public Integer getTrackOverTimeNum() {
		return this.trackOverTimeNum;
	}

	public void setTrackOverTimeNum(Integer trackOverTimeNum) {
		this.trackOverTimeNum = trackOverTimeNum;
	}

	public Float getTrackOverTimePer() {
		return this.trackOverTimePer;
	}

	public void setTrackOverTimePer(Float trackOverTimePer) {
		this.trackOverTimePer = trackOverTimePer;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getTrackMonthNum() {
		return this.trackMonthNum;
	}

	public void setTrackMonthNum(Integer trackMonthNum) {
		this.trackMonthNum = trackMonthNum;
	}

	public Integer getTrackMonthOverTimeNum() {
		return this.trackMonthOverTimeNum;
	}

	public void setTrackMonthOverTimeNum(Integer trackMonthOverTimeNum) {
		this.trackMonthOverTimeNum = trackMonthOverTimeNum;
	}

	public Float getTrackMonthOverTimePer() {
		return this.trackMonthOverTimePer;
	}

	public void setTrackMonthOverTimePer(Float trackMonthOverTimePer) {
		this.trackMonthOverTimePer = trackMonthOverTimePer;
	}

	@Override
	public String toString() {
		return "StaCustComp [dbid=" + dbid + ", entId=" + entId + ", entName="
				+ entName + ", depId=" + depId + ", depName=" + depName
				+ ", userName=" + userName + ", itemType=" + itemType
				+ ", userId=" + userId + ", recordNum=" + recordNum
				+ ", recordMonthNum=" + recordMonthNum + ", recordOverplusNum="
				+ recordOverplusNum + ", recordMonthAddNum="
				+ recordMonthAddNum + ", flowNum=" + flowNum + ", flowPer="
				+ flowPer + ", flowMonthNum=" + flowMonthNum
				+ ", flowMonthPer=" + flowMonthPer + ", comeShopNum="
				+ comeShopNum + ", comeShopPer=" + comeShopPer
				+ ", comeShopMonthNum=" + comeShopMonthNum
				+ ", comeShopMonthPer=" + comeShopMonthPer
				+ ", comeShopSucessNum=" + comeShopSucessNum
				+ ", comeShopSucessPer=" + comeShopSucessPer
				+ ", comeShopMonthSuccessNum=" + comeShopMonthSuccessNum
				+ ", comeShopMonthSuccessPer=" + comeShopMonthSuccessPer
				+ ", twoTimesComeShopNum=" + twoTimesComeShopNum
				+ ", twoTimesComeShopPer=" + twoTimesComeShopPer
				+ ", twoTimesComeShopMonthNum=" + twoTimesComeShopMonthNum
				+ ", twoTimesComeShopMonthPer=" + twoTimesComeShopMonthPer
				+ ", twoTimesComeShopSucessNum=" + twoTimesComeShopSucessNum
				+ ", twoTimesComeShopSucessPer=" + twoTimesComeShopSucessPer
				+ ", twoTimesComeShopMonthSucessNum="
				+ twoTimesComeShopMonthSucessNum
				+ ", twoTimesComeShopMonthSucessPer="
				+ twoTimesComeShopMonthSucessPer + ", tryCarNum=" + tryCarNum
				+ ", tryCarPer=" + tryCarPer + ", tryCarMonthNum="
				+ tryCarMonthNum + ", tryCarMonthPer=" + tryCarMonthPer
				+ ", tryCarSuccessNum=" + tryCarSuccessNum
				+ ", tryCarSucessPer=" + tryCarSucessPer
				+ ", tryCarMonthSuccessNum=" + tryCarMonthSuccessNum
				+ ", tryCarMonthSuccessPer=" + tryCarMonthSuccessPer
				+ ", customerSuccessNum=" + customerSuccessNum
				+ ", customerSuccessPer=" + customerSuccessPer
				+ ", customerMonthSuccessNum=" + customerMonthSuccessNum
				+ ", customerMonthSuccessPer=" + customerMonthSuccessPer
				+ ", trackNum=" + trackNum + ", trackAva=" + trackAva
				+ ", trackOverTimeNum=" + trackOverTimeNum
				+ ", trackOverTimePer=" + trackOverTimePer + ", createDate="
				+ createDate + ", trackMonthNum=" + trackMonthNum
				+ ", trackMonthOverTimeNum=" + trackMonthOverTimeNum
				+ ", trackMonthOverTimePer=" + trackMonthOverTimePer + "]";
	}

}
