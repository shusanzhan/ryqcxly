package com.ystech.xwqr.set.model;

// Generated 2015-1-15 9:16:53 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * SetLoantype generated by hbm2java
 */
public class LoanType implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private Integer orderNum;
	private Date createTime;
	private Date modifyTime;
	private LoanType parent;
	private String note;
	private Integer totalNum;

	public LoanType() {
	}

	public LoanType(String name, Integer orderNum, Date createTime,
			Date modifyTime, Integer parentId, String note) {
		this.name = name;
		this.orderNum = orderNum;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.note = note;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public LoanType getParent() {
		return parent;
	}

	public void setParent(LoanType parent) {
		this.parent = parent;
	}

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}

}