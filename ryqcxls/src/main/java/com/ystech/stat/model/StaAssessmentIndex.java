package com.ystech.stat.model;
// Generated 2018-9-28 11:54:13 by Hibernate Tools 4.0.0.Final

import java.util.Date;
import java.util.Set;

/**
 * StaAssessmentindex generated by hbm2java
 */
public class StaAssessmentIndex implements java.io.Serializable {

	private Integer dbid;
	//指标名称
	private String name;
	//指标备注
	private String note;
	//创建时间
	private Date createTime;
	//修改时间
	private Date modifyTime;
	//类型：1、系统创建；2、自定义创建
	private Integer type;
	//行业平均值
	private Integer indexNum;
	private Set<StaAssessmentIndexLevel> staAssessmentIndexLevels;
	public StaAssessmentIndex() {
	}

	public StaAssessmentIndex(String name, String note, Date createTime, Date modifyTime, Integer type,
			Integer indexNum) {
		this.name = name;
		this.note = note;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.type = type;
		this.indexNum = indexNum;
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

	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
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

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getIndexNum() {
		return this.indexNum;
	}

	public void setIndexNum(Integer indexNum) {
		this.indexNum = indexNum;
	}

	public Set<StaAssessmentIndexLevel> getStaAssessmentIndexLevels() {
		return staAssessmentIndexLevels;
	}

	public void setStaAssessmentIndexLevels(
			Set<StaAssessmentIndexLevel> staAssessmentIndexLevels) {
		this.staAssessmentIndexLevels = staAssessmentIndexLevels;
	}

}
