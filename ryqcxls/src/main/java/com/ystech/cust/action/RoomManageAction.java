package com.ystech.cust.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.ystech.cust.model.CarseriyItemTypeCount;
import com.ystech.cust.model.CityCrossCustomerCount;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.DayComeShop;
import com.ystech.cust.model.HasNoCarOrder;
import com.ystech.cust.model.InfoFromTotal;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.RoomManageStaticManageImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("roomManageAction")
@Scope("prototype")
public class RoomManageAction extends BaseController{
	private CustomerMangeImpl customerMangeImpl;
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	private DepartmentManageImpl departmentManageImpl;
	private RoomManageStaticManageImpl roomManageStaticManageImpl;
	private StatisticalManageImpl statisticalManageImpl;
	private HttpServletRequest request=this.getRequest();
	private CarSeriyManageImpl carSeriyManageImpl; 
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	private UserManageImpl userManageImpl;
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setStatisticalManageImpl(StatisticalManageImpl statisticalManageImpl) {
		this.statisticalManageImpl = statisticalManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setRoomManageStaticManageImpl(
			RoomManageStaticManageImpl roomManageStaticManageImpl) {
		this.roomManageStaticManageImpl = roomManageStaticManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	 * 功能描述：统计主页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		try{
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" departmentId="+currentUser.getDepartment().getDbid();
			}
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where "+selSql+" and (lastResult="+Customer.NORMAL+" or (lastResult="+Customer.SUCCESS+" and orderContractStatus="+Customer.ORDERNOT+")) ";

			String canncelCountSql="SELECT COUNT(*) as total FROM cust_customer where "+selSql+" and lastResult>"+Customer.SUCCESS;

			String orderCountSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_ordercontract AS ord where cuts.dbid=ord.customerId AND ord.`status`<"+OrderContract.PRINT+" and "+selSql+"" ;
			
			String waitingCarSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus!="+CustomerPidBookingRecord.FINISHED +" and "+selSql ;
			
			String customerSuccessSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus="+CustomerPidBookingRecord.FINISHED +" and "+selSql+"" ;
			
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			
			Object canncelCount = statisticalSalerManageImpl.queryCount(canncelCountSql);
			request.setAttribute("canncelCount", canncelCount);
			
			Object orderCount = statisticalSalerManageImpl.queryCount(orderCountSql);
			request.setAttribute("orderCount", orderCount);
			
			
			Object waitingCar = statisticalSalerManageImpl.queryCount(waitingCarSql);
			request.setAttribute("waitingCar", waitingCar);
			
			Object customerSuccess = statisticalSalerManageImpl.queryCount(customerSuccessSql);
			request.setAttribute("customerSuccess", customerSuccess);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	
	/**
	 * 功能描述：车辆类型统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String carStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			//车型信息
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy order by itemType ", null);
			request.setAttribute("carSeriys",carSeriys);
			
			List<CarSerCount> carSerCounts = roomManageStaticManageImpl.queryCountCar(start, end, selSql);
			
			List<CarSerCount> carSerCounts2 = filterCarSerCounts(carSeriys, carSerCounts);
			request.setAttribute("carSerCounts", carSerCounts2);
			
			Integer totalcCountCar = roomManageStaticManageImpl.queryCountCarTotal(start, end,  selSql);
			request.setAttribute("totalcCountCar", totalcCountCar);
			
			String jsonCarData = jsonCarData(carSerCounts2);
			request.setAttribute("jsonCarData", jsonCarData);
			
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "carStatistics";
	}
	
	private List<CarSerCount> filterCarSerCounts(List<CarSeriy> carSeriys,List<CarSerCount> carSerCounts){
		List<CarSerCount> carSerCounts2=new ArrayList<CarSerCount>();
		if(null!=carSeriys){
			int carSeriysLength = carSeriys.size();
			if(null!=carSerCounts){
				int carSerCountsLenth = carSerCounts.size();
				if(carSerCountsLenth==carSeriysLength){
					return carSerCounts;
				}else{
					for (CarSeriy carSeriy : carSeriys) {
						boolean state=false;
						for (CarSerCount carSerCount : carSerCounts) {
							if(carSerCount.getSerid()==carSeriy.getDbid()){
								state=true;
								carSerCounts2.add(carSerCount);
								break;
							}
						}
						if(state==false){
							CarSerCount carSerCount=new CarSerCount();
							carSerCount.setCountNum(0);
							carSerCount.setPer(Double.valueOf("0.0"));
							carSerCount.setSerid(carSeriy.getDbid());
							carSerCount.setSerName(carSeriy.getName());
							carSerCounts2.add(carSerCount);
						}
					}
				}
			}else{
				for (CarSeriy carSeriy : carSeriys) {
					CarSerCount carSerCount=new CarSerCount();
					carSerCount.setCountNum(0);
					carSerCount.setPer(Double.valueOf("0.0"));
					carSerCount.setSerid(carSeriy.getDbid());
					carSerCount.setSerName(carSeriy.getName());
					carSerCounts2.add(carSerCount);
				}
			}
		}else{
			return null;
		}
		return carSerCounts2;
	}
	
	
	/**
	 * 功能描述：每日进店量分析
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String dayComeShopStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			List<DayComeShop> dayComeShops = roomManageStaticManageImpl.queryCountDayComeShop(start, selSql, CustomerShoppingRecord.COMETYPESHOPING);
			
			String xSer=new String();
			String xSerValue=new String();
			xSer=xSer+"[";
			xSerValue=xSerValue+"[";
			for (DayComeShop dayComeShop : dayComeShops) {
				xSer=xSer+dayComeShop.getDay()+",";
				xSerValue=xSerValue+dayComeShop.getCountNum()+",";
			}
			xSer = xSer.substring(0,xSer.lastIndexOf(","));
			xSerValue = xSerValue.substring(0,xSerValue.lastIndexOf(","));
			xSer=xSer+"]";
			xSerValue=xSerValue+"]";
			
			request.setAttribute("xSerValue", xSerValue);
			request.setAttribute("xSer", xSer);
			request.setAttribute("dayComeShops", dayComeShops);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			
		}
		return "dayComeShopStatistics";
	}
	/**
	 * 功能描述：来电类型分析
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String comeTypeStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			//来店
			List<DayComeShop> shopings = roomManageStaticManageImpl.queryCountDayComeShop(start, selSql,CustomerShoppingRecord.COMETYPESHOPING);
			//其他方式
			List<DayComeShop> others = roomManageStaticManageImpl.queryCountDayComeShop(start, selSql,CustomerShoppingRecord.COMETYPEOTHER);
			request.setAttribute("others", others);
			//电话
			List<DayComeShop> phones = roomManageStaticManageImpl.queryCountDayComeShop(start, selSql,CustomerShoppingRecord.COMETYPEPHONE);
			request.setAttribute("phones", phones);
			//活动
			List<DayComeShop> acts = roomManageStaticManageImpl.queryCountDayComeShop(start, selSql,CustomerShoppingRecord.COMETYPESACT);
			request.setAttribute("acts", acts);
			
			String xSer=new String();
			xSer=xSer+"[";
			for (DayComeShop dayComeShop : shopings) {
				xSer=xSer+dayComeShop.getDay()+",";
			}
			xSer = xSer.substring(0,xSer.lastIndexOf(","));
			xSer=xSer+"]";
			
			String shopingV = getComeType(shopings);
			String actV = getComeType(acts);
			String phoneV = getComeType(phones);
			String otherV = getComeType(others);
			
			request.setAttribute("shopingV", shopingV);
			request.setAttribute("actV", actV);
			request.setAttribute("phoneV", phoneV);
			request.setAttribute("otherV", otherV);
			request.setAttribute("xSer", xSer);
			request.setAttribute("dayComeShops", shopings);
			
			
			Object shopCount = roomManageStaticManageImpl.queryCountDayComeShopCount(start, selSql, CustomerShoppingRecord.COMETYPESHOPING);
			Object phoneCount = roomManageStaticManageImpl.queryCountDayComeShopCount(start, selSql, CustomerShoppingRecord.COMETYPEPHONE);
			Object actCount = roomManageStaticManageImpl.queryCountDayComeShopCount(start, selSql, CustomerShoppingRecord.COMETYPESACT);
			Object otherCount = roomManageStaticManageImpl.queryCountDayComeShopCount(start, selSql, CustomerShoppingRecord.COMETYPEOTHER);
			request.setAttribute("shopCount", shopCount);
			request.setAttribute("phoneCount", phoneCount);
			request.setAttribute("actCount", actCount);
			request.setAttribute("otherCount", otherCount);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "comeTypeStatistics";
	}
	/**
	 * 来店类型数据值
	 * @param shopings
	 * @return
	 */
	private String getComeType(List<DayComeShop> shopings ){
		String xSerValue=new String();
		xSerValue=xSerValue+"[";
		for (DayComeShop dayComeShop : shopings) {
			xSerValue=xSerValue+dayComeShop.getCountNum()+",";
		}
		xSerValue = xSerValue.substring(0,xSerValue.lastIndexOf(","));
		xSerValue=xSerValue+"]";
		return xSerValue;
	}
	/**
	 * 功能描述：客户等级分析
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String levelStatistics() throws Exception {
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			List<Department> departments = departmentManageImpl.find("from Department  where name like ? ", new Object[]{"%销售%"});
			request.setAttribute("departments", departments);
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			
			Department department = departmentManageImpl.get(departmentId);
			request.setAttribute("department", department);
			String departmentIds2 = departmentManageImpl.getDepartmentIds(department);
			//来店
			List<DayComeShop> levelOs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELO);
			List<DayComeShop> levelAs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELA);
			List<DayComeShop> levelBs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELB);
			List<DayComeShop> levelCs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELC);
			List<DayComeShop> levelLs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELL);
			List<DayComeShop> levelFs = statisticalManageImpl.queryLevlelDayComeShop(start, end, departmentIds2, CustomerPhase.LEVELF);
			request.setAttribute("levelOs", levelOs);
			request.setAttribute("levelAs", levelAs);
			request.setAttribute("levelBs", levelBs);
			request.setAttribute("levelCs", levelCs);
			request.setAttribute("levelLs", levelLs);
			request.setAttribute("levelFs", levelFs);
			
			String xSer=new String();
			xSer=xSer+"[";
			for (DayComeShop dayComeShop : levelOs) {
				xSer=xSer+dayComeShop.getDay()+",";
			}
			xSer = xSer.substring(0,xSer.lastIndexOf(","));
			xSer=xSer+"]";
			
			String levelAV = getComeType(levelAs);
			String levelOV = getComeType(levelOs);
			String levelBV = getComeType(levelBs);
			String levelCV = getComeType(levelCs);
			String levelLV = getComeType(levelLs);
			String levelFV = getComeType(levelFs);
			
			request.setAttribute("levelAV", levelAV);
			request.setAttribute("levelOV", levelOV);
			request.setAttribute("levelBV", levelBV);
			request.setAttribute("levelCV", levelCV);
			request.setAttribute("levelLV", levelLV);
			request.setAttribute("levelFV", levelFV);
			request.setAttribute("xSer", xSer);
		
			
			Object levelCO = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELO);
			Object levelCA = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELA);
			Object levelCB = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELB);
			Object levelCC = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELC);
			Object levelLC = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELL);
			Object levelFC = statisticalManageImpl.queryCountLevelCount(start, end, departmentIds2, CustomerPhase.LEVELF);
			request.setAttribute("levelCO", levelCO);
			request.setAttribute("levelCA", levelCA);
			request.setAttribute("levelCB", levelCB);
			request.setAttribute("levelCC", levelCC);
			request.setAttribute("levelLC", levelLC);
			request.setAttribute("levelFC", levelFC);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "levelStatistics";
	}
	/**
	 * 功能描述：渠道分析
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String tradeStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			List<InfoFromTotal> infoFromTotals = roomManageStaticManageImpl.queryCountInfo(start, end, selSql);
			
			Integer totalCount = roomManageStaticManageImpl.queryCountInfoTotal(start, end,  selSql);
			request.setAttribute("totalcCountCar", totalCount);
			
			
			String jsonInfoData = jsonInfoData(infoFromTotals);
			request.setAttribute("jsonInfoData", jsonInfoData);
			
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "tradeStatistics";
	}
	/**
	 * 功能描述：无车订单统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String noCarStatistics() throws Exception {
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<HasNoCarOrder> hasNoCarOrders = statisticalManageImpl.queryHasNoCarOrders(enterprise.getDbid());
			request.setAttribute("hasNoCarOrders", hasNoCarOrders);
			
			//已经处理 无车
			String countFinishedSqlNoCarSql=" select count(*) AS total " +
					" from  cust_Customer as cu,cust_CustomerPidBookingRecord as cpid " +
					" where " +
					" cpid.customerId=cu.dbid and cpid.pidStatus>=1 and cpid.wlStatus=2 and cpid.pidStatus!=2 and hasCarOrder="+CustomerPidBookingRecord.HASCARORDERNO;
			Object countFinishedSqlNoCar = statisticalSalerManageImpl.queryCount(countFinishedSqlNoCarSql);
			request.setAttribute("countFinishedSqlNoCar", countFinishedSqlNoCar);
			
			request.setAttribute("enterprise", enterprise);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "noCarStatistics";
	}
	/**
	 * 功能描述：试乘试驾率统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String tryCarStatistics() throws Exception {
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			List<User> userSubs = userManageImpl.findBy("parent.dbid", currentUser.getDbid());
			userSubs.add(currentUser);
			request.setAttribute("users", userSubs);
			//试乘试驾列表信息
			Integer[] queryTryCar = roomManageStaticManageImpl.queryTryCar(start, end,userId, selSql);
			
			Integer totalCount = roomManageStaticManageImpl.queryTryCarCount(start, end, userId, selSql);
			
			request.setAttribute("queryTryCar", queryTryCar);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "tryCarStatistics";
	}
	/**
	 * 功能描述：同城交叉客户分析
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String cityCrossCustomer() throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			Enterprise enterprise = currentUser.getEnterprise();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			//交叉客户总数
			Integer count = roomManageStaticManageImpl.queryCityCrossCustomerCount(start, end, selSql);
			request.setAttribute("count", count);
			
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
		}catch (Exception e) {
			// TODO: handele exception
			e.printStackTrace();
		}
		return "cityCrossCustomer";
	}
	private String jsonData(List<CarseriyItemTypeCount> carseriyItemTypeCounts){
		String data="[";
		for (CarseriyItemTypeCount carseriyItemTypeCount : carseriyItemTypeCounts) {
			if(carseriyItemTypeCount.getItemType()==1){
				data=data+" ['主力车型',"+carseriyItemTypeCount.getCountNum()+"],";
			}
			if(carseriyItemTypeCount.getItemType()==2){
				data=data+" ['发力车型',"+carseriyItemTypeCount.getCountNum()+"],";
			}
			if(carseriyItemTypeCount.getItemType()==3){
				data=data+" ['清库车型',"+carseriyItemTypeCount.getCountNum()+"],";
			}
			if(carseriyItemTypeCount.getItemType()==4){
				data=data+" ['其他',"+carseriyItemTypeCount.getCountNum()+"]";
			}
		}
	   data=data+"]";
	   return data;
 }
	
	private String jsonCarData(List<CarSerCount> carSerCounts){
		String data="[";
		for (CarSerCount carSerCount : carSerCounts) {
				data=data+" ['"+carSerCount.getSerName()+"',"+carSerCount.getCountNum()+"],";
		}
		int lastIndexOf = data.lastIndexOf(",");
		data = data.substring(0, lastIndexOf);
		data=data+"]";
		return data;
	}
	//渠道json
	private String jsonInfoData(List<InfoFromTotal> infoFromTotals){
		String data="[";
		for (InfoFromTotal infoFromTotal : infoFromTotals) {
			data=data+" ['"+infoFromTotal.getInName()+"',"+infoFromTotal.getTotalCount()+"],";
		}
		int lastIndexOf = data.lastIndexOf(",");
		if(lastIndexOf!=-1){
			data = data.substring(0, lastIndexOf);
		}
		data=data+"]";
		return data;
	}
	//交叉客户json
	private String jsonCityCrossesData(List<CityCrossCustomerCount> cityCrossCustomerCounts){
		String data="[";
		for (CityCrossCustomerCount cityCrossCustomerCount : cityCrossCustomerCounts) {
			data=data+" ['"+cityCrossCustomerCount.getName()+"',"+cityCrossCustomerCount.getTotalCount()+"],";
		}
		int lastIndexOf = data.lastIndexOf(",");
		data = data.substring(0, lastIndexOf);
		data=data+"]";
		return data;
	}
	
}
