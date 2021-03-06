package com.ystech.cust.model;

// Generated 2016-10-24 11:13:36 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * CustMarketingact generated by hbm2java
 */
public class CustMarketingAct implements java.io.Serializable {
	private Integer dbid;
	//活动主题
	private String name;
	//活动内容
	private String content;
	//创建时间
	private Date createDate;
	//修改时间
	private Date modifyDate;
	//活动开始时间
	private Date actStartDate;
	//活动结束时间
	private Date actEndDate;
	//邀约人数
	private Integer inviteNum;
	//意向客户
	private Integer intentionCustNum;
	//目标客户
	private Integer targetPersonNum;
	//企业ID
	private Integer enterpriseId;

	public CustMarketingAct() {
	}

	public CustMarketingAct(String name, String content, Date createDate,
			Date modifyDate, Date actStartDate, Date actEndDate,
			Integer inviteNum, Integer intentionCustNum, Integer targetPersonNum) {
		this.name = name;
		this.content = content;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.actStartDate = actStartDate;
		this.actEndDate = actEndDate;
		this.inviteNum = inviteNum;
		this.intentionCustNum = intentionCustNum;
		this.targetPersonNum = targetPersonNum;
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

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Date getActStartDate() {
		return this.actStartDate;
	}

	public void setActStartDate(Date actStartDate) {
		this.actStartDate = actStartDate;
	}

	public Date getActEndDate() {
		return this.actEndDate;
	}

	public void setActEndDate(Date actEndDate) {
		this.actEndDate = actEndDate;
	}

	public Integer getInviteNum() {
		return this.inviteNum;
	}

	public void setInviteNum(Integer inviteNum) {
		this.inviteNum = inviteNum;
	}

	public Integer getIntentionCustNum() {
		return this.intentionCustNum;
	}

	public void setIntentionCustNum(Integer intentionCustNum) {
		this.intentionCustNum = intentionCustNum;
	}

	public Integer getTargetPersonNum() {
		return this.targetPersonNum;
	}

	public void setTargetPersonNum(Integer targetPersonNum) {
		this.targetPersonNum = targetPersonNum;
	}

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}
