package com.ystech.stat.customer.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.ystech.stat.customer.model.Order;
import com.ystech.stat.customer.model.OrderBuyType;
import com.ystech.stat.customer.model.OrderType;
import com.ystech.stat.customer.model.OrderUser;
import com.ystech.stat.customer.service.OrderManageImpl;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("orderAction")
@Scope("prototype")
public class OrderAction extends BaseController{
	private OrderManageImpl orderManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	public OrderManageImpl getOrderManageImpl() {
		return orderManageImpl;
	}
	@Resource
	public void setOrderManageImpl(OrderManageImpl orderManageImpl) {
		this.orderManageImpl = orderManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryOrderList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer customerType = ParamUtil.getIntParam(request, "customerType", -1);
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
			//每日订单明细
			List<Order> orders = orderManageImpl.queryFLow(beginDate, endDate, type, enterprise, dateType, null,tryCarStatus,comeShopStatus,customerType);
			request.setAttribute("orders", orders);
			//变化趋势
			String[] dayByDayData = dayByDayData(orders, dateType, 1);
			request.setAttribute("dayByDayNumAll",dayByDayData[0]);
			request.setAttribute("selfOrderDayByDay",dayByDayData[1]);
			String[] comeShopDayByDay = dayByDayData(orders, dateType, 2);
			request.setAttribute("netOrderDayByDay",comeShopDayByDay[1]);
			String[] comeShopOrderDayByDay = dayByDayData(orders, dateType, 3);
			request.setAttribute("orderDayByDay",comeShopOrderDayByDay[1]);
			//
			Order totalOrder = orderManageImpl.queryOrderTotal(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus,customerType);
			request.setAttribute("totalOrder", totalOrder);
			
			//客户类型订单统计
			List<OrderType> orderTypes = orderManageImpl.queryOrderType(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("orderTypes",orderTypes);
			OrderType orderTypeAll = orderManageImpl.queryOrderTypeAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("orderTypeAll", orderTypeAll);
			String pieOrderTypeData = pieOrderTypeData(orderTypes, totalOrder);
			request.setAttribute("pieOrderType", pieOrderTypeData);
			
			//购车方式
			List<OrderBuyType> orderBuyTypes = orderManageImpl.queryBuyCarTypeOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderBuyTypes", orderBuyTypes);
			
			//每日订单车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			Map<Order, List<CarSerCount>> mapCarseriys = orderManageImpl.queryOrderCarSeriy(orders, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("mapCarseriys", mapCarseriys);
			List<CarSerCount> carSerCounts = orderManageImpl.queryOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderCarSeriyAll", carSerCounts);
			String pieCarSerData = pieCarSerData(carSerCounts);
			request.setAttribute("pieOrderCarSerData",pieCarSerData);
			
			
			//用户数据统计
			List<OrderUser> orderUsers = orderManageImpl.queryOrderUser(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUsers", orderUsers);
			OrderUser orderUserAll = orderManageImpl.queryOrderUserAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUserAll", orderUserAll);
			String pieUserData = pieUserData(orderUsers);
			request.setAttribute("pieUserData", pieUserData);
			
			//销售顾问车型统计
			Map<OrderUser, List<CarSerCount>> mapUserOrderCars = orderManageImpl.queryUserOrderCarSeriy(orderUsers, beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("mapUserOrderCars", mapUserOrderCars);
			List<CarSerCount> carUserOrderCounts = orderManageImpl.queryUserOrderCarSeriyAll(beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("carUserOrderCounts", carUserOrderCounts);
			
			//订单同比怀比
			StaYearByYearChain staYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, -1);
			request.setAttribute("staYearByYearChain", staYearByYearChain);
			
			//自有店订单同比怀比
			StaYearByYearChain staSelfYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, 1);
			request.setAttribute("staSelfYearByYearChain", staSelfYearByYearChain);
			
			//二网订单同比怀比
			StaYearByYearChain staNetYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, 2);
			request.setAttribute("staNetYearByYearChain", staNetYearByYearChain);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "orderList";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryOrderYearList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer customerType = ParamUtil.getIntParam(request, "customerType", -1);
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=2;
		//网销数据
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
			//每日订单明细
			List<Order> orders = orderManageImpl.queryFLow(beginDate, endDate, type, enterprise, dateType, null,tryCarStatus,comeShopStatus,customerType);
			request.setAttribute("orders", orders);
			//变化趋势
			String[] dayByDayData = dayByDayData(orders, dateType, 1);
			request.setAttribute("dayByDayNumAll",dayByDayData[0]);
			request.setAttribute("selfOrderDayByDay",dayByDayData[1]);
			String[] comeShopDayByDay = dayByDayData(orders, dateType, 2);
			request.setAttribute("netOrderDayByDay",comeShopDayByDay[1]);
			String[] comeShopOrderDayByDay = dayByDayData(orders, dateType, 3);
			request.setAttribute("orderDayByDay",comeShopOrderDayByDay[1]);
			//
			Order totalOrder = orderManageImpl.queryOrderTotal(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus,customerType);
			request.setAttribute("totalOrder", totalOrder);
			
			//客户类型订单统计
			List<OrderType> orderTypes = orderManageImpl.queryOrderType(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("orderTypes",orderTypes);
			OrderType orderTypeAll = orderManageImpl.queryOrderTypeAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus);
			request.setAttribute("orderTypeAll", orderTypeAll);
			String pieOrderTypeData = pieOrderTypeData(orderTypes, totalOrder);
			request.setAttribute("pieOrderType", pieOrderTypeData);
			
			//购车方式
			List<OrderBuyType> orderBuyTypes = orderManageImpl.queryBuyCarTypeOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderBuyTypes", orderBuyTypes);
			
			//每日订单车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			Map<Order, List<CarSerCount>> mapCarseriys = orderManageImpl.queryOrderCarSeriy(orders, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("mapCarseriys", mapCarseriys);
			List<CarSerCount> carSerCounts = orderManageImpl.queryOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderCarSeriyAll", carSerCounts);
			String pieCarSerData = pieCarSerData(carSerCounts);
			request.setAttribute("pieOrderCarSerData",pieCarSerData);
			
			
			//用户数据统计
			List<OrderUser> orderUsers = orderManageImpl.queryOrderUser(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUsers", orderUsers);
			OrderUser orderUserAll = orderManageImpl.queryOrderUserAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUserAll", orderUserAll);
			String pieUserData = pieUserData(orderUsers);
			request.setAttribute("pieUserData", pieUserData);
			
			//销售顾问车型统计
			Map<OrderUser, List<CarSerCount>> mapUserOrderCars = orderManageImpl.queryUserOrderCarSeriy(orderUsers, beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("mapUserOrderCars", mapUserOrderCars);
			List<CarSerCount> carUserOrderCounts = orderManageImpl.queryUserOrderCarSeriyAll(beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("carUserOrderCounts", carUserOrderCounts);
			
			//订单同比怀比
			StaYearByYearChain staYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, -1);
			request.setAttribute("staYearByYearChain", staYearByYearChain);
			
			//自有店订单同比怀比
			StaYearByYearChain staSelfYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, 1);
			request.setAttribute("staSelfYearByYearChain", staSelfYearByYearChain);
			
			//二网订单同比怀比
			StaYearByYearChain staNetYearByYearChain = orderManageImpl.queryOrderStaYearByYearChain(start, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, 2);
			request.setAttribute("staNetYearByYearChain", staNetYearByYearChain);
			
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			
		}catch(Exception e){
			
		}
		return "orderYearList";
	}
	
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(List<Order> orders,int dateType,int dataType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int keySize = orders.size();
			if(dataType==1){
				bufferNum.append("{name:'自有店订单',data:[");
			}
			if(dataType==2){
				bufferNum.append("{name:'二网订单',data:[");
			}
			if(dataType==3){
				bufferNum.append("{name:'总订单',data:[");
			}
			int tempSize=1;
			for (Order comeShop : orders) {
				if(null!=comeShop){
					int num=0;
					if(dataType==1){
						num=comeShop.getSelfOrderNum();
					}
					if(dataType==2){
						num=comeShop.getNetOrderNum();
					}
					if(dataType==3){
						num=comeShop.getOrderNum();
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
			for (StaDateNum staCustomerRecordDateNum : orders) {
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
	 * 功能描述：客户类型饼图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieOrderTypeData(List<OrderType> orderTypes,Order orderAll) {
		StringBuffer dataBuf=new StringBuffer();
		if(orderTypes.isEmpty()){
			return "[]";
		}
		OrderType maxCount = orderTypes.get(0);
		for (OrderType temp : orderTypes) {
			if(maxCount.getOrderNum()<temp.getOrderNum()){
				maxCount=temp;
			}
		}
		dataBuf.append("[");
		for (OrderType temp : orderTypes) {
			dataBuf.append("{"
					+ "name:\""+temp.getName()+"\","
					+"y:"+temp.getOrderNum());
			if(temp.getName().equals(maxCount.getName())){
				dataBuf.append(",sliced: true,selected: true");
			}
			dataBuf.append("},");
		}
		dataBuf.append("{"
				+ "name:\"二网\","
				+"y:"+orderAll.getNetOrderNum());
		dataBuf.append("}");
		dataBuf.append("]");
		return dataBuf.toString();
	}
	/**
	 * 功能描述：车型饼状图统计
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieCarseriyData(List<CarSerCount> carSerCountTotals) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		if(carSerCountTotals.isEmpty()){
			return "[]";
		}
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
	private String pieCarSerData(List<CarSerCount> carSerCountTotals) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		if(carSerCountTotals.isEmpty()){
			return "[]";
		}
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
	private String pieUserData(List<OrderUser> orderUsers) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = orderUsers.size();
		if(orderUsers.isEmpty()){
			return "[]";
		}
		OrderUser maxCount = orderUsers.get(0);
		for (OrderUser carSerCount : orderUsers) {
			if(maxCount.getOrderNum()<carSerCount.getOrderNum()){
				maxCount=carSerCount;
			}
		}
		
		dataBuf.append("[");
		for (OrderUser carSerCount : orderUsers) {
			int dateNum=0;
			dateNum=carSerCount.getOrderNum();
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getBussiStaff()+"\","
					+"y:"+dateNum);
			if(carSerCount.getBussiStaff().equals(maxCount.getBussiStaff())){
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
