package com.ystech.stat.customer.model;

import java.util.Date;

public class Order extends OrderComm{
	public Integer selfOrderNum;//自有店订单率
	public Integer netOrderNum;//二网订单
	public Date createDate;
	
	public Order(){
		
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getSelfOrderNum() {
		return selfOrderNum;
	}
	public void setSelfOrderNum(Integer selfOrderNum) {
		this.selfOrderNum = selfOrderNum;
	}
	public Integer getNetOrderNum() {
		return netOrderNum;
	}
	public void setNetOrderNum(Integer netOrderNum) {
		this.netOrderNum = netOrderNum;
	}
	public Order(Date date){
		createDate=date;
		selfOrderNum=0;
		netOrderNum=0;
		orderNum=0;
	}
	
}
