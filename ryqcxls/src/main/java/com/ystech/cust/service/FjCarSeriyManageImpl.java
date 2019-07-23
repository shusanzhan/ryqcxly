package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.FjCarSeriy;

@Component("fjCarSeriyManageImpl")
public class FjCarSeriyManageImpl extends HibernateEntityDao<FjCarSeriy>{
	/**
	 * 功能描述：获取车系加装装饰
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjCarSeriy> findByDecore(String dateSql,Integer customerType){
		String sql="SELECT " +
				"cs.dbid,cs.`name`,COUNT(cust.dbid) AS successNum,SUM(ocd.acturePrice) AS acturePrice,SUM(ocd.decoreSaleTotalPrce) AS decoreSaleTotalPrce," +
				"SUM(ocd.acturePrice)/COUNT(cust.dbid) AS avg,SUM(ocd.acturePrice)/SUM(ocd.decoreSaleTotalPrce) AS zkl,SUM(ocd.giveTotalPrice) AS giveTotalPrice " +
				"FROM " +
				"set_carseriy cs,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractdecore ocd " +
				"WHERE " +
				"cs.dbid=cpid.carSeriyId AND cust.dbid=cpid.customerId AND ocd.customerId=cust.dbid " +
				"AND cpid.pidStatus=2 AND cust.customerType="+customerType+" "+dateSql+" " +
				" GROUP BY cs.dbid ORDER BY acturePrice DESC";
		List<FjCarSeriy> fjSalers = createQuerySql(sql, FjCarSeriy.class, null);
		return fjSalers;
	}
	/**
	 * 功能描述：获取部门 贷款服务费
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	public List<FjCarSeriy> findByLoan(String dateSql,Integer customerType){
		String sql="SELECT A.dbid,A.name,A.successNum,B.loanNum,B.loanPrice,B.loanNum/A.successNum AS stl,B.loanPrice/B.loanNum AS avg " +
				"FROM( " +
				"SELECT " +
				"cs.dbid,cs.name,COUNT(cust.dbid) AS successNum " +
				"FROM " +
				"set_carseriy cs,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce " +
				"WHERE " +
				"cs.dbid=cpid.carSeriyId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid " +
				"AND cpid.pidStatus=2 AND  cust.customerType="+customerType+" " +dateSql+
				" GROUP BY cs.dbid" +
				")A " +
				"LEFT JOIN " +
				"(" +
				" SELECT " +
				" cs.dbid,COUNT(cust.dbid) AS loanNum,SUM(oceci.price) AS loanPrice " +
				"FROM " +
				"set_carseriy cs,cust_customerpidbookingrecord cpid,cust_customer cust,cust_ordercontractexpenses oce,cust_ordercontractexpenseschargeitem oceci " +
				"WHERE " +
				"cs.dbid=cpid.carSeriyId AND cust.dbid=cpid.customerId AND oce.customerId=cust.dbid AND oceci.orderContractExpressId=oce.dbid ";
		if(customerType==Customer.CUSTOMERTYPECOMM){
			sql=sql+" AND  oceci.chargeItemId=8";
		}
		if(customerType==Customer.CUSTOMERTYPENETTOW){
			sql=sql+" AND  oceci.chargeItemId=9";
		}
		sql=sql+" AND cpid.pidStatus=2   AND cust.customerType="+customerType+" " +dateSql+
				"	GROUP BY cs.dbid " +
				")B " +
				"ON A.dbid=B.dbid ORDER BY B.loanPrice DESC";
		List<FjCarSeriy> fjDeps = createQuerySql(sql, FjCarSeriy.class, null);
		return fjDeps;
	}
}
