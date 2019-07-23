package com.ystech.stat.customer.model;

import com.ystech.stat.model.core.StaDateNum;

public class TryCarComm extends StaDateNum{
	//到店客户 查询时间段到店数据（包含首次到店、二次到店数据）
	public Integer comeShopNum;
	//到店试乘试驾客户 查询时间段到店试驾客户
	public Integer tryCarNum;
	//到店试乘试驾率
	public Float tryCarPer;
	//到店订单数
	public Integer tryCarOrderNum;
	//到店试乘试驾订单数
	public Float tryCarOrderPer;

	public Integer getComeShopNum() {
		return comeShopNum;
	}

	public void setComeShopNum(Integer comeShopNum) {
		this.comeShopNum = comeShopNum;
	}

	public Integer getTryCarNum() {
		return tryCarNum;
	}

	public void setTryCarNum(Integer tryCarNum) {
		this.tryCarNum = tryCarNum;
	}

	public Float getTryCarPer() {
		return tryCarPer;
	}

	public void setTryCarPer(Float tryCarPer) {
		this.tryCarPer = tryCarPer;
	}


	public Integer getTryCarOrderNum() {
		return tryCarOrderNum;
	}

	public void setTryCarOrderNum(Integer tryCarOrderNum) {
		this.tryCarOrderNum = tryCarOrderNum;
	}

	public Float getTryCarOrderPer() {
		return tryCarOrderPer;
	}

	public void setTryCarOrderPer(Float tryCarOrderPer) {
		this.tryCarOrderPer = tryCarOrderPer;
	}

}
