package com.ystech.stat.customer.model;

import java.util.Date;

public class Flow extends FlowComm{
	public Date createDate;
	//净增客户
	public Integer addNum;
	public Date getCreateDate() {
		return createDate;
	}
	
	public Integer getAddNum() {
		return addNum;
	}

	public void setAddNum(Integer addNum) {
		this.addNum = addNum;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Flow(){
		
	}
	public Flow(Date creDate){
		this.createDate=creDate;
		this.addNum=0;
		this.flowNum=0;
		this.createFolderNum=0;
	}
		
}
