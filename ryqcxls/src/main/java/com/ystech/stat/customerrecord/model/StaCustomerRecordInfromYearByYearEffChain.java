package com.ystech.stat.customerrecord.model;

public class StaCustomerRecordInfromYearByYearEffChain extends StaYearByYearChain{
	private Integer dbid;
	private String alias;
	//当前有效率
	private Float nowEffPer;
	//上月有效
	private Float preEffPer;
	//上年有效
	private Float yearByYearEffPer;
	public StaCustomerRecordInfromYearByYearEffChain(){
		
	}
	public  StaCustomerRecordInfromYearByYearEffChain(String nowDate,String preDate,String yearByYearDate) {
		super(nowDate, preDate, yearByYearDate);
	}
	/**
	 * @return the dbid
	 */
	public Integer getDbid() {
		return dbid;
	}
	/**
	 * @param dbid the dbid to set
	 */
	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}
	/**
	 * @return the alias
	 */
	public String getAlias() {
		return alias;
	}
	/**
	 * @param alias the alias to set
	 */
	public void setAlias(String alias) {
		this.alias = alias;
	}
	/**
	 * @return the nowEffPer
	 */
	public Float getNowEffPer() {
		return nowEffPer;
	}
	/**
	 * @param nowEffPer the nowEffPer to set
	 */
	public void setNowEffPer(Float nowEffPer) {
		this.nowEffPer = nowEffPer;
	}
	/**
	 * @return the preEffPer
	 */
	public Float getPreEffPer() {
		return preEffPer;
	}
	/**
	 * @param preEffPer the preEffPer to set
	 */
	public void setPreEffPer(Float preEffPer) {
		this.preEffPer = preEffPer;
	}
	/**
	 * @return the yearByYearEffPer
	 */
	public Float getYearByYearEffPer() {
		return yearByYearEffPer;
	}
	/**
	 * @param yearByYearEffPer the yearByYearEffPer to set
	 */
	public void setYearByYearEffPer(Float yearByYearEffPer) {
		this.yearByYearEffPer = yearByYearEffPer;
	}
	
}
