package com.ystech.stat.customer.model;


public class FlowComeShopType extends FlowComm {
	public Integer dbid;
	//线索类型名称
	public String name;
	
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
}
