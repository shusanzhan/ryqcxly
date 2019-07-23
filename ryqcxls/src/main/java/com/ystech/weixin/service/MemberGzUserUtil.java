package com.ystech.weixin.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.LogUtil;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.MemberInfo;
import com.ystech.mem.model.MemberShipLevel;
import com.ystech.mem.model.Spread;
import com.ystech.mem.model.SpreadDetail;
import com.ystech.mem.service.MemLogManageImpl;
import com.ystech.mem.service.MemberInfoManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.MemberShipLevelManagImpl;
import com.ystech.mem.service.SpreadManageImpl;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.xwqr.model.sys.User;

@Component("memberGzUserUtil")
public class MemberGzUserUtil {
	private MemberShipLevelManagImpl memberShipLevelManagImpl;
	private MemberManageImpl memberManageImpl;
	private MemberInfoManageImpl memberInfoManageImpl;
	private MemLogManageImpl memLogManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private SpreadManageImpl spreadManageImpl;
	@Resource
	public void setMemberShipLevelManagImpl(MemberShipLevelManagImpl memberShipLevelManagImpl) {
		this.memberShipLevelManagImpl = memberShipLevelManagImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setMemberInfoManageImpl(MemberInfoManageImpl memberInfoManageImpl) {
		this.memberInfoManageImpl = memberInfoManageImpl;
	}
	@Resource
	public void setMemLogManageImpl(MemLogManageImpl memLogManageImpl) {
		this.memLogManageImpl = memLogManageImpl;
	}
	@Resource
	public void setWeixinAccountManageImpl(
			WeixinAccountManageImpl weixinAccountManageImpl) {
		this.weixinAccountManageImpl = weixinAccountManageImpl;
	}
	@Resource
	public void setSpreadManageImpl(SpreadManageImpl spreadManageImpl) {
		this.spreadManageImpl = spreadManageImpl;
	}
	public void saveMember(WeixinGzuserinfo weixinGzuserinfo,int memType){
		try {
			if(weixinGzuserinfo==null){
				return ;
			}
			List<Member> members = memberManageImpl.findBy("microId", weixinGzuserinfo.getOpenid());
			//新增会员信息
			if(null==members||members.size()<=0){
				Integer memberShipLevelId = 1;
				Member member=new Member();
				String no = member.getNo();
				if(null==no||no.trim().length()<=0){
					no=DateUtil.generatedName(new Date());
					member.setNo(no);
				}
				if(null!=weixinGzuserinfo.getNickname()){
					member.setName(weixinGzuserinfo.getNickname());
				}
				member.setMobilePhone(null);
				member.setPhone(null);
				member.setBirthdayType(1);
				member.setBirthday(null);
				if(null!=weixinGzuserinfo.getSex()){
					String sex = weixinGzuserinfo.getSex();
					if(sex.equals("1")){
						member.setSex("男");
					}
					if(sex.equals("2")){
						member.setSex("女");
					}
				}else{
					member.setSex("未知");
				}
				if(memberShipLevelId>0){
					MemberShipLevel memberShipLevel = memberShipLevelManagImpl.get(memberShipLevelId);
					member.setMemberShipLevel(memberShipLevel);
				}
				
				member.setCarNo(null);
				member.setVinNo(null);
				member.setCar(null);
				member.setNote("关注时添加会员");
				
				if(null==member.getTotalPoint()||member.getTotalPoint()<=0){
					member.setTotalPoint(0);
				}
				member.setOveragePiont(0);
				member.setConsumpiontPoint(0);
				
				member.setBalance("0.0");
				member.setTotalBuy(0);
				member.setTotalMoney(Double.valueOf(0));
				member.setLastBuyDate(new Date());
				
				
				member.setCreateTime(new Date());
				member.setModifyTime(new Date());
				//设置企业号ID
				member.setEnterpriseId(weixinGzuserinfo.getEnterpriseId());
				member.setMicroId(weixinGzuserinfo.getOpenid());
				//是否同步到微信平台
				member.setWeixinGzuserinfo(weixinGzuserinfo);
				member.setMemTagIds("1,");
				member.setMemTagNames("默认,");
				
				member.setCarMasterStatus(Member.AGENTAUTHCOMM);
				member.setCarMasterDate(new Date());
				member.setHasCar(Member.HASNOCAR);
				
				member.setOnlineBookingNum(0);
				member.setLastOnlineBookingDate(new Date());
				member.setLastContactDate(new Date());
				
				member.setMemAuthStatus(Member.AGENTAUTHCOMM);
				member.setMemAuthDate(null);
				member.setMemAuthDate(null);
				
				//会员状态
				member.setAgentStatus(Member.AGENTAUTHCOMM);
				member.setAgentDate(null);
				member.setAgentNum(0);
				member.setAgentSuccessNum(0);
				member.setPayType(null);
				member.setAccountNo(null);
				member.setAgentMoney(Float.valueOf(0));
				member.setAgentPointNum(0);
				member.setNickName(weixinGzuserinfo.getNickname());
				member.setEnterpriseId(weixinGzuserinfo.getEnterpriseId());
				member.setIcard(null);
			    //会员类型为默认0
				member.setMemType(memType);
				//设置会员父节点
				WeixinGzuserinfo parent = weixinGzuserinfo.getParent();
				if(null!=parent){
					//LogUtil.error("parent :"+weixinGzuserinfo.getNickname());
					List<Member> parentMembers = memberManageImpl.findBy("weixinGzuserinfo.dbid", parent.getDbid());
					Member parentMember=null;
					if(null!=parentMembers&&parentMembers.size()>0){
						parentMember=parentMembers.get(0);
					}
					if(null!=parentMember){
						LogUtil.error("parentMember :"+parentMember.getName());
						member.setParent(parentMember);
						//设置会员等级
						Integer level = parentMember.getLevel();
						if(level==null){
							parentMember.setLevel(1);
							member.setLevel(2);
						}else{
							member.setLevel(level+1);
						}
						
						//引流经纪人数
						Integer toalNum = parentMember.getTotalNum();
						if(toalNum==null){
							toalNum=1;
						}else{
							toalNum=toalNum+1;
						}
						parentMember.setTotalNum(toalNum);
						
						//更新父会员信息
						memberManageImpl.save(parentMember);
					}else{
						LogUtil.error("parentMember :null");
						member.setLevel(1);
					}
				}else{
					LogUtil.error("parent null:");
					member.setLevel(1);
				}
				
				Spread spread=spreadManageImpl.get(1);
				SpreadDetail spreadDetail = weixinGzuserinfo.getSpreadDetail();
				if(null!=spreadDetail){
					spread = spreadDetail.getSpread();
				}
				member.setSpread(spread);
				member.setTotalNum(0);
				memberManageImpl.save(member);
				//删除重复数据
				memberManageImpl.deleteDub(weixinGzuserinfo);
				//保存 会员基本信息
				MemberInfo memberInfo=new MemberInfo();
				memberInfo.setMember(member);
				memberInfo.setName(member.getName());
				memberInfoManageImpl.save(memberInfo);
				memberInfoManageImpl.deleteDub(member);
				User user=new User();
				user.setRealName("管理员");
				memLogManageImpl.saveMemberOperatorLog(member.getDbid(), "系统创建会员", "",user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
