package com.ystech.stat.customerrecord.model;

import java.util.Date;

import com.ystech.stat.model.core.StaDateNum;

public class StatCustomerRecordTime extends StaDateNum {
	private Date createDate;
	//总数据
	private Integer totalNum;
	//自然到店数据
	private Integer roomNum;
	//网销数据
	private Integer netNum;
	//二次到店客户
	private Integer twoNum;
	//来店有效线索
	private Integer effectiveNum;
	
	private Integer eightNum;
	private Integer nineNum;
	private Integer tenNum;
	private Integer elevenNum;
	private Integer twelveNum;
	private Integer thirteenNum;
	private Integer fourteenNum;
	private Integer fifteenNum;
	private Integer sixteenNum;
	private Integer seventeenNum;
	private Integer eighteenNUm;

	public StatCustomerRecordTime()	{
		
	}
	public StatCustomerRecordTime(Date date){
		createDate=date;
		this.totalNum=0;
		eightNum=0;
		nineNum=0;
		tenNum=0;
		elevenNum=0;
		twelveNum=0;
		thirteenNum=0;
		fourteenNum=0;
		fifteenNum=0;
		sixteenNum=0;
		seventeenNum=0;
		eighteenNUm=0;
		netNum=0;
		effectiveNum=0;
		roomNum=0;
		twoNum=0;
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

	public Integer getEightNum() {
		return eightNum;
	}

	public void setEightNum(Integer eightNum) {
		this.eightNum = eightNum;
	}

	public Integer getNineNum() {
		return nineNum;
	}

	public void setNineNum(Integer nineNum) {
		this.nineNum = nineNum;
	}

	public Integer getTenNum() {
		return tenNum;
	}

	public void setTenNum(Integer tenNum) {
		this.tenNum = tenNum;
	}

	public Integer getElevenNum() {
		return elevenNum;
	}

	public void setElevenNum(Integer elevenNum) {
		this.elevenNum = elevenNum;
	}

	public Integer getTwelveNum() {
		return twelveNum;
	}

	public void setTwelveNum(Integer twelveNum) {
		this.twelveNum = twelveNum;
	}

	public Integer getThirteenNum() {
		return thirteenNum;
	}

	public void setThirteenNum(Integer thirteenNum) {
		this.thirteenNum = thirteenNum;
	}

	public Integer getFourteenNum() {
		return fourteenNum;
	}

	public void setFourteenNum(Integer fourteenNum) {
		this.fourteenNum = fourteenNum;
	}

	public Integer getFifteenNum() {
		return fifteenNum;
	}

	public void setFifteenNum(Integer fifteenNum) {
		this.fifteenNum = fifteenNum;
	}

	public Integer getSixteenNum() {
		return sixteenNum;
	}

	public void setSixteenNum(Integer sixteenNum) {
		this.sixteenNum = sixteenNum;
	}

	public Integer getSeventeenNum() {
		return seventeenNum;
	}

	public void setSeventeenNum(Integer seventeenNum) {
		this.seventeenNum = seventeenNum;
	}

	public Integer getEighteenNUm() {
		return eighteenNUm;
	}

	public void setEighteenNUm(Integer eighteenNUm) {
		this.eighteenNUm = eighteenNUm;
	}
	public Integer getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}
	public Integer getNetNum() {
		return netNum;
	}
	public void setNetNum(Integer netNum) {
		this.netNum = netNum;
	}
	public Integer getTwoNum() {
		return twoNum;
	}
	public void setTwoNum(Integer twoNum) {
		this.twoNum = twoNum;
	}
	public Integer getEffectiveNum() {
		return effectiveNum;
	}
	public void setEffectiveNum(Integer effectiveNum) {
		this.effectiveNum = effectiveNum;
	}

}
