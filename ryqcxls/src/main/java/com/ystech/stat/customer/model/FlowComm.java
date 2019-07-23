package com.ystech.stat.customer.model;

import com.ystech.stat.model.core.StaDateNum;

public class FlowComm extends StaDateNum{
	//创建文档
	public Integer createFolderNum;
	//流失客户
	public Integer flowNum;
	//留存潜客
	public Integer retainNum;
	//总数据
	public Integer totalNum;
	//首次到店率
	public Float flowPer;
	public Integer getCreateFolderNum() {
		return createFolderNum;
	}
	public void setCreateFolderNum(Integer createFolderNum) {
		this.createFolderNum = createFolderNum;
	}
	public Integer getFlowNum() {
		return flowNum;
	}
	public void setFlowNum(Integer flowNum) {
		this.flowNum = flowNum;
	}
	public Integer getRetainNum() {
		return retainNum;
	}
	public void setRetainNum(Integer retainNum) {
		this.retainNum = retainNum;
	}
	public Integer getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(Integer totalNum) {
		this.totalNum = totalNum;
	}
	public Float getFlowPer() {
		return flowPer;
	}
	public void setFlowPer(Float flowPer) {
		this.flowPer = flowPer;
	}
	
}
