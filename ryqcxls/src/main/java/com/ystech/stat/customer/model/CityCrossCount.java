/**
 * 
 */
package com.ystech.stat.customer.model;

/**
 * @author shusanzhan
 * @date 2014-7-5
 */
public class CityCrossCount {
	private Integer dbid;
	private Integer totalCount;
	private String name;
	private Integer totalOrderCount;
	private Float orderPer;
	private Integer totalFlowCount;
	private Float flowPer;
	public Integer getDbid() {
		return dbid;
	}
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getTotalOrderCount() {
		return totalOrderCount;
	}
	public void setTotalOrderCount(Integer totalOrderCount) {
		this.totalOrderCount = totalOrderCount;
	}
	public Float getOrderPer() {
		return orderPer;
	}
	public void setOrderPer(Float orderPer) {
		this.orderPer = orderPer;
	}
	public Integer getTotalFlowCount() {
		return totalFlowCount;
	}
	public void setTotalFlowCount(Integer totalFlowCount) {
		this.totalFlowCount = totalFlowCount;
	}
	public Float getFlowPer() {
		return flowPer;
	}
	public void setFlowPer(Float flowPer) {
		this.flowPer = flowPer;
	}
	
}
