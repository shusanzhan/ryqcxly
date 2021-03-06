package com.ystech.mem.model;

// Generated 2014-4-10 18:03:39 by Hibernate Tools 4.0.0

import java.util.Date;
import java.util.Set;

/**会员定向券，会员领用券信息
 * Coupon generated by hbm2java
 */
public class CouponMemberTemplate implements java.io.Serializable {
	
	private Integer dbid;
	//优惠券名称
	private String name;
	//优惠券类型 代金券、折扣券
	private Integer type;
	//图片
	private String image;
	//优惠券描述
	private String description;
	//是否启用
	private boolean enabled;
	//创建时间
	private Date createTime;
	//修改时间
	private Date modifyTime;
	private boolean showHiden;
	private Integer enterpriseId;
	public CouponMemberTemplate() {
	}
	public CouponMemberTemplate(String name, float moneyOrRabatt, Date startTime,
			Date stopTime, boolean isExchange, boolean enabled) {
		this.name = name;
		this.enabled = enabled;
	}

	public CouponMemberTemplate(String name, Integer type, byte[] image, Float conditions,
			float moneyOrRabatt, Integer ausgabeCount, Integer userReceiveNum,
			Integer receivedNum, Date startTime, Date stopTime,
			String description, boolean isExchange, Integer exchangeNum,
			boolean enabled, Date createTime, Date modifyTime, Integer bussiId,
			Set couponcodes) {
		this.name = name;
		this.type = type;
		this.description = description;
		this.enabled = enabled;
		this.createTime = createTime;
		this.modifyTime = modifyTime;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}



	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	public boolean isEnabled() {
		return this.enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public boolean getShowHiden() {
		return showHiden;
	}
	public void setShowHiden(boolean showHiden) {
		this.showHiden = showHiden;
	}
	public Integer getEnterpriseId() {
		return enterpriseId;
	}
	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	
}
