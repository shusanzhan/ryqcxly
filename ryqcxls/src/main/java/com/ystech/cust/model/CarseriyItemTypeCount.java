/**
 * 
 */
package com.ystech.cust.model;

import java.io.Serializable;

/**
 * 店销售前台数据分析
 * @author shusanzhan
 * @date 2014-5-15
 */
public class CarseriyItemTypeCount implements Serializable{
	//类型
	private Integer itemType;
	//统计数量
	private Integer countNum;
	
	public CarseriyItemTypeCount(Integer itemType,Integer countNum){
		this.itemType=itemType;
		this.countNum=countNum;
	}
	
	public Integer getItemType() {
		return itemType;
	}
	public void setItemType(Integer itemType) {
		this.itemType = itemType;
	}
	public Integer getCountNum() {
		return countNum;
	}
	public void setCountNum(Integer countNum) {
		this.countNum = countNum;
	}
	
}
