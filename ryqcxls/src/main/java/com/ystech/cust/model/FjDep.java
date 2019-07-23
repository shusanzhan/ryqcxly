package com.ystech.cust.model;

public class FjDep {
	//部门ID
	private Integer dbid;
	//查询部门负责人是 ，获取用户名称
	private  String  realName;
	//部门名称
	private String name;
	//成交客户
	private Integer successNum;
	//附加总额
	private Integer fjzje;
	//平均数
	private Double avg;
	//实际销售金额
	private Integer acturePrice;
	//销售装饰
	private  Integer decoreSaleTotalPrce;
	//折扣率
	private Double zkl;
	//赠送装饰
	private Integer giveTotalPrice;
	//贷款总额
	private Integer loanPrice;
	//贷款数量
	private Integer loanNum;
	//贷款渗透率
	private Double stl;
	
	public Integer getDbid() {
		return dbid;
	}
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSuccessNum() {
		return successNum;
	}
	public void setSuccessNum(Integer successNum) {
		this.successNum = successNum;
	}
	
	public Integer getFjzje() {
		return fjzje;
	}
	public void setFjzje(Integer fjzje) {
		this.fjzje = fjzje;
	}
	public Double getAvg() {
		return avg;
	}
	public void setAvg(Double avg) {
		this.avg = avg;
	}
	public Integer getDecoreSaleTotalPrce() {
		return decoreSaleTotalPrce;
	}
	public void setDecoreSaleTotalPrce(Integer decoreSaleTotalPrce) {
		this.decoreSaleTotalPrce = decoreSaleTotalPrce;
	}
	public Double getZkl() {
		return zkl;
	}
	public void setZkl(Double zkl) {
		this.zkl = zkl;
	}
	public Integer getGiveTotalPrice() {
		return giveTotalPrice;
	}
	public void setGiveTotalPrice(Integer giveTotalPrice) {
		this.giveTotalPrice = giveTotalPrice;
	}
	public Integer getActurePrice() {
		return acturePrice;
	}
	public void setActurePrice(Integer acturePrice) {
		this.acturePrice = acturePrice;
	}
	public Integer getLoanPrice() {
		return loanPrice;
	}
	public void setLoanPrice(Integer loanPrice) {
		this.loanPrice = loanPrice;
	}
	public Integer getLoanNum() {
		return loanNum;
	}
	public void setLoanNum(Integer loanNum) {
		this.loanNum = loanNum;
	}
	public Double getStl() {
		return stl;
	}
	public void setStl(Double stl) {
		this.stl = stl;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
	
}
