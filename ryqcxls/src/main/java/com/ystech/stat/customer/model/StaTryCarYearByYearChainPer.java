package com.ystech.stat.customer.model;

import com.ystech.stat.customerrecord.model.StaYearByYearChain;

public class StaTryCarYearByYearChainPer extends StaYearByYearChain {
	//项目名称
	public String itemName;
	//当月项目百分比
	public Float nowTryCarPer;
	//上月项目百分比
	public Float preTryCarPer;
	//上年同期项目百分比
	public Float yearByYearTryCarPer;

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Float getNowTryCarPer() {
		return nowTryCarPer;
	}

	public void setNowTryCarPer(Float nowTryCarPer) {
		this.nowTryCarPer = nowTryCarPer;
	}

	public Float getPreTryCarPer() {
		return preTryCarPer;
	}

	public void setPreTryCarPer(Float preTryCarPer) {
		this.preTryCarPer = preTryCarPer;
	}

	public Float getYearByYearTryCarPer() {
		return yearByYearTryCarPer;
	}

	public void setYearByYearTryCarPer(Float yearByYearTryCarPer) {
		this.yearByYearTryCarPer = yearByYearTryCarPer;
	}

}
