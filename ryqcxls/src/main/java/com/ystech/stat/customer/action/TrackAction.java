package com.ystech.stat.customer.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.stat.customer.model.Flow;
import com.ystech.stat.customer.model.FlowReason;
import com.ystech.stat.customer.model.FlowUser;
import com.ystech.stat.customer.model.Track;
import com.ystech.stat.customer.model.TrackStatTotal;
import com.ystech.stat.customer.model.TrackUser;
import com.ystech.stat.customer.service.TrackManageImpl;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

@Component("trackAction")
@Scope("prototype")
public class TrackAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	private TrackManageImpl trackManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setTrackManageImpl(TrackManageImpl trackManageImpl) {
		this.trackManageImpl = trackManageImpl;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryTrackList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=1;
		//网销数据
		int userBussiType=2;
		try {
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
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
			
			//客户回访按天统计
			List<Track> tracks = trackManageImpl.queryTrack(beginDate, endDate, type, enterprise, dateType, null,tryCarStatus,comeShopStatus);
			request.setAttribute("tracks", tracks);
			
			Track trackAll = trackManageImpl.queryTrackAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackAll",trackAll);
			
			//统计选择时间内销售顾问回访数据
			List<TrackUser> trackUsers = trackManageImpl.queryTrackUser(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackUsers", trackUsers);
			
			TrackUser trackUserAll = trackManageImpl.queryTrackUserAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserAll", trackUserAll);
			
			//销售顾问潜客平均回访次数
			List<TrackStatTotal> trackStatTotals = trackManageImpl.queryTrackUserStatTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatTotals", trackStatTotals);
			
			TrackStatTotal trackStatTotal = trackManageImpl.queryTrackStatTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatTotal", trackStatTotal);
			
			//成交客户回访率统计
			TrackStatTotal trackStatSuccessTotal = trackManageImpl.queryTrackStatSuccessTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatSuccessTotal", trackStatSuccessTotal);
			
			List<TrackStatTotal> trackUserStatSuccessTotalLists = trackManageImpl.queryTrackUserStatSuccessTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserStatSuccessTotalLists", trackUserStatSuccessTotalLists);
			
			List<TrackStatTotal> trackUserStatFlowTotalLists = trackManageImpl.queryTrackUserStatFlowTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserStatFlowTotalLists", trackUserStatFlowTotalLists);
			
			TrackStatTotal trackStatFlowTotal = trackManageImpl.queryTrackStatFlowTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatFlowTotal", trackStatFlowTotal);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "flowList";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryTrackYearList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=2;
		//网销数据
		int userBussiType=2;
		try {
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
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
			
			//客户回访按天统计
			List<Track> tracks = trackManageImpl.queryTrack(beginDate, endDate, type, enterprise, dateType, null,tryCarStatus,comeShopStatus);
			request.setAttribute("tracks", tracks);
			
			Track trackAll = trackManageImpl.queryTrackAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackAll",trackAll);
			
			//统计选择时间内销售顾问回访数据
			List<TrackUser> trackUsers = trackManageImpl.queryTrackUser(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackUsers", trackUsers);
			
			TrackUser trackUserAll = trackManageImpl.queryTrackUserAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserAll", trackUserAll);
			
			//销售顾问潜客平均回访次数
			List<TrackStatTotal> trackStatTotals = trackManageImpl.queryTrackUserStatTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatTotals", trackStatTotals);
			
			TrackStatTotal trackStatTotal = trackManageImpl.queryTrackStatTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatTotal", trackStatTotal);
			
			//成交客户回访率统计
			TrackStatTotal trackStatSuccessTotal = trackManageImpl.queryTrackStatSuccessTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatSuccessTotal", trackStatSuccessTotal);
			
			List<TrackStatTotal> trackUserStatSuccessTotalLists = trackManageImpl.queryTrackUserStatSuccessTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserStatSuccessTotalLists", trackUserStatSuccessTotalLists);
			
			List<TrackStatTotal> trackUserStatFlowTotalLists = trackManageImpl.queryTrackUserStatFlowTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackUserStatFlowTotalLists", trackUserStatFlowTotalLists);
			
			TrackStatTotal trackStatFlowTotal = trackManageImpl.queryTrackStatFlowTotalList(enterprise,type,tryCarStatus, comeShopStatus);
			request.setAttribute("trackStatFlowTotal", trackStatFlowTotal);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			
		}catch(Exception e){
			
		}
		return "flowYearList";
	}
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(HttpServletRequest request,List<Flow> comeShops,int dateType,int dataType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int keySize = comeShops.size();
			if(dataType==1){
				bufferNum.append("{name:'建档客户',data:[");
			}
			if(dataType==2){
				bufferNum.append("{name:'流失客户',data:[");
			}
			if(dataType==3){
				bufferNum.append("{name:'净增客户',data:[");
			}
			int tempSize=1;
			for (Flow comeShop : comeShops) {
				if(null!=comeShop){
					int num=0;
					if(dataType==1){
						num=comeShop.getCreateFolderNum();
					}
					if(dataType==2){
						num=comeShop.getFlowNum();
					}
					if(dataType==3){
						num=comeShop.getAddNum();
					}
					bufferNum.append(num);
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
			bufferNum.append("]}");
			bufferNum.append("]");
			
			j=1;
			for (StaDateNum staCustomerRecordDateNum : comeShops) {
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
	 * 功能描述：车型饼状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieCarSerData(List<CarSerCount> carSerCountTotals) {
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
		return dataBuf.toString();
	}
	/**
	 * 功能描述：车型饼状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieUserData(List<FlowUser> flowUser) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = flowUser.size();
		FlowUser maxCount=flowUser.get(0);
		for (FlowUser carSerCount : flowUser) {
			if(maxCount.getFlowNum()<carSerCount.getFlowNum()){
				maxCount=carSerCount;
			}
		}
		
		dataBuf.append("[");
		for (FlowUser carSerCount : flowUser) {
			int dateNum=0;
			dateNum=carSerCount.getFlowNum();
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getUserName()+"\","
					+"y:"+dateNum);
			if(carSerCount.getUserName().equals(maxCount.getUserName())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("}");
			if(i!=size){
				dataBuf.append(",");
			}
		}
		dataBuf.append("]");
		return dataBuf.toString();
	}
	/**
	 * 功能描述：流失原因统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieFlowReasonData(List<FlowReason> flowReasons) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = flowReasons.size();
		FlowReason maxCount=flowReasons.get(0);
		for (FlowReason carSerCount : flowReasons) {
			if(maxCount.getFlowNum()<carSerCount.getFlowNum()){
				maxCount=carSerCount;
			}
		}
		
		dataBuf.append("[");
		for (FlowReason carSerCount : flowReasons) {
			int dateNum=0;
			dateNum=carSerCount.getFlowNum();
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getName()+"\","
					+"y:"+dateNum);
			if(carSerCount.getName().equals(maxCount.getName())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("}");
			if(i!=size){
				dataBuf.append(",");
			}
		}
		dataBuf.append("]");
		return dataBuf.toString();
	}
	
}
