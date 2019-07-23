/**
 * 
 */
package com.ystech.cust.model;

import java.io.Serializable;

/**
 * @author shusanzhan
 * @date 2014-5-15
 */
public class CarSerCount implements Serializable{
	private String serName;
	private Integer serid;
	private String name;
	private Integer countNum;
	private Double per;
	private String salePrice;
	public CarSerCount(){
		
	}
	public String getSerName() {
		return serName;
	}
	public void setSerName(String serName) {
		this.serName = serName;
	}
	public Integer getSerid() {
		return serid;
	}
	public void setSerid(Integer serid) {
		this.serid = serid;
	}
	public Integer getCountNum() {
		return countNum;
	}
	public void setCountNum(Integer countNum) {
		this.countNum = countNum;
	}
	public Double getPer() {
		return per;
	}
	public void setPer(Double per) {
		this.per = per;
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
