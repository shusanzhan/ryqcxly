package com.ystech.xwqr.model.sys;

import java.util.List;
import java.util.Set;

// Generated 2013-5-23 0:03:33 by Hibernate Tools 4.0.0

/**
 * Department generated by hbm2java
 */
public class Department implements java.io.Serializable {
	//部门根节点
	public static Integer ROOT=0;
	//普通组织结构
	public static Integer TYPECOMM=1;
	//分店
	public static Integer TYPEBRANCH=2;
	
	//业务部门，1、行政部门；
	public static final Integer BUSSITYPEADMIN=1;
	//业务部门，2、业务部门
	public static final Integer BUSSITYPEABUSSI=2;
	
	private Integer dbid;
	private String name;
	private String discription;
	private Integer parentId;
	private Integer suqNo;
	private String phone;
	private String fax;
	private User manager;
	private List<Department> children;
	private Enterprise enterprise;
	//部门类型，1、普通的组织结构节点；2、分店组织机构节点
	private Integer type;
	//业务部门，1、行政部门；2、业务部门
	private Integer bussiType;
	public Department() {
	}

	public Department(String name, String discription, Integer parentId,
			Integer suqNo) {
		this.name = name;
		this.discription = discription;
		this.parentId = parentId;
		this.suqNo = suqNo;
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

	public String getDiscription() {
		return this.discription;
	}

	public void setDiscription(String discription) {
		this.discription = discription;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Integer getSuqNo() {
		return this.suqNo;
	}

	public void setSuqNo(Integer suqNo) {
		this.suqNo = suqNo;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public User getManager() {
		return manager;
	}

	public void setManager(User manager) {
		this.manager = manager;
	}

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getBussiType() {
		return bussiType;
	}

	public void setBussiType(Integer bussiType) {
		this.bussiType = bussiType;
	}
	

}
