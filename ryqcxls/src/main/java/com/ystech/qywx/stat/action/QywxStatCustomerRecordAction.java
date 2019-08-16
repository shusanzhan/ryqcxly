package com.ystech.qywx.stat.action;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerRecordTarget;
import com.ystech.cust.service.CustomerRecordTargetManageImpl;
import com.ystech.stat.customerrecord.model.StaCustomerRecordMonth;
import com.ystech.stat.customerrecord.model.StatCustomerRecordTime;
import com.ystech.stat.customerrecord.model.StatCustomerRecordUser;
import com.ystech.stat.customerrecord.service.StaCustomerRecordRoomManageImpl;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;
@Component("qywxStatCustomerRecordAction")
@Scope("prototype")
public class QywxStatCustomerRecordAction extends BaseController{
	private StaCustomerRecordRoomManageImpl staCustomerRecordRoomManageImpl;
	private CustomerRecordTargetManageImpl customerRecordTargetManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;

	@Resource
	public void setStaCustomerRecordRoomManageImpl(
			StaCustomerRecordRoomManageImpl staCustomerRecordRoomManageImpl) {
		this.staCustomerRecordRoomManageImpl = staCustomerRecordRoomManageImpl;
	}

	@Resource
	public void setCustomerRecordTargetManageImpl(
			CustomerRecordTargetManageImpl customerRecordTargetManageImpl) {
		this.customerRecordTargetManageImpl = customerRecordTargetManageImpl;
	}

	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}

	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryReceptionStat() {
		HttpServletRequest request = getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Date start=null;
		Date end=null;
		int userBussiType=1;
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
			User currentUser =getSessionUser(); 
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
			Enterprise enterprise =currentUser.getEnterprise(); 
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprises", enterprises);
			
			request.setAttribute("enterprise", enterprise);
			
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			//查询当月数据
			List<StatCustomerRecordTime> statCustomerRecordTimes = staCustomerRecordRoomManageImpl.findCustomerRecordStatTime(beginDate, endDate, enterprise, type,1,status);
			request.setAttribute("statCustomerRecordTimes", statCustomerRecordTimes);
			dayByDayData(request, statCustomerRecordTimes,type,1);
			
			//统计合计
			StatCustomerRecordTime totalStatCustomerRecordTime = staCustomerRecordRoomManageImpl.getTotalStatCustomerRecordTime(statCustomerRecordTimes);
			request.setAttribute("totalStatCustomerRecordTime", totalStatCustomerRecordTime);
			receptionTimeData(request, totalStatCustomerRecordTime,type);
			
			//来店目的标题
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", type);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
			
			List<StaDateNum> statCustomerRecordDataNums = staCustomerRecordRoomManageImpl.getStatCustomerRecordDataNum(statCustomerRecordTimes);
			Map<StaDateNum, List<CustomerRecordTarget>> map = staCustomerRecordRoomManageImpl.findCustomerRecordTarget(statCustomerRecordDataNums,type,enterprise,1);
			request.setAttribute("map", map);
			//统计来店目的总数据
			List<CustomerRecordTarget> customerRecordTargetAlls = staCustomerRecordRoomManageImpl.findCustomerRecordTargetAll(beginDate, endDate, enterprise, type,1);
			request.setAttribute("customerRecordTargetAlls", customerRecordTargetAlls);
			//统计数据
			receptionTargetData(request, customerRecordTargetAlls,type);
			
			
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//每日有效关注车型统计数据
			List<StaDateNum> customerRecordCarSeriyTotals = staCustomerRecordRoomManageImpl.getCustomerRecordCarSeriyTotal(statCustomerRecordTimes);
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriy(customerRecordCarSeriyTotals, type, enterprise,1,null);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			
			List<CarSerCount> carSerCountTotals = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise,1,null);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			//统计数据
			receptionCarSerData(request, carSerCountTotals,type);
			
			//统计销售顾问接待客户以及对应车型
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerRecordRoomManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,1,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,1);
			request.setAttribute("mapUsers", mapUsers);
			
			StatCustomerRecordUser customerRecordUserTotal = staCustomerRecordRoomManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,1);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);
			
			//当月统计
			String dateMonth= DateUtil.formatPatten(start, "yyyy-MM");
			StaCustomerRecordMonth staCustomerRecordMonth = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(dateMonth, enterprise,1).get(0);
			request.setAttribute("dateMonth", dateMonth);
			request.setAttribute("staCustomerRecordMonth",staCustomerRecordMonth);
			//去年同期统计
			Date preYearDate = DateUtil.addYear(start, -1);
			String preYearStr= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			request.setAttribute("preYearStr", preYearStr);
			StaCustomerRecordMonth preYear = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(preYearStr, enterprise,1).get(0);
			request.setAttribute("preYear",preYear);
			
			//今年环比
			Date preMonthDate = DateUtil.addMonth(start, -1);
			String preMonthStr= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
			StaCustomerRecordMonth preMonth = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(preMonthStr, enterprise,1).get(0);
			request.setAttribute("preMonthStr", preMonthStr);
			request.setAttribute("preMonth",preMonth);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			request.setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "receptionStat";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryReceptionStatYear() {
		HttpServletRequest request = getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Date start=null;
		Date end=null;
		int dateType=2;
		int userBussiType=1;
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
			User currentUser = getSessionUser();
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
			Enterprise enterprise = currentUser.getEnterprise();
			if(enterpriseId>0){
				enterprise = enterpriseManageImpl.get(enterpriseId);
			}
			request.setAttribute("enterprises", enterprises);
			request.setAttribute("enterprise", enterprise);
			
			String beginDate=DateUtil.formatPatten(start, "yyyy-MM");
			String endDate=DateUtil.formatPatten(end,"yyyy-MM");
			//查询当月数据
			List<StatCustomerRecordTime> statCustomerRecordTimes = staCustomerRecordRoomManageImpl.findCustomerRecordStatTime(beginDate, endDate, enterprise, type,2,status);
			request.setAttribute("statCustomerRecordTimes", statCustomerRecordTimes);
			dayByDayData(request, statCustomerRecordTimes,type,2);
			
			//统计合计
			StatCustomerRecordTime totalStatCustomerRecordTime = staCustomerRecordRoomManageImpl.getTotalStatCustomerRecordTime(statCustomerRecordTimes);
			request.setAttribute("totalStatCustomerRecordTime", totalStatCustomerRecordTime);
			receptionTimeData(request, totalStatCustomerRecordTime,type);
			
			//来店目的标题
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", type);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
			
			List<StaDateNum> statCustomerRecordDataNums = staCustomerRecordRoomManageImpl.getStatCustomerRecordDataNum(statCustomerRecordTimes);
			Map<StaDateNum, List<CustomerRecordTarget>> map = staCustomerRecordRoomManageImpl.findCustomerRecordTarget(statCustomerRecordDataNums,type,enterprise,2);
			request.setAttribute("map", map);
			//统计来店目的总数据
			List<CustomerRecordTarget> customerRecordTargetAlls = staCustomerRecordRoomManageImpl.findCustomerRecordTargetAll(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordTargetAlls", customerRecordTargetAlls);
			//统计数据
			receptionTargetData(request, customerRecordTargetAlls,type);
			
			
			//来店车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			//每日有效关注车型统计数据
			List<StaDateNum> customerRecordCarSeriyTotals = staCustomerRecordRoomManageImpl.getCustomerRecordCarSeriyTotal(statCustomerRecordTimes);
			Map<StaDateNum, List<CarSerCount>> mapCarSerCount = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriy(customerRecordCarSeriyTotals, type, enterprise,dateType,null);
			request.setAttribute("mapCarSerCount", mapCarSerCount);
			//车型变化趋势
			dayByDayDataCarLine(request, carSeriys, mapCarSerCount);
			
			List<CarSerCount> carSerCountTotals = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriyTotal(beginDate, endDate, type, enterprise,dateType,null);
			request.setAttribute("carSerCountTotals", carSerCountTotals);
			//统计数据
			receptionCarSerData(request, carSerCountTotals,type);
			
			//统计销售顾问接待客户以及对应车型
			List<StatCustomerRecordUser> statCustomerRecordUsers = staCustomerRecordRoomManageImpl.findCustomerRecordUser(beginDate, endDate, enterprise, type,dateType,userBussiType);
			Map<StatCustomerRecordUser, List<CarSerCount>> mapUsers = staCustomerRecordRoomManageImpl.findCustomerRecordCarSeriyByUserId(statCustomerRecordUsers, type, enterprise, beginDate, endDate,dateType);
			request.setAttribute("mapUsers", mapUsers);
			
			StatCustomerRecordUser customerRecordUserTotal = staCustomerRecordRoomManageImpl.findCustomerRecordUserTotal(beginDate, endDate, enterprise, type,dateType);
			request.setAttribute("customerRecordUserTotal", customerRecordUserTotal);

			//前台综合统计分析数据
			String year= DateUtil.formatPatten(start, "yyyy");
			request.setAttribute("year", year);
			List<StaCustomerRecordMonth> staCustomerRecordMonths = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(year, enterprise,2);
			request.setAttribute("staCustomerRecordMonths", staCustomerRecordMonths);
			receptionMonthData(request, staCustomerRecordMonths);
			
			//当年
			String dateMonth= DateUtil.formatPatten(start, "yyyy");
			StaCustomerRecordMonth staCustomerRecordMonth = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(dateMonth, enterprise,3).get(0);
			request.setAttribute("dateMonth", dateMonth);
			request.setAttribute("staCustomerRecordMonth",staCustomerRecordMonth);
			//去年
			Date preYearDate = DateUtil.addYear(start, -1);
			String preYearStr= DateUtil.formatPatten(preYearDate, "yyyy");
			request.setAttribute("preYearStr", preYearStr);
			StaCustomerRecordMonth preYear = staCustomerRecordRoomManageImpl.queryStaStaCustomerRecordMonths(preYearStr, enterprise,3).get(0);
			request.setAttribute("preYear",preYear);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			request.setAttribute("type", type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "receptionStatYear";
	}
	
	
	/**
	 * 功能描述：每日数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void dayByDayData(HttpServletRequest request,List<StatCustomerRecordTime> statCustomerRecordTimes,int type,int dateType) {
		if(null!=statCustomerRecordTimes&&!statCustomerRecordTimes.isEmpty()){
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			StringBuffer bufferRoomNum=new StringBuffer();
			StringBuffer bufferNetNum=new StringBuffer();
			StringBuffer bufferTwoNum=new StringBuffer();
			bufferNum.append("[");
			if(type==1){
				bufferNum.append("{name:'每日来店',data:[");
			}
			if(type==2){
				bufferNum.append("{name:'每日来电',data:[");
			}
			bufferRoomNum.append("{name:'展厅来店',data:[");
			bufferNetNum.append("{name:'网络来店',data:[");
			bufferTwoNum.append("{name:'二次来店',data:[");
			int i=1;
			int size = statCustomerRecordTimes.size();
			for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecordTimes) {
				if(dateType==1){
					dayByDay.append(DateUtil.formatPatten(statCustomerRecordTime.getCreateDate(),"dd"));
				}
				if(dateType==2){
					dayByDay.append("'"+DateUtil.formatPatten(statCustomerRecordTime.getCreateDate(),"MM月")+"'");
				}
				bufferNum.append(statCustomerRecordTime.getTotalNum());
				bufferRoomNum.append(statCustomerRecordTime.getRoomNum());
				bufferNetNum.append(statCustomerRecordTime.getNetNum());
				bufferTwoNum.append(statCustomerRecordTime.getTwoNum());
				if(i!=size){
					dayByDay.append(",");
					bufferNum.append(",");
					bufferRoomNum.append(",");
					bufferNetNum.append(",");
					bufferTwoNum.append(",");
				}
				i++;
			}
			if(type==1){
				bufferNum.append("]},");
			}
			if(type==2){
				bufferNum.append("]}]");
			}
			bufferRoomNum.append("]},");
			bufferNetNum.append("]},");
			bufferTwoNum.append("]}]");
			request.setAttribute("dayByDay", dayByDay.toString());
			if(type==1){
				request.setAttribute("dayByDayNum", bufferNum.toString()+bufferRoomNum.toString()+bufferNetNum.toString()+bufferTwoNum.toString());
			}
			if(type==2){
				request.setAttribute("dayByDayNum", bufferNum.toString());
			}
		}
	}
	/**
	 * 功能描述：数据区间数据统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void receptionTimeData(HttpServletRequest request,StatCustomerRecordTime statCustomerRecordTime,int type){
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[{");
			if(type==1){
				bufferNum.append("name:'进店区间',");
			}
			if(type==2){
				bufferNum.append("name:'来电区间',");
			}
			bufferNum.append("data:[");
			dayByDay.append("'8:00-9:00',");
			bufferNum.append(statCustomerRecordTime.getEightNum()+",");
			dayByDay.append("'9:00-10:00',");
			bufferNum.append(statCustomerRecordTime.getNineNum()+",");
			dayByDay.append("'10:00-11:00',");
			bufferNum.append(statCustomerRecordTime.getTenNum()+",");
			dayByDay.append("'11:00-12:00',");
			bufferNum.append(statCustomerRecordTime.getElevenNum()+",");
			dayByDay.append("'12:00-13:00',");
			bufferNum.append(statCustomerRecordTime.getTwelveNum()+",");
			dayByDay.append("'13:00-14:00',");
			bufferNum.append(statCustomerRecordTime.getThirteenNum()+",");
			dayByDay.append("'14:00-15:00',");
			bufferNum.append(statCustomerRecordTime.getFourteenNum()+",");
			dayByDay.append("'15:00-16:00',");
			bufferNum.append(statCustomerRecordTime.getFifteenNum()+",");
			dayByDay.append("'16:00-17:00',");
			bufferNum.append(statCustomerRecordTime.getSixteenNum()+",");
			dayByDay.append("'17:00-18:00',");
			bufferNum.append(statCustomerRecordTime.getSeventeenNum()+",");
			dayByDay.append("'18:00<'");
			bufferNum.append(statCustomerRecordTime.getEighteenNUm());
			bufferNum.append("]");
			bufferNum.append("}]");
			request.setAttribute("receptionTimeTitle", dayByDay.toString());
			request.setAttribute("receptionTimeData", bufferNum.toString());
	}
	/**
	 * 功能描述：数据区间数据统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void receptionTargetData(HttpServletRequest request,List<CustomerRecordTarget> customerRecordTargetAlls,int type){
		StringBuffer titleBuf=new StringBuffer();
		StringBuffer dataBuf=new StringBuffer();
		dataBuf.append("[{");
		if(type==1){
			dataBuf.append("name:'来店目的',");
		}
		if(type==2){
			dataBuf.append("name:'来电目的',");
		}
		dataBuf.append("data:[");
		int i=0;
		int size = customerRecordTargetAlls.size();
		for (CustomerRecordTarget customerRecordTarget : customerRecordTargetAlls) {
			i++;
			if(i==size){
				titleBuf.append("'"+customerRecordTarget.getName()+"'");
				dataBuf.append(customerRecordTarget.getTotalNum());
			}else{
				titleBuf.append("'"+customerRecordTarget.getName()+"',");
				dataBuf.append(customerRecordTarget.getTotalNum()+",");
			}
		}
		dataBuf.append("]");
		dataBuf.append("}]");
		request.setAttribute("receptionTargetTitle", titleBuf.toString());
		request.setAttribute("receptionTargetData", dataBuf.toString());
	}
	/**
	 * 功能描述：车型柱状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void receptionCarSerData(HttpServletRequest request,
			List<CarSerCount> carSerCountTotals, Integer type) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = carSerCountTotals.size();
		CarSerCount maxCount=carSerCountTotals.get(0);
		for (CarSerCount carSerCount : carSerCountTotals) {
			if(maxCount.getCountNum()<carSerCount.getCountNum()){
				maxCount=carSerCount;
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
		request.setAttribute("receptionCarSerData", dataBuf.toString());
	}
	/**
	 * 功能描述：车型柱状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void receptionMonthData(HttpServletRequest request,
			List<StaCustomerRecordMonth> staCustomerRecordMonths) {
		StringBuffer comeShopBuf=new StringBuffer();
		comeShopBuf.append("{name: '展厅来店量',type: 'column',yAxis: 1,data: [");
		StringBuffer netBuf=new StringBuffer();
		netBuf.append("{name: '网销来店量',type: 'column',yAxis: 1,data: [");
		StringBuffer comeShopCreateFolderBuf=new StringBuffer();
		comeShopCreateFolderBuf.append("{name: '展厅来店建档量',type: 'column',yAxis: 1,data: [");
		StringBuffer comeShopCreateFolderPerBuf=new StringBuffer();
		comeShopCreateFolderPerBuf.append("{name: '建档率',type: 'spline',yAxis: 1,data: [");
		
		StringBuffer phoneShopNumBuff=new StringBuffer();
		phoneShopNumBuff.append("{name: '来电量',type: 'column',yAxis: 1,data: [");
		StringBuffer phoneCreateFolderNumBuff=new StringBuffer();
		phoneCreateFolderNumBuff.append("{name: '来电建档量',type: 'column',yAxis: 1,data: [");
		StringBuffer phoneCreateFolderPerBuff=new StringBuffer();
		phoneCreateFolderPerBuff.append("{name: '来电建档率',type: 'spline',yAxis: 1,data: [");
		
		int i=0;
		int size = staCustomerRecordMonths.size();
		for (StaCustomerRecordMonth staCustomerRecordMonth : staCustomerRecordMonths) {
			i++;
			if(size==i){
				comeShopBuf.append(staCustomerRecordMonth.getComeShopNum()+"]");
				netBuf.append(staCustomerRecordMonth.getNetNum()+"]");
				comeShopCreateFolderBuf.append(staCustomerRecordMonth.getComeShopCreateFolderNum()+"]");
				comeShopCreateFolderPerBuf.append(staCustomerRecordMonth.getComeShopCreateFolderNumPer()+"]");
				
				phoneShopNumBuff.append(staCustomerRecordMonth.getPhoneShopNum()+"]");
				phoneCreateFolderNumBuff.append(staCustomerRecordMonth.getPhoneCreateFolderNum()+"]");
				phoneCreateFolderPerBuff.append(staCustomerRecordMonth.getPhoneCreateFolderPer()+"]");
			}else{
				comeShopBuf.append(staCustomerRecordMonth.getComeShopNum()+",");
				netBuf.append(staCustomerRecordMonth.getNetNum()+",");
				comeShopCreateFolderBuf.append(staCustomerRecordMonth.getComeShopCreateFolderNum()+",");
				comeShopCreateFolderPerBuf.append(staCustomerRecordMonth.getComeShopCreateFolderNumPer()+",");
				
				phoneShopNumBuff.append(staCustomerRecordMonth.getPhoneShopNum()+",");
				phoneCreateFolderNumBuff.append(staCustomerRecordMonth.getPhoneCreateFolderNum()+",");
				phoneCreateFolderPerBuff.append(staCustomerRecordMonth.getPhoneCreateFolderPer()+",");
			}
		}
		comeShopBuf.append(",tooltip: {valueSuffix: '批次'}},");
		netBuf.append(",tooltip: {valueSuffix: '批次'}},");
		comeShopCreateFolderBuf.append(",tooltip: {valueSuffix: '批次'}},");
		comeShopCreateFolderPerBuf.append(",tooltip: {valueSuffix: '百分比'}}");
		request.setAttribute("receptionMonthData", comeShopBuf.toString()+netBuf.toString()+comeShopCreateFolderBuf.toString()+comeShopCreateFolderPerBuf.toString());
		
		phoneShopNumBuff.append(",tooltip: {valueSuffix: '批次'}},");
		phoneCreateFolderNumBuff.append(",tooltip: {valueSuffix: '批次'}},");
		phoneCreateFolderPerBuff.append(",tooltip: {valueSuffix: '百分比'}}");
		request.setAttribute("receptionPhoneMonthData", phoneShopNumBuff.toString()+phoneCreateFolderNumBuff.toString()+phoneCreateFolderPerBuff.toString());
	}
	
	/**
	 * 功能描述：每月车辆关注车型趋势
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private void dayByDayDataCarLine(HttpServletRequest request,List<CarSeriy> carSeriys,Map<StaDateNum, List<CarSerCount>> mapCarSerCount) {
		StringBuffer bufferNum=new StringBuffer();
		bufferNum.append("[");
		int j=0;
		int size = mapCarSerCount.size();
		Set<StaDateNum> keySet = mapCarSerCount.keySet();
		int keySize = keySet.size();
		for (CarSeriy carSeriy : carSeriys) {
			bufferNum.append("{name:'"+carSeriy.getName()+"',data:[");
			int tempSize=1;
			Set<Entry<StaDateNum, List<CarSerCount>>> entrySet = mapCarSerCount.entrySet();
			for (Entry<StaDateNum, List<CarSerCount>> entry : entrySet) {
				List<CarSerCount> carSerCounts = entry.getValue();
				if(null!=carSerCounts&&!carSeriys.isEmpty()){
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
		
	}
}
