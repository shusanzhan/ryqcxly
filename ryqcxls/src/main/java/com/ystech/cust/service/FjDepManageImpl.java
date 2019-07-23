package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.FjDep;

@Component("fjDepManageImpl")
public class FjDepManageImpl extends HibernateEntityDao<FjDep>{
	/**
	 * 功能描述：获取部门
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByFjzje(String dateSql,Integer customerType,Integer parentId){
		String sql="SELECT " +
				"dep.dbid,dep.`name`,COUNT(cust.dbid) AS successNum,SUM(oce.fjzje) AS fjzje,SUM(oce.fjzje)/COUNT(cust.dbid) AS avg " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce  " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND dep.parentId="+parentId+" " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" "+dateSql+" GROUP BY dep.dbid ORDER BY fjzje DESC";
		List<FjDep> fjSalers = createQuerySql(sql, FjDep.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取部门加装装饰
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByDecore(String dateSql,Integer customerType,Integer parentId){
		String sql="SELECT " +
				"dep.dbid,dep.`name`,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice,SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce," +
				"SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg,SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid AND dep.parentId="+parentId+" " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" "+dateSql+" " +
				" GROUP BY dep.dbid ORDER BY acturePrice DESC";
		List<FjDep> fjSalers = createQuerySql(sql, FjDep.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取二网 市场专员装饰统计
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByDecoreManager(String dateSql){
		String sql="SELECT " +
				"us.dbid,us.realName,SUM(B.successNum) AS successNum, SUM(B.acturePrice) AS acturePrice," +
				"SUM(B.decoreSaleTotalPrce) AS decoreSaleTotalPrce,SUM(B.acturePrice)/SUM(B.successNum) AS avg," +
				"SUM(B.acturePrice)/SUM(B.decoreSaleTotalPrce) AS zkl,SUM(B.giveTotalPrice) AS giveTotalPrice" +
				" FROM sys_user us," +
				"(SELECT " +
				"dep.dbid,dep.`name`,dep.manager,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice," +
				"SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce,SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg," +
				"SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId  AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid  " +
				"AND cpid.pidStatus=2 AND cust.customerType="+Customer.CUSTOMERTYPENETTOW+" "+dateSql+" "+
				"GROUP BY dep.dbid ORDER BY acturePrice DESC)B " +
				"WHERE us.dbid=B.manager GROUP BY us.dbid ORDER BY acturePrice DESC";
		List<FjDep> fjSalers = createQuerySql(sql, FjDep.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取二网 区域装饰统计
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByDecoreDist(String dateSql){
		String sql="SELECT " +
				"dist.dbid,dist.`name`,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice," +
				"SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce,SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg," +
				"SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
				"FROM " +
				"cust_distributortype dist,sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
				"WHERE " +
				"dist.dbid=us.distributorTypeId  AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid AND us.userType=2 AND cust.bussiStaffId=us.dbid " +
				"AND cpid.pidStatus=2 AND cust.customerType="+Customer.CUSTOMERTYPENETTOW+" "+dateSql+" "+
				"GROUP BY dist.dbid ORDER BY acturePrice DESC";
		List<FjDep> fjSalers = createQuerySql(sql, FjDep.class, null);
		return fjSalers;
	}
	
	/**
	 * 功能描述：获取部门 贷款服务费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByLoan(String dateSql,Integer customerType,Integer parentId){
		String sql="SELECT A.dbid,A.name,A.successNum,B.loanNum,B.loanPrice,B.loanNum/A.successNum AS stl,B.loanPrice/B.loanNum AS avg " +
				"FROM( " +
				"SELECT " +
				"dep.dbid,dep.name,COUNT(cust.dbid) AS successNum " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid  AND dep.parentId="+parentId+" " +
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
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND oceci.orderContractExpressId=oce.dbid AND dep.parentId="+parentId+" " +
				"AND cpid.pidStatus=2 AND oceci.chargeItemId=8  AND cust.customerType="+customerType+" " +dateSql+
				"	GROUP BY dep.dbid " +
				")B " +
				"ON A.dbid=B.dbid ORDER BY B.loanPrice DESC";
		List<FjDep> fjDeps = createQuerySql(sql, FjDep.class, null);
		return fjDeps;
	}
	/**
	 * 功能描述：获取二网 区域专员 按揭服务费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByLoanManager(String dateSql,Integer customerType){
		String sql="SELECT  " +
				"us.dbid,us.realName,SUM(R.successNum) AS successNum,SUM(R.loanNum) AS loanNum,SUM(R.loanPrice) AS loanPrice," +
				"SUM(R.loanNum)/SUM(R.successNum) AS stl,SUM(R.loanPrice)/SUM(R.loanNum) AS avg " +
				"FROM " +
				"sys_user us," +
				"(" +
				"SELECT " +
				"A.dbid,B.manager,A.successNum,B.loanNum,B.loanPrice " +
				"FROM " +
				"(SELECT " +
				"dep.dbid,dep.name,COUNT(cust.dbid) AS successNum " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" " +dateSql+
				" GROUP BY dep.dbid " +
				")A " +
				"LEFT JOIN" +
				"(" +
				"SELECT  " +
				"dep.dbid,dep.`name`,dep.manager,COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice " +
				"FROM " +
				"sys_department dep,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci" +
				" " +
				"WHERE " +
				"dep.dbid=cust.successDepartmentId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid " +
				"AND oceci.orderContractExpressId=oce.dbid  AND cpid.pidStatus=2 " +
				"AND oceci.chargeItemId=9  AND cust.customerType="+customerType+" " +dateSql+
				" GROUP BY dep.dbid" +
				")B ON A.dbid=B.dbid" +
				")R " +
				"WHERE us.dbid=R.manager GROUP BY us.dbid ORDER BY R.loanPrice DESC";
		List<FjDep> fjDeps = createQuerySql(sql, FjDep.class, null);
		return fjDeps;
	}
	/**
	 * 功能描述：获取二网 区域 按揭服务费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjDep> findByLoanDist(String dateSql,Integer customerType){
		String sql="SELECT " +
				"dist.dbid,dist.`name`,SUM(R.successNum) AS successNum,SUM(R.loanNum) AS loanNum,SUM(R.loanPrice) AS loanPrice," +
				"SUM(R.loanNum)/SUM(R.successNum) AS stl,SUM(R.loanPrice)/SUM(R.loanNum) AS avg " +
				"FROM " +
				"sys_user us,cust_distributortype dist,(" +
				"SELECT " +
				"A.dbid,A.successNum,B.loanNum,B.loanPrice " +
				"FROM " +
				"(SELECT " +
				"us.dbid,COUNT(cust.dbid) AS successNum " +
				"FROM " +
				"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE " +
				"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND us.userType=2 " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" " +dateSql+
				"GROUP BY us.dbid" +
				")A " +
				"LEFT JOIN" +
				"(" +
				"SELECT " +
				"us.dbid,COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice " +
				"FROM " +
				"sys_user us,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci " +
				"WHERE " +
				"us.dbid=cust.bussiStaffId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND us.userType=2 " +
				"AND oceci.orderContractExpressId=oce.dbid  AND cpid.pidStatus=2 " +
				"AND oceci.chargeItemId=9 AND cust.customerType="+customerType+" " +dateSql+
				"GROUP BY us.dbid" +
				")B ON A.dbid=B.dbid" +
				")R WHERE us.dbid=R.dbid AND us.distributorTypeId=dist.dbid GROUP BY dist.dbid ORDER BY loanPrice DESC";
		List<FjDep> fjDeps = createQuerySql(sql, FjDep.class, null);
		return fjDeps;
	}
}
