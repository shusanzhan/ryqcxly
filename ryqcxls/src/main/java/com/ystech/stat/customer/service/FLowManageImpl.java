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
import com.ystech.stat.customer.model.Flow;
import com.ystech.stat.customer.model.FlowCarSeriy;
import com.ystech.stat.customer.model.FlowComeShopType;
import com.ystech.stat.customer.model.FlowReason;
import com.ystech.stat.customer.model.FlowUser;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("fLowManageImpl")
public class FLowManageImpl {
	public List<Flow> queryFLow(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "A.createDate,"
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.flowNum,0) flowNum,"
				+ "IFNULL(IFNULL(A.createFolderNum,0)-IFNULL(B.flowNum,0),0) AS addNum "
				+ "FROM"
				+ "("
				+ "		SELECT"
				+ "			DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate,"
				+ "			COUNT(*) AS createFolderNum"
				+ "		FROM"
				+ "			cust_customer"
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
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
				sql=sql+ "		GROUP BY"
						+ "		DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ ")A"
				+ " LEFT JOIN"
				+ "("
				+ "		SELECT"
				+ "			DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS approvalDate,"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE 1=1 AND recordType=1 AND cust.dbid=custcl.customerId  AND custcl.approvalStatus=1 ";
			if(null!=enterprise){
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
			}
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
			sql=sql	+ "		GROUP BY"
				+ "			DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")"
				+ ")B ON A.createDate=B.approvalDate";
			
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<Flow> flowComms=new ArrayList<Flow>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				flowComms = ResultSetUtil.getDateResult(flowComms, resultSet, Flow.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			sortResult(startDate, endDate, flowComms, dateType);
			return flowComms;
	}
	/**
	 * 功能描述：查询时间内流失汇总数据
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public Flow queryFLowTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.flowNum,0) flowNum,"
				+ "IFNULL(IFNULL(A.createFolderNum,0)-IFNULL(B.flowNum,0),0) AS addNum "
				+ "FROM"
				+ "("
				+ "		SELECT"
				+ "			COUNT(*) AS createFolderNum"
				+ "		FROM"
				+ "			cust_customer"
				+ "		WHERE 1=1 AND  recordType=1 ";
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
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ ")A"
				+ ","
				+ "("
				+ "		SELECT"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE recordType=1 AND cust.dbid=custcl.customerId  AND custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		List<Flow> flowComms=new ArrayList<Flow>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowComms = ResultSetUtil.getDateResult(flowComms, resultSet, Flow.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!flowComms.isEmpty()){
			Flow flow = flowComms.get(0);
			return flow;
		}
		return null;
	}
	/**
	 * 功能描述：流失按客户类型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<FlowComeShopType> queryFlowComeShopType(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "type.dbid,type.`name`, "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0) AS totalNum,"
				+ "IFNULL(C.flowNum,0) AS flowNum,"
				+ "IFNULL(C.flowNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS flowPer "
				+ "FROM "
				+ "cust_customertype type "
				+ "LEFT JOIN "
				+ "("
				+ "	SELECT"
				+ "		customerTypeId,"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer  "
				+ "	WHERE  recordType=1 ";
		
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
				if(tryCarStatus>0){
					sql=sql+" AND tryCarStatus="+tryCarStatus;
				}
				if(comeShopStatus>0){
					sql=sql+" AND comeShopStatus="+comeShopStatus;
				}
				sql=sql+ "	GROUP BY customerTypeId"
				+ ")A "
				+ "ON A.customerTypeId=type.dbid "
				+ "LEFT JOIN"
				+ "("
				+ "	SELECT"
				+ "	customerTypeId,"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE  cust.dbid=custc.customerId AND recordType=1 ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
				sql=sql+ "	GROUP BY customerTypeId"
				+ ")B ON type.dbid=B.customerTypeId "
				+ "LEFT JOIN("
				+ "	SELECT"
				+ "		customerTypeId,"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
				sql=sql+ "		GROUP BY"
				+ "			customerTypeId"
				+ ")C ON type.dbid=C.customerTypeId";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<FlowComeShopType> flowComeShopTypes=new ArrayList<FlowComeShopType>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				flowComeShopTypes = ResultSetUtil.getDateResult(flowComeShopTypes, resultSet, FlowComeShopType.class);
				createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}	
		return flowComeShopTypes;	
	}
	/**
	 * 功能描述：流失按客户类型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public FlowComeShopType queryFlowComeShopTypeAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0) AS totalNum,"
				+ "IFNULL(C.flowNum,0) AS flowNum,"
				+ "IFNULL(C.flowNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS flowPer "
				+ "FROM "
				+ "("
				+ "	SELECT"
				+ "		customerTypeId,"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer  "
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
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ ")A,"
				+ "("
				+ "	SELECT"
				+ "	customerTypeId,"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE 1=1  AND cust.dbid=custc.customerId AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ ")B,("
				+ "	SELECT"
				+ "		customerTypeId,"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ "	)C";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<FlowComeShopType> flowComeShopTypes=new ArrayList<FlowComeShopType>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowComeShopTypes = ResultSetUtil.getDateResult(flowComeShopTypes, resultSet, FlowComeShopType.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		if(!flowComeShopTypes.isEmpty()){
			FlowComeShopType flowComeShopType = flowComeShopTypes.get(0);
			return flowComeShopType;
		}
		return null;	
	}
	/**
	 * 功能描述：流失原因统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<FlowReason> queryFlowReason(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "custf.dbid,custf.`name`,"
				+ "IFNULL(A.flowNum,0) AS flowNum "
				+ "FROM "
				+ "cust_customerflowreason custf LEFT JOIN"
				+ "("
				+ "SELECT"
				+ "	customerFlowReasonId,"
				+ "	COUNT(*) AS flowNum FROM"
				+ "	cust_customer cust,cust_customerlastbussi custcl "
				+ "WHERE"
				+ " cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+" GROUP BY"
				+ " customerFlowReasonId"
				+ ")A ON A.customerFlowReasonId=custf.dbid";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<FlowReason> flowReasons=new ArrayList<FlowReason>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowReasons = ResultSetUtil.getDateResult(flowReasons, resultSet, FlowReason.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		return flowReasons;
	}
	/**
	 * 功能描述：获取流失客户关注车型
	 * @param flows
	 * @param type
	 * @return
	 */
	public Map<Flow,List<CarSerCount>> queryFlowCarSeriy(List<Flow> flows,Enterprise enterprise,int type,int dateType,int tryCarStatus,int comeShopStatus){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cb.carSeriyId,COUNT(cb.carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb,cust_customerlastbussi custcl "
				+ " WHERE"
				+ " cust.dbid=cb.customerId	AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 AND recordType=1 ";
		if(enterprise!=null){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
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
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
			sql=sql	+ "	GROUP BY cb.carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<Flow,List<CarSerCount>> map=new HashMap<Flow, List<CarSerCount>>(flows.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (Flow staTryCar : flows) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staTryCar.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staTryCar, customerRecordTargets);
			}
			 Map<Flow, List<CarSerCount>> sortMap =new TreeMap<Flow, List<CarSerCount>>(new SortByDateComparator());
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
	public List<CarSerCount> queryFlowCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cb.carSeriyId,COUNT(cb.carSeriyId) AS totalNum"
				+ " FROM"
				+ "	 cust_customer cust,cust_customerbussi cb,cust_customerlastbussi custcl "
				+ " WHERE"
				+ "	 cust.dbid=cb.customerId	AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql	+ "	GROUP BY cb.carSeriyId "
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
	 * 功能描述：查询车型试驾率统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<FlowCarSeriy> queryCarSeriyTryCar(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
					+ "cs.dbid,cs.`name`,"
					+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
					+ "IFNULL(B.retainNum,0) AS retainNum,"
					+ "IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0) AS totalNum,"
					+ "IFNULL(C.flowNum,0) AS flowNum,"
					+ "IFNULL(C.flowNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS flowPer "
					+ "FROM "
					+ "set_carseriy cs "
					+ "LEFT JOIN "
					+ "("
					+ "	SELECT"
					+ "		cb.carSeriyId,"
					+ "		COUNT(*) AS createFolderNum"
					+ "	FROM"
					+ "		cust_customer cust,cust_customerbussi cb  "
					+ "	WHERE cust.dbid=cb.customerId AND recordType=1 ";
			
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
					if(tryCarStatus>0){
						sql=sql+" AND tryCarStatus="+tryCarStatus;
					}
					if(comeShopStatus>0){
						sql=sql+" AND comeShopStatus="+comeShopStatus;
					}
					sql=sql+ "	GROUP BY cb.carSeriyId "
					+ ")A "
					+ "ON A.carSeriyId=cs.dbid "
					+ "LEFT JOIN"
					+ "("
					+ "	SELECT"
					+ "	cb.carSeriyId,"
					+ "	COUNT(*) AS retainNum"
					+ "	FROM"
					+ "	cust_customer cust,cust_customerbussi cb,"
					+ "	sta_customercopy custc"
					+ "	WHERE cust.dbid=cb.customerId AND cust.dbid=custc.customerId AND recordType=1 ";
					if(null!=enterprise){
						sql=sql+" AND enterpriseId="+enterprise.getDbid();
					}
					if(null!=startDate&&startDate.trim().length()>0){
						sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
					}
					if(null!=endDate&&endDate.trim().length()>0){
						sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
					sql=sql+ "	GROUP BY cb.carSeriyId"
					+ ")B ON cs.dbid=B.carSeriyId "
					+ "LEFT JOIN("
					+ "	SELECT"
					+ "			cb.carSeriyId,"
					+ "			COUNT(*) AS flowNum"
					+ "		FROM"
					+ "			cust_customer cust,cust_customerbussi cb,cust_customerlastbussi custcl"
					+ "		WHERE"
					+ "			cust.dbid=cb.customerId AND recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 ";
					if(null!=enterprise){
						sql=sql+" AND enterpriseId="+enterprise.getDbid();
					}
					if(null!=startDate&&startDate.trim().length()>0){
						sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
					}
					if(null!=endDate&&endDate.trim().length()>0){
						sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
					sql=sql+ " GROUP BY cb.carSeriyId "
					+ ")C ON cs.dbid=C.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<FlowCarSeriy> flowCarSeriys=new ArrayList<FlowCarSeriy>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowCarSeriys = ResultSetUtil.getDateResult(flowCarSeriys, resultSet, FlowCarSeriy.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return flowCarSeriys;
	}
	/**
	 * 功能描述：流失按客户类型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<FlowUser> queryFlowUser(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "A.userId ,A.userName, "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0) AS totalNum,"
				+ "IFNULL(C.flowNum,0) AS flowNum,"
				+ "IFNULL(C.flowNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS flowPer "
				+ "FROM "
				+ "("
				+ "	SELECT"
				+ "		cust.bussiStaffId AS userId,"
				+ "		cust.bussiStaff AS userName,"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer cust "
				+ "	WHERE recordType=1 AND recordType=1 ";
		
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
				if(tryCarStatus>0){
					sql=sql+" AND tryCarStatus="+tryCarStatus;
				}
				if(comeShopStatus>0){
					sql=sql+" AND comeShopStatus="+comeShopStatus;
				}
				sql=sql+ "	GROUP BY cust.bussiStaffId"
				+ ")A "
				+ "LEFT JOIN"
				+ "("
				+ "	SELECT"
				+ "	cust.bussiStaffId,"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE  cust.dbid=custc.customerId AND recordType=1 ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
				sql=sql+ "	GROUP BY cust.bussiStaffId"
				+ ")B ON A.userId=B.bussiStaffId "
				+ "LEFT JOIN("
				+ "	SELECT"
				+ "			cust.bussiStaffId,"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 ";
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
				sql=sql+ "		GROUP BY"
				+ "			cust.bussiStaffId"
				+ ")C ON A.userId=C.bussiStaffId";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<FlowUser> flowUsers=new ArrayList<FlowUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowUsers = ResultSetUtil.getDateResult(flowUsers, resultSet, FlowUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		return flowUsers;	
	}
	/**
	 * 功能描述：流失按客户类型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public FlowUser queryFlowUserAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(A.createFolderNum,0) AS createFolderNum,"
				+ "IFNULL(B.retainNum,0) AS retainNum,"
				+ "IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0) AS totalNum,"
				+ "IFNULL(C.flowNum,0) AS flowNum,"
				+ "IFNULL(C.flowNum,0)/(IFNULL(A.createFolderNum,0)+IFNULL(B.retainNum,0))*100 AS flowPer "
				+ "FROM "
				+ "("
				+ "	SELECT"
				+ "		COUNT(*) AS createFolderNum"
				+ "	FROM"
				+ "		cust_customer cust  "
				+ "	WHERE recordType=1 AND recordType=1 ";
		
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
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ "	)A "
				+ ","
				+ "("
				+ "	SELECT"
				+ "	COUNT(*) AS retainNum"
				+ "	FROM"
				+ "	cust_customer cust,"
				+ "	sta_customercopy custc"
				+ "	WHERE  cust.dbid=custc.customerId AND recordType=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custc.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		sql=sql+ "	)B,("
				+ "	SELECT"
				+ "			COUNT(*) AS flowNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl"
				+ "		WHERE recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		sql=sql+ "	)C";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<FlowUser> flowUsers=new ArrayList<FlowUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowUsers = ResultSetUtil.getDateResult(flowUsers, resultSet, FlowUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		if(!flowUsers.isEmpty()){
			return flowUsers.get(0);
		}
		return null;	
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
	public StaYearByYearChain queryCreateFolderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
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
				+ "					cust_customer cust"
				+ "				WHERE 1=1  AND recordType=1 ";
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
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
	 * 功能描述：获取创建潜客数据同比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaYearByYearChain queryFlowStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
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
				+ "					COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "					cust_customer cust,cust_customerlastbussi custcl "
				+ "				WHERE recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1  ";
		if(type>0){
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
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
	 * 功能描述：流失率比环比数据
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public StaTryCarYearByYearChainPer queryFLowYearByYearChainPer(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
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
				+ "	IFNULL(IFNULL(B.nowNum,0)/(IFNULL(A.nowNum,0)+IFNULL(C.nowNum,0))*100,0) AS nowTryCarPer,"
				+ "	IFNULL(IFNULL(B.preNum,0)/(IFNULL(A.preNum,0)+IFNULL(C.preNum,0))*100,0) AS preTryCarPer,"
				+ "	IFNULL(IFNULL(B.yearByYearNum,0)/(IFNULL(A.yearByYearNum,0)+IFNULL(C.yearByYearNum,0))*100,0) AS yearByYearTryCarPer"
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
			sql=sql+" AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
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
			sql=sql+" AND customerTypeId="+type;
		}
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql+ ")C,("
				+ "		SELECT"
				+ "			COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "			COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "			COUNT(IF(DATE_FORMAT(custcl.approvalDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "			cust_customer cust,cust_customerlastbussi custcl "
				+ "		WHERE recordType=1 AND cust.dbid=custcl.customerId  AND  custcl.approvalStatus=1  ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
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
		sql=sql	+ "	)B";
		StaTryCarYearByYearChainPer queryStaTryCarYearByYearChainPer = queryStaTryCarYearByYearChainPer(sql);
		if(null!=queryStaTryCarYearByYearChainPer){
			queryStaTryCarYearByYearChainPer.setItemName("流失率");
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
	 * @param flowComms
	 */
	private void sortResult(String startDate, String endDate,List<Flow> flowComms,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=flowComms.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (Flow twoComeShop : flowComms) {
						if(twoComeShop.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						Flow comeShop = new Flow(date);
						flowComms.add(comeShop);
					}
				}
			}
			Collections.sort(flowComms,new SortByDateComparator());
		}
		if(dateTye==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=flowComms.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (Flow comeShop : flowComms) {
						String hasTemp = DateUtil.formatPatten(comeShop.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						Flow comeShop = new Flow(date);
						flowComms.add(comeShop);
					}
				}
			}
			Collections.sort(flowComms,new SortByDateComparator());
		}
	}
}
