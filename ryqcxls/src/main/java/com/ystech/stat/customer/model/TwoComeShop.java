package com.ystech.stat.customer.model;

import java.util.Date;

public class TwoComeShop extends TwoComeShopComm{
	//来店时间
	private Date createDate;
	//来店总数据（包括首次来店+二次来店）
	private Integer totalNum;
	public TwoComeShop(){
		
	}
	public TwoComeShop(Date createDate){
		this.createDate=createDate;
		this.totalNum=0;
		this.comeShopNum=0;
		this.twoComeShopNum=0;
		this.twoComeShopOrderNum=0;
		this.twoComeShopOrderPer=0f;
		this.twoComeShopPer=0f;
		this.twoComeShopNum=0;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	
}
