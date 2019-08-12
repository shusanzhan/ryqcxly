package com.ystech.agent.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.AgentSet;
import com.ystech.agent.model.AgentSetLevel;
import com.ystech.agent.model.FlowReason;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentMesgManageImpl;
import com.ystech.agent.service.AgentMessageUtil;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.AgentSetLevelManageImpl;
import com.ystech.agent.service.AgentSetManageImpl;
import com.ystech.agent.service.FlowReasonManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.excel.RecommendCustomerToExcel;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.CheckIdCardUtils;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.BuyCarBudget;
import com.ystech.cust.model.BuyCarCare;
import com.ystech.cust.model.BuyCarMainUse;
import com.ystech.cust.model.BuyCarTarget;
import com.ystech.cust.model.BuyCarType;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.service.BuyCarBudgetManageImpl;
import com.ystech.cust.service.BuyCarCareManageImpl;
import com.ystech.cust.service.BuyCarMainUseManageImpl;
import com.ystech.cust.service.BuyCarTargetManageImpl;
import com.ystech.cust.service.BuyCarTypeManageImpl;
import com.ystech.cust.service.CustomerBussiManageImpl;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.mem.model.MemPointrecordSet;
import com.ystech.mem.model.Member;
import com.ystech.mem.model.PointRecord;
import com.ystech.mem.model.Reward;
import com.ystech.mem.model.Spread;
import com.ystech.mem.service.MemPointrecordSetManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.PointRecordManageImpl;
import com.ystech.mem.service.RewardManageImpl;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.weixin.model.WeixinGzuserinfo;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarColor;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarColorManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("recommendCustomerAction")
@Scope("prototype")
public class RecommendCustomerAction extends BaseController{
	private RecommendCustomer recommendCustomer;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private UserManageImpl userManageImpl;
	private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private AreaManageImpl areaManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private BuyCarTypeManageImpl buyCarTypeManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private FlowReasonManageImpl flowReasonManageImpl;
	private AgentMesgManageImpl agentMesgManageImpl;
	private RecommendCustomerToExcel recommendCustomerToExcel;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private MemberManageImpl memberManageImpl;
	private CustomerTractUtile customerTractUtile;
	private AgentSetManageImpl agentSetManageImpl;
	private PointRecordManageImpl pointRecordManageImpl;
	private RewardManageImpl rewardManageImpl;
	private RedBagManageImpl redBagManageImpl;
	private MemPointrecordSetManageImpl memPointrecordSetManageImpl;
	private AgentSetLevelManageImpl agentSetLevelManageImpl;
	@Resource
	public void setFlowReasonManageImpl(FlowReasonManageImpl flowReasonManageImpl) {
		this.flowReasonManageImpl = flowReasonManageImpl;
	}
	public RecommendCustomer getRecommendCustomer() {
		return recommendCustomer;
	}
	
	@Resource
	public void setRecommendCustomerToExcel(
			RecommendCustomerToExcel recommendCustomerToExcel) {
		this.recommendCustomerToExcel = recommendCustomerToExcel;
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
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setAgentOperatorLogManageImpl(
			AgentOperatorLogManageImpl agentOperatorLogManageImpl) {
		this.agentOperatorLogManageImpl = agentOperatorLogManageImpl;
	}
	@Resource
	public void setAgentMesgManageImpl(AgentMesgManageImpl agentMesgManageImpl) {
		this.agentMesgManageImpl = agentMesgManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setAgentSetManageImpl(AgentSetManageImpl agentSetManageImpl) {
		this.agentSetManageImpl = agentSetManageImpl;
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
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}
	@Resource
	public void setMemPointrecordSetManageImpl(
			MemPointrecordSetManageImpl memPointrecordSetManageImpl) {
		this.memPointrecordSetManageImpl = memPointrecordSetManageImpl;
	}
	@Resource
	public void setAgentSetLevelManageImpl(
			AgentSetLevelManageImpl agentSetLevelManageImpl) {
		this.agentSetLevelManageImpl = agentSetLevelManageImpl;
	}
	/**
	 * 功能描述：查询经纪人
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryCompanyManageList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		Integer tradeStatus = ParamUtil.getIntParam(request, "tradeStatus", -11);
		Integer distStatus = ParamUtil.getIntParam(request, "distStatus", -1);
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from agent_recommendcustomer where 1=1 ";
			if(enterprise.getDbid()>0){
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
			}
			List params=new ArrayList();
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(tradeStatus>0){
				sql=sql+" and tradeStatus=? ";
				params.add(tradeStatus);
			}
			if(distStatus>0){
				sql=sql+" and distStatus=? ";
				params.add(distStatus);
			}
			sql=sql+" and approvalStatus=? ";
			params.add(recommendCustomer.APPROVALED);
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			Page<RecommendCustomer> page = recommendCustomerManageImpl.pagedQuerySql(pageNo, pageSize, RecommendCustomer.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "companyManageList";
	}
	/**
	 * 功能描述：查询经纪人
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryCompanySalerList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from agent_recommendcustomer where salerId="+currentUser.getDbid();
			List params=new ArrayList();
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			Page<RecommendCustomer> page = recommendCustomerManageImpl.pagedQuerySql(pageNo, pageSize, RecommendCustomer.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "companySalerList";
	}
	/**
	 * 功能描述：查询经纪人 等待审批（凯翼厂商）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryWaitingList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer companyStatus = ParamUtil.getIntParam(request, "companyStatus", -1);
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String compnayName = request.getParameter("compnayName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//省
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			if(proviceId>0){
				List<Area> cityAreas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{proviceId});
				request.setAttribute("citys", cityAreas);
			}
			if(cityId>0){
				List<Area> areas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{cityId});
				request.setAttribute("areas", areas);
			}
			
			String sql="select * from agent_recommendcustomer where 1=1 and approvalStatus=?";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				sql=sql+" and enterpriseId="+enterprise.getDbid();
			}
			params.add(RecommendCustomer.APPROVALWAITING);
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(null!=compnayName&&compnayName.trim().length()>0){
				sql=sql+" and compnayName like ? ";
				params.add("%"+compnayName+"%");
			}
			if(proviceId>0){
				sql=sql+" and province=? ";
				Area area = areaManageImpl.get(proviceId);
				params.add(area.getName());
			}
			if(cityId>0){
				sql=sql+" and city=? ";
				Area area = areaManageImpl.get(cityId);
				params.add(area.getName());
			}
			if(areaId>0){
				sql=sql+" and areaStr=? ";
				Area area = areaManageImpl.get(areaId);
				params.add(area.getName());
			}
			if(companyStatus>0){
				if(companyStatus==1){
					sql=sql+" and companyId is null ";
				}
				if(companyStatus==2){
					sql=sql+" and companyId is not null ";
				}
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			Page<RecommendCustomer> page= recommendCustomerManageImpl.pagedQuerySql(pageNo, pageSize, RecommendCustomer.class, sql, params.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "waitingList";
	}
	/**
	 * 功能描述：客户无效处理
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String outFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request,"dbid", -1);
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			
			List<FlowReason> flowReasons= flowReasonManageImpl.getAll();
			request.setAttribute("flowReasons", flowReasons);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "outFlow";
	}
	/**
	 * 功能描述：保存客户流失
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer flowReasonId = ParamUtil.getIntParam(request, "flowReasonId", -1);
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			if(flowReasonId<0){
				renderErrorMsg(new Throwable("保存数据错误，请选择无效原因"),"");
				return ;
			}
			String note = request.getParameter("note");
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			FlowReason flowReason = flowReasonManageImpl.get(flowReasonId);
			recommendCustomer2.setFlowReason(flowReason);
			recommendCustomer2.setFlowNote(note);
			//客户流失
			recommendCustomer2.setApprovalStatus(RecommendCustomer.APPROVALINVALID);
			recommendCustomer2.setTradeStatus(RecommendCustomer.TRADEFAIL);
			recommendCustomerManageImpl.save(recommendCustomer2);
			User currentUser = SecurityUserHolder.getCurrentUser();
			saveAgentOperatorLog("推荐客户无效", currentUser.getRealName()+"：无效客户操作", dbid);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/recommendCustomer/queryWaitingList?pageSize="+pageSize+"&currentPage="+pageNo, "保存数据成功");
		return;
	}
	/**
	 * 功能描述：无效客户列表 厂商
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryInvalidList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer companyStatus = ParamUtil.getIntParam(request, "companyStatus", -1);
		String name = request.getParameter("name");
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String compnayName = request.getParameter("compnayName");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			//省
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			if(proviceId>0){
				List<Area> cityAreas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{proviceId});
				request.setAttribute("citys", cityAreas);
			}
			if(cityId>0){
				List<Area> areas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{cityId});
				request.setAttribute("areas", areas);
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from agent_recommendcustomer where 1=1 and approvalStatus=? and enterpriseId="+enterprise.getDbid();
			List params=new ArrayList();
			params.add(RecommendCustomer.APPROVALINVALID);
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(proviceId>0){
				sql=sql+" and province=? ";
				Area area = areaManageImpl.get(proviceId);
				params.add(area.getName());
			}
			if(cityId>0){
				sql=sql+" and city=? ";
				Area area = areaManageImpl.get(cityId);
				params.add(area.getName());
			}
			if(areaId>0){
				sql=sql+" and areaStr=? ";
				Area area = areaManageImpl.get(areaId);
				params.add(area.getName());
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			Page<RecommendCustomer> page= recommendCustomerManageImpl.pagedQuerySql(pageNo, pageSize, RecommendCustomer.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "invalidList";
	}
	/**
	 * 功能描述：查询经纪人（凯翼厂商）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer tradeStatus = ParamUtil.getIntParam(request, "tradeStatus", -11);
		Integer distStatus = ParamUtil.getIntParam(request, "distStatus", -1);
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		Integer companyStatus = ParamUtil.getIntParam(request, "companyStatus", -1);
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String compnayName = request.getParameter("compnayName");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		
		try{
			//省
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			if(proviceId>0){
				List<Area> cityAreas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{proviceId});
				request.setAttribute("citys", cityAreas);
			}
			if(cityId>0){
				List<Area> areas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{cityId});
				request.setAttribute("areas", areas);
			}
			
			String sql="select * from agent_recommendcustomer where 1=1 and approvalStatus=? ";
			List params=new ArrayList();
			params.add(RecommendCustomer.APPROVALED);
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(tradeStatus>0){
				sql=sql+" and tradeStatus=? ";
				params.add(tradeStatus);
			}
			if(null!=compnayName&&compnayName.trim().length()>0){
				sql=sql+" and compnayName like ? ";
				params.add("%"+compnayName+"%");
			}
			if(proviceId>0){
				sql=sql+" and province=? ";
				Area area = areaManageImpl.get(proviceId);
				params.add(area.getName());
			}
			if(cityId>0){
				sql=sql+" and city=? ";
				Area area = areaManageImpl.get(cityId);
				params.add(area.getName());
			}
			if(areaId>0){
				sql=sql+" and areaStr=? ";
				Area area = areaManageImpl.get(areaId);
				params.add(area.getName());
			}
			if(companyStatus>0){
				if(companyStatus==1){
					sql=sql+" and companyId is null ";
				}
				if(companyStatus==2){
					sql=sql+" and companyId is not null ";
				}
			}
			if(distStatus>0){
				sql=sql+" and distStatus=? ";
				params.add(distStatus);
			}
			if(approvalStatus>0){
				sql=sql+" and approvalStatus=? ";
				params.add(approvalStatus);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			 Page<RecommendCustomer> page= recommendCustomerManageImpl.pagedQuerySql(pageNo, pageSize, RecommendCustomer.class, sql, params.toArray());
			 request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：推荐客户档案
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String recommendCustomerFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			Member member = recommendCustomer2.getMember();
			request.setAttribute("member", member);
			List<AgentOperatorLog> agentOperatorLogs = agentOperatorLogManageImpl.findBy("customerId", recommendCustomer2.getDbid());
			request.setAttribute("agentOperatorLogs", agentOperatorLogs);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "recommendCustomerFile";
	}
	/**
	 * 功能描述：推荐人档案
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String agentFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer memberId = ParamUtil.getIntParam(request, "agentId", -1);
		try {
			Member member = memberManageImpl.get(memberId);
			request.setAttribute("member", member);
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null!=member){
				List<RecommendCustomer> recommendCustomers = recommendCustomerManageImpl.executeSql("select * from agent_RecommendCustomer where memberId=? and enterpriseId=? ", new Object[]{member.getDbid(),enterprise.getDbid()});
				request.setAttribute("recommendCustomers", recommendCustomers);
				
				//历史推荐人数
				List<RecommendCustomer> hisRecommendCustomers = recommendCustomerManageImpl.findBy("member.dbid", member.getDbid());
				request.setAttribute("hisRecommendCustomers", hisRecommendCustomers);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "agentFile";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			
			Member member = recommendCustomer2.getMember();
			request.setAttribute("member", member);
			
			List<AgentOperatorLog> agentOperatorLogs = agentOperatorLogManageImpl.findBy("customerId", recommendCustomer2.getDbid());
			request.setAttribute("agentOperatorLogs", agentOperatorLogs);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFile";
	}
	/**
	 * 功能描述：单个审批
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void approval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				User currentUser = SecurityUserHolder.getCurrentUser();
				RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
				recommendCustomer2.setApprovalDate(new Date());
				recommendCustomer2.setApprovalStatus(RecommendCustomer.APPROVALED);
				recommendCustomer2.setApprovalUser(currentUser.getRealName());
				recommendCustomerManageImpl.save(recommendCustomer2);
				//保存操作日志
				saveAgentOperatorLog("推荐客户审核", "", recommendCustomer2.getDbid());
				
				
			}else{
				renderErrorMsg(new Throwable("请先选择审批数据"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/recommendCustomer/queryCompanyManageList"+query, "审批数据成功！");
		return;
	}
	/**
	 * 功能描述：单个审批
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void approvalMore() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
		try {
			if(null!=dbids&&dbids.length>0){
				for (Integer dbid : dbids) {
					if(dbid>0){
						User currentUser = SecurityUserHolder.getCurrentUser();
						RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
						recommendCustomer2.setApprovalDate(new Date());
						recommendCustomer2.setApprovalStatus(RecommendCustomer.APPROVALED);
						recommendCustomer2.setApprovalUser(currentUser.getRealName());
						recommendCustomerManageImpl.save(recommendCustomer2);
						//创建经销商 经纪人 数据库
						//保存操作日志
						saveAgentOperatorLog("推荐客户审核", "", recommendCustomer2.getDbid());
					}
				}
			
			}else{
				renderErrorMsg(new Throwable("请先选择审批数据"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/recommendCustomer/queryCompanyManageList", "审批数据成功！");
		return;
	}
	/**
	 * 功能描述：页面跳转到分配页面(公司分配经销商）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String distriCompnay() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			
			Enterprise enterprise = enterpriseManageImpl.get(recommendCustomer2.getEnterpriseId());
			request.setAttribute("enterprise", enterprise);
			
			List<AgentSet> agentSets = agentSetManageImpl.findBy("enterpriseId", enterprise.getDbid());
			if(null!=agentSets&&agentSets.size()>0){
				request.setAttribute("agentSet", agentSets.get(0));
			}
			
			List<User> users = userManageImpl.findBy("enterprise.dbid",enterprise.getDbid());
			request.setAttribute("users", users);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "distriCompnay";
	}
	/**
	 * 功能描述：保存公司分配状态
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveDistriCompnay() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer companyId = ParamUtil.getIntParam(request, "companyId", -1);
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Double point = ParamUtil.getDoubleParam(request, "point", Double.valueOf(0));
		Double rewardMoney = ParamUtil.getDoubleParam(request, "rewardMoney", Double.valueOf(0));
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		try {
			if(companyId<0){
				renderErrorMsg(new Throwable("保存数据错误，择经销商为空"),"");
				return ;
			}
			User currentUser2 = SecurityUserHolder.getCurrentUser();
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			recommendCustomer2.setRewardMoney(rewardMoney.floatValue());
			recommendCustomer2.setPoint(point.floatValue());
			if(type==1){
				recommendCustomer2.setApprovalDate(new Date());
				recommendCustomer2.setApprovalStatus(RecommendCustomer.APPROVALED);
				recommendCustomer2.setApprovalUser(currentUser2.getRealName());
			}
			
			User saler = userManageImpl.get(salerId);
			recommendCustomer2.setSaler(saler);
			recommendCustomer2.setDistDate(new Date());
			recommendCustomer2.setDistUser(currentUser2.getRealName());
			recommendCustomer2.setDistStatus(RecommendCustomer.DISTED);
			recommendCustomerManageImpl.save(recommendCustomer2);
			
			saveAgentOperatorLog("推荐客户分配", "", recommendCustomer2.getDbid());
			
			recommendCustomerManageImpl.save(recommendCustomer2);
			User currentUser = SecurityUserHolder.getCurrentUser();
			saveAgentOperatorLog("客服部分配推荐客户", currentUser.getRealName()+"：分配客户到销售顾问", dbid);
			//发送微信通知信息
			String message="客服经理已经受理了您的推荐，客户【"+recommendCustomer2.getName()+"】已分配专属销售顾问【"+saler.getRealName()+"】，销售顾问的联系电话是【"+saler.getMobilePhone()+"】,您也可以在【微众销】->【个人中心】->【我的推荐】查看推荐客户状态";
			Member member = recommendCustomer2.getMember();
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, message, member);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		if(type==1){
			renderMsg("/recommendCustomer/queryWaitingList?pageSize="+pageSize+"&currentPage="+pageNo, "保存数据成功");
		}
		if(type==2){
			renderMsg("/recommendCustomer/queryList?pageSize="+pageSize+"&currentPage="+pageNo, "保存数据成功");
		}
		return;
	}
	/**
	 * 功能描述：页面跳转到分配页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String distribution() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			
			List<User> users = userManageImpl.findBy("enterprise.dbid",enterprise.getDbid());
			request.setAttribute("users", users);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "distribution";
	}
	/**
	 * 功能描述：保存分配销售顾问
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveDistribution() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try {
			if(dbid>0){
				RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
				User saler = userManageImpl.get(salerId);
				recommendCustomer2.setSaler(saler);
				recommendCustomer2.setDistDate(new Date());
				recommendCustomer2.setDistUser(currentUser.getRealName());
				recommendCustomer2.setDistStatus(RecommendCustomer.DISTED);
				recommendCustomerManageImpl.save(recommendCustomer2);
				
				saveAgentOperatorLog("推荐客户分配", "", recommendCustomer2.getDbid());
			}else{
				renderErrorMsg(new Throwable("请先选分配客户"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/recommendCustomer/queryCompanyManageList"+query, "审批数据成功！");
		return;
	}
	/**
	 * 功能描述：登记客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String toCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(dbid);
			request.setAttribute("recommendCustomer", recommendCustomer2);
			
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			
			if(null!=recommendCustomer2.getArea()){
				String areaSelect = areaSelect(recommendCustomer2.getArea());
				request.setAttribute("areaSelect", areaSelect);
			}
			List<Department> departments = departmentManageImpl.getAll();
			request.setAttribute("departments", departments);
			
			//购车类型
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			//品牌
			List<Brand> brands = brandManageImpl.getAll();
			request.setAttribute("brands", brands);
			Brand brand = recommendCustomer2.getBrand();
			if(null!=brand){
				//意向车型
				List<CarSeriy>  carSeriys= carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
				request.setAttribute("carSeriys", carSeriys);
			}
			CarSeriy carSeriy = recommendCustomer2.getCarSeriy();
			if(null!=carSeriy){
				List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
				request.setAttribute("carModels", carModels);
			}
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type",CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			
			
			String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(null);
			request.setAttribute("customerInfromSelect", customerInfromSelect);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "toCustomer";
	}
	/**
	 * 验证销售顾问填写两个相同的客户信息
	 * @param name
	 * @param mobilePhone
	 * @return
	 */
	public Customer validateCustomer(String mobilePhone,Integer bussiStaffId){
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Customer> customers = customerMangeImpl.find("from Customer where  mobilePhone=? and enterprise.dbid=? ", new Object[]{mobilePhone,enterprise.getDbid()});
			if(null!=customers&&customers.size()>0){
				for (Customer customer : customers) {
					CustomerPhase customerPhase = customer.getCustomerPhase();
					if(customerPhase.getName().equals("F")){
						return null;
					}
					return customer;
				}
			}else{
				return null;
			}
		}
		return null;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCustomerShoppingRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer red = ParamUtil.getIntParam(request, "red", 0);
		Integer recommendCustomerId = ParamUtil.getIntParam(request, "recommendCustomerId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		try{
			//验证添加相同的客户信息
			User currentUser = SecurityUserHolder.getCurrentUser();
			Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
			//修改推荐客户状态为登记客户
			RecommendCustomer recommendCustomer2 = recommendCustomerManageImpl.get(recommendCustomerId);
			//客户来源
			if(customerInfromId>0){
				CustomerInfrom customerInfrom = customerInfromManageImpl.get(customerInfromId);
				customer.setCustomerType(null);;
				customer.setCustomerInfrom(customerInfrom);
				CustomerInfrom parent = customerInfrom.getParent();
				if(null==parent){
					customerShoppingRecord.setComeType(customerInfrom.getDbid());
				}else{
					customerShoppingRecord.setComeType(parent.getDbid());
				}
			}
			/**保持customer 信息**/
			String no = customer.getSn();
			if(null==no||no.trim().length()<=0){
				no=DateUtil.generatedName(new Date());
				customer.setSn(no);
			}
			Customer customer2 = validateCustomer(customer.getMobilePhone(), currentUser.getDbid());
			if(null!=customer2){
				if(customer2.getUser().getDbid()==(int)currentUser.getDbid()){
					renderErrorMsg(new Throwable("您已添加该客户，请确认!"), "");
					return ;
				}else{
					renderErrorMsg(new Throwable("【"+customer2.getBussiStaff()+"】销售顾问已接待该客户，请确认!"), "");
					return ;
				}
			}
			if(null==customer.getDbid()||customer.getDbid()<=0){
				//客户最终状态
				customer.setLastResult(Customer.NORMAL);
				//客户订单状态
				customer.setOrderContractStatus(Customer.ORDERNOT);
			}
			customer.setArea(recommendCustomer2.getArea());
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi.setBrand(brand);
			}
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			CarModel carModel=null;
			if(carModelId>0){
				 carModel = carModelManageImpl.get(carModelId);
				 customerBussi.setCarModel(carModel);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			CarSeriy carSeriy=null;
			if(carSeriyId>0){
				 carSeriy = carSeriyManageImpl.get(carSeriyId);
				 customerBussi.setCarSeriy(carSeriy);
			}
			customer.setUser(currentUser);
			customer.setBussiStaff(currentUser.getRealName());
			if(null!=currentUser.getDepartment()){
				customer.setDepartment(currentUser.getDepartment());
				customer.setSuccessDepartment(currentUser.getDepartment());
				customer.setEnterprise(currentUser.getEnterprise());
			}
			//设置客户追踪状态
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			CustomerPhase customerPhase=null;
			if(customerPhaseId>0){
				customerPhase = customerPhaseManageImpl.get(customerPhaseId);
				//固定初始状态
				customer.setFirstCustomerPhase(customerPhase);
				//需修改状态
				customer.setCustomerPhase(customerPhase);
				
				//如果意向级别为O级 那么设置客户的状态为成交状态
				if(null!=customerPhase){
					if(customerPhase.getName().equals("O")){
						customer.setLastResult(lastResult);
					}
				}
			
			}
			if(null!=customer.getIcard()&&customer.getIcard().trim().length()>0){
				String icard = customer.getIcard();
				if(CheckIdCardUtils.validateCard(icard)){
					int age = CheckIdCardUtils.getAgeByIdCard(icard);
					String birthDay = CheckIdCardUtils.getBirthByIdCard(icard);
					customer.setAge(age);
					customer.setNbirthday(DateUtil.string2Date(birthDay));
					String gender = CheckIdCardUtils.getGenderByIdCard(icard);
					if(gender.equals("M")){
						customer.setAge(1);
					}
					if(gender.equals("F")){
						customer.setAge(2);
					}
				}
			}
			
			Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			if(areaId>0){
				Area area = areaManageImpl.get(areaId);
				customer.setArea(area);
			}
			
			customer.setDepartment(currentUser.getDepartment());
			customer.setSuccessDepartment(currentUser.getDepartment());

			//**************************************保存最终成交结果***********************************************//
			if(null!=customerPhase){
				if(customerPhase.getName().equals("O")){
					Integer carColor = ParamUtil.getIntParam(request, "carColor", -1);
					customerBussi.setBrand(brand);
					customerBussi.setCarModel(carModel);
					customerBussi.setCarSeriy(carSeriy);
					if(carColor>0){
						CarColor carColor2 = carColorManageImpl.get(carColor);
						customerLastBussi.setCarColor(carColor2);
					}
				}
			}
			customer.setRecordType(Customer.CUSTOMERTYPECOMM);
			customer.setCreateFolderTime(new Date());
			Enterprise enterprise = currentUser.getEnterprise();
			customer.setEnterprise(enterprise);
			customer.setRecommendCustomer(recommendCustomer2);
			customerMangeImpl.save(customer);
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "登记客户信息", "");
			/****************************保存customer 信息*******************************/
			
			/******************************保存来店登记信息 start******************************/
			customerShoppingRecord.setCustomer(customer);
			customerShoppingRecordManageImpl.save(customerShoppingRecord);
			
			/******************************保存来店登记信息 end******************************/
			
			/****************************保存customerBussi 信息*******************************/
			customerBussi.setCustomer(customer);
			
			Integer buyCarCareId = ParamUtil.getIntParam(request, "buyCarCareId", -1);
			if(buyCarCareId>0){
				BuyCarCare buyCarCare = buyCarCareManageImpl.get(buyCarCareId);
				customerBussi.setBuyCarCare(buyCarCare);
			}
			Integer buyCarTargetId = ParamUtil.getIntParam(request, "buyCarTargetId", -1);
			if(buyCarTargetId>0){
				BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(buyCarTargetId);
				customerBussi.setBuyCarTarget(buyCarTarget);
			}
			Integer buyCarTypeId = ParamUtil.getIntParam(request, "buyCarTypeId", -1);
			if(buyCarTypeId>0){
				BuyCarType buyCarType = buyCarTypeManageImpl.get(buyCarTypeId);
				customerBussi.setBuyCarType(buyCarType);
			}
			
			
			Integer buyCarBudgetId = ParamUtil.getIntParam(request, "buyCarBudgetId", -1);
			if(buyCarBudgetId>0){
				BuyCarBudget buyCarBudget = buyCarBudgetManageImpl.get(buyCarBudgetId);
				customerBussi.setBuyCarBudget(buyCarBudget);
			}
			Integer buyCarMainUseId = ParamUtil.getIntParam(request, "buyCarMainUseId", -1);
			if(buyCarMainUseId>0){
				BuyCarMainUse buyCarMainUse = buyCarMainUseManageImpl.get(buyCarMainUseId);
				customerBussi.setBuyCarMainUse(buyCarMainUse);
			}
			customerBussiManageImpl.save(customerBussi);
			
			customerLastBussi.setCustomer(customer);
			customerLastBussi.setCreateTime(new Date());
			customerLastBussiManageImpl.save(customerLastBussi);
			
			/**********************************************保存超时信息表********************************************************/
			//创建客户跟踪任务
			customerTractUtile.createCustomerToCreateTask(customer);
			
			recommendCustomer2.setCustomerStatus(RecommendCustomer.CUSTOMERSTATUSYEAS);
			recommendCustomerManageImpl.save(recommendCustomer2);
			saveAgentOperatorLog("添加推荐为客户为登记客户", "", recommendCustomer2.getDbid());
			
			//发送微信通知信息
			String message="登记客户通知，销售顾问【"+currentUser.getRealName()+"】，已把您推荐客户的【"+recommendCustomer2.getName()+"】转为登记客户";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, message, recommendCustomer2.getMember());
		}catch (Exception e) {
			renderErrorMsg(e, "保存数据失败！");
			e.printStackTrace();
			log.error(e);
			return ;
		}
		renderMsg("/recommendCustomer/queryCompanySalerList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：保存操作日志
	 * @param type
	 * @param note
	 * @param finCustomerId
	 */
	private void saveAgentOperatorLog(String type,String note,Integer customerId){
		User currentUser = SecurityUserHolder.getCurrentUser();
		AgentOperatorLog agentOperatorLog=new AgentOperatorLog();
		agentOperatorLog.setCustomerId(customerId);
		agentOperatorLog.setNote(note);
		agentOperatorLog.setOperateDate(new Date());
		agentOperatorLog.setOperator(currentUser.getRealName());
		agentOperatorLog.setType(type);
		agentOperatorLogManageImpl.save(agentOperatorLog);
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
		try {
			if(null!=dbids&&dbids.length>0){
				for (Integer dbid : dbids) {
					recommendCustomerManageImpl.deleteById(dbid);
				}
			}else {
				renderErrorMsg(new Throwable("未选中数据！"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/recommendCustomer/queryInvalidList"+query, "删除数据成功！");
		return ;
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
	 * 功能描述：下载页面跳转
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String exportExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		//type=1，厂商导出；type=2，大区导出；type=3，经销商导出
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		try {
			//省
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "exportExcel";
	}
	/**
	 * 功能描述：下载
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void download() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = this.getResponse();
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String agentName = request.getParameter("agentName");
		String compnayName = request.getParameter("compnayName");
		Integer tradeStatus = ParamUtil.getIntParam(request, "tradeStatus", -11);
		Integer distStatus = ParamUtil.getIntParam(request, "distStatus", -1);
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String fileName="";
		try{
			if(null!=startTime&&startTime.trim().length()>0){
				fileName=fileName+""+startTime;
			}
			
			if(null!=endTime&&endTime.trim().length()>0){
				fileName=fileName+"至"+endTime;
			}else{
				fileName=fileName+"至"+DateUtil.format(new Date());
			}
			String sql="";
			List params=new ArrayList();
			if(type==1){
				//厂商导出数据
				sql="select * from agent_recommendcustomer where 1=1  ";
				if(approvalStatus>0){
					sql=sql+" and approvalStatus=? ";
					params.add(approvalStatus);
				}
			}
			if(null!=compnayName&&compnayName.trim().length()>0){
				sql=sql+" and compnayName like ? ";
				params.add("%"+compnayName+"%");
			}
			if(proviceId>0){
				sql=sql+" and province=? ";
				Area area = areaManageImpl.get(proviceId);
				params.add(area.getName());
			}
			if(cityId>0){
				sql=sql+" and city=? ";
				Area area = areaManageImpl.get(cityId);
				params.add(area.getName());
			}
			if(areaId>0){
				sql=sql+" and areaStr=? ";
				Area area = areaManageImpl.get(areaId);
				params.add(area.getName());
			}
			if(tradeStatus>0){
				sql=sql+" and tradeStatus=? ";
				params.add(tradeStatus);
			}
			if(distStatus>0){
				sql=sql+" and distStatus=? ";
				params.add(distStatus);
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=agentName&&agentName.trim().length()>0){
				sql=sql+" and agentName like ? ";
				params.add("%"+agentName+"%");
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and recommendDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and recommendDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			List<RecommendCustomer> recommendCustomers = recommendCustomerManageImpl.executeSql(sql, params.toArray());
			String filePath = recommendCustomerToExcel.writeExcel(fileName, recommendCustomers,type);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return ;
	}
	
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setBuyCarTypeManageImpl(BuyCarTypeManageImpl buyCarTypeManageImpl) {
		this.buyCarTypeManageImpl = buyCarTypeManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
	}
	private Customer customer;
	private CarColorManageImpl carColorManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CustomerShoppingRecord customerShoppingRecord;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl;
	private CustomerBussi customerBussi;
	private BuyCarCareManageImpl buyCarCareManageImpl;
	private BuyCarTargetManageImpl buyCarTargetManageImpl;
	private BuyCarMainUseManageImpl buyCarMainUseManageImpl;
	private BuyCarBudgetManageImpl buyCarBudgetManageImpl;
	private CustomerBussiManageImpl customerBussiManageImpl;
	private CustomerLastBussi customerLastBussi;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public CustomerBussi getCustomerBussi() {
		return customerBussi;
	}
	public void setCustomerBussi(CustomerBussi customerBussi) {
		this.customerBussi = customerBussi;
	}
	public CustomerLastBussi getCustomerLastBussi() {
		return customerLastBussi;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	public void setCustomerShoppingRecord(
			CustomerShoppingRecord customerShoppingRecord) {
		this.customerShoppingRecord = customerShoppingRecord;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerShoppingRecordManageImpl(
			CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl) {
		this.customerShoppingRecordManageImpl = customerShoppingRecordManageImpl;
	}
	@Resource
	public void setBuyCarCareManageImpl(BuyCarCareManageImpl buyCarCareManageImpl) {
		this.buyCarCareManageImpl = buyCarCareManageImpl;
	}
	public void setBuyCarTargetManageImpl(
			BuyCarTargetManageImpl buyCarTargetManageImpl) {
		this.buyCarTargetManageImpl = buyCarTargetManageImpl;
	}
	@Resource
	public void setBuyCarMainUseManageImpl(
			BuyCarMainUseManageImpl buyCarMainUseManageImpl) {
		this.buyCarMainUseManageImpl = buyCarMainUseManageImpl;
	}
	@Resource
	public void setBuyCarBudgetManageImpl(
			BuyCarBudgetManageImpl buyCarBudgetManageImpl) {
		this.buyCarBudgetManageImpl = buyCarBudgetManageImpl;
	}
	
	public CustomerShoppingRecord getCustomerShoppingRecord() {
		return customerShoppingRecord;
	}
	@Resource
	public void setCustomerBussiManageImpl(
			CustomerBussiManageImpl customerBussiManageImpl) {
		this.customerBussiManageImpl = customerBussiManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	/**
	 * 功能描述：添加发送微信通知信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveWechatMessage(String message,Enterprise enterprise)  {
		try {
				/*if(null!=enterprise){
					//查询厂商接受通知信息人员
					List<WechatRecvier> wechatRecviers = wechatRecvierManageImpl.findBy("company.dbid", enterprise.getDbid());
					if(null!=wechatRecviers&&wechatRecviers.size()>0){
						for (WechatRecvier wechatRecvier : wechatRecviers) {
							AgentMesg agentMesg=new AgentMesg();
							agentMesg.setCreateDate(new Date());
							agentMesg.setMesg(message);
							agentMesg.setModifyDate(new Date());
							agentMesg.setOpenId(wechatRecvier.getOpenId());
							agentMesg.setRealName(wechatRecvier.getUser().getRealName());
							agentMesg.setSendNum(1);
							agentMesg.setSendStatus(AgentMesg.COMM);
							agentMesg.setUserId(wechatRecvier.getUser().getDbid());
							agentMesgManageImpl.save(agentMesg);
						}
					}
				}*/
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String reward() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer recommendCustomerId = ParamUtil.getIntParam(request, "recommendCustomerId", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerId);
			request.setAttribute("recommendCustomer", recommendCustomer);
			Member member = recommendCustomer.getMember();
			request.setAttribute("member", member);
			AgentSet agentSet=null;
			Integer enterpriseId = recommendCustomer.getEnterpriseId();
			Spread spread = member.getSpread();
			if((null!=enterpriseId&&enterpriseId>0)&&spread!=null){
				List<AgentSet> agentSets = agentSetManageImpl.find("from AgentSet where enterpriseId=? AND spreadId=? ", new Object[]{enterpriseId,spread.getDbid()});
				if(null!=agentSets&&agentSets.size()>0){
					agentSet = agentSets.get(0);
				}
			}
			if(agentSet==null){
				agentSet=agentSetManageImpl.get(1);
			}
			request.setAttribute("spread", spread);
			
			
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			
			
			
			WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
			WeixinGzuserinfo parent = weixinGzuserinfo.getParent();
			if(null!=parent){
				Member member2 = parent.getMember();
				request.setAttribute("parentMember", member2);
			}
			Integer agentSuccessNum = member.getAgentSuccessNum();
			if(null!=agentSet){
				Integer agentRewardModel = agentSet.getAgentRewardModel();
				if(agentRewardModel==2){
					List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.executeSql("SELECT * FROM agent_agentsetlevel WHERE beginNum<"+agentSuccessNum+" AND endNum>="+agentSuccessNum+" AND agentSetId="+agentSet.getDbid(),null);
					if(null!=agentSetLevels&&!agentSetLevels.isEmpty()){
						request.setAttribute("agentSetLevel", agentSetLevels.get(0));
					}
				}
			}
			request.setAttribute("agentSet", agentSet);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "reward";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveReward() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer recommendCustomerId = ParamUtil.getIntParam(request, "recommendCustomerId", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		String note = request.getParameter("note");
		try {
			User currentUser = SecurityUserHolder.getCurrentUser();
			//保存返利记录
			RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerId);
			AgentSet agentSet=null;
			Integer enterpriseId = recommendCustomer.getEnterpriseId();
			Member member = recommendCustomer.getMember();
			if(member==null){
				renderErrorMsg(new Throwable("发送红包失败，无会员信息"), "");
				return ;
			}
			Spread spread = member.getSpread();
			if((null!=enterpriseId&&enterpriseId>0)&&spread!=null){
				List<AgentSet> agentSets = agentSetManageImpl.find("from AgentSet where enterpriseId=? AND spreadId=? ", new Object[]{enterpriseId,spread.getDbid()});
				if(null!=agentSets&&agentSets.size()>0){
					agentSet = agentSets.get(0);
				}
			}
			if(agentSet==null){
				agentSet=agentSetManageImpl.get(1);
			}
			if(null==agentSet){
				renderErrorMsg(new Throwable("发送红包失败，未设置红包奖励信息"), "");
				return ;
			}
			//经纪人奖励
			if(null!=agentSet){
				//奖励推荐经纪人奖励状态
				Integer agentRewardStatus = agentSet.getAgentRewardStatus();
				if(agentRewardStatus==(int)AgentSet.START){
					saveRewardAgent(recommendCustomer, agentSet);
				}
				//奖励上级经纪人
				if(agentSet.getAgentRewardParentStatus()==(int)AgentSet.START){
					WeixinGzuserinfo weixinGzuserinfo = member.getWeixinGzuserinfo();
					if(null!=weixinGzuserinfo){
						WeixinGzuserinfo parent = weixinGzuserinfo.getParent();
						if(null!=parent){
							Member parentMember = parent.getMember();
							if(null!=parentMember){
								saveRewardAgentPrent(recommendCustomer,parentMember, member, agentSet);
							}
						}
					}
				}
			}
			recommendCustomer.setRewardNote(note);
			recommendCustomer.setRewardStatus(RecommendCustomer.REWARD_SENDED);
			recommendCustomer.setRewardTime(new Date());
			recommendCustomerManageImpl.save(recommendCustomer);
			saveAgentOperatorLog("推荐客成交发送奖励", "推荐客户成交发送奖励", customerId, currentUser);
			
			//推荐客户成交赠送积分
			agentSuccessSendPoint(recommendCustomer);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("奖励记录提报失败"), "");
			return ;
		}
		renderMsg("/customerPidBookingRecord/wlbCustomerManageSuccess", "奖励记录提报成功");
		return;
	}
	/**
	 * 功能描述：保存操作日志
	 * @param type
	 * @param note
	 * @param finCustomerId
	 */
	public void saveAgentOperatorLog(String type,String note,Integer customerId,User currentUser){
		AgentOperatorLog agentOperatorLog=new AgentOperatorLog();
		agentOperatorLog.setCustomerId(customerId);
		agentOperatorLog.setNote(note);
		agentOperatorLog.setOperateDate(new Date());
		agentOperatorLog.setOperator(currentUser.getRealName());
		agentOperatorLog.setType(type);
		agentOperatorLogManageImpl.save(agentOperatorLog);
	}
	/**
	 * 功能描述：记录经纪人奖励
	 * 参数描述：
	 * 逻辑描述：
	 */
	private void saveRewardAgent(RecommendCustomer recommendCustomer,AgentSet agentSet) {
		HttpServletRequest request = getRequest();
		try {
			Member member = recommendCustomer.getMember();
			Float agentRewardNum =Float.valueOf(0);
			Integer agentRewardModel = agentSet.getAgentRewardModel();
			if(agentRewardModel==1){
				agentRewardNum=Float.valueOf(agentSet.getAgentRewardNum());
			}else{
				Integer agentSuccessNum = member.getAgentSuccessNum();
				if(null==agentRewardNum){
					agentSuccessNum=0;
				}
				List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.executeSql("SELECT * FROM agent_agentsetlevel WHERE beginNum<"+agentSuccessNum+" AND endNum>="+agentSuccessNum+" AND agentSetId="+agentSet.getDbid(),null);
				if(null!=agentSetLevels&&!agentSetLevels.isEmpty()){
					AgentSetLevel agentSetLevel = agentSetLevels.get(0);
					agentRewardNum = agentSetLevel.getRewardMoney();
				}
			}
			//更新推荐人客户成功数
			Reward reward=new Reward();
			reward.setCreateTime(new Date());
			reward.setCreator("系统管理员");
			reward.setMember(member);
			StringBuilder builder=new StringBuilder();
			builder.append("会员："+member.getName()+"");
			builder.append("推荐【"+member.getName()+"】客户获得奖励，奖励金额："+agentRewardNum);
			reward.setRewardFrom("客户成交奖励");
			reward.setNote(recommendCustomer.getName()+"客户成交奖励");
			reward.setRewardMoney(agentRewardNum);
			reward.setNote(builder.toString());
			reward.setRewardType(Reward.AGENT);
			reward.setEnterpriseId(recommendCustomer.getEnterpriseId());
			reward.setRecommendCustomerId(recommendCustomer.getDbid());
			rewardManageImpl.save(reward);
			
			
			//会员返利总额
			Integer agentSuccessNum = member.getAgentSuccessNum();
			if(null!=agentSuccessNum&&agentSuccessNum>0){
				agentSuccessNum=agentSuccessNum+1;
			}else{
				agentSuccessNum=1;
			}
			//保存赠送积分记录
			Float point = recommendCustomer.getPoint();
			if(null!=point&&point>0){
				Integer pointNum = member.getAgentPointNum();
				pointNum=pointNum+point.intValue();
				member.setAgentPointNum(pointNum);
			}
			Float turnBackMoney = member.getAgentMoney();
			turnBackMoney=turnBackMoney+agentRewardNum;
			member.setAgentMoney(turnBackMoney);
			member.setAgentSuccessNum(agentSuccessNum);
			memberManageImpl.save(member);
			
			//保存赠送积分记录
			if(null!=point&&point>0){
				PointRecord pointRecord=new PointRecord();
				pointRecord.setMember(member);
				pointRecord.setCreateTime(new Date());
				pointRecord.setCreator(customer.getUser().getRealName());
				pointRecord.setNote(recommendCustomer.getName()+"客户成交返积分");
				pointRecord.setNum(point.intValue());
				pointRecord.setPointFrom(recommendCustomer.getName()+"推荐客户成交赠送积分");
				pointRecord.setRecommendCustomerId(recommendCustomer.getDbid());
				if(null!=customer.getEnterprise()){
					pointRecord.setEnterpriseId(customer.getEnterprise().getDbid());
				}
				pointRecordManageImpl.save(pointRecord);
				
				memberManageImpl.updateMemberPoint(member, pointRecord);
			}
			
			//发送红包记录
			Enterprise enterprise = enterpriseManageImpl.get(member.getEnterprise().getDbid());
			String remoteAddr = request.getRemoteAddr();
			if(null!=enterprise){
				redBagManageImpl.saveRedBagAgent(member,reward, enterprise, remoteAddr);
			}
			
			String agentMessage="客户成交通知，您的推荐【"+recommendCustomer.getName()+"】已成交。奖励金额："+agentRewardNum+",请注意查收。";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, member);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	/**
	 * 功能描述：成交客户奖励上级经纪人 
	 * @param parent 上级经纪人
	 * @param child  当前经纪人
	 * @param agentSet 
	 */
	private void saveRewardAgentPrent(RecommendCustomer recommendCustomer,Member parent,Member child,AgentSet agentSet){
		HttpServletRequest request = getRequest();
		try {
			Reward reward=new Reward();
			reward.setCreateTime(new Date());
			reward.setCreator("系统管理员");
			reward.setMember(parent);
			StringBuilder builder=new StringBuilder();
			builder.append("经纪人【"+child.getName()+"】推荐客户【"+recommendCustomer.getName()+"】已成交，获得奖励奖励金额："+agentSet.getAgentRewardParentNum());
			reward.setRewardFrom("客户成交奖励");
			reward.setRewardMoney(Float.valueOf(agentSet.getAgentRewardParentNum()));
			reward.setNote(builder.toString());
			reward.setRewardType(Reward.AGENT);
			reward.setTurnBackStatus(1);
			reward.setEnterpriseId(parent.getEnterprise().getDbid());
			rewardManageImpl.save(reward);
			
			//会员返利总额
			Float turnBackMoney = parent.getAgentMoney();
			turnBackMoney=turnBackMoney+agentSet.getAgentRewardParentNum();
			parent.setAgentMoney(turnBackMoney);
			memberManageImpl.save(parent);	
			
			//发送红包记录
			Enterprise enterprise = enterpriseManageImpl.get(parent.getEnterprise().getDbid());
			String remoteAddr = request.getRemoteAddr();
			if(null!=enterprise){
				redBagManageImpl.saveRedBagAgent(parent,reward, enterprise, remoteAddr);
			}
			
			String agentMessage="客户成交通知，您的下级经纪人【"+child.getName()+"】推荐客户【"+recommendCustomer.getName()+"】已成交。奖励金额："+agentSet.getAgentRewardNum()+"，请注意查收.";
			AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, parent);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	/**
	 * 功能描述：删除返利记录
	 * @param recommendCustomer
	 */
	@SuppressWarnings("unused")
	private void deleteFanliAndPoint(RecommendCustomer recommendCustomer) {
		Member member = recommendCustomer.getMember();
		Integer agentSuccessNum = member.getAgentSuccessNum();
		if(agentSuccessNum>0){
			member.setAgentSuccessNum(agentSuccessNum-1);
		}else{
			member.setAgentSuccessNum(0);
		}
		if(null!=recommendCustomer.getRewardMoney()){
			Float turnBackMoney = member.getAgentMoney();
			turnBackMoney=turnBackMoney-recommendCustomer.getRewardMoney();
			member.setAgentMoney(turnBackMoney);
		}
		//保存赠送积分记录
		Float point = recommendCustomer.getPoint();
		if(null!=point&&point>0){
			Integer pointNum = member.getAgentPointNum();
			pointNum=pointNum-point.intValue();
			member.setAgentPointNum(pointNum);
		}
		memberManageImpl.save(member);
		
		//删除返利记录
		rewardManageImpl.deleteBySql(recommendCustomer.getDbid());
		//删除积分记录
		pointRecordManageImpl.deleteBySql(recommendCustomer.getDbid());
	}
	
	/**
	 * 功能描述：推荐客户成交赠送积分通知
	 * @param member
	 */
	private void agentSuccessSendPoint(RecommendCustomer recommendCustomer){
		Member member = recommendCustomer.getMember();
		if(null==member){
			return ;
		}
		Integer enterpriseId = member.getEnterprise().getDbid();
		if(null==enterpriseId||enterpriseId<=0){
			return ;
		}
		List<MemPointrecordSet> memPointrecordSets = memPointrecordSetManageImpl.findBy("enterpriseId",enterpriseId);
		if(null==memPointrecordSets||memPointrecordSets.size()<=0){
			return ;
		}
		MemPointrecordSet memPointrecordSet = memPointrecordSets.get(0);
		Integer agentSuccessStatus = memPointrecordSet.getAgentSuccessStatus();
		//注册送积分
		if(null!=agentSuccessStatus&&agentSuccessStatus>0&&agentSuccessStatus==(int)MemPointrecordSet.START){
			Integer agentSuccessNum = memPointrecordSet.getAgentSuccessNum();
			if(null!=agentSuccessNum&&agentSuccessNum>0){
				StringBuffer buffer=new StringBuffer();
				PointRecord pointRecord=new PointRecord();
				pointRecord.setCreateTime(new Date());
				pointRecord.setCreator("系统管理员");
				pointRecord.setEnterpriseId(enterpriseId);
				pointRecord.setMember(member);
				buffer.append("推荐客户成交赠送积分，您推荐客户【"+recommendCustomer.getName()+"】已经成交，赠送："+agentSuccessNum+" 积分。");
				pointRecord.setNote(buffer.toString());
				pointRecord.setNum(agentSuccessNum);
				pointRecord.setPointFrom("推荐客户成交赠送积分");
				pointRecord.setRecommendCustomerId(recommendCustomer.getDbid());
				pointRecord.setType(2);
				pointRecordManageImpl.save(pointRecord);
				
				//更新会员积分记录
				memberManageImpl.updateMemberPoint(member, pointRecord);
				
				//发送微信消息
				String agentMessage="推荐客户成交赠送积分通知，您推荐客户【"+recommendCustomer.getName()+"】已经成交。赠送："+agentSuccessNum+" 积分，请在会员中心查看我的积分记录。";
				AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, member);
			}
		}
		//注册赠送上级积分
		Integer agentParentSuccessStatus = memPointrecordSet.getAgentParentSuccessStatus();
		if(null!=agentParentSuccessStatus&&agentParentSuccessStatus>0&&agentParentSuccessStatus==(int)MemPointrecordSet.START){
			Integer agentParentSuccessNum = memPointrecordSet.getAgentParentSuccessNum();
			if(null!=agentParentSuccessNum&&agentParentSuccessNum>0){
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
							pointRecord.setEnterpriseId(enterpriseId);
							pointRecord.setMember(member);
							buffer.append("推荐客户成交上级赠送积分，您的下级【"+member.getName()+"】,荐客户的【"+recommendCustomer.getName()+"】已经成交,赠送："+agentParentSuccessNum+" 积分。");
							pointRecord.setNote(buffer.toString());
							pointRecord.setNum(agentParentSuccessNum);
							pointRecord.setPointFrom("推荐客户成交上级赠送积分");
							pointRecord.setType(2);
							pointRecord.setRecommendCustomerId(recommendCustomer.getDbid());
							pointRecordManageImpl.save(pointRecord);
							
							//更新会员积分记录
							memberManageImpl.updateMemberPoint(parentMember, pointRecord);
							
							//发送微信消息
							String agentMessage="推荐客户成交上级赠送积分通知，您的下级【"+member.getName()+"】,荐客户的【"+recommendCustomer.getName()+"】已经成交。赠送："+agentParentSuccessNum+" 积分，请在会员中心查看我的积分记录。";
							AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, parentMember);
						}
					}
				}
			}
		}
	}
}
