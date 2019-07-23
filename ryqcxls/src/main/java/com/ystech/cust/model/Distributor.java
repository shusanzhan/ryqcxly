package com.ystech.cust.model;

// Generated 2014-8-9 16:04:11 by Hibernate Tools 4.0.0

import java.util.Date;

import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

/**
 * Distributor generated by hbm2java
 */
public class Distributor implements java.io.Serializable {

	private Integer dbid;
	private String name;
	private String shortName;
	private String legalRep;
	private String icard;
	private Date birthday;
	private String address;
	private String mobilePhone;
	private String phone;
	private String bond;
	private String companyAddress;
	private Integer companyAttr;
	private Date startCooperation;
	private Date createTime;
	private Date modifyTime;
	//创建人Id
	private Integer creatorId;
	//创建人姓名
	private String creatorName;
	private String note;
	private Area companyArea;
	private Area legalArea;
	private DistributorType distributorType;
	private String billingName;
	private String taxtpaperIdentifactionNumber;
	private String addressPhone;
	private String bankAccountNo;
	//所属公司
	private Enterprise enterprise;
	//分配区域专员
	private User user;
	//区域专员所在部门
	private Department department;
	private String pinYin;
	//经销商类型：1、合作经销商；2、非合作经销商
	private Integer type;
	public Distributor() {
	}

	public Distributor(String name, String shortName, String legalRep,
			String icard, Date birthday, String address, String mobilePhone,
			String phone, String bond, String companyAddress,
			Integer companyAttr, Date startCooperation, Date createTime,
			Date modifyTime, Integer creatorId, String creatorName) {
		this.name = name;
		this.shortName = shortName;
		this.legalRep = legalRep;
		this.icard = icard;
		this.birthday = birthday;
		this.address = address;
		this.mobilePhone = mobilePhone;
		this.phone = phone;
		this.bond = bond;
		this.companyAddress = companyAddress;
		this.companyAttr = companyAttr;
		this.startCooperation = startCooperation;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
		this.creatorId = creatorId;
		this.creatorName = creatorName;
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

	public String getShortName() {
		return this.shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getLegalRep() {
		return this.legalRep;
	}

	public void setLegalRep(String legalRep) {
		this.legalRep = legalRep;
	}

	public String getIcard() {
		return this.icard;
	}

	public void setIcard(String icard) {
		this.icard = icard;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBond() {
		return this.bond;
	}

	public void setBond(String bond) {
		this.bond = bond;
	}

	public String getCompanyAddress() {
		return this.companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	public Integer getCompanyAttr() {
		return this.companyAttr;
	}

	public void setCompanyAttr(Integer companyAttr) {
		this.companyAttr = companyAttr;
	}

	public Date getStartCooperation() {
		return this.startCooperation;
	}

	public void setStartCooperation(Date startCooperation) {
		this.startCooperation = startCooperation;
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

	public Integer getCreatorId() {
		return this.creatorId;
	}

	public void setCreatorId(Integer creatorId) {
		this.creatorId = creatorId;
	}

	public String getCreatorName() {
		return this.creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Area getCompanyArea() {
		return companyArea;
	}

	public void setCompanyArea(Area companyArea) {
		this.companyArea = companyArea;
	}

	public Area getLegalArea() {
		return legalArea;
	}

	public void setLegalArea(Area legalArea) {
		this.legalArea = legalArea;
	}

	public DistributorType getDistributorType() {
		return distributorType;
	}

	public void setDistributorType(DistributorType distributorType) {
		this.distributorType = distributorType;
	}

	public String getBillingName() {
		return billingName;
	}

	public void setBillingName(String billingName) {
		this.billingName = billingName;
	}

	public String getTaxtpaperIdentifactionNumber() {
		return taxtpaperIdentifactionNumber;
	}

	public void setTaxtpaperIdentifactionNumber(String taxtpaperIdentifactionNumber) {
		this.taxtpaperIdentifactionNumber = taxtpaperIdentifactionNumber;
	}

	public String getAddressPhone() {
		return addressPhone;
	}

	public void setAddressPhone(String addressPhone) {
		this.addressPhone = addressPhone;
	}

	public String getBankAccountNo() {
		return bankAccountNo;
	}

	public void setBankAccountNo(String bankAccountNo) {
		this.bankAccountNo = bankAccountNo;
	}

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getPinYin() {
		return pinYin;
	}

	public void setPinYin(String pinYin) {
		this.pinYin = pinYin;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
	
}