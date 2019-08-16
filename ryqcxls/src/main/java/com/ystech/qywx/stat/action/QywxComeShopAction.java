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
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.stat.customer.model.ComeShop;
import com.ystech.stat.customer.model.ComeShopType;
import com.ystech.stat.customer.model.ComeShopUser;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customer.service.ComeShopManageImpl;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxComeShopAction")
@Scope("prototype")
public class QywxComeShopAction extends BaseController{
	private ComeShopManageImpl comeShopManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	@Resource
	public void setComeShopManageImpl(ComeShopManageImpl comeShopManageImpl) {
		this.comeShopManageImpl = comeShopManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
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
	public String queryComeShopList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer userType = ParamUtil.getIntParam(request, "userType",1);
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
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			
			//首次到店综合统计
			List<ComeShop> comeShops = comeShopManageImpl.queryComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShops", comeShops);
			String[] createFolderDayByDay = dayByDayData(request, comeShops, dateType, 1);
			request.setAttribute("dayByDayNumAll",createFolderDayByDay[0]);
			request.setAttribute("createFolderDayByDay",createFolderDayByDay[1]);
			String[] comeShopDayByDay = dayByDayData(request, comeShops, dateType, 2);
			request.setAttribute("comeShopDayByDay",comeShopDayByDay[1]);
			String[] comeShopOrderDayByDay = dayByDayData(request, comeShops, dateType, 3);
			request.setAttribute("comeShopOrderDayByDay",comeShopOrderDayByDay[1]);
			//首次到店综合统计 汇总数据
			ComeShop comeShopTotal = comeShopManageImpl.queryComeShopTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTotal", comeShopTotal);
			
			//个线索来店率
			List<ComeShopType> comeShopTypes = comeShopManageImpl.queryComeShopType(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTypes",comeShopTypes);
			ComeShopType comeShopTypeTotal = comeShopManageImpl.queryComeShopTypeTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTypeTotal",comeShopTypeTotal);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			
			//建档客户车型明细
			Map<StaDateNum, List<CarSerCount>> mapCreateFolderCarSeriy = comeShopManageImpl.queryCreateFolderCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapCreateFolderCarSeriy", mapCreateFolderCarSeriy);
			//建档客户车型明细汇总
			List<CarSerCount> createFolderCarSeriys = comeShopManageImpl.queryCreateFolderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("createFolderCarSeriys", createFolderCarSeriys);
			String createFolderPieCarSerData = pieCarSerData(createFolderCarSeriys);
			request.setAttribute("createFolderPieCarSerData", createFolderPieCarSerData);
			
			//首次到店客户车型明细
			Map<StaDateNum, List<CarSerCount>> mapComeShopCarSeriy = comeShopManageImpl.queryComeShopCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapComeShopCarSeriy", mapComeShopCarSeriy);
			//首次到店客户车型明细汇总
			List<CarSerCount> comeShopCarSeriys = comeShopManageImpl.queryComeShopCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopCarSeriys",comeShopCarSeriys);
			String comeShopPieCarSerData = pieCarSerData(comeShopCarSeriys);
			request.setAttribute("comeShopPieCarSerData", comeShopPieCarSerData);
			
			//到店客户转订单车型明细
			Map<StaDateNum, List<CarSerCount>> mapComeShopOrderCarSeriy = comeShopManageImpl.queryComeShopOrderCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapComeShopOrderCarSeriy", mapComeShopOrderCarSeriy);
			
			//到店客户转订单车型明细汇总
			List<CarSerCount> comeShopOrderCarSeriyAllList = comeShopManageImpl.queryComeShopOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopOrderCarSeriyAllList",comeShopOrderCarSeriyAllList);
			String comeShopOrderPieCarSerData = pieCarSerData(comeShopOrderCarSeriyAllList);
			request.setAttribute("comeShopOrderPieCarSerData", comeShopOrderPieCarSerData);
			
			//销售顾问-来店客户车型统计
		/*	List<ComeShopUser> comeShopUsers = comeShopManageImpl.queryComeShopUser(beginDate, endDate, enterprise, type, dateType,userType);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopUserCarSeriys = comeShopManageImpl.queryComeShopUserCarSeriy(comeShopUsers, type, enterprise, beginDate, endDate, dateType,userType);
			request.setAttribute("mapComeShopUserCarSeriys", mapComeShopUserCarSeriys);
			ComeShopUser comeShopUserTotal = comeShopManageImpl.queryComeShopUserTotal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopUserTotal", comeShopUserTotal);
			List<CarSerCount> carSerCounts = comeShopManageImpl.queryComeShopUserCarSeriy(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("carSerCounts", carSerCounts);*/
			
			//总销售顾问-来店客户车型统计
		/*	List<ComeShopUser> comeShopUserAlls = comeShopManageImpl.queryComeShopUserAll(beginDate, endDate, enterprise, type, dateType,userType);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopUserCarSeriyAlls = comeShopManageImpl.queryComeShopUserCarSeriyAll(comeShopUserAlls, type, enterprise, beginDate, endDate, dateType,userType);
			request.setAttribute("mapComeShopUserCarSeriyAlls", mapComeShopUserCarSeriyAlls);
			ComeShopUser comeShopUserTotalAll = comeShopManageImpl.queryComeShopUserTotalAll(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopUserTotalAll", comeShopUserTotalAll);
			List<CarSerCount> carSerCountAlls = comeShopManageImpl.queryComeShopUserCarSeriyAll(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("carSerCountAlls", carSerCountAlls);*/
			
			//销售顾问-来店客户转订单车型统计
			List<ComeShopUser> comeShopOrderUsers = comeShopManageImpl.queryComeShopOrderUser(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopOrderUsers", comeShopOrderUsers);
			//销售顾问中来店数据占比
			String comeShopPieUserData = pieUserData(comeShopOrderUsers, 1);
			request.setAttribute("comeShopPieUserData", comeShopPieUserData);
			//销售顾问订单占比
			String comeShopOrderPieUserData = pieUserData(comeShopOrderUsers, 2);
			request.setAttribute("comeShopOrderPieUserData", comeShopOrderPieUserData);
			ComeShopUser comeShopOrderUserAll = comeShopManageImpl.queryComeShopOrderUserAll(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopOrderUserAll",comeShopOrderUserAll);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopOrderUserCarSeriy = comeShopManageImpl.queryComeShopOrderUserCarSeriy(comeShopOrderUsers, type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("mapComeShopOrderUserCarSeriy", mapComeShopOrderUserCarSeriy);
			List<CarSerCount> comeShopOrderUserCarSeriyAll = comeShopManageImpl.queryComeShopOrderUserCarSeriyAll(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("comeShopOrderUserCarSeriyAll", comeShopOrderUserCarSeriyAll);
			
			//新增潜客同比环比数据
			StaYearByYearChain createFolderStaYearByYearChain = comeShopManageImpl.queryCreateFolderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("createFolderStaYearByYearChain", createFolderStaYearByYearChain);
			//首次到店同比/怀比数据
			StaYearByYearChain comeShopStaYearByYearChain = comeShopManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店客户同比/怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = comeShopManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain", twoComeShopStaYearByYearChain);
			//首次进店转订单
			StaYearByYearChain comeShopOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,1);
			request.setAttribute("comeShopOrderStaYearByYearChain", comeShopOrderStaYearByYearChain);
			//二次到店客户同比/怀比数据
			StaYearByYearChain twoComeShopOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,2);
			request.setAttribute("twoComeShopOrderStaYearByYearChain", twoComeShopOrderStaYearByYearChain);
			//到店客户转订单同比/怀比数据
			StaYearByYearChain comeShopTotalOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,3);
			request.setAttribute("comeShopTotalOrderStaYearByYearChain", comeShopTotalOrderStaYearByYearChain);
			
			//客户首次进店率
			StaTryCarYearByYearChainPer createFolderToComeShopYearByYearChainPer = comeShopManageImpl.queryCreateFolderToComeShopYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("createFolderToComeShopYearByYearChainPer",createFolderToComeShopYearByYearChainPer);
			//潜客来店率
			StaTryCarYearByYearChainPer ComeShopYearByYearChainPer = comeShopManageImpl.queryComeShopYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("ComeShopYearByYearChainPer",ComeShopYearByYearChainPer);
			//到店客户转订单率
			StaTryCarYearByYearChainPer comeShopOrderearByYearChainPer = comeShopManageImpl.queryComeShopOrderearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopOrderearByYearChainPer",comeShopOrderearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "comeShopList";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryComeShopYearList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer userType = ParamUtil.getIntParam(request, "userType", 1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
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
			String beginDate=DateUtil.formatPatten(start, "yyyy-MM");
			String endDate=DateUtil.formatPatten(end,"yyyy-MM");
			
			//首次到店综合统计
			List<ComeShop> comeShops = comeShopManageImpl.queryComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShops", comeShops);
			String[] createFolderDayByDay = dayByDayData(request, comeShops, dateType, 1);
			request.setAttribute("dayByDayNumAll",createFolderDayByDay[0]);
			request.setAttribute("createFolderDayByDay",createFolderDayByDay[1]);
			String[] comeShopDayByDay = dayByDayData(request, comeShops, dateType, 2);
			request.setAttribute("comeShopDayByDay",comeShopDayByDay[1]);
			String[] comeShopOrderDayByDay = dayByDayData(request, comeShops, dateType, 3);
			request.setAttribute("comeShopOrderDayByDay",comeShopOrderDayByDay[1]);
			//首次到店综合统计 汇总数据
			ComeShop comeShopTotal = comeShopManageImpl.queryComeShopTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTotal", comeShopTotal);
			
			//个线索来店率
			List<ComeShopType> comeShopTypes = comeShopManageImpl.queryComeShopType(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTypes",comeShopTypes);
			ComeShopType comeShopTypeTotal = comeShopManageImpl.queryComeShopTypeTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopTypeTotal",comeShopTypeTotal);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1 AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			
			//建档客户车型明细
			Map<StaDateNum, List<CarSerCount>> mapCreateFolderCarSeriy = comeShopManageImpl.queryCreateFolderCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapCreateFolderCarSeriy", mapCreateFolderCarSeriy);
			//建档客户车型明细汇总
			List<CarSerCount> createFolderCarSeriys = comeShopManageImpl.queryCreateFolderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("createFolderCarSeriys", createFolderCarSeriys);
			String createFolderPieCarSerData = pieCarSerData(createFolderCarSeriys);
			request.setAttribute("createFolderPieCarSerData", createFolderPieCarSerData);
			
			//首次到店客户车型明细
			Map<StaDateNum, List<CarSerCount>> mapComeShopCarSeriy = comeShopManageImpl.queryComeShopCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapComeShopCarSeriy", mapComeShopCarSeriy);
			//首次到店客户车型明细汇总
			List<CarSerCount> comeShopCarSeriys = comeShopManageImpl.queryComeShopCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopCarSeriys",comeShopCarSeriys);
			String comeShopPieCarSerData = pieCarSerData(comeShopCarSeriys);
			request.setAttribute("comeShopPieCarSerData", comeShopPieCarSerData);
			
			//到店客户转订单车型明细
			Map<StaDateNum, List<CarSerCount>> mapComeShopOrderCarSeriy = comeShopManageImpl.queryComeShopOrderCarSeriy(comeShops, enterprise, type, dateType);
			request.setAttribute("mapComeShopOrderCarSeriy", mapComeShopOrderCarSeriy);
			
			//到店客户转订单车型明细汇总
			List<CarSerCount> comeShopOrderCarSeriyAllList = comeShopManageImpl.queryComeShopOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("comeShopOrderCarSeriyAllList",comeShopOrderCarSeriyAllList);
			String comeShopOrderPieCarSerData = pieCarSerData(comeShopOrderCarSeriyAllList);
			request.setAttribute("comeShopOrderPieCarSerData", comeShopOrderPieCarSerData);
			
			//销售顾问-来店客户车型统计
		/*	List<ComeShopUser> comeShopUsers = comeShopManageImpl.queryComeShopUser(beginDate, endDate, enterprise, type, dateType,userType);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopUserCarSeriys = comeShopManageImpl.queryComeShopUserCarSeriy(comeShopUsers, type, enterprise, beginDate, endDate, dateType,userType);
			request.setAttribute("mapComeShopUserCarSeriys", mapComeShopUserCarSeriys);
			ComeShopUser comeShopUserTotal = comeShopManageImpl.queryComeShopUserTotal(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopUserTotal", comeShopUserTotal);
			List<CarSerCount> carSerCounts = comeShopManageImpl.queryComeShopUserCarSeriy(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("carSerCounts", carSerCounts);
			
			//总销售顾问-来店客户车型统计
			List<ComeShopUser> comeShopUserAlls = comeShopManageImpl.queryComeShopUserAll(beginDate, endDate, enterprise, type, dateType,userType);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopUserCarSeriyAlls = comeShopManageImpl.queryComeShopUserCarSeriyAll(comeShopUserAlls, type, enterprise, beginDate, endDate, dateType,userType);
			request.setAttribute("mapComeShopUserCarSeriyAlls", mapComeShopUserCarSeriyAlls);
			ComeShopUser comeShopUserTotalAll = comeShopManageImpl.queryComeShopUserTotalAll(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopUserTotalAll", comeShopUserTotalAll);
			List<CarSerCount> carSerCountAlls = comeShopManageImpl.queryComeShopUserCarSeriyAll(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("carSerCountAlls", carSerCountAlls);*/
			
			//销售顾问-来店客户转订单车型统计
			List<ComeShopUser> comeShopOrderUsers = comeShopManageImpl.queryComeShopOrderUser(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopOrderUsers", comeShopOrderUsers);
			//销售顾问中来店数据占比
			String comeShopPieUserData = pieUserData(comeShopOrderUsers, 1);
			request.setAttribute("comeShopPieUserData", comeShopPieUserData);
			//销售顾问订单占比
			String comeShopOrderPieUserData = pieUserData(comeShopOrderUsers, 2);
			request.setAttribute("comeShopOrderPieUserData", comeShopOrderPieUserData);
			ComeShopUser comeShopOrderUserAll = comeShopManageImpl.queryComeShopOrderUserAll(beginDate, endDate, enterprise, type, dateType);
			request.setAttribute("comeShopOrderUserAll",comeShopOrderUserAll);
			Map<ComeShopUser, List<CarSerCount>> mapComeShopOrderUserCarSeriy = comeShopManageImpl.queryComeShopOrderUserCarSeriy(comeShopOrderUsers, type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("mapComeShopOrderUserCarSeriy", mapComeShopOrderUserCarSeriy);
			List<CarSerCount> comeShopOrderUserCarSeriyAll = comeShopManageImpl.queryComeShopOrderUserCarSeriyAll(type, enterprise, beginDate, endDate, dateType);
			request.setAttribute("comeShopOrderUserCarSeriyAll", comeShopOrderUserCarSeriyAll);
			
			//新增潜客同比环比数据
			StaYearByYearChain createFolderStaYearByYearChain = comeShopManageImpl.queryCreateFolderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("createFolderStaYearByYearChain", createFolderStaYearByYearChain);
			//首次到店同比/怀比数据
			StaYearByYearChain comeShopStaYearByYearChain = comeShopManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店客户同比/怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = comeShopManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain", twoComeShopStaYearByYearChain);
			//首次进店转订单
			StaYearByYearChain comeShopOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,1);
			request.setAttribute("comeShopOrderStaYearByYearChain", comeShopOrderStaYearByYearChain);
			//二次到店客户同比/怀比数据
			StaYearByYearChain twoComeShopOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,2);
			request.setAttribute("twoComeShopOrderStaYearByYearChain", twoComeShopOrderStaYearByYearChain);
			//到店客户转订单同比/怀比数据
			StaYearByYearChain comeShopTotalOrderStaYearByYearChain = comeShopManageImpl.queryComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null,3);
			request.setAttribute("comeShopTotalOrderStaYearByYearChain", comeShopTotalOrderStaYearByYearChain);
			
			
			//客户首次进店率
			StaTryCarYearByYearChainPer createFolderToComeShopYearByYearChainPer = comeShopManageImpl.queryCreateFolderToComeShopYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("createFolderToComeShopYearByYearChainPer",createFolderToComeShopYearByYearChainPer);
			//潜客来店率
			StaTryCarYearByYearChainPer ComeShopYearByYearChainPer = comeShopManageImpl.queryComeShopYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("ComeShopYearByYearChainPer",ComeShopYearByYearChainPer);
			//到店客户转订单率
			StaTryCarYearByYearChainPer comeShopOrderearByYearChainPer = comeShopManageImpl.queryComeShopOrderearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopOrderearByYearChainPer",comeShopOrderearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			
		}catch(Exception e){
			
		}
		return "comeShopYearList";
	}
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(HttpServletRequest request,List<ComeShop> comeShops,int dateType,int dataType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int keySize = comeShops.size();
			if(dataType==1){
				bufferNum.append("{name:'建档客户',data:[");
			}
			if(dataType==2){
				bufferNum.append("{name:'到店客户',data:[");
			}
			if(dataType==3){
				bufferNum.append("{name:'订单客户',data:[");
			}
			int tempSize=1;
			for (ComeShop comeShop : comeShops) {
				if(null!=comeShop){
					int num=0;
					if(dataType==1){
						num=comeShop.getCreateFolderNum();
					}
					if(dataType==2){
						num=comeShop.getTotalComeShopNum();
					}
					if(dataType==3){
						num=comeShop.getComeShopTotalOrderNum();
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
	private String pieUserData(List<ComeShopUser> comeShopUsers,int dataType) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = comeShopUsers.size();
		ComeShopUser maxCount=comeShopUsers.get(0);
		for (ComeShopUser carSerCount : comeShopUsers) {
			if(dataType==1){
				if(maxCount.getTotalComeShopNum()<carSerCount.getTotalComeShopNum()){
					maxCount=carSerCount;
				}
			}
			if(dataType==2){
				if(maxCount.getComeShopTotalOrderNum()<carSerCount.getComeShopTotalOrderNum()){
					maxCount=carSerCount;
				}
			}
		}
		
		dataBuf.append("[");
		for (ComeShopUser carSerCount : comeShopUsers) {
			int dateNum=0;
			if(dataType==1){
				dateNum=carSerCount.getTotalComeShopNum();
			}
			if(dataType==2){
				dateNum=carSerCount.getComeShopTotalOrderNum();
			}
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getRealName()+"\","
					+"y:"+dateNum);
			if(carSerCount.getRealName().equals(maxCount.getRealName())){
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
