package com.ystech.stat.model.core;

import java.util.Date;

import com.ystech.stat.customerrecord.model.StatDataSort;

/**
 * 功能描述：用于统计来店/来电目的 每日统计数据
 * 
 * @author Administrator
 *
 */
public class StaDateNum extends StatDataSort{
	private Date createDate;
	private Integer totalNum;
	public StaDateNum(){
		
	}
	public StaDateNum(Date createDate, Integer totalNum) {
		this.createDate = createDate;
		this.totalNum = totalNum;
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
