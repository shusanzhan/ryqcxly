package com.ystech.qywx.model;

import java.io.Serializable;

public class Count implements Serializable{
	private Integer dbid;
	private String name;
	private Integer num;
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
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	
}
