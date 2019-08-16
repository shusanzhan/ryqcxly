package com.ystech.stat.customerrecord.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.mysql.fabric.xmlrpc.base.Array;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DataFormatUtil;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearChain;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearEffChain;
import com.ystech.stat.customerrecord.model.StatCustomerRecordUser;
import com.ystech.stat.customerrecord.service.StaCustomerRecordNetManageImpl;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.stat.service.CustomerInfromStaSetManageImpl;
import com.ystech.stat.service.CustomerInfromStaSetServiceImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;
@Component("statCustomerRecordNetAction")
@Scope("prototype")
public class StatCustomerRecordNetAction extends BaseController{
	private StaCustomerRecordNetManageImpl staCustomerRecordNetManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CustomerInfromStaSetServiceImpl customerInfromStaSetServiceImpl;
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;

	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}

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
	public void setStaCustomerRecordNetManageImpl(
			StaCustomerRecordNetManageImpl staCustomerRecordNetManageImpl) {
		this.staCustomerRecordNetManageImpl = staCustomerRecordNetManageImpl;
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
	public String queryNetStaMonth() throws Exception {
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = currentUser.getEnterprise();
			List<Enterprise> enterprises=null;
			if(enterprise.getDbid()>0){
				enterprises = new ArrayList<Enterprise>();
				enterprises.add(enterprise);
			}else{
				enterprises = enterpriseManageImpl.getAll();
			}
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprise", enterprise);
			
			List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetServiceImpl.queryByCustomerInfromStaSetByEntparseId(enterprise);
			request.setAttribute("customerInfromStaSets", customerInfromStaSets);
			
			request.setAttribute("enterprises", enterprises);
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			
			//每日数据汇总
			List<StaDateNum> staCustomerRecordDateNums = staCustomerRecordNetManageImpl.queryStaCustomerRecordDateNums(beginDate, endDate, enterprise,type, dateType,0,null);
			//每日网销平台明细
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDate(staCustomerRecordDateNums, enterprise,type, dateType,0);
			request.setAttribute("mapCustomerInfromStaSets", mapCustomerInfromStaSets);
			//网销平台数据汇总
			List<CustomerInfromStaSet> customerInfromStaSetTotals = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDateToatal(beginDate, endDate, enterprise,type, dateType,0);
			request.setAttribute("customerInfromStaSetTotals", customerInfromStaSetTotals);
			String[] dayByDayAll = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayAll", dayByDayAll[0]);
			request.setAttribute("dayByDayNumAll", dayByDayAll[1]);
			//有效线索有效
			int effectvie=1;
			List<StaDateNum> effStaCustomerRecordDateNums = staCustomerRecordNetManageImpl.queryStaCustomerRecordDateNums(beginDate, endDate, enterprise,type, dateType,effectvie,null);
			request.setAttribute("effStaCustomerRecordDateNums", effStaCustomerRecordDateNums);
			//每日网销平台明细
			Map<StaDateNum, List<CustomerInfromStaSet>> mapEffCustomerInfromStaSets = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDate(effStaCustomerRecordDateNums, enterprise,type, dateType,effectvie);
			request.setAttribute("mapEffCustomerInfromStaSets", mapEffCustomerInfromStaSets);
			//网销平台数据汇总
			List<CustomerInfromStaSet> effCustomerInfromStaSetTotals = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDateToatal(beginDate, endDate, enterprise,type, dateType,effectvie);
			request.setAttribute("effCustomerInfromStaSetTotals", effCustomerInfromStaSetTotals);
			String[] dayByDayDataEff = dayByDayData(request, customerInfromStaSets, mapEffCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayEff", dayByDayDataEff[0]);
			request.setAttribute("dayByDayNumEff", dayByDayDataEff[1]);
			
			//网销平台有效率线性统计
			Map<StaDateNum, List<CustomerInfromStaSet>> mapEff = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetEffByDate(effStaCustomerRecordDateNums, enterprise, type, dateType);
			dayByDayDataEff(request, customerInfromStaSets, mapEff, dateType);
			
			//网线
			List<CustomerInfromStaSet> customerInfromStaSetsSummarys = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetSummary(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapCustomerInfromCars= staCustomerRecordNetManageImpl.queryCustomerInfromStaSetCarSeriy(customerInfromStaSetsSummarys, beginDate, endDate,type, enterprise, dateType);
			request.setAttribute("mapCustomerInfromCars", mapCustomerInfromCars);
			
			//网销每日关注车型
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriy(effStaCustomerRecordDateNums, type, enterprise,dateType,null);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			List<CarSerCount> carSerCountTotals = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise,1,null);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			//统计数据
			String[] receptionCarSerData = receptionCarSerData(carSerCountTotals,3);
			request.setAttribute("receptionCarSerTitle", receptionCarSerData[0]);
			request.setAttribute("receptionCarSerData", receptionCarSerData[1]);
			//统计销售顾问接待客户以及对应车型
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerRecordNetManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsers", mapUsers);
			
			StatCustomerRecordUser customerRecordUserTotal = staCustomerRecordNetManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);

			//线索汇总同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerRecordInfromYearByYearChainTotals = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearChain(start, type, enterprise, dateType, 0);
			request.setAttribute("customerRecordInfromYearByYearChainTotals", customerRecordInfromYearByYearChainTotals);
			if(!customerRecordInfromYearByYearChainTotals.isEmpty()){
				request.setAttribute("fristCustomerRecordInfromYearByYearChain",customerRecordInfromYearByYearChainTotals.get(0));
			}
			//线索有效数据同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerRecordInfromYearByYearChains = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearChain(start, type, enterprise, dateType, 2);
			request.setAttribute("customerRecordInfromYearByYearChains", customerRecordInfromYearByYearChains);
			//线索有效率比环比数据
			List<StaCustomerRecordInfromYearByYearEffChain> sustomerRecordInfromYearByYearEffChains = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearEffChain(start, type, enterprise, dateType);
			request.setAttribute("sustomerRecordInfromYearByYearEffChains", sustomerRecordInfromYearByYearEffChains);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "netStaMonth";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryNetStaYear() throws Exception {
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
			
			List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetServiceImpl.queryByCustomerInfromStaSetByEntparseId(enterprise);
			request.setAttribute("customerInfromStaSets", customerInfromStaSets);
			
			request.setAttribute("enterprises", enterprises);
			String beginDate=DateUtil.formatPatten(start, "yyyy-MM");
			String endDate=DateUtil.formatPatten(end,"yyyy-MM");
			
			//每日数据汇总
			List<StaDateNum> staCustomerRecordDateNums = staCustomerRecordNetManageImpl.queryStaCustomerRecordDateNums(beginDate, endDate, enterprise,type, dateType,0,null);
			//每日网销平台明细
			Map<StaDateNum, List<CustomerInfromStaSet>> mapCustomerInfromStaSets = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDate(staCustomerRecordDateNums, enterprise,type, dateType,0);
			request.setAttribute("mapCustomerInfromStaSets", mapCustomerInfromStaSets);
			//网销平台数据汇总
			List<CustomerInfromStaSet> customerInfromStaSetTotals = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDateToatal(beginDate, endDate, enterprise,type, dateType,0);
			request.setAttribute("customerInfromStaSetTotals", customerInfromStaSetTotals);
			String[] dayByDayAll = dayByDayData(request, customerInfromStaSets, mapCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayAll", dayByDayAll[0]);
			request.setAttribute("dayByDayNumAll", dayByDayAll[1]);
			//有效线索有效
			int effectvie=1;
			//每日数据汇总
			List<StaDateNum> effStaCustomerRecordDateNums = staCustomerRecordNetManageImpl.queryStaCustomerRecordDateNums(beginDate, endDate, enterprise,type, dateType,effectvie,null);
			request.setAttribute("effStaCustomerRecordDateNums", effStaCustomerRecordDateNums);
			//每日网销平台明细
			Map<StaDateNum, List<CustomerInfromStaSet>> mapEffCustomerInfromStaSets = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDate(effStaCustomerRecordDateNums, enterprise,type, dateType,effectvie);
			request.setAttribute("mapEffCustomerInfromStaSets", mapEffCustomerInfromStaSets);
			
			//网销平台数据汇总
			List<CustomerInfromStaSet> effCustomerInfromStaSetTotals = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetByDateToatal(beginDate, endDate, enterprise,type, dateType,effectvie);
			request.setAttribute("effCustomerInfromStaSetTotals", effCustomerInfromStaSetTotals);
			String[] dayByDayDataEff = dayByDayData(request, customerInfromStaSets, mapEffCustomerInfromStaSets, dateType);
			request.setAttribute("dayByDayEff", dayByDayDataEff[0]);
			request.setAttribute("dayByDayNumEff", dayByDayDataEff[1]);
			
			//网线
			List<CustomerInfromStaSet> customerInfromStaSetsSummarys = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetSummary(beginDate, endDate, enterprise, dateType,type);
			Map<CustomerInfromStaSet, List<CarSerCount>> mapCustomerInfromCars= staCustomerRecordNetManageImpl.queryCustomerInfromStaSetCarSeriy(customerInfromStaSetsSummarys, beginDate, endDate,type, enterprise, dateType);
			request.setAttribute("mapCustomerInfromCars", mapCustomerInfromCars);
			//网销平台有效率线性统计
			Map<StaDateNum, List<CustomerInfromStaSet>> mapEff = staCustomerRecordNetManageImpl.queryCustomerInfromStaSetEffByDate(effStaCustomerRecordDateNums, enterprise, type, dateType);
			dayByDayDataEff(request, customerInfromStaSets, mapEff, dateType);
			
			//网销每日关注车型
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriy(effStaCustomerRecordDateNums, type, enterprise,dateType,null);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			List<CarSerCount> carSerCountTotals = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise,dateType,null);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			//车型趋势图
			dayByDayDataCarLine(request, carSeriys, mapCarSerCount);
			//统计数据
			String[] receptionCarSerData = receptionCarSerData(carSerCountTotals,3);
			request.setAttribute("receptionCarSerTitle", receptionCarSerData[0]);
			request.setAttribute("receptionCarSerData", receptionCarSerData[1]);
			//统计销售顾问接待客户以及对应车型
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerRecordNetManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsers", mapUsers);
			
			StatCustomerRecordUser customerRecordUserTotal = staCustomerRecordNetManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);
			
			//线索汇总同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerRecordInfromYearByYearChainTotals = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearChain(start, type, enterprise, dateType, 0);
			request.setAttribute("customerRecordInfromYearByYearChainTotals", customerRecordInfromYearByYearChainTotals);
			if(!customerRecordInfromYearByYearChainTotals.isEmpty()){
				request.setAttribute("fristCustomerRecordInfromYearByYearChain",customerRecordInfromYearByYearChainTotals.get(0));
			}
			//线索有效数据同比环比数据
			List<StaCustomerRecordInfromYearByYearChain> customerRecordInfromYearByYearChains = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearChain(start, type, enterprise, dateType, 2);
			request.setAttribute("customerRecordInfromYearByYearChains", customerRecordInfromYearByYearChains);
			//线索有效率比环比数据
			List<StaCustomerRecordInfromYearByYearEffChain> sustomerRecordInfromYearByYearEffChains = staCustomerRecordNetManageImpl.queryCustomerRecordInfromYearByYearEffChain(start, type, enterprise, dateType);
			request.setAttribute("sustomerRecordInfromYearByYearEffChains", sustomerRecordInfromYearByYearEffChains);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "netStaYear";
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
	/**
	 * 功能描述：车型柱状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] receptionCarSerData(List<CarSerCount> carSerCountTotals, Integer type) {
		StringBuffer titleBuf=new StringBuffer();
		StringBuffer dataBuf=new StringBuffer();
		dataBuf.append("[{");
		if(type==3){
			dataBuf.append("name:'网销关注车型',");
		}
		dataBuf.append("data:[");
		int i=0;
		int size = carSerCountTotals.size();
		for (CarSerCount carSerCount : carSerCountTotals) {
			i++;
			if(i==size){
				titleBuf.append("'"+carSerCount.getName()+"'");
				dataBuf.append(carSerCount.getCountNum());
			}else{
				titleBuf.append("'"+carSerCount.getName()+"',");
				dataBuf.append(carSerCount.getCountNum()+",");
			}
		}
		dataBuf.append("]");
		dataBuf.append("}]");
		return new String[]{titleBuf.toString(),dataBuf.toString()};
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
			}
			
			int effectvie=1;
			List<StaDateNum> effStaCustomerRecordDateNums = staCustomerRecordNetManageImpl.queryStaCustomerRecordDateNums(beginDate, endDate, enterprise,type, dateType,effectvie,customerInfromIds);
			request.setAttribute("effStaCustomerRecordDateNums", effStaCustomerRecordDateNums);
			//每日有效关注车型统计数据
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriy(effStaCustomerRecordDateNums, type, enterprise,dateType,customerInfromIds);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			List<CarSerCount> carSerCountTotals = staCustomerRecordNetManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise,dateType,customerInfromIds);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			//合计数据
			StringBuffer totalBuff=new StringBuffer();
			totalBuff.append("<tr class='totalTr'>");
			totalBuff.append("	<td colspan=\"2\">合计</td>");
			int countNum=0;
			for (CarSerCount  carSerCount: carSerCountTotals) {
				countNum=carSerCount.getCountNum()+countNum;
				totalBuff.append("<td>"+carSerCount.getCountNum()+"</td>");
			}
			totalBuff.append("<td>"+countNum+"</td>");	
			totalBuff.append("</tr>");
			totalBuff.append("<tr class='totalTr'>");
			totalBuff.append("	<td colspan=\"2\">占比</td>");
			for (CarSerCount  carSerCount: carSerCountTotals) {
				if(countNum>0){
					double a=((double)((double)carSerCount.getCountNum()/(double)countNum))*100;
					System.out.println(a);
					totalBuff.append("	<td>"+DataFormatUtil.formatDouble(a)+"%</td>");
				}else{
					totalBuff.append("	<td>0.0</td>");
				}
			}
				totalBuff.append("<td>"+(countNum==0?"0.0":"100%")+"</td>");
			totalBuff.append("</tr>");
			
			
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
			if(size>15){
				buffer.append(totalBuff.toString());
			}
			int j=1;
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
				buffer.append(totalBuff.toString());
			}
			buffer.append("</table>");
			
			String[] receptionCarSerData = receptionCarSerData(carSerCountTotals,3);
			if(dateType==1){
				renderText(buffer.toString()+"|"+receptionCarSerData[0].replaceAll("'","")+"|"+receptionCarSerData[1]);
			}else{
				String dayByDayDataCarLine = dayByDayDataCarLine(request, carSeriys, mapCarSerCount);
				renderText(buffer.toString()+"|"+receptionCarSerData[0].replaceAll("'","")+"|"+receptionCarSerData[1]+"|"+dayByDayDataCarLine.toString());
			}
			return ;
		} catch (Exception e) {
			e.printStackTrace();
			renderText("error");
			return ;
		}
	}
}
