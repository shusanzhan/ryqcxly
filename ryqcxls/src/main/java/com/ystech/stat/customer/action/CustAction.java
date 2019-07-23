package com.ystech.stat.customer.action;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.stat.customer.model.CustPhase;
import com.ystech.stat.customer.model.CustUser;
import com.ystech.stat.customer.service.CustManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("custAction")
@Scope("prototype")
public class CustAction extends BaseController{
	public CustManageImpl custManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	
	@Resource
	public void setCustManageImpl(CustManageImpl custManageImpl) {
		this.custManageImpl = custManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
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
	public String queryList() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		try {
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
			//总基盘
			CustUser userAll = custManageImpl.findByCustUsersAll(enterprise.getDbid(),tryCarStatus,comeShopStatus);
			request.setAttribute("userAll",userAll);
			
			List<CustPhase> custPhases = custManageImpl.findByCustPhases(enterprise.getDbid(),tryCarStatus,comeShopStatus);
			Map<CustPhase, List<CarSerCount>> mapCustPhases = custManageImpl.findByCustPhaseCarSerCount(custPhases, enterprise.getDbid(),tryCarStatus,comeShopStatus);
			request.setAttribute("mapCustPhases",mapCustPhases);
			String pieCustPhaseData = pieCustPhaseData(custPhases);
			request.setAttribute("pieCustPhaseData", pieCustPhaseData);
			
			List<CustUser> custUsers = custManageImpl.findByCustUsers(enterprise.getDbid(),tryCarStatus,comeShopStatus);
			String pieCustUserData = pieCustUserData(custUsers);
			request.setAttribute("pieCustUserData",pieCustUserData);
			List<CarSerCount> carSerCounts = custManageImpl.findByCustUserCarSerCountAll(enterprise.getDbid(),tryCarStatus,comeShopStatus);
			request.setAttribute("carSerCounts", carSerCounts);
			String pieCustCarData = pieCustCarData(carSerCounts);
			request.setAttribute("pieCustCarData", pieCustCarData);
			
			Map<CustUser, List<CarSerCount>> mapUserCarSerCounts = custManageImpl.findByCustUserCarSerCount(custUsers, enterprise.getDbid(),tryCarStatus,comeShopStatus);
			request.setAttribute("mapUserCarSerCounts", mapUserCarSerCounts);
			
			
			Map<CustUser, List<CustPhase>> mapCustUserPhases = custManageImpl.findByCustPhases(custUsers, enterprise.getDbid(),tryCarStatus,comeShopStatus);
			Map<CustUser, Map<CustPhase, List<CarSerCount>>> mapCarSerCounts = custManageImpl.findByCarSerCount(mapCustUserPhases, enterprise.getDbid(),tryCarStatus,comeShopStatus);
			request.setAttribute("mapCarSerCounts", mapCarSerCounts);
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where status=1  AND enterpriseId="+enterprise.getDbid(),null);
			
			request.setAttribute("carSeriys",carSeriys);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：客户等级
	 * @param statCustomerRecordTimes
	 */
	private String pieCustPhaseData(List<CustPhase> custPhases) {
		StringBuffer dataBuf=new StringBuffer();
		if(custPhases.isEmpty()){
			return "[]";
		}
		int size = custPhases.size();
		int i=0;
		CustPhase maxCount = custPhases.get(0);
		for (CustPhase temp : custPhases) {
			if(maxCount.getTotalNum()<temp.getTotalNum()){
				maxCount=temp;
			}
		}
		dataBuf.append("[");
		for (CustPhase temp : custPhases) {
			i++;
			dataBuf.append("{"
					+ "name:\""+temp.getName()+"\","
					+"y:"+temp.getTotalNum());
			if(temp.getName().equals(maxCount.getName())){
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
	 * 功能描述：客户车型
	 * @param statCustomerRecordTimes
	 */
	private String pieCustCarData(List<CarSerCount> carSerCounts) {
		StringBuffer dataBuf=new StringBuffer();
		if(carSerCounts.isEmpty()){
			return "[]";
		}
		int size = carSerCounts.size();
		CarSerCount maxCount = carSerCounts.get(0);
		for (CarSerCount temp : carSerCounts) {
			if(maxCount.getCountNum()<temp.getCountNum()){
				maxCount=temp;
			}
		}
		dataBuf.append("[");
		int i=0;
		for (CarSerCount temp : carSerCounts) {
			i++;
			dataBuf.append("{"
					+ "name:\""+temp.getName()+"\","
					+"y:"+temp.getCountNum());
			if(temp.getName().equals(maxCount.getName())){
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
	 * 功能描述：用户-
	 * @param statCustomerRecordTimes
	 */
	private String pieCustUserData(List<CustUser> carSerCounts) {
		StringBuffer dataBuf=new StringBuffer();
		if(carSerCounts.isEmpty()){
			return "[]";
		}
		int size = carSerCounts.size();
		CustUser maxCount = carSerCounts.get(0);
		for (CustUser temp : carSerCounts) {
			if(maxCount.getTotalNum()<temp.getTotalNum()){
				maxCount=temp;
			}
		}
		dataBuf.append("[");
		int i=0;
		for (CustUser temp : carSerCounts) {
			i++;
			dataBuf.append("{"
					+ "name:\""+temp.getBussiStaff()+"\","
					+"y:"+temp.getTotalNum());
			if(temp.getTotalNum().equals(maxCount.getBussiStaff())){
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
