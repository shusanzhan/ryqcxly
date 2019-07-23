package com.ystech.stat.customer.model;

import java.util.Date;

public class Track extends TrackComm{
	//来店时间
	public Date createDate;
	public Track(){
		
	}
	public Track(Date createDate){
		this.createDate=createDate;
		this.trackAllNum=0;
		this.trackNum=0;
		this.trackOverPer=0f;
		this.trackOverTimeNum=0;
		this.trackPer=0f;
		this.waitNum=0;
		this.waitTrackEdNum=0;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
}
