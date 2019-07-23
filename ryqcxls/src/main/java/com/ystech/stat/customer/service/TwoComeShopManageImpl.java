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
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customer.model.TwoComeShop;
import com.ystech.stat.customer.model.TwoComeShopCarSeriy;
import com.ystech.stat.customer.model.TwoComeShopUser;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("twoComeShopManageImpl")
public class TwoComeShopManageImpl {
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
	public List<TwoComeShop> queryTwoComeShop(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT C.*,"
				+ "	IFNULL(C.twoComeShopNum/C.totalNum*100,0) AS twoComeShopPer,"
				+ "	IFNULL(D.totalNum,0) AS twoComeShopOrderNum,"
				+ "	IFNULL(D.totalNum/C.twoComeShopNum*100,0) AS twoComeShopOrderPer"
				+ "	FROM("
				+ "			SELECT"
				+ "			A.createDate,"
				+ "			IFNULL(A.totalNum,0) AS comeShopNum,"
				+ "			IFNULL(B.totalNum,0) AS twoComeShopNum,"
				+ "			(IFNULL(A.totalNum,0)+IFNULL(B.totalNum,0)) AS totalNum"
				+ "		  FROM"
				+ "				("
				+ "				SELECT"
				+ "					DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE 1=1 AND comeShopStatus=2 ";
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
		sql=sql		+ "	GROUP BY"
				+ "					DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "				)A"
				+ "			LEFT JOIN"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE"
				+ "					comeShopStatus>2 ";
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
		sql=sql		+ "				GROUP BY"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "			)B ON A.createDate=B.createDate"
				+ "		)C"
				+ "			LEFT JOIN"
				+ "		("
				+ "			SELECT"
				+ "				DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "				COUNT(*) AS totalNum"
				+ "				FROM"
				+ "				cust_ordercontract custo,cust_customer cust"
				+ "				WHERE"
				+ "				  custo.`status`=4 AND cust.comeShopStatus>2  AND custo.customerId=cust.dbid ";
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
		sql=sql		+ "				GROUP BY DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "		)D ON C.createDate=D.createDate;";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TwoComeShop> staTryCars=new ArrayList<TwoComeShop>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCars = ResultSetUtil.getDateResult(staTryCars, resultSet, TwoComeShop.class);
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
	public TwoComeShop queryTwoComeShopTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT C.*,"
				+ "	IFNULL(C.twoComeShopNum/C.totalNum*100,0) AS twoComeShopPer,"
				+ "	IFNULL(D.totalNum,0) AS twoComeShopOrderNum,"
				+ "	IFNULL(D.totalNum/C.twoComeShopNum*100,0) AS twoComeShopOrderPer"
				+ "	FROM("
				+ "			SELECT"
				+ "			IFNULL(A.totalNum,0) AS comeShopNum,"
				+ "			IFNULL(B.totalNum,0) AS twoComeShopNum,"
				+ "			(IFNULL(A.totalNum,0)+IFNULL(B.totalNum,0)) AS totalNum"
				+ "		  FROM"
				+ "				("
				+ "				SELECT"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE 1=1 AND comeShopStatus=2 ";
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
		sql=sql		+")A"
				+ "	,"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer"
				+ "				WHERE"
				+ "					comeShopStatus>2 ";
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
		sql=sql		+ "	)B"
				+ "		)C"
				+ "	,"
				+ "		("
				+ "			SELECT"
				+ "				DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "				COUNT(*) AS totalNum"
				+ "				FROM"
				+ "				cust_ordercontract custo,cust_customer cust"
				+ "				WHERE"
				+ "				  custo.`status`=4 AND cust.comeShopStatus>2  AND custo.customerId=cust.dbid ";
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
		sql=sql	+ "		)D ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TwoComeShop> twoComeShops=new ArrayList<TwoComeShop>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			twoComeShops = ResultSetUtil.getDateResult(twoComeShops, resultSet, TwoComeShop.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(null!=twoComeShops&&!twoComeShops.isEmpty()){
			return twoComeShops.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：获取各网销邀约到店关注车型
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryTwoComeShopCarSeriy(List<TwoComeShop> staTryCars,Enterprise enterprise,int dateType,int type){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId	AND enterpriseId="+enterprise.getDbid()+"  AND comeShopStatus>2 ";
			sql=sql+" AND DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
			if(type>0){
				sql=sql+" AND type="+type;
			}
			sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(staTryCars.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staTryCar : staTryCars) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staTryCar.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staTryCar, customerRecordTargets);
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
	 * 功能描述：获取各网销邀约到店关注车型
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryTwoComeShopCarCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId	 AND comeShopStatus>2 ";
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
	 * 功能描述：获取试乘试驾订单客户明细
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryTwoComeShopOrderCarSeriy(List<TwoComeShop> staTryCars,Enterprise enterprise,int dateType,int type){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum"
				+ " FROM "
				+ " cust_ordercontract custo,cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ "  custo.`status`=4 AND custo.customerId=cust.dbid AND cust.dbid=cb.customerId	AND enterpriseId="+enterprise.getDbid()+"  AND comeShopStatus>2 ";
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(staTryCars.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staTryCar : staTryCars) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staTryCar.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staTryCar, customerRecordTargets);
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
	 * 功能描述：获取试乘试驾订单客户汇总
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryTwoComeShopOrderCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_ordercontract custo,cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " custo.`status`=4 AND custo.customerId=cust.dbid AND cust.dbid=cb.customerId	AND enterpriseId="+enterprise.getDbid()+"  AND comeShopStatus>2 ";
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
	 * 功能描述：查询二车次到店车型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<TwoComeShopCarSeriy> queryCarSeriyTwoComeShop(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
					+ "cs.dbid,cs.`name`,"
					+ "IFNULL(A.totalNum,0) AS comeShopNum,"
					+ "IFNULL(B.totalNum,0) AS twoComeShopNum,"
					+ "IFNULL(A.totalNum+B.totalNum,0) AS totalNum,"
					+ "IFNULL(B.totalNum/(A.totalNum+B.totalNum),0)*100 AS twoComeShopPer,"
					+ "IFNULL(C.totalNum,0) AS twoComeShopOrderNum,"
					+ "IFNULL(C.totalNum/B.totalNum,0)*100 AS twoComeShopOrderPer"
				+ " FROM "
				+ "set_carseriy cs "
				+ "LEFT JOIN "
				+ "( "
					+ "SELECT "
						+ "cb.carSeriyId,"
						+ "COUNT(*) totalNum "
					+ "FROM"
					+ " cust_customer cust,cust_customerbussi cb "
				+ "WHERE "
					+ "cust.dbid=cb.customerId AND comeShopStatus=2 ";
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
		sql=sql			+ " GROUP BY cb.carSeriyId "
				+ ")A ON cs.dbid=A.carSeriyId "
				+ "LEFT JOIN( "
					+ "SELECT "
						+ "cb.carSeriyId, "
						+ "COUNT(*) totalNum"
				+ " FROM "
					+ "cust_customer cust,cust_customerbussi cb "
				+ "WHERE "
					+ "cust.dbid=cb.customerId AND comeShopStatus>2 ";
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
		sql=sql			+ " GROUP BY cb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ "LEFT JOIN("
					+ "SELECT "
						+ "cb.carSeriyId, "
						+ "COUNT(*) totalNum "
					+ "FROM "
						+ "cust_customer cust,cust_customerbussi cb,cust_ordercontract custo "
					+ "WHERE "
						+ "cust.dbid=cb.customerId AND  custo.`status`=4	AND cust.comeShopStatus>2  AND custo.customerId=cust.dbid ";
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
		sql=sql			+ " GROUP BY cb.carSeriyId"
					+ ")C ON cs.dbid=C.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TwoComeShopCarSeriy> twoComeShopCarSeriys=new ArrayList<TwoComeShopCarSeriy>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			twoComeShopCarSeriys = ResultSetUtil.getDateResult(twoComeShopCarSeriys, resultSet, TwoComeShopCarSeriy.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return twoComeShopCarSeriys;
	}
	/**
	 * 功能描述：查询销售顾问二次到店率
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<TwoComeShopUser> queryTwoComeShopUser(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT"
				+ "			A.userId,A.userName,"
				+ "			IFNULL(A.totalNum,0) AS comeShopNum,"
				+ "			IFNULL(B.totalNum,0) AS twoComeShopNum,"
				+ "			IFNULL(B.totalNum,0)/IFNULL(A.totalNum,0)+IFNULL(B.totalNum,0) AS twoComeShopPer,"
				+ "			IFNULL(A.totalNum,0)+IFNULL(B.totalNum,0) AS totalNum,"
				+ "			IFNULL(C.totalNum,0) AS twoComeShopOrderNum,"
				+ "			IFNULL(C.totalNum/B.totalNum,0)*100 AS twoComeShopOrderPer"
				+ "			FROM"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId AS userId,"
					+ "			cust.bussiStaff AS userName,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
				+ "				cust_customer cust"
				+ "			WHERE 1=1 AND comeShopStatus=2 ";
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
		sql=sql		+ "				GROUP BY cust.bussiStaffId"
				+ "			)A"
				+ "			LEFT JOIN"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
				+ "				cust_customer cust"
				+ "			WHERE 1=1 AND comeShopStatus>2 ";
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
		sql=sql			+ "			GROUP BY cust.bussiStaffId"
				+ "			)B ON A.userId=B.bussiStaffId"
				+ "			LEFT JOIN"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
					+ "			cust_customer cust,"
					+ "			cust_ordercontract custo"
				+ "			WHERE"
				+ "				1=1 AND custo.`status`=4 AND cust.comeShopStatus>2  AND custo.customerId=cust.dbid ";
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
			sql=sql	+ "			GROUP BY cust.bussiStaffId"
				+ "	)C ON A.userId=C.bussiStaffId";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<TwoComeShopUser> twoCoemShopUsers=new ArrayList<TwoComeShopUser>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				twoCoemShopUsers = ResultSetUtil.getDateResult(twoCoemShopUsers, resultSet, TwoComeShopUser.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return twoCoemShopUsers;
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
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
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
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：获取试乘试驾创建订单数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryTwoComeShopOrderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
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
				+ "				WHERE 1=1 AND custo.`status`=4 AND cust.comeShopStatus>2  AND custo.customerId=cust.dbid";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：获取客户试乘试驾率同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaTryCarYearByYearChainPer queryTryCarStaTryCarYearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
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
				+ "	IFNULL(B.nowNum/(A.nowNum+B.nowNum)*100,0) AS nowTryCarPer,"
				+ "	IFNULL(B.preNum/(A.preNum+B.preNum)*100,0) AS preTryCarPer,"
				+ "	IFNULL(B.yearByYearNum/(A.yearByYearNum+B.yearByYearNum)*100,0) AS yearByYearTryCarPer"
				+ "  FROM"
				+ "		("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1 AND comeShopStatus=2";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND type="+type;
				}
				sql=sql+ "		)A"
				+ ","
				+ "(SELECT"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE"
				+ "			1=1  AND comeShopStatus>2";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND type="+type;
				}
				sql=sql	+ "	)B";
			StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
			if(null!=queryStaTryCarYearByYearChainPer){
				queryStaTryCarYearByYearChainPer.setItemName("二次到店率");
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
	public StaTryCarYearByYearChainPer queryTryCarOrderStaTryCarYearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
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
				+ "		IFNULL(B.nowNum/A.nowNum*100,0) AS nowTryCarPer,"
				+ "		IFNULL(B.preNum/A.preNum*100,0) AS preTryCarPer,"
				+ "		IFNULL(B.yearByYearNum/A.yearByYearNum*100,0) as yearByYearTryCarPer"
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
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql		+ "		)A,"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "				cust_ordercontract custo,cust_customer cust"
				+ "				WHERE"
				+ "				custo.`status`=4 	AND cust.comeShopStatus>2 AND custo.customerId=cust.dbid";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND type="+type;
		}
		sql=sql	+ "		)B";
		StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
		if(null!=queryStaTryCarYearByYearChainPer){
			queryStaTryCarYearByYearChainPer.setItemName("二次到店客户订单率");
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
	 * @param twoComeShops
	 */
	private void sortResult(String startDate, String endDate,List<TwoComeShop> twoComeShops,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=twoComeShops.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (TwoComeShop twoComeShop : twoComeShops) {
						if(twoComeShop.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						TwoComeShop twoComeShopTemp = new TwoComeShop(date);
						twoComeShops.add(twoComeShopTemp);
					}
				}
			}
			Collections.sort(twoComeShops,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=twoComeShops.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (TwoComeShop twoComeShop : twoComeShops) {
						String hasTemp = DateUtil.formatPatten(twoComeShop.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						TwoComeShop twoComeShopTemp = new TwoComeShop(date);
						twoComeShops.add(twoComeShopTemp);
					}
				}
			}
			Collections.sort(twoComeShops,new SortByDateComparator());
		}
	}
}
