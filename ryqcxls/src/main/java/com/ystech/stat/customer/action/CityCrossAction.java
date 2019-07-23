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
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.stat.customer.model.CityCrossCount;
import com.ystech.stat.customer.service.CityCrossManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

@Component("cityCrossAction")
@Scope("prototype")
public class CityCrossAction extends BaseController{
	private CustomerTypeManageImpl customerTypeManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CityCrossManageImpl cityCrossManageImpl;
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setCityCrossManageImpl(CityCrossManageImpl cityCrossManageImpl) {
		this.cityCrossManageImpl = cityCrossManageImpl;
	}
	/**
	 * 功能描述：
	 * @return
	 */
	public String queryCityCrossCount() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
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
			
			List<CityCrossCount> cityCrossCustomerCounts = cityCrossManageImpl.queryStatCityCross(beginDate, endDate, enterprise.getDbid(), type, tryCarStatus, comeShopStatus);
			request.setAttribute("cityCrossCustomerCounts", cityCrossCustomerCounts);
			
			CityCrossCount statCityCrossTotal = cityCrossManageImpl.queryStatCityCrossTotal(beginDate, endDate, enterprise.getDbid(), type, tryCarStatus, comeShopStatus);
			request.setAttribute("statCityCrossTotal", statCityCrossTotal);
			CityCrossCount cityCrossCount=null;
			for (CityCrossCount cityCrossCountTemp : cityCrossCustomerCounts) {
				if(cityCrossCountTemp.getName().equals("无")){
					cityCrossCount=cityCrossCountTemp;
				}
			}
			
			String dataTotal="[";
			if(null!=cityCrossCount){
				dataTotal=dataTotal+"['无',"+cityCrossCount.getTotalCount()+"],['交叉',"+(statCityCrossTotal.getTotalCount()-cityCrossCount.getTotalCount())+"]";
			}
			dataTotal=dataTotal+"]";
			request.setAttribute("dataTotal",dataTotal);
			
			
			String jsonCityCrossesData = jsonCityCrossesData(cityCrossCustomerCounts);
			request.setAttribute("jsonCityCrossesData", jsonCityCrossesData);
			
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "cityCrossCount";
	}
	
	//交叉客户json
	private String jsonCityCrossesData(List<CityCrossCount> cityCrossCustomerCounts){
		String data="[";
		if(!cityCrossCustomerCounts.isEmpty()){
			for (CityCrossCount cityCrossCustomerCount : cityCrossCustomerCounts) {
				if(!cityCrossCustomerCount.getName().equals("无")){
					data=data+" ['"+cityCrossCustomerCount.getName()+"',"+cityCrossCustomerCount.getTotalCount()+"],";
				}
			}
			int lastIndexOf = data.lastIndexOf(",");
			data = data.substring(0, lastIndexOf);
		}
		data=data+"]";
		return data;
	}
}
