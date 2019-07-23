package com.ystech.stat.customer.model;
/**
 * 功能描述：线索类型统计
 * @author Administrator
 *
 */
public class ComeShopType extends ComeShopComm{
	public Integer dbid;
	//线索类型名称
	public String name;
	//留存潜客
	public Integer retainNum;
	public Integer totalNum;
	//首次到店率
	public Float comeShopPer;
	//到店率
	public Float comeShopTotalPer;
	public Integer getDbid() {
		return dbid;
	}
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getRetainNum() {
		return retainNum;
	}
	public void setRetainNum(Integer retainNum) {
		this.retainNum = retainNum;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public Float getComeShopPer() {
		return comeShopPer;
	}
	public void setComeShopPer(Float comeShopPer) {
		this.comeShopPer = comeShopPer;
	}
	public Float getComeShopTotalPer() {
		return comeShopTotalPer;
	}
	public void setComeShopTotalPer(Float comeShopTotalPer) {
		this.comeShopTotalPer = comeShopTotalPer;
	}
	
}
