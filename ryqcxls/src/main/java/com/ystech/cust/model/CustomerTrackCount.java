/**
 *  @author shusanzhan
 *  @date  2017年4月30日
 *  @dis   
 */

package com.ystech.cust.model;

public class CustomerTrackCount {
	//经销商Id
	private Integer companyId;
	//大区名称
	private String depName;
	//经销商名称
	private String companyName;
	//回访总量
	private Integer total;
	//已回访总数
	private Integer trackedNum;
	//未回访数overCloseTrackNum
	private Integer notTrackNum;
	//关闭任务
	private Integer closeTrackNum;
	//超时总数
	private Integer overTimeTrackNum;
	//超时未回访
	private Integer overTimeNotTrackNum;
	//超时已经回访
	private Integer overTimeTrackedNum;
	//任务关闭超时数据
	private Integer overTimeCloseNum;
	public Integer getCompanyId() {
		return companyId;
	}
	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getTrackedNum() {
		return trackedNum;
	}
	public void setTrackedNum(Integer trackedNum) {
		this.trackedNum = trackedNum;
	}
	public Integer getNotTrackNum() {
		return notTrackNum;
	}
	public void setNotTrackNum(Integer notTrackNum) {
		this.notTrackNum = notTrackNum;
	}
	public Integer getOverTimeTrackNum() {
		return overTimeTrackNum;
	}
	public void setOverTimeTrackNum(Integer overTimeTrackNum) {
		this.overTimeTrackNum = overTimeTrackNum;
	}
	public Integer getOverTimeNotTrackNum() {
		return overTimeNotTrackNum;
	}
	public void setOverTimeNotTrackNum(Integer overTimeNotTrackNum) {
		this.overTimeNotTrackNum = overTimeNotTrackNum;
	}
	public Integer getOverTimeTrackedNum() {
		return overTimeTrackedNum;
	}
	public void setOverTimeTrackedNum(Integer overTimeTrackedNum) {
		this.overTimeTrackedNum = overTimeTrackedNum;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getDepName() {
		return depName;
	}
	public void setDepName(String depName) {
		this.depName = depName;
	}
	public Integer getCloseTrackNum() {
		return closeTrackNum;
	}
	public void setCloseTrackNum(Integer closeTrackNum) {
		this.closeTrackNum = closeTrackNum;
	}
	public Integer getOverTimeCloseNum() {
		return overTimeCloseNum;
	}
	public void setOverTimeCloseNum(Integer overTimeCloseNum) {
		this.overTimeCloseNum = overTimeCloseNum;
	}
	
}
