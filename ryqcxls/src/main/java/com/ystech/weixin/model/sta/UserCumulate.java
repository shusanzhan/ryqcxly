package com.ystech.weixin.model.sta;

// Generated 2015-10-20 12:04:28 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * WeixinStaUsercumulate generated by hbm2java
 */
public class UserCumulate implements java.io.Serializable {

	private Integer dbid;
	private Integer cumulateUser;
	private Date refDate;
	private Integer accountId;

	public UserCumulate() {
	}

	public UserCumulate(Integer cumulateUser, Date refDate,
			Integer wechatCompanyId) {
		this.cumulateUser = cumulateUser;
		this.refDate = refDate;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getCumulateUser() {
		return this.cumulateUser;
	}

	public void setCumulateUser(Integer cumulateUser) {
		this.cumulateUser = cumulateUser;
	}

	public Date getRefDate() {
		return this.refDate;
	}

	public void setRefDate(Date refDate) {
		this.refDate = refDate;
	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}


}
