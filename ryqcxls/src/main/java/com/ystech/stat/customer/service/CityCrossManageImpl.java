package com.ystech.stat.customer.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.stat.customer.model.CityCrossCount;

@Component("cityCrossManageImpl")
public class CityCrossManageImpl {
	/**
	 * 功能描述：查询同城交叉客户
	 * @param startDate
	 * @param endDate
	 * @param enterpriseId
	 * @param type
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public List<CityCrossCount> queryStatCityCross(String startDate,String endDate,Integer enterpriseId,int type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT " +
				   " city.dbid AS dbid,"
				   + "	city.`name` AS name,"
				   + "  IFNULL(A.totalNum,0)  AS totalCount,"
				   + "  IFNULL(B.totalNum,0)  AS totalOrderCount,"
				   + "	IFNULL(IFNULL(B.totalNum,0)/IFNULL(A.totalNum,0),0)*100 orderPer,"
				   + "  IFNULL(C.totalNum,0)  AS totalFlowCount,"
				   + "	IFNULL(IFNULL(C.totalNum,0)/IFNULL(A.totalNum,0),0)*100 flowPer  "
				   +" FROM "+
				   " cust_citycrosscustomer as city "
				   + "LEFT JOIN("
				   + "		SELECT"
				   + "		cityCrossCustomerId,"
				   + "		COUNT(*) as totalNum"
				   + "		FROM"
				   + "			cust_customer cust "
				   + "		WHERE 1=1  AND recordType=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}	
		sql=sql+ " GROUP BY cityCrossCustomerId"
				+ "	)A ON	city.dbid=A.cityCrossCustomerId"
				+ " LEFT JOIN ("
				+ "		SELECT"
				+ "		cityCrossCustomerId,"
				+ "		COUNT(*) as totalNum"
				+ "		FROM"
				+ "			cust_customer cust,"
				+ "      cust_ordercontract corder "
				+ "WHERE  1=1 AND cust.dbid=corder.customerId  AND recordType=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql+" 	GROUP BY cityCrossCustomerId"
				+ "	)B ON	city.dbid=B.cityCrossCustomerId"
				+ "	LEFT JOIN ("
				+ "		SELECT"
				+ "		cityCrossCustomerId,"
				+ "		COUNT(*) as totalNum"
				+ "		FROM"
				+ "			cust_customer cust,"
				+ "      cust_customerlastbussi cl"
				+ "		WHERE  1=1 AND cust.dbid=cl.customerId AND recordType=1 AND cl.approvalStatus=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql+"	GROUP BY cityCrossCustomerId"
				+ " )C ON	city.dbid=C.cityCrossCustomerId "
				+ "WHERE "
				+ "city.enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CityCrossCount> sityCrossCounts=new ArrayList<CityCrossCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			sityCrossCounts = ResultSetUtil.getDateResult(sityCrossCounts, resultSet, CityCrossCount.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return sityCrossCounts;
	}
	/**
	 * 功能描述：查询同城交叉客户
	 * @param startDate
	 * @param endDate
	 * @param enterpriseId
	 * @param type
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public CityCrossCount queryStatCityCrossTotal(String startDate,String endDate,Integer enterpriseId,int type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT " +
				" city.dbid AS dbid,"
				+ "	city.`name` AS name,"
				+ "  IFNULL(A.totalNum,0)  AS totalCount,"
				+ "  IFNULL(B.totalNum,0)  AS totalOrderCount,"
				+ "	IFNULL(IFNULL(B.totalNum,0)/IFNULL(A.totalNum,0),0)*100 orderPer,"
				+ "  IFNULL(C.totalNum,0)  AS totalFlowCount,"
				+ "	IFNULL(IFNULL(C.totalNum,0)/IFNULL(A.totalNum,0),0)*100 flowPer  "
				+" FROM "+
				" cust_citycrosscustomer as city,"
				+ "("
				+ "		SELECT"
				+ "		COUNT(*) as totalNum"
				+ "		FROM"
				+ "			cust_customer cust "
				+ "		WHERE 1=1 AND recordType=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}	
		sql=sql+ " "
				+ "	)A,"
				+ " ("
				+ "		SELECT"
				+ "		COUNT(*) as totalNum"
				+ "		FROM"
				+ "			cust_customer cust,"
				+ "      cust_ordercontract corder "
				+ "WHERE  1=1 AND cust.dbid=corder.customerId AND recordType=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql+" 	"
				+ "	)B, ("
				+ "		SELECT"
				+ "		COUNT(*) as totalNum"
				+ "		FROM"
				+ "			cust_customer cust,"
				+ "      cust_customerlastbussi cl"
				+ "		WHERE  1=1 AND cust.dbid=cl.customerId AND recordType=1 AND cl.approvalStatus=1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+startDate +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+endDate+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" and cust.enterpriseId="+enterpriseId;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql		+ " )C "
				+ "WHERE "
				+ "city.enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CityCrossCount> sityCrossCounts=new ArrayList<CityCrossCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			sityCrossCounts = ResultSetUtil.getDateResult(sityCrossCounts, resultSet, CityCrossCount.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!sityCrossCounts.isEmpty()){
			return sityCrossCounts.get(0);
		}
		return null;
	}
}
