package com.ystech.wechat.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.PointRecord;
import com.ystech.mem.model.Reward;
import com.ystech.mem.model.SpreadDetail;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.PointRecordManageImpl;
import com.ystech.mem.service.RewardManageImpl;
import com.ystech.mem.service.SpreadDetailManageImpl;
import com.ystech.weixin.core.util.WeixinCommon;
import com.ystech.weixin.core.util.WeixinUtil;
import com.ystech.weixin.model.WeixinAccesstoken;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.weixin.service.WeixinAccesstokenManageImpl;
import com.ystech.weixin.service.WeixinAccountManageImpl;
import com.ystech.weixin.service.WeixinGzuserinfoManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

@Component("agentWechatAction")
@Scope("prototype")
public class AgentWechatAction extends BaseController{
	private AreaManageImpl areaManageImpl;
	private PointRecordManageImpl pointRecordManageImpl;
	private RewardManageImpl rewardManageImpl;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private MemberManageImpl memberManageImpl;
	private SpreadDetailManageImpl spreadDetailManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private WeixinAccesstokenManageImpl weixinAccesstokenManageImpl;
	private WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private String url;
	private Member member;
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setPointRecordManageImpl(PointRecordManageImpl pointRecordManageImpl) {
		this.pointRecordManageImpl = pointRecordManageImpl;
	}
	@Resource
	public void setRewardManageImpl(RewardManageImpl rewardManageImpl) {
		this.rewardManageImpl = rewardManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setSpreadDetailManageImpl(
			SpreadDetailManageImpl spreadDetailManageImpl) {
		this.spreadDetailManageImpl = spreadDetailManageImpl;
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
	public void setWeixinGzuserinfoManageImpl(
			WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl) {
		this.weixinGzuserinfoManageImpl = weixinGzuserinfoManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	
	/**
	 * 功能描述：我要加入
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String jionIn() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null!=member){
				if(member.getMemAuthStatus()==Member.AGENTAUTHCOMM||member.getMemAuthStatus()==null){
					setUrl("/agentWechat/jionIn");
					return "jionIn";
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
		return "jionIn";
	}
	/**
	 * 功能描述：完善资料
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String info() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				return "weixinNullError";
			}
			request.setAttribute("member", member);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		
		return "info";
	}
	/**
	 * 功能描述：保存完善经纪人资料
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveInfo() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Member member2 = memberManageImpl.get(member.getDbid());
			member2.setPayType(member.getPayType());
			member2.setAccountNo(member.getAccountNo());
			member2.setName(member.getName());
			member2.setSex(member.getSex());
			member2.setIcard(member.getIcard());
			member2.setModifyTime(new Date());
			memberManageImpl.save(member2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("保存数据失败"), "");
			return ;
		}
		renderMsg("/agentWechat/info", "保存信息成功");
		return;
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
			if(null==member){
				return "weixinNullError";
			}
			request.setAttribute("member", member);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "memberCenter";
	}
	/**
	 * 功能描述：我的提成
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myMoney() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				return "weixinNullError";
			}
			request.setAttribute("member", member);
			
			List<Reward> fanlis = rewardManageImpl.findBy("member.dbid", member.getDbid());
			request.setAttribute("fanlis", fanlis);
			//我的当前排名
			Integer curentSn = memberManageImpl.getCurentSn(wechatId);
			request.setAttribute("curentSn", curentSn);
			Integer totalMoney = rewardManageImpl.getCurrentMonth(member.getDbid());
			request.setAttribute("totalMoney", totalMoney);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myMoney";
	}
	/**
	 * 功能描述：我的积分
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myPoint() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				return "weixinNullError";
			}
			List<PointRecord> pointRecords = pointRecordManageImpl.findBy("member.dbid", member.getDbid());
			request.setAttribute("pointRecords", pointRecords);
			request.setAttribute("member", member);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myPoint";
	}
	/**
	 * 功能描述：推荐客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String recommendCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer type = ParamUtil.getIntParam(request, "type",-1);
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				return "weixinNullError";
			}
			String sql="select * from agent_RecommendCustomer where memberId="+member.getDbid();
			if(type>0){
				sql=sql+" and tradeStatus="+type;
			}
			List<RecommendCustomer> recommendCustomers = recommendCustomerManageImpl.executeSql(sql,null);
			request.setAttribute("recommendCustomers", recommendCustomers);
			
			Enterprise enterprise2 = member.getEnterprise();
			request.setAttribute("enterprise", enterprise2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "recommendCustomer";
	}
	/**
	 * 功能描述：推荐客户明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String recommendCustomerDetial() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer recommendCustomerDbid = ParamUtil.getIntParam(request, "recommendCustomerDbid", -1);
		try {
			RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerDbid);
			Member member = recommendCustomer.getMember();
			if(null==member){
				return "weixinNullError";
			}
			request.setAttribute("member", member);
			request.setAttribute("recommendCustomer", recommendCustomer);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "recommendCustomerDetial";
	}
	/**
	 * 功能描述：推荐客户明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerDetial() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer recommendCustomerDbid = ParamUtil.getIntParam(request, "recommendCustomerDbid", -1);
		try {
			RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerDbid);
			request.setAttribute("recommendCustomer", recommendCustomer);
			Member member2 = recommendCustomer.getMember();
			request.setAttribute("member", member2);
			if(null==member2){
				return "weixinNullError";
			}
			if(null!=recommendCustomer){
				Customer customer2 = customerMangeImpl.findUniqueBy("recommendCustomer.dbid", recommendCustomer.getDbid());
				request.setAttribute("customer", customer2);
				if(null!=customer2){
					//客户业务信息
					CustomerBussi customerBussi2 = customer2.getCustomerBussi();
					request.setAttribute("customerBussi", customerBussi2);
					
					CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
					request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
					
					//客户跟踪记录
					List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customer2.getDbid(),CustomerTrack.TASKFINISHTYPECOMM});
					request.setAttribute("customertracks", customerTracks);
					
					//最终结果信息
					CustomerLastBussi customerLastBussi = customer2.getCustomerLastBussi();
					request.setAttribute("customerLastBussi", customerLastBussi);
					
					OrderContract orderContract = customer2.getOrderContract();
					request.setAttribute("orderContract", orderContract);
					
					CustomerPidBookingRecord customerPidBookingRecord = customer2.getCustomerPidBookingRecord();
					request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerDetial";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCity() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		try{
			JSONObject object=new JSONObject();
			if(parentId>0){
				List<Area> citys = areaManageImpl.findBy("area.dbid",parentId);
				StringBuffer cityBuffer=new StringBuffer();
				StringBuffer areaBuffer=new StringBuffer();
				if(null!=citys&&citys.size()>0){
					cityBuffer.append("<select id='cityId' name='cityId' class='weui_select' onchange='ajaxArea(this)' checkType='integer,1'>");
					for (Area area : citys) {
						cityBuffer.append("<option value='"+area.getDbid()+"'>"+area.getName()+"</option>");
					}
					cityBuffer.append("</select> ");
					object.put("city", cityBuffer.toString());
					///设置区域
					Area city = citys.get(0);
					List<Area> areas = areaManageImpl.findBy("area.dbid",city.getDbid());
					areaBuffer.append("<select id='areaId' name='areaId' class='weui_select'  checkType='integer,1'>");
					for (Area area2 : areas) {
						areaBuffer.append("<option value='"+area2.getDbid()+"'>"+area2.getName()+"</option>");
					}
					areaBuffer.append("</select> ");
					object.put("area", areaBuffer.toString());
					renderJson(object.toString());
				}else{
					renderText("error");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderText("error");
			return ;
		}
		return ;
	}
	/**
	 * 功能描述：获取区域
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxArea() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parentId = ParamUtil.getIntParam(request, "parentId", -1);
		try{
			JSONObject object=new JSONObject();
			if(parentId>0){
				List<Area> citys = areaManageImpl.findBy("area.dbid",parentId);
				StringBuffer areaBuffer=new StringBuffer();
				if(null!=citys&&citys.size()>0){
					areaBuffer.append("<select id='areaId' name='areaId' class='weui_select' checkType='integer,1'>");
					for (Area area : citys) {
						areaBuffer.append("<option value='"+area.getDbid()+"'>"+area.getName()+"</option>");
					}
					areaBuffer.append("</select> ");
					object.put("area", areaBuffer.toString());
					
					renderJson(object.toString());
				}else{
					renderText("error");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderText("error");
			return ;
		}
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String mySpreadDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			request.setAttribute("member", member);
			if(null!=member){
				WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
				List<SpreadDetail> spreadDetails = spreadDetailManageImpl.findBy("weixinGzuserinfo.dbid", weixinGzuserinfo.getDbid());
				if(null!=spreadDetails&&spreadDetails.size()>0){
					request.setAttribute("spreadDetail", spreadDetails.get(0));
					Integer accountid = weixinGzuserinfo.getAccountid();
					WeixinAccount weixinAccount = weixinAccountManageImpl.get(accountid);
					WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
					WeixinCommon weixinCommon = getWeixinCommon("/agentWechat/mySpreadDetail",accessToken,weixinAccount);
					request.setAttribute("weixinCommon", weixinCommon);
					request.setAttribute("weixinAccount", weixinAccount);
				}
			}else{
				return "weixinNullError";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "mySpreadDetail";
	}
	/**
	 * 功能描述：参数二维码
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String shareSpreadDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		String sceneStr = request.getParameter("sceneStr");
		try {
			SpreadDetail spreadDetail = spreadDetailManageImpl.findUniqueBy("sceneStr", sceneStr);
			request.setAttribute("spreadDetail", spreadDetail);
			if(null!=spreadDetail){
				WeixinGzuserinfo weixinGzuserinfo = spreadDetail.getWeixinGzuserinfo();
				Member member = memberManageImpl.findByOpenId(weixinGzuserinfo.getOpenid());
				request.setAttribute("member", member);
				if(null!=weixinGzuserinfo){
					WeixinAccount weixinAccount = weixinAccountManageImpl.get(weixinGzuserinfo.getAccountid());
					WeixinAccesstoken accessToken = WeixinUtil.getAccessToken(weixinAccesstokenManageImpl,weixinAccount);
					WeixinCommon weixinCommon = getWeixinCommon("/agentWechat/shareSpreadDetail",accessToken,weixinAccount);
					request.setAttribute("weixinCommon", weixinCommon);
					request.setAttribute("weixinAccount", weixinAccount);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "shareSpreadDetail";
	}
	/**
	 * 功能描述：我的经纪人
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String myAgent() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			request.setAttribute("member", member);
			if(null!=member){
				WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
				String sql="SELECT *  "
						+ "from "
						+ "mem_member mem,weixin_gzuserinfo gz "
						+ "WHERE mem.weixinGzuserinfoId=gz.dbid AND gz.parentId="+weixinGzuserinfo.getDbid();
				List<Member> members = memberManageImpl.executeSql(sql, null);
				request.setAttribute("members", members);
			}else{
				return "weixinNullError";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "myAgent";
	}
}
