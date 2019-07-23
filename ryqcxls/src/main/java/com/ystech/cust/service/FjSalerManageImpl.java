package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.FjSaler;

@Component("fjSalerManageImpl")
public class FjSalerManageImpl extends HibernateEntityDao<FjSaler>{
	/**
	 * 功能描述：获取销售顾问附加总金额
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjSaler> findByFjzje(String dateSql,Integer customerType){
		String sql="SELECT " +
				"us.dbid,us.realName,COUNT(cust.dbid) AS successNum,SUM(oce.fjzje) AS fjzje,SUM(oce.fjzje)/COUNT(cust.dbid) AS avg " +
				"FROM " +
				"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE " +
				"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" "+dateSql+" GROUP BY us.dbid ORDER BY fjzje DESC";
		List<FjSaler> fjSalers = createQuerySql(sql, FjSaler.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取销售顾问加装装饰
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjSaler> findByDecore(String dateSql,Integer customerType){
		String sql="";
		if(Customer.CUSTOMERTYPECOMM==customerType){
			sql="SELECT " +
					"us.realName,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice,SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce," +
					"SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg,SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
					"FROM " +
					"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
					"WHERE " +
					"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid " +
					"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" "+dateSql+" " +
					" GROUP BY us.dbid ORDER BY acturePrice DESC";
		}
		if(Customer.CUSTOMERTYPENETTOW==customerType){
			sql="SELECT " +
				"dep.`name` AS realName,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice,SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce," +
				"SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg,SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
				"FROM " +
				"sys_user us,sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
				"WHERE " +
				"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid AND dep.dbid=cust.successDepartmentId " +
				"AND cpid.pidStatus=2 AND acturePrice>0 AND cust.customerType="+customerType+" "+dateSql+" " +
				" GROUP BY us.dbid ORDER BY acturePrice DESC";
		}
		
		List<FjSaler> fjSalers = createQuerySql(sql, FjSaler.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取销售顾问 贷款服务费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjSaler> findByLoan(String dateSql,Integer customerType){
		String sql="";
		if(customerType==Customer.CUSTOMERTYPECOMM){
			sql="SELECT A.dbid,A.realName,A.successNum,B.loanNum,B.loanPrice,B.loanNum/A.successNum AS stl,B.loanPrice/B.loanNum AS avg " +
					"FROM( " +
					"SELECT " +
					"us.dbid,us.realName,COUNT(cust.dbid) AS successNum " +
					"FROM " +
					"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
					"WHERE " +
					"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid  " +
					"AND cpid.pidStatus=2 AND  cust.customerType="+customerType+" " +dateSql+
					" GROUP BY us.dbid" +
					")A " +
					"LEFT JOIN " +
					"(" +
					" SELECT " +
					" us.dbid,COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice " +
					"FROM " +
					"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci " +
					"WHERE " +
					"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND oceci.orderContractExpressId=oce.dbid " +
					"AND cpid.pidStatus=2 AND oceci.chargeItemId=8  AND cust.customerType="+customerType+" " +dateSql+
					"	GROUP BY us.dbid " +
					")B " +
					"ON A.dbid=B.dbid ORDER BY B.loanPrice DESC";
		}
		if(customerType==Customer.CUSTOMERTYPENETTOW){
			sql="SELECT A.dbid,A.`name`,A.successNum,B.loanNum,B.loanPrice,B.loanNum/A.successNum AS stl,B.loanPrice/B.loanNum AS avg " +
					"FROM( " +
					"SELECT " +
					"dep.dbid,dep.`name`,COUNT(cust.dbid) AS successNum " +
					"FROM " +
					"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
					"WHERE " +
					"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid  " +
					"AND cpid.pidStatus=2 AND  cust.customerType="+customerType+" " +dateSql+
					" GROUP BY dep.dbid" +
					")A " +
					"LEFT JOIN " +
					"(" +
					" SELECT " +
					" dep.dbid,COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice " +
					"FROM " +
					"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci " +
					"WHERE " +
					"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND oceci.orderContractExpressId=oce.dbid " +
					"AND cpid.pidStatus=2 AND oceci.chargeItemId=9  AND cust.customerType="+customerType+" " +dateSql+
					"	GROUP BY dep.dbid " +
					")B " +
					"ON A.dbid=B.dbid WHERE B.loanNum>0 ORDER BY B.loanPrice DESC";
		}
		List<FjSaler> fjSalers = createQuerySql(sql, FjSaler.class, null);
		return fjSalers;
	}
	/**
	 * 统计成交量
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public Object countSuccess(String dateSql,Integer customerType) {
		//自有店数据统计合
		String sql="SELECT " +
				"COUNT(*) as total " +
				"FROM sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
				"WHERE" +
				" dep.dbid=cust.successDepartmentId AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
				" "+dateSql+" and cust.customerType="+customerType;
		Object countBySql = countBySql(sql);
		return countBySql;
	}
	/**
	 * 统计 附加总金额
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public Object countFjzje(String dateSql,Integer customerType) {
		//自有店数据统计合
		String sql="SELECT " +
				"SUM(oce.fjzje) AS fjzje " +
				"FROM " +
				"cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE" +
				" cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
				" "+dateSql+" and cust.customerType="+customerType;
		Object fjzje = countBySql(sql);
		return fjzje;
	}
	/**
	 * 统计装饰
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public Object countDecore(String dateSql,Integer customerType) {
		//自有店数据统计合
		String sql="SELECT " +
				"SUM(ocd.acturePrice) AS acturePrice " +
				"FROM " +
				"cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd  " +
				"WHERE" +
				"  cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
				" "+dateSql+" and cust.customerType="+customerType;
		Object fjzje = countBySql(sql);
		return fjzje;
	}
	/**
	 * 统计 贷款手续费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjSaler> countLoan(String dateSql,Integer customerType) {
		//自有店数据统计合
		String sql="SELECT " +
				"COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice  " +
				"FROM " +
				"cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci " +
				"WHERE" +
				" cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND oceci.orderContractExpressId=oce.dbid ";
		if(customerType==Customer.CUSTOMERTYPECOMM){
			sql=sql+" AND cpid.pidStatus=2 AND oceci.chargeItemId=8";
		}
		if(customerType==Customer.CUSTOMERTYPENETTOW){
			sql=sql+" AND cpid.pidStatus=2 AND oceci.chargeItemId=9";
		}
				
		sql=sql+		" AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
				" "+dateSql+" and cust.customerType="+customerType;
		List<FjSaler> fjSalers = createQuerySql(sql, FjSaler.class, null);
		return fjSalers;
}
	
}
