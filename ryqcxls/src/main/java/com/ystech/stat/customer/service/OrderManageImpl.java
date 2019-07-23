package com.ystech.stat.customer.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import com.ystech.qywx.model.Count;
import com.ystech.stat.customer.model.Order;
import com.ystech.stat.customer.model.OrderBuyType;
import com.ystech.stat.customer.model.OrderType;
import com.ystech.stat.customer.model.OrderUser;
import com.ystech.stat.customer.model.StaTryCarYearByYearChainPer;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.StaYearByYearChain;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("orderManageImpl")
public class OrderManageImpl {
	public List<Order> queryFLow(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="	SELECT"
				+ "			DATE_FORMAT(custord.createTime,'%Y-%m-%d') AS createDate,"
				+ "			COUNT(*) AS orderNum,"
				+ "			COUNT(if(cust.recordType=1,TRUE,NULL)) AS selfOrderNum,"
				+ "			COUNT(if(cust.recordType=2,TRUE,NULL)) AS netOrderNum"
				+ "		FROM"
				+ "			cust_customer cust INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON cust.dbid=custord.customerId"
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		sql=sql+" GROUP BY 	"
				+ "	DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<Order> flowComms=new ArrayList<Order>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				flowComms = ResultSetUtil.getDateResult(flowComms, resultSet, Order.class);
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
	public Order queryOrderTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="	SELECT"
				+ "			COUNT(*) AS orderNum,"
				+ "			COUNT(if(cust.recordType=1,TRUE,NULL)) AS selfOrderNum,"
				+ "			COUNT(if(cust.recordType=2,TRUE,NULL)) AS netOrderNum"
				+ "		FROM"
				+ "			cust_customer cust INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON cust.dbid=custord.customerId"
				+ "		WHERE 1=1 AND custord.status>0 ";
		
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Order> flowComms=new ArrayList<Order>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowComms = ResultSetUtil.getDateResult(flowComms, resultSet, Order.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!flowComms.isEmpty()){
			Order flow = flowComms.get(0);
			return flow;
		}
		return null;
	}
	/**
	 * 功能描述：订单类型类型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<OrderType> queryOrderType(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "custtype.`name`,"
				+ "IFNULL(A.orderNum,0) AS orderNum "
				+ "FROM "
				+ "	cust_customerType	custtype "
				+ "LEFT JOIN("
				+ "	SELECT"
				+ "	cust.customerTypeId,"
				+ "	COUNT(*) orderNum"
				+ "	FROM"
				+ "			cust_customer cust"
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId"
				+ "		WHERE 1=1 AND custord.status>0 AND cust.recordType=1 ";
		
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
				sql=sql+ "	GROUP BY customerTypeId"
				+ ")A "
				+ "ON A.customerTypeId=custtype.dbid ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<OrderType> orderTypes=new ArrayList<OrderType>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				orderTypes = ResultSetUtil.getDateResult(orderTypes, resultSet, OrderType.class);
				createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}	
		return orderTypes;	
	}
	/**
	 * 功能描述：订单类型汇总
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public OrderType queryOrderTypeAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus){
		String sql="SELECT "
				+ "	COUNT(*) orderNum"
				+ "	FROM"
				+ "			cust_customer cust"
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId"
				+ "		WHERE 1=1 AND custord.status>0 AND cust.recordType=1 ";
		
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
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
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<OrderType> orderTypes=new ArrayList<OrderType>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			orderTypes = ResultSetUtil.getDateResult(orderTypes, resultSet, OrderType.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		if(!orderTypes.isEmpty()){
			OrderType orderType = orderTypes.get(0);
			return orderType;
		}
		return null;	
	}
	/**
	 * 功能描述：获取订单客户关注车型
	 * @param orders
	 * @param type
	 * @return
	 */
	public Map<Order,List<CarSerCount>> queryOrderCarSeriy(List<Order> orders,Enterprise enterprise,int type,int dateType,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		custcl.carSeriyId,COUNT(custcl.carSeriyId) AS totalNum "
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_ordercontract custord"
				+ "		ON cust.dbid=custord.customerId "
				+ "		INNER JOIN "
				+ "		cust_customerlastbussi custcl "
				+ "		ON cust.dbid=custcl.customerId "
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' ";
		sql=sql	+ "	GROUP BY custcl.carSeriyId "
			+ ")B "
			+ "	ON cs.dbid=B.carSeriyId "
			+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<Order,List<CarSerCount>> map=new HashMap<Order, List<CarSerCount>>(orders.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (Order staTryCar : orders) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staTryCar.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staTryCar, customerRecordTargets);
			}
			 Map<Order, List<CarSerCount>> sortMap =new TreeMap<Order, List<CarSerCount>>(new SortByDateComparator());
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
	public List<CarSerCount> queryOrderCarSeriyAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		custcl.carSeriyId,COUNT(custcl.carSeriyId) AS totalNum "
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_ordercontract custord"
				+ "		ON cust.dbid=custord.customerId "
				+ "		INNER JOIN "
				+ "		cust_customerlastbussi custcl "
				+ "		ON cust.dbid=custcl.customerId "
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql	+ "	GROUP BY custcl.carSeriyId "
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
	 * 功能描述：订单用户车型统计
	 * @param startDate
	 * @param endDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param customerInfromIds
	 * @return
	 */
	public List<OrderUser> queryOrderUser(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT A.dbid,A.bussiStaff,A.orderNum "
				+ "FROM "
				+ "(SELECT"
				+ "	cust.bussiStaffId AS dbid ,"
				+ "	cust.bussiStaff ,"
				+ "	COUNT(*) orderNum"
				+ "	FROM"
				+ "			cust_customer cust"
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId"
				+ "	WHERE "
				+ "		 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql		+ "	GROUP BY bussiStaffId )A order BY A.orderNum DESC ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<OrderUser> orderUsers=new ArrayList<OrderUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			orderUsers = ResultSetUtil.getDateResult(orderUsers, resultSet, OrderUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}	
		return orderUsers;	
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
	public OrderUser queryOrderUserAll(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT"
				+ "	COUNT(*) orderNum"
				+ "	FROM"
				+ "			cust_customer cust"
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId"
				+ "	WHERE "
				+ "		 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<OrderUser> flowUsers=new ArrayList<OrderUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			flowUsers = ResultSetUtil.getDateResult(flowUsers, resultSet, OrderUser.class);
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
	 * 功能描述：获取订单客户关注车型
	 * @param orderUsers
	 * @param type
	 * @return
	 */
	public Map<OrderUser,List<CarSerCount>> queryUserOrderCarSeriy(List<OrderUser> orderUsers,String startDate,String endDate,Enterprise enterprise,int type,int dateType,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		custcl.carSeriyId,COUNT(custcl.carSeriyId) AS totalNum "
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_ordercontract custord"
				+ "		ON cust.dbid=custord.customerId "
				+ "		INNER JOIN "
				+ "		cust_customerlastbussi custcl "
				+ "		ON cust.dbid=custcl.customerId "
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql+" AND bussiStaffId=PARAMUSERID ";
		sql=sql	+ "	GROUP BY custcl.carSeriyId "
			+ ")B "
			+ "	ON cs.dbid=B.carSeriyId "
			+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<OrderUser,List<CarSerCount>> map=new TreeMap<OrderUser, List<CarSerCount>>(new SortByUserComparator());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (OrderUser orderUser : orderUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("PARAMUSERID",orderUser.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(orderUser, customerRecordTargets);
			}
		 	createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：获取订单客户关注车型
	 * @param orderUsers
	 * @param type
	 * @return
	 */
	public List<CarSerCount> queryUserOrderCarSeriyAll(String startDate,String endDate,Enterprise enterprise,int type,int dateType,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		custcl.carSeriyId,COUNT(custcl.carSeriyId) AS totalNum "
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_ordercontract custord"
				+ "		ON cust.dbid=custord.customerId "
				+ "		INNER JOIN "
				+ "		cust_customerlastbussi custcl "
				+ "		ON cust.dbid=custcl.customerId "
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql	+ "	GROUP BY custcl.carSeriyId "
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
	public StaYearByYearChain queryOrderStaYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
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
				+ "					COUNT(IF(DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "					COUNT(IF(DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "					COUNT(IF(DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "				FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_ordercontract custord"
				+ "		ON cust.dbid=custord.customerId "
				+ "		INNER JOIN "
				+ "		cust_customerlastbussi custcl "
				+ "		ON cust.dbid=custcl.customerId "
				+ "		WHERE 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
	 * 功能描述：生成部门明细数据
	 * @param count
	 * @return
	 */
	public List<Count> queryDepOrder(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT"
				+ "	dep.dbid,"
				+ " dep.`name`,"
				+ " COUNT(dep.dbid) num "
				+ "	FROM "
				+"          sys_department dep"
				+ "			 INNER JOIN "		
				+ "			cust_customer cust"
					+"       ON  "		
					+"       dep.dbid=cust.departmentId  "		
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId "
				+ "	WHERE "
				+ "		 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql		+ "	GROUP BY cust.departmentId  order BY COUNT(*) DESC ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Count> depOrders=new ArrayList<Count>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			depOrders = ResultSetUtil.getDateResult(depOrders, resultSet, Count.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return depOrders;
	}
	/**
	 * 功能描述：购车方式
	 * @param count
	 * @return
	 */
	public List<OrderBuyType> queryBuyCarTypeOrder(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds,int tryCarStatus,int comeShopStatus,int recordType){
		String sql="SELECT"
				+ "	dep.name,"
				+ "	COUNT(IF(custorde.buyCarType=1,TRUE,NULL)) AS cashNum, "
				+ "	COUNT(IF(custorde.buyCarType=2,TRUE,NULL)) AS finNum, "
				+ "	COUNT(*) AS orderNum, "
				+ "	COUNT(IF(custorde.buyCarType=2,TRUE,NULL))/COUNT(*)*100 finPer "
				+ "	FROM "
				+ "			cust_customer cust"
				+ "			INNER JOIN"
				+ "			cust_ordercontract custord"
				+ "			ON"
				+ "			cust.dbid=custord.customerId "
				+ "         INNER JOIN "
				+ "         cust_ordercontractexpenses AS custorde"
				+ "			ON  "
				+ "			cust.dbid=custorde.customerId "
				+ "			INNER JOIN "
				+ "			sys_department dep "
				+ "			ON cust.departmentId=dep.dbid "
				+ "	WHERE "
				+ "		 1=1 AND custord.status>0 ";
		if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
		if(recordType>0){
			sql=sql+" AND recordType="+recordType;
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
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"'";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(custord.createTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"'";
		}
		sql=sql		+ "	GROUP BY cust.departmentId  order BY COUNT(*) DESC ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<OrderBuyType> depOrders=new ArrayList<OrderBuyType>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			depOrders = ResultSetUtil.getDateResult(depOrders, resultSet, OrderBuyType.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return depOrders;
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
	private void sortResult(String startDate, String endDate,List<Order> flowComms,int dateTye) {
		if(dateTye==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=flowComms.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (Order twoComeShop : flowComms) {
						if(twoComeShop.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						Order comeShop = new Order(date);
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
					for (Order comeShop : flowComms) {
						String hasTemp = DateUtil.formatPatten(comeShop.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						Order comeShop = new Order(date);
						flowComms.add(comeShop);
					}
				}
			}
			Collections.sort(flowComms,new SortByDateComparator());
		}
	}
	public class SortByUserComparator implements Comparator<OrderUser> {
		public int compare(OrderUser o1, OrderUser o2) {
			if(o1.getOrderNum()!=null&&o2.getOrderNum()!=null){
				if(o1.getOrderNum().compareTo(o2.getOrderNum())<0){
					return 1;
				}else{
					return  -1;
				}
			}
			return -1;
		}

	}
}
