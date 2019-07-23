package com.ystech.weixin.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.LogUtil;
import com.ystech.weixin.core.util.WeixinUtil;
import com.ystech.weixin.model.DateNum;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;

@Component("weixinGzuserinfoManageImpl")
public class WeixinGzuserinfoManageImpl extends HibernateEntityDao<WeixinGzuserinfo>{
	//点击事件获取微信用户信息
	public WeixinGzuserinfo saveWeixinGzuserinfo(String openId,String accessToken,WeixinAccount weixinAccount){
		WeixinGzuserinfo weixinGzuserinfo = findUniqueBy("openid", openId);
		String requestUrl = WeixinUtil.userMsgInfo_url.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
		JSONObject jsonObject = WeixinUtil.httpRequest(requestUrl,"GET", null);
		try {
			if (null != jsonObject) {
				if(jsonObject.toString().contains("invalid")){
					logger.error("userMsgInfo_url:接口获取关注粉丝信息发生错误！"+jsonObject.toString());
					return null;
				}
				if(null==weixinGzuserinfo){ 
					weixinGzuserinfo=new WeixinGzuserinfo();
					String subscribe = jsonObject.getString("subscribe");
					if(null!=subscribe)
						weixinGzuserinfo.setSubscribe(subscribe);
					String openid = jsonObject.getString("openid");
					if(null!=openId)
						weixinGzuserinfo.setOpenid(openid);
					String nickname = jsonObject.getString("nickname");
					if(null!=nickname){
						String filterEmoji = filterEmoji(nickname);
						weixinGzuserinfo.setNickname(filterEmoji);
					}
					String sex = jsonObject.getString("sex");
					if(null!=sex)
						weixinGzuserinfo.setSex(sex);
					String language = jsonObject.getString("language");
					if(null!=language)
						weixinGzuserinfo.setLanguage(language);
					String city = jsonObject.getString("city");
					if(null!=city)
						weixinGzuserinfo.setCity(city);
					String province = jsonObject.getString("province");
					if(null!=province)
						weixinGzuserinfo.setProvince(province);
					String country = jsonObject.getString("country");
					if(null!=country)
						weixinGzuserinfo.setCountry(country);
					String headimgurl = jsonObject.getString("headimgurl");
					if(null!=headimgurl)
						weixinGzuserinfo.setHeadimgurl(headimgurl);
					String subscribe_time = jsonObject.getString("subscribe_time");
					if(null!=subscribe_time)
						weixinGzuserinfo.setSubscribeTime(subscribe_time);
					String remark = jsonObject.getString("remark");
					if(null!=remark)
						weixinGzuserinfo.setRemark(remark);
					String groupid = jsonObject.getString("groupid");
					if(null!=groupid)
						weixinGzuserinfo.setGroupId(groupid);
					weixinGzuserinfo.setEventStatus(1);
					weixinGzuserinfo.setAddtime(new Date());
					weixinGzuserinfo.setEnterpriseId(weixinAccount.getEnterpriseId());
					weixinGzuserinfo.setAccountid(weixinAccount.getDbid());
					weixinGzuserinfo.setMemType(1);
					save(weixinGzuserinfo);
					//删除重复数据
					deleteDub(openid);
				}else{
					Integer eventStatus = weixinGzuserinfo.getEventStatus();
					if(eventStatus==0){
						String subscribe = jsonObject.getString("subscribe");
						if(null!=subscribe)
							weixinGzuserinfo.setSubscribe(subscribe);
						String openid = jsonObject.getString("openid");
						if(null!=openId)
							weixinGzuserinfo.setOpenid(openid);
						String nickname = jsonObject.getString("nickname");
						if(null!=nickname){
							String filterEmoji = filterEmoji(nickname);
							weixinGzuserinfo.setNickname(filterEmoji);
						}
						String sex = jsonObject.getString("sex");
						if(null!=sex)
							weixinGzuserinfo.setSex(sex);
						String language = jsonObject.getString("language");
						if(null!=language)
							weixinGzuserinfo.setLanguage(language);
						String city = jsonObject.getString("city");
						if(null!=city)
							weixinGzuserinfo.setCity(city);
						String province = jsonObject.getString("province");
						if(null!=province)
							weixinGzuserinfo.setProvince(province);
						String country = jsonObject.getString("country");
						if(null!=country)
							weixinGzuserinfo.setCountry(country);
						String headimgurl = jsonObject.getString("headimgurl");
						if(null!=headimgurl)
							weixinGzuserinfo.setHeadimgurl(headimgurl);
						String subscribe_time = jsonObject.getString("subscribe_time");
						if(null!=subscribe_time)
							weixinGzuserinfo.setSubscribeTime(subscribe_time);
						String remark = jsonObject.getString("remark");
						if(null!=remark)
							weixinGzuserinfo.setRemark(remark);
						String groupid = jsonObject.getString("groupid");
						if(null!=groupid)
						weixinGzuserinfo.setGroupId(groupid);
						weixinGzuserinfo.setEventStatus(1);
						weixinGzuserinfo.setEnterpriseId(weixinAccount.getEnterpriseId());
						weixinGzuserinfo.setAccountid(weixinAccount.getDbid());
						weixinGzuserinfo.setMemType(1);
						save(weixinGzuserinfo);
						//删除重复数据
						deleteDub(openid);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			weixinGzuserinfo = null;
			// 获取token失败
			String wrongMessage = "获取weixinGzuserinfo失败 errcode:{} errmsg:{}"
					+ jsonObject.getString("errcode")
					+ jsonObject.getString("errmsg");
			logger.error(""+wrongMessage);
		}
		return weixinGzuserinfo;
	}
	//批量同步数据
	public WeixinGzuserinfo saveGzuserinfo(String openId,String accessToken,Integer accountId){
		try {
			String requestUrl = WeixinUtil.userMsgInfo_url.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
			JSONObject jsonObject = WeixinUtil.httpRequest(requestUrl,"GET", null);
			if (null != jsonObject) {
				if(jsonObject.toString().contains("invalid")){
					String wrongMessage = "获取weixinGzuserinfo失败 errcode:{} errmsg:{}"
							+ jsonObject.getString("errcode")
							+ jsonObject.getString("errmsg");
					LogUtil.error(wrongMessage);
					return null;
				}
				
				WeixinGzuserinfo weixinGzuserinfo=new WeixinGzuserinfo();
				String subscribe = jsonObject.getString("subscribe");
				if(null!=subscribe)
					weixinGzuserinfo.setSubscribe(subscribe);
				String openid = jsonObject.getString("openid");
				if(null!=openId)
					weixinGzuserinfo.setOpenid(openid);
				String nickname = jsonObject.getString("nickname");
				if(null!=nickname){
					String filterEmoji = filterEmoji(nickname);
					weixinGzuserinfo.setNickname(filterEmoji);
				}
				String sex = jsonObject.getString("sex");
				if(null!=sex)
					weixinGzuserinfo.setSex(sex);
				String language = jsonObject.getString("language");
				if(null!=language)
					weixinGzuserinfo.setLanguage(language);
				String city = jsonObject.getString("city");
				if(null!=city)
					weixinGzuserinfo.setCity(city);
				String province = jsonObject.getString("province");
				if(null!=province)
					weixinGzuserinfo.setProvince(province);
				String country = jsonObject.getString("country");
				if(null!=country)
					weixinGzuserinfo.setCountry(country);
				String headimgurl = jsonObject.getString("headimgurl");
				if(null!=headimgurl)
					weixinGzuserinfo.setHeadimgurl(headimgurl);
				String subscribe_time = jsonObject.getString("subscribe_time");
				if(null!=subscribe_time)
					weixinGzuserinfo.setSubscribeTime(subscribe_time);
				/*String unionid = jsonObject.getString("unionid");
				if(null!=unionid)
					weixinGzuserinfo.setUnionid(unionid);*/
				String remark = jsonObject.getString("remark");
				if(null!=remark)
					weixinGzuserinfo.setRemark(remark);
				String groupid = jsonObject.getString("groupid");
				if(null!=groupid)
					weixinGzuserinfo.setGroupId(groupid);
				weixinGzuserinfo.setEventStatus(1);
				weixinGzuserinfo.setMemType(1);
				weixinGzuserinfo.setAddtime(new Date());
				weixinGzuserinfo.setAccountid(accountId);
				save(weixinGzuserinfo);
				//删除重复数据
				deleteDub(openid);
				return weixinGzuserinfo;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 获取token失败
		}
		return null;
	}
	//取消关注更新数据
	public void updateByOpenId(String openId){
		WeixinGzuserinfo weixinGzuserinfo = findUniqueBy("openid", openId);
		if(null!=weixinGzuserinfo){
			weixinGzuserinfo.setEventStatus(2);
			weixinGzuserinfo.setCancelDate(new Date());
			save(weixinGzuserinfo);
		}
	}
	  /** 
     * 将emoji表情替换成* 
     * @param source 
     * @return 过滤后的字符串 
     */  
    public static String filterEmoji(String source) {  
        if(StringUtils.isNotBlank(source)){  
            return source.replaceAll("[\\ud800\\udc00-\\udbff\\udfff\\ud800-\\udfff]", "*");  
        }else{  
            return source;  
        }  
    }  
	/**
	 * 删除重复数据
	 * @param openId
	 */
	public void deleteDub(String openId){
		List<WeixinGzuserinfo> weixinGzuserinfos = findBy("openid", openId);
		if(null!=weixinGzuserinfos&&weixinGzuserinfos.size()>1){
			int j=weixinGzuserinfos.size();
			for (int i = 1; i < j; i++) {
				WeixinGzuserinfo weixinGzuserinfo = weixinGzuserinfos.get(i);
				delete(weixinGzuserinfo);
			}
		}
	}
	/**
	 * 获取所以会员Id
	 * @param sql
	 * @param objects
	 * @return
	 */
	public String getmemberIds(String sql){
		StringBuffer buffer=new StringBuffer();
		try {
			try {
				DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
				java.sql.Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				PreparedStatement prepareStatement = jdbcConnection.prepareStatement(sql);
				ResultSet resultSet = prepareStatement.executeQuery();
				 while (resultSet.next()) {  
					Object object = resultSet.getObject("dbid"); 
					buffer.append(object.toString()+",");
		        }  
				if(prepareStatement != null)prepareStatement.close();  
	            if(jdbcConnection != null)jdbcConnection.close();  
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return buffer.toString();
	}
	/**
	 * 获取所以会员Id
	 * @param sql
	 * @param objects
	 * @return
	 */
	public List<WeixinGzuserinfo> getWeixinGzUser(String sql){
		List<WeixinGzuserinfo> gzuserinfos=new ArrayList<WeixinGzuserinfo>();
		try {
			try {
				DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
				java.sql.Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				PreparedStatement prepareStatement = jdbcConnection.prepareStatement(sql);
				ResultSet resultSet = prepareStatement.executeQuery();
				while (resultSet.next()) {  
					WeixinGzuserinfo gzuserinfo=new WeixinGzuserinfo();
					Integer dbid = resultSet.getInt("dbid"); 
					String nickname = resultSet.getString("nickname"); 
					String openid = resultSet.getString("openid"); 
					gzuserinfo.setDbid(dbid);
					gzuserinfo.setNickname(nickname);
					gzuserinfo.setOpenid(openid);
					gzuserinfos.add(gzuserinfo);
				}  
				if(prepareStatement != null)prepareStatement.close();  
				if(jdbcConnection != null)jdbcConnection.close();  
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return gzuserinfos;
	}
	
	/**
	 * 新增粉丝
	 * @param coupon
	 */
	public List<DateNum> queryNews(){
		String sql="SELECT "
				+ "DATE_FORMAT(addtime,'%Y-%m-%d') AS addtime,"
				+ "COUNT(*) AS shareNum "
				+ "FROM  "
				+ "weixin_gzuserinfo "
				+ "WHERE  "
				+ "TO_DAYS(NOW()) - TO_DAYS(addtime)<7 and eventStatus=1 "
				+ "GROUP BY "
				+ " DATE_FORMAT(addtime,'%y-%m-%d')";
		List<DateNum> dateNums=new ArrayList<DateNum>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				DateNum dateNum=new DateNum();
				String date = resultSet.getString("addtime");
				int shareNum = resultSet.getInt("shareNum");
				dateNum.setDate(date);
				dateNum.setShareNum(shareNum);
				dateNums.add(dateNum);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dateNums;
	}
	/**
	 * 新增粉丝
	 * @param coupon
	 */
	public List<DateNum> queryCanncel(){
		String sql="SELECT "
				+ "DATE_FORMAT(addtime,'%Y-%m-%d') AS addtime,"
				+ "COUNT(*) AS shareNum "
				+ "FROM  "
				+ "weixin_gzuserinfo "
				+ "WHERE  "
				+ "TO_DAYS(NOW()) - TO_DAYS(addtime)<7 and eventStatus=2 "
				+ "GROUP BY "
				+ " DATE_FORMAT(addtime,'%y-%m-%d')";
		List<DateNum> dateNums=new ArrayList<DateNum>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				DateNum dateNum=new DateNum();
				String date = resultSet.getString("addtime");
				int shareNum = resultSet.getInt("shareNum");
				dateNum.setDate(date);
				dateNum.setShareNum(shareNum);
				dateNums.add(dateNum);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dateNums;
	}
}
