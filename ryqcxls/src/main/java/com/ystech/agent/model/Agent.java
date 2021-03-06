package com.ystech.agent.model;

// Generated 2016-2-29 21:39:09 by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.Set;

import com.ystech.xwqr.model.sys.Area;

/**
 * AgentAgent generated by hbm2java
 */
public class Agent implements java.io.Serializable {
	public static Integer STATUSCOMM=1;
	public static Integer STATUSYES=2;
	public static Integer STATUSNO=3;
	private Integer dbid;
	//名称
	private String name;
	//联系电话
	private String mobilePhone;
	//邮箱
	private String email;
	//省市区
	private String province;
	//省Id
	private Integer provinceId;
	//城市
	private String city;
	//区域
	private String areaStr;
	//性别
	private String sex;
	//英航
	private String bank;
	//账号
	private String bankNo;
	//创建时间
	private Date createDate;
	//修改时间
	private Date modifyDate;
	//申请时间
	private Date applyDate;
	//出生年月
	private Date birthday;
	//推荐人数
	private Integer agentNum;
	//推荐成功数
	private Integer agentSuccessNum;
	//审批状态
	private Integer status;
	//审批人
	private String approvePerson;
	//审批时间
	private Date approveDate;
	//微信ID
	private String openId;
	//返利总额
	private Float turnBackMoney;
	//积分
	private Integer pointNum;
	//区域
	private Area area;
	//身份证
	private String icard;
	public Agent() {
	}

	public Agent(String name, String mobilePhone, String email,
			String province, String city, String area, String sex, String bank,
			String bankNo, Date createDate, Date modifyDate, Date applyDate,
			Date birthday, Integer agentNum, Integer agentSuccessNum,
			Integer status, String approvePerson, Date approveDate,
			Set agentRecommendcustomerfs) {
		this.name = name;
		this.mobilePhone = mobilePhone;
		this.email = email;
		this.province = province;
		this.city = city;
		this.sex = sex;
		this.bank = bank;
		this.bankNo = bankNo;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.applyDate = applyDate;
		this.birthday = birthday;
		this.agentNum = agentNum;
		this.agentSuccessNum = agentSuccessNum;
		this.status = status;
		this.approvePerson = approvePerson;
		this.approveDate = approveDate;
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

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}


	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBank() {
		return this.bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBankNo() {
		return this.bankNo;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
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

	public Date getApplyDate() {
		return this.applyDate;
	}

	public void setApplyDate(Date applyDate) {
		this.applyDate = applyDate;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Integer getAgentNum() {
		return this.agentNum;
	}

	public void setAgentNum(Integer agentNum) {
		this.agentNum = agentNum;
	}

	public Integer getAgentSuccessNum() {
		return this.agentSuccessNum;
	}

	public void setAgentSuccessNum(Integer agentSuccessNum) {
		this.agentSuccessNum = agentSuccessNum;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getApprovePerson() {
		return this.approvePerson;
	}

	public void setApprovePerson(String approvePerson) {
		this.approvePerson = approvePerson;
	}

	public Date getApproveDate() {
		return this.approveDate;
	}

	public void setApproveDate(Date approveDate) {
		this.approveDate = approveDate;
	}

	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public Float getTurnBackMoney() {
		return turnBackMoney;
	}

	public void setTurnBackMoney(Float turnBackMoney) {
		this.turnBackMoney = turnBackMoney;
	}

	public Integer getPointNum() {
		return pointNum;
	}

	public void setPointNum(Integer pointNum) {
		this.pointNum = pointNum;
	}


	public String getAreaStr() {
		return areaStr;
	}

	public void setAreaStr(String areaStr) {
		this.areaStr = areaStr;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getIcard() {
		return icard;
	}

	public void setIcard(String icard) {
		this.icard = icard;
	}

	public Integer getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}



}
