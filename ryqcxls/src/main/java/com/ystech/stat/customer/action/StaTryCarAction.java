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
import com.ystech.stat.customer.model.StaCarSeriyTryCar;
import com.ystech.stat.customer.model.StaTryCar;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customer.model.StaUserTryCar;
import com.ystech.stat.customer.service.TryCarManageImpl;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("staTryCarAction")
@Scope("prototype")
public class StaTryCarAction extends BaseController {
	private EnterpriseManageImpl enterpriseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private TryCarManageImpl tryCarManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setTryCarManageImpl(TryCarManageImpl tryCarManageImpl) {
		this.tryCarManageImpl = tryCarManageImpl;
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
	public String  queryTryCarList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
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
			
			//获取来店试乘试驾综合统计
			List<StaTryCar> staTryCars = tryCarManageImpl.queryStaTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staTryCars", staTryCars);
			String[] dayByDayData = dayByDayData(request, staTryCars, dateType);
			request.setAttribute("dayByDayAll",dayByDayData[0]);
			request.setAttribute("dayByDayNumAll",dayByDayData[1]);
			
			
			StaTryCar queryStaTryCarTotal = tryCarManageImpl.queryStaTryCarTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("queryStaTryCarTotal", queryStaTryCarTotal);
			String pieComeShop = pieComeShop(queryStaTryCarTotal);
			request.setAttribute("pieComeShop", pieComeShop);
			String pieTryCar = pieTryCar(queryStaTryCarTotal);
			request.setAttribute("pieTryCar", pieTryCar);
			
			
			//来店试乘试驾客户明细
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where 1=1 AND tryCarStatus=? AND status=? AND enterpriseId=?", new Object[]{1,1,enterprise.getDbid()});
			request.setAttribute("carSeriys",carSeriys);
			Map<StaDateNum, List<CarSerCount>> map = tryCarManageImpl.queryTryCarCarSeriy(staTryCars, enterprise, dateType,type);
			request.setAttribute("maps", map);
			List<CarSerCount> carSerCounts = tryCarManageImpl.queryTryCarCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("carSerCounts", carSerCounts);
			String pieCustomerTryCar = pieCarSerData(carSerCounts);
			request.setAttribute("pieCustomerTryCar",pieCustomerTryCar);
			
			//获取试乘试驾客户订单明细
			Map<StaDateNum, List<CarSerCount>>  mapTryCarOrders= tryCarManageImpl.queryTryCarOrderCarSeriy(staTryCars, enterprise, dateType,type);
			request.setAttribute("mapTryCarOrders", mapTryCarOrders);
			List<CarSerCount> listTryCarOrders = tryCarManageImpl.queryTryCarOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("listTryCarOrders", listTryCarOrders);
			String pieCustomerTryCarOrder = pieCarSerData(listTryCarOrders);
			request.setAttribute("pieCustomerTryCarOrder",pieCustomerTryCarOrder);
			//试乘试驾车型数据统计
			List<StaCarSeriyTryCar> staCarSeriyTryCars = tryCarManageImpl.queryCarSeriyTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staCarSeriyTryCars", staCarSeriyTryCars);
			
			//销售顾问试乘试驾数据
			List<StaUserTryCar> staUserTryCars = tryCarManageImpl.queryUserTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staUserTryCars", staUserTryCars);
			
			String pieUserTryCarOderData = pieUserTryCarOderData(staUserTryCars);
			request.setAttribute("pieUserTryCarOderData", pieUserTryCarOderData);
			String pieUserTryCarData = pieUserTryCarData(staUserTryCars);
			request.setAttribute("pieUserTryCarData", pieUserTryCarData);
			
			//首次到店同比环比数据
			StaYearByYearChain comeShopStaYearByYearChain = tryCarManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店同比怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = tryCarManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain",twoComeShopStaYearByYearChain);
			
			//到店试乘试驾同比怀比数据
			StaYearByYearChain tryCarStaYearByYearChain = tryCarManageImpl.queryTryCarStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarStaYearByYearChain", tryCarStaYearByYearChain);
			
			//试乘试驾订单同比怀比数据
			StaYearByYearChain tryCarOrderStaYearByYearChain = tryCarManageImpl.queryTryCarOrderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaYearByYearChain", tryCarOrderStaYearByYearChain);
			
			//试乘试驾客户转订单率同比环比
			StaTryCarYearByYearChainPer tryCarOrderStaTryCarYearByYearChainPer = tryCarManageImpl.queryTryCarOrderStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaTryCarYearByYearChainPer", tryCarOrderStaTryCarYearByYearChainPer);
			//试乘试驾率同比环比
			StaTryCarYearByYearChainPer staTryCarYearByYearChainPer = tryCarManageImpl.queryTryCarStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("staTryCarYearByYearChainPer", staTryCarYearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "错误信息："+e.getMessage());
			return "error";
		}
		return "tryCarList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String  queryTryCarYearList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
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
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
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
			//获取来店试乘试驾综合统计
			List<StaTryCar> staTryCars = tryCarManageImpl.queryStaTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staTryCars", staTryCars);
			String[] dayByDayData = dayByDayData(request, staTryCars, dateType);
			request.setAttribute("dayByDayAll",dayByDayData[0]);
			request.setAttribute("dayByDayNumAll",dayByDayData[1]);
			
			
			StaTryCar queryStaTryCarTotal = tryCarManageImpl.queryStaTryCarTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("queryStaTryCarTotal", queryStaTryCarTotal);
			String pieComeShop = pieComeShop(queryStaTryCarTotal);
			request.setAttribute("pieComeShop", pieComeShop);
			String pieTryCar = pieTryCar(queryStaTryCarTotal);
			request.setAttribute("pieTryCar", pieTryCar);
			
			
			//来店试乘试驾客户明细
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where 1=1 AND tryCarStatus=? AND status=? AND enterpriseId=?", new Object[]{1,1,enterprise.getDbid()});
			request.setAttribute("carSeriys",carSeriys);
			Map<StaDateNum, List<CarSerCount>> map = tryCarManageImpl.queryTryCarCarSeriy(staTryCars, enterprise, dateType,type);
			request.setAttribute("maps", map);
			List<CarSerCount> carSerCounts = tryCarManageImpl.queryTryCarCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("carSerCounts", carSerCounts);
			String pieCustomerTryCar = pieCarSerData(carSerCounts);
			request.setAttribute("pieCustomerTryCar",pieCustomerTryCar);
			
			//获取试乘试驾客户订单明细
			Map<StaDateNum, List<CarSerCount>>  mapTryCarOrders= tryCarManageImpl.queryTryCarOrderCarSeriy(staTryCars, enterprise, dateType,type);
			request.setAttribute("mapTryCarOrders", mapTryCarOrders);
			List<CarSerCount> listTryCarOrders = tryCarManageImpl.queryTryCarOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("listTryCarOrders", listTryCarOrders);
			String pieCustomerTryCarOrder = pieCarSerData(listTryCarOrders);
			request.setAttribute("pieCustomerTryCarOrder",pieCustomerTryCarOrder);
			//试乘试驾车型数据统计
			List<StaCarSeriyTryCar> staCarSeriyTryCars = tryCarManageImpl.queryCarSeriyTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staCarSeriyTryCars", staCarSeriyTryCars);
			
			//销售顾问试乘试驾数据
			List<StaUserTryCar> staUserTryCars = tryCarManageImpl.queryUserTryCar(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("staUserTryCars", staUserTryCars);
			String pieUserTryCarOderData = pieUserTryCarOderData(staUserTryCars);
			request.setAttribute("pieUserTryCarOderData", pieUserTryCarOderData);
			String pieUserTryCarData = pieUserTryCarData(staUserTryCars);
			request.setAttribute("pieUserTryCarData", pieUserTryCarData);
			//首次到店同比环比数据
			StaYearByYearChain comeShopStaYearByYearChain = tryCarManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店同比怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = tryCarManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain",twoComeShopStaYearByYearChain);
			
			//到店试乘试驾同比怀比数据
			StaYearByYearChain tryCarStaYearByYearChain = tryCarManageImpl.queryTryCarStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarStaYearByYearChain", tryCarStaYearByYearChain);
			
			//试乘试驾订单同比怀比数据
			StaYearByYearChain tryCarOrderStaYearByYearChain = tryCarManageImpl.queryTryCarOrderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaYearByYearChain", tryCarOrderStaYearByYearChain);
			
			//试乘试驾客户转订单率同比环比
			StaTryCarYearByYearChainPer tryCarOrderStaTryCarYearByYearChainPer = tryCarManageImpl.queryTryCarOrderStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaTryCarYearByYearChainPer", tryCarOrderStaTryCarYearByYearChainPer);
			//试乘试驾率同比环比
			StaTryCarYearByYearChainPer staTryCarYearByYearChainPer = tryCarManageImpl.queryTryCarStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("staTryCarYearByYearChainPer", staTryCarYearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "错误信息："+e.getMessage());
			return "error";
		}
		return "tryCarYearList";
	}
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(HttpServletRequest request,List<StaTryCar> staTryCars,int dateType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int keySize = staTryCars.size();
			bufferNum.append("{name:'来店客户',data:[");
			int tempSize=1;
			for (StaTryCar staTryCar : staTryCars) {
				if(null!=staTryCar){
					bufferNum.append(staTryCar.getTotalNum());
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
			for (StaDateNum staCustomerRecordDateNum : staTryCars) {
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
	 * 功能描述：客户来店饼图
	 * @param queryStaTryCarTotal
	 * @return
	 */
	private String pieComeShop(StaTryCar queryStaTryCarTotal){
		StringBuffer dataBuff=new StringBuffer();
		Integer comeShop=0;
		Integer twoComeShopNum=0;
		if(null!=queryStaTryCarTotal){
			comeShop=queryStaTryCarTotal.getComeShopNum();
			twoComeShopNum=queryStaTryCarTotal.getTwoComeShopNum();
		}
		dataBuff.append("[");
		dataBuff.append("{"
				+ "name:\"首次到店\","
				+"y:"+comeShop);
		dataBuff.append(",sliced: true,selected: true");
		dataBuff.append("}");
		dataBuff.append(",");
		dataBuff.append("{"
				+ "name:\"二次到店\","
				+"y:"+twoComeShopNum);
		dataBuff.append("}");
		dataBuff.append("]");
		return dataBuff.toString();
	}
	/**
	 * 功能描述：客户来店饼图
	 * @param queryStaTryCarTotal
	 * @return
	 */
	private String pieTryCar(StaTryCar queryStaTryCarTotal){
		StringBuffer dataBuff=new StringBuffer();
		Integer tryCarNum=0;
		Integer tryCarNotNum=0;
		if(null!=queryStaTryCarTotal){
			tryCarNum=queryStaTryCarTotal.getTryCarNum();
			tryCarNotNum=queryStaTryCarTotal.getTotalNum()-queryStaTryCarTotal.getTryCarNum();
		}
		dataBuff.append("[");
		dataBuff.append("{"
				+ "name:\"已经试驾\","
				+"y:"+tryCarNum);
		dataBuff.append(",sliced: true,selected: true");
		dataBuff.append("}");
		dataBuff.append(",");
		dataBuff.append("{"
				+ "name:\"未试驾\","
				+"y:"+tryCarNotNum);
		dataBuff.append("}");
		dataBuff.append("]");
		return dataBuff.toString();
	}
	/**
	 * 功能描述：车型柱状图统计
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
	 * 功能描述：销售顾问试乘试驾客户占比
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieUserTryCarData(List<StaUserTryCar> staUserTryCars) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		if(null==staUserTryCars||staUserTryCars.isEmpty()){
			dataBuf.append("[]");
			return dataBuf.toString();
		}
		int size = staUserTryCars.size();
		StaUserTryCar maxCount=staUserTryCars.get(0);
		for (StaUserTryCar carSerCount : staUserTryCars) {
			if(maxCount.getTryCarNum()<carSerCount.getTryCarNum()){
				maxCount=carSerCount;
			}
		}
		dataBuf.append("[");
		for (StaUserTryCar carSerCount : staUserTryCars) {
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getUserName()+"\","
					+"y:"+carSerCount.getTryCarNum());
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
	 * 功能描述：销售顾问试乘试驾转订单占比
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String pieUserTryCarOderData(List<StaUserTryCar> staUserTryCars) {
		StringBuffer dataBuf=new StringBuffer();
		int i=0;
		int size = staUserTryCars.size();
		if(null==staUserTryCars||staUserTryCars.isEmpty()){
			dataBuf.append("[");
			dataBuf.append("]");
			return dataBuf.toString();
		}
		StaUserTryCar maxCount=staUserTryCars.get(0);
		for (StaUserTryCar carSerCount : staUserTryCars) {
			if(maxCount.getTryCarOrderNum()<carSerCount.getTryCarOrderNum()){
				maxCount=carSerCount;
			}
		}
		dataBuf.append("[");
		for (StaUserTryCar carSerCount : staUserTryCars) {
			i++;
			dataBuf.append("{"
					+ "name:\""+carSerCount.getUserName()+"\","
					+"y:"+carSerCount.getTryCarOrderNum());
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
}
