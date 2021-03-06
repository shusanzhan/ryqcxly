package com.ystech.xwqr.set.model;

// Generated 2014-1-6 15:19:33 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Brand generated by hbm2java
 */
public class Brand implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String type;
	private String logo;
	private String url;
	private String introduction;
	private Date createTime;
	private Date modifyTime;
	private Integer orderNum;
	private Set  productCategories=new HashSet(0);
	private Set products = new HashSet(0);
	private Integer enterpriseId;

	public Brand() {
	}

	public Brand(String name, String type, String logo, String url,
			String introduction, Date createTime, Date modifyTime,
			Integer orderNum, Integer companyId, Set productbrandcategories,
			Set products) {
		this.name = name;
		this.type = type;
		this.logo = logo;
		this.url = url;
		this.introduction = introduction;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.orderNum = orderNum;
		this.products = products;
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

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLogo() {
		return this.logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getIntroduction() {
		return this.introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
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

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public Set getProductCategories() {
		return productCategories;
	}

	public void setProductCategories(Set productCategories) {
		this.productCategories = productCategories;
	}

	public Set getProducts() {
		return this.products;
	}

	public void setProducts(Set products) {
		this.products = products;
	}

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

}
