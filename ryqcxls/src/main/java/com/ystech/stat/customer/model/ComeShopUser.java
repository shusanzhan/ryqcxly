package com.ystech.stat.customer.model;

/**
 * 功能描述：来店客户销售顾问统计
 * @author Administrator
 *
 */
public class ComeShopUser extends ComeShopComm{
	public Integer dbid;
	public String realName;
	//上月留存潜客
	private Integer keepNum;;
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


	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
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

	public Integer getKeepNum() {
		return keepNum;
	}

	public void setKeepNum(Integer keepNum) {
		this.keepNum = keepNum;
	}


}
