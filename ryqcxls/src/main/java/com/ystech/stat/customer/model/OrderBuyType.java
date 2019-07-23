package com.ystech.stat.customer.model;


public class OrderBuyType {
	public String name;
	public Integer cashNum;
	public Integer finNum;
	public Integer orderNum;
	public Float finPer;

	public OrderBuyType() {

	}

	public Integer getCashNum() {
		return cashNum;
	}

	public void setCashNum(Integer cashNum) {
		this.cashNum = cashNum;
	}

	public Integer getFinNum() {
		return finNum;
	}

	public void setFinNum(Integer finNum) {
		this.finNum = finNum;
	}

	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public Float getFinPer() {
		return finPer;
	}

	public void setFinPer(Float finPer) {
		this.finPer = finPer;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
