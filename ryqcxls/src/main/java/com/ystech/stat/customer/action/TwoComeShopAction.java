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
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customer.model.TwoComeShop;
import com.ystech.stat.customer.model.TwoComeShopCarSeriy;
import com.ystech.stat.customer.model.TwoComeShopUser;
import com.ystech.stat.customer.service.TwoComeShopManageImpl;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("twoComeShopAction")
@Scope("prototype")
public class TwoComeShopAction extends BaseController {
	private EnterpriseManageImpl enterpriseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private TwoComeShopManageImpl twoComeShopManageImpl;
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
	public void setTwoComeShopManageImpl(TwoComeShopManageImpl twoComeShopManageImpl) {
		this.twoComeShopManageImpl = twoComeShopManageImpl;
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
	public String  queryTwoComeShopList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		//按日查询
		int dateType=1;
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
			List<TwoComeShop> twoComeShops = twoComeShopManageImpl.queryTwoComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShops", twoComeShops);
			String[] dayByDayData = dayByDayData(request, twoComeShops, dateType);
			request.setAttribute("dayByDayAll",dayByDayData[0]);
			request.setAttribute("dayByDayNumAll",dayByDayData[1]);
			
			
			TwoComeShop twoComeShopTotal = twoComeShopManageImpl.queryTwoComeShopTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopTotal", twoComeShopTotal);
			String pieComeShop = pieComeShop(twoComeShopTotal);
			request.setAttribute("pieComeShop", pieComeShop);
			String pieTryCar = pieTryCar(twoComeShopTotal);
			request.setAttribute("pieTryCar", pieTryCar);
			
			
			//二次到店客户车型明细
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			Map<StaDateNum, List<CarSerCount>> map = twoComeShopManageImpl.queryTwoComeShopCarSeriy(twoComeShops, enterprise, dateType,type);
			request.setAttribute("maps", map);
			List<CarSerCount> carSerCounts = twoComeShopManageImpl.queryTwoComeShopCarCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("carSerCounts", carSerCounts);
			String pieCustomerTryCar = pieCarSerData(carSerCounts);
			request.setAttribute("pieCustomerTryCar",pieCustomerTryCar);
			
			//二次到店客户转订单车型明细
			Map<StaDateNum, List<CarSerCount>>  mapTwoComeShopOrders= twoComeShopManageImpl.queryTwoComeShopOrderCarSeriy(twoComeShops, enterprise, dateType,type);
			request.setAttribute("mapTwoComeShopOrders", mapTwoComeShopOrders);
			List<CarSerCount> listTwoComeShopOrders = twoComeShopManageImpl.queryTwoComeShopOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("listTwoComeShopOrders", listTwoComeShopOrders);
			String pieCustomerTryCarOrder = pieCarSerData(listTwoComeShopOrders);
			request.setAttribute("pieCustomerTryCarOrder",pieCustomerTryCarOrder);
			//试乘试驾车型数据统计
			List<TwoComeShopCarSeriy> twoComeShopCarSeriys = twoComeShopManageImpl.queryCarSeriyTwoComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopCarSeriys", twoComeShopCarSeriys);
			
			//销售顾问试乘试驾数据
			List<TwoComeShopUser> twoComeShopUsers = twoComeShopManageImpl.queryTwoComeShopUser(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopUsers", twoComeShopUsers);
			
			//首次到店同比环比数据
			StaYearByYearChain comeShopStaYearByYearChain = twoComeShopManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店同比怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = twoComeShopManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain",twoComeShopStaYearByYearChain);
			
			//二次订单同比怀比数据
			StaYearByYearChain tryCarOrderStaYearByYearChain = twoComeShopManageImpl.queryTwoComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaYearByYearChain", tryCarOrderStaYearByYearChain);
			
			//试乘试驾客户转订单率同比环比
			StaTryCarYearByYearChainPer tryCarOrderStaTryCarYearByYearChainPer = twoComeShopManageImpl.queryTryCarOrderStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaTryCarYearByYearChainPer", tryCarOrderStaTryCarYearByYearChainPer);
			//试乘试驾率同比环比
			StaTryCarYearByYearChainPer staTryCarYearByYearChainPer = twoComeShopManageImpl.queryTryCarStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("staTryCarYearByYearChainPer", staTryCarYearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "错误信息："+e.getMessage());
			return "error";
		}
		return "twoComeShopList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String  queryTwoComeShopYearList() {
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
			//获取来店试乘试驾综合统计
			//获取来店试乘试驾综合统计
			List<TwoComeShop> twoComeShops = twoComeShopManageImpl.queryTwoComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShops", twoComeShops);
			String[] dayByDayData = dayByDayData(request, twoComeShops, dateType);
			request.setAttribute("dayByDayAll",dayByDayData[0]);
			request.setAttribute("dayByDayNumAll",dayByDayData[1]);
			
			
			TwoComeShop twoComeShopTotal = twoComeShopManageImpl.queryTwoComeShopTotal(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopTotal", twoComeShopTotal);
			String pieComeShop = pieComeShop(twoComeShopTotal);
			request.setAttribute("pieComeShop", pieComeShop);
			String pieTryCar = pieTryCar(twoComeShopTotal);
			request.setAttribute("pieTryCar", pieTryCar);
			
			
			//二次到店客户车型明细
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			request.setAttribute("carSeriys",carSeriys);
			Map<StaDateNum, List<CarSerCount>> map = twoComeShopManageImpl.queryTwoComeShopCarSeriy(twoComeShops, enterprise, dateType,type);
			request.setAttribute("maps", map);
			List<CarSerCount> carSerCounts = twoComeShopManageImpl.queryTwoComeShopCarCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("carSerCounts", carSerCounts);
			String pieCustomerTryCar = pieCarSerData(carSerCounts);
			request.setAttribute("pieCustomerTryCar",pieCustomerTryCar);
			
			//二次到店客户转订单车型明细
			Map<StaDateNum, List<CarSerCount>>  mapTwoComeShopOrders= twoComeShopManageImpl.queryTwoComeShopOrderCarSeriy(twoComeShops, enterprise, dateType,type);
			request.setAttribute("mapTwoComeShopOrders", mapTwoComeShopOrders);
			List<CarSerCount> listTwoComeShopOrders = twoComeShopManageImpl.queryTwoComeShopOrderCarSeriyAll(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("listTwoComeShopOrders", listTwoComeShopOrders);
			String pieCustomerTryCarOrder = pieCarSerData(listTwoComeShopOrders);
			request.setAttribute("pieCustomerTryCarOrder",pieCustomerTryCarOrder);
			//试乘试驾车型数据统计
			List<TwoComeShopCarSeriy> twoComeShopCarSeriys = twoComeShopManageImpl.queryCarSeriyTwoComeShop(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopCarSeriys", twoComeShopCarSeriys);
			
			//销售顾问试乘试驾数据
			List<TwoComeShopUser> twoComeShopUsers = twoComeShopManageImpl.queryTwoComeShopUser(beginDate, endDate, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopUsers", twoComeShopUsers);
			
			//首次到店同比环比数据
			StaYearByYearChain comeShopStaYearByYearChain = twoComeShopManageImpl.queryComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("comeShopStaYearByYearChain", comeShopStaYearByYearChain);
			//二次到店同比怀比数据
			StaYearByYearChain twoComeShopStaYearByYearChain = twoComeShopManageImpl.queryTwoComeShopStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("twoComeShopStaYearByYearChain",twoComeShopStaYearByYearChain);
			
			//二次订单同比怀比数据
			StaYearByYearChain tryCarOrderStaYearByYearChain = twoComeShopManageImpl.queryTwoComeShopOrderStaYearByYearChain(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaYearByYearChain", tryCarOrderStaYearByYearChain);
			
			//试乘试驾客户转订单率同比环比
			StaTryCarYearByYearChainPer tryCarOrderStaTryCarYearByYearChainPer = twoComeShopManageImpl.queryTryCarOrderStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("tryCarOrderStaTryCarYearByYearChainPer", tryCarOrderStaTryCarYearByYearChainPer);
			//试乘试驾率同比环比
			StaTryCarYearByYearChainPer staTryCarYearByYearChainPer = twoComeShopManageImpl.queryTryCarStaTryCarYearByYearChainPer(start, type, enterprise, dateType, null);
			request.setAttribute("staTryCarYearByYearChainPer", staTryCarYearByYearChainPer);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "错误信息："+e.getMessage());
			return "error";
		}
		return "twoComeShopYearList";
	}
	/**
	 * 功能描述：每日/月数据趋势图
	 * @param request
	 * @param statCustomerRecordTimes
	 */
	private String[] dayByDayData(HttpServletRequest request,List<TwoComeShop> twoComeShops,int dateType) {
			StringBuffer dayByDay=new StringBuffer();
			StringBuffer bufferNum=new StringBuffer();
			bufferNum.append("[");
			int j=0;
			int keySize = twoComeShops.size();
			bufferNum.append("{name:'来店客户',data:[");
			int tempSize=1;
			for (TwoComeShop twoComeShop : twoComeShops) {
				if(null!=twoComeShop){
					bufferNum.append(twoComeShop.getTotalNum());
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
			for (StaDateNum staCustomerRecordDateNum : twoComeShops) {
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
	private String pieComeShop(TwoComeShop queryStaTryCarTotal){
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
	private String pieTryCar(TwoComeShop queryStaTryCarTotal){
		StringBuffer dataBuff=new StringBuffer();
		Integer twoComeShopOrderNum=0;
		Integer twoComeShopNotNum=0;
		if(null!=queryStaTryCarTotal){
			twoComeShopOrderNum=queryStaTryCarTotal.getTwoComeShopOrderNum();
			twoComeShopNotNum=queryStaTryCarTotal.getTwoComeShopNum()-queryStaTryCarTotal.getTwoComeShopOrderNum();
		}
		dataBuff.append("[");
		dataBuff.append("{"
				+ "name:\"已成交\","
				+"y:"+twoComeShopOrderNum);
		dataBuff.append(",sliced: true,selected: true");
		dataBuff.append("}");
		dataBuff.append(",");
		dataBuff.append("{"
				+ "name:\"未成交\","
				+"y:"+twoComeShopNotNum);
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
		if(carSerCountTotals.isEmpty()){
			dataBuf.append("[");
			dataBuf.append("]");
			return dataBuf.toString();
		}
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
}
