package com.ystech.weixin.model;

// Generated 2015-6-11 14:42:54 by Hibernate Tools 4.0.0

import java.util.Date;

import com.ystech.mem.model.Member;
import com.ystech.mem.model.SpreadDetail;

/**
 * WeixinGzuserinfo generated by hbm2java
 */
public class WeixinGzuserinfo implements java.io.Serializable {

	private Integer dbid;
	private String subscribe;//用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息。
	private String openid;//用户的标识，对当前公众号唯一
	private String nickname;//用户的昵称
	private String sex;//用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
	private String city;//用户所在城市
	private String province;//国家用户所在省份
	private String country;//用户所在国
	private String headimgurl;//用户头像，最后一个数值代表正方形头像大小（
	private String bzName;
	private String groupId;//	用户所在的分组ID
	private String subscribeTime;//用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间
	private String remark;//公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注
	private String unionid;//只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段
	private Date addtime;//关注事件
	private String language;//语言
	private Integer eventStatus;//0.未关注，关注状态1关注、2、取消关注
	private Date cancelDate;//取消关注时间
	private Integer accountid;//公纵号ID
	private WeixinGzuserinfo parent;
	private SpreadDetail spreadDetail;
	//会员类型 1、默认；2、渠道商
	private Integer memType;
	private Integer enterpriseId;
	public WeixinGzuserinfo() {
	}

	public WeixinGzuserinfo(String subscribe, String openid, String nickname,
			String sex, String city, String province, String country,
			String headimgurl, String bzName, String groupId,
			String subscribeTime, Date addtime, Integer accountid) {
		this.subscribe = subscribe;
		this.openid = openid;
		this.nickname = nickname;
		this.sex = sex;
		this.city = city;
		this.province = province;
		this.country = country;
		this.headimgurl = headimgurl;
		this.bzName = bzName;
		this.groupId = groupId;
		this.subscribeTime = subscribeTime;
		this.addtime = addtime;
		this.accountid = accountid;
	}

	public Integer getDbid() {
		return this.dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public String getSubscribe() {
		return this.subscribe;
	}

	public void setSubscribe(String subscribe) {
		this.subscribe = subscribe;
	}

	public String getOpenid() {
		return this.openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getNickname() {
		return this.nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getHeadimgurl() {
		return this.headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}

	public String getBzName() {
		return this.bzName;
	}

	public void setBzName(String bzName) {
		this.bzName = bzName;
	}

	public String getGroupId() {
		return this.groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getSubscribeTime() {
		return this.subscribeTime;
	}

	public void setSubscribeTime(String subscribeTime) {
		this.subscribeTime = subscribeTime;
	}

	public Date getAddtime() {
		return this.addtime;
	}

	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public Integer getAccountid() {
		return this.accountid;
	}

	public void setAccountid(Integer accountid) {
		this.accountid = accountid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUnionid() {
		return unionid;
	}

	public void setUnionid(String unionid) {
		this.unionid = unionid;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public Integer getEventStatus() {
		return eventStatus;
	}

	public void setEventStatus(Integer eventStatus) {
		this.eventStatus = eventStatus;
	}

	public Date getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}

	public WeixinGzuserinfo getParent() {
		return parent;
	}

	public void setParent(WeixinGzuserinfo parent) {
		this.parent = parent;
	}

	public SpreadDetail getSpreadDetail() {
		return spreadDetail;
	}

	public void setSpreadDetail(SpreadDetail spreadDetail) {
		this.spreadDetail = spreadDetail;
	}


	public Integer getMemType() {
		return memType;
	}

	public void setMemType(Integer memType) {
		this.memType = memType;
	}

	public Integer getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
}
