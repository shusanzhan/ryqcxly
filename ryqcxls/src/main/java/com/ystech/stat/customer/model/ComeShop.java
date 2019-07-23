package com.ystech.stat.customer.model;

import java.util.Date;

public class ComeShop extends ComeShopComm{
	//来店时间
	private Date createDate;
	//来店总数据（包括首次来店+二次来店）
	private Integer totalNum;
	public ComeShop(){
		
	}
	public ComeShop(Date createDate){
		this.createDate=createDate;
		this.createFolderNum=0;
		this.comeShopNum=0;
		this.twoComeShopNum=0;
		this.comeShopOrderNum=0;
		this.comeShopOrderPer=0f;
		this.totalComeShopNum=0;
		this.comeShopTwoOrderNum=0;
		this.comeShopTotalOrderNum=0;
		this.totalNum=0;
		this.comeShopTotalOrderPer=0f;
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
