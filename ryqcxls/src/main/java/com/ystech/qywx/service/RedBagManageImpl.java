package com.ystech.qywx.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Customer;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.Reward;
import com.ystech.qywx.core.Configure;
import com.ystech.qywx.model.ActEnterprise;
import com.ystech.qywx.model.AppUser;
import com.ystech.qywx.model.RedBag;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

@Component("redBagManageImpl")
public class RedBagManageImpl extends HibernateEntityDao<RedBag>{
	public void saveRedBagJc(Customer customer,ActEnterprise actEnterprise,AppUser appUser,Double redBagMoney,String ip,String note){
		RedBag	redBag=new RedBag();
		redBag.setRedType(RedBag.REDENTERPRISE);
		redBag.setActName(actEnterprise.getName());
		redBag.setRemark(actEnterprise.getRemark());
		redBag.setWishing(actEnterprise.getWishing());
		redBag.setRedBagMoney(redBagMoney);
		redBag.setOpenId(appUser.getOpenId());
		if(null!=customer.getDepartment()){
			redBag.setDepartmentId(customer.getDepartment().getDbid());
		}
		String billNo = getBillNo();
		List<RedBag> redBags = findBy("billno", billNo);
		if(null!=redBags&&redBags.size()>0){
			billNo=getBillNo();
		}
		redBag.setBillno(billNo);
		redBag.setAppId(appUser.getRedBagAppId());
		redBag.setCreateDate(new Date());
		redBag.setCreator("super");
		if(null!=customer){
			redBag.setCustomerId(customer.getDbid());
		}
		redBag.setOpenId(appUser.getOpenId());
		redBag.setSendTime(new Date());
		redBag.setTurnBackStatus(RedBag.COMM);
		User user = appUser.getUser();
		if(null!=user){
			if(null!=user.getEnterprise()){
				redBag.setEnterprise(user.getEnterprise());
			}
			redBag.setRecipientId(user.getDbid());
			redBag.setRecipientName(user.getRealName());
		}
		redBag.setIp(ip);
		redBag.setNote(note);
		redBag.setNum(1);
		save(redBag);
	}
	/**
	 * 功能描述：经纪人奖励红包
	 * @param member
	 * @param reward
	 * @param enterprise
	 * @param ip
	 * @param note
	 */
	public void saveRedBagAgent(Member member,Reward reward,Enterprise enterprise,String ip){
		Double redBagMoney=new Double(0);
		Float rewardMoney = reward.getRewardMoney();
		if(rewardMoney>200){
			int intValue = rewardMoney.intValue();
			int i=intValue/200;
			for (int j = 0; j < i; j++) {
				redBagMoney=Double.valueOf(200);
				saveRedBag(member, reward, redBagMoney, enterprise, ip);
			}
			int mo=intValue%200;
			if(mo>0){
				redBagMoney=Double.valueOf(mo);
				saveRedBag(member, reward, redBagMoney, enterprise, ip);
			}
		}else{
			redBagMoney=rewardMoney.doubleValue();
			saveRedBag(member, reward,redBagMoney,enterprise, ip);
		}
	}
	private void saveRedBag(Member member, Reward reward,Double redBagMoney,Enterprise enterprise, String ip) {
		RedBag	redBag=new RedBag();
		redBag.setRedType(RedBag.REDWECHAT);
		redBag.setActName(reward.getRewardFrom());
		redBag.setRemark(reward.getRewardFrom());
		redBag.setWishing(reward.getRewardFrom());
		redBag.setRedBagMoney(redBagMoney);
		String microId = member.getMicroId();
		redBag.setOpenId(microId);
		redBag.setDepartmentId(0);
		String billNo = getBillNo();
		List<RedBag> redBags = findBy("billno", billNo);
		if(null!=redBags&&redBags.size()>0){
			billNo=getBillNo();
		}
		redBag.setBillno(billNo);
		redBag.setAppId(Configure.getAppid());
		redBag.setCreateDate(new Date());
		redBag.setCreator("super");
		redBag.setCustomerId(null);
		redBag.setSendTime(new Date());
		redBag.setTurnBackStatus(RedBag.COMM);
		if(null!=member){
			redBag.setRecipientId(member.getDbid());
			redBag.setRecipientName(member.getName());
		}
		if(null!=enterprise){
			redBag.setEnterprise(enterprise);
		}
		redBag.setRewardId(reward.getDbid());
		redBag.setIp(ip);
		redBag.setNote(reward.getNote());
		redBag.setNum(1);
		save(redBag);
	}
	private String getBillNo(){
		SimpleDateFormat f = new SimpleDateFormat("yyyyMMdd");
		String format = f.format(new Date());
		String time = "" + System.currentTimeMillis();
		int beginIndex = time.length() - 10;
		int endIndex = time.length();
		String substring = time.substring(beginIndex, endIndex);
		return format+substring;
	}
	public List<RedBag> findb(String start,Enterprise enterprise){
		String sql="SELECT userName,SUM(redBagMoney) as totalMoney FROM qywx_redbag WHERE DATE_FORMAT(createDate,'%Y-%m')='"+start+"'  GROUP BY userName ORDER BY  totalMoney DESC";
		List<RedBag> redBags = getSession().createSQLQuery(sql).setResultTransformer(Transformers.aliasToBean(RedBag.class)).list();
		return redBags;
	}
}
