package com.ystech.stat.action;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DataFormatUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.stat.model.StaCustComp;
import com.ystech.stat.service.StaCustCompManageImpl;

@Component("staCustCompAction")
@Scope("prototype")
public class StaCustCompAction extends BaseController{
	private StaCustCompManageImpl staCustCompManageImpl;
	@Resource
	public void setStaCustCompManageImpl(StaCustCompManageImpl staCustCompManageImpl) {
		this.staCustCompManageImpl = staCustCompManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryEntList(){
		HttpServletRequest request = getRequest();
		try {
			List<StaCustComp> staCustComps = staCustCompManageImpl.queryEntStaCustComp(null,null);
			request.setAttribute("staCustComps", staCustComps);
			
			Map<Integer, StaCustComp> map = staCustCompManageImpl.queryAllYear();
			Set<Integer> keySet = map.keySet();
			request.setAttribute("keySet", keySet);
			
			//集客统计
			String[] customerStr = getCustomerStr(map);
			request.setAttribute("customerStr", customerStr[0]);
			request.setAttribute("customerMonthData", customerStr[1]);
			
			
			//到店率统计
			String[] comeShopCustomerStr = getComeShopCustomerStr(map);
			request.setAttribute("comeShopCustomerStr", comeShopCustomerStr[0]);
			request.setAttribute("comeShopData", comeShopCustomerStr[1]);
			request.setAttribute("comeShopPer", comeShopCustomerStr[2]);
			//到店客户成交率
			String[] comeShopSuccessCustomerStr = getComeShopSuccessCustomerStr(map);
			request.setAttribute("comeShopSuccessCustomerStr", comeShopSuccessCustomerStr[0]);
			request.setAttribute("comeShopSuccessData", comeShopSuccessCustomerStr[1]);
			request.setAttribute("comeShopSuccessPer", comeShopSuccessCustomerStr[2]);
			
			//二次到店率统计
			String[] twoComeShopCustomerStr = getTwoComeShopCustomerStr(map);
			request.setAttribute("twoComeShopCustomerStr", twoComeShopCustomerStr[0]);
			request.setAttribute("twoComeShopData", twoComeShopCustomerStr[1]);
			request.setAttribute("twoComeShopPer", twoComeShopCustomerStr[2]);
			//二次到店客户成交率
			String[] twocomeShopSuccessCustomerStr = getTwoComeShopSuccessCustomerStr(map);
			request.setAttribute("twoComeShopSuccessCustomerStr", twocomeShopSuccessCustomerStr[0]);
			request.setAttribute("twoComeShopSuccessData", twocomeShopSuccessCustomerStr[1]);
			request.setAttribute("twoComeShopSuccessPer", twocomeShopSuccessCustomerStr[2]);
			
			//试乘试驾统计
			String[] tryCarCustomerStr = getTryCarCustomerStr(map);
			request.setAttribute("tryCarCustomerStr", tryCarCustomerStr[0]);
			request.setAttribute("tryCarCustomerData", tryCarCustomerStr[1]);
			request.setAttribute("tryCarCustomerPer", tryCarCustomerStr[2]);
			//试乘试驾成交统计
			String[] tryCarSuccessCustomerStr = getTryCarSuccessCustomerStr(map);
			request.setAttribute("tryCarSuccessCustomerStr", tryCarSuccessCustomerStr[0]);
			request.setAttribute("tryCarSuccessCustomerData", tryCarSuccessCustomerStr[1]);
			request.setAttribute("tryCarSuccessCustomerPer", tryCarSuccessCustomerStr[2]);
			
			//客户成交统计
			String[] customerSuccessStr = getCustomerSuccessStr(map);
			request.setAttribute("customerSuccessStr", customerSuccessStr[0]);
			request.setAttribute("customerSuccessMonthData", customerSuccessStr[1]);
			request.setAttribute("customerSuccessMonthPer", customerSuccessStr[2]);
			
			//回访数据统计
			String[] trackCustomerStr = getTrackCustomerStr(map);
			request.setAttribute("trackCustomerStr", trackCustomerStr[0]);
			request.setAttribute("trackCustomerData", trackCustomerStr[1]);
			request.setAttribute("trackSuccessPer", trackCustomerStr[2]);
			
			//客户流失统计
			String[] customerFlowStr = getCustomerFlowStr(map);
			request.setAttribute("customerFlowStr", customerFlowStr[0]);
			request.setAttribute("customerFlowMonthData", customerFlowStr[1]);
			request.setAttribute("customerFlowMonthPer", customerFlowStr[2]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "entList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryDepList() {
		HttpServletRequest request = getRequest();
		Integer entId = ParamUtil.getIntParam(request, "entId", -1);
		try {
			List<StaCustComp> staCustComps = staCustCompManageImpl.queryDepStaCustComp(entId,null,null);
			request.setAttribute("staCustComps", staCustComps);
			
			Map<Integer, StaCustComp> map = staCustCompManageImpl.queryAllYearByEntId(entId);
			Set<Integer> keySet = map.keySet();
			request.setAttribute("keySet", keySet);
			
			//集客统计
			String[] customerStr = getCustomerStr(map);
			request.setAttribute("customerStr", customerStr[0]);
			request.setAttribute("customerData", customerStr[1]);
			request.setAttribute("flowSuccessPer", customerStr[2]);
			request.setAttribute("monthData", customerStr[3]);
			
			//试乘试驾统计
			String[] tryCarCustomerStr = getTryCarCustomerStr(map);
			request.setAttribute("tryCarCustomerStr", tryCarCustomerStr[0]);
			request.setAttribute("tryCarCustomerData", tryCarCustomerStr[1]);
			request.setAttribute("tryCarSuccessPer", tryCarCustomerStr[2]);
			//到店率统计
			String[] comeShopCustomerStr = getComeShopCustomerStr(map);
			request.setAttribute("comeShopCustomerStr", comeShopCustomerStr[0]);
			request.setAttribute("comeShopCustomerData", comeShopCustomerStr[1]);
			request.setAttribute("comeShopSuccessPer", comeShopCustomerStr[2]);
			
			//回访数据统计
			String[] trackCustomerStr = getTrackCustomerStr(map);
			request.setAttribute("trackCustomerStr", trackCustomerStr[0]);
			request.setAttribute("trackCustomerData", trackCustomerStr[1]);
			request.setAttribute("trackSuccessPer", trackCustomerStr[2]);
		} catch (Exception e) {
		}
		return "depList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryUserList() {
		HttpServletRequest request = getRequest();
		Integer entId = ParamUtil.getIntParam(request, "entId", -1);
		Integer depId = ParamUtil.getIntParam(request, "depId", -1);
		try {
			List<StaCustComp> staCustComps = staCustCompManageImpl.queryUserStaCustComp(entId, depId,null,null);
			request.setAttribute("staCustComps", staCustComps);
			
			Map<Integer, StaCustComp> map = staCustCompManageImpl.queryAllYearByDepId(depId);
			Set<Integer> keySet = map.keySet();
			request.setAttribute("keySet", keySet);
			
			//集客统计
			String[] customerStr = getCustomerStr(map);
			request.setAttribute("customerStr", customerStr[0]);
			request.setAttribute("customerData", customerStr[1]);
			request.setAttribute("flowSuccessPer", customerStr[2]);
			request.setAttribute("monthData", customerStr[3]);
			
			//试乘试驾统计
			String[] tryCarCustomerStr = getTryCarCustomerStr(map);
			request.setAttribute("tryCarCustomerStr", tryCarCustomerStr[0]);
			request.setAttribute("tryCarCustomerData", tryCarCustomerStr[1]);
			request.setAttribute("tryCarSuccessPer", tryCarCustomerStr[2]);
			//到店率统计
			String[] comeShopCustomerStr = getComeShopCustomerStr(map);
			request.setAttribute("comeShopCustomerStr", comeShopCustomerStr[0]);
			request.setAttribute("comeShopCustomerData", comeShopCustomerStr[1]);
			request.setAttribute("comeShopSuccessPer", comeShopCustomerStr[2]);
			
			//回访数据统计
			String[] trackCustomerStr = getTrackCustomerStr(map);
			request.setAttribute("trackCustomerStr", trackCustomerStr[0]);
			request.setAttribute("trackCustomerData", trackCustomerStr[1]);
			request.setAttribute("trackSuccessPer", trackCustomerStr[2]);
		} catch (Exception e) {
		}
		return "userList";
	}
	
	/**
	 * 功能描述：集客统计，
	 * 统计项目包括：每月总潜客，每月新增潜客，每月留存潜客
	 * @return
	 */
	private String[] getCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[2];
		StringBuffer valueStr1=new StringBuffer();
		StringBuffer monthRecordNumStr=new StringBuffer();
		StringBuffer overplusRecordNumStr=new StringBuffer();
		
		StringBuffer valueJson1=new StringBuffer();
		StringBuffer monthRecordNumJsonStr=new StringBuffer();
		StringBuffer overplusRecordNumJsonStr=new StringBuffer();
		
		valueStr1.append("<tr><td style='font-size:14px;style='font-weight: bold;''>总集客</td>");
		monthRecordNumStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>新增集客</td>");
		overplusRecordNumStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>留存集客</td>");
		
		valueJson1.append("[{name: '总集客',data: [");
		monthRecordNumJsonStr.append("[{name: '新增集客',data: [");
		overplusRecordNumJsonStr.append(",{name: '留存集客',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				valueStr1.append("<td>"+staCustComp.getRecordNum()+"</td>");
				monthRecordNumStr.append("<td>"+staCustComp.getRecordMonthNum()+"</td>");
				overplusRecordNumStr.append("<td>"+staCustComp.getRecordOverplusNum()+"</td>");
				
				if(i==keySet.size()){
					valueJson1.append(staCustComp.getRecordNum());
					monthRecordNumJsonStr.append(staCustComp.getRecordMonthNum());
					overplusRecordNumJsonStr.append(staCustComp.getRecordOverplusNum());
				}else{
					valueJson1.append(staCustComp.getRecordNum()+",");
					monthRecordNumJsonStr.append(staCustComp.getRecordMonthNum()+",");
					overplusRecordNumJsonStr.append(staCustComp.getRecordOverplusNum()+",");
				}
			}else{
				valueStr1.append("<td>0</td>");
				monthRecordNumStr.append("<td>0.00</td>");
				overplusRecordNumStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					valueJson1.append(0);
					monthRecordNumJsonStr.append(0);
					overplusRecordNumJsonStr.append(0);
					
				}else{
					valueJson1.append(0+",");
					monthRecordNumJsonStr.append(0+",");
					overplusRecordNumJsonStr.append(0+",");
				}
			}
			i++;
		}
		valueStr1.append("</tr>");
		monthRecordNumStr.append("</tr>");
		overplusRecordNumStr.append("</tr>");
		String value=valueStr1.toString()+monthRecordNumStr.toString()+overplusRecordNumStr.toString();
		valueJson1.append("]}");
		monthRecordNumJsonStr.append("]}");
		overplusRecordNumJsonStr.append("]}");
		
		String monthData=monthRecordNumJsonStr.toString()+overplusRecordNumJsonStr.toString()+"]";
		str[0]=value;
		str[1]=monthData;
		
		return str;
	}
	/**
	 * 客户流失统计：
	 * 统计项目：总流失客户，每月流失客户
	 * @param map
	 * @return
	 */
	private String[] getCustomerFlowStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer valueStr2=new StringBuffer();
		StringBuffer valueStr3=new StringBuffer();
		StringBuffer monthFLowNumStr=new StringBuffer();
		
		StringBuffer monthFLowNumJsonStr=new StringBuffer();
		
		StringBuffer avaflowPer=new StringBuffer();
		StringBuffer monthflowPer=new StringBuffer();
		
		valueStr2.append("<tr><td style='font-size:14px;style='font-weight: bold;''>总流失客户</td>");
		monthFLowNumStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>流失客户</td>");
		valueStr3.append("<tr><td style='font-size:14px;style='font-weight: bold;''>流失率</td>");
		
		monthFLowNumJsonStr.append("[{name: '每月流失客户',data: [");
		
		avaflowPer.append("[{name: '平均流失率',data: [");
		monthflowPer.append(",{name: '月流失率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float flowValue=Float.valueOf(0);
				if(null!=staCustComp.getFlowPer()){
					flowValue=DataFormatUtil.formatFloat(staCustComp.getFlowPer()*100);
				}
				float monthflowValue=Float.valueOf(0);
				if(null!=staCustComp.getFlowMonthPer()){
					System.out.println("=="+staCustComp.getFlowMonthPer());
					monthflowValue=DataFormatUtil.formatFloat(staCustComp.getFlowMonthPer()*100);
				}
				valueStr2.append("<td>"+staCustComp.getFlowNum()+"</td>");
				valueStr3.append("<td>"+flowValue+"</td>");
				monthFLowNumStr.append("<td>"+staCustComp.getFlowMonthNum()+"</td>");
				
				if(i==keySet.size()){
					monthFLowNumJsonStr.append(staCustComp.getFlowMonthNum());
					avaflowPer.append(flowValue);
					monthflowPer.append(monthflowValue);
				}else{
					monthFLowNumJsonStr.append(staCustComp.getFlowMonthNum()+",");
					avaflowPer.append(flowValue+",");
					monthflowPer.append(monthflowValue+",");
				}
			}else{
				valueStr2.append("<td>0</td>");
				valueStr3.append("<td>0.00</td>");
				monthFLowNumStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					monthFLowNumJsonStr.append(0);
					avaflowPer.append(0);
					monthflowPer.append(0);
					
				}else{
					monthFLowNumJsonStr.append(0+",");
					avaflowPer.append(0+",");
					monthflowPer.append(0+",");
				}
			}
			i++;
		}
		valueStr2.append("</tr>");
		valueStr3.append("</tr>");
		monthFLowNumStr.append("</tr>");
		String value=valueStr2.toString()+monthFLowNumStr.toString()+valueStr3.toString();
		monthFLowNumJsonStr.append("]}");
		avaflowPer.append("]}");
		monthflowPer.append("]}");
		String flowSucessPer=avaflowPer.toString()+monthflowPer.toString()+"]";
		String monthFLowNumValue=monthFLowNumJsonStr.toString()+"]";
		str[0]=value;
		str[1]=monthFLowNumValue;
		str[2]=flowSucessPer;
		return str;
	}
	/**
	 * 功能描述：成交客户统计
	 * 统计项目：总成交客户、每月新增成交客户、每月成交率
	 * @return
	 */
	private String[] getCustomerSuccessStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer totalSuccessStr=new StringBuffer();
		StringBuffer successPerStr=new StringBuffer();
		StringBuffer successMonthStr=new StringBuffer();
		
		StringBuffer monthSuccess=new StringBuffer();
		
		StringBuffer avgSuccessPer=new StringBuffer();
		StringBuffer monthSuccessPer=new StringBuffer();
		
		totalSuccessStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>总成交客户</td>");
		successMonthStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>月交客户</td>");
		successPerStr.append("<tr><td style='font-size:14px;style='font-weight: bold;''>成交率</td>");
		
		monthSuccess.append("[{name: '月成交客户',data: [");
		avgSuccessPer.append("[{name: '平均成交率',data: [");
		monthSuccessPer.append(",{name: '月成交率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float successValue=Float.valueOf(0);
				if(null!=staCustComp.getCustomerSuccessPer()){
					successValue=DataFormatUtil.formatFloat(staCustComp.getCustomerSuccessPer()*100);
				}
				float monthSuccessValue=Float.valueOf(0);
				if(null!=staCustComp.getCustomerMonthSuccessPer()){
					monthSuccessValue=DataFormatUtil.formatFloat(staCustComp.getCustomerMonthSuccessPer()*100);
				}
				totalSuccessStr.append("<td>"+staCustComp.getCustomerSuccessNum()+"</td>");
				successMonthStr.append("<td>"+staCustComp.getCustomerMonthSuccessNum()+"</td>");
				successPerStr.append("<td>"+successValue+"</td>");
				
				if(i==keySet.size()){
					monthSuccess.append(staCustComp.getCustomerMonthSuccessNum());
					avgSuccessPer.append(successValue);
					monthSuccessPer.append(monthSuccessValue);
				}else{
					monthSuccess.append(staCustComp.getCustomerMonthSuccessNum()+",");
					avgSuccessPer.append(successValue+",");
					monthSuccessPer.append(monthSuccessValue+",");
				}
			}else{
				totalSuccessStr.append("<td>0</td>");
				successMonthStr.append("<td>0</td>");
				successPerStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					monthSuccess.append(0);
					avgSuccessPer.append(0);
					monthSuccessPer.append(0);
				}else{
					monthSuccess.append(0+",");
					avgSuccessPer.append(0+",");
					monthSuccessPer.append(0+",");
				}
			}
			i++;
		}
		totalSuccessStr.append("</tr>");
		successPerStr.append("</tr>");
		String value=totalSuccessStr.toString()+successMonthStr.toString()+successPerStr.toString();
		monthSuccess.append("]}");
		avgSuccessPer.append("]}");
		monthSuccessPer.append("]}");
		String data=monthSuccess.toString()+"]";
		
		String flowSucessPer=avgSuccessPer.toString()+monthSuccessPer.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：试乘试驾统计
	 * @return
	 */
	private String[] getTryCarCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer getTryCarNumStr=new StringBuffer();
		StringBuffer tryCarPerStr=new StringBuffer();
		
		StringBuffer tryCarMonthNumStr=new StringBuffer();
		StringBuffer tryCarMonthPerStr=new StringBuffer();
		
		StringBuffer tryCarMonthNumJson=new StringBuffer();
		
		StringBuffer tryCarPerJson=new StringBuffer();
		StringBuffer tryCarMonthPerJson=new StringBuffer();
		
		getTryCarNumStr.append("<tr><td style='font-weight: bold;'>试驾总客户</td>");
		tryCarPerStr.append("<tr><td style='font-weight: bold;'>平均试驾率</td>");
		tryCarMonthNumStr.append("<tr><td style='font-weight: bold;'>月试驾客户</td>");
		tryCarMonthPerStr.append("<tr><td style='font-weight: bold;'>月试驾率</td>");
		
		tryCarMonthNumJson.append("[{name: '月试驾客户',data: [");
		
		tryCarPerJson.append("[{name: '平均试驾率',data: [");
		tryCarMonthPerJson.append(",{name: '月试驾率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float tryCarPerValue=Float.valueOf(0);
				float tryCarMonthPerValue=Float.valueOf(0);
				if(null!=staCustComp.getTryCarPer()){
					tryCarPerValue=DataFormatUtil.formatFloat(staCustComp.getTryCarPer()*100);
				}
				if(null!=staCustComp.getTryCarMonthPer()){
					tryCarMonthPerValue=DataFormatUtil.formatFloat(staCustComp.getTryCarMonthPer()*100);
				}
				getTryCarNumStr.append("<td>"+staCustComp.getTryCarNum()+"</td>");
				tryCarPerStr.append("<td>"+tryCarPerValue+"</td>");
				tryCarMonthNumStr.append("<td>"+staCustComp.getTryCarMonthNum()+"</td>");
				tryCarMonthPerStr.append("<td>"+tryCarMonthPerValue+"</td>");
				if(i==keySet.size()){
					tryCarMonthNumJson.append(staCustComp.getTryCarMonthNum());
					
					tryCarPerJson.append(tryCarPerValue);
					tryCarMonthPerJson.append(tryCarMonthPerValue);
				}else{
					tryCarMonthNumJson.append(staCustComp.getTryCarMonthNum()+",");
					
					tryCarPerJson.append(tryCarPerValue+",");
					tryCarMonthPerJson.append(tryCarMonthPerValue+",");
				}
			}else{
				getTryCarNumStr.append("<td>0</td>");
				tryCarPerStr.append("<td>0.00</td>");
				tryCarMonthNumStr.append("<td>0</td>");
				tryCarMonthPerStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					tryCarMonthNumJson.append(0);
					
					tryCarPerJson.append(0);
					tryCarMonthPerJson.append(0);
				}else{
					tryCarMonthNumJson.append(0+",");
					
					tryCarPerJson.append(0+",");
					tryCarMonthPerJson.append(0+",");
				}
			}
			i++;
		}
		getTryCarNumStr.append("</tr>");
		tryCarPerStr.append("</tr>");
		tryCarMonthNumStr.append("</tr>");
		tryCarMonthPerStr.append("</tr>");
		String value=getTryCarNumStr.toString()+tryCarPerStr.toString()+tryCarMonthNumStr.toString()+tryCarMonthPerStr.toString();

		tryCarMonthNumJson.append("]}");
		String data=tryCarMonthNumJson.toString()+"]";
		
		tryCarPerJson.append("]}");
		tryCarMonthPerJson.append("]}");
		String flowSucessPer=tryCarPerJson.toString()+tryCarMonthPerJson.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：试乘试驾成交客户统计
	 * @return
	 */
	private String[] getTryCarSuccessCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer tryCarSuccessNumStr=new StringBuffer();
		StringBuffer tryCarSucessPerStr=new StringBuffer();
		StringBuffer tryCarMonthSuccessNumStr=new StringBuffer();
		StringBuffer tryCarMonthSuccessPerStr=new StringBuffer();
		
		StringBuffer tryCarMonthSuccessNumJson=new StringBuffer();
		
		StringBuffer tryCarSucessPerJson=new StringBuffer();
		StringBuffer tryCarMonthSuccessPerJson=new StringBuffer();
		
		tryCarSuccessNumStr.append("<tr><td style='font-weight: bold;'>试驾客户总成交数</td>");
		tryCarSucessPerStr.append("<tr><td style='font-weight: bold;'>平均试驾成交率</td>");
		tryCarMonthSuccessNumStr.append("<tr><td style='font-weight: bold;'>月度试驾客户成交数</td>");
		tryCarMonthSuccessPerStr.append("<tr><td style='font-weight: bold;'>月度试驾客户成交率</td>");
		
		tryCarMonthSuccessNumJson.append("[{name: '月度试驾客户成交数',data: [");
		
		tryCarSucessPerJson.append("[{name: '平均试驾成交率',data: [");
		tryCarMonthSuccessPerJson.append(",{name: '月度试驾客户成交率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float tryCarSucessPerValue=Float.valueOf(0);
				float tryCarMonthSuccessPerValue=Float.valueOf(0);
				if(null!=staCustComp.getTryCarSucessPer()){
					tryCarSucessPerValue=DataFormatUtil.formatFloat(staCustComp.getTryCarSucessPer()*100);
				}
				if(null!=staCustComp.getTryCarMonthSuccessPer()){
					tryCarMonthSuccessPerValue=DataFormatUtil.formatFloat(staCustComp.getTryCarMonthSuccessPer()*100);
				}
				tryCarSuccessNumStr.append("<td>"+staCustComp.getTryCarSuccessNum()+"</td>");
				tryCarSucessPerStr.append("<td>"+tryCarSucessPerValue+"</td>");
				tryCarMonthSuccessNumStr.append("<td>"+staCustComp.getTryCarMonthSuccessNum()+"</td>");
				tryCarMonthSuccessPerStr.append("<td>"+tryCarMonthSuccessPerValue+"</td>");
				if(i==keySet.size()){
					tryCarMonthSuccessNumJson.append(staCustComp.getTryCarMonthSuccessNum());
					
					tryCarSucessPerJson.append(tryCarSucessPerValue);
					tryCarMonthSuccessPerJson.append(tryCarMonthSuccessPerValue);
				}else{
					tryCarMonthSuccessNumJson.append(staCustComp.getTryCarMonthSuccessNum()+",");
					
					tryCarSucessPerJson.append(tryCarSucessPerValue+",");
					tryCarMonthSuccessPerJson.append(tryCarMonthSuccessPerValue+",");
				}
			}else{
				tryCarSuccessNumStr.append("<td>0</td>");
				tryCarSucessPerStr.append("<td>0</td>");
				tryCarMonthSuccessNumStr.append("<td>0</td>");
				tryCarMonthSuccessPerStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					tryCarMonthSuccessNumJson.append(0);
					
					tryCarSucessPerJson.append(0);
					tryCarMonthSuccessPerJson.append(0);
				}else{
					tryCarMonthSuccessNumJson.append(0+",");
					
					tryCarSucessPerJson.append(0+",");
					tryCarMonthSuccessPerJson.append(0+",");
				}
			}
			i++;
		}
		tryCarSuccessNumStr.append("</tr>");
		tryCarSucessPerStr.append("</tr>");
		tryCarMonthSuccessNumStr.append("</tr>");
		tryCarMonthSuccessPerStr.append("</tr>");
		String value=tryCarSuccessNumStr.toString()+tryCarSucessPerStr.toString()+tryCarMonthSuccessNumStr.toString()+tryCarMonthSuccessPerStr.toString();
		
		tryCarMonthSuccessNumJson.append("]}");
		String data=tryCarMonthSuccessNumJson.toString()+"]";
		
		tryCarSucessPerJson.append("]}");
		tryCarMonthSuccessPerJson.append("]}");
		String flowSucessPer=tryCarSucessPerJson.toString()+tryCarMonthSuccessPerJson.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：到店客户统计
	 * @return
	 */
	private String[] getComeShopCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer comeShopNumStr=new StringBuffer();
		StringBuffer comeShopPerStr=new StringBuffer();
		StringBuffer comeShopMonthNumStr=new StringBuffer();
		StringBuffer comeShopMonthPerStr=new StringBuffer();
		
		StringBuffer comeShopMonthNumJson=new StringBuffer();
		
		StringBuffer comeShopPer=new StringBuffer();
		StringBuffer comeShopMonthPer=new StringBuffer();
		
		comeShopNumStr.append("<tr><td style='font-weight: bold;'>到店总客户</td>");
		comeShopPerStr.append("<tr><td style='font-weight: bold;'>平均到店率</td>");
		comeShopMonthNumStr.append("<tr><td style='font-weight: bold;'>月到店客户</td>");
		comeShopMonthPerStr.append("<tr><td style='font-weight: bold;'>月到店率</td>");
		
		comeShopMonthNumJson.append("[{name: '月到店客户',data: [");
		
		comeShopPer.append("[{name: '平均到店率',data: [");
		comeShopMonthPer.append(",{name: '月到店率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float comeShopPerValue=Float.valueOf(0);
				float comeShopSuccessValue=Float.valueOf(0);
				if(null!=staCustComp.getComeShopPer()){
					comeShopPerValue=DataFormatUtil.formatFloat(staCustComp.getComeShopPer()*100);
				}
				if(null!=staCustComp.getComeShopMonthPer()){
					comeShopSuccessValue=DataFormatUtil.formatFloat(staCustComp.getComeShopMonthPer()*100);
				}
				comeShopNumStr.append("<td>"+staCustComp.getComeShopNum()+"</td>");
				comeShopPerStr.append("<td>"+comeShopPerValue+"</td>");
				comeShopMonthNumStr.append("<td>"+staCustComp.getComeShopMonthNum()+"</td>");
				comeShopMonthPerStr.append("<td>"+comeShopSuccessValue+"</td>");
				if(i==keySet.size()){
					comeShopMonthNumJson.append(staCustComp.getComeShopMonthNum());
					comeShopPer.append(comeShopPerValue);
					comeShopMonthPer.append(comeShopSuccessValue);
				}else{
					comeShopMonthNumJson.append(staCustComp.getComeShopMonthNum()+",");
					comeShopPer.append(comeShopPerValue+",");
					comeShopMonthPer.append(comeShopSuccessValue+",");
				}
			}else{
				comeShopNumStr.append("<td>0</td>");
				comeShopPerStr.append("<td>0</td>");
				comeShopMonthNumStr.append("<td>0.00</td>");
				comeShopMonthPerStr.append("<td>0</td>");
				if(i==keySet.size()){
					comeShopMonthNumJson.append(0);
					comeShopPer.append(0);
					comeShopMonthPer.append(0);
				}else{
					comeShopMonthNumJson.append(0+",");
					comeShopPer.append(0+",");
					comeShopMonthPer.append(0+",");
				}
			}
			i++;
		}
		comeShopNumStr.append("</tr>");
		comeShopPerStr.append("</tr>");
		comeShopMonthNumStr.append("</tr>");
		comeShopMonthPerStr.append("</tr>");
		String value=comeShopNumStr.toString()+comeShopPerStr.toString()+comeShopMonthNumStr.toString()+comeShopMonthPerStr.toString();
		comeShopMonthNumJson.append("]}");
		String data=comeShopMonthNumJson.toString()+"]";
		
		comeShopPer.append("]}");
		comeShopMonthPer.append("]}");
		String flowSucessPer=comeShopPer.toString()+comeShopMonthPer.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		return str;
	}
	/**
	 * 功能描述：到店客户成交统计
	 * @return
	 */
	private String[] getComeShopSuccessCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer comeShopSucessNumStr=new StringBuffer();
		StringBuffer comeShopSucessPerStr=new StringBuffer();
		StringBuffer comeShopMonthSuccessNumStr=new StringBuffer();
		StringBuffer comeShopMonthSuccessPerStr=new StringBuffer();
		
		StringBuffer comeShopMonthSuccessNumJson=new StringBuffer();
		
		StringBuffer comeShopSucessPerJson=new StringBuffer();
		StringBuffer comeShopMonthSuccessPerJson=new StringBuffer();
		
		comeShopSucessNumStr.append("<tr><td style='font-weight: bold;'>到店总成交客户</td>");
		comeShopSucessPerStr.append("<tr><td style='font-weight: bold;'>平均到店成交率</td>");
		comeShopMonthSuccessNumStr.append("<tr><td style='font-weight: bold;'>月度到店成交客户</td>");
		comeShopMonthSuccessPerStr.append("<tr><td style='font-weight: bold;'>月到店成交率</td>");
		
		comeShopMonthSuccessNumJson.append("[{name: '月度到店成交客户',data: [");
		
		comeShopSucessPerJson.append("[{name: '平均到店成交率',data: [");
		comeShopMonthSuccessPerJson.append(",{name: '月到店成交率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float comeShopSucessPerValue=Float.valueOf(0);
				float comeShopSuccessValue=Float.valueOf(0);
				if(null!=staCustComp.getComeShopSucessPer()){
					comeShopSucessPerValue=DataFormatUtil.formatFloat(staCustComp.getComeShopSucessPer()*100);
				}
				if(null!=staCustComp.getComeShopMonthSuccessPer()){
					comeShopSuccessValue=DataFormatUtil.formatFloat(staCustComp.getComeShopMonthSuccessPer()*100);
				}
				comeShopSucessNumStr.append("<td>"+staCustComp.getComeShopSucessNum()+"</td>");
				comeShopSucessPerStr.append("<td>"+comeShopSucessPerValue+"</td>");
				comeShopMonthSuccessNumStr.append("<td>"+staCustComp.getComeShopMonthSuccessNum()+"</td>");
				comeShopMonthSuccessPerStr.append("<td>"+comeShopSuccessValue+"</td>");
				if(i==keySet.size()){
					comeShopMonthSuccessNumJson.append(staCustComp.getComeShopMonthSuccessNum());
					
					comeShopSucessPerJson.append(comeShopSucessPerValue);
					comeShopMonthSuccessPerJson.append(comeShopSuccessValue);
				}else{
					comeShopMonthSuccessNumJson.append(staCustComp.getComeShopMonthSuccessNum()+",");
					
					comeShopSucessPerJson.append(comeShopSucessPerValue+",");
					comeShopMonthSuccessPerJson.append(comeShopSuccessValue+",");
				}
			}else{
				comeShopSucessNumStr.append("<td>0</td>");
				comeShopSucessPerStr.append("<td>0</td>");
				comeShopMonthSuccessNumStr.append("<td>0.00</td>");
				comeShopMonthSuccessPerStr.append("<td>0</td>");
				if(i==keySet.size()){
					comeShopMonthSuccessNumJson.append(0);
					
					comeShopSucessPerJson.append(0);
					comeShopMonthSuccessPerJson.append(0);
				}else{
					comeShopMonthSuccessNumJson.append(0+",");
					
					comeShopSucessPerJson.append(0+",");
					comeShopMonthSuccessPerJson.append(0+",");
				}
			}
			i++;
		}
		comeShopSucessNumStr.append("</tr>");
		comeShopSucessPerStr.append("</tr>");
		comeShopMonthSuccessNumStr.append("</tr>");
		comeShopMonthSuccessPerStr.append("</tr>");
		String value=comeShopSucessNumStr.toString()+comeShopSucessPerStr.toString()+comeShopMonthSuccessNumStr.toString()+comeShopMonthSuccessPerStr.toString();
		
		comeShopMonthSuccessNumJson.append("]}");
		String data=comeShopMonthSuccessNumJson.toString()+"]";
		
		comeShopSucessPerJson.append("]}");
		comeShopMonthSuccessPerJson.append("]}");
		String flowSucessPer=comeShopSucessPerJson.toString()+comeShopMonthSuccessPerJson.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：二次到店客户统计
	 * @return
	 */
	private String[] getTwoComeShopCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer twoTimesComeShopNumStr=new StringBuffer();
		StringBuffer twoTimesComeShopPerStr=new StringBuffer();
		StringBuffer twoTimesComeShopMonthNumStr=new StringBuffer();
		StringBuffer twoTimesComeShopMonthPerStr=new StringBuffer();
		
		StringBuffer twoTimesComeShopMonthNumJson=new StringBuffer();
		
		StringBuffer twoTimesComeShopPerJson=new StringBuffer();
		StringBuffer twoTimesComeShopMonthPerJson=new StringBuffer();
		
		twoTimesComeShopNumStr.append("<tr><td style='font-weight: bold;'>二次到店总客户</td>");
		twoTimesComeShopPerStr.append("<tr><td style='font-weight: bold;'>平均二次到店率</td>");
		twoTimesComeShopMonthNumStr.append("<tr><td style='font-weight: bold;'>月二次到店客户</td>");
		twoTimesComeShopMonthPerStr.append("<tr><td style='font-weight: bold;'>月二次到店率</td>");
		
		twoTimesComeShopMonthNumJson.append("[{name: '月二次到店客户',data: [");
		
		twoTimesComeShopPerJson.append("[{name: '平均二次到店率',data: [");
		twoTimesComeShopMonthPerJson.append(",{name: '月二次到店率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float twoTimesComeShopPerValue=Float.valueOf(0);
				float twoTimesComeShopMonthPerValue=Float.valueOf(0);
				if(null!=staCustComp.getTwoTimesComeShopPer()){
					twoTimesComeShopPerValue=DataFormatUtil.formatFloat(staCustComp.getTwoTimesComeShopPer()*100);
				}
				if(null!=staCustComp.getTwoTimesComeShopMonthPer()){
					twoTimesComeShopMonthPerValue=DataFormatUtil.formatFloat(staCustComp.getTwoTimesComeShopMonthPer()*100);
				}
				twoTimesComeShopNumStr.append("<td>"+staCustComp.getTwoTimesComeShopNum()+"</td>");
				twoTimesComeShopPerStr.append("<td>"+twoTimesComeShopPerValue+"</td>");
				twoTimesComeShopMonthNumStr.append("<td>"+staCustComp.getTwoTimesComeShopMonthNum()+"</td>");
				twoTimesComeShopMonthPerStr.append("<td>"+twoTimesComeShopMonthPerValue+"</td>");
				if(i==keySet.size()){
					twoTimesComeShopMonthNumJson.append(staCustComp.getTwoTimesComeShopMonthNum());
					
					twoTimesComeShopPerJson.append(twoTimesComeShopPerValue);
					twoTimesComeShopMonthPerJson.append(twoTimesComeShopMonthPerValue);
				}else{
					twoTimesComeShopMonthNumJson.append(staCustComp.getTwoTimesComeShopMonthNum()+",");
					
					twoTimesComeShopPerJson.append(twoTimesComeShopPerValue+",");
					twoTimesComeShopMonthPerJson.append(twoTimesComeShopMonthPerValue+",");
				}
			}else{
				twoTimesComeShopNumStr.append("<td>0.00</td>");
				twoTimesComeShopPerStr.append("<td>0.00</td>");
				twoTimesComeShopMonthNumStr.append("<td>0.00</td>");
				twoTimesComeShopMonthPerStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					twoTimesComeShopMonthNumJson.append(0);
					
					twoTimesComeShopPerJson.append(0);
					twoTimesComeShopMonthPerJson.append(0);
				}else{
					twoTimesComeShopMonthNumJson.append(0+",");
					
					twoTimesComeShopPerJson.append(0+",");
					twoTimesComeShopMonthPerJson.append(0+",");
				}
			}
			i++;
		}
		String value=twoTimesComeShopNumStr.toString()+twoTimesComeShopPerStr.toString()+twoTimesComeShopMonthNumStr.toString()+twoTimesComeShopMonthPerStr.toString();
		
		twoTimesComeShopMonthNumJson.append("]}");
		String data=twoTimesComeShopMonthNumJson.toString()+"]";
		
		twoTimesComeShopPerJson.append("]}");
		twoTimesComeShopMonthPerJson.append("]}");
		String flowSucessPer=twoTimesComeShopPerJson.toString()+twoTimesComeShopMonthPerJson.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：到店客户统计
	 * @return
	 */
	private String[] getTwoComeShopSuccessCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer twoTimesComeShopSucessNumStr=new StringBuffer();
		StringBuffer twoTimesComeShopSucessPerStr=new StringBuffer();
		StringBuffer twoTimesComeShopMonthSucessNumStr=new StringBuffer();
		StringBuffer twoTimesComeShopMonthSucessPerStr=new StringBuffer();
		
		StringBuffer twoTimesComeShopMonthSucessNumJson=new StringBuffer();
		
		StringBuffer twoTimesComeShopSucessPerJson=new StringBuffer();
		StringBuffer twoTimesComeShopMonthSucessPerJson=new StringBuffer();
		
		twoTimesComeShopSucessNumStr.append("<tr><td style='font-weight: bold;'>二次到店总成交客户</td>");
		twoTimesComeShopSucessPerStr.append("<tr><td style='font-weight: bold;'>平均二次到成交率</td>");
		twoTimesComeShopMonthSucessNumStr.append("<tr><td style='font-weight: bold;'>月二次到店成交客户</td>");
		twoTimesComeShopMonthSucessPerStr.append("<tr><td style='font-weight: bold;'>月二次到店成交率</td>");
		
		twoTimesComeShopMonthSucessNumJson.append("[{name: '月二次到店成交客户',data: [");
		
		twoTimesComeShopSucessPerJson.append("[{name: '平均二次到成交率',data: [");
		twoTimesComeShopMonthSucessPerJson.append(",{name: '月二次到店成交率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float twoTimesComeShopSucessPerValue=Float.valueOf(0);
				float twoTimesComeShopMonthSucessPerValue=Float.valueOf(0);
				if(null!=staCustComp.getTwoTimesComeShopSucessPer()){
					twoTimesComeShopSucessPerValue=DataFormatUtil.formatFloat(staCustComp.getTwoTimesComeShopSucessPer()*100);
				}
				if(null!=staCustComp.getTwoTimesComeShopMonthSucessPer()){
					twoTimesComeShopMonthSucessPerValue=DataFormatUtil.formatFloat(staCustComp.getTwoTimesComeShopMonthSucessPer()*100);
				}
				Integer twoTimesComeShopMonthSucessNum = staCustComp.getTwoTimesComeShopMonthSucessNum();
				if(null==twoTimesComeShopMonthSucessNum){
					twoTimesComeShopMonthSucessNum=0;
				}
				twoTimesComeShopSucessNumStr.append("<td>"+staCustComp.getTwoTimesComeShopSucessNum()+"</td>");
				twoTimesComeShopSucessPerStr.append("<td>"+twoTimesComeShopSucessPerValue+"</td>");
				twoTimesComeShopMonthSucessNumStr.append("<td>"+twoTimesComeShopMonthSucessNum+"</td>");
				twoTimesComeShopMonthSucessPerStr.append("<td>"+twoTimesComeShopMonthSucessPerValue+"</td>");
				if(i==keySet.size()){
					twoTimesComeShopMonthSucessNumJson.append(twoTimesComeShopMonthSucessNum);
					
					twoTimesComeShopSucessPerJson.append(twoTimesComeShopSucessPerValue);
					twoTimesComeShopMonthSucessPerJson.append(twoTimesComeShopMonthSucessPerValue);
				}else{
					twoTimesComeShopMonthSucessNumJson.append(twoTimesComeShopMonthSucessNum+",");
					
					twoTimesComeShopSucessPerJson.append(twoTimesComeShopSucessPerValue+",");
					twoTimesComeShopMonthSucessPerJson.append(twoTimesComeShopMonthSucessPerValue+",");
				}
			}else{
				twoTimesComeShopSucessNumStr.append("<td>0.00</td>");
				twoTimesComeShopSucessPerStr.append("<td>0.00</td>");
				twoTimesComeShopMonthSucessNumStr.append("<td>0.00</td>");
				twoTimesComeShopMonthSucessPerStr.append("<td>0.00</td>");
				if(i==keySet.size()){
					twoTimesComeShopMonthSucessNumJson.append(0);
					
					twoTimesComeShopSucessPerJson.append(0);
					twoTimesComeShopMonthSucessPerJson.append(0);
				}else{
					twoTimesComeShopMonthSucessNumJson.append(0+",");
					
					twoTimesComeShopSucessPerJson.append(0+",");
					twoTimesComeShopMonthSucessPerJson.append(0+",");
				}
			}
			i++;
		}
		twoTimesComeShopSucessNumStr.append("</tr>");
		twoTimesComeShopSucessPerStr.append("</tr>");
		twoTimesComeShopMonthSucessNumStr.append("</tr>");
		twoTimesComeShopMonthSucessPerStr.append("</tr>");
		String value=twoTimesComeShopSucessNumStr.toString()+twoTimesComeShopSucessPerStr.toString()+twoTimesComeShopMonthSucessNumStr.toString()+twoTimesComeShopMonthSucessPerStr.toString();
		
		twoTimesComeShopMonthSucessNumJson.append("]}");
		String data=twoTimesComeShopMonthSucessNumJson.toString()+"]";
		
		twoTimesComeShopSucessPerJson.append("]}");
		twoTimesComeShopMonthSucessPerJson.append("]}");
		String flowSucessPer=twoTimesComeShopSucessPerJson.toString()+twoTimesComeShopMonthSucessPerJson.toString()+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	/**
	 * 功能描述：回访统计
	 * @return
	 */
	private String[] getTrackCustomerStr(Map<Integer, StaCustComp> map){
		String[] str=new String[3];
		StringBuffer valueStr1=new StringBuffer();
		StringBuffer valueStr2=new StringBuffer();
		StringBuffer valueStr3=new StringBuffer();
		StringBuffer valueStr4=new StringBuffer();
		StringBuffer valueStr5=new StringBuffer();
		StringBuffer trackMonthNumStr=new StringBuffer();
		StringBuffer trackMonthOverTimeNumStr=new StringBuffer();
		StringBuffer trackMonthOverTimePerStr=new StringBuffer();
		
		StringBuffer valueJson1=new StringBuffer();
		StringBuffer valueJson2=new StringBuffer();
		StringBuffer valueJson3=new StringBuffer();
		StringBuffer valueJson4=new StringBuffer();
		StringBuffer trackMonthOverTimePerJson=new StringBuffer();
		
		StringBuffer comeShopPer=new StringBuffer();
		valueStr1.append("<tr><td style='font-weight: bold;'>集客</td>");
		valueStr2.append("<tr><td style='font-weight: bold;'>回访总数</td>");
		valueStr3.append("<tr><td style='font-weight: bold;'>平均回访频次</td>");
		valueStr4.append("<tr><td style='font-weight: bold;'>超时次数</td>");
		valueStr5.append("<tr><td style='font-weight: bold;'>平均超时率</td>");
		
		trackMonthNumStr.append("<tr><td style='font-weight: bold;'>月回访量</td>");
		trackMonthOverTimeNumStr.append("<tr><td style='font-weight: bold;'>月回访超时量</td>");
		trackMonthOverTimePerStr.append("<tr><td style='font-weight: bold;'>月回访超时率</td>");
		
		valueJson1.append("[{name: '集客',data: [");
		valueJson2.append(",{name: '回访总数',data: [");
		valueJson3.append(",{name: '回访频次',data: [");
		valueJson4.append(",{name: '超时次数',data: [");
		
		comeShopPer.append("[{name: '超时率',data: [");
		trackMonthOverTimePerJson.append(",{name: '月回访超时率',data: [");
		
		Set<Integer> keySet = map.keySet();
		int i=1;
		for (Integer integer : keySet) {
			StaCustComp staCustComp = map.get(integer);
			if(staCustComp!=null){
				float TrackOverTimePerValue=Float.valueOf(0);
				if(null!=staCustComp.getTrackOverTimePer()){
					TrackOverTimePerValue=DataFormatUtil.formatFloat(staCustComp.getTrackOverTimePer()*100);
				}
				float trackMonthOverTimePerValue=Float.valueOf(0);
				if(null!=staCustComp.getTrackMonthOverTimePer()){
					trackMonthOverTimePerValue=DataFormatUtil.formatFloat(staCustComp.getTrackMonthOverTimePer()*100);
				}
				valueStr1.append("<td>"+staCustComp.getRecordNum()+"</td>");
				valueStr2.append("<td>"+staCustComp.getTrackNum()+"</td>");
				valueStr3.append("<td>"+staCustComp.getTrackAva()+"</td>");
				valueStr4.append("<td>"+staCustComp.getTrackOverTimeNum()+"</td>");
				valueStr5.append("<td>"+TrackOverTimePerValue+"</td>");
				
				trackMonthNumStr.append("<td >"+staCustComp.getTrackMonthNum()+"</td>");
				trackMonthOverTimeNumStr.append("<td >"+staCustComp.getTrackMonthOverTimeNum()+"</td>");
				trackMonthOverTimePerStr.append("<td >"+trackMonthOverTimePerValue+"</td>");
				
				
				if(i==keySet.size()){
					valueJson1.append(staCustComp.getRecordNum());
					valueJson2.append(staCustComp.getTrackNum());
					valueJson3.append(staCustComp.getTrackAva());
					valueJson4.append(staCustComp.getTrackOverTimeNum());
					
					comeShopPer.append(TrackOverTimePerValue);
					trackMonthOverTimePerJson.append(trackMonthOverTimePerValue);
				}else{
					valueJson1.append(staCustComp.getRecordNum()+",");
					valueJson2.append(staCustComp.getTrackNum()+",");
					valueJson3.append(staCustComp.getTrackAva()+",");
					valueJson4.append(staCustComp.getTrackOverTimeNum()+",");
					
					comeShopPer.append(TrackOverTimePerValue+",");
					trackMonthOverTimePerJson.append(trackMonthOverTimePerValue+",");
				}
			}else{
				valueStr1.append("<td>0</td>");
				valueStr2.append("<td>0</td>");
				valueStr3.append("<td>0.00</td>");
				valueStr4.append("<td>0</td>");
				valueStr5.append("<td>0</td>");
				trackMonthNumStr.append("<td >0</td>");
				trackMonthOverTimeNumStr.append("<td >0</td>");
				trackMonthOverTimePerStr.append("<td >0</td>");
				
				if(i==keySet.size()){
					valueJson1.append(0);
					valueJson2.append(0);
					valueJson3.append(0);
					valueJson4.append(0);
					
					comeShopPer.append(0);
					trackMonthOverTimePerJson.append(0);
				}else{
					valueJson1.append(0+",");
					valueJson2.append(0+",");
					valueJson3.append(0+",");
					valueJson4.append(0+",");
					
					comeShopPer.append(0+",");
					trackMonthOverTimePerJson.append(0+",");
				}
			}
			i++;
		}
		valueStr1.append("</tr>");
		valueStr2.append("</tr>");
		valueStr3.append("</tr>");
		valueStr4.append("</tr>");
		valueStr5.append("</tr>");
		String value=valueStr1.toString()+valueStr2.toString()+valueStr3.toString()+valueStr4.toString()
				+valueStr5.toString()+trackMonthNumStr.toString()+trackMonthOverTimeNumStr.toString()+trackMonthOverTimePerStr.toString();
		
		valueJson1.append("]}");
		valueJson2.append("]}");
		valueJson3.append("]}");
		valueJson4.append("]}");
		String data=valueJson1.toString()+valueJson2.toString()+valueJson3.toString()+valueJson4.toString()+"]";
		
		comeShopPer.append("]}");
		trackMonthOverTimePerJson.append("]}");
		String flowSucessPer=comeShopPer.toString()+trackMonthOverTimePerJson+"]";
		str[0]=value;
		str[1]=data;
		str[2]=flowSucessPer;
		
		return str;
	}
	
}
