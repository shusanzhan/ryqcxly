package com.ystech.stat.customerrecord.model;

public class StatCustomerRecordUser extends StatDataSort{
	public Integer dbid;
	//姓名
	public String realName;
	//总接待客户
	public Integer totalNum;
	//销售顾问自己登记到店线索
	public Integer salerSelfNum;
	//前台登记线索
	public Integer receptionNum;
	//上月留存潜客
	private Integer keepNum;
	//新增潜客
	private Integer addNum;
	//未处理
	private Integer notDealNum;
	//来店线索（转登记到数据）
	private Integer otherNum;
	//来店看车无效线索
	private Integer unableNum;
	//首次到店客户=总接待客户-来店线索（转登记到数据）
	private Integer fristComeNum;
	//建档客户
	public Integer creatorFolderNum;
	//建档率
	public Float creatorFolderPer;
	public StatCustomerRecordUser() {
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
	 * @return the realName
	 */
	public String getRealName() {
		return realName;
	}
	/**
	 * @param realName the realName to set
	 */
	public void setRealName(String realName) {
		this.realName = realName;
	}
	/**
	 * @return the totalNum
	 */
	public Integer getTotalNum() {
		return totalNum;
	}
	/**
	 * @param totalNum the totalNum to set
	 */
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	/**
	 * @return the creatorFolderNum
	 */
	public Integer getCreatorFolderNum() {
		return creatorFolderNum;
	}
	/**
	 * @param creatorFolderNum the creatorFolderNum to set
	 */
	public void setCreatorFolderNum(Integer creatorFolderNum) {
		this.creatorFolderNum = creatorFolderNum;
	}
	/**
	 * @return the creatorFolderPer
	 */
	public Float getCreatorFolderPer() {
		return creatorFolderPer;
	}
	/**
	 * @param creatorFolderPer the creatorFolderPer to set
	 */
	public void setCreatorFolderPer(Float creatorFolderPer) {
		this.creatorFolderPer = creatorFolderPer;
	}
	public Integer getKeepNum() {
		return keepNum;
	}
	public void setKeepNum(Integer keepNum) {
		this.keepNum = keepNum;
	}
	public Integer getAddNum() {
		return addNum;
	}
	public void setAddNum(Integer addNum) {
		this.addNum = addNum;
	}
	public void setOtherNum(Integer otherNum) {
		this.otherNum = otherNum;
	}
	public void setUnableNum(Integer unableNum) {
		this.unableNum = unableNum;
	}
	public void setFristComeNum(Integer fristComeNum) {
		this.fristComeNum = fristComeNum;
	}
	public Integer getOtherNum() {
		return otherNum;
	}
	public Integer getUnableNum() {
		return unableNum;
	}
	public Integer getFristComeNum() {
		return fristComeNum;
	}
	public Integer getSalerSelfNum() {
		return salerSelfNum;
	}
	public void setSalerSelfNum(Integer salerSelfNum) {
		this.salerSelfNum = salerSelfNum;
	}
	public Integer getReceptionNum() {
		return receptionNum;
	}
	public void setReceptionNum(Integer receptionNum) {
		this.receptionNum = receptionNum;
	}
	public Integer getNotDealNum() {
		return notDealNum;
	}
	public void setNotDealNum(Integer notDealNum) {
		this.notDealNum = notDealNum;
	}
	
}
