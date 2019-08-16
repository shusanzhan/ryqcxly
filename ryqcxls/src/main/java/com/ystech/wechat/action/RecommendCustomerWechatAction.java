package com.ystech.wechat.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentMesg;
import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.model.WechatRecvier;
import com.ystech.agent.service.AgentMesgManageImpl;
import com.ystech.agent.service.AgentMessageUtil;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.agent.service.WechatRecvierManageImpl;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Member;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.weixin.core.util.SendMessageUtil;
import com.ystech.weixin.model.WeixinAccount;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.weixin.service.WeixinAccesstokenManageImpl;
import com.ystech.weixin.service.WeixinAccountManageImpl;
import com.ystech.weixin.service.WeixinGzuserinfoManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;


@Component("recommendCustomerWechatAction")
@Scope("prototype")
public class RecommendCustomerWechatAction extends BaseController{
	private RecommendCustomer recommendCustomer;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private AreaManageImpl areaManageImpl;
	private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	private WeixinAccesstokenManageImpl weixinAccesstokenManageImpl;
	private WeixinAccountManageImpl weixinAccountManageImpl;
	private WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl;
	private UserManageImpl userManageImpl;
	private WechatRecvierManageImpl wechatRecvierManageImpl;
	private AgentMesgManageImpl agentMesgManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private int memberId=7;
	private MemberManageImpl memberManageImpl;
	public RecommendCustomer getRecommendCustomer() {
		return recommendCustomer;
	}
	public void setRecommendCustomer(RecommendCustomer recommendCustomer) {
		this.recommendCustomer = recommendCustomer;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setAgentOperatorLogManageImpl(
			AgentOperatorLogManageImpl agentOperatorLogManageImpl) {
		this.agentOperatorLogManageImpl = agentOperatorLogManageImpl;
	}
	@Resource
	public void setWeixinAccesstokenManageImpl(
			WeixinAccesstokenManageImpl weixinAccesstokenManageImpl) {
		this.weixinAccesstokenManageImpl = weixinAccesstokenManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setAgentMesgManageImpl(AgentMesgManageImpl agentMesgManageImpl) {
		this.agentMesgManageImpl = agentMesgManageImpl;
	}
	@Resource
	public void setWeixinAccountManageImpl(
			WeixinAccountManageImpl weixinAccountManageImpl) {
		this.weixinAccountManageImpl = weixinAccountManageImpl;
	}
	@Resource
	public void setWeixinGzuserinfoManageImpl(
			WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl) {
		this.weixinGzuserinfoManageImpl = weixinGzuserinfoManageImpl;
	}
	@Resource
	public void setWechatRecvierManageImpl(
			WechatRecvierManageImpl wechatRecvierManageImpl) {
		this.wechatRecvierManageImpl = wechatRecvierManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
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
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			//地域信息
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			if(null!=member){
				Enterprise enterprise = member.getEnterprise();
				request.setAttribute("enterprise", enterprise);
				if(member.getAgentStatus()==null||member.getAgentStatus()==1){
					return "error";
				}
				request.setAttribute("member", member);
				List<CarSeriy> carSeriys = carSeriyManageImpl.findAjaxByEnterpriseIdAndBrandId(enterprise.getDbid(),null);
				request.setAttribute("carSeriys", carSeriys);
				return "recommendCustomer";
			}else{
				request.setAttribute("member", member);
				return "jionIn";
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "recommendCustomer";
	}
	/**
	 * 功能描述：保存推荐客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveRecommendCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				renderErrorMsg(new Throwable("提交失败，经纪人信息为空"), "");
				return ;
			}
			recommendCustomer.setMember(member);
			recommendCustomer.setAgentName(member.getName());
			recommendCustomer.setAgentPhone(member.getMobilePhone());
			recommendCustomer.setApprovalStatus(RecommendCustomer.APPROVALWAITING);
			recommendCustomer.setDistStatus(RecommendCustomer.DISTWATING);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				recommendCustomer.setBrand(carSeriy.getBrand());
				recommendCustomer.setCarSeriy(carSeriy);
				recommendCustomer.setCarModelName(carSeriy.getBrand().getName()+carSeriy.getName());
			}else{
				renderErrorMsg(new Throwable("提交失败，车型为空"), "");
				return ;
			}
			recommendCustomer.setTradeStatus(RecommendCustomer.TRADECOMM);
			recommendCustomer.setRewardStatus(RecommendCustomer.REWARD_COMM);
			recommendCustomer.setCustomerStatus(RecommendCustomer.CUSTOMERSTATUSCOMM);
			recommendCustomer.setModifyDate(new Date());
			recommendCustomer.setCreateDate(new Date());
			recommendCustomer.setRecommendDate(new Date());
			recommendCustomer.setEnterpriseId(member.getEnterprise().getDbid());
			recommendCustomerManageImpl.save(recommendCustomer);
			
			Integer agentNum = member.getAgentNum();
			if(null==agentNum){
				agentNum=1;
			}else{
				agentNum=agentNum+1;
			}
			member.setAgentNum(agentNum);
			//保存操作日志
			saveAgentOperatorLog("创建推荐客户", "", recommendCustomer);
			String message="推荐人【"+recommendCustomer.getAgentName()+"】联系电话"+recommendCustomer.getAgentPhone()+"】，推荐了【"+recommendCustomer.getName()+"】客户，客户联系电话"+recommendCustomer.getMobilePhone()+"，请尽快处理。";
			//saveWechatMessage(message);
			
			String agentMessage="客户提交成功通知，您的推荐信息已提交成功，我们将在2小时内处理，您也可以在【瑞一经纪人】->【个人中心】->【我的推荐】查看推荐客户状态";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, member);
			
			Member member2 = memberManageImpl.get(memberId);
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, message,member2);
			//sendMessage(message);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderMsg("", "保存失败");
			return ;
		}
		renderMsg("/agentWechat/index", "保存信息成功");
		return;
	}
	/**
	 * 功能描述：推荐客户编辑
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String editRecom() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			//推荐客户信息
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			//推荐人信息
			Member member = recommendCustomer2.getMember();
			request.setAttribute("member", member);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=? order by orderNum", CarSeriy.STATUSCOMM);
			request.setAttribute("carSeriys", carSeriys);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "editRecom";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveEdit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try {
			String wechatId = getWechatId();
			Member member = memberManageImpl.findUniqueBy("microId", wechatId);
			if(null==member){
				renderErrorMsg(new Throwable("提交失败，经纪人信息为空"), "");
				return ;
			}
			String 	mobilePhone=request.getParameter("mobile");
			List<RecommendCustomer> agents = recommendCustomerManageImpl.findBy("mobilePhone", mobilePhone);
			if(null!=agents&&agents.size()>0){
				renderErrorMsg(new Throwable("提交失败，手机号已经存在，请确认"), "");
				return ;
			}
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				recommendCustomer.setBrand(carSeriy.getBrand());
				recommendCustomer.setCarSeriy(carSeriy);
				recommendCustomer.setCarModelName(carSeriy.getBrand().getName()+carSeriy.getName());
			}else{
				renderErrorMsg(new Throwable("提交失败，车型为空"), "");
				return ;
			}
			
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(recommendCustomer.getDbid());
			recommendCustomer2.setBrand(recommendCustomer.getBrand());
			recommendCustomer2.setCarModel(recommendCustomer.getCarModel());
			recommendCustomer2.setCarModelName(recommendCustomer.getCarModelName());
			recommendCustomer2.setCarriageType(recommendCustomer.getCarriageType());
			recommendCustomer2.setCarSeriy(recommendCustomer.getCarSeriy());
			recommendCustomer2.setCity(recommendCustomer.getCity());
			recommendCustomer2.setMobilePhone(recommendCustomer.getMobilePhone());
			recommendCustomer2.setModifyDate(new Date());
			recommendCustomer2.setName(recommendCustomer.getName());
			recommendCustomer2.setSex(recommendCustomer.getSex());
			recommendCustomer2.setShopId(recommendCustomer.getShopId());
			recommendCustomer2.setBudgetMoney(recommendCustomer.getBudgetMoney());
			recommendCustomerManageImpl.save(recommendCustomer2);
			//保存操作日志
			saveAgentOperatorLog("编辑推荐客户", "", recommendCustomer);

			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderMsg("", "保存失败");
			return ;
		}
		renderMsg("/agentWechat/recommendCustomer?type=0", "保存信息成功");
		return;
	}
	/**
	 * 功能描述：删除推荐客户
	 * 参数描述：推荐客户未审批，推荐人可以删除
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete(){
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			recommendCustomerManageImpl.deleteById(dbid);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("删除推荐客户失败"), "");
			return ;
		}
		renderMsg("/agentWechat/recommendCustomer?type=0", "删除推荐客户成功");
		return;
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
				StringBuffer companyBuffer=new StringBuffer();
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
				StringBuffer companyBuffer=new StringBuffer();
				if(null!=citys&&citys.size()>0){
					areaBuffer.append("<select id='areaId' name='areaId' class='weui_select' checkType='integer,1'>");
					for (Area area : citys) {
						areaBuffer.append("<option value='"+area.getDbid()+"'>"+area.getName()+"</option>");
					}
					areaBuffer.append("</select> ");
					object.put("area", areaBuffer.toString());
					
					Area city = areaManageImpl.get(parentId);
					//设置区域经销商
					/*List<CompanyArea> companies = companyAreaManageImpl.executeSql("select * from sys_CompanyArea where city=? group by companyId", city.getName());
					if(null==companies||companies.size()<=0){
						companyBuffer.append("<select id='companyId' name='companyId' class='weui_select'>");
						companyBuffer.append("<option value='-1'>无经销商</option>");
						companyBuffer.append("</select> ");
						object.put("company", companyBuffer.toString());
					}else{
						companyBuffer.append("<select id='companyId' name='companyId' class='weui_select'  checkType='integer,1'>");
						for (CompanyArea companyArea : companies) {
							Company company = companyArea.getCompany();
							companyBuffer.append("<option value='"+companyArea.getDbid()+"'>"+company.getName()+"</option>");
						}
						companyBuffer.append("</select> ");
						object.put("company", companyBuffer.toString());
					}*/
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
	 * 功能描述：保存操作日志
	 * @param type
	 * @param note
	 * @param finCustomerId
	 */
	private void saveAgentOperatorLog(String type,String note,RecommendCustomer recommendCustomer){
		AgentOperatorLog agentOperatorLog=new AgentOperatorLog();
		agentOperatorLog.setCustomerId(recommendCustomer.getDbid());
		agentOperatorLog.setNote(note);
		agentOperatorLog.setOperateDate(new Date());
		agentOperatorLog.setOperator(recommendCustomer.getAgentName());
		agentOperatorLog.setType(type);
		agentOperatorLogManageImpl.save(agentOperatorLog);
	}
	/**
	 * 功能描述：添加发送微信通知信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveWechatMessage(String message)  {
		try {
				//查询厂商接受通知信息人员
			List<WechatRecvier> wechatRecviers = wechatRecvierManageImpl.getAll();
			if(null!=wechatRecviers&&wechatRecviers.size()>0){
				for (WechatRecvier wechatRecvier : wechatRecviers) {
					AgentMesg agentMesg=new AgentMesg();
					agentMesg.setCreateDate(new Date());
					agentMesg.setMesg(message);
					agentMesg.setModifyDate(new Date());
					agentMesg.setOpenId(wechatRecvier.getOpenId());
					agentMesg.setRealName(wechatRecvier.getUser().getRealName());
					agentMesg.setSendNum(1);
					agentMesg.setMsgType("text");
					agentMesg.setSendStatus(AgentMesg.COMM);
					agentMesg.setUserId(wechatRecvier.getUser().getDbid());
					agentMesgManageImpl.save(agentMesg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	private void sendMessage(String message){
		WeixinAccount weixinAccount = weixinAccountManageImpl.get(3);
		//String openId=new String("openId");
		WeixinGzuserinfo weixinGzuserinfo = weixinGzuserinfoManageImpl.get(6573);
		SendMessageUtil.sendMessage(weixinAccesstokenManageImpl, weixinAccount, weixinGzuserinfo.getOpenid(), message);
	}
	/**
	 * 功能描述：验证推荐用户是否已经推荐
	 */
	public void validateMobilePhone() {
		HttpServletRequest request = this.getRequest();
		try {
			String 	mobilePhone=request.getParameter("mobile");
			List<RecommendCustomer> agents = recommendCustomerManageImpl.findBy("mobilePhone", mobilePhone);
			if (null!=agents&&agents.size()>0) {
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
}
