package com.ystech.stat.customerrecord.model;

/**
 * 功能描述：同比/环比数据结构
 * 
 * @author Administrator
 *
 */
public class StaYearByYearChain {
	//当期日期
	public String nowDate;
	//当前日期统计数据
	public Integer nowNum;
	//环比日期
	public String preDate;
	//环比数据
	public Integer preNum;
	//环比百分比
	public Float chainPer;
	//同比日期
	public String yearByYearDate;
	//同比数据
	public Integer yearByYearNum;
	//同比百分比
	public Float yreaByYearPer;
	
	public StaYearByYearChain(){
		
	}
	public StaYearByYearChain(String nowDate,String preDate,String yearByYearDate){
		this.nowDate=nowDate;
		this.preDate=preDate;
		this.yearByYearDate=yearByYearDate;
	}
	/**
	 * @return the nowDate
	 */
	public String getNowDate() {
		return nowDate;
	}

	/**
	 * @param nowDate
	 *            the nowDate to set
	 */
	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}

	/**
	 * @return the nowNum
	 */
	public Integer getNowNum() {
		return nowNum;
	}

	/**
	 * @param nowNum
	 *            the nowNum to set
	 */
	public void setNowNum(Integer nowNum) {
		this.nowNum = nowNum;
	}

	/**
	 * @return the preDate
	 */
	public String getPreDate() {
		return preDate;
	}

	/**
	 * @param preDate
	 *            the preDate to set
	 */
	public void setPreDate(String preDate) {
		this.preDate = preDate;
	}

	/**
	 * @return the preNum
	 */
	public Integer getPreNum() {
		return preNum;
	}

	/**
	 * @param preNum
	 *            the preNum to set
	 */
	public void setPreNum(Integer preNum) {
		this.preNum = preNum;
	}

	/**
	 * @return the chainPer
	 */
	public Float getChainPer() {
		return chainPer;
	}

	/**
	 * @param chainPer
	 *            the chainPer to set
	 */
	public void setChainPer(Float chainPer) {
		this.chainPer = chainPer;
	}

	/**
	 * @return the yearByYearDate
	 */
	public String getYearByYearDate() {
		return yearByYearDate;
	}

	/**
	 * @param yearByYearDate
	 *            the yearByYearDate to set
	 */
	public void setYearByYearDate(String yearByYearDate) {
		this.yearByYearDate = yearByYearDate;
	}

	/**
	 * @return the yearByYearNum
	 */
	public Integer getYearByYearNum() {
		return yearByYearNum;
	}

	/**
	 * @param yearByYearNum
	 *            the yearByYearNum to set
	 */
	public void setYearByYearNum(Integer yearByYearNum) {
		this.yearByYearNum = yearByYearNum;
	}

	/**
	 * @return the yreaByYearPer
	 */
	public Float getYreaByYearPer() {
		return yreaByYearPer;
	}

	/**
	 * @param yreaByYearPer
	 *            the yreaByYearPer to set
	 */
	public void setYreaByYearPer(Float yreaByYearPer) {
		this.yreaByYearPer = yreaByYearPer;
	}

}
