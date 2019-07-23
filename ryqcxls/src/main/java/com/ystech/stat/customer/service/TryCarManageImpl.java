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
import com.ystech.stat.customer.model.StaCarSeriyTryCar;
import com.ystech.stat.customer.model.StaTryCar;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customer.model.StaUserTryCar;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("tryCarManageImpl")
public class TryCarManageImpl {
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
	public List<StaTryCar> queryStaTryCar(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT C.*,"
				+ "	IFNULL(D.tryCarNum,0) AS tryCarNum,"
				+ "	IFNULL(D.tryCarNum/C.totalNum*100,0) AS tryCarPer,"
				+ "	IFNULL(F.totalNum,0) AS tryCarOrderNum,"
				+ "	IFNULL(F.totalNum/D.tryCarNum*100,0) AS tryCarOrderPer"
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
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql		+ "	GROUP BY"
				+ "					DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "				)A"
				+ "			LEFT JOIN"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus>2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql		+ "				GROUP BY"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "			)B ON A.createDate=B.createDate"
				+ "		)C"
				+ "			LEFT JOIN"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS tryCarNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND  cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql		+ "				GROUP BY"
				+ "					DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "		)D"
				+ "			ON C.createDate=D.createDate"
				+ "			LEFT JOIN"
				+ "		("
				+ "			SELECT"
				+ "				DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "				COUNT(*) AS totalNum"
				+ "				FROM"
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE"
				+ "				  custo.`status`=4 AND cust.tryCarStatus=2  AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql		+ "				GROUP BY DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ "		)F ON D.createDate=F.createDate;";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaTryCar> staTryCars=new ArrayList<StaTryCar>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCars = ResultSetUtil.getDateResult(staTryCars, resultSet, StaTryCar.class);
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
	public StaTryCar queryStaTryCarTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT C.*,"
				+ "	IFNULL(D.tryCarNum,0) AS tryCarNum,"
				+ "	IFNULL(D.tryCarNum/C.totalNum*100,0) AS tryCarPer,"
				+ "	IFNULL(F.totalNum,0) AS tryCarOrderNum,"
				+ "	IFNULL(F.totalNum/D.tryCarNum*100,0) AS tryCarOrderPer"
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
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql		+")A"
				+ "	,"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS totalNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus>2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql		+ "	)B"
				+ "		)C"
				+ "	,"
				+ "			("
				+ "				SELECT"
				+ "					DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "					COUNT(*) AS tryCarNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND  cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql		+ "	)D"
				+ "	,"
				+ "		("
				+ "			SELECT"
				+ "				DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "				COUNT(*) AS totalNum"
				+ "				FROM"
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE"
				+ "				  custo.`status`=4 AND cust.tryCarStatus=2  AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql	+ "		)F ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaTryCar> staTryCars=new ArrayList<StaTryCar>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staTryCars = ResultSetUtil.getDateResult(staTryCars, resultSet, StaTryCar.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(null!=staTryCars&&!staTryCars.isEmpty()){
			return staTryCars.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：获取各网销邀约到店关注车型
	 * @param staTryCars
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> queryTryCarCarSeriy(List<StaTryCar> staTryCars,Enterprise enterprise,int dateType,int type){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1  AND cust.tryCarStatus=2 ";
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
			if(type>0){
				sql=sql+" AND customerTypeId="+type;
			}
			sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND cs.tryCarStatus=1 AND cs.enterpriseId="+enterprise.getDbid();
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
	public List<CarSerCount> queryTryCarCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "FROM "
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1 "
				+ " AND cust.enterpriseId="+enterprise.getDbid()+"  AND cust.tryCarStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND cs.tryCarStatus=1 AND cs.enterpriseId="+enterprise.getDbid();
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
	public Map<StaDateNum,List<CarSerCount>> queryTryCarOrderCarSeriy(List<StaTryCar> staTryCars,Enterprise enterprise,int dateType,int type){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum"
				+ " FROM "
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ " WHERE"
				+ "  custo.`status`=4 	AND cust.enterpriseId="+enterprise.getDbid()+"  AND cust.tryCarStatus=2 AND cs.tryCarStatus=1  ";
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1  AND cs.tryCarStatus=1 AND enterpriseId="+enterprise.getDbid() ;
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
	public List<CarSerCount> queryTryCarOrderCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ " WHERE"
				+ " custo.`status`=4  AND cust.tryCarStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1  AND cs.tryCarStatus=1 AND enterpriseId="+enterprise.getDbid() ;
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
	 * 功能描述：查询车型试驾率统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<StaCarSeriyTryCar> queryCarSeriyTryCar(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT "
					+ "cs.dbid,cs.`name`,"
					+ "			IFNULL(A.totalNum,0) AS comeShopNum,"
					+ "			IFNULL(B.totalNum,0) AS tryCarNum,"
					+ "			IFNULL(B.totalNum/A.totalNum,0)*100 AS tryCarPer,"
					+ "			IFNULL(C.totalNum,0) AS tryCarOrderNum,"
					+ "			IFNULL(C.totalNum/B.totalNum,0)*100 AS tryCarOrderPer"
				+ " FROM "
				+ "set_carseriy cs "
				+ "LEFT JOIN "
				+ "( "
					+ "SELECT "
						+ "cb.carSeriyId,"
						+ "COUNT(*) totalNum "
					+ "FROM"
					+ " 				cust_customer cust "
					+ "					left JOIN "
					+ "					cust_customerbussi cb	"
					+ "					ON cust.dbid=cb.customerId"
					+ "					LEFT JOIN"
					+ "					set_carseriy cs "
					+ "					ON cs.dbid=cb.carSeriyId "
				+ "WHERE "
					+ " comeShopStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql			+ " GROUP BY cb.carSeriyId "
				+ ")A ON cs.dbid=A.carSeriyId "
				+ "LEFT JOIN( "
					+ "SELECT "
						+ "cb.carSeriyId, "
						+ "COUNT(*) totalNum"
				+ " FROM "
				+ " 				cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "WHERE "
				+ " comeShopStatus=2 AND cs.tryCarStatus=1 AND cust.tryCarStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql			+ " GROUP BY cb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ "LEFT JOIN("
					+ "SELECT "
						+ "cb.carSeriyId, "
						+ "COUNT(*) totalNum "
					+ "FROM "
					+ "				cust_ordercontract custo "
					+ "					LEFT JOIN "
					+ "				cust_customer cust "
					+ "				ON custo.customerId=cust.dbid "
					+ "					left JOIN "
					+ "					cust_customerbussi cb	"
					+ "					ON cust.dbid=cb.customerId"
					+ "					LEFT JOIN"
					+ "					set_carseriy cs "
					+ "					ON cs.dbid=cb.carSeriyId "
					+ "WHERE "
						+ " custo.`status`=4	AND cust.tryCarStatus=2   AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}				
		sql=sql			+ " GROUP BY cb.carSeriyId"
					+ ")C ON cs.dbid=C.carSeriyId "
				+ "WHERE cs.`status`=1  AND cs.tryCarStatus=1 AND cs.enterpriseId="+enterprise.getDbid();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaCarSeriyTryCar> staCarSeriyTryCar=new ArrayList<StaCarSeriyTryCar>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCarSeriyTryCar = ResultSetUtil.getDateResult(staCarSeriyTryCar, resultSet, StaCarSeriyTryCar.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return staCarSeriyTryCar;
	}
	/**
	 * 功能描述：查询销售顾问试乘试统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<StaUserTryCar> queryUserTryCar(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT"
				+ "			A.userId,A.userName,"
				+ "			IFNULL(A.totalNum,0) AS comeShopNum,"
				+ "			IFNULL(B.totalNum,0) AS tryCarNum,"
				+ "			IFNULL(B.totalNum/A.totalNum,0)*100 AS tryCarPer,"
				+ "			IFNULL(C.totalNum,0) AS tryCarOrderNum,"
				+ "			IFNULL(C.totalNum/B.totalNum,0)*100 AS tryCarOrderPer"
				+ "			FROM"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId AS userId,"
					+ "			cust.bussiStaff AS userName,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "			WHERE 1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
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
		sql=sql		+ "				GROUP BY cust.bussiStaffId"
				+ "			)A"
				+ "			LEFT JOIN"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "			WHERE 1=1 AND cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql			+ "			GROUP BY cust.bussiStaffId"
				+ "			)B ON A.userId=B.bussiStaffId"
				+ "			LEFT JOIN"
				+ "			("
				+ "			SELECT"
					+ "			cust.bussiStaffId,"
					+ "			COUNT(*) totalNum"
				+ "			FROM"
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "			WHERE"
				+ "				1=1 AND custo.`status`=4 AND cust.tryCarStatus=2 AND cs.tryCarStatus=1  ";
			if(null!=enterprise){
				sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
			}
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
			}
			if(type>0){
				sql=sql+" AND customerTypeId="+type;
			}
			sql=sql	+ "			GROUP BY cust.bussiStaffId"
				+ "	)C ON A.userId=C.bussiStaffId";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<StaUserTryCar> staUserTryCars=new ArrayList<StaUserTryCar>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				staUserTryCars = ResultSetUtil.getDateResult(staUserTryCars, resultSet, StaUserTryCar.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return staUserTryCars;
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
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId  AND cs.tryCarStatus=1 "
				+ "				WHERE 1=1  AND comeShopStatus=2 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
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
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1  AND comeShopStatus>2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql	+ "	)A";
		StaYearByYearChain queryStaYearByYearChain = queryStaYearByYearChain(sql);
		return queryStaYearByYearChain;
	}
	/**
	 * 功能描述：获取到店试乘试驾数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryTryCarStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
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
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE 1=1  AND cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
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
	public StaYearByYearChain queryTryCarOrderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
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
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE custo.`status`=4 AND cust.tryCarStatus=2  AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
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
		String sql="SELECT "
					+ "IFNULL(D.nowNum/C.nowNum*100,0) AS nowTryCarPer,"
					+ "IFNULL(D.preNum/C.preNum*100,0) AS preTryCarPer,"
					+ "IFNULL(D.yearByYearNum/C.yearByYearNum*100,0) as yearByYearTryCarPer "
				+ "FROM "
				+ "("
				+ "	SELECT"
				+ "	IFNULL(A.nowNum+B.nowNum,0) AS nowNum,"
				+ "	IFNULL(A.preNum+B.preNum,0) AS preNum,"
				+ "	IFNULL(A.yearByYearNum+B.yearByYearNum,0) AS yearByYearNum"
				+ "  FROM"
				+ "		("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "		WHERE"
				+ "			1=1 AND comeShopStatus=2 AND cs.tryCarStatus=1 ";
				if(null!=enterprise){
					sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND customerTypeId="+type;
				}
				sql=sql+ "		)A"
				+ ","
				+ "(SELECT"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(twoComeShopDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "		WHERE"
				+ "			1=1  AND comeShopStatus>2 AND cs.tryCarStatus=1 ";
				if(null!=enterprise){
					sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND customerTypeId="+type;
				}
				sql=sql	+ "	)B"
				+ ")C"
				+ ","
				+ "	("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "		WHERE"
				+ "			1=1  AND cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
				if(null!=enterprise){
					sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
				}
				if(type>0){
					sql=sql+" AND customerTypeId="+type;
				}
				sql=sql				
				+ ")D";
			StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
			if(null!=queryStaTryCarYearByYearChainPer){
				queryStaTryCarYearByYearChainPer.setItemName("来店客户试乘试驾率");
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
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(tryCarDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer cust "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE"
				+ "					1=1  AND cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql		+ "		)A,"
				+ "		("
				+ "			SELECT"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custo.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "				cust_ordercontract custo "
				+ "					LEFT JOIN "
				+ "				cust_customer cust "
				+ "				ON custo.customerId=cust.dbid "
				+ "					left JOIN "
				+ "					cust_customerbussi cb	"
				+ "					ON cust.dbid=cb.customerId"
				+ "					LEFT JOIN"
				+ "					set_carseriy cs "
				+ "					ON cs.dbid=cb.carSeriyId "
				+ "				WHERE"
				+ "				custo.`status`=4 	AND cust.tryCarStatus=2 AND cs.tryCarStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		sql=sql	+ "		)B";
		StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
		if(null!=queryStaTryCarYearByYearChainPer){
			queryStaTryCarYearByYearChainPer.setItemName("试乘试驾客户转订单率");
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
	 * @param staTryCars
	 */
	private void sortResult(String startDate, String endDate,List<StaTryCar> staTryCars,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=staTryCars.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (StaTryCar staTryCar : staTryCars) {
						if(staTryCar.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						StaTryCar statCustomerRecordTime = new StaTryCar(date);
						staTryCars.add(statCustomerRecordTime);
					}
				}
			}
			Collections.sort(staTryCars,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=staTryCars.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (StaTryCar staTryCar : staTryCars) {
						String hasTemp = DateUtil.formatPatten(staTryCar.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						StaTryCar staTryCar = new StaTryCar(date);
						staTryCars.add(staTryCar);
					}
				}
			}
			Collections.sort(staTryCars,new SortByDateComparator());
		}
	}
}
