package com.ystech.stat.customer.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.stat.customer.model.ComeShop;
import com.ystech.stat.customer.model.ComeShopType;
import com.ystech.stat.customer.model.ComeShopUser;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.SortByDbidComparator;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("comeShopManageImpl")
public class ComeShopManageImpl {
	/**
	 * 功能描述：
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<ComeShop> queryComeShop(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
				+ "A.createDate,"
				+ "A.createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS comeShopNum,"
				+ "IFNULL(D.twoComeShopNum,0) AS twoComeShopNum,"
				+ "IFNULL(C.comeShopOrderNum,0) AS comeShopOrderNum,"
				+ "IFNULL(C.comeShopOrderNum/B.comeShopNum*100,0) AS comeShopOrderPer,"
				+ "IFNULL(B.comeShopNum,0)+IFNULL(D.twoComeShopNum,0) AS totalComeShopNum,"
				+ "IFNULL(C.comeShopTwoOrderNum,0) AS comeShopTwoOrderNum,"
				+ "IFNULL(C.comeShopTotalOrderNum,0) AS comeShopTotalOrderNum,"
				+ "IFNULL(C.comeShopTotalOrderNum/(IFNULL(B.comeShopNum,0)+IFNULL(D.twoComeShopNum,0))*100,0) AS comeShopTotalOrderPer "
				+ "FROM"
				+ "	("
				+ "		SELECT"
				+ "			DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,COUNT(*) AS createFolderNum"
				+ "		FROM"
				+ "		cust_customer"
				+ "		WHERE 1=1 AND recordType=1 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql+" GROUP BY"
				+ "		DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ ")A "
				+ "LEFT JOIN"
				+ "	(SELECT"
				+ "	DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS comeShopDate,"
				+ "	COUNT(*) AS comeShopNum"
				+ "	FROM "
				+ "	cust_customer"
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
	sql=sql+"	GROUP BY"
			+ "	DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
			+ "	)B "
			+ "ON A.createDate=B.comeShopDate "
			+ "LEFT JOIN"
			+ " 	("
			+ "		SELECT"
			+ "			DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createTime,"
			+ "			COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopOrderNum,"
			+ "			COUNT(IF(comeShopStatus=3,TRUE,NULL)) AS comeShopTwoOrderNum,"
			+ "			COUNT(IF(comeShopStatus>1,TRUE,NULL)) AS comeShopTotalOrderNum"
			+ "		FROM"
			+ "			cust_customer cust,cust_ordercontract custo"
			+ "	WHERE 1=1 AND cust.dbid=custo.customerId AND recordType=1 AND custo.status=4 ";
	if(null!=enterprise){
		sql=sql+" AND enterpriseId="+enterprise.getDbid();
	}
	if(null!=startDate&&startDate.trim().length()>0){
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
	}
	if(null!=endDate&&endDate.trim().length()>0){
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
	}
	if(type>0){
		sql=sql+" AND type="+type;
	}
    sql=sql+"		GROUP BY"
    		+ "			DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
    		+ "	)C"
    		+ "	ON A.createDate=C.createTime "
    		+ "LEFT JOIN "
    		+ "(SELECT"
    		+ "	DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS twoComeShopDate,"
    		+ "	COUNT(*) AS twoComeShopNum "
    		+ "FROM "
    		+ "cust_customer "
			+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus>2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql+ " GROUP BY "
				+ "DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") "
				+ ")D ON A.createDate=D.twoComeShopDate";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShop> staTryCars=new ArrayList<ComeShop>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCars = ResultSetUtil.getDateResult(staTryCars, resultSet, ComeShop.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		sortResult(startDate, endDate, staTryCars, dateType);
		return staTryCars;
	}
	/**
	 * 功能描述：
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public ComeShop queryComeShopTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
				+ "A.createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS comeShopNum,"
				+ "IFNULL(D.twoComeShopNum,0) AS twoComeShopNum,"
				+ "IFNULL(C.comeShopOrderNum,0) AS comeShopOrderNum,"
				+ "IFNULL(C.comeShopOrderNum,0)/IFNULL(B.comeShopNum,0)*100 AS comeShopOrderPer,"
				+ "IFNULL(B.comeShopNum,0)+IFNULL(D.twoComeShopNum,0) AS totalComeShopNum,"
				+ "IFNULL(C.comeShopTwoOrderNum,0) AS comeShopTwoOrderNum,"
				+ "IFNULL(C.comeShopTotalOrderNum,0) AS comeShopTotalOrderNum,"
				+ "IFNULL(C.comeShopTotalOrderNum,0)/(IFNULL(B.comeShopNum,0)+IFNULL(D.twoComeShopNum,0))*100 AS comeShopTotalOrderPer "
				+ "FROM"
				+ "	("
				+ "		SELECT"
				+ "			DATE_FORMAT(createFolderTime,'%Y-%m-%d') AS createDate,COUNT(*) AS createFolderNum"
				+ "		FROM"
				+ "		cust_customer"
				+ "		WHERE 1=1 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
				sql=sql+ ")A "
				+ ","
				+ "	(SELECT"
				+ "	DATE_FORMAT(comeShopDate,'%Y-%m-%d') AS comeShopDate,"
				+ "	COUNT(*) AS comeShopNum"
				+ "	FROM "
				+ "	cust_customer"
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
	sql=sql+ "	)B "
			+ ", "
			+ " 	("
			+ "		SELECT"
			+ "			DATE_FORMAT(custo.createTime,'%Y-%m-%d') AS createTime,"
			+ "			COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopOrderNum,"
			+ "			COUNT(IF(comeShopStatus=3,TRUE,NULL)) AS comeShopTwoOrderNum,"
			+ "			COUNT(IF(comeShopStatus>1,TRUE,NULL)) AS comeShopTotalOrderNum"
			+ "		FROM"
			+ "			cust_customer cust,cust_ordercontract custo"
			+ "	WHERE 1=1 AND cust.dbid=custo.customerId AND recordType=1 AND custo.status=4 ";
	if(null!=enterprise){
		sql=sql+" AND enterpriseId="+enterprise.getDbid();
	}
	if(null!=startDate&&startDate.trim().length()>0){
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
	}
	if(null!=endDate&&endDate.trim().length()>0){
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
	}
	if(type>0){
		sql=sql+" AND type="+type;
	}
    sql=sql		+ "	)C"
    		+ ", "
    		+ "(SELECT"
    		+ "	DATE_FORMAT(twoComeShopDate,'%Y-%m-%d') AS twoComeShopDate,"
    		+ "	COUNT(*) AS twoComeShopNum "
    		+ "FROM "
    		+ "cust_customer "
			+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus>2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql		+ ")D";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShop> staTryCars=new ArrayList<ComeShop>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCars = ResultSetUtil.getDateResult(staTryCars, resultSet, ComeShop.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(staTryCars.isEmpty()){
			return null;
		}else{
			ComeShop comeShop = staTryCars.get(0);
			return comeShop;
		}
	}
	/**
	 * 功能描述：查询首次到店率和二次到店率
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<ComeShopType> queryComeShopType(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
				+ "type.dbid,"
				+ "type.`name`,"
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0)) AS totalNum,"
				+ "IFNULL(C.comeShopNum,0) AS comeShopNum,"
				+ "IFNULL(C.comeShopNum/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100,0) AS comeShopPer,"
				+ "IFNULL(D.twoComeShopNum,0) AS twoComeShopNum,"
				+ "(IFNULL(C.comeShopNum,0)+IFNULL(D.twoComeShopNum,0)) AS totalComeShopNum,"
				+ "IFNULL((IFNULL(C.comeShopNum,0)+IFNULL(D.twoComeShopNum,0))/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100,0) AS comeShopTotalPer "
				+ "FROM "
				+ "cust_customertype type "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		customerTypeId as type,"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer"
				+ "	WHERE 1=1 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" GROUP BY customerTypeId "
				+ ")A "
				+ "ON A.type=type.dbid "
				+ "LEFT JOIN "
				+ "("
				+ "	SELECT"
				+ "	customerTypeId as type,"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE 1=1 AND recordType=1 AND cust.dbid=custc.customerId ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			String formatPatten = DateUtil.formatPatten(beginDate,"yyyy-MM");
			sql=sql+" AND DATE_FORMAT(custc.createDate,'%Y-%m')='"+formatPatten+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" GROUP BY customerTypeId"
				+ ")B "
				+ "ON type.dbid=B.type "
				+ "LEFT JOIN( "
				+ "SELECT "
				+ "customerTypeId as type,"
				+ "COUNT(*) AS comeShopNum "
				+ "FROM "
				+ "cust_customer "
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" GROUP BY customerTypeId)C "
				+ "ON type.dbid=C.type "
				+ "LEFT JOIN "
				+ "("
				+ "	SELECT"
				+ "	customerTypeId as type,"
				+ "	COUNT(*) AS twoComeShopNum "
				+ "FROM"
				+ "	cust_customer "
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus>2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" GROUP BY customerTypeId "
				+ ")D ON type.dbid=D.type";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopType> comeShopTypes=new ArrayList<ComeShopType>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopTypes = ResultSetUtil.getDateResult(comeShopTypes, resultSet, ComeShopType.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return comeShopTypes;
	}
	/**
	 * 功能描述：查询首次到店率和二次到店率汇总
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public ComeShopType queryComeShopTypeTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0)) AS totalNum,"
				+ "IFNULL(C.comeShopNum,0) AS comeShopNum,"
				+ "IFNULL(C.comeShopNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS comeShopPer,"
				+ "IFNULL(D.twoComeShopNum,0) AS twoComeShopNum,"
				+ "(IFNULL(C.comeShopNum,0)+IFNULL(D.twoComeShopNum,0)) AS totalComeShopNum,"
				+ "(IFNULL(C.comeShopNum,0)+IFNULL(D.twoComeShopNum,0))/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS comeShopTotalPer "
				+ "FROM "
				+ " ("
				+ "	SELECT"
				+ "		customerTypeId as type,"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer"
				+ "	WHERE 1=1 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" )A "
				+ ", "
				+ "("
				+ "	SELECT"
				+ "	customerTypeId as type,"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE 1=1 AND recordType=1 AND cust.dbid=custc.customerId ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			String formatPatten = DateUtil.formatPatten(beginDate,"yyyy-MM");
			sql=sql+" AND DATE_FORMAT(custc.createDate,'%Y-%m')='"+formatPatten+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" )B "
				+ ",( "
				+ "SELECT "
				+ "customerTypeId as type,"
				+ "COUNT(*) AS comeShopNum "
				+ "FROM "
				+ "cust_customer "
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" )C "
				+ ", "
				+ "("
				+ "	SELECT"
				+ "	customerTypeId as type,"
				+ "	COUNT(*) AS twoComeShopNum "
				+ "FROM"
				+ "	cust_customer "
				+ "	WHERE 1=1 AND recordType=1 AND comeShopStatus>2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" )D";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopType> comeShopTypes=new ArrayList<ComeShopType>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopTypes = ResultSetUtil.getDateResult(comeShopTypes, resultSet, ComeShopType.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!comeShopTypes.isEmpty()){
			return comeShopTypes.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：获取创建线索关注车型
	 * @param comeShops
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryCreateFolderCarSeriy(List<ComeShop> comeShops,Enterprise enterprise,int type,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ "		WHERE 1=1 AND recordType=1 AND cust.dbid=cb.customerId ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND customerTypeId="+type;
				}
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
			sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(comeShops.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum comeShop : comeShops) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(comeShop.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(comeShop, customerRecordTargets);
			}
			 Map<StaDateNum, List<CarSerCount>> sortMap =new TreeMap<StaDateNum, List<CarSerCount>>(new SortByDateComparator());
		     sortMap.putAll(map);
		 	createStatement.close();
			jdbcConnection.close();
		     return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取创建线索关注车型-总数据
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryCreateFolderCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ "	 1=1 AND recordType=1 AND cust.dbid=cb.customerId ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount>  carSerCounts=new ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：获取到店客户关注车型
	 * @param comeShops
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryComeShopCarSeriy(List<ComeShop> comeShops,Enterprise enterprise,int type,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ "		WHERE 1=1 AND recordType=1 AND cust.dbid=cb.customerId  AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(comeShops.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum comeShop : comeShops) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(comeShop.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(comeShop, customerRecordTargets);
			}
			Map<StaDateNum, List<CarSerCount>> sortMap =new TreeMap<StaDateNum, List<CarSerCount>>(new SortByDateComparator());
			sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取到店客户关注车型
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryComeShopCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ "	 1=1 AND recordType=1 AND cust.dbid=cb.customerId  AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount>  carSerCounts=new ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：获取到店转订单客户关注车型
	 * @param comeShops
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryComeShopOrderCarSeriy(List<ComeShop> comeShops,Enterprise enterprise,int type,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "FROM"
				+ "		cust_customer cust,cust_ordercontract custo,cust_customerbussi cb "
				+ "		WHERE"
				+ "  cust.dbid=custo.customerId AND recordType=1 AND cust.dbid=cb.customerId AND custo.status=4  AND comeShopStatus>=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(comeShops.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum comeShop : comeShops) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(comeShop.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(comeShop, customerRecordTargets);
			}
			Map<StaDateNum, List<CarSerCount>> sortMap =new TreeMap<StaDateNum, List<CarSerCount>>(new SortByDateComparator());
			sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取到店转订单客户关注车型
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryComeShopOrderCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ "	cust_customer cust,cust_ordercontract custo,cust_customerbussi cb  "
				+ "	WHERE"
				+ " cust.dbid=custo.customerId AND recordType=1 AND cust.dbid=cb.customerId AND custo.status=4  AND comeShopStatus>=2 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount>  carSerCounts=new ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	
	/**
	 * 功能描述：获取当月潜客邀约到店数统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<ComeShopUser> queryComeShopUser(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ "us.dbid,us.realName as realName, "
				+ "IFNULL(B.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS  comeShopNum,"
				+ "IFNULL(IFNULL(B.comeShopNum,0)/IFNULL(B.createFolderNum,0)*100,0) AS comeShopPer,"
				+ "IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "IFNULL(B.totalComeShopNum,0) AS  totalComeShopNum,"
				+ "IFNULL(IFNULL(B.totalComeShopNum,0)/IFNULL(B.createFolderNum,0)*100,0) AS comeShopTotalPer "
				+ "FROM "
				+ "sys_user us LEFT JOIN("
				+ "	SELECT	invitationSalerId,"
				+ "	COUNT(*) AS createFolderNum,"
				+ " COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopNum,"
				+ " COUNT(IF(comeShopStatus>2,TRUE,NULL)) AS twoComeShopNum,"
				+ " COUNT(IF(comeShopStatus>=2,TRUE,NULL)) AS totalComeShopNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 AND recordType=1 ";
				if(type!=null&&type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY invitationSalerId"
				+ ")B ON us.dbid=B.invitationSalerId "
				+ "WHERE us.userState=1 AND us.bussiType<=2 ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<ComeShopUser> statCustomerRecordUsers=new ArrayList<ComeShopUser>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, ComeShopUser.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return statCustomerRecordUsers;	
	}
	/**
	 * 功能描述：获取当月潜客邀约到店数统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public ComeShopUser queryComeShopUserTotal(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ "IFNULL(B.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS  comeShopNum,"
				+ "IFNULL(IFNULL(B.comeShopNum,0)/IFNULL(B.createFolderNum,0)*100,0) AS comeShopPer,"
				+ "IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "IFNULL(B.totalComeShopNum,0) AS  totalComeShopNum,"
				+ "IFNULL(IFNULL(B.totalComeShopNum,0)/IFNULL(B.createFolderNum,0)*100,0) AS comeShopTotalPer "
				+ "FROM "
				+ "( SELECT "
				+ "	COUNT(*) AS createFolderNum,"
				+ " COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopNum,"
				+ " COUNT(IF(comeShopStatus>2,TRUE,NULL)) AS twoComeShopNum,"
				+ " COUNT(IF(comeShopStatus>=2,TRUE,NULL)) AS totalComeShopNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 AND recordType=1 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ ")B ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopUser> comeShopUsers=new ArrayList<ComeShopUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopUsers = ResultSetUtil.getDateResult(comeShopUsers, resultSet, ComeShopUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!comeShopUsers.isEmpty()){
			return comeShopUsers.get(0);
		}
		return null;	
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public Map<ComeShopUser,List<CarSerCount>> queryComeShopUserCarSeriy(List<ComeShopUser> comeShopUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND	invitationSalerId=USERID AND comeShopStatus>=2 ";
				if(type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<ComeShopUser,List<CarSerCount>> map=new HashMap<ComeShopUser, List<CarSerCount>>(comeShopUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (ComeShopUser user : comeShopUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<ComeShopUser,List<CarSerCount>> sortMap =new TreeMap<ComeShopUser, List<CarSerCount>>(new SortByDbidComparator());
		    sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计-汇总
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryComeShopUserCarSeriy(int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId  AND comeShopStatus>=2 ";
		if(type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount> carSerCounts=new  ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	
	/**
	 * 功能描述：获取总潜客邀约到店数统计(含历史）
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<ComeShopUser> queryComeShopUserAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ "us.dbid,us.realName as realName, "
				+ " IFNULL((B.createFolderNum+C.totalNum),0) AS totalNum,"
				+ "IFNULL(B.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS  comeShopNum,"
				+ "	IFNULL(C.totalNum,0) AS keepNum,"
				+ "IFNULL(IFNULL(B.comeShopNum,0)/(B.createFolderNum+C.totalNum)*100,0) AS comeShopPer,"
				+ "IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "IFNULL(B.totalComeShopNum,0) AS  totalComeShopNum,"
				+ "IFNULL(IFNULL(B.totalComeShopNum,0)/(B.createFolderNum+C.totalNum)*100,0) AS comeShopTotalPer "
				+ "FROM "
				+ "sys_user us LEFT JOIN("
				+ "	SELECT	invitationSalerId,"
				+ "	COUNT(*) AS createFolderNum,"
				+ " COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopNum,"
				+ " COUNT(IF(comeShopStatus>2,TRUE,NULL)) AS twoComeShopNum,"
				+ " COUNT(IF(comeShopStatus>=2,TRUE,NULL)) AS totalComeShopNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 AND recordType=1 ";
				if(type!=null&&type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
				}
				sql=sql+ "	GROUP BY invitationSalerId "
				+ ")B ON us.dbid=B.invitationSalerId ";
			Date dateMonth = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			String dateMonthStr = DateUtil.formatPatten(dateMonth, "yyyy-MM");
		    sql=sql+"	LEFT JOIN("
		    		+ "			SELECT"
		    		+ "				invitationSalerId,"
		    		+ "				COUNT(invitationSalerId) AS totalNum"
		    		+ "				FROM"
		    		+ "				cust_customer cust,sta_customercopy scust"
		    		+ "				WHERE"
		    		+ "				1=1 AND recordType=1  AND DATE_FORMAT(scust.createDate,'%Y-%m')>='"+dateMonthStr+"' AND scust.customerId=cust.dbid"
		    		+ "				GROUP BY invitationSalerId "
		    		+ "		)C	ON us.dbid=C.invitationSalerId ";
				sql=sql+ "WHERE us.userState=1 AND us.bussiType<=2 ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<ComeShopUser> statCustomerRecordUsers=new ArrayList<ComeShopUser>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, ComeShopUser.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return statCustomerRecordUsers;	
	}
	/**
	 * 功能描述：获取（总）潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public Map<ComeShopUser,List<CarSerCount>> queryComeShopUserCarSeriyAll(List<ComeShopUser> comeShopUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND	invitationSalerId=USERID AND comeShopStatus>=2 ";
				if(type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
				}
				sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<ComeShopUser,List<CarSerCount>> map=new HashMap<ComeShopUser, List<CarSerCount>>(comeShopUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (ComeShopUser user : comeShopUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<ComeShopUser,List<CarSerCount>> sortMap =new TreeMap<ComeShopUser, List<CarSerCount>>(new SortByDbidComparator());
		    sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取总潜客邀约到店数统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public ComeShopUser queryComeShopUserTotalAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ " IFNULL((B.createFolderNum+C.totalNum),0) AS totalNum,"
				+ "IFNULL(B.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.comeShopNum,0) AS  comeShopNum,"
				+ "	IFNULL(C.totalNum,0) AS keepNum,"
				+ "IFNULL(IFNULL(B.comeShopNum,0)/(B.createFolderNum+C.totalNum)*100,0) AS comeShopPer,"
				+ "IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "IFNULL(B.totalComeShopNum,0) AS  totalComeShopNum,"
				+ "IFNULL(IFNULL(B.totalComeShopNum,0)/(B.createFolderNum+C.totalNum)*100,0) AS comeShopTotalPer "
				+ "FROM "
				+ "( SELECT "
				+ "	COUNT(*) AS createFolderNum,"
				+ " COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopNum,"
				+ " COUNT(IF(comeShopStatus>2,TRUE,NULL)) AS twoComeShopNum,"
				+ " COUNT(IF(comeShopStatus>=2,TRUE,NULL)) AS totalComeShopNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 AND recordType=1 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql+ ")B ";
		Date dateMonth = DateUtil.stringDatePatten(startDate,"yyyy-MM");
		String dateMonthStr = DateUtil.formatPatten(dateMonth, "yyyy-MM");
	    sql=sql+",("
	    		+ "			SELECT"
	    		+ "				COUNT(invitationSalerId) AS totalNum"
	    		+ "				FROM"
	    		+ "				cust_customer cust,sta_customercopy scust"
	    		+ "				WHERE"
	    		+ "				1=1 AND recordType=1  AND DATE_FORMAT(scust.createDate,'%Y-%m')>='"+dateMonthStr+"' AND scust.customerId=cust.dbid"
	    		+ "				"
	    		+ "		)C ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopUser> comeShopUsers=new ArrayList<ComeShopUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopUsers = ResultSetUtil.getDateResult(comeShopUsers, resultSet, ComeShopUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!comeShopUsers.isEmpty()){
			return comeShopUsers.get(0);
		}
		return null;	
	}
	
	/**
	 * 功能描述：获取（总）到店客户-关注车型统计-汇总
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryComeShopUserCarSeriyAll(int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId  AND comeShopStatus>=2 ";
		if(type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount> carSerCounts=new  ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：获取销售顾问来店客户转订单
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @param dateType
	 * @return
	 */
	public List<ComeShopUser> queryComeShopOrderUser(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT"
				+ "		us.dbid,us.realName as realName,"
				+ "		IFNULL(A.comeShopNum,0) AS comeShopNum,"
				+ "		IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "		IFNULL(IFNULL(B.twoComeShopNum,0)+IFNULL(A.comeShopNum,0),0) AS totalComeShopNum,"
				+ "		IFNULL(C.comeShopOrderNum,0) AS comeShopOrderNum,"
				+ "		IFNULL(C.comeShopOrderNum/A.comeShopNum,0)*100 AS comeShopOrderPer,"
				+ "		IFNULL(C.comeShopTwoOrderNum,0) AS comeShopTwoOrderNum,"
				+ "		IFNULL(C.comeShopTotalOrderNum,0) AS comeShopTotalOrderNum,"
				+ "		IFNULL(C.comeShopTotalOrderNum/(IFNULL(B.twoComeShopNum,0)+IFNULL(A.comeShopNum,0)),0)*100 AS comeShopTotalPer"
				+ "		 FROM"
				+ "		 sys_user us LEFT JOIN("
				+ "			SELECT"
				+ "				bussiStaffId,	COUNT(*) AS comeShopNum"
				+ "			FROM"
				+ "				cust_customer"
				+ "			WHERE	1=1 AND recordType=1  AND comeShopStatus=2";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql+" 	GROUP BY bussiStaffId"
				+ "		)A ON us.dbid=A.bussiStaffId"
				+ "		LEFT JOIN"
				+ "		("
				+ "				SELECT"
				+ "				bussiStaffId,	COUNT(*) AS twoComeShopNum"
				+ "			FROM"
				+ "				cust_customer"
				+ "			WHERE	1=1 AND recordType=1  AND comeShopStatus>2";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql +" GROUP BY bussiStaffId"
				+ "		)B"
				+ "		ON us.dbid=B.bussiStaffId "
				+ "		LEFT JOIN"
				+ "		("
				+ "			SELECT"
				+ "					bussiStaffId,"
				+ "					COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopOrderNum,"
				+ "					COUNT(IF(comeShopStatus=3,TRUE,NULL)) AS comeShopTwoOrderNum,"
				+ "					COUNT(IF(comeShopStatus>1,TRUE,NULL)) AS comeShopTotalOrderNum"
				+ "				FROM"
				+ "					cust_customer cust,cust_ordercontract custo"
				+ "				WHERE"
				+ "					cust.dbid=custo.customerId AND recordType=1 AND custo.status=4 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+"		GROUP BY"
				+ "					bussiStaffId"
				+ "			)C"
				+ "		ON us.dbid=C.bussiStaffId"
				+ "		 WHERE us.userState=1 AND us.bussiType<=2";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopUser> comeShopList=new ArrayList<ComeShopUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopList = ResultSetUtil.getDateResult(comeShopList, resultSet, ComeShopUser.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return comeShopList;	
	}
	/**
	 * 功能描述：获取销售顾问来店客户转订单车型
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @param dateType
	 * @return
	 */
	public ComeShopUser queryComeShopOrderUserAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT"
				+ "		IFNULL(A.comeShopNum,0) AS comeShopNum,"
				+ "		IFNULL(B.twoComeShopNum,0) AS  twoComeShopNum,"
				+ "		IFNULL(IFNULL(B.twoComeShopNum,0)+IFNULL(A.comeShopNum,0),0) AS totalComeShopNum,"
				+ "		IFNULL(C.comeShopOrderNum,0) AS comeShopOrderNum,"
				+ "		IFNULL(C.comeShopOrderNum/A.comeShopNum,0)*100 AS comeShopOrderPer,"
				+ "		IFNULL(C.comeShopTwoOrderNum,0) AS comeShopTwoOrderNum,"
				+ "		IFNULL(C.comeShopTotalOrderNum,0) AS comeShopTotalOrderNum,"
				+ "		IFNULL(C.comeShopTotalOrderNum/(IFNULL(B.twoComeShopNum,0)+IFNULL(A.comeShopNum,0)),0)*100 AS comeShopTotalPer"
				+ "		 FROM"
				+ "		 ("
				+ "			SELECT"
				+ "				bussiStaffId,	COUNT(*) AS comeShopNum"
				+ "			FROM"
				+ "				cust_customer"
				+ "			WHERE	1=1 AND recordType=1  AND comeShopStatus=2";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql+" )A ,"
				+ "	("
				+ "				SELECT"
				+ "				bussiStaffId,	COUNT(*) AS twoComeShopNum"
				+ "			FROM"
				+ "				cust_customer"
				+ "			WHERE	1=1 AND recordType=1  AND comeShopStatus>2";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"')";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND (DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' or DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' )";
		}
		sql=sql +" )B"
				+ "	,"
				+ "	("
				+ "			SELECT"
				+ "					bussiStaffId,"
				+ "					COUNT(IF(comeShopStatus=2,TRUE,NULL)) AS comeShopOrderNum,"
				+ "					COUNT(IF(comeShopStatus=3,TRUE,NULL)) AS comeShopTwoOrderNum,"
				+ "					COUNT(IF(comeShopStatus>1,TRUE,NULL)) AS comeShopTotalOrderNum"
				+ "				FROM"
				+ "					cust_customer cust,cust_ordercontract custo"
				+ "				WHERE"
				+ "					cust.dbid=custo.customerId AND recordType=1 AND custo.status=4 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+")C";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<ComeShopUser> comeShopList=new ArrayList<ComeShopUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			comeShopList = ResultSetUtil.getDateResult(comeShopList, resultSet, ComeShopUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!comeShopList.isEmpty()){
			return comeShopList.get(0);
		}
		return null;	
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public Map<ComeShopUser,List<CarSerCount>> queryComeShopOrderUserCarSeriy(List<ComeShopUser> comeShopUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb,cust_ordercontract custo "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND cust.dbid=custo.customerId AND	bussiStaffId=USERID AND comeShopStatus>=2 AND custo.status=4 ";
				if(type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<ComeShopUser,List<CarSerCount>> map=new HashMap<ComeShopUser, List<CarSerCount>>(comeShopUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (ComeShopUser user : comeShopUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<ComeShopUser,List<CarSerCount>> sortMap =new TreeMap<ComeShopUser, List<CarSerCount>>(new SortByDbidComparator());
		    sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryComeShopOrderUserCarSeriyAll(int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb,cust_ordercontract custo "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND cust.dbid=custo.customerId  AND comeShopStatus>=2 AND custo.status=4 ";
		if(type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount> carSerCounts=new ArrayList<CarSerCount>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：获取创建潜客数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryCreateFolderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "					IFNULL(A.nowNum,0) AS nowNum,"
				+ "					IFNULL(A.preNum,0) AS preNum,"
				+ "					IFNULL((A.nowNum-A.preNum)/A.preNum*100,0) AS chainPer,"
				+ "					IFNULL(A.yearByYearNum,0) AS yearByYearNum,"
				+ "					IFNULL((A.nowNum-A.yearByYearNum)/A.yearByYearNum*100,0) AS yreaByYearPer"
				+ "			FROM"
				+ "			(SELECT"
				+ "					COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE 1=1  AND recordType=1 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		if(null!=queryStaYearByYearChain){
			queryStaYearByYearChain.setNowDate(nowDate);
			queryStaYearByYearChain.setPreDate(preDate);
			queryStaYearByYearChain.setYearByYearDate(yearByYearDate);
		}
		return queryStaYearByYearChain;
	}
	
	/**
	 * 功能描述：获取首次到店数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryComeShopStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "					IFNULL(A.nowNum,0) AS nowNum,"
				+ "					IFNULL(A.preNum,0) AS preNum,"
				+ "					IFNULL((A.nowNum-A.preNum)/A.preNum*100,0) AS chainPer,"
				+ "					IFNULL(A.yearByYearNum,0) AS yearByYearNum,"
				+ "					IFNULL((A.nowNum-A.yearByYearNum)/A.yearByYearNum*100,0) AS yreaByYearPer"
				+ "			FROM"
				+ "			(SELECT"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE 1=1  AND comeShopStatus=2 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		if(null!=queryStaYearByYearChain){
			queryStaYearByYearChain.setNowDate(nowDate);
			queryStaYearByYearChain.setPreDate(preDate);
			queryStaYearByYearChain.setYearByYearDate(yearByYearDate);
		}
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：获取二次到店数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryTwoComeShopStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "					IFNULL(A.nowNum,0) AS nowNum,"
				+ "					IFNULL(A.preNum,0) AS preNum,"
				+ "					IFNULL((A.nowNum-A.preNum)/A.preNum*100,0) AS chainPer,"
				+ "					IFNULL(A.yearByYearNum,0) AS yearByYearNum,"
				+ "					IFNULL((A.nowNum-A.yearByYearNum)/A.yearByYearNum*100,0) AS yreaByYearPer"
				+ "			FROM"
				+ "			(SELECT"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE 1=1  AND comeShopStatus>2 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：获取首次到店转订单数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryComeShopOrderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int comeShopStatusType){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "					IFNULL(A.nowNum,0) AS nowNum,"
				+ "					IFNULL(A.preNum,0) AS preNum,"
				+ "					IFNULL((A.nowNum-A.preNum)/A.preNum*100,0) AS chainPer,"
				+ "					IFNULL(A.yearByYearNum,0) AS yearByYearNum,"
				+ "					IFNULL((A.nowNum-A.yearByYearNum)/A.yearByYearNum*100,0) AS yreaByYearPer"
				+ "			FROM"
				+ "			(SELECT"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "						cust_ordercontract custo,cust_customer cust "
				+ "				WHERE 1=1 AND custo.`status`=4   AND custo.customerId=cust.dbid";
		//查询首次进店
		if(comeShopStatusType==1){
			sql=sql+" AND cust.comeShopStatus=2";
		}
		//查询二次进店
		if(comeShopStatusType==2){
			sql=sql+" AND cust.comeShopStatus>2";
		}
		//查询到店
		if(comeShopStatusType==3){
			sql=sql+" AND cust.comeShopStatus>=2";
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：客户首次来店率同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaTryCarYearByYearChainPer queryCreateFolderToComeShopYearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "	IFNULL(B.nowNum/(IFNULL(A.nowNum,0)+IFNULL(C.nowNum,0))*100,0) AS nowTryCarPer,"
				+ "	IFNULL(B.preNum/(IFNULL(A.preNum,0)+IFNULL(C.preNum,0))*100,0) AS preTryCarPer,"
				+ "	IFNULL(B.yearByYearNum/(IFNULL(A.yearByYearNum,0)+IFNULL(C.yearByYearNum,0))*100,0) AS yearByYearTryCarPer"
				+ "  FROM"
				+ "		("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1 AND  recordType=1 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql+ "		)A"
				+ ","
				+ "("
				+ "	SELECT"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE 1=1 AND recordType=1 AND cust.dbid=custc.customerId ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND type="+type;
				}
				sql=sql+ ")C,("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1 AND comeShopStatus=2 AND recordType=1 ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND type="+type;
				}
				sql=sql	+ "	)B";
			StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
			if(null!=queryStaTryCarYearByYearChainPer){
				queryStaTryCarYearByYearChainPer.setItemName("首次进店店率");
				queryStaTryCarYearByYearChainPer.setNowDate(nowDate);
				queryStaTryCarYearByYearChainPer.setPreDate(preDate);
				queryStaTryCarYearByYearChainPer.setYearByYearDate(yearByYearDate);
			}
			return queryStaTryCarYearByYearChainPer;
	}
	/**
	 * 功能描述：客户来店率（来店客户包含首次来店+二次来店）/（留存客户+新创建客户）比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaTryCarYearByYearChainPer queryComeShopYearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "	IFNULL((IFNULL(B.nowNum,0)+IFNULL(D.nowNum,0))/(IFNULL(A.nowNum,0)+IFNULL(C.nowNum,0))*100,0) AS nowTryCarPer,"
				+ "	IFNULL((IFNULL(B.preNum,0)+IFNULL(D.preNum,0))/(IFNULL(A.preNum,0)+IFNULL(C.preNum,0))*100,0) AS preTryCarPer,"
				+ "	IFNULL((IFNULL(B.yearByYearNum,0)+IFNULL(D.yearByYearNum,0))/(IFNULL(A.yearByYearNum,0)+IFNULL(C.yearByYearNum,0))*100,0) AS yearByYearTryCarPer"
				+ "  FROM"
				+ "		("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1 AND  recordType=1 ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql+ "		)A"
				+ ","
				+ "("
				+ "	SELECT"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(custc.createDate,'%Y-%m')='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE 1=1 AND recordType=1 AND cust.dbid=custc.customerId ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql+ ")C,("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1 AND comeShopStatus=2 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql	+ "	)B,"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE"
				+ "					1=1  AND comeShopStatus>2";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql		+ "		)D";
		StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
		if(null!=queryStaTryCarYearByYearChainPer){
			queryStaTryCarYearByYearChainPer.setItemName("到店率");
			queryStaTryCarYearByYearChainPer.setNowDate(nowDate);
			queryStaTryCarYearByYearChainPer.setPreDate(preDate);
			queryStaTryCarYearByYearChainPer.setYearByYearDate(yearByYearDate);
		}
		return queryStaTryCarYearByYearChainPer;
	}
	/**
	 * 功能描述：获取试乘试驾客户订单率同比环比率数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaTryCarYearByYearChainPer queryComeShopOrderearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String nowDate="",preDate="",yearByYearDate="";
		if(dateType==1){
			nowDate= DateUtil.formatPatten(startDate, "yyyy-MM");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy-MM");
			Date preMonthDate = DateUtil.addMonth(startDate, -1);
			preDate= DateUtil.formatPatten(preMonthDate, "yyyy-MM");
		}
		if(dateType==2){
			nowDate= DateUtil.formatPatten(startDate, "yyyy");
			Date preYearDate = DateUtil.addYear(startDate, -1);
			yearByYearDate= DateUtil.formatPatten(preYearDate, "yyyy");
			preDate=yearByYearDate;
		}
		String sql="SELECT"
				+ "		IFNULL(B.nowNum/(IFNULL(A.nowNum,0)+IFNULL(C.nowNum,0))*100,0) AS nowTryCarPer,"
				+ "		IFNULL(B.preNum/(IFNULL(A.preNum,0)+IFNULL(C.preNum,0))*100,0) AS preTryCarPer,"
				+ "		IFNULL(B.yearByYearNum/(IFNULL(A.yearByYearNum,0)+IFNULL(C.yearByYearNum,0))*100,0) as yearByYearTryCarPer"
				+ "	FROM"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE"
				+ "					1=1  AND comeShopStatus>2";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql		+ "		)A,"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE"
				+ "					1=1  AND comeShopStatus=2";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql		+ "		)C,"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "				cust_ordercontract custo,cust_customer cust"
				+ "				WHERE"
				+ "				custo.`status`=4 	AND cust.comeShopStatus>=2 AND custo.customerId=cust.dbid";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql	+ "		)B";
		StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
		if(null!=queryStaTryCarYearByYearChainPer){
			queryStaTryCarYearByYearChainPer.setItemName("到店客户转订单率");
			queryStaTryCarYearByYearChainPer.setNowDate(nowDate);
			queryStaTryCarYearByYearChainPer.setPreDate(preDate);
			queryStaTryCarYearByYearChainPer.setYearByYearDate(yearByYearDate);
		}
		return queryStaTryCarYearByYearChainPer;
	}
	
	/**
	 * 功能描述：通过sql查询统计同比怀比数据
	 * @param sql
	 * @return
	 */
	private StaYearByYearChain queryStaYearByYearChain(String sql){
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaYearByYearChain> staUserTryCars=new ArrayList<StaYearByYearChain>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staUserTryCars = ResultSetUtil.getDateResult(staUserTryCars, resultSet, StaYearByYearChain.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!staUserTryCars.isEmpty()){
			StaYearByYearChain staYearByYearChain = staUserTryCars.get(0);
			return staYearByYearChain;
		}
		return null;
	}
	/**
	 * 功能描述：通过sql查询试乘试驾、试乘试驾客户订单率
	 * @param sql
	 * @return
	 */
	private StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer(String sql){
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaTryCarYearByYearChainPer> staTryCarYearByYearChainPers=new ArrayList<StaTryCarYearByYearChainPer>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCarYearByYearChainPers = ResultSetUtil.getDateResult(staTryCarYearByYearChainPers, resultSet, StaTryCarYearByYearChainPer.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!staTryCarYearByYearChainPers.isEmpty()){
			StaTryCarYearByYearChainPer staTryCarYearByYearChainPer = staTryCarYearByYearChainPers.get(0);
			return staTryCarYearByYearChainPer;
		}
		return null;
	}
	 /**
	 * 功能描述：无数据日期自动设置为零，并对最终结果按日期从新排序
	 * @param startDate
	 * @param endDate
	 * @param comeShops
	 */
	private void sortResult(String startDate, String endDate,List<ComeShop> comeShops,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=comeShops.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (ComeShop twoComeShop : comeShops) {
						if(twoComeShop.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						ComeShop comeShop = new ComeShop(date);
						comeShops.add(comeShop);
					}
				}
			}
			Collections.sort(comeShops,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=comeShops.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (ComeShop comeShop : comeShops) {
						String hasTemp = DateUtil.formatPatten(comeShop.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						ComeShop comeShop = new ComeShop(date);
						comeShops.add(comeShop);
					}
				}
			}
			Collections.sort(comeShops,new SortByDateComparator());
		}
	}
}
