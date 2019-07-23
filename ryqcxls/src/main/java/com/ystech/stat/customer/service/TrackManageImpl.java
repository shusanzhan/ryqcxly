package com.ystech.stat.customer.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.stat.customer.model.Track;
import com.ystech.stat.customer.model.TrackStatTotal;
import com.ystech.stat.customer.model.TrackUser;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("trackManageImpl")
public class TrackManageImpl {
	/**
	 * 功能描述：查询每天回访数据统计明细
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public List<Track> queryTrack(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "A.createDate as createDate,"
				+ "IFNULL(A.waitNum,0) AS waitNum,"
				+ "IFNULL(A.waitTrackEdNum,0) AS waitTrackEdNum,"
				+ "IFNULL(IFNULL(A.waitTrackEdNum,0)/IFNULL(A.waitNum,0),0)*100 AS trackPer,"
				+ "IFNULL(B.trackAllNum,0) AS trackAllNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(B.trackOverTimeNum,0) AS trackOverTimeNum,"
				+ "IFNULL(IFNULL(B.trackOverTimeNum,0)/IFNULL(B.trackAllNum,0),0)*100 AS trackOverPer "
				+ "FROM"
				+ "(SELECT"
				+ " DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ " COUNT(*) AS waitNum,"
				+ " COUNT(IF(custt.taskDealStatus>=2,TRUE,NULL)) AS waitTrackEdNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ " GROUP BY "
				+ "DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") "
				+ ")A LEFT JOIN"
				+ "( "
				+ "SELECT "
				+ "DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS finishDate,"
				+ "COUNT(*) AS trackAllNum,"
				+ "COUNT(IF(custt.taskDealStatus=2,TRUE,NULL)) AS trackNum,"
				+ "COUNT(IF(custt.taskOverTimeStatus=2,TRUE,NULL)) AS trackOverTimeNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ " GROUP BY "
				+ "DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") "
				+ ")B ON A.createDate=B.finishDate ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Track> tracks=new ArrayList<Track>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			tracks = ResultSetUtil.getDateResult(tracks, resultSet, Track.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		sortResult(startDate, endDate, tracks, dateType);
		return tracks;
	}
	/**
	 * 功能描述：查询每天回访数据统计明细
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public Track queryTrackAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.waitNum,0) AS waitNum,"
				+ "IFNULL(A.waitTrackEdNum,0) AS waitTrackEdNum,"
				+ "IFNULL(IFNULL(A.waitTrackEdNum,0)/IFNULL(A.waitNum,0),0)*100 AS trackPer,"
				+ "IFNULL(B.trackAllNum,0) AS trackAllNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(B.trackOverTimeNum,0) AS trackOverTimeNum,"
				+ "IFNULL(IFNULL(B.trackOverTimeNum,0)/IFNULL(B.trackAllNum,0),0)*100 AS trackOverPer "
				+ "FROM"
				+ "(SELECT"
				+ " DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ " COUNT(*) AS waitNum,"
				+ " COUNT(IF(custt.taskDealStatus>=2,TRUE,NULL)) AS waitTrackEdNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ ")A,"
				+ "( "
				+ "SELECT "
				+ "DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS finishDate,"
				+ "COUNT(*) AS trackAllNum,"
				+ "COUNT(IF(custt.taskDealStatus=2,TRUE,NULL)) AS trackNum,"
				+ "COUNT(IF(custt.taskOverTimeStatus=2,TRUE,NULL)) AS trackOverTimeNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")B ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Track> tracks=new ArrayList<Track>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			tracks = ResultSetUtil.getDateResult(tracks, resultSet, Track.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!tracks.isEmpty()){
			return tracks.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：销售顾问回访数据统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public List<TrackUser> queryTrackUser(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "A.userId,"
				+ "A.userName,"
				+ "IFNULL(A.waitNum,0) AS waitNum,"
				+ "IFNULL(A.waitTrackEdNum,0) AS waitTrackEdNum,"
				+ "IFNULL(IFNULL(A.waitTrackEdNum,0)/IFNULL(A.waitNum,0),0)*100 AS trackPer,"
				+ "IFNULL(B.trackAllNum,0) AS trackAllNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(B.trackOverTimeNum,0) AS trackOverTimeNum,"
				+ "IFNULL(IFNULL(B.trackOverTimeNum,0)/IFNULL(B.trackAllNum,0),0)*100 AS trackOverPer "
				+ "FROM "
				+ "(SELECT"
				+ " custt.userId,"
				+ " bussiStaff as userName,"
				+ " COUNT(*) AS waitNum,"
				+ " COUNT(IF(custt.taskDealStatus>=2,TRUE,NULL)) AS waitTrackEdNum "
				+ " FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ " GROUP BY "
				+ "custt.userId "
				+ ")A "
				+ "LEFT JOIN"
				+ "("
				+ "	SELECT "
				+ "custt.userId,"
				+ "bussiStaff,"
				+ "COUNT(*) AS trackAllNum,"
				+ "COUNT(IF(custt.taskDealStatus=2,TRUE,NULL)) AS trackNum,"
				+ "COUNT(IF(custt.taskOverTimeStatus=2,TRUE,NULL)) AS trackOverTimeNum"
				+ " FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ " GROUP BY "
				+ "custt.userId "
				+ ")B "
				+ "ON A.userId=B.userId ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackUser> trackUsers=new ArrayList<TrackUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackUsers = ResultSetUtil.getDateResult(trackUsers, resultSet, TrackUser.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return trackUsers;
	}
	/**
	 * 功能描述：销售顾问回访数据统计-总数据
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @param tryCarStatus
	 * @param comeShopStatus
	 * @return
	 */
	public TrackUser queryTrackUserAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.waitNum,0) AS waitNum,"
				+ "IFNULL(A.waitTrackEdNum,0) AS waitTrackEdNum,"
				+ "IFNULL(IFNULL(A.waitTrackEdNum,0)/IFNULL(A.waitNum,0),0)*100 AS trackPer,"
				+ "IFNULL(B.trackAllNum,0) AS trackAllNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(B.trackOverTimeNum,0) AS trackOverTimeNum,"
				+ "IFNULL(IFNULL(B.trackOverTimeNum,0)/IFNULL(B.trackAllNum,0),0)*100 AS trackOverPer "
				+ "FROM "
				+ "(SELECT"
				+ " COUNT(*) AS waitNum,"
				+ " COUNT(IF(custt.taskDealStatus>=2,TRUE,NULL)) AS waitTrackEdNum "
				+ " FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(nextReservationTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ ")A "
				+ ","
				+ "("
				+ "	SELECT "
				+ "COUNT(*) AS trackAllNum,"
				+ "COUNT(IF(custt.taskDealStatus=2,TRUE,NULL)) AS trackNum,"
				+ "COUNT(IF(custt.taskOverTimeStatus=2,TRUE,NULL)) AS trackOverTimeNum"
				+ " FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE 1=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+ " AND DATE_FORMAT(finishDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")B ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackUser> trackUsers=new ArrayList<TrackUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackUsers = ResultSetUtil.getDateResult(trackUsers, resultSet, TrackUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!trackUsers.isEmpty()){
			return trackUsers.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：查询销售顾问总回访数据
	 * @return
	 */
	public List<TrackStatTotal> queryTrackUserStatTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT us.dbid,"
				+ "us.realName,"
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "sys_user us "
				+ "LEFT JOIN"
				+ "("
				+ "SELECT"
				+ "	bussiStaffId,"
				+ "	bussiStaff,"
				+ "	COUNT(*) AS createNum"
				+ " FROM"
				+ "	cust_customer cust "
				+ "WHERE"
				+ "	recordType=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
			sql=sql	+ " GROUP BY "
				+ "	bussiStaffId "
				+ ")A ON us.dbid=A.bussiStaffId "
				+ "LEFT JOIN "
				+ "(SELECT "
				+ "custt.userId, "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1 ";
			if(null!=enterprise){
				sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
			}
			if(type>0){
				sql=sql+" AND customerTypeId="+type;
			}
			if(tryCarStatus>0){
				sql=sql+" AND tryCarStatus="+tryCarStatus;
			}
			if(comeShopStatus>0){
				sql=sql+" AND comeShopStatus="+comeShopStatus;
			}
			sql=sql+ " GROUP BY "
				+ " custt.userId"
				+ ")B ON us.dbid=B.userId "
				+ "WHERE "
				+ "us.userState=1 AND us.bussiType<=2";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return trackStatTotals;
	}
	/**
	 * 功能描述：查询系统的客户平均回访率
	 * @return
	 */
	public TrackStatTotal queryTrackStatTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "("
				+ "SELECT"
				+ "		COUNT(*) AS createNum "
				+ "FROM"
				+ "	cust_customer cust "
				+ "WHERE"
				+ " recordType=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
			sql=sql	+ ")A,"
				+ "(SELECT "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON custt.customerId=cust.dbid "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1";
			if(null!=enterprise){
				sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
			}
			if(type>0){
				sql=sql+" AND customerTypeId="+type;
			}
			if(tryCarStatus>0){
				sql=sql+" AND tryCarStatus="+tryCarStatus;
			}
			if(comeShopStatus>0){
				sql=sql+" AND comeShopStatus="+comeShopStatus;
			}	
			sql=sql	+ ")B";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!trackStatTotals.isEmpty()){
			return trackStatTotals.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：查询销售顾问总回访数据
	 * @return
	 */
	public List<TrackStatTotal> queryTrackUserStatSuccessTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT us.dbid,"
				+ "us.realName,"
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "sys_user us "
				+ "LEFT JOIN"
				+ "("
				+ "SELECT"
				+ "	bussiStaffId,"
				+ "	bussiStaff,"
				+ "	COUNT(*) AS createNum"
				+ " FROM"
				+ "	cust_customer cust "
				+ " LEFT JOIN "
				+ "cust_ordercontract custo"
				+ "	ON"
				+ "	cust.dbid=custo.customerId "
				+ "WHERE"
				+ "	recordType=1 AND custo.`status`=4 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ " GROUP BY "
				+ "	bussiStaffId "
				+ ")A ON us.dbid=A.bussiStaffId "
				+ "LEFT JOIN "
				+ "(SELECT "
				+ "custt.userId, "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "LEFT JOIN "
				+ "cust_ordercontract custo "
				+ "ON "
				+ "cust.dbid=custo.customerId "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1 AND custo.`status`=4 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ " GROUP BY "
				+ " custt.userId"
				+ ")B ON us.dbid=B.userId "
				+ "WHERE "
				+ "us.userState=1 AND us.bussiType<=2";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return trackStatTotals;
	}
	/**
	 * 功能描述：查询系统的客户平均回访率
	 * @return
	 */
	public TrackStatTotal queryTrackStatSuccessTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "("
				+ "SELECT"
				+ "		COUNT(*) AS createNum "
				+ "FROM"
				+ "	cust_customer cust "
				+ " LEFT JOIN "
				+ "cust_ordercontract custo"
				+ "	ON"
				+ "	cust.dbid=custo.customerId "
				+ "WHERE"
				+ " recordType=1 AND custo.`status`=4 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")A,"
				+ "(SELECT "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON custt.customerId=cust.dbid "
				+ "LEFT JOIN "
				+ "cust_ordercontract custo "
				+ "ON "
				+ "cust.dbid=custo.customerId "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1 AND custo.`status`=4 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")B";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!trackStatTotals.isEmpty()){
			return trackStatTotals.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：查询销售顾问流失客户总回访数据
	 * @return
	 */
	public List<TrackStatTotal> queryTrackUserStatFlowTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT us.dbid,"
				+ "us.realName,"
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "sys_user us "
				+ "LEFT JOIN"
				+ "("
				+ "SELECT"
				+ "	bussiStaffId,"
				+ "	bussiStaff,"
				+ "	COUNT(*) AS createNum"
				+ " FROM"
				+ "	cust_customer cust "
				+ " LEFT JOIN "
				+ "cust_customerlastbussi custcl"
				+ "	ON"
				+ "	cust.dbid=custcl.customerId "
				+ "WHERE"
				+ "	recordType=1 AND custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ " GROUP BY "
				+ "	bussiStaffId "
				+ ")A ON us.dbid=A.bussiStaffId "
				+ "LEFT JOIN "
				+ "(SELECT "
				+ "custt.userId, "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON "
				+ "custt.customerId=cust.dbid "
				+ "LEFT JOIN "
				+ "cust_customerlastbussi custcl "
				+ "ON "
				+ "cust.dbid=custcl.customerId "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1 AND custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ " GROUP BY "
				+ " custt.userId"
				+ ")B ON us.dbid=B.userId "
				+ "WHERE "
				+ "us.userState=1 AND us.bussiType<=2";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return trackStatTotals;
	}
	/**
	 * 功能描述：查询系统的销售顾问流失客户平均回访率
	 * @return
	 */
	public TrackStatTotal queryTrackStatFlowTotalList(Enterprise enterprise,Integer type,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createNum,0) AS createNum,"
				+ "IFNULL(B.trackNum,0) AS trackNum,"
				+ "IFNULL(IFNULL(B.trackNum,0)/IFNULL(A.createNum,0),0) AS trackAvgNum "
				+ "FROM "
				+ "("
				+ "SELECT"
				+ "		COUNT(*) AS createNum "
				+ "FROM"
				+ "	cust_customer cust "
				+ " LEFT JOIN "
				+ "cust_customerlastbussi custcl"
				+ "	ON"
				+ "	cust.dbid=custcl.customerId "
				+ "WHERE"
				+ " recordType=1 AND custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")A,"
				+ "(SELECT "
				+ "COUNT(*) AS trackNum "
				+ "FROM "
				+ "cust_customertrack custt "
				+ "LEFT JOIN "
				+ "cust_customer cust "
				+ "ON custt.customerId=cust.dbid "
				+ "LEFT JOIN "
				+ "cust_customerlastbussi custcl "
				+ "ON "
				+ "cust.dbid=custcl.customerId "
				+ "WHERE "
				+ " taskDealStatus>=2 AND recordType=1 AND custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+ " AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ ")B";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<TrackStatTotal> trackStatTotals=new ArrayList<TrackStatTotal>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			trackStatTotals = ResultSetUtil.getDateResult(trackStatTotals, resultSet, TrackStatTotal.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!trackStatTotals.isEmpty()){
			return trackStatTotals.get(0);
		}
		return null;
	}
	 /**
	 * 功能描述：无数据日期自动设置为零，并对最终结果按日期从新排序
	 * @param startDate
	 * @param endDate
	 * @param tracks
	 */
	private void sortResult(String startDate, String endDate,List<Track> tracks,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=tracks.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (Track twoComeShop : tracks) {
						if(twoComeShop.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						Track comeShop = new Track(date);
						tracks.add(comeShop);
					}
				}
			}
			Collections.sort(tracks,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=tracks.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (Track comeShop : tracks) {
						String hasTemp = DateUtil.formatPatten(comeShop.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						Track comeShop = new Track(date);
						tracks.add(comeShop);
					}
				}
			}
			Collections.sort(tracks,new SortByDateComparator());
		}
	}
}
