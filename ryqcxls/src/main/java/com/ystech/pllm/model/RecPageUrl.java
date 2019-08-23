package com.ystech.pllm.model;
// Generated 2016-8-19 22:40:49 by Hibernate Tools 4.0.0.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * PllmRecPageurl generated by hbm2java
 */
public class RecPageUrl implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String url;
	private Date createDate;
	private Date modifyDate;
	private Integer num;
	private String note;
	private Integer clickNum;
	//分享次数
	private Integer shareNum;
	//分享阅读次数
	private Integer readNum;
	private Set pllmRecPagerecords = new HashSet(0);

	public RecPageUrl() {
	}

	public RecPageUrl(int dbid) {
		this.dbid = dbid;
	}

	public RecPageUrl(int dbid, String name, String url, Date createDate, Date modifyDate, Integer num,
			Integer clickNum, Set pllmRecPagerecords) {
		this.dbid = dbid;
		this.name = name;
		this.url = url;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.num = num;
		this.clickNum = clickNum;
		this.pllmRecPagerecords = pllmRecPagerecords;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
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

	public Integer getNum() {
		return this.num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getClickNum() {
		return this.clickNum;
	}

	public void setClickNum(Integer clickNum) {
		this.clickNum = clickNum;
	}

	public Set getPllmRecPagerecords() {
		return this.pllmRecPagerecords;
	}

	public void setPllmRecPagerecords(Set pllmRecPagerecords) {
		this.pllmRecPagerecords = pllmRecPagerecords;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getShareNum() {
		return shareNum;
	}

	public void setShareNum(Integer shareNum) {
		this.shareNum = shareNum;
	}

	public Integer getReadNum() {
		return readNum;
	}

	public void setReadNum(Integer readNum) {
		this.readNum = readNum;
	}
	
}