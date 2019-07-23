package com.ystech.stat.customer.model;

import com.ystech.stat.model.core.StaDateNum;

public class ComeShopComm extends StaDateNum{
	//创建文档
	public Integer createFolderNum;
	//首次来店数据
	public Integer comeShopNum;
	//二次来店数据
	public Integer twoComeShopNum;
	//首次到店转订单客户
	public Integer comeShopOrderNum;
	//首次到店客户率
	public Float comeShopOrderPer;
	//总到店客户（含首次到店+二次到店）
	public Integer totalComeShopNum;
	//二次到店客户订单
	public Integer comeShopTwoOrderNum;
	//到店总订单（含首次到店订单+二次到店订单）
	public Integer comeShopTotalOrderNum;
	//到店总订单率
	public Float comeShopTotalOrderPer;
	
	
	public Integer getComeShopNum() {
		return comeShopNum;
	}
	public void setComeShopNum(Integer comeShopNum) {
		this.comeShopNum = comeShopNum;
	}
	public Integer getTwoComeShopNum() {
		return twoComeShopNum;
	}
	public void setTwoComeShopNum(Integer twoComeShopNum) {
		this.twoComeShopNum = twoComeShopNum;
	}
	public Integer getCreateFolderNum() {
		return createFolderNum;
	}
	public void setCreateFolderNum(Integer createFolderNum) {
		this.createFolderNum = createFolderNum;
	}
	public Integer getComeShopOrderNum() {
		return comeShopOrderNum;
	}
	public void setComeShopOrderNum(Integer comeShopOrderNum) {
		this.comeShopOrderNum = comeShopOrderNum;
	}
	public Float getComeShopOrderPer() {
		return comeShopOrderPer;
	}
	public void setComeShopOrderPer(Float comeShopOrderPer) {
		this.comeShopOrderPer = comeShopOrderPer;
	}
	public Integer getTotalComeShopNum() {
		return totalComeShopNum;
	}
	public void setTotalComeShopNum(Integer totalComeShopNum) {
		this.totalComeShopNum = totalComeShopNum;
	}
	public Integer getComeShopTwoOrderNum() {
		return comeShopTwoOrderNum;
	}
	public void setComeShopTwoOrderNum(Integer comeShopTwoOrderNum) {
		this.comeShopTwoOrderNum = comeShopTwoOrderNum;
	}
	public Integer getComeShopTotalOrderNum() {
		return comeShopTotalOrderNum;
	}
	public void setComeShopTotalOrderNum(Integer comeShopTotalOrderNum) {
		this.comeShopTotalOrderNum = comeShopTotalOrderNum;
	}
	public Float getComeShopTotalOrderPer() {
		return comeShopTotalOrderPer;
	}
	public void setComeShopTotalOrderPer(Float comeShopTotalOrderPer) {
		this.comeShopTotalOrderPer = comeShopTotalOrderPer;
	}
}
