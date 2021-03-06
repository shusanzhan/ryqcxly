package com.ystech.stat.model;

// Generated 2018-11-19 14:29:07 by Hibernate Tools 4.0.0

import java.util.Date;

import com.ystech.cust.model.CustomerInfrom;
import com.ystech.stat.customerrecord.model.StatDataSort;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * StaCustomerinfromstaset generated by hbm2java
 */
public class CustomerInfromStaSet extends StatDataSort implements java.io.Serializable {

	private Integer dbid;
	private CustomerInfrom customerInfrom;
	//统计状态：1、参与统计；2、不参与统计
	private Integer staStatus;
	//统计代码
	private Integer codeNum;
	//别名
	private String alias;
	//分公司ID
	private Integer enterpriseId;
	private Date createDate;
	private Date modifyDate;
	//统计总数
	private Integer totalNum;
	//上月留存潜客
	private Integer keepNum;
	//新增倩姐
	private Integer addNum;
	//有效数
	private Integer effTotalNum;
	//无效数 resultStatus=4
	private Integer invTotalNum;
	//线索有效率
	private Float effPer;
	public CustomerInfromStaSet(){
		
	}
	public CustomerInfromStaSet(CustomerInfrom customerInfrom,Enterprise enterprise) {
		this.customerInfrom=customerInfrom;
		this.staStatus=1;
		this.codeNum=customerInfrom.getDbid();
		this.alias=customerInfrom.getName();
		this.enterpriseId=enterprise.getDbid();
		this.createDate=new Date();
		this.modifyDate=new Date();
	}

	public CustomerInfromStaSet(int dbid) {
		this.dbid = dbid;
	}

	public CustomerInfromStaSet(int dbid, Integer customerInfromId,
			Integer staStatus, Integer codeNum, String alias,
			Integer enterpriseId, Date createDate, Date modifyDate) {
		this.dbid = dbid;
		this.staStatus = staStatus;
		this.codeNum = codeNum;
		this.alias = alias;
		this.enterpriseId = enterpriseId;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public CustomerInfrom getCustomerInfrom() {
		return customerInfrom;
	}

	public void setCustomerInfrom(CustomerInfrom customerInfrom) {
		this.customerInfrom = customerInfrom;
	}

	public Integer getStaStatus() {
		return this.staStatus;
	}

	public void setStaStatus(Integer staStatus) {
		this.staStatus = staStatus;
	}

	public Integer getCodeNum() {
		return this.codeNum;
	}

	public void setCodeNum(Integer codeNum) {
		this.codeNum = codeNum;
	}

	public String getAlias() {
		return this.alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Integer getEnterpriseId() {
		return this.enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return this.modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public Integer getEffTotalNum() {
		return effTotalNum;
	}
	public void setEffTotalNum(Integer effTotalNum) {
		this.effTotalNum = effTotalNum;
	}
	public Integer getInvTotalNum() {
		return invTotalNum;
	}
	public void setInvTotalNum(Integer invTotalNum) {
		this.invTotalNum = invTotalNum;
	}
	/**
	 * @return the effPer
	 */
	public Float getEffPer() {
		return effPer;
	}
	/**
	 * @param effPer the effPer to set
	 */
	public void setEffPer(Float effPer) {
		this.effPer = effPer;
	}
	public Integer getKeepNum() {
		return keepNum;
	}
	public void setKeepNum(Integer keepNum) {
		this.keepNum = keepNum;
	}
	public Integer getAddNum() {
		return addNum;
	}
	public void setAddNum(Integer addNum) {
		this.addNum = addNum;
	}

}
