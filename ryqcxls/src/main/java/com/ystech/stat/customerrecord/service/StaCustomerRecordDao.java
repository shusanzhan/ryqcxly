package com.ystech.stat.customerrecord.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.SortByDbidComparator;
import com.ystech.stat.customerrecord.model.StatCustomerRecordTime;
import com.ystech.stat.customerrecord.model.StatCustomerRecordUser;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.xwqr.model.sys.Enterprise;

public class StaCustomerRecordDao {
	/**
	 * 功能描述：获取每日有效看车数据
	 * @param statCustomerRecords
	 * @return
	 */
	public List<StaDateNum> getCustomerRecordCarSeriyTotal(List<StatCustomerRecordTime> statCustomerRecords){
		List<StaDateNum> data=new ArrayList<StaDateNum>(statCustomerRecords.size());
		for (StatCustomerRecordTime statCustomerRecordTime : statCustomerRecords) {
			data.add(new StaDateNum(statCustomerRecordTime.getCreateDate(),statCustomerRecordTime.getEffectiveNum()));
		}
		return data;
	}
	/**
	 * 功能描述：获取到店看车车型
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> findCustomerRecordCarSeriy(List<StaDateNum> staCustomerRecordDateNums,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customerrecord "
				+ " WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' and customerTypeId="+type+" AND `status`=1 AND resultStatus=2";
			if(null!=customerInfromIds){
				sql=sql+" AND customerInfromId IN("+customerInfromIds+") ";
			}
			sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(staCustomerRecordDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staCustomerRecordDateNums) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staCustomerRecordDateNum, customerRecordTargets);
			}
			 Map<StaDateNum,List<CarSerCount>> sortMap =new TreeMap<StaDateNum, List<CarSerCount>>(new SortByDateComparator());
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
	 * 功能描述：获取到店看车车型-总数据
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public List<CarSerCount> findCustomerRecordCarSeriyTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT carseriy.dbid AS serid,carseriy.`name` AS serName,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy carseriy LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customerrecord "
				+ " WHERE 1=1 ";
			if(type>0){
				sql=sql+ " and customerTypeId="+type;
			}
			if(null!=enterprise){
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
			}
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
			}
			sql=sql+" AND `status`=1 AND resultStatus=2 "
				+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON carseriy.dbid=B.carSeriyId "
				+ "WHERE carseriy.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CarSerCount> carSerCounts=new ArrayList<CarSerCount>();
		try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				carSerCounts = ResultSetUtil.getDateResult(carSerCounts, resultSet, CarSerCount.class);
				resultSet.close();
				createStatement.close();
				jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：获取展厅销售顾问接待线索以及建档客户
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<StatCustomerRecordUser> findCustomerRecordUser(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType,int userBussiType){
		String sql="SELECT "
				+ "us.dbid,us.realName,"
				+ "IFNULL(B.totalNum,0) AS totalNum,"
				+ "IFNULL(B.salerSelfNum,0) AS salerSelfNum,"
				+ "IFNULL(B.receptionNum,0) AS receptionNum,"
				+ "IFNULL(B.notDealNum,0) AS notDealNum,"
				+ "IFNULL(B.otherNum,0) AS otherNum,"
				+ "IFNULL(B.unableNum,0) AS unableNum,"
				+ "IFNULL(B.creatorFolderNum,0) AS  creatorFolderNum,"
				+ "(IFNULL(B.totalNum,0)-IFNULL(B.otherNum,0)) AS fristComeNum,"
				+ "IFNULL(B.creatorFolderNum,0)/(IFNULL(B.totalNum,0)-IFNULL(B.otherNum,0))*100 AS creatorFolderPer "
				+ "FROM "
				+ "("
				+ "	SELECT	salerId,salerName,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1,TRUE,NULL)) AS totalNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&salerId=creatorId,TRUE,NULL)) AS salerSelfNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&salerId!=creatorId,TRUE,NULL)) AS receptionNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&resultStatus=1,TRUE,NULL)) AS notDealNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=2,TRUE,NULL)) AS creatorFolderNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=3,TRUE,NULL)) AS otherNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=4,TRUE,NULL)) AS unableNum "
				+ "	FROM"
				+ "	cust_customerrecord"
				+ "	WHERE"
				+ "	1=1 ";
				if(type!=null&&type>0){
					sql=sql+ " and customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY salerId"
				+ ")B LEFT JOIN sys_user us  "
				+ " ON us.dbid=B.salerId ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return statCustomerRecordUsers;	
	}
	/**
	 * 功能描述：获取展厅销售顾问接待线索以及建档客户
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public StatCustomerRecordUser findCustomerRecordUserTotal(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ "IFNULL(B.totalNum,0) AS totalNum,"
				+ "IFNULL(B.salerSelfNum,0) AS salerSelfNum,"
				+ "IFNULL(B.receptionNum,0) AS receptionNum,"
				+ "IFNULL(B.otherNum,0) AS otherNum,"
				+ "IFNULL(B.unableNum,0) AS unableNum,"
				+ "IFNULL(B.notDealNum,0) AS notDealNum,"
				+ "IFNULL(B.creatorFolderNum,0) AS  creatorFolderNum,"
				+ "(IFNULL(B.totalNum,0)-IFNULL(B.otherNum,0)) AS fristComeNum,"
				+ "IFNULL(B.creatorFolderNum,0)/(IFNULL(B.totalNum,0)-IFNULL(B.otherNum,0))*100 AS creatorFolderPer "
				+ "FROM "
				+ "(SELECT "
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1,TRUE,NULL)) AS totalNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&salerId=creatorId,TRUE,NULL)) AS salerSelfNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&salerId!=creatorId,TRUE,NULL)) AS receptionNum,"
				+ "	COUNT(IF(customerTypeId=1&&status=1&&resultStatus=1,TRUE,NULL)) AS notDealNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=2,TRUE,NULL)) AS creatorFolderNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=3,TRUE,NULL)) AS otherNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&status=1&&resultStatus=4,TRUE,NULL)) AS unableNum "
				+ "	FROM"
				+ "	cust_customerrecord"
				+ "	WHERE"
				+ "	1=1 ";
		if(type!=null&&type>0){
			sql=sql+ " and customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+")B";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if (!statCustomerRecordUsers.isEmpty()) {
			return statCustomerRecordUsers.get(0);
		}
		return null;	
	}
	/**
	 * 功能描述：获取销售顾问到店看车车型
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public Map<StatCustomerRecordUser,List<CarSerCount>> findCustomerRecordCarSeriyByUserId(List<StatCustomerRecordUser> statCustomerRecordUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customerrecord "
				+ " WHERE"
				+ "	salerId=USERID  AND `status`=1 AND resultStatus=2  ";
				if(type>0){
					sql=sql+ " and customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StatCustomerRecordUser,List<CarSerCount>> map=new HashMap<StatCustomerRecordUser, List<CarSerCount>>(statCustomerRecordUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StatCustomerRecordUser user : statCustomerRecordUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<StatCustomerRecordUser,List<CarSerCount>> sortMap =new TreeMap<StatCustomerRecordUser, List<CarSerCount>>(new SortByDbidComparator());
		    sortMap.putAll(map);
			createStatement.close();
			jdbcConnection.close();
			return sortMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
}
