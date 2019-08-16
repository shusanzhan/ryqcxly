package com.ystech.qywx.stat.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.model.HasNoCarOrder;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.qywx.model.Count;
import com.ystech.stat.customer.model.Order;
import com.ystech.stat.customer.model.OrderBuyType;
import com.ystech.stat.customer.model.OrderType;
import com.ystech.stat.customer.model.OrderUser;
import com.ystech.stat.customer.service.OrderManageImpl;
import com.ystech.stat.customer.service.WaitingCarManageImpl;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxOrderStaticAction")
@Scope("prototype")
public class QywxOrderStaticAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	private StatisticalManageImpl statisticalManageImpl;
	private OrderManageImpl orderManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private WaitingCarManageImpl waitingCarManageImpl;
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setStatisticalManageImpl(StatisticalManageImpl statisticalManageImpl) {
		this.statisticalManageImpl = statisticalManageImpl;
	}
	@Resource
	public void setOrderManageImpl(OrderManageImpl orderManageImpl) {
		this.orderManageImpl = orderManageImpl;
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
	@Resource
	public void setWaitingCarManageImpl(WaitingCarManageImpl waitingCarManageImpl) {
		this.waitingCarManageImpl = waitingCarManageImpl;
	}
	/**
	 * 功能描述：订单客户统计
	 * 参数描述：1、按部门，车系统计；2、按车系统计；3、按经销商类型统计
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String order(){
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "custtype", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer customerType = ParamUtil.getIntParam(request, "customerType", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=1;
		//网销数据
		try {
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=new Date();
			}
			end= start;
			request.setAttribute("start",start);
			
			User currentUser = getSessionUser();
			String enterpriseIds="";
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
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			//每日订单明细
			List<Order> orders = orderManageImpl.queryFLow(beginDate, endDate, type, enterprise, dateType, null,tryCarStatus,comeShopStatus,customerType);
			request.setAttribute("orders", orders);
			
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
			//每日订单车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			List<CarSerCount> carSerCounts = orderManageImpl.queryOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderCarSeriyAll", carSerCounts);
			String pieCarSerData = pieCarSerData(carSerCounts);
			request.setAttribute("pieOrderCarSerData",pieCarSerData);
			
			//分店数据明细
			List<Count> depCounts = orderManageImpl.queryDepOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("depCounts", depCounts);
			
			//用户数据统计
			List<OrderUser> orderUsers = orderManageImpl.queryOrderUser(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUsers", orderUsers);
			OrderUser orderUserAll = orderManageImpl.queryOrderUserAll(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderUserAll", orderUserAll);
			String pieUserData = pieUserData(orderUsers);
			request.setAttribute("pieUserData", pieUserData);
			
			//购车方式
			List<OrderBuyType> orderBuyTypes = orderManageImpl.queryBuyCarTypeOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderBuyTypes", orderBuyTypes);
			
			//销售顾问车型统计
			Map<OrderUser, List<CarSerCount>> mapUserOrderCars = orderManageImpl.queryUserOrderCarSeriy(orderUsers, beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("mapUserOrderCars", mapUserOrderCars);
			List<CarSerCount> carUserOrderCounts = orderManageImpl.queryUserOrderCarSeriyAll(beginDate, endDate, enterprise, type, dateType, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("carUserOrderCounts", carUserOrderCounts);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "order";
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
		Integer type = ParamUtil.getIntParam(request, "custtype", -1);
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
			request.setAttribute("start",start);
			
			User currentUser = getSessionUser();
			String enterpriseIds="";
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
			
			//每日订单车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
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
			
			//购车方式
			List<OrderBuyType> orderBuyTypes = orderManageImpl.queryBuyCarTypeOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("orderBuyTypes", orderBuyTypes);
			
			//分店数据明细
			List<Count> depCounts = orderManageImpl.queryDepOrder(beginDate, endDate, type, enterprise, dateType, null, tryCarStatus, comeShopStatus, customerType);
			request.setAttribute("depCounts", depCounts);
			
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
	 * 功能描述：留存客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String waitingCar() throws Exception {
		HttpServletRequest request = this.getRequest();
		//领导查询类型1、总经理；2、区域经理；3、销售副总
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		try {
			User currentUser = getSessionUser();
			String enterpriseIds="";
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
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			
			//留存订单总数
			Integer waitingCar = waitingCarManageImpl.getWaitingCountNum(enterpriseId);
			request.setAttribute("waitingCar", waitingCar);
			
			//无车订单
			Integer noCar = waitingCarManageImpl.getOrderCarStatusNum(enterpriseId,CustomerPidBookingRecord.HASCARORDERNO);
			request.setAttribute("noCar", noCar);
			//在途订单
			Integer driverCar = waitingCarManageImpl.getOrderCarStatusNum(enterpriseId,CustomerPidBookingRecord.HASCARORDERING);
			request.setAttribute("driverCar", driverCar);
			//有车订单
			Integer hasCar = waitingCarManageImpl.getOrderCarStatusNum(enterpriseId,CustomerPidBookingRecord.HASCARORDERWIN);
			request.setAttribute("hasCar", hasCar);
			
			
			//物流未处理订单
			Integer wlNoDeal = waitingCarManageImpl.getOrderWlStatusNum(enterpriseId,CustomerPidBookingRecord.WLWATING);
			request.setAttribute("wlNoDeal", wlNoDeal);
			//物流已经处理订单
			Integer wlDealEd = waitingCarManageImpl.getOrderWlStatusNum(enterpriseId,CustomerPidBookingRecord.WLDEALED);
			request.setAttribute("wlDealEd", wlDealEd);
			
			//车辆购车成方式统计--------------------------------------------------------------
			//现款购车人数
			List<OrderBuyType> orderBuyTypes = waitingCarManageImpl.getOrderBuyCarTypeNum(enterpriseId);
			request.setAttribute("orderBuyTypes", orderBuyTypes);
			//分店数据明细
			List<Count> depCounts = waitingCarManageImpl.queryDepOrderNum(enterpriseId);
			request.setAttribute("depCounts", depCounts);
			//订单车型统计
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			List<Count> userCounts = waitingCarManageImpl.queryUserOrderNum(enterpriseId);
			Map<Count, List<CarSerCount>> userMaps = waitingCarManageImpl.queryUserOrderCarSeriy(userCounts, enterpriseId);
			request.setAttribute("userMaps", userMaps);
			List<CarSerCount> carUserOrderCounts = waitingCarManageImpl.queryUserOrderCarSeriyAll(enterpriseId);
			request.setAttribute("carUserOrderCounts", carUserOrderCounts);
			//留存订单月份数据
			List<Count> countMonths = waitingCarManageImpl.queryMonthNum(enterpriseId);
			Map<Count, List<CarSerCount>> mapCountMonths = waitingCarManageImpl.queryMonthOrderCarSeriy(countMonths, enterpriseId);
			request.setAttribute("mapCountMonths", mapCountMonths);
			//**车型统计明细
			List<Count> carSeriyCounts = waitingCarManageImpl.queryOrderCarSeriyWaiting(enterpriseId);
			request.setAttribute("carSeriyCounts", carSeriyCounts);
			
			//车型饼图
			String carSeriyPie = getPie(carSeriyCounts);
			request.setAttribute("carSeriyPie", carSeriyPie);
			//车型明细
			String carSeriByDetail = carSeriById(carSeriyCounts, null);
			request.setAttribute("carSeriByDetail", carSeriByDetail);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "waitingCar";
	}

	/**
	 * 功能描述：生成部门明细数据
	 * @param count
	 * @return
	 */
	public String carSeriById(List<Count> carSeriys,String dateSql){
		StringBuffer buffer=new StringBuffer();
		if(null!=carSeriys&&carSeriys.size()>0){
			for (Count count : carSeriys) {
				buffer.append("<table class=\"table table-bordered table-striped\">");
				buffer.append("<tbody>");
				buffer.append("<tr>");
				buffer.append("<td align=\"center\" colspan=\"4\" style=\"text-align: left;font-size:16px;\">"+count.getName()+"</td>");
				buffer.append("</tr>");
				buffer.append("<tr>");
				buffer.append("<td align=\"center\" width=\"40\">序号</td>");
				buffer.append("<td align=\"center\" width=\"80\">车型</td>");
				buffer.append("<td align=\"center\" width=\"60\">数量</td>");
				buffer.append("</tr>");
				String sql="SELECT " +
						"cm.dbid,cm.`name`,COUNT(cm.dbid) num " +
						"from " +
						"set_carModel cm,cust_customer cust,cust_customerpidbookingrecord cpid " +
						"WHERE " +
						"cm.dbid=cpid.carModelid AND cpid.carSeriyId=ENTER and cpid.customerId=cust.dbid" +
						" and cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED +" AND cpid.pidStatus!=-1 ";
				if(null!=dateSql){
					sql=sql+dateSql;
				}
				sql=sql+" GROUP BY cm.dbid " +
						"ORDER BY num DESC";
				sql=sql.replace("ENTER", count.getDbid()+"");
				List<Count> depCounts = statisticalSalerManageImpl.exceuteCountSql(sql);
				int i=1;
				for (Count count2 : depCounts) {
					buffer.append("<tr>");
					buffer.append("<td align=\"center\" width=\"40\">"+i+"</td>");
					buffer.append("<td align=\"center\" width=\"80\">"+count2.getName()+"</td>");
					buffer.append("<td align=\"center\" width=\"60\">"+count2.getNum()+"</td>");
					buffer.append("</tr>");
					i++;
				}
				buffer.append("<tr>");
				buffer.append("<td align=\"center\" colspan=\"4\" style=\"text-align: right;\">合计："+count.getNum()+"</td>");
				buffer.append("</tr>");
				buffer.append("</tbody>");
				buffer.append("</table>");
			}
		}else{
			
		}
		return buffer.toString();
	}

	/**
	 * 功能描述：获取各分店集客数据
	 * @param dateSql
	 * @param enterpriseIds
	 * @return
	 */
	public List<Count> byEnterpriseSql(String dateSql,String enterpriseIds){
		String sql="SELECT " +
				"ent.dbid,ent.`name`,COUNT(ent.dbid) num "+
				"from "+
				"sys_enterprise ent,cust_customer cust,cust_customerpidbookingrecord cpid "+
				"WHERE "+
				"ent.dbid=cust.enterpriseId and cpid.customerId=cust.dbid and cpid.pidStatus!=2";
		if(null!=dateSql){
			sql=sql+dateSql;
		}
		if(null!=enterpriseIds){
			sql=sql+enterpriseIds;
		}
		sql=sql+"GROUP BY " +
			"ent.dbid " +
			"ORDER BY num DESC;"; 
		List<Count> counts = statisticalSalerManageImpl.exceuteCountSql(sql);
		return counts;
	}
	
	/**
	 * 功能描述：查询车型统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public List<Count> carSeriy(String dateSql,String enterpriseIds) throws Exception {
		String sql="SELECT " +
				"cs.dbid as dbid,cs.`name` as name,COUNT(cpid.carSeriyId) as num "+
				"from "+
				"cust_customer cust,cust_customerpidbookingrecord cpid,set_carseriy cs "+
				"WHERE "+
				"cust.dbid=cpid.customerId AND cpid.carSeriyId=cs.dbid and cpid.pidStatus!=2";
		if(null!=dateSql){
			sql=sql+dateSql;
		}
		if(null!=enterpriseIds){
			sql=sql+enterpriseIds;
		}
		sql=sql+" GROUP BY " +
			" cs.dbid " +
			" ORDER BY num DESC;"; 
		List<Count> counts = statisticalSalerManageImpl.exceuteCountSql(sql);
		return counts;
	}
	/**
	 * 功能描述：无车订单统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String noCar(){
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId",-1);
		try{
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
			request.setAttribute("enterprise", enterprise);
			request.setAttribute("enterprises", enterprises);
			List<HasNoCarOrder> hasNoCarOrders = statisticalManageImpl.queryHasNoCarOrders(enterprise.getDbid());
			request.setAttribute("hasNoCarOrders", hasNoCarOrders);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "noCar";
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
	/**
	 * 功能描述：获取分店饼图
	 * @param counts
	 * @return
	 */
	public static String getPie(List<Count> counts){
		String pie="[";
		if(null!=counts&&counts.size()>0){
			int size = counts.size();
			for (int i=0;i<size;i++) {
				Count count = counts.get(i);
				if(i==0){
					pie=pie+"{" +
							"name: '"+count.getName()+"'," +
							"y: "+count.getNum()+"," +
							"sliced: true,"+
							"selected: true"+
							"},";
				}
				if(i>0&&i<(size-1)){
					pie=pie+"['"+count.getName()+"',"+count.getNum()+"],";
				}
				if(i==(size-1)){
					pie=pie+"['"+count.getName()+"',"+count.getNum()+"]";
				}
			}
			
		}
		pie=pie+"]";
		return pie;
	}
}
