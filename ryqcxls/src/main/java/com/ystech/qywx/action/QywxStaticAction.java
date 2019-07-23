package com.ystech.qywx.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("qywxStaticAction")
@Scope("prototype")
public class QywxStaticAction extends BaseController{
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	private UserManageImpl userManageImpl;
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	/**
	 * 功能描述：我的客户构
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerStatic() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User currentUser = getSessionUser();
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where (lastResult="+Customer.NORMAL+" or (lastResult="+Customer.SUCCESS+" and orderContractStatus="+Customer.ORDERNOT+")) AND bussiStaffId="+currentUser.getDbid();
			String totalCountSql="SELECT COUNT(*) as total FROM cust_customer where bussiStaffId="+currentUser.getDbid();
			
			String canncelCountSql="SELECT COUNT(*) as total FROM cust_customer where lastResult="+Customer.CANCCEL+" AND bussiStaffId="+currentUser.getDbid();

			String orderCountSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_ordercontract AS ord where cuts.dbid=ord.customerId AND ord.`status`>"+OrderContract.WATINGDECORE+" and ord.`status`<"+OrderContract.PRINT +" and cuts.bussiStaffId="+currentUser.getDbid();
			
			String waitingCarSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus!="+CustomerPidBookingRecord.FINISHED +" and cuts.bussiStaffId="+currentUser.getDbid();
			
			String customerSuccessSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus="+CustomerPidBookingRecord.FINISHED +" and cuts.bussiStaffId="+currentUser.getDbid();
			
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
			
			Object total = statisticalSalerManageImpl.queryCount(totalCountSql);
			request.setAttribute("total", total);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerStatic";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerLevel() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		try{
			User user = getSessionUser();
			Integer userDbid = user.getDbid();
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
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where (lastResult="+Customer.NORMAL+" or (lastResult="+Customer.SUCCESS+" and orderContractStatus="+Customer.ORDERNOT+")) AND bussiStaffId="+userDbid+" AND createFolderTime>='"+DateUtil.format(start)+"'" +" AND createFolderTime<'"+DateUtil.format(end)+"'";;
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			Object levelCO = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELO);
			Object levelCA = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELA);
			Object levelCB = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELB);
			Object levelCC = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELC);
			request.setAttribute("levelCO", levelCO);
			request.setAttribute("levelCA", levelCA);
			request.setAttribute("levelCB", levelCB);
			request.setAttribute("levelCC", levelCC);
			
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerLevel";
	}
/**
 * 功能描述：成交客户车辆分析
 * 参数描述：
 * 逻辑描述：
 * @return
 * @throws Exception
 */
public String successCustomerCar() throws Exception {
	HttpServletRequest request = this.getRequest();
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	Date start=null;
	Date end=null;
	try{
		User user = getSessionUser();
		Integer userDbid = user.getDbid();
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
		List<CarSerCount> carSerCounts = statisticalSalerManageImpl.querySuccessCustomer(start, end,userDbid,null);
		request.setAttribute("carSerCounts", carSerCounts);
		
		String jsonCarData = jsonCarData(carSerCounts);
		request.setAttribute("jsonCarData", jsonCarData);
		
		String customerSuccessSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus="+CustomerPidBookingRecord.FINISHED +" and cuts.bussiStaffId="+userDbid+" AND cuts.createFolderTime>='"+DateUtil.format(start)+"'" +" AND cuts.createFolderTime<'"+DateUtil.format(end)+"'";
		System.out.println(customerSuccessSql);
		request.setAttribute("start", start);
		request.setAttribute("end", DateUtil.preDay(end));
		Object queryCount = statisticalSalerManageImpl.queryCount(customerSuccessSql);
		request.setAttribute("queryCount", queryCount);
		
	}catch (Exception e) {
		e.printStackTrace();
		log.error(e);
	}
	return "successCustomerCar";
}
/**
 * 功能描述：待交车客户统计
 * 参数描述：
 * 逻辑描述：
 * @return
 * @throws Exception
 */
public String waitingCustomerCar() throws Exception {
	HttpServletRequest request = this.getRequest();
	try{
		User user = getSessionUser();
		String noCarSql="SELECT COUNT(*) as total FROM cust_customerpidbookingrecord pd,cust_customer cus WHERE bussiStaffId="+user.getDbid()+" AND pd.customerId=cus.dbid AND pd.pidStatus=1 AND hasCarOrder=1";
		String driverCarSql="SELECT COUNT(*) as total FROM cust_customerpidbookingrecord pd,cust_customer cus WHERE bussiStaffId="+user.getDbid()+" AND pd.customerId=cus.dbid AND pd.pidStatus=1 AND hasCarOrder=2";
		String hasCarSql="SELECT COUNT(*) as total FROM cust_customerpidbookingrecord pd,cust_customer cus WHERE bussiStaffId="+user.getDbid()+" AND pd.customerId=cus.dbid AND pd.pidStatus=1 AND hasCarOrder=3";
		String totalSql="SELECT COUNT(*) as total FROM cust_customerpidbookingrecord pd,cust_customer cus WHERE bussiStaffId="+user.getDbid()+" AND pd.customerId=cus.dbid AND pd.pidStatus=1";
		Object noCar = statisticalSalerManageImpl.queryCount(noCarSql);
		Object driverCar = statisticalSalerManageImpl.queryCount(driverCarSql);
		Object hasCar = statisticalSalerManageImpl.queryCount(hasCarSql);
		Object total = statisticalSalerManageImpl.queryCount(totalSql);
		
		request.setAttribute("noCar", noCar);
		request.setAttribute("driverCar", driverCar);
		request.setAttribute("hasCar", hasCar);
		request.setAttribute("total", total);
	}catch (Exception e) {
		e.printStackTrace();
		log.error(e);
	}
	return "waitingCustomerCar";
}
private String jsonCarData(List<CarSerCount> carSerCounts){
	if(null==carSerCounts||carSerCounts.size()<=0){
		return null;
	}
	String data="[";
	for (CarSerCount carSerCount : carSerCounts) {
			data=data+" ['"+carSerCount.getSerName()+"',"+carSerCount.getCountNum()+"],";
	}
	int lastIndexOf = data.lastIndexOf(",");
	data = data.substring(0, lastIndexOf);
	data=data+"]";
	return data;
}
/**
 * 功能描述：客户回访统计
 * 参数描述：
 * 逻辑描述：
 * @return
 * @throws Exception
 */
public String visitRecord() throws Exception {
	HttpServletRequest request = this.getRequest();
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	Date start=null;
	Date end=null;
	try{
		User user = getSessionUser();
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
		//待回访客户
		String waitingSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customer cust,cust_customerpidbookingrecord cpid WHERE cpid.customerId=cust.dbid AND hfv.customerId=cust.dbid AND cpid.hfStatus<3 AND cust.bussiStaffId="+user.getDbid()+"  AND cpid.modifyTime>='"+DateUtil.format(start)+"'" +" AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
		Object waitingCount = statisticalSalerManageImpl.queryCount(waitingSql);
		request.setAttribute("waitingCount", waitingCount);
		//待回访数据
		String successSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customer cust,cust_customerpidbookingrecord cpid WHERE cpid.customerId=cust.dbid AND hfv.customerId=cust.dbid AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+"  AND cpid.modifyTime>='"+DateUtil.format(start)+"'" +" AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
		Object successCount = statisticalSalerManageImpl.queryCount(successSql);
		request.setAttribute("successCount", successCount);
		//回访成功需要考核数据
		String successAgesSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customer cust,cust_customerpidbookingrecord cpid WHERE cpid.customerId=cust.dbid AND hfv.customerId=cust.dbid AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND hfv.isStatic=1 AND cpid.modifyTime>='"+DateUtil.format(start)+"'" +" AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
		Object successAgesCount = statisticalSalerManageImpl.queryCount(successAgesSql);
		request.setAttribute("successAgesCount", successAgesCount);
		//回访成功不考核数据
		String notSuccessAgesSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customer cust,cust_customerpidbookingrecord cpid WHERE cpid.customerId=cust.dbid AND hfv.customerId=cust.dbid AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND hfv.isStatic=2 AND cpid.modifyTime>='"+DateUtil.format(start)+"'" +" AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
		Object notSuccessAgesCount = statisticalSalerManageImpl.queryCount(notSuccessAgesSql);
		request.setAttribute("notSuccessAgesCount", notSuccessAgesCount);
		//核心流程调查（assessmentType=1 核心流程）
		String notSql="SELECT COUNT(hfvra.dbid) as total " +
				"FROM hf_visitrecordanswer hfvra,hf_quest hfq,hf_questansweritem hfqai,hf_visitrecord hfv,cust_customerpidbookingrecord cpid,cust_customer cust " +
				"WHERE " +
				"hfvra.questId=hfq.dbid AND hfvra.questAnswerItemId=hfqai.dbid AND hfqai.questid=hfq.dbid AND hfv.dbid=hfvra.visitRecordId AND cpid.customerId=cust.dbid AND cust.dbid=hfv.customerId" +
				" AND hfq.isAssessment=2 AND hfq.assessmentType=1 and hfqai.assessmentState=2  AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<='"+DateUtil.format(end)+"' ";
		Object notCuont = statisticalSalerManageImpl.queryCount(notSql);
		request.setAttribute("notCuont", notCuont);
		//是否介绍延保服务(assessmentType=2 自有店）
		String ybSql="SELECT COUNT(hfvra.dbid) as total " +
				"FROM hf_visitrecordanswer hfvra,hf_quest hfq,hf_questansweritem hfqai,hf_visitrecord hfv,cust_customerpidbookingrecord cpid,cust_customer cust " +
				"WHERE " +
				"hfvra.questId=hfq.dbid AND hfvra.questAnswerItemId=hfqai.dbid AND hfqai.questid=hfq.dbid AND hfv.dbid=hfvra.visitRecordId AND cpid.customerId=cust.dbid AND cust.dbid=hfv.customerId" +
				" AND hfq.isAssessment=2 AND hfq.assessmentType=2 and hfqai.assessmentState=2  AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<='"+DateUtil.format(end)+"' ";
		Object ybCount = statisticalSalerManageImpl.queryCount(ybSql);
		request.setAttribute("ybCount", ybCount);
		
		//满意数据
		String manyiSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customerpidbookingrecord cpid,cust_customer cust WHERE " +
				"hfv.customerId=cust.dbid AND cpid.customerId=cust.dbid " +
				"AND (hfv.comSat='非常满意' OR hfv.comSat='满意' ) AND hfv.isStatic=1 AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<='"+DateUtil.format(end)+"' ";
		Object manyiCount = statisticalSalerManageImpl.queryCount(manyiSql);
		request.setAttribute("manyiCount", manyiCount);
		
		String manyiTotalSql="SELECT COUNT(*) as total FROM hf_visitrecord hfv,cust_customerpidbookingrecord cpid,cust_customer cust WHERE " +
				"hfv.customerId=cust.dbid AND cpid.customerId=cust.dbid " +
				"AND hfv.isStatic=1 AND cpid.hfStatus=3 AND cust.bussiStaffId="+user.getDbid()+" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<='"+DateUtil.format(end)+"' ";
		Object manyiTotalCount = statisticalSalerManageImpl.queryCount(manyiTotalSql);
		request.setAttribute("manyiTotalCount", manyiTotalCount);
		
	} catch (Exception e) {
		e.printStackTrace();
		log.error(e);
	}
	return "visitRecord";
}
}
