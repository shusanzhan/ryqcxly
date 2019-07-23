package com.ystech.cust.model;

public class SalerProfit {
	//客户ID
	public Integer customerId;
	//客户姓名
	public String name;
	//联系电话
	public String mobilePhone;
	//部门
	public String depName;
	//销售顾问
	public String bussiStaff;
	//品牌
	public String brandName;
	//车系
	public String csName;
	//车型
	public String cmName;
	//颜色
	public String carColorName;
	//总数量
	public int num;
	//合同总额
	public Float totalPrice;
	//车辆结算价
	public Float carSalerPrice;
	//裸车销售价
	public Float carGrofitPrice;
	//按揭手续费
	public Float ajsxf;
	//按揭手续费毛利
	public Float ajsxfGrofit;
	//预收款
	public Float advanceTotalPrice;
	//装饰销售顾问结算
	public Float decoreGrofitPrice;
	//按揭销售顾问
	public Float salerPrice;
	//保险提成
	public Float insSalerPrice;
	//利润
	public Float profitMoney;
	/**
	 * @return the customerId
	 */
	public Integer getCustomerId() {
		return customerId;
	}
	/**
	 * @param customerId the customerId to set
	 */
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the mobilePhone
	 */
	public String getMobilePhone() {
		return mobilePhone;
	}
	/**
	 * @param mobilePhone the mobilePhone to set
	 */
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	/**
	 * @return the depName
	 */
	public String getDepName() {
		return depName;
	}
	/**
	 * @param depName the depName to set
	 */
	public void setDepName(String depName) {
		this.depName = depName;
	}
	/**
	 * @return the bussiStaff
	 */
	public String getBussiStaff() {
		return bussiStaff;
	}
	/**
	 * @param bussiStaff the bussiStaff to set
	 */
	public void setBussiStaff(String bussiStaff) {
		this.bussiStaff = bussiStaff;
	}
	/**
	 * @return the brandName
	 */
	public String getBrandName() {
		return brandName;
	}
	/**
	 * @param brandName the brandName to set
	 */
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	/**
	 * @return the csName
	 */
	public String getCsName() {
		return csName;
	}
	/**
	 * @param csName the csName to set
	 */
	public void setCsName(String csName) {
		this.csName = csName;
	}
	/**
	 * @return the cmName
	 */
	public String getCmName() {
		return cmName;
	}
	/**
	 * @param cmName the cmName to set
	 */
	public void setCmName(String cmName) {
		this.cmName = cmName;
	}
	/**
	 * @return the carColorName
	 */
	public String getCarColorName() {
		return carColorName;
	}
	/**
	 * @param carColorName the carColorName to set
	 */
	public void setCarColorName(String carColorName) {
		this.carColorName = carColorName;
	}
	/**
	 * @return the totalPrice
	 */
	public Float getTotalPrice() {
		return totalPrice;
	}
	/**
	 * @param totalPrice the totalPrice to set
	 */
	public void setTotalPrice(Float totalPrice) {
		this.totalPrice = totalPrice;
	}
	/**
	 * @return the carSalerPrice
	 */
	public Float getCarSalerPrice() {
		return carSalerPrice;
	}
	/**
	 * @param carSalerPrice the carSalerPrice to set
	 */
	public void setCarSalerPrice(Float carSalerPrice) {
		this.carSalerPrice = carSalerPrice;
	}
	/**
	 * @return the ajsxf
	 */
	public Float getAjsxf() {
		return ajsxf;
	}
	/**
	 * @param ajsxf the ajsxf to set
	 */
	public void setAjsxf(Float ajsxf) {
		this.ajsxf = ajsxf;
	}
	/**
	 * @return the advanceTotalPrice
	 */
	public Float getAdvanceTotalPrice() {
		return advanceTotalPrice;
	}
	/**
	 * @param advanceTotalPrice the advanceTotalPrice to set
	 */
	public void setAdvanceTotalPrice(Float advanceTotalPrice) {
		this.advanceTotalPrice = advanceTotalPrice;
	}
	
	public Float getDecoreGrofitPrice() {
		return decoreGrofitPrice;
	}
	public void setDecoreGrofitPrice(Float decoreGrofitPrice) {
		this.decoreGrofitPrice = decoreGrofitPrice;
	}
	/**
	 * @return the salerPrice
	 */
	public Float getSalerPrice() {
		return salerPrice;
	}
	/**
	 * @param salerPrice the salerPrice to set
	 */
	public void setSalerPrice(Float salerPrice) {
		this.salerPrice = salerPrice;
	}
	/**
	 * @return the insSalerPrice
	 */
	public Float getInsSalerPrice() {
		return insSalerPrice;
	}
	/**
	 * @param insSalerPrice the insSalerPrice to set
	 */
	public void setInsSalerPrice(Float insSalerPrice) {
		this.insSalerPrice = insSalerPrice;
	}
	/**
	 * @return the profitMoney
	 */
	public Float getProfitMoney() {
		return profitMoney;
	}
	/**
	 * @param profitMoney the profitMoney to set
	 */
	public void setProfitMoney(Float profitMoney) {
		this.profitMoney = profitMoney;
	}
	/**
	 * @return the num
	 */
	public int getNum() {
		return num;
	}
	/**
	 * @param num the num to set
	 */
	public void setNum(int num) {
		this.num = num;
	}
	public Float getCarGrofitPrice() {
		return carGrofitPrice;
	}
	public void setCarGrofitPrice(Float carGrofitPrice) {
		this.carGrofitPrice = carGrofitPrice;
	}
	public Float getAjsxfGrofit() {
		return ajsxfGrofit;
	}
	public void setAjsxfGrofit(Float ajsxfGrofit) {
		this.ajsxfGrofit = ajsxfGrofit;
	}
	 
}
