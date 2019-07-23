package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.DateNum;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("qywxRoomManageFlowReportAction")
@Scope("prototype")
public class QywxRoomManageFlowReportAction extends BaseController{
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	private UserManageImpl userManageImpl;
	private StatisticalManageImpl statisticalManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private DepartmentManageImpl departmentManageImpl;
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	@Resource
	public void setStatisticalManageImpl(StatisticalManageImpl statisticalManageImpl) {
		this.statisticalManageImpl = statisticalManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	/**
	 * 功能描述：客户流失日报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start);
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date());
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			//客户流失总量
			String flowTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					" FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 And "+selSql+" ";
			Object flowTotalNum = statisticalSalerManageImpl.queryCount(flowTotalNumSql);
			request.setAttribute("flowTotalNum", flowTotalNum);
			//当天客户流失总量
			String todayTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1"+
					" AND clb.approvalDate>='"+DateUtil.format(start)+"' AND clb.approvalDate<'"+DateUtil.format(end)+"' and cust.customerType=1 AND clb.approvalStatus=1 And "+selSql+" ";
			Object todayTotalNum = statisticalSalerManageImpl.queryCount(todayTotalNumSql);
			request.setAttribute("todayTotalNum", todayTotalNum);
			
			//部门查询(一网）
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				List<Department> depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM	cust_customer cust,cust_customerlastbussi clb,sys_department dep " +
					"WHERE" +
					" cust.dbid=clb.customerId AND cust.lastResult>1 AND dep.dbid=cust.departmentId AND dep.parentId=paramDepId"+
					"  AND clb.approvalDate>='"+DateUtil.format(start)+"' AND clb.approvalDate<'"+DateUtil.format(end)+"' and cust.customerType=1 AND clb.approvalStatus=1 And "+selSql+"  GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			
			//购买其他品牌
			String buyOtherSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.BUYOTHER+"  AND clb.approvalStatus=1 "+
					" AND clb.approvalDate>='"+DateUtil.format(start)+"' AND clb.approvalDate<'"+DateUtil.format(end)+"' and cust.customerType=1 AND clb.approvalStatus=1 And "+selSql+" ";
			Object buyOther = statisticalSalerManageImpl.queryCount(buyOtherSql);
			request.setAttribute("buyOther", buyOther);
			//购买计划取消
			String buyPlanSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.CANCCEL+"  AND clb.approvalStatus=1 "+
					" AND clb.approvalDate>='"+DateUtil.format(start)+"' AND clb.approvalDate<'"+DateUtil.format(end)+"' and cust.customerType=1 AND clb.approvalStatus=1 And "+selSql+" ";
			Object buyPlan = statisticalSalerManageImpl.queryCount(buyPlanSql);
			request.setAttribute("buyPlan", buyPlan);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFlow";
	}
	/**
	 * 功能描述：客户流失月报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFlowMonth() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
				title=startTime+"集客报表";
			}else{
				title=format.format(new Date())+"集客报表";
				start=format.format(new Date());
			}
			request.setAttribute("monthDay", start.subSequence(5,7));
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"DATE_FORMAT(clb.approvalDate,'%d') AS createFolderTime,COUNT(DATE_FORMAT(clb.approvalDate,'%d')) AS totalNum " +
					"FROM " +
					"cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 "+
					"and DATE_FORMAT(clb.approvalDate,'%Y-%m')='"+start+"' AND cust.customerType=1 "+" And "+selSql+
					" GROUP BY DATE_FORMAT(clb.approvalDate,'%d')";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			int param=0;
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				for (DateNum dateNum : customerWeekDateNums) {
					avageCustomer=avageCustomer+dateNum.getTotalNum();
					if(param==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					param++;
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			if(param!=0){
				request.setAttribute("avageCustomer", avageCustomer/param);
			}else{
				request.setAttribute("avageCustomer", 0);
			}
			//客户流失总量
			String flowTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					" FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1  And "+selSql;
			Object flowTotalNum = statisticalSalerManageImpl.queryCount(flowTotalNumSql);
			request.setAttribute("flowTotalNum", flowTotalNum);
			//当前7周客户流失量
			String todayTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 "+
					"and DATE_FORMAT(clb.approvalDate,'%Y-%m')='"+start+"' AND cust.customerType=1  And "+selSql;
			Object todayTotalNum = statisticalSalerManageImpl.queryCount(todayTotalNumSql);
			request.setAttribute("todayTotalNum", todayTotalNum);
			
			//部门查询(一网）
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				List<Department> depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM	cust_customer cust,cust_customerlastbussi clb,sys_department dep " +
					"WHERE" +
					" cust.dbid=clb.customerId AND cust.lastResult>1 AND dep.dbid=cust.departmentId AND dep.parentId=paramDepId  And "+selSql+
					"  AND DATE_FORMAT(clb.approvalDate,'%Y-%m')='"+start+"' and cust.customerType=1 GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			
			//购买其他品牌
			String buyOtherSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.BUYOTHER+"  AND clb.approvalStatus=1 And "+selSql+
					" AND DATE_FORMAT(clb.approvalDate,'%Y-%m')='"+start+"' and cust.customerType=1";
			Object buyOther = statisticalSalerManageImpl.queryCount(buyOtherSql);
			request.setAttribute("buyOther", buyOther);
			//购买计划取消
			String buyPlanSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.CANCCEL+"  AND clb.approvalStatus=1 And "+selSql+
					" AND DATE_FORMAT(clb.approvalDate,'%Y-%m')='"+start+"' and cust.customerType=1";
			Object buyPlan = statisticalSalerManageImpl.queryCount(buyPlanSql);
			request.setAttribute("buyPlan", buyPlan);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFlowMonth";
	}
	/**
	 * 功能描述：客户流失月报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFlowYear() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
				title=startTime+"集客报表";
			}else{
				title=format.format(new Date())+"集客报表";
				start=format.format(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			request.setAttribute("monthDay",start);
			request.setAttribute("nowMonthDay",format.format(new Date()));
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"MONTH(clb.approvalDate) AS createFolderTime,COUNT(MONTH(clb.approvalDate)) AS totalNum " +
					"FROM " +
					"cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 And "+selSql+
					" and YEAR(clb.approvalDate)='"+start+"' AND cust.customerType=1 "+
					"GROUP BY MONTH(clb.approvalDate)";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			int i=0;
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				for (DateNum dateNum : customerWeekDateNums) {
					if(i==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"月'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"月'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					i++;
					if(i!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
					}
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
				if(i>1){
					if(start.equals(format.format(new Date()))){
						request.setAttribute("avageCustomer", avageCustomer/(i-1));
					}else{
						request.setAttribute("avageCustomer", avageCustomer/i);
					}
				}else{
					request.setAttribute("avageCustomer", avageCustomer/i);
				}
				request.setAttribute("monthNum", i);
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			//客户流失总量
			String flowTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					" FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 And "+selSql;
			Object flowTotalNum = statisticalSalerManageImpl.queryCount(flowTotalNumSql);
			request.setAttribute("flowTotalNum", flowTotalNum);
			//当前7周客户流失量
			String todayTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 And "+selSql+
					" and YEAR(clb.approvalDate)='"+start+"' AND cust.customerType=1";
			Object todayTotalNum = statisticalSalerManageImpl.queryCount(todayTotalNumSql);
			request.setAttribute("todayTotalNum", todayTotalNum);
			
			
			
			//购买其他品牌
			String buyOtherSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.BUYOTHER+"  AND clb.approvalStatus=1 And "+selSql+
					" AND YEAR(clb.approvalDate)='"+start+"' and cust.customerType=1";
			Object buyOther = statisticalSalerManageImpl.queryCount(buyOtherSql);
			request.setAttribute("buyOther", buyOther);
			//购买计划取消
			String buyPlanSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.CANCCEL+"  AND clb.approvalStatus=1 And "+selSql+
					" AND YEAR(clb.approvalDate)='"+start+"' and cust.customerType=1";
			Object buyPlan = statisticalSalerManageImpl.queryCount(buyPlanSql);
			request.setAttribute("buyPlan", buyPlan);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFlowYear";
	}
	/**
	 * 功能描述：客户流失周报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFlowWeek() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start);
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date());
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"WEEKOFYEAR(clb.approvalDate) as createFolderTime,COUNT(*) as totalNum " +
					"FROM " +
					"cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 "+
					"and (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(clb.approvalDate))<7 AND  YEAR(CURDATE())=YEAR(clb.approvalDate) AND cust.customerType=1 And "+selSql+
					" GROUP BY WEEKOFYEAR(clb.approvalDate) ORDER BY WEEKOFYEAR(clb.approvalDate)";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			int param=0;
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				for (DateNum dateNum : customerWeekDateNums) {
					avageCustomer=avageCustomer+dateNum.getTotalNum();
					if(param==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"周'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"周'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					param++;
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			if(param!=0){
				request.setAttribute("avageCustomer", avageCustomer/param);
			}else{
				request.setAttribute("avageCustomer", 0);
			}
			//客户流失总量
			String flowTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					" FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 And "+selSql;
			
			Object flowTotalNum = statisticalSalerManageImpl.queryCount(flowTotalNumSql);
			request.setAttribute("flowTotalNum", flowTotalNum);
			//当前7周客户流失量
			String todayTotalNumSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult>"+Customer.SUCCESS+"  AND clb.approvalStatus=1 "+
					"and (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(clb.approvalDate))<7 AND  YEAR(CURDATE())=YEAR(clb.approvalDate) AND cust.customerType=1 And "+selSql;;
			Object todayTotalNum = statisticalSalerManageImpl.queryCount(todayTotalNumSql);
			request.setAttribute("todayTotalNum", todayTotalNum);
			
			//部门查询(一网）
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM department WHERE parentId="+saleDepart.getDbid();
				List<Department> depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM	cust_customer cust,cust_customerlastbussi clb,sys_department dep " +
					"WHERE" +
					" cust.dbid=clb.customerId AND cust.lastResult>1 AND dep.dbid=cust.departmentId AND dep.parentId=paramDepId"+
					"  AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(clb.approvalDate))<7 AND  YEAR(CURDATE())=YEAR(clb.approvalDate) and cust.customerType=1 And "+selSql+" GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			
			//购买其他品牌
			String buyOtherSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.BUYOTHER+"  AND clb.approvalStatus=1 "+
					" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(clb.approvalDate))<7 AND  YEAR(CURDATE())=YEAR(clb.approvalDate) and cust.customerType=1 And "+selSql;
			Object buyOther = statisticalSalerManageImpl.queryCount(buyOtherSql);
			request.setAttribute("buyOther", buyOther);
			//购买计划取消
			String buyPlanSql="SELECT " +
					"COUNT(*) as total " +
					"FROM cust_customer cust,cust_customerlastbussi clb " +
					"WHERE " +
					"cust.dbid=clb.customerId AND cust.lastResult="+Customer.CANCCEL+"  AND clb.approvalStatus=1 "+
					" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(clb.approvalDate))<7 AND  YEAR(CURDATE())=YEAR(clb.approvalDate) and cust.customerType=1 And "+selSql;
			Object buyPlan = statisticalSalerManageImpl.queryCount(buyPlanSql);
			request.setAttribute("buyPlan", buyPlan);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFlowWeek";
	}
	
}
