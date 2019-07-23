package com.ystech.stat.customer.model;

/**
 * 功能描述：试乘试驾车型统计
 * @author Administrator
 *
 */
public class StaCarSeriyTryCar extends TryCarComm {
	public Integer dbid;
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
