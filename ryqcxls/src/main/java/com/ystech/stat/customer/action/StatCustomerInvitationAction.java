package com.ystech.stat.customer.action;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DataFormatUtil;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.stat.customer.service.StaCustomerInvationManageImpl;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearChain;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearEffChain;
import com.ystech.stat.customerrecord.model.StatCustomerRecordUser;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.stat.service.CustomerInfromStaSetManageImpl;
import com.ystech.stat.service.CustomerInfromStaSetServiceImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;
/**
 * 功能描述：统计网销邀约到店率
 * @author Administrator
 *
 */
@Component("statCustomerInvitationAction")
@Scope("prototype")
public class StatCustomerInvitationAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	private CustomerInfromStaSetServiceImpl customerInfromStaSetServiceImpl;
	private StaCustomerInvationManageImpl staCustomerInvationManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCustomerInfromStaSetServiceImpl(
			CustomerInfromStaSetServiceImpl customerInfromStaSetServiceImpl) {
		this.customerInfromStaSetServiceImpl = customerInfromStaSetServiceImpl;
	}
	@Resource
	public void setStaCustomerInvationManageImpl(
			StaCustomerInvationManageImpl staCustomerInvationManageImpl) {
		this.staCustomerInvationManageImpl = staCustomerInvationManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setCustomerInfromStaSetManageImpl(
			CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl) {
		this.customerInfromStaSetManageImpl = customerInfromStaSetManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryInvitationList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=1;
		//网销数据
		int type=3;
		int userBussiType=2;
		try {
			
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.string2Date(endTime);
			}else{
				end=new Date();
			}
			String enterpriseIds="";
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				enterpriseIds=currentUser.getCompnayIds();
			}else{
				enterpriseIds=enterpriseIds+currentUser.getEnterprise().getDbid()+"";
			}
			List<Enterprise> enterprises=null;
			if(null!=enterpriseIds){
				enterprises = enterpriseManageImpl.executeSql("select * from sys_Enterprise where dbid in("+enterpriseIds+")", null);
			}else{
				enterprises = enterpriseManageImpl.getAll();
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			
			List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetServiceImpl.queryByCustomerInfromStaSetByEntparseId(enterprise);
			request.setAttribute("customerInfromStaSets", customerInfromStaSets);
			
			String customerInfromIds = customerInfromStaSetManageImpl.queryByCustomerInfromIdsByEntparseId(enterprise);
			
			//获取每日网销潜客数据
			List<StaDateNum> staDateNums = staCustomerInvationManageImpl.queryCustomerDateNums(beginDate, endDate, enterprise, type, dateType, null);
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerByDate(staDateNums, enterprise, type, dateType);
			request.setAttribute("mapCustomerInfromStaSets", mapCustomerInfromStaSets);
			//获取网销渠道总数据，在表单下方做总数据
			List<CustomerInfromStaSet> customerInfromStaSetTotals = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerByDateToatal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("customerInfromStaSetTotals", customerInfromStaSetTotals);
			String[] dayByDayAll = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayAll", dayByDayAll[0]);
			request.setAttribute("dayByDayNumAll", dayByDayAll[1]);
			
			//获取网销每日各网销平台邀约到店客户
			List<StaDateNum> staInvitationDateNums = staCustomerInvationManageImpl.queryCustomerInvitationDateNums(beginDate, endDate, enterprise, type, dateType,null);
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSetCustomerInvitations = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationByDate(staInvitationDateNums, enterprise, type, dateType);
			request.setAttribute("mapCustomerInfromStaSetCustomerInvitations",mapCustomerInfromStaSetCustomerInvitations);
			//获取网销时间段各网销平台邀约到店客户汇总
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationTotals = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationByDateToatal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("customerInfromStaSetCustomerInvitationTotals", customerInfromStaSetCustomerInvitationTotals);
			String[] dayByDayDataEff = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSetCustomerInvitations, dateType);
			request.setAttribute("dayByDayEff", dayByDayDataEff[0]);
			request.setAttribute("dayByDayNumEff", dayByDayDataEff[1]);
			
			
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//当月潜客统计、当月潜客邀约到店客户
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationSummarys = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationSummary(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapCarSerCounts = staCustomerInvationManageImpl.queryCustomerInfromStaSetCarSeriy(customerInfromStaSetCustomerInvitationSummarys, beginDate, endDate, type, enterprise, dateType);
			request.setAttribute("mapCarSerCounts", mapCarSerCounts);
			List<CarSerCount> carSerCountTotals = staCustomerInvationManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise, dateType, customerInfromIds);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			String[] pieCustomerInfromStaSet = pieCustomerInfromStaSet(customerInfromStaSetCustomerInvitationSummarys);
			request.setAttribute("pieCustomerInfromStaSet", pieCustomerInfromStaSet[0]);
			request.setAttribute("pieCustomerInfromComeShopStaSet", pieCustomerInfromStaSet[1]);
			
			//总潜客邀约率统计
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationSummaryAlls = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationSummaryAll(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapInvitationSummaryAll = staCustomerInvationManageImpl.queryCustomerInfromStaSetCarSeriyInvitationAll(customerInfromStaSetCustomerInvitationSummaryAlls, beginDate, endDate, type, enterprise, dateType);
			request.setAttribute("mapInvitationSummaryAll", mapInvitationSummaryAll);
			List<CarSerCount> carSerCountInvitationSummaryAllTotals = staCustomerInvationManageImpl.findCarSeriyInvitationSummaryAllTotal(beginDate, endDate, type, enterprise, dateType, customerInfromIds);
			request.setAttribute("carSerCountInvitationSummaryAllTotals", carSerCountInvitationSummaryAllTotals);
			String[] pieCustomerInfromStaSetCustomerInvitationSummaryAlls = pieCustomerInfromStaSet(customerInfromStaSetCustomerInvitationSummaryAlls);
			request.setAttribute("pieCustomerInfromStaSetAll", pieCustomerInfromStaSetCustomerInvitationSummaryAlls[0]);
			request.setAttribute("pieCustomerInfromComeShopStaSetAll", pieCustomerInfromStaSetCustomerInvitationSummaryAlls[1]);
			
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerInvationManageImpl.findCustomerInvitationCarSeriy(staInvitationDateNums, type, enterprise, dateType, null, -1);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			//销售顾问当月潜客邀约到店统计
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerInvationManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerInvationManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsers", mapUsers);
			String[] pieUserMonthStaSet = pieUserSta(statCustomerRecordUsers);
			request.setAttribute("pieUserMonth", pieUserMonthStaSet[0]);
			request.setAttribute("pieUserMonthComeShop", pieUserMonthStaSet[1]);
			//销售顾问当月潜客邀约到店汇总统计
			StatCustomerRecordUser customerRecordUserTotal = staCustomerInvationManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);
			//销售顾问总潜客邀约到店统计
			List<StatCustomerRecordUser> statCustomerRecordUsersAll = staCustomerInvationManageImpl.findCustomerRecordUserAll(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsersAll = staCustomerInvationManageImpl.findCustomerRecordCarSeriyByUserIdAll(statCustomerRecordUsersAll, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsersAll", mapUsersAll);
			String[] pieUserMonthAll = pieUserSta(statCustomerRecordUsersAll);
			request.setAttribute("pieUserMonthAll", pieUserMonthAll[0]);
			request.setAttribute("pieUserMonthAllComeShop", pieUserMonthAll[1]);
			//销售顾问当月潜客邀约到店汇总统计
			StatCustomerRecordUser customerRecordUserTotalAll = staCustomerInvationManageImpl.findCustomerRecordUserTotalAll(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotalAll", customerRecordUserTotalAll);
			int coplexDateType=1,comeShopStatus=1;
			//网线潜客月汇总同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerShopInfromYearByYearChainTotals = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopInfromYearByYearChainTotals", customerShopInfromYearByYearChainTotals);
			if(!customerShopInfromYearByYearChainTotals.isEmpty()){
				request.setAttribute("fristCustomerShopYearByYearChain",customerShopInfromYearByYearChainTotals.get(0));
			}
			//网线潜客月邀约到店汇总同比环比数据
			comeShopStatus=2;
			List<StaCustomerRecordInfromYearByYearChain> customerShopInfromYearByYearMonthChains = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopInfromYearByYearMonthChains", customerShopInfromYearByYearMonthChains);
			//网线潜客月邀约到店汇总同比环比数据
			coplexDateType=2;
			List<StaCustomerRecordInfromYearByYearChain> customerShopeInfromYearByYearMonthAllChains = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopeInfromYearByYearMonthAllChains", customerShopeInfromYearByYearMonthAllChains);
			
			//线索有效率比环比数据
			List<StaCustomerRecordInfromYearByYearEffChain> sustomerRecordInfromYearByYearEffChains = staCustomerInvationManageImpl.queryCustomerRecordInfromYearByYearEffChain(start, type, enterprise, dateType,1);
			request.setAttribute("sustomerRecordInfromYearByYearEffChains", sustomerRecordInfromYearByYearEffChains);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("error", "系统发生异常，异常内容"+e.getMessage());
			return "error";
		}
		return "invitationList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryInvitationYearList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=2;
		//网销数据
		int type=3;
		int userBussiType=2;
		try {
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.stringDatePatten(startTime, "yyyy-MM");
			}else{
				start=DateUtil.stringDatePatten(DateUtil.format(DateUtil.startYear(new Date())),"yyyy-MM");
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.stringDatePatten(endTime, "yyyy-MM");
			}else{
				end=DateUtil.stringDatePatten(DateUtil.getNowMonth(), "yyyy-MM");
			}
			String enterpriseIds="";
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				enterpriseIds=currentUser.getCompnayIds();
			}else{
				enterpriseIds=enterpriseIds+currentUser.getEnterprise().getDbid()+"";
			}
			List<Enterprise> enterprises=null;
			if(null!=enterpriseIds){
				enterprises = enterpriseManageImpl.executeSql("select * from sys_Enterprise where dbid in("+enterpriseIds+")", null);
			}else{
				enterprises = enterpriseManageImpl.getAll();
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			String beginDate=DateUtil.formatPatten(start, "yyyy-MM");
			String endDate=DateUtil.formatPatten(end,"yyyy-MM");
			
			List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetServiceImpl.queryByCustomerInfromStaSetByEntparseId(enterprise);
			request.setAttribute("customerInfromStaSets", customerInfromStaSets);
			
			String customerInfromIds = customerInfromStaSetManageImpl.queryByCustomerInfromIdsByEntparseId(enterprise);
			
			//获取每日网销潜客数据
			List<StaDateNum> staDateNums = staCustomerInvationManageImpl.queryCustomerDateNums(beginDate, endDate, enterprise, type, dateType, null);
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerByDate(staDateNums, enterprise, type, dateType);
			request.setAttribute("mapCustomerInfromStaSets", mapCustomerInfromStaSets);
			//获取网销渠道总数据，在表单下方做总数据
			List<CustomerInfromStaSet> customerInfromStaSetTotals = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerByDateToatal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("customerInfromStaSetTotals", customerInfromStaSetTotals);
			String[] dayByDayAll = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayAll", dayByDayAll[0]);
			request.setAttribute("dayByDayNumAll", dayByDayAll[1]);
			
			//获取网销每日各网销平台邀约到店客户
			List<StaDateNum> staInvitationDateNums = staCustomerInvationManageImpl.queryCustomerInvitationDateNums(beginDate, endDate, enterprise, type, dateType,null);
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSetCustomerInvitations = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationByDate(staInvitationDateNums, enterprise, type, dateType);
			request.setAttribute("mapCustomerInfromStaSetCustomerInvitations",mapCustomerInfromStaSetCustomerInvitations);
			//获取网销时间段各网销平台邀约到店客户汇总
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationTotals = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationByDateToatal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("customerInfromStaSetCustomerInvitationTotals", customerInfromStaSetCustomerInvitationTotals);
			String[] dayByDayDataEff = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSetCustomerInvitations, dateType);
			request.setAttribute("dayByDayEff", dayByDayDataEff[0]);
			request.setAttribute("dayByDayNumEff", dayByDayDataEff[1]);
			
			
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//当月潜客统计、当月潜客邀约到店客户
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationSummarys = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationSummary(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapCarSerCounts = staCustomerInvationManageImpl.queryCustomerInfromStaSetCarSeriy(customerInfromStaSetCustomerInvitationSummarys, beginDate, endDate, type, enterprise, dateType);
			request.setAttribute("mapCarSerCounts", mapCarSerCounts);
			List<CarSerCount> carSerCountTotals = staCustomerInvationManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise, dateType, customerInfromIds);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			String[] pieCustomerInfromStaSet = pieCustomerInfromStaSet(customerInfromStaSetCustomerInvitationSummarys);
			request.setAttribute("pieCustomerInfromStaSet", pieCustomerInfromStaSet[0]);
			request.setAttribute("pieCustomerInfromComeShopStaSet", pieCustomerInfromStaSet[1]);
			
			//总潜客邀约率统计
			List<CustomerInfromStaSet> customerInfromStaSetCustomerInvitationSummaryAlls = staCustomerInvationManageImpl.queryCustomerInfromStaSetCustomerInvitationSummaryAll(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapInvitationSummaryAll = staCustomerInvationManageImpl.queryCustomerInfromStaSetCarSeriyInvitationAll(customerInfromStaSetCustomerInvitationSummaryAlls, beginDate, endDate, type, enterprise, dateType);
			request.setAttribute("mapInvitationSummaryAll", mapInvitationSummaryAll);
			List<CarSerCount> carSerCountInvitationSummaryAllTotals = staCustomerInvationManageImpl.findCarSeriyInvitationSummaryAllTotal(beginDate, endDate, type, enterprise, dateType, customerInfromIds);
			request.setAttribute("carSerCountInvitationSummaryAllTotals", carSerCountInvitationSummaryAllTotals);
			String[] pieCustomerInfromStaSetCustomerInvitationSummaryAlls = pieCustomerInfromStaSet(customerInfromStaSetCustomerInvitationSummaryAlls);
			request.setAttribute("pieCustomerInfromStaSetAll", pieCustomerInfromStaSetCustomerInvitationSummaryAlls[0]);
			request.setAttribute("pieCustomerInfromComeShopStaSetAll", pieCustomerInfromStaSetCustomerInvitationSummaryAlls[1]);
			
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerInvationManageImpl.findCustomerInvitationCarSeriy(staInvitationDateNums, type, enterprise, dateType, null, -1);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			//销售顾问当月潜客邀约到店统计
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerInvationManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerInvationManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsers", mapUsers);
			String[] pieUserMonthStaSet = pieUserSta(statCustomerRecordUsers);
			request.setAttribute("pieUserMonth", pieUserMonthStaSet[0]);
			request.setAttribute("pieUserMonthComeShop", pieUserMonthStaSet[1]);
			//销售顾问当月潜客邀约到店汇总统计
			StatCustomerRecordUser customerRecordUserTotal = staCustomerInvationManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);
			//销售顾问总潜客邀约到店统计
			List<StatCustomerRecordUser> statCustomerRecordUsersAll = staCustomerInvationManageImpl.findCustomerRecordUserAll(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsersAll = staCustomerInvationManageImpl.findCustomerRecordCarSeriyByUserIdAll(statCustomerRecordUsersAll, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsersAll", mapUsersAll);
			String[] pieUserMonthAll = pieUserSta(statCustomerRecordUsersAll);
			request.setAttribute("pieUserMonthAll", pieUserMonthAll[0]);
			request.setAttribute("pieUserMonthAllComeShop", pieUserMonthAll[1]);
			//销售顾问当月潜客邀约到店汇总统计
			StatCustomerRecordUser customerRecordUserTotalAll = staCustomerInvationManageImpl.findCustomerRecordUserTotalAll(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotalAll", customerRecordUserTotalAll);
			
			int coplexDateType=1,comeShopStatus=1;
			//网线潜客月汇总同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerShopInfromYearByYearChainTotals = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopInfromYearByYearChainTotals", customerShopInfromYearByYearChainTotals);
			if(!customerShopInfromYearByYearChainTotals.isEmpty()){
				request.setAttribute("fristCustomerShopYearByYearChain",customerShopInfromYearByYearChainTotals.get(0));
			}
			//网线潜客月邀约到店汇总同比环比数据
			comeShopStatus=2;
			List<StaCustomerRecordInfromYearByYearChain> customerShopInfromYearByYearMonthChains = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopInfromYearByYearMonthChains", customerShopInfromYearByYearMonthChains);
			//网线潜客月邀约到店汇总同比环比数据
			coplexDateType=2;
			List<StaCustomerRecordInfromYearByYearChain> customerShopeInfromYearByYearMonthAllChains = staCustomerInvationManageImpl.queryCustomerComeShopInfromYearByYearChain(start, type, enterprise, dateType,coplexDateType,comeShopStatus);
			request.setAttribute("customerShopeInfromYearByYearMonthAllChains", customerShopeInfromYearByYearMonthAllChains);
			
			//线索有效率比环比数据
			List<StaCustomerRecordInfromYearByYearEffChain> sustomerRecordInfromYearByYearEffChains = staCustomerInvationManageImpl.queryCustomerRecordInfromYearByYearEffChain(start, type, enterprise, dateType,1);
			request.setAttribute("sustomerRecordInfromYearByYearEffChains", sustomerRecordInfromYearByYearEffChains);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("error", "系统发生异常，异常内容"+e.toString());
			return "error";
		}
		return "invitationYearList";
	}
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(HttpServletRequest request,List<CustomerInfromStaSet> customerInfromStaSets,Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets,int dateType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int size = customerInfromStaSets.size();
			Set<StaDateNum> keySet = mapCustomerInfromStaSets.keySet();
			int keySize = keySet.size();
			for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
				CustomerInfrom customerInfrom = customerInfromStaSet.getCustomerInfrom();
				if(customerInfrom==null){
					continue;
				}
				bufferNum.append("{name:'"+customerInfromStaSet.getAlias()+"',data:[");
				int tempSize=1;
				Set<Entry<StaDateNum, List<CustomerInfromStaSet>>> entrySet = mapCustomerInfromStaSets.entrySet();
				for (Entry<StaDateNum, List<CustomerInfromStaSet>> entry : entrySet) {
					List<CustomerInfromStaSet> customerInfromStaSetLists = entry.getValue();
					if(null!=customerInfromStaSetLists){
						CustomerInfromStaSet temp = customerInfromStaSetLists.get(j);
						bufferNum.append(temp.getTotalNum());
						if(tempSize!=keySize){
							bufferNum.append(",");
						}
					}else{
						bufferNum.append("0");
						if(tempSize!=keySize){
							bufferNum.append(",");
						}
					}
					tempSize++;
				}
				if(j!=(size-1)){
					bufferNum.append("]},");
				}else{
					bufferNum.append("]}");
				}
				j++;
			}
			bufferNum.append("]");
			
			
			j=1;
			for (StaDateNum staCustomerRecordDateNum : keySet) {
				if(dateType==1){
					dayByDay.append(DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),"dd"));
				}
				if(dateType==2){
					dayByDay.append("'"+DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),"MM月")+"'");
				}
				if(j!=keySize){
					dayByDay.append(",");
				}
				j++;
			}
			String[] temps=new String[]{dayByDay.toString(),bufferNum.toString()};
			return temps;
	}
	/**
	 * 功能描述：每日月网销平台有效率数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void dayByDayDataEff(HttpServletRequest request,List<CustomerInfromStaSet> customerInfromStaSets,Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets,int dateType) {
		StringBuffer bufferNum=new StringBuffer();
		bufferNum.append("[");
		int j=0;
		int size = customerInfromStaSets.size();
		Set<StaDateNum> keySet = mapCustomerInfromStaSets.keySet();
		int keySize = keySet.size();
		for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
			CustomerInfrom customerInfrom = customerInfromStaSet.getCustomerInfrom();
			if(customerInfrom==null){
				continue;
			}
			bufferNum.append("{name:'"+customerInfromStaSet.getAlias()+"',data:[");
			int tempSize=1;
			Set<Entry<StaDateNum, List<CustomerInfromStaSet>>> entrySet = mapCustomerInfromStaSets.entrySet();
			for (Entry<StaDateNum, List<CustomerInfromStaSet>> entry : entrySet) {
				List<CustomerInfromStaSet> customerInfromStaSetLists = entry.getValue();
				if(null!=customerInfromStaSetLists){
					CustomerInfromStaSet temp = customerInfromStaSetLists.get(j);
					bufferNum.append(temp.getEffPer());
					if(tempSize!=keySize){
						bufferNum.append(",");
					}
				}else{
					bufferNum.append("0");
					if(tempSize!=keySize){
						bufferNum.append(",");
					}
				}
				tempSize++;
			}
			if(j!=(size-1)){
				bufferNum.append("]},");
			}else{
				bufferNum.append("]}");
			}
			j++;
		}
		bufferNum.append("]");
		request.setAttribute("customerInfromEff", bufferNum.toString());
	}
	/**
	 * 功能描述：查询网销平台数据
	 */
	public void ajaxCarCount(){
		HttpServletRequest request = getRequest();
		Integer customerInfromSetDbid = ParamUtil.getIntParam(request, "customerInfromSetDbid", -1);
		//日期类型：1、月；2、年
		Integer dateType = ParamUtil.getIntParam(request, "dateType", 1);
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		//网销数据
		int type=3;
		try {
			
			if(null!=startTime&&startTime.trim().length()>0){
				if(dateType==1){
					start = DateUtil.string2Date(startTime);
				}else{
					start = DateUtil.stringDatePatten(startTime, "yyyy-MM");
				}
			}else{
				if(dateType==1){
					start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
				}else{
					start=DateUtil.stringDatePatten(DateUtil.format(DateUtil.startYear(new Date())),"yyyy-MM");
				}
			}
			if(null!=endTime&&endTime.trim().length()>0){
				if(dateType==1){
					end=DateUtil.string2Date(endTime);
				}else{
					end=DateUtil.stringDatePatten(endTime, "yyyy-MM");
				}
			}else{
				if(dateType==1){
					end=new Date();
				}else{
					end=DateUtil.stringDatePatten(DateUtil.getNowMonth(), "yyyy-MM");
				}
			}
			String enterpriseIds="";
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				enterpriseIds=currentUser.getCompnayIds();
			}else{
				enterpriseIds=enterpriseIds+currentUser.getEnterprise().getDbid()+"";
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			String beginDate="";
			String endDate="";
			if(dateType==1){
				beginDate=DateUtil.format(start);
				endDate=DateUtil.format(end);
			}else{
				beginDate=DateUtil.formatPatten(start, "yyyy-MM");
				endDate=DateUtil.formatPatten(end,"yyyy-MM");
			}
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			
			String customerInfromIds=null;
			if(customerInfromSetDbid>0){
				CustomerInfromStaSet customerInfromStaSet = customerInfromStaSetManageImpl.get(customerInfromSetDbid);
				customerInfromIds = customerInfromStaSetManageImpl.findCustomerInfromIdsByCodeNum(enterprise.getDbid(), customerInfromStaSet.getCodeNum());
			}else{
				customerInfromIds=customerInfromStaSetManageImpl.queryByCustomerInfromIdsByEntparseId(enterprise);
			}
			
			List<StaDateNum> staInvitationDateNums = staCustomerInvationManageImpl.queryCustomerInvitationDateNums(beginDate, endDate, enterprise, type, dateType,customerInfromIds);
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerInvationManageImpl.findCustomerInvitationCarSeriy(staInvitationDateNums, type, enterprise,dateType,customerInfromIds,-1);
			
			List<CarSerCount> carSerCountTotals = staCustomerInvationManageImpl.findCarSeriyInvitationSummaryAllTotal(beginDate, endDate, type, enterprise, dateType, customerInfromIds);
			StringBuffer totalBuffer=new StringBuffer();
			totalBuffer.append("<tr class='totalTr'>");
			totalBuffer.append("	<td colspan=\"2\">合计</td>");
			int countNum=0;
			for (CarSerCount  carSerCount: carSerCountTotals) {
				countNum=carSerCount.getCountNum()+countNum;
				totalBuffer.append("<td>"+carSerCount.getCountNum()+"</td>");
			}
			totalBuffer.append("<td>"+countNum+"</td>");	
			totalBuffer.append("</tr>");
			totalBuffer.append("<tr class='totalTr'>");
			totalBuffer.append("	<td colspan=\"2\">占比</td>");
			for (CarSerCount  carSerCount: carSerCountTotals) {
				if(countNum>0){
					double a=((double)((double)carSerCount.getCountNum()/(double)countNum))*100;
					totalBuffer.append("	<td>"+DataFormatUtil.formatDouble(a)+"%</td>");
				}else{
					totalBuffer.append("	<td>0.0</td>");
				}
			}
				totalBuffer.append("<td>"+(countNum==0?"0.0":"100%")+"</td>");
			totalBuffer.append("</tr>");
			
			
			StringBuffer buffer=new StringBuffer();
			buffer.append("<table class=\"staltalbe\" style=\"width: 100%;\" cellpadding=\"0\" cellspacing=\"0\">");
			buffer.append("<thead>");
			buffer.append("<tr><td>序号</td><td>日期</td>");
			for (CarSeriy carSeriy : carSeriys) {
				buffer.append("<td>"+carSeriy.getName()+"</td>");
			}
			buffer.append("<td style=\"width: 60px;\"> 合计 </td>");
			buffer.append("</tr>");
			buffer.append("</thead>");
			Set<Entry<StaDateNum, List<CarSerCount>>> entrySet = mapCarSerCount.entrySet();
			int size = entrySet.size();
			int j=1;
			if(size>15){
				buffer.append(totalBuffer.toString());
			}
			for (Entry<StaDateNum, List<CarSerCount>> entry : entrySet) {
				StaDateNum key = entry.getKey();
				List<CarSerCount> value = entry.getValue();
				buffer.append("<tr>");
				buffer.append("<td>"+(j++)+"</td>");
				if(dateType==1){
					buffer.append("<td>"+DateUtil.formatPatten(key.getCreateDate(),"yyyy-MM-dd")+"</td>");
				}
				if(dateType==2){
					buffer.append("<td>"+DateUtil.formatPatten(key.getCreateDate(), "yyyy-MM")+"</td>");
				}
				for (CarSerCount carSerCount : value) {
					buffer.append("<td>"+carSerCount.getCountNum()+"</td>");
				}
				buffer.append("<td>"+key.getTotalNum()+"</td>");
				buffer.append("</tr>");
				
			}
			if(size<=15){
				buffer.append(totalBuffer.toString());
			}
			buffer.append("</table>");
			
			String[] receptionCarSerData = receptionCarSerData(carSerCountTotals,3);
			if(dateType==1){
				renderText(buffer.toString()+"|"+receptionCarSerData[0].replaceAll("'",""));
			}else{
				String dayByDayDataCarLine = dayByDayDataCarLine(request, carSeriys, mapCarSerCount);
				renderText(buffer.toString()+"|"+receptionCarSerData[0].replaceAll("'","")+"|"+dayByDayDataCarLine.toString());
			}
			return ;
		} catch (Exception e) {
			e.printStackTrace();
			renderText("error");
			return ;
		}
	}
	/**
	 * 功能描述：网销平台线索饼图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] pieCustomerInfromStaSet(List<CustomerInfromStaSet> customerInfromStaSets) {
		StringBuffer dataBuf=new StringBuffer();
		StringBuffer dataEffNumBuf=new StringBuffer();
		int i=0;
		int size = customerInfromStaSets.size();
		CustomerInfromStaSet maxCount=customerInfromStaSets.get(0);
		for (CustomerInfromStaSet carSerCount : customerInfromStaSets) {
			if(maxCount.getTotalNum()<carSerCount.getTotalNum()){
				maxCount=carSerCount;
			}
		}
		CustomerInfromStaSet effMaxCount=customerInfromStaSets.get(0);
		for (CustomerInfromStaSet carSerCount : customerInfromStaSets) {
			if(effMaxCount.getEffTotalNum()<carSerCount.getEffTotalNum()){
				effMaxCount=carSerCount;
			}
		}
		dataBuf.append("[");
		dataEffNumBuf.append("[");
		for (CustomerInfromStaSet carSerCount : customerInfromStaSets) {
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getAlias()+"\","
					+"y:"+carSerCount.getTotalNum());
			if(carSerCount.getAlias().equals(maxCount.getAlias())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("}");
			if(i!=size){
				dataBuf.append(",");
			}
			
			dataEffNumBuf.append("{"
					+ "name:\""+carSerCount.getAlias()+"\","
					+"y:"+carSerCount.getEffTotalNum());
			if(carSerCount.getAlias().equals(effMaxCount.getAlias())){
				dataEffNumBuf.append(",sliced: true,selected: true");
			}
			dataEffNumBuf.append("}");
			if(i!=size){
				dataEffNumBuf.append(",");
			}
		}
		dataBuf.append("]");
		dataEffNumBuf.append("]");
		return new String[]{dataBuf.toString(),dataEffNumBuf.toString()};
	}
	/**
	 * 功能描述：网销平台线索饼图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] pieUserSta(List<StatCustomerRecordUser> customerInfromStaSets) {
		StringBuffer dataBuf=new StringBuffer();
		StringBuffer datacreatorFolderNumBuf=new StringBuffer();
		int i=0;
		StatCustomerRecordUser maxCount=null;
		StatCustomerRecordUser maxCreateCount=null;
		int size = customerInfromStaSets.size();
		if(!customerInfromStaSets.isEmpty()){
			maxCount=customerInfromStaSets.get(0);
			for (StatCustomerRecordUser carSerCount : customerInfromStaSets) {
				if(maxCount.getTotalNum()<carSerCount.getTotalNum()){
					maxCount=carSerCount;
				}
			}
			maxCreateCount=customerInfromStaSets.get(0);
			for (StatCustomerRecordUser carSerCount : customerInfromStaSets) {
				if(maxCreateCount.getCreatorFolderNum()<carSerCount.getCreatorFolderNum()){
					maxCreateCount=carSerCount;
				}
			}
		}
		dataBuf.append("[");
		datacreatorFolderNumBuf.append("[");
		
		for (StatCustomerRecordUser carSerCount : customerInfromStaSets) {
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getRealName()+"\","
					+"y:"+carSerCount.getTotalNum());
			if(carSerCount.getRealName().equals(maxCount.getRealName())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("}");
			if(i!=size){
				dataBuf.append(",");
			}
			
			datacreatorFolderNumBuf.append("{"
					+ "name:\""+carSerCount.getRealName()+"\","
					+"y:"+carSerCount.getCreatorFolderNum());
			if(carSerCount.getRealName().equals(maxCreateCount.getRealName())){
				datacreatorFolderNumBuf.append(",sliced: true,selected: true");
			}
			datacreatorFolderNumBuf.append("}");
			if(i!=size){
				datacreatorFolderNumBuf.append(",");
			}
		}
		dataBuf.append("]");
		datacreatorFolderNumBuf.append("]");
		return new String[]{dataBuf.toString(),datacreatorFolderNumBuf.toString()};
	}
	/**
	 * 功能描述：车型柱状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] receptionCarSerData(List<CarSerCount> carSerCountTotals, Integer type) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = carSerCountTotals.size();
		CarSerCount maxCount=null;
		if(!carSerCountTotals.isEmpty()){
			maxCount=carSerCountTotals.get(0);
			for (CarSerCount carSerCount : carSerCountTotals) {
				if(maxCount.getCountNum()<carSerCount.getCountNum()){
					maxCount=carSerCount;
				}
			}
		}
		dataBuf.append("[");
		for (CarSerCount carSerCount : carSerCountTotals) {
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getName()+"\","
					+"y:"+carSerCount.getCountNum());
			if(carSerCount.getName().equals(maxCount.getName())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("}");
			if(i!=size){
				dataBuf.append(",");
			}
		}
		dataBuf.append("]");
		return new String[]{dataBuf.toString()};
	}
	/**
	 * 功能描述：每月车辆关注车型趋势
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String dayByDayDataCarLine(HttpServletRequest request,List<CarSeriy> carSeriys,Map<StaDateNum, List<CarSerCount>> mapCarSerCount) {
		StringBuffer bufferNum=new StringBuffer();
		bufferNum.append("[");
		int j=0;
		int size = carSeriys.size();
		Set<StaDateNum> keySet = mapCarSerCount.keySet();
		int keySize = keySet.size();
		for (CarSeriy carSeriy : carSeriys) {
			bufferNum.append("{name:'"+carSeriy.getName()+"',data:[");
			int tempSize=1;
			Set<Entry<StaDateNum, List<CarSerCount>>> entrySet = mapCarSerCount.entrySet();
			for (Entry<StaDateNum, List<CarSerCount>> entry : entrySet) {
				List<CarSerCount> carSerCounts = entry.getValue();
				if(null!=carSerCounts){
					CarSerCount carSerCount = carSerCounts.get(j);
					bufferNum.append(carSerCount.getCountNum());
					if(tempSize!=keySize){
						bufferNum.append(",");
					}
				}else{
					bufferNum.append("0");
					if(tempSize!=keySize){
						bufferNum.append(",");
					}
				}
				tempSize++;
			}
			if(j!=(size-1)){
				bufferNum.append("]},");
			}else{
				bufferNum.append("]}");
			}
			j++;
		}
		bufferNum.append("]");
		
		request.setAttribute("carLine", bufferNum.toString());
		return bufferNum.toString();
	}
}
