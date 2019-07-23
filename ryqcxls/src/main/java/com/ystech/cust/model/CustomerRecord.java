package com.ystech.cust.model;

// Generated 2016-10-8 12:01:13 by Hibernate Tools 4.0.0

import java.util.Date;

import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * Customerrecord generated by hbm2java
 */
public class CustomerRecord implements java.io.Serializable {
	//来店状态有效
	public static Integer STATUSCOMM=1;
	//来店状态无效
	public static Integer STATUSINVAL=2;
	
	//最终结果 默认1
	public static Integer RESULTCOMM=1;
	//最终结果 转登记2
	public static Integer RESULTRECORD=2;
	//最终结果3 登记客户 转为回访
	public static Integer RESULTTRACK=3;
	//最终结果 无效4
	public static Integer RESULTINVALIT=4;
	
	//来店次数 1为默认
	public static Integer COMEINNUMCOMM=1;
	//多次来店 2为二次进店
	public static Integer COMEINNUMMORE=2;
	
	//超时状态 1为默认
	public static Integer OVERTIMECOMM=1;
	//超时状态 2为二次进店
	public static Integer OVERTIMEED=2;

	//线索类型：1、进店，
	public static Integer TYPECOMESHOP=1;
	//线索类型：2、来店
	public static Integer TYPEPHONE=2;
	//线索类型：3、网销导入
	public static Integer TYPENETEXPORT=3;
	public static Integer TYPE=1;
	
	private Integer dbid;
	//进店目的
	private CustomerRecordTarget customerRecordTarget;
	//进店时间
	private String comeInTime;
	//客户随行人数
	private Integer customerNum;
	//性别
	private String sex;
	//创建时间
	private Date createDate;
	//修改时间
	private Date modifyDate;
	//销售顾问
	private User saler;
	//销售顾问姓名
	private String salerName;
	//客户姓名
	private String name;
	//联系电话
	private String mobilePhone;
	//客户来源
	private CustomerInfrom customerInfrom;
	//品牌
	private Brand brand;
	//车系
	private CarSeriy carSeriy;
	//车型
	private CarModel carModel;

	private String carModelStr;
	//备注
	private String note;
	//创建人
	private User user;
	private String creator;
	//状态1、有效；2、无效(前台录入数据）
	private Integer status;
	//客户销售顾问登记状态 1、默认；2、转登记；3、无效，4、已回访
	private Integer resultStatus;
	//处理日期
	private Date resultDate;
	//线索无效
	private CustomerRecordClubInvalidReason  customerRecordClubInvalidReason;
	//线索无效备注
	private String invalidNote;
	//企业ID
	private Enterprise enterprise;
	//来店次数 0、未进店；1、初次到店；2、二次到店;
	private Integer comeinNum;
	
	//是否生成客户，初次到店：有效线索是否生成客户，二次到店：是否绑定客户
	private Customer customer;
	
	private String address;
	//
	private String carModels;
	//代办人
	private User agentUser;
	//超时状态
	private Integer overtimeStatus;
	//超时次数
	private Integer overtimeNum;
	//1、前台接待 进店；2、前台接待 来电；3、网销导入；4、活动；5、其他
	private CustomerType customerType;
	//进店类型：1、展厅进店；2、网销进店
	private Integer comeInType;
	//来店时间段
	private Integer comeInHour;
	
	public CustomerRecord() {
	}

	public CustomerRecord(CustomerRecordTarget customerrecordtarget,
			Integer comeInTime, Integer customerNum, Integer type,
			Date createDate, Date modifyDate, Integer salerId, String name,
			String mobilePhone, Integer infromId, String note,
			Integer creatorId, Integer status, Integer resultStatus,
			Integer invalidReasonId, String invalidNote, Integer enterpriseId) {
		this.customerNum = customerNum;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.name = name;
		this.mobilePhone = mobilePhone;
		this.note = note;
		this.status = status;
		this.resultStatus = resultStatus;
		this.invalidNote = invalidNote;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public CustomerRecordTarget getCustomerRecordTarget() {
		return customerRecordTarget;
	}

	public void setCustomerRecordTarget(CustomerRecordTarget customerRecordTarget) {
		this.customerRecordTarget = customerRecordTarget;
	}

	public String getComeInTime() {
		return this.comeInTime;
	}

	public void setComeInTime(String comeInTime) {
		this.comeInTime = comeInTime;
	}

	public Integer getCustomerNum() {
		return this.customerNum;
	}

	public void setCustomerNum(Integer customerNum) {
		this.customerNum = customerNum;
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

	public User getSaler() {
		return saler;
	}

	public void setSaler(User saler) {
		this.saler = saler;
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


	public CustomerInfrom getCustomerInfrom() {
		return customerInfrom;
	}

	public void setCustomerInfrom(CustomerInfrom customerInfrom) {
		this.customerInfrom = customerInfrom;
	}

	public String getNote() {
		return this.note;
	}

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public void setNote(String note) {
		this.note = note;
	}


	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getResultStatus() {
		return this.resultStatus;
	}

	public void setResultStatus(Integer resultStatus) {
		this.resultStatus = resultStatus;
	}


	public CustomerRecordClubInvalidReason getCustomerRecordClubInvalidReason() {
		return customerRecordClubInvalidReason;
	}

	public void setCustomerRecordClubInvalidReason(
			CustomerRecordClubInvalidReason customerRecordClubInvalidReason) {
		this.customerRecordClubInvalidReason = customerRecordClubInvalidReason;
	}

	public String getInvalidNote() {
		return this.invalidNote;
	}

	public void setInvalidNote(String invalidNote) {
		this.invalidNote = invalidNote;
	}


	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getComeinNum() {
		return comeinNum;
	}

	public void setComeinNum(Integer comeinNum) {
		this.comeinNum = comeinNum;
	}

	public Date getResultDate() {
		return resultDate;
	}

	public void setResultDate(Date resultDate) {
		this.resultDate = resultDate;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}


	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public CarSeriy getCarSeriy() {
		return carSeriy;
	}

	public void setCarSeriy(CarSeriy carSeriy) {
		this.carSeriy = carSeriy;
	}

	public CarModel getCarModel() {
		return carModel;
	}

	public void setCarModel(CarModel carModel) {
		this.carModel = carModel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCarModels() {
		return carModels;
	}

	public void setCarModels(String carModels) {
		this.carModels = carModels;
	}

	public User getAgentUser() {
		return agentUser;
	}

	public void setAgentUser(User agentUser) {
		this.agentUser = agentUser;
	}

	public Integer getOvertimeStatus() {
		return overtimeStatus;
	}

	public void setOvertimeStatus(Integer overtimeStatus) {
		this.overtimeStatus = overtimeStatus;
	}

	public Integer getOvertimeNum() {
		return overtimeNum;
	}

	public void setOvertimeNum(Integer overtimeNum) {
		this.overtimeNum = overtimeNum;
	}

	/**
	 * @return the customerType
	 */
	public CustomerType getCustomerType() {
		return customerType;
	}

	/**
	 * @param customerType the customerType to set
	 */
	public void setCustomerType(CustomerType customerType) {
		this.customerType = customerType;
	}

	/**
	 * @return the salerName
	 */
	public String getSalerName() {
		return salerName;
	}

	/**
	 * @param salerName the salerName to set
	 */
	public void setSalerName(String salerName) {
		this.salerName = salerName;
	}

	public String getCarModelStr() {
		return carModelStr;
	}

	public void setCarModelStr(String carModelStr) {
		this.carModelStr = carModelStr;
	}

	public Integer getComeInHour() {
		return comeInHour;
	}

	public void setComeInHour(Integer comeInHour) {
		this.comeInHour = comeInHour;
	}

	public Integer getComeInType() {
		return comeInType;
	}

	public void setComeInType(Integer comeInType) {
		this.comeInType = comeInType;
	}
	

}