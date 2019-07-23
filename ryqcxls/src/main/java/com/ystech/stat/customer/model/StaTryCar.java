package com.ystech.stat.customer.model;

import java.util.Date;

public class StaTryCar extends TryCarComm{
	//来店时间
	private Date createDate;
	//二次来店数据
	private Integer twoComeShopNum;
	//来店总数据（包括首次来店+二次来店）
	private Integer totalNum;
	public StaTryCar(){
		
	}
	public StaTryCar(Date createDate){
		this.createDate=createDate;
		this.totalNum=0;
		this.comeShopNum=0;
		this.tryCarNum=0;
		this.tryCarOrderNum=0;
		this.tryCarOrderPer=0f;
		this.tryCarPer=0f;
		this.twoComeShopNum=0;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getTwoComeShopNum() {
		return twoComeShopNum;
	}
	public void setTwoComeShopNum(Integer twoComeShopNum) {
		this.twoComeShopNum = twoComeShopNum;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	
	
}
