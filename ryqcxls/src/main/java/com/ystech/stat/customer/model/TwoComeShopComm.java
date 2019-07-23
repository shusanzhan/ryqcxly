package com.ystech.stat.customer.model;

import com.ystech.stat.model.core.StaDateNum;

public class TwoComeShopComm extends StaDateNum{
	//首次来店数据
	public Integer comeShopNum;
	//二次来店数据
	public Integer twoComeShopNum;
	//二次来店率
	public Float twoComeShopPer;
	//二次来店订单数据
	public Integer twoComeShopOrderNum;
	//二次来店订单率
	public Float twoComeShopOrderPer;
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
	public Float getTwoComeShopPer() {
		return twoComeShopPer;
	}
	public void setTwoComeShopPer(Float twoComeShopPer) {
		this.twoComeShopPer = twoComeShopPer;
	}
	public Integer getTwoComeShopOrderNum() {
		return twoComeShopOrderNum;
	}
	public void setTwoComeShopOrderNum(Integer twoComeShopOrderNum) {
		this.twoComeShopOrderNum = twoComeShopOrderNum;
	}
	public Float getTwoComeShopOrderPer() {
		return twoComeShopOrderPer;
	}
	public void setTwoComeShopOrderPer(Float twoComeShopOrderPer) {
		this.twoComeShopOrderPer = twoComeShopOrderPer;
	}
}
