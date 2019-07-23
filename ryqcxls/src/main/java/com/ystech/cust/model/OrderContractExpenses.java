package com.ystech.cust.model;

// Generated 2015-1-9 15:36:47 by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;

import com.ystech.xwqr.set.model.LoanType;


/**
 * Ordercontractexpenses generated by hbm2java
 * 收款明细表单
 */
public class OrderContractExpenses implements java.io.Serializable {

	private Integer dbid;
	//合同总金额
	private Double totalPrice;
	//+合同总额-预收总额
	private Double revenuePrice;
	//预付款总金额(大客户+惠民+二手车置换）
	private Double advanceTotalPrice;
	
	//挂车金额
	private Double trailerPrice;
	//挂车结算价
	private Double trailerSalerPrice;
	
	//车辆销售价(经销商报价）
	private Double salePrice;
	//车辆销售顾问结算价（销售每月政策）
	private Double carSalerPrice;
	//车辆总价（裸车销售价+挂车）
	private Double carTotalPrice;
	
	//车辆实际销售价(营收-装饰-按揭-其他）
	private Double carActurePrice;
	//车辆盈利预估(车款-销售顾问结算价）
	private Double carGrofitPrice;
	
	//装饰款
	private Double decoreMoney;
	//装饰销售顾问结算价
	private Double decoreCostMoney;
	//装饰盈利预估（装饰-结算价）
	private Double decoreGrofitPrice;
	
	//其他收费总金额
	private Double otherFeePrice;
	//其他收费项目总成本
	private Double otherCostFeePrice;
	
	//颜色溢价
	private Double colorPrice;
	
	//单车总盈利预估(裸车盈利预估+装饰盈利预估+按揭+其他收费+预收保险） 挂车
	private Double totalGrofitPrice;
		
	//按揭手续费
	private Double ajsxf;
	//按揭手续费盈利
	private Double ajsxfGrofit;
	//按揭手续费扣除基础系数
	private Double ajsxBase;
	
	//优惠款项（弃用）
	private Double preferentialTogether;
	//定金
	private Double orderMoney;
	
	//附加总金额(弃用）
	private Double fjzje;
	//贷款类型
	private LoanType loanType;
	//定金大写
	private String bigOrderMoney;
	
	//首付比例
	private Double paymentPer;
	//首付款
	private Double sfk;
	//贷款额度
	private Double daikuan;
	//按揭车款
	private Double loanCarPrice;
	//购买方式1、正常；2、按揭
	private Integer buyCarType;
	//贷款产品
	private String finProductName;
	//贷款期限
	private String finProductItemName;
	
	//付款方式
	private Integer payWay;
	
	
	//特殊权限
	private Double specialPermPrice;
	//特殊权限备注
	private String specialPermNote;
	
	private OrderContract orderContract;
	//现金优惠金额
	private Double cashBenefit;
	//未折让权限 裸车实际销售价-销售顾问结算价
	private Double noWllowancePrice;
	private Customer customer;
	private Set ordercontractexpensespreferenceitems = new HashSet(0);
	private Set ordercontractexpenseschargeitems = new HashSet(0);
	//装饰款是否计入主合同；开票价
	private Integer decorePriceOrderStatus;
	
	//装饰款计入主合同
	private Double masterDecoreMoney;
	//这块计入附加合同
	private Double attachDecoreMoney;
	
	//垫付状态:1、正常；2、垫付；
	private Integer loanPaymentType;

	//垫付金额
	private Double loanPaymentPrice;
	//垫付期限
	private String loanPaymentTerm;
	//垫付支付利息
	private Double loanPaymentInterest;
	//垫付月还
	private Double loanPaybackMonthMoney;
	
	//预收保费
	private Double preInsMoney;
	//实际保费
	private Double insMoney;
	//保费返利
	private Double insMoneyGrofit;
	//保费利润扣除系数
	private Double insMoneyBase;
	
	//实际收款金额
	private Double actureCollectedPrice;
	//续保押金
	private Double insaranceRenewalDepositPrice;
	//合同低开票
	private Double lowInvoicePrice;
	//备注
	private String note;
	
	public OrderContractExpenses() {
	}

	public OrderContractExpenses(int dbid) {
		this.dbid = dbid;
	}

	public OrderContractExpenses(int dbid, Integer buyCarType, Integer payWay,
			Double salePrice, Double totalPrice, Double preferentialTogether,
			Double decoreMoney, Double sfk, Double daikuan, Double orderMoney,
			String bigOrderMoney, Integer ordercontractId,
			Set ordercontractexpensespreferenceitems,
			Set ordercontractexpenseschargeitems) {
		this.dbid = dbid;
		this.buyCarType = buyCarType;
		this.payWay = payWay;
		this.salePrice = salePrice;
		this.totalPrice = totalPrice;
		this.preferentialTogether = preferentialTogether;
		this.decoreMoney = decoreMoney;
		this.sfk = sfk;
		this.daikuan = daikuan;
		this.orderMoney = orderMoney;
		this.bigOrderMoney = bigOrderMoney;
		this.ordercontractexpensespreferenceitems = ordercontractexpensespreferenceitems;
		this.ordercontractexpenseschargeitems = ordercontractexpenseschargeitems;
	}


	public Integer getDbid() {
		return dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getBuyCarType() {
		return this.buyCarType;
	}

	public void setBuyCarType(Integer buyCarType) {
		this.buyCarType = buyCarType;
	}

	public Integer getPayWay() {
		return this.payWay;
	}

	public void setPayWay(Integer payWay) {
		this.payWay = payWay;
	}

	public Double getSalePrice() {
		return this.salePrice;
	}

	public void setSalePrice(Double salePrice) {
		this.salePrice = salePrice;
	}

	public Double getTotalPrice() {
		return this.totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Double getPreferentialTogether() {
		return this.preferentialTogether;
	}

	public void setPreferentialTogether(Double preferentialTogether) {
		this.preferentialTogether = preferentialTogether;
	}

	public Double getDecoreMoney() {
		return this.decoreMoney;
	}

	public void setDecoreMoney(Double decoreMoney) {
		this.decoreMoney = decoreMoney;
	}

	public Double getSfk() {
		return this.sfk;
	}

	public void setSfk(Double sfk) {
		this.sfk = sfk;
	}

	public Double getDaikuan() {
		return this.daikuan;
	}

	public void setDaikuan(Double daikuan) {
		this.daikuan = daikuan;
	}

	public Double getOrderMoney() {
		return this.orderMoney;
	}

	public void setOrderMoney(Double orderMoney) {
		this.orderMoney = orderMoney;
	}

	public String getBigOrderMoney() {
		return this.bigOrderMoney;
	}

	public void setBigOrderMoney(String bigOrderMoney) {
		this.bigOrderMoney = bigOrderMoney;
	}


	public Set getOrdercontractexpensespreferenceitems() {
		return this.ordercontractexpensespreferenceitems;
	}

	public void setOrdercontractexpensespreferenceitems(
			Set ordercontractexpensespreferenceitems) {
		this.ordercontractexpensespreferenceitems = ordercontractexpensespreferenceitems;
	}

	public Set getOrdercontractexpenseschargeitems() {
		return this.ordercontractexpenseschargeitems;
	}

	public void setOrdercontractexpenseschargeitems(
			Set ordercontractexpenseschargeitems) {
		this.ordercontractexpenseschargeitems = ordercontractexpenseschargeitems;
	}

	public OrderContract getOrderContract() {
		return orderContract;
	}

	public void setOrderContract(OrderContract orderContract) {
		this.orderContract = orderContract;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Double getFjzje() {
		return fjzje;
	}

	public void setFjzje(Double fjzje) {
		this.fjzje = fjzje;
	}

	public LoanType getLoanType() {
		return loanType;
	}

	public void setLoanType(LoanType loanType) {
		this.loanType = loanType;
	}

	public Double getAjsxf() {
		return ajsxf;
	}

	public void setAjsxf(Double ajsxf) {
		this.ajsxf = ajsxf;
	}

	public Double getRevenuePrice() {
		return revenuePrice;
	}

	public void setRevenuePrice(Double revenuePrice) {
		this.revenuePrice = revenuePrice;
	}

	public Double getAdvanceTotalPrice() {
		return advanceTotalPrice;
	}

	public void setAdvanceTotalPrice(Double advanceTotalPrice) {
		this.advanceTotalPrice = advanceTotalPrice;
	}

	public Double getCarSalerPrice() {
		return carSalerPrice;
	}

	public void setCarSalerPrice(Double carSalerPrice) {
		this.carSalerPrice = carSalerPrice;
	}

	public Double getCarActurePrice() {
		return carActurePrice;
	}

	public void setCarActurePrice(Double carActurePrice) {
		this.carActurePrice = carActurePrice;
	}

	public Double getCarGrofitPrice() {
		return carGrofitPrice;
	}

	public void setCarGrofitPrice(Double carGrofitPrice) {
		this.carGrofitPrice = carGrofitPrice;
	}

	public Double getDecoreCostMoney() {
		return decoreCostMoney;
	}

	public void setDecoreCostMoney(Double decoreCostMoney) {
		this.decoreCostMoney = decoreCostMoney;
	}

	public Double getDecoreGrofitPrice() {
		return decoreGrofitPrice;
	}

	public void setDecoreGrofitPrice(Double decoreGrofitPrice) {
		this.decoreGrofitPrice = decoreGrofitPrice;
	}

	public Double getOtherFeePrice() {
		return otherFeePrice;
	}

	public void setOtherFeePrice(Double otherFeePrice) {
		this.otherFeePrice = otherFeePrice;
	}

	public Double getOtherCostFeePrice() {
		return otherCostFeePrice;
	}

	public void setOtherCostFeePrice(Double otherCostFeePrice) {
		this.otherCostFeePrice = otherCostFeePrice;
	}

	public Double getTotalGrofitPrice() {
		return totalGrofitPrice;
	}

	public void setTotalGrofitPrice(Double totalGrofitPrice) {
		this.totalGrofitPrice = totalGrofitPrice;
	}

	public Double getAjsxfGrofit() {
		return ajsxfGrofit;
	}

	public void setAjsxfGrofit(Double ajsxfGrofit) {
		this.ajsxfGrofit = ajsxfGrofit;
	}

	public Double getSpecialPermPrice() {
		return specialPermPrice;
	}

	public void setSpecialPermPrice(Double specialPermPrice) {
		this.specialPermPrice = specialPermPrice;
	}

	public String getSpecialPermNote() {
		return specialPermNote;
	}

	public void setSpecialPermNote(String specialPermNote) {
		this.specialPermNote = specialPermNote;
	}

	public Double getCashBenefit() {
		return cashBenefit;
	}

	public void setCashBenefit(Double cashBenefit) {
		this.cashBenefit = cashBenefit;
	}

	public Double getNoWllowancePrice() {
		return noWllowancePrice;
	}

	public void setNoWllowancePrice(Double noWllowancePrice) {
		this.noWllowancePrice = noWllowancePrice;
	}

	public Double getColorPrice() {
		return colorPrice;
	}

	public void setColorPrice(Double colorPrice) {
		this.colorPrice = colorPrice;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getDecorePriceOrderStatus() {
		return decorePriceOrderStatus;
	}

	public void setDecorePriceOrderStatus(Integer decorePriceOrderStatus) {
		this.decorePriceOrderStatus = decorePriceOrderStatus;
	}

	public Double getMasterDecoreMoney() {
		return masterDecoreMoney;
	}

	public void setMasterDecoreMoney(Double masterDecoreMoney) {
		this.masterDecoreMoney = masterDecoreMoney;
	}

	public Double getAttachDecoreMoney() {
		return attachDecoreMoney;
	}

	public void setAttachDecoreMoney(Double attachDecoreMoney) {
		this.attachDecoreMoney = attachDecoreMoney;
	}

	public Integer getLoanPaymentType() {
		return loanPaymentType;
	}

	public void setLoanPaymentType(Integer loanPaymentType) {
		this.loanPaymentType = loanPaymentType;
	}

	public Double getTrailerPrice() {
		return trailerPrice;
	}

	public void setTrailerPrice(Double trailerPrice) {
		this.trailerPrice = trailerPrice;
	}

	public Double getLoanPaymentPrice() {
		return loanPaymentPrice;
	}

	public void setLoanPaymentPrice(Double loanPaymentPrice) {
		this.loanPaymentPrice = loanPaymentPrice;
	}

	public String getLoanPaymentTerm() {
		return loanPaymentTerm;
	}

	public void setLoanPaymentTerm(String loanPaymentTerm) {
		this.loanPaymentTerm = loanPaymentTerm;
	}

	public Double getLoanPaymentInterest() {
		return loanPaymentInterest;
	}

	public void setLoanPaymentInterest(Double loanPaymentInterest) {
		this.loanPaymentInterest = loanPaymentInterest;
	}

	public Double getLoanPaybackMonthMoney() {
		return loanPaybackMonthMoney;
	}

	public void setLoanPaybackMonthMoney(Double loanPaybackMonthMoney) {
		this.loanPaybackMonthMoney = loanPaybackMonthMoney;
	}

	public Double getPaymentPer() {
		return paymentPer;
	}

	public void setPaymentPer(Double paymentPer) {
		this.paymentPer = paymentPer;
	}

	public Double getPreInsMoney() {
		return preInsMoney;
	}

	public void setPreInsMoney(Double preInsMoney) {
		this.preInsMoney = preInsMoney;
	}

	public Double getTrailerSalerPrice() {
		return trailerSalerPrice;
	}

	public void setTrailerSalerPrice(Double trailerSalerPrice) {
		this.trailerSalerPrice = trailerSalerPrice;
	}

	public Double getActureCollectedPrice() {
		return actureCollectedPrice;
	}

	public void setActureCollectedPrice(Double actureCollectedPrice) {
		this.actureCollectedPrice = actureCollectedPrice;
	}

	public Double getInsaranceRenewalDepositPrice() {
		return insaranceRenewalDepositPrice;
	}

	public void setInsaranceRenewalDepositPrice(Double insaranceRenewalDepositPrice) {
		this.insaranceRenewalDepositPrice = insaranceRenewalDepositPrice;
	}

	public Double getCarTotalPrice() {
		return carTotalPrice;
	}

	public void setCarTotalPrice(Double carTotalPrice) {
		this.carTotalPrice = carTotalPrice;
	}

	public String getFinProductName() {
		return finProductName;
	}

	public void setFinProductName(String finProductName) {
		this.finProductName = finProductName;
	}

	public String getFinProductItemName() {
		return finProductItemName;
	}

	public void setFinProductItemName(String finProductItemName) {
		this.finProductItemName = finProductItemName;
	}

	public Double getLowInvoicePrice() {
		return lowInvoicePrice;
	}

	public void setLowInvoicePrice(Double lowInvoicePrice) {
		this.lowInvoicePrice = lowInvoicePrice;
	}

	public Double getLoanCarPrice() {
		return loanCarPrice;
	}

	public void setLoanCarPrice(Double loanCarPrice) {
		this.loanCarPrice = loanCarPrice;
	}
	
	
	public Double getAjsxBase() {
		return ajsxBase;
	}

	public void setAjsxBase(Double ajsxBase) {
		this.ajsxBase = ajsxBase;
	}

	public Double getInsMoney() {
		return insMoney;
	}

	public void setInsMoney(Double insMoney) {
		this.insMoney = insMoney;
	}

	public Double getInsMoneyGrofit() {
		return insMoneyGrofit;
	}

	public void setInsMoneyGrofit(Double insMoneyGrofit) {
		this.insMoneyGrofit = insMoneyGrofit;
	}

	public Double getInsMoneyBase() {
		return insMoneyBase;
	}

	public void setInsMoneyBase(Double insMoneyBase) {
		this.insMoneyBase = insMoneyBase;
	}

	public Double getCarGrofit(){
		Double carGrofit=Double.valueOf(0);
		if(null==carActurePrice){
			carActurePrice=Double.valueOf(0);
		}
		if(null==carSalerPrice){
			carSalerPrice=Double.valueOf(0);
		}
		carGrofit=carActurePrice-carSalerPrice;
		return carGrofit;
	}
	//单车总盈利预估(裸车盈利预估+装饰盈利预估(装饰提报订单有减除，此部分不显示解除）+按揭+其他收费+预收保险*40%） 挂车
	public Double getTotalGrofit(){
		Double carGrofit = getCarGrofit();
		if(decoreMoney==null){
			decoreMoney=Double.valueOf(0);
		}
		if(ajsxf==null){
			ajsxf=Double.valueOf(0);
		}
		if(otherFeePrice==null){
			otherFeePrice=Double.valueOf(0);
		}
		Double preInsMoneyG = getCarGrofit();
		if(preInsMoneyG==null){
			preInsMoneyG=Double.valueOf(0);
		}else{
			preInsMoneyG=preInsMoneyG*40/100;
		}
		carGrofit=carGrofit+decoreMoney+ajsxf+otherFeePrice+preInsMoneyG;
		return carGrofit;
	}
	//保费预估 预收保险*40%
	public Double getinsGrofit(){
		Double carGrofit = getCarGrofit();
		if(preInsMoney==null){
			carGrofit=Double.valueOf(0);
		}else{
			carGrofit=preInsMoney*40/100;
		}
		return carGrofit;
	}
}