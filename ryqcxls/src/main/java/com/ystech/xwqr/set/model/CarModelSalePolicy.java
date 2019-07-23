package com.ystech.xwqr.set.model;

// Generated 2016-4-26 14:07:29 by Hibernate Tools 4.0.0

/**
 * Carmodelsalepolicy generated by hbm2java
 */
public class CarModelSalePolicy implements java.io.Serializable {
	public static Integer STOP=2;
	public static Integer START=1;
	private Integer dbid;
	private String name;
	private Brand brand;
	private CarSeriy carSeriy;
	private String yearModel;
	//指导价
	private Long navPrice;
	//经销商报价
	private Long salePrice;
	//展厅销售顾问结算价
	private Long saleCsprice;
	//最近一次修改结算价
	private Long historyCsprice;
	//网销销售顾问结算价
	private Long netSaleCsprice;
	//网销销售顾问最近一次修改结算价
	private Long netHsitoryCsprice;
	//区域销售顾问结算价
	private Long areaSaleCsprice;
	//区域销售顾问最近一次修改结算价
	private Long areaHsitoryCsprice;
	private Integer orderNum;
	private Integer enterpriseId;
	private Integer status;
	private CarModel carModel;
	//库龄奖励设置状态;1、启用；2、停用
	private Integer ageRewardStatus;
	//金融奖励设置状态;1、启用；2、停用
	private Integer finRewardStatus;
	//车型奖励设置状态;1、启用；2、停用
	private Integer carModelRewarStatus;
	//车型奖励金额
	private Integer carModelPrice;

	public CarModelSalePolicy() {
	}

	public CarModelSalePolicy(String name) {
		this.name = name;
	}

	public CarModelSalePolicy(String name, Integer brandId,
			Integer carSeriesId, String yearModel, Long navPrice,
			Long salePrice, Long saleCsprice, Long historyCsprice,
			Integer orderNum, Integer enterpriseId, Integer status,
			Integer carModelId) {
		this.name = name;
		this.yearModel = yearModel;
		this.navPrice = navPrice;
		this.salePrice = salePrice;
		this.saleCsprice = saleCsprice;
		this.historyCsprice = historyCsprice;
		this.orderNum = orderNum;
		this.enterpriseId = enterpriseId;
		this.status = status;
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

	public String getYearModel() {
		return this.yearModel;
	}

	public void setYearModel(String yearModel) {
		this.yearModel = yearModel;
	}

	public Long getNavPrice() {
		return this.navPrice;
	}

	public void setNavPrice(Long navPrice) {
		this.navPrice = navPrice;
	}

	public Long getSalePrice() {
		return this.salePrice;
	}

	public void setSalePrice(Long salePrice) {
		this.salePrice = salePrice;
	}

	public Long getSaleCsprice() {
		return this.saleCsprice;
	}

	public void setSaleCsprice(Long saleCsprice) {
		this.saleCsprice = saleCsprice;
	}

	public Long getHistoryCsprice() {
		return this.historyCsprice;
	}

	public void setHistoryCsprice(Long historyCsprice) {
		this.historyCsprice = historyCsprice;
	}

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	public Integer getEnterpriseId() {
		return this.enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public CarModel getCarModel() {
		return carModel;
	}

	public void setCarModel(CarModel carModel) {
		this.carModel = carModel;
	}

	public Integer getAgeRewardStatus() {
		return ageRewardStatus;
	}

	public void setAgeRewardStatus(Integer ageRewardStatus) {
		this.ageRewardStatus = ageRewardStatus;
	}

	public Integer getFinRewardStatus() {
		return finRewardStatus;
	}

	public void setFinRewardStatus(Integer finRewardStatus) {
		this.finRewardStatus = finRewardStatus;
	}

	public Integer getCarModelRewarStatus() {
		return carModelRewarStatus;
	}

	public void setCarModelRewarStatus(Integer carModelRewarStatus) {
		this.carModelRewarStatus = carModelRewarStatus;
	}

	public Integer getCarModelPrice() {
		return carModelPrice;
	}

	public void setCarModelPrice(Integer carModelPrice) {
		this.carModelPrice = carModelPrice;
	}

	public Long getNetSaleCsprice() {
		return netSaleCsprice;
	}

	public void setNetSaleCsprice(Long netSaleCsprice) {
		this.netSaleCsprice = netSaleCsprice;
	}

	public Long getNetHsitoryCsprice() {
		return netHsitoryCsprice;
	}

	public void setNetHsitoryCsprice(Long netHsitoryCsprice) {
		this.netHsitoryCsprice = netHsitoryCsprice;
	}

	public Long getAreaSaleCsprice() {
		return areaSaleCsprice;
	}

	public void setAreaSaleCsprice(Long areaSaleCsprice) {
		this.areaSaleCsprice = areaSaleCsprice;
	}

	public Long getAreaHsitoryCsprice() {
		return areaHsitoryCsprice;
	}

	public void setAreaHsitoryCsprice(Long areaHsitoryCsprice) {
		this.areaHsitoryCsprice = areaHsitoryCsprice;
	}
	

}
