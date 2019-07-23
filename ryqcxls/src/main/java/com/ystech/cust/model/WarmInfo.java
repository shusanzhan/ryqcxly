package com.ystech.cust.model;

// Generated 2014-2-28 9:43:52 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * Warminfo generated by hbm2java
 */
public class WarmInfo implements java.io.Serializable {

	private Integer dbid;
	private String mainTitle;
	private String content;
	private Integer warmType;
	private Integer userId;
	private Date warmDate;
	private Integer method;
	private String finishContent;
	private Boolean finishStatus;
	private Integer cusOrMemId;

	public WarmInfo() {
	}

	public WarmInfo(String mainTitle, String content, Integer warmType,
			Integer userId, Date warmDate, Integer method,
			String finishContent, Boolean finishStatus, Integer cusOrMemId) {
		this.mainTitle = mainTitle;
		this.content = content;
		this.warmType = warmType;
		this.userId = userId;
		this.warmDate = warmDate;
		this.method = method;
		this.finishContent = finishContent;
		this.finishStatus = finishStatus;
		this.cusOrMemId = cusOrMemId;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getMainTitle() {
		return this.mainTitle;
	}

	public void setMainTitle(String mainTitle) {
		this.mainTitle = mainTitle;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getWarmType() {
		return this.warmType;
	}

	public void setWarmType(Integer warmType) {
		this.warmType = warmType;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Date getWarmDate() {
		return this.warmDate;
	}

	public void setWarmDate(Date warmDate) {
		this.warmDate = warmDate;
	}

	public Integer getMethod() {
		return this.method;
	}

	public void setMethod(Integer method) {
		this.method = method;
	}

	public String getFinishContent() {
		return this.finishContent;
	}

	public void setFinishContent(String finishContent) {
		this.finishContent = finishContent;
	}

	public Boolean getFinishStatus() {
		return this.finishStatus;
	}

	public void setFinishStatus(Boolean finishStatus) {
		this.finishStatus = finishStatus;
	}

	public Integer getCusOrMemId() {
		return this.cusOrMemId;
	}

	public void setCusOrMemId(Integer cusOrMemId) {
		this.cusOrMemId = cusOrMemId;
	}

}
