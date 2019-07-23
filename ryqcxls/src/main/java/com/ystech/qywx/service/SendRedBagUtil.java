package com.ystech.qywx.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.ystech.core.util.LogUtil;
import com.ystech.cust.model.Customer;
import com.ystech.mem.model.Reward;
import com.ystech.mem.service.RewardManageImpl;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.core.UtilXmlToBean;
import com.ystech.qywx.core.WXXStreamHelper;
import com.ystech.qywx.model.ActEnterprise;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.AppUserRole;
import com.ystech.qywx.model.AppUserRolePer;
import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.model.ScanPayReqData;
import com.ystech.qywx.model.ScanPayRespData;
import com.ystech.xwqr.model.sys.User;

@Component("sendRedBagUtil")
public class SendRedBagUtil {
	private static final String actName="交车红包";
	private AppUserManageImpl appUserManageImpl;
	private AppUserRoleManageImpl appUserRoleManageImpl;
	private ActEnterpriseManageImpl actEnterpriseManageImpl;
	private ScanPayRespDataManageImpl scanPayRespDataManageImpl;
	private RedBagManageImpl redBagManageImpl;
	private RewardManageImpl rewardManageImpl;
	@Resource
	public void setAppUserManageImpl(AppUserManageImpl appUserManageImpl) {
		this.appUserManageImpl = appUserManageImpl;
	}
	@Resource
	public void setAppUserRoleManageImpl(AppUserRoleManageImpl appUserRoleManageImpl) {
		this.appUserRoleManageImpl = appUserRoleManageImpl;
	}
	@Resource
	public void setActEnterpriseManageImpl(
			ActEnterpriseManageImpl actEnterpriseManageImpl) {
		this.actEnterpriseManageImpl = actEnterpriseManageImpl;
	}
	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}
	@Resource
	public void setScanPayRespDataManageImpl(
			ScanPayRespDataManageImpl scanPayRespDataManageImpl) {
		this.scanPayRespDataManageImpl = scanPayRespDataManageImpl;
	}
	@Resource
	public void setRewardManageImpl(RewardManageImpl rewardManageImpl) {
		this.rewardManageImpl = rewardManageImpl;
	}
	/**
	 * 功能描述：发送交车红包
	 * @param customer
	 * @param redBagMoney
	 */
	public void redBag(Customer customer,Double redBagMoney,String ip,String note){
		User user = customer.getUser();
		List<ActEnterprise> actEnterprises =actEnterpriseManageImpl.executeSql("select * from qywx_actenterprise ace,qywx_act qac where ace.actId=qac.dbid and qac.name=?", actName);
		if(null==actEnterprises||actEnterprises.size()<=0){
			LogUtil.error(user.getRealName()+"无交车发红包活动");
			return ;
		}
		ActEnterprise actEnterprise = actEnterprises.get(0);
		User user2 = customer.getUser();
		List<AppUser> appUsers = appUserManageImpl.executeSql("select * from qywx_appUser apu,user us where us.dbid=apu.userId and us.userId=? and apu.appId=51", user2.getUserId());
		if(null==appUsers||appUsers.size()<=0){
			LogUtil.error(user.getRealName()+"无对应的userID");
			return ;
		}
		AppUser appUser = appUsers.get(0);
		Integer status = appUser.getStatus();
		if(status==(int)AppUser.STATUSCOMM){
			LogUtil.error(user.getRealName()+"useriId还未同步转换");
			return ;
		}
		List<AppUserRole> appUserRoles = appUserRoleManageImpl.findBy("userId",user.getUserId());
		if(null==appUserRoles&&appUserRoles.size()<=0){
			LogUtil.error(user.getRealName()+"未设置红包权限");
			return ;
		}
		Integer levelStatus = actEnterprise.getLevelStatus();
		//开启领导红包权限
		if(levelStatus==(int)ActEnterprise.COMM){
			//发送销售顾问红包
			AppUserRole appUserRole = appUserRoles.get(0);
			Integer userPer = appUserRole.getUserPer();
			Double userDouble=redBagMoney*userPer/100;
			redBagManageImpl.saveRedBagJc(customer, actEnterprise, appUser, userDouble,ip,note);
			
			//发送领导红包
			Set<AppUserRolePer> appUserRolePers = appUserRole.getAppUserRolePers();
			for (AppUserRolePer appUserRolePer : appUserRolePers) {
				Integer per = appUserRolePer.getPer();
				Double reDouble=redBagMoney*per/100;
				User leader = appUserRolePer.getUser();
				List<AppUser> appLeaders = appUserManageImpl.executeSql("select * from qywx_appUser apu,user us where us.dbid=apu.userId and us.userId=? and apu.appId=51", leader.getUserId());
				if(null==appLeaders||appLeaders.size()<0){
					LogUtil.error(user.getRealName()+"无对应的userID");
					continue;
				}
				AppUser leaderAppuser = appLeaders.get(0);
				redBagManageImpl.saveRedBagJc(customer, actEnterprise, leaderAppuser, reDouble,ip,note+"【领导】");
			}
		}else{
			//未开启领导红包权限
			redBagManageImpl.saveRedBagJc(customer, actEnterprise, appUser, redBagMoney,ip,note);
		}
		
	}
	public void sendRedBag(ScanPayReqData scanPayReqData){
		try {
			XStream xStream = WXXStreamHelper.createXstream();
			xStream.processAnnotations(ScanPayReqData.class);  
		     //将要提交给API的数据对象转换成XML格式数据Post给API
		    String postDataXML = xStream.toXML(scanPayReqData);
			String sendredpack = QywxUtil.sendredpack;
			String httpRequest = QywxUtil.httpRequestStr(sendredpack, "POST", postDataXML);
			LogUtil.error("=======httpRequest"+httpRequest);
			if(null!=httpRequest){
				ScanPayRespData scanPayRespData = (ScanPayRespData) UtilXmlToBean.getObjectFromXML(httpRequest, ScanPayRespData.class);
				scanPayRespData.setScanPayReqData(scanPayReqData);
				scanPayRespDataManageImpl.save(scanPayRespData);
				if(scanPayRespData.getErr_code().equals("SUCCESS")){
					LogUtil.error("发送红包成功，返回编码："+httpRequest+",失败原因："+httpRequest);
					Integer redBagId = scanPayReqData.getRedBagId();
					RedBag redBag = redBagManageImpl.get(redBagId);
					redBag.setTurnBackStatus(RedBag.SUCCESS);
					redBagManageImpl.save(redBag);
					
					Integer redType = redBag.getRedType();
					if(redType==(int)RedBag.REDWECHAT){
						List<RedBag> redBags = redBagManageImpl.findBy("rewardId",redBag.getRewardId());
						if(null!=redBags&&redBags.size()>1){
							boolean status=true;
							for (RedBag redBag2 : redBags) {
								if(redBag2.getTurnBackStatus()!=(int)RedBag.SUCCESS){
									status=false;
									break;
								}
							}
							if(status){
								Reward reward = rewardManageImpl.get(redBag.getRewardId());
								reward.setTurnBackStatus(RedBag.SUCCESS);
								reward.setSendTime(new Date());
								rewardManageImpl.save(reward);
							}
						}else{
							Reward reward = rewardManageImpl.get(redBag.getRewardId());
							reward.setTurnBackStatus(RedBag.SUCCESS);
							reward.setSendTime(new Date());
							rewardManageImpl.save(reward);
						}
					}
				}else{
					LogUtil.error("发送红包失败，返回编码："+httpRequest+",失败原因："+httpRequest);
					Integer redBagId = scanPayReqData.getRedBagId();
					RedBag redBag = redBagManageImpl.get(redBagId);
					Integer num = redBag.getNum();
					num=num+1;
					redBag.setNum(num);
					redBag.setTurnBackStatus(RedBag.FUAIL);
					redBagManageImpl.save(redBag);
					Integer redType = redBag.getRedType();
					if(redType==(int)RedBag.REDWECHAT){
						Reward reward = rewardManageImpl.get(redBag.getRewardId());
						reward.setTurnBackStatus(RedBag.FUAIL);
						reward.setSendTime(new Date());
						rewardManageImpl.save(reward);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public static void main(String[] args) {
		String xml="<xml>" +
				"<return_code><![CDATA[SUCCESS]]></return_code>" +
				"<return_msg><![CDATA[发放成功]]></return_msg>" +
				"<result_code><![CDATA[SUCCESS]]></result_code>" +
				"<err_code><![CDATA[SUCCESS]]></err_code>" +
				"<err_code_des><![CDATA[发放成功]]></err_code_des>" +
				"<mch_billno><![CDATA[1364163202201607289692825128]]></mch_billno>" +
				"<mch_id><![CDATA[1364163202]]></mch_id>" +
				"<wxappid><![CDATA[wx5506239bbb6beea9]]></wxappid>" +
				"<re_openid><![CDATA[oVVlow7TbU82b4nIjtzjZcdZJpCQ]]></re_openid>" +
				"<total_amount>100</total_amount>" +
				"<send_listid><![CDATA[10000417012016072830587990007]]></send_listid>" +
				"</xml>";
		try {
			if(null!=xml){
				if(xml.contains("SUCCESS")){
					LogUtil.error("发送红包成功，返回编码："+xml+",失败原因："+xml);
					XStream xStreamForResponseData = new XStream(new DomDriver());
			        xStreamForResponseData.alias("xml", ScanPayRespData.class);
			        xStreamForResponseData.ignoreUnknownElements();//暂时忽略掉一些新增的字段
			        ScanPayRespData fromXML = (ScanPayRespData)xStreamForResponseData.fromXML(xml);
					System.out.println("======="+fromXML.getErr_code());
				}else{
					LogUtil.error("发送红包失败，返回编码："+xml+",失败原因："+xml);
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
