package com.ystech.agent.model;

// Generated 2018-8-16 14:22:21 by Hibernate Tools 4.0.0

import java.util.Date;

/**
 * AgentAgentsetlevel generated by hbm2java
 */
public class AgentSetLevel implements java.io.Serializable {

	private Integer dbid;
	private Integer agentSetId;
	private Integer beginNum;
	private Integer endNum;
	private Float rewardMoney;
	private Date createTime;
	private Date modifyTime;

	public AgentSetLevel() {
	}

	public AgentSetLevel(Integer agentSetId, Integer beginNum,
			Integer endNum, Float rewardMoney, Date createTime, Date modifyTime) {
		this.agentSetId = agentSetId;
		this.beginNum = beginNum;
		this.endNum = endNum;
		this.rewardMoney = rewardMoney;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getAgentSetId() {
		return this.agentSetId;
	}

	public void setAgentSetId(Integer agentSetId) {
		this.agentSetId = agentSetId;
	}

	public Integer getBeginNum() {
		return this.beginNum;
	}

	public void setBeginNum(Integer beginNum) {
		this.beginNum = beginNum;
	}

	public Integer getEndNum() {
		return this.endNum;
	}

	public void setEndNum(Integer endNum) {
		this.endNum = endNum;
	}

	public Float getRewardMoney() {
		return this.rewardMoney;
	}

	public void setRewardMoney(Float rewardMoney) {
		this.rewardMoney = rewardMoney;
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

}