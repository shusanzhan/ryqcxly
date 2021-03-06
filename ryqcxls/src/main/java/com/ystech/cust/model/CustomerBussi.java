package com.ystech.cust.model;

import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;

// Generated 2014-2-23 13:31:11 by Hibernate Tools 4.0.0

/**
 * 来电信息评估表
 * Customerbussi generated by hbm2java
 */
public class CustomerBussi implements java.io.Serializable {

	private Integer dbid;
	private Customer customer;
	private BuyCarCare buyCarCare;
	private BuyCarTarget buyCarTarget;
	private BuyCarType buyCarType;
	private CarModel carModel;
	private CarSeriy carSeriy;
	private Brand brand;
	private BuyCarBudget buyCarBudget;
	private BuyCarMainUse buyCarMainUse;
	private String note;
	
	private String customerSpecification;
	private String customerNeed;
	private String customerCareAbout;
	private String otherMainDescription;
	private String afterPlan;

	public CustomerBussi() {
	}

	public CustomerBussi(Integer dbid) {
		this.dbid = dbid;
	}

	public CustomerBussi(int dbid, Customer customer, Integer bussiFrom,
			Integer buyCarCareId, Integer buyCarTargetId, Integer buyCarTypeId,
			Integer buyCarModelId, Integer buyCarBudgetId,
			Integer buyCarMainUseId, Integer buyCarTimeId,
			String customerSpecification, String customerNeed,
			String customerCareAbout, String otherMainDescription,
			String afterPlan, Integer lastResultId, Integer lastBuyCarModelId,
			String carColor, String vinCode, Boolean isCarPlate,
			String carPlateNo, Boolean isBuySafe, Boolean isBoutique) {
		this.dbid = dbid;
		this.customer = customer;
		this.customerSpecification = customerSpecification;
		this.customerNeed = customerNeed;
		this.customerCareAbout = customerCareAbout;
		this.otherMainDescription = otherMainDescription;
		this.afterPlan = afterPlan;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}


	public String getCustomerSpecification() {
		return this.customerSpecification;
	}

	public void setCustomerSpecification(String customerSpecification) {
		this.customerSpecification = customerSpecification;
	}

	public String getCustomerNeed() {
		return this.customerNeed;
	}

	public void setCustomerNeed(String customerNeed) {
		this.customerNeed = customerNeed;
	}

	public String getCustomerCareAbout() {
		return this.customerCareAbout;
	}

	public void setCustomerCareAbout(String customerCareAbout) {
		this.customerCareAbout = customerCareAbout;
	}

	public String getOtherMainDescription() {
		return this.otherMainDescription;
	}

	public void setOtherMainDescription(String otherMainDescription) {
		this.otherMainDescription = otherMainDescription;
	}

	public String getAfterPlan() {
		return this.afterPlan;
	}

	public void setAfterPlan(String afterPlan) {
		this.afterPlan = afterPlan;
	}


	public BuyCarCare getBuyCarCare() {
		return buyCarCare;
	}

	public void setBuyCarCare(BuyCarCare buyCarCare) {
		this.buyCarCare = buyCarCare;
	}

	public BuyCarTarget getBuyCarTarget() {
		return buyCarTarget;
	}

	public void setBuyCarTarget(BuyCarTarget buyCarTarget) {
		this.buyCarTarget = buyCarTarget;
	}

	public BuyCarType getBuyCarType() {
		return buyCarType;
	}

	public void setBuyCarType(BuyCarType buyCarType) {
		this.buyCarType = buyCarType;
	}

	public CarModel getCarModel() {
		return carModel;
	}

	public void setCarModel(CarModel carModel) {
		this.carModel = carModel;
	}

	public BuyCarBudget getBuyCarBudget() {
		return buyCarBudget;
	}

	public void setBuyCarBudget(BuyCarBudget buyCarBudget) {
		this.buyCarBudget = buyCarBudget;
	}

	public BuyCarMainUse getBuyCarMainUse() {
		return buyCarMainUse;
	}

	public void setBuyCarMainUse(BuyCarMainUse buyCarMainUse) {
		this.buyCarMainUse = buyCarMainUse;
	}


	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public CarSeriy getCarSeriy() {
		return carSeriy;
	}

	public void setCarSeriy(CarSeriy carSeriy) {
		this.carSeriy = carSeriy;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}



}
