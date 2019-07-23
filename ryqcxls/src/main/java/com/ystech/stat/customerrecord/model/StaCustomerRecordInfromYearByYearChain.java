package com.ystech.stat.customerrecord.model;

/**
 * 功能描述：网销同比环比统计
 * @author Administrator
 *
 */
public class StaCustomerRecordInfromYearByYearChain extends StaYearByYearChain{
	private Integer dbid;
	private String alias;
	public StaCustomerRecordInfromYearByYearChain(){
		
	}
	public  StaCustomerRecordInfromYearByYearChain(String nowDate,String preDate,String yearByYearDate) {
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
	
}
