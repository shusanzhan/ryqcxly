/**
 * 
 */
package com.ystech.wechat.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentSet;
import com.ystech.agent.model.VerificationCode;
import com.ystech.agent.service.AgentMesgManageImpl;
import com.ystech.agent.service.AgentMessageUtil;
import com.ystech.agent.service.AgentSetManageImpl;
import com.ystech.agent.service.VerificationCodeManageImpl;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.mem.model.Coupon;
import com.ystech.mem.model.CouponCode;
import com.ystech.mem.model.CouponMember;
import com.ystech.mem.model.MemPointrecordSet;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.MemberCarInfo;
import com.ystech.mem.model.MemberInfo;
import com.ystech.mem.model.OnlineBooking;
import com.ystech.mem.model.PointRecord;
import com.ystech.mem.model.Reward;
import com.ystech.mem.model.Spread;
import com.ystech.mem.model.TradingSnapshot;
import com.ystech.mem.service.CouponCodeManageImpl;
import com.ystech.mem.service.CouponManageImpl;
import com.ystech.mem.service.CouponMemberManageImpl;
import com.ystech.mem.service.MemPointrecordSetManageImpl;
import com.ystech.mem.service.MemberCarInfoManageImpl;
import com.ystech.mem.service.MemberInfoManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.MemberShipLevelManagImpl;
import com.ystech.mem.service.OnlineBookingManageImpl;
import com.ystech.mem.service.PointRecordManageImpl;
import com.ystech.mem.service.RewardManageImpl;
import com.ystech.mem.service.SpreadDetailManageImpl;
import com.ystech.mem.service.SpreadManageImpl;
import com.ystech.mem.service.TradingSnapshotManageImpl;
import com.ystech.mem.service.UseCarAreaManageImpl;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.weixin.core.util.WeixinUtil;
import com.ystech.weixin.model.WeixinAccesstoken;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.weixin.model.WeixinNewsitem;
import com.ystech.weixin.model.template.WeixinSendTemplateMessageUtil;
import com.ystech.weixin.service.WeixinAccesstokenManageImpl;
import com.ystech.weixin.service.WeixinAccountManageImpl;
import com.ystech.weixin.service.WeixinNewsitemManageImpl;
import com.ystech.weixin.service.WeixinNewstemplateManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2014-3-21
 */
@Component("memberWechatAction")
@Scope("prototype")
public class MemberWechatAction extends BaseController{
	private MemberCarInfo memberCarInfo;
	private CouponManageImpl couponManageImpl;
	private CouponCodeManageImpl couponCodeManageImpl;
	private MemberManageImpl memberManageImpl;
	private UserManageImpl userManageImpl;
	private CouponMemberManageImpl couponMemberManageImpl;
	private MemberInfo memberInfo;
	private Member member;
	private PointRecordManageImpl pointRecordManageImpl;
	private MemberInfoManageImpl memberInfoManageImpl;
	private MemberCarInfoManageImpl memberCarInfoManageImpl;
	private AreaManageImpl areaManageImpl;
	private OnlineBookingManageImpl onlineBookingManageImpl;
	private MemberShipLevelManagImpl memberShipLevelManagImpl;
	private TradingSnapshotManageImpl tradingSnapshotManageImpl;
	private VerificationCodeManageImpl verificationCodeManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private AgentSetManageImpl agentSetManageImpl;
	private RewardManageImpl rewardManageImpl;
	private SpreadDetailManageImpl spreadDetailManageImpl;
	private RedBagManageImpl redBagManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private WeixinAccesstokenManageImpl weixinAccesstokenManageImpl;
	private AgentMesgManageImpl agentMesgManageImpl;
	private MemPointrecordSetManageImpl memPointrecordSetManageImpl;
	private UseCarAreaManageImpl useCarAreaManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private WeixinNewsitemManageImpl weixinNewsitemManageImpl;
	private WeixinNewstemplateManageImpl weixinNewstemplateManageImpl;
	
	public MemberCarInfo getMemberCarInfo() {
		return memberCarInfo;
	}
	public void setMemberCarInfo(MemberCarInfo memberCarInfo) {
		this.memberCarInfo = memberCarInfo;
	}
	@Resource
	public void setMemberShipLevelManagImpl(
			MemberShipLevelManagImpl memberShipLevelManagImpl) {
		this.memberShipLevelManagImpl = memberShipLevelManagImpl;
	}
	@Resource
	public void setCouponManageImpl(CouponManageImpl couponManageImpl) {
		this.couponManageImpl = couponManageImpl;
	}
	@Resource
	public void setCouponCodeManageImpl(CouponCodeManageImpl couponCodeManageImpl) {
		this.couponCodeManageImpl = couponCodeManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setVerificationCodeManageImpl(VerificationCodeManageImpl verificationCodeManageImpl) {
		this.verificationCodeManageImpl = verificationCodeManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCouponMemberManageImpl(
			CouponMemberManageImpl couponMemberManageImpl) {
		this.couponMemberManageImpl = couponMemberManageImpl;
	}
	@Resource
	public void setSpreadDetailManageImpl(
			SpreadDetailManageImpl spreadDetailManageImpl) {
		this.spreadDetailManageImpl = spreadDetailManageImpl;
	}
	@Resource
	public void setUseCarAreaManageImpl(UseCarAreaManageImpl useCarAreaManageImpl) {
		this.useCarAreaManageImpl = useCarAreaManageImpl;
	}
	@Resource
	public void setWeixinNewsitemManageImpl(
			WeixinNewsitemManageImpl weixinNewsitemManageImpl) {
		this.weixinNewsitemManageImpl = weixinNewsitemManageImpl;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public MemberManageImpl getMemberManageImpl() {
		return memberManageImpl;
	}
	
	public MemberInfo getMemberInfo() {
		return memberInfo;
	}
	public void setMemberInfo(MemberInfo memberInfo) {
		this.memberInfo = memberInfo;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setPointRecordManageImpl(PointRecordManageImpl pointRecordManageImpl) {
		this.pointRecordManageImpl = pointRecordManageImpl;
	}
	@Resource
	public void setMemberInfoManageImpl(MemberInfoManageImpl memberInfoManageImpl) {
		this.memberInfoManageImpl = memberInfoManageImpl;
	}
	@Resource
	public void setMemberCarInfoManageImpl(
			MemberCarInfoManageImpl memberCarInfoManageImpl) {
		this.memberCarInfoManageImpl = memberCarInfoManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setOnlineBookingManageImpl(
			OnlineBookingManageImpl onlineBookingManageImpl) {
		this.onlineBookingManageImpl = onlineBookingManageImpl;
	}
	@Resource
	public void setTradingSnapshotManageImpl(
			TradingSnapshotManageImpl tradingSnapshotManageImpl) {
		this.tradingSnapshotManageImpl = tradingSnapshotManageImpl;
	}
	@Resource
	public void setAgentSetManageImpl(AgentSetManageImpl agentSetManageImpl) {
		this.agentSetManageImpl = agentSetManageImpl;
	}
	@Resource
	public void setRewardManageImpl(RewardManageImpl rewardManageImpl) {
		this.rewardManageImpl = rewardManageImpl;
	}
	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}
	@Resource
	public void setWeixinAccountManageImpl(
			WeixinAccountManageImpl weixinAccountManageImpl) {
		this.weixinAccountManageImpl = weixinAccountManageImpl;
	}
	@Resource
	public void setWeixinAccesstokenManageImpl(
			WeixinAccesstokenManageImpl weixinAccesstokenManageImpl) {
		this.weixinAccesstokenManageImpl = weixinAccesstokenManageImpl;
	}
	@Resource
	public void setAgentMesgManageImpl(AgentMesgManageImpl agentMesgManageImpl) {
		this.agentMesgManageImpl = agentMesgManageImpl;
	}
	@Resource
	public void setMemPointrecordSetManageImpl(
			MemPointrecordSetManageImpl memPointrecordSetManageImpl) {
		this.memPointrecordSetManageImpl = memPointrecordSetManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	/**
	 * 功能描述：会员验证
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String memAuth() throws Exception {
		HttpServletRequest request = this.getRequest();
		String url = request.getParameter("url");
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null!=member){
				if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
					request.setAttribute("member", member);
					request.setAttribute("url", url);
					return "memAuth";
				}else{
					request.setAttribute("member", member);
					return "index";
				}
			}else{
				return "weixinNullError";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "memAuth";
	}
	/**
	 * 功能描述：保存会员卡申请信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveMemAuth() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		String codeNum = request.getParameter("codeNum");
		try{
			String mobilePhone = request.getParameter("mobilePhone");
			String name=request.getParameter("name");
			String sex=request.getParameter("sex");
			String url=request.getParameter("url");
			if(null!=codeNum&&codeNum.trim().length()==4){
				boolean vilidate = verificationMobile(mobilePhone,codeNum);
				if(vilidate==false){
					renderErrorMsg(new Throwable("验证码错误!"), "");
					return ;
				}
			}else{
				renderErrorMsg(new Throwable("验证码格式错误"), "");
				return ;
			}
			StringBuffer message=new StringBuffer();
			message.append("会员认证成功");
			Member member2 = memberManageImpl.get(dbid);
			if(null==member2){
				renderErrorMsg(new Throwable("无微信关注信息，请退出后重试"), "");
				return ;
			}
			//经纪人设置信息
			AgentSet agentSet=null;
			Enterprise enterprise = member2.getEnterprise();
			Spread spread = member2.getSpread();
			if((null!=enterprise)&&null!=spread){
				List<AgentSet> agentSets = agentSetManageImpl.find("from AgentSet where enterprise.dbid=? ", new Object[]{enterprise.getDbid()});
				if(null!=agentSets&&agentSets.size()>0){
					agentSet = agentSets.get(0);
				}
			}
			member2.setSex(sex);
			member2.setName(name);
			member2.setMobilePhone(mobilePhone);
			//会员认证
			member2.setMemAuthDate(new Date());
			member2.setMemAuthStatus(Member.AGENTAUTHED);
			if(null!=agentSet){
				//判断系统是否开启经纪人注册拥有推荐权限
				if(agentSet.getAuthAgentStatus()==(int)AgentSet.START){
					member2.setAgentStatus(Member.AGENTAUTHED);
					member2.setAgentDate(new Date());
				}
			}
			Integer memType = member2.getMemType();
			if(null!=memType&&memType==3){
				member2.setMemType(0);
			}
			memberManageImpl.save(member2);
			//保存 会员基本信息
			List<MemberInfo> memberInfos = memberInfoManageImpl.findBy("member.dbid", member2.getDbid());
			if(null!=memberInfos&&memberInfos.size()==1){
				MemberInfo memberInfo=memberInfos.get(0);
				memberInfo.setMember(member2);
				memberInfo.setName(member2.getName());
				memberInfoManageImpl.save(memberInfo);
			}
			//保存发送信息
			saveMessage(member2);
			
			//发送微信通知
			if(null!=enterprise){
				WeixinAccount weixinAccount = weixinAccountManageImpl.findByWeixinAccount();
				if(null!=weixinAccount){
					WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
					WeixinSendTemplateMessageUtil.send_template_memberAtuh(accessToken,member2,enterprise);
				}
			}
			//经纪人奖励
			if(null!=agentSet){
				//奖励推荐经纪人奖励状态
				Integer parentRewardStatus = agentSet.getRegParentRewardStatus();
				if(parentRewardStatus==(int)AgentSet.START){
					WeixinGzuserinfo weixinGzuserinfo = member2.getWeixinGzuserinfo();
					if(null!=weixinGzuserinfo){
						WeixinGzuserinfo parent = weixinGzuserinfo.getParent();
						if(null!=parent){
							List<Member> members = memberManageImpl.findBy("weixinGzuserinfo.dbid", parent.getDbid());
							if(null!=members&&members.size()>0){
								Member parentMember = members.get(0);
								saveRewardAgent(parentMember, member2, agentSet);
							}
						}
					}
				}
				//奖励经纪人注册奖励状态
				Integer regRewardStatus = agentSet.getRegRewardStatus();
				if(regRewardStatus==(int)AgentSet.START){
					saveRewardReg(member2, agentSet);
					message.append(",会员认证红包已发送请注意查收");
				}
			}
			
			//经纪人认证 赠送积分
			registerSendPoint(member2);
			
			//经纪人认证后生成他的专属二维码
			log.info("begin 二维码成功！");
			boolean craeateBooleanStatus = spreadDetailManageImpl.saveSpreadDetail(member2);
			log.info("end 二维码成功！");
			if(craeateBooleanStatus==true){
				log.info("生成经纪人专属二维码成功！");
			}else{
				log.error("生成经纪人专属二维码失败！");
			}
			if(null==url||url.trim().length()<=0){
				renderMsg("/memberWechat/memberCenter",message.toString());
			}else{
				renderMsg(url,message.toString());
			}
			
			return ;
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("会员认证失败!"),"");
			return ;
		}
	
	}
	
	/**
	 * 功能描述：保存会员详细信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveMemeber() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
				Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			
				Member member2 = memberManageImpl.get(member.getDbid());
				member2.setBirthday(member.getBirthday());
				member2.setName(member.getName());
				member2.setMobilePhone(member.getMobilePhone());
				member2.setSex(member.getSex());
				member2.setHasCar(member.getHasCar());
				member2.setCar(member.getCar());
				member2.setCarNo(member.getCarNo());
				memberManageImpl.save(member2);
				
				MemberInfo memberInfo2 = memberInfoManageImpl.get(memberInfo.getDbid());
				if(areaId>0){
					Area area = areaManageImpl.get(areaId);
					memberInfo2.setArea(area);
				}
				memberInfo2.setAddress(memberInfo.getAddress());
				memberInfo2.setName(member.getName());
				memberInfoManageImpl.save(memberInfo2);
				renderMsg("/memberWechat/memberCenter", "完善会员信息成功，页面将在3秒后跳转到会员中心！");
			
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("完善会员信息失败!"),"");
			return ;
		}
		return ;
	}
	
	/**
	 * 功能描述：会员中心
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String memberCenter() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null!=member){
				if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
					request.setAttribute("url", "/memberWechat/memberCenter");
					request.setAttribute("member", member);
					return "memAuth";
				}else{
					request.setAttribute("member", member);
					request.setAttribute("enterprise", member.getEnterprise());
					return "memberCenter";
				}
			}else{
				return "weixinNullError";
			}
		} catch (Exception e) {
		}
		return "error";
	}
	/**
	 *  功能描述：完善会员详细信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String memberInfo() throws Exception{
		HttpServletRequest request = this.getRequest();
		//地域信息
		try{
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			Member member2 = getMemberBy();
			if(null!=member2&&member2.getDbid()>0){
				Member member3 = memberManageImpl.get(member2.getDbid());
				request.setAttribute("member", member3);
				request.setAttribute("memberInfo", member3.getMemberInfo());
				if(null!=member3.getMemberInfo()){
					String areaSelect = areaSelect(member3.getMemberInfo().getArea());
					request.setAttribute("areaSelect", areaSelect);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "memberInfo";
	}
	/**
	 *  功能描述：车主认证
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String carMasterAuth() throws Exception{
		HttpServletRequest request = this.getRequest();
	    Integer memberId = ParamUtil.getIntParam(request, "memberId",-1);
		//地域信息
		try{
			Member member2 = memberManageImpl.get(memberId);
			request.setAttribute("member", member2);
			
			List<Customer> customers = customerMangeImpl.findBy("mobilePhone", member2.getMobilePhone());
			if(!customers.isEmpty()){
				request.setAttribute("customer", customers.get(0));
				String carSeriyName="";
				Customer customer = customers.get(0);
				CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
				if(null!=customerLastBussi){
					Brand brand = customerLastBussi.getBrand();
					if(null!=brand){
						carSeriyName=brand.getName();
					}
					CarSeriy carSeriy = customerLastBussi.getCarSeriy();
					if(null!=carSeriy){
						carSeriyName=carSeriyName+carSeriy.getName();
					}
					CarModel carModel = customerLastBussi.getCarModel();
					if(null!=carModel){
						carSeriyName=carSeriyName+carModel.getName();
					}
					request.setAttribute("car", carSeriyName);
					request.setAttribute("carPlate", customerLastBussi.getCarPlateNo());
				}
			}
			
			String useCarArea = useCarAreaManageImpl.getUseCarArea(null);
			request.setAttribute("useCarArea", useCarArea);
			System.err.println(useCarArea);
			//会员车辆认证信息
			List<MemberCarInfo> memberCarInfos = memberCarInfoManageImpl.findBy("member.dbid", member2.getDbid());
			request.setAttribute("memberCarInfos", memberCarInfos);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "carMasterAuth";
	}
	/**
	 * 功能描述：保存会员认证
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCarAuth() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer memberId = ParamUtil.getIntParam(request, "memberId", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer useCarAreaId = ParamUtil.getIntParam(request, "useCarAreaId", -1);
		try {
			if(null!=memberCarInfo.getDbid()){
				MemberCarInfo memberCarInfo2 = memberCarInfoManageImpl.get(memberCarInfo.getDbid());
				memberCarInfo2.setCar(memberCarInfo.getCar());
				memberCarInfo2.setCarPlate(memberCarInfo.getCarPlate());
				Member member2 = memberManageImpl.get(memberId);
				memberCarInfo2.setMember(member2);
				memberCarInfo2.setMobilePhone(memberCarInfo.getMobilePhone());
				memberCarInfo2.setName(memberCarInfo.getName());
				memberCarInfo2.setNote(memberCarInfo.getNote());
				memberCarInfo2.setVinCode(memberCarInfo.getVinCode());
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					memberCarInfo2.setCustomer(customer);
				}
				memberCarInfoManageImpl.save(memberCarInfo2);
				
				//认证成功赠送积分通知
				registerSendPoint(member2);
			}else{
				Member member2 = memberManageImpl.get(memberId);
				Integer memAuthStatus = member2.getMemAuthStatus();
				if(null==memAuthStatus||memAuthStatus==(int)Member.AGENTAUTHCOMM){
					member2.setName(memberCarInfo.getName());
					member2.setMobilePhone(memberCarInfo.getMobilePhone());
					member2.setMemAuthDate(new Date());
					member2.setMemAuthStatus(Member.AGENTAUTHED);
					memberManageImpl.save(member2);
				}
				if(member2.getAgentStatus()==null||member2.getAgentStatus()==(int)Member.AGENTAUTHCOMM){
					member2.setAgentStatus(Member.AGENTAUTHED);
					member2.setAgentDate(new Date());
				}
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					memberCarInfo.setCustomer(customer);
				}
				Integer carMasterStatus = member2.getCarMasterStatus();
				if(null==carMasterStatus||carMasterStatus==(int)Member.AGENTAUTHCOMM){
					member2.setCarMasterDate(new Date());
					member2.setCarMasterStatus(Member.AGENTAUTHED);
				}
				memberCarInfo.setMember(member2);
				memberCarInfoManageImpl.save(memberCarInfo);
				
				String car = member2.getCar();
				if(null!=car){
					if(null!=memberCarInfo.getCar()){
						if(car.indexOf(memberCarInfo.getCar())==-1){
							car=car+","+memberCarInfo.getCar();
							member2.setCar(car);
						}
					}
				}else{
					member2.setCar(memberCarInfo.getCar());
				}
				String carNo = member2.getCarNo();
				if(null!=carNo){
					if(null!=memberCarInfo.getCarPlate()){
						if(carNo.indexOf(memberCarInfo.getCarPlate())==-1){
							carNo=carNo+","+memberCarInfo.getCarPlate();
							member2.setCarNo(carNo);
						}
					}
				}else{
					member2.setCarNo(memberCarInfo.getCarPlate());
				}
				String vinNo = member2.getVinNo();
				if(null!=vinNo){
					if(null!=memberCarInfo.getVinCode()){
						if(vinNo.indexOf(memberCarInfo.getVinCode())==-1){
							vinNo=vinNo+","+memberCarInfo.getVinCode();
							member2.setVinNo(vinNo);
						}
					}
				}else{
					member2.setVinNo(memberCarInfo.getVinCode());
				}
				memberManageImpl.save(member2);
				//认证成功赠送积分通知
				registerSendPoint(member2);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/agentWechat/myAgent", "认证成功");
		return;
	}
	/**
	 * 功能描述：我的预约中心
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myOnlineBooking() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Member memberBy = getMemberBy();
			if(null!=memberBy){
				List<OnlineBooking> onlineBookings = onlineBookingManageImpl.findBy("member.dbid", memberBy.getDbid());
				request.setAttribute("onlineBookings", onlineBookings);
			}
		} catch (Exception e) {
		}
		return "myOnlineBooking";
	}
	
	
	/**
	 * @param memberInfo2
	 */
	private String areaSelect(Area area) {
		StringBuffer buffer=new StringBuffer();
		if(null!=area){
			String treePath = area.getTreePath();
			String[] split = treePath.split(",");
			if(split.length>1){
				//父节点
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				if(null!=areas&&areas.size()>0){
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas) {
						if(ar.getDbid()==Integer.parseInt(split[1])){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
				for (int i=2; i<split.length ; i++) {
					List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[i-1]));
					if(null!=areas2&&areas2.size()>0){
						buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
						buffer.append("<option>请选择...</option>");
						for (Area ar : areas2) {
							if(ar.getDbid()==Integer.parseInt(split[i])){
								buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}else{
								buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}
						}
						buffer.append("</select> ");
					}
				}
				//最后一个下拉框
				List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[split.length-1]));
				if(null!=areas2&&areas2.size()>0){
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas2) {
						if(ar.getDbid()==area.getDbid()){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
			}
		}else{
			return null;
		}
		return buffer.toString();
	}
	/**
	 * 功能描述：我的积分记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myScoreRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Integer selectType = ParamUtil.getIntParam(request, "selectType", -1);
			List<PointRecord> pointRecords=null;
			Member member2 = getMemberBy();
			if(null!=member2){
				request.setAttribute("member", member2);
				if(selectType==0){
					pointRecords = pointRecordManageImpl.executeSql("select *  from mem_PointRecord where memberId=? ", new Object[]{member2.getDbid()});
				}
				else if(selectType==1){
					pointRecords = pointRecordManageImpl.executeSql("select *  from mem_PointRecord where memberId=? and num>?", new Object[]{member2.getDbid(),0});
				}
				else if(selectType==2){
					pointRecords = pointRecordManageImpl.executeSql("select *  from mem_PointRecord where memberId=? and num<=?", new Object[]{member2.getDbid(),0});
				}
				request.setAttribute("pointRecords", pointRecords);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myScoreRecord";
	}
	/**
	 * 功能描述：我的交易记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myTrading() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Integer selectType = ParamUtil.getIntParam(request, "selectType", -1);
			List<TradingSnapshot> tradingSnapshots=null;
			Member member2 = getMemberBy();
			if(null!=member2){
				request.setAttribute("member", member2);
				if(selectType==0){
					tradingSnapshots = tradingSnapshotManageImpl.executeSql("select *  from mem_TradingSnapshot where memberId=? ", new Object[]{member2.getDbid()});
				}
				else if(selectType==1){
					tradingSnapshots = tradingSnapshotManageImpl.executeSql("select *  from mem_TradingSnapshot where memberId=? and tradingType=?", new Object[]{member2.getDbid(),TradingSnapshot.TRADINGTYPESTORE});
				}
				else if(selectType==2){
					tradingSnapshots = tradingSnapshotManageImpl.executeSql("select *  from mem_TradingSnapshot where memberId=? and tradingType=?", new Object[]{member2.getDbid(),TradingSnapshot.TRADINGTYPEXIAOFEI});
				}
				request.setAttribute("tradingSnapshots", tradingSnapshots);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myTrading";
	}
	/**
	 * 保存通知信息
	 * @param booking
	 */
	private void saveMessage(Member member){
		String title=member.getName();
		String url="/member/edit?dbid="+member.getDbid();
		String content="";
		content=member.getName()+""+DateUtil.format(member.getCreateTime())+"申请了会员！";
		MessageUtile messageUtile=new MessageUtile();
		messageUtile.sendMessage(title, content, url);
	}
	
	/**
	 * 功能描述：优惠券列表
	 * @return
	 */
	public String coupon() throws Exception{
		HttpServletRequest request = this.getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try {
			Member member2 = getMemberBy();
			List<Coupon> coupons=null;
			if(type>0){
				coupons= couponManageImpl.find("from Coupon where   enabled=? and type=?  ", new Object[]{true,type});
			}else{
				coupons= couponManageImpl.find("from Coupon where   enabled=?   ", new Object[]{true});
			}
			for (Coupon coupon : coupons) {
				List<CouponCode> couponCodes = couponCodeManageImpl.find("from CouponCode as couponCode where couponCode.coupon.dbid=? and couponCode.member.dbid=?", new Object[]{coupon.getDbid(),member2.getDbid()});
				if(null!=couponCodes&&couponCodes.size()>0){
					for (CouponCode couponCode : couponCodes) {
						Coupon c=couponCode.getCoupon();
						if(coupon.getDbid()==c.getDbid()){
							coupon.setReceive(true);
							break;
						}
					}
				}
			}
			request.setAttribute("coupons",coupons);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "coupon";
	}
	/**
	 * 功能描述：领取优惠券
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void receiveCoupon() throws Exception {
		HttpServletRequest request = this.getRequest();
		//微信会员Id
		Integer couponId = ParamUtil.getIntParam(request, "couponId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try{
				Member member = getMemberBy();
				if(null==member){
					renderErrorMsg(new Throwable("领取优惠券失败，您还不是会员请先注册会员！"), "");
					return ;
				}

				Coupon coupon = couponManageImpl.get(couponId);
				if(null==coupon||coupon.getDbid()<=0){
					renderErrorMsg(new Throwable("领取优惠券失败，优惠券不可用！"), "");
					return ;
				}
				//创建领用记录
				CouponCode couponCode=new CouponCode();
				couponCode.setMember(member);
				couponCode.setCoupon(coupon);
				couponCode.setCreateTime(new Date());
				couponCode.setModifyTime(new Date());
				String identityCode = DateUtil.generatedName(new Date());
				couponCode.setCode(identityCode);
				couponCodeManageImpl.save(couponCode);
				
				//创建会员领取优惠券记录
				User admin = userManageImpl.findUniqueBy("userId", "admin");
				CouponMember couponMember=new CouponMember();
				couponMember.setName(coupon.getName());
				couponMember.setType(coupon.getType());
				couponMember.setImage(coupon.getImage());
				couponMember.setMoneyOrRabatt(coupon.getMoneyOrRabatt());
				couponMember.setEnabled(coupon.isEnabled());
				couponMember.setStartTime(coupon.getStartTime());
				couponMember.setStopTime(coupon.getStopTime());
				couponMember.setBigType(CouponMember.NORMALCOUPON);
				couponMember.setReason(coupon.getReason());
				couponMember.setDescription(coupon.getDescription());
				couponMember.setCreateTime(new Date());
				couponMember.setModifyTime(new Date());
				couponMember.setCreatorId(admin.getDbid());
				couponMember.setIsUsed(false);
				couponMember.setCode(identityCode);
				couponMember.setMember(member);
				couponMember.setCreatorName(admin.getRealName());
				couponMember.setShowHiden(coupon.getShowHiden());
				couponMemberManageImpl.save(couponMember);
				
				Integer receivedNum = coupon.getReceivedNum();
				receivedNum=receivedNum+1;
				coupon.setReceivedNum(receivedNum);
				couponManageImpl.save(coupon);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("领取优惠券错误,请稍后再试！"), "");
			return ;
		}
		renderMsg("/memberWechat/coupon?type="+type, "领取优惠券成功！");
		return ;
	}
	/**
	* 功能描述：修改联系电话
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String modifyPhone() throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Member member2 = getMemberBy();
			if(null!=member2){
				Member member3 = memberManageImpl.get(member2.getDbid());
				request.setAttribute("member", member3);
			}else{
				return "weixinNullError";
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "modifyPhone";
	}
	/**
		 * 功能描述：
		 * 参数描述：
		 * 逻辑描述：
		 * @return
		 * @throws Exception
		 */
	public void saveModifyPhone() throws Exception {
		HttpServletRequest request = getRequest();
		Integer memberId = ParamUtil.getIntParam(request, "memberId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String codeNum = request.getParameter("codeNum");
		try {
			if(memberId<0){
				renderErrorMsg(new Throwable("会员信息为空，请退出后重试"), "");
				return ;
			}
			if(null!=codeNum&&codeNum.trim().length()==4){
				boolean vilidate = verificationMobile(mobilePhone,codeNum);
				if(vilidate==false){
					renderErrorMsg(new Throwable("验证码错误!"), "");
					return ;
				}
			}else{
				renderErrorMsg(new Throwable("验证码格式错误"), "");
				return ;
			}
			Member member2 = memberManageImpl.get(memberId);
			if(null==member2){
				renderErrorMsg(new Throwable("会员信息为空，请退出后重试"), "");
				return ;
			}
			boolean validateMobilePhone = memberManageImpl.validateMobilePhone(mobilePhone, member2.getDbid());
			if(validateMobilePhone==true){
				renderErrorMsg(new Throwable("手机号已被注册，请确认"), "");
				return ;
			}
			member2.setMobilePhone(mobilePhone);
			memberManageImpl.save(member2);
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("修改电话号码失败"), "");
			return ;
		}
		renderMsg("/memberWechat/memberCenter","电话号码修改成功");
		return;
	}
	/**
	 * 功能描述：我的优惠券列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myCoupon() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		HttpSession session = request.getSession();
		try {
			Member member2 = getMemberBy();
			if(null!=member2){
				if(type>0){
					List<CouponMember> couponCodes = couponMemberManageImpl.find("from CouponMember as cc where cc.member.dbid=?   and cc.type=? order by cc.isUsed ", new Object[]{member2.getDbid(),type});
					request.setAttribute("couponCodes", couponCodes);
				}else{
					List<CouponMember> couponCodes = couponMemberManageImpl.find("from CouponMember as cc where cc.member.dbid=?   order by cc.isUsed ", new Object[]{member2.getDbid()});
					request.setAttribute("couponCodes", couponCodes);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myCoupon";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String readNewsItem() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Member member2 = getMemberBy();
			WeixinNewsitem weixinNewsitem = weixinNewsitemManageImpl.getWeixinNewsitem(member2);
			if(null==weixinNewsitem){
				return "error";
			}
			Integer readNum = weixinNewsitem.getReadNum();
			if(null!=readNum){
				readNum=readNum+1;
			}else{
				readNum=0;
			}
			weixinNewsitem.setReadNum(readNum);
			weixinNewsitemManageImpl.save(weixinNewsitem);
			request.setAttribute("weixinNewsitem", weixinNewsitem);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "readNewsItem";
	}
	/**
	 * @param request
	 */
	private Member getMemberBy() {
		String wechatId = getWechatId();
		if(null!=wechatId){
			List<Member> members = memberManageImpl.findBy("microId", wechatId);
			if(null!=members&&members.size()>0){
				return members.get(0);
			}
		}
		return null;
	}
	
	
	/**
	 * 手机验证码处理方法：
	 * 1、通过手机、验证码查询verificationCode表中的数据
	 * 2、判断查询数据，如果有数据则删除数据、未有数据验证失败
	 * 3、验证成功，修改user用户表的手机验证状态和用户的用户状态
	 */
	private boolean verificationMobile(String mobile,String codeNum){
		try {
			//判断验证手机验证码
			if(null!=mobile&&mobile.trim().length()>0&&null!=codeNum&&codeNum.trim().length()>0){
				List<VerificationCode> verificationCodes = verificationCodeManageImpl.find("from VerificationCode where mobile=? and verificationCode=?", new Object[]{mobile,codeNum});
				if(null!=verificationCodes&&verificationCodes.size()>0){
						List<VerificationCode> verificationCodes2 = verificationCodeManageImpl.findBy("mobile", mobile);
						for (VerificationCode verificationCode2 : verificationCodes2) {
							verificationCodeManageImpl.delete(verificationCode2);
						}
						return true;
				}else{
					return false;
				}
			}
		} catch (Exception e) {
		}
		return false;
	}
	/**
	 * 功能描述：验证经纪人是否已经注册
	 */
	public void validateMember() {
		HttpServletRequest request = this.getRequest();
		try {
			Member member = getMemberBy();
			if(null==member){
				renderText("2");//已经注册，请直接登录！
				return  ;
			}
			String 	mobilePhone=request.getParameter("mobile");
			boolean validateMobilePhone = memberManageImpl.validateMobilePhone(mobilePhone, member.getDbid());
			if (validateMobilePhone) {
				renderText("2");//已经注册，请直接登录！
			}else{
				renderText("1");//
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderText("0");
		}
		return ;
	}
	/**
	 * 功能描述：记录经纪人奖励
	 * 参数描述：
	 * 逻辑描述：
	 */
	private void saveRewardReg(Member member,AgentSet agentSet) throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Enterprise enterprise = member.getEnterprise();
			if(null==enterprise){
				return ;
			}
			Reward reward=new Reward();
			reward.setCreateTime(new Date());
			reward.setCreator("系统管理员");
			reward.setMember(member);
			StringBuilder builder=new StringBuilder();
			builder.append("会员："+member.getName()+"");
			builder.append("注册经纪人奖励，奖励金额："+agentSet.getRegRewardNum());
			reward.setRewardFrom("注册经纪人奖励");
			reward.setRewardMoney(Float.valueOf(agentSet.getRegRewardNum()));
			reward.setNote(builder.toString());
			reward.setRewardType(Reward.REG);
			reward.setTurnBackStatus(1);
			reward.setEnterpriseId(enterprise.getDbid());
			rewardManageImpl.save(reward);
			
			//发送红包记录
			String remoteAddr = request.getRemoteAddr();
			if(null!=enterprise){
				redBagManageImpl.saveRedBagAgent(member, reward, enterprise, remoteAddr);
			}
			
			//会员返利总额
			Float turnBackMoney = member.getAgentMoney();
			turnBackMoney=turnBackMoney+agentSet.getRegRewardNum();
			member.setAgentMoney(turnBackMoney);
			memberManageImpl.save(member);
			
			String agentMessage="经纪人注册成功通知，您在【"+enterprise.getName()+"】经纪人已注册成功。奖励金额："+agentSet.getRegRewardNum()+",请注意查收。";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, member);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	/**
	 * 功能描述：记录经纪人奖励
	 * 参数描述：
	 * 逻辑描述：
	 */
	private void saveRewardAgent(Member parent,Member child,AgentSet agentSet) throws Exception {
		HttpServletRequest request = getRequest();
		try {
			Enterprise enterprise = member.getEnterprise();
			if(null==enterprise){
				return ;
			}
			Reward reward=new Reward();
			reward.setCreateTime(new Date());
			reward.setCreator("系统管理员");
			reward.setMember(parent);
			StringBuilder builder=new StringBuilder();
			builder.append("会员："+parent.getName()+"");
			builder.append("推荐经纪人【"+child.getName()+"】获得奖励，奖励金额："+agentSet.getRegParentRewardNum()+" 元");
			reward.setRewardFrom("推荐经纪人奖励");
			reward.setRewardMoney(Float.valueOf(agentSet.getRegParentRewardNum()));
			reward.setNote(builder.toString());
			reward.setRewardType(Reward.AGENT);
			reward.setTurnBackStatus(1);
			reward.setEnterpriseId(enterprise.getDbid());
			rewardManageImpl.save(reward);
			
			//发送红包记录
			String remoteAddr = request.getRemoteAddr();
			if(null!=enterprise){
				redBagManageImpl.saveRedBagAgent(parent, reward, enterprise, remoteAddr);
			}
			//会员返利总额
			Float turnBackMoney = parent.getAgentMoney();
			turnBackMoney=turnBackMoney+agentSet.getRegParentRewardNum();
			parent.setAgentMoney(turnBackMoney);
			memberManageImpl.save(parent);
			
			String agentMessage="推荐经纪人注册成功通知，您的推荐【"+child.getName()+"】已注册经纪人。奖励金额："+agentSet.getRegParentRewardNum()+" 元,请注意查收。";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, parent);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	
	/**
	 * 功能描述：注册送积分
	 * @param member
	 */
	private void registerSendPoint(Member member){
		if(null==member){
			return ;
		}
		Enterprise enterprise = member.getEnterprise();
		if(null==enterprise){
			return ;
		}
		List<MemPointrecordSet> memPointrecordSets = memPointrecordSetManageImpl.findBy("enterpriseId",enterprise.getDbid());
		if(null==memPointrecordSets||memPointrecordSets.size()<=0){
			return ;
		}
		MemPointrecordSet memPointrecordSet = memPointrecordSets.get(0);
		Integer rigPointStatus = memPointrecordSet.getRigPointStatus();
		//注册送积分
		if(null!=rigPointStatus&&rigPointStatus>0&&rigPointStatus==(int)MemPointrecordSet.START){
			if(null!=memPointrecordSet.getRigPointNum()&&memPointrecordSet.getRigPointNum()>0){
				StringBuffer buffer=new StringBuffer();
				PointRecord pointRecord=new PointRecord();
				pointRecord.setCreateTime(new Date());
				pointRecord.setCreator("系统管理员");
				pointRecord.setEnterpriseId(enterprise.getDbid());
				pointRecord.setMember(member);
				buffer.append("注册经纪人赠送积分，赠送："+memPointrecordSet.getRigPointNum()+" 积分。");
				pointRecord.setNote(buffer.toString());
				pointRecord.setNum(memPointrecordSet.getRigPointNum());
				pointRecord.setPointFrom("注册经纪人赠送积分");
				pointRecord.setType(1);
				pointRecordManageImpl.save(pointRecord);
				
				//更新会员积分记录
				memberManageImpl.updateMemberPoint(member, pointRecord);
				
				//发送微信消息
				String agentMessage="注册经纪人赠送积分通知，您在【"+enterprise.getName()+"】经纪人已注册成功。赠送："+memPointrecordSet.getRigPointNum()+" 积分，请在会员中心查看我的积分记录。";
				AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, member);
			}
		}
		//注册赠送上级积分
		Integer rigParentStatus = memPointrecordSet.getRigParentStatus();
		if(null!=rigParentStatus&&rigParentStatus>0&&rigParentStatus==(int)MemPointrecordSet.START){
			Integer rigParentNum = memPointrecordSet.getRigParentNum();
			if(null!=rigParentNum&&rigParentNum>0){
				WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
				if(null!=weixinGzuserinfo){
					WeixinGzuserinfo parent = weixinGzuserinfo.getParent();
					if(null!=parent){
						List<Member> members = memberManageImpl.findBy("weixinGzuserinfo.dbid", parent.getDbid());
						if(null!=members&&members.size()>0){
							Member parentMember = members.get(0);
							StringBuffer buffer=new StringBuffer();
							PointRecord pointRecord=new PointRecord();
							pointRecord.setCreateTime(new Date());
							pointRecord.setCreator("系统管理员");
							pointRecord.setEnterpriseId(enterprise.getDbid());
							pointRecord.setMember(member);
							buffer.append("注册经纪人赠送上级积分，赠送："+rigParentNum+" 积分。");
							pointRecord.setNote(buffer.toString());
							pointRecord.setNum(rigParentNum);
							pointRecord.setPointFrom("注册经纪人赠送上级积分");
							pointRecord.setType(1);
							pointRecordManageImpl.save(pointRecord);
							
							//更新会员积分记录
							memberManageImpl.updateMemberPoint(parentMember, pointRecord);
							
							//发送微信消息
							String agentMessage="推荐经纪人注册成功赠送上级积分通知，您的推荐【"+member.getName()+"】已注册经纪人。赠送："+rigParentNum+" 积分，请在会员中心查看我的积分记录。";
							AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, parentMember);
						}
					}
				}
			}
		}
	}
}
