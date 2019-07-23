package com.ystech.stat.customer.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.qywx.model.Count;
import com.ystech.stat.customer.model.OrderBuyType;

@Component("waitingCarManageImpl")
public class WaitingCarManageImpl {
	/**
	 * 功能描述：留存客户总数据13408346100
	 * 查询总统计数据
	 */
	public Integer getWaitingCountNum(Integer enterpriseId){
		String sql="SELECT " +
				"COUNT(*) as total "+
				"from "+
				"sys_enterprise ent,cust_customer cust,cust_customerpidbookingrecord cpid "+
				"WHERE "+
				"ent.dbid=cust.enterpriseId and cpid.customerId=cust.dbid AND cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED +" AND cpid.pidStatus!=-1 ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		Integer total = queryCount(sql);
		return total;
	}
	/**
	 * 功能描述：获取留存订单状态
	 * 查询总统计数据
	 */
	public Integer getOrderCarStatusNum(Integer enterpriseId,int hashCarStatus){
		String sql="SELECT " +
				"COUNT(*) as total FROM cust_customerpidbookingrecord cpid,cust_customer cust "+
				" WHERE  " +
				"	cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+
				" AND cpid.wlStatus="+CustomerPidBookingRecord.WLDEALED;
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		if(hashCarStatus>0){
			sql=sql+" and cpid.hasCarOrder="+hashCarStatus;
		}
		Integer total = queryCount(sql);
		return total;
	}
	/**
	 * 功能描述：物流处理状态
	 * 查询总统计数据
	 */
	public Integer getOrderWlStatusNum(Integer enterpriseId,int wlStatus){
		String sql="SELECT " +
				"COUNT(*) as total " +
				"FROM " +
				"cust_customerpidbookingrecord cpid,cust_customer cust "
				+ "WHERE cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED;
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		if(wlStatus>0){
			sql=sql+" and cpid.wlStatus="+wlStatus;
		}
		Integer total = queryCount(sql);
		return total;
	}
	/**
	 * 功能描述：购车方式
	 * 查询总统计数据
	 */
	public List<OrderBuyType>  getOrderBuyCarTypeNum(Integer enterpriseId){
		String sql="SELECT "
				+ "	dep.name,"
				+ "	COUNT(IF(custorde.buyCarType=1,TRUE,NULL)) AS cashNum, "
				+ "	COUNT(IF(custorde.buyCarType=2,TRUE,NULL)) AS finNum, "
				+ "	COUNT(*) AS orderNum, "
				+ "	COUNT(IF(custorde.buyCarType=2,TRUE,NULL))/COUNT(*)*100 finPer "
				+"	FROM " 
				+"	cust_customerpidbookingrecord cpid,"
				+ " cust_customer cust ,"
				+ "	cust_ordercontractexpenses AS custorde,"
				+ "	sys_department dep " +
				"WHERE cpid.customerId=cust.dbid AND custorde.customerId=cust.dbid AND dep.dbid=cust.departmentId  AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
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
	 * 功能描述：部门数据
	 * 查询总统计数据
	 */
	public List<Count> queryDepOrderNum(Integer enterpriseId){
		String sql="SELECT " 
				+ "	dep.dbid,"
				+ " dep.`name`,"
				+ " COUNT(dep.dbid) num "
				+"	FROM " 
				+" sys_department dep,"
				+" cust_customerpidbookingrecord cpid,"
				+ "cust_customer cust "
				+"WHERE cpid.customerId=cust.dbid AND dep.dbid=cust.departmentId AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
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
	 * 查询总统计数据
	 */
	public List<Count> queryUserOrderNum(Integer enterpriseId){
		String sql="SELECT " 
				+ "	cust.bussiStaffId as dbid,"
				+ " cust.bussiStaff AS name,"
				+ " COUNT(cust.bussiStaffId) num "
				+"	FROM " 
				+" cust_customerpidbookingrecord cpid,"
				+ "cust_customer cust "
				+"WHERE cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		sql=sql		+ "	GROUP BY cust.bussiStaffId  order BY COUNT(*) DESC ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Count> depOrders=new ArrayList<Count>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				Integer dbid = resultSet.getInt("dbid");
				String name = resultSet.getString("name");
				Integer num = resultSet.getInt("num");
				Count carSerCount=new Count();
				carSerCount.setDbid(dbid);
				carSerCount.setName(name);
				carSerCount.setNum(num);
				depOrders.add(carSerCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return depOrders;
	}
	/**
	 * 功能描述：获取订单客户关注车型
	 * @param orderUsers
	 * @param type
	 * @return
	 */
	public Map<Count,List<CarSerCount>> queryUserOrderCarSeriy(List<Count> orderUsers,Integer enterpriseId){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cpid.carSeriyId,COUNT(cpid.carSeriyId) AS totalNum "
				+ "	FROM"
				+" cust_customerpidbookingrecord cpid,"
				+ "cust_customer cust "
				+"WHERE cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		sql=sql+" AND bussiStaffId=PARAMUSERID ";
		sql=sql	+ "	GROUP BY cpid.carSeriyId "
			+ ")B "
			+ "	ON cs.dbid=B.carSeriyId "
			+ "WHERE cs.`status`=1 AND enterpriseId="+enterpriseId ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<Count,List<CarSerCount>> map=new TreeMap<Count, List<CarSerCount>>(new SortByUserOrderComparator());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (Count orderUser : orderUsers) {
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
	public List<CarSerCount> queryUserOrderCarSeriyAll(Integer enterpriseId){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cpid.carSeriyId,COUNT(cpid.carSeriyId) AS totalNum "
				+ "	FROM"
				+" cust_customerpidbookingrecord cpid,"
				+ "cust_customer cust "
				+"WHERE cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		sql=sql	+ "	GROUP BY cpid.carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterpriseId ;
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
	 * 功能描述：查询车型统计
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public List<Count> queryOrderCarSeriyWaiting(int enterpriseId) {
		String sql="SELECT " +
				"cs.dbid as dbid,cs.`name` as name,COUNT(cpid.carSeriyId) as num "+
				"from "+
				"cust_customer cust,cust_customerpidbookingrecord cpid,set_carseriy cs "+
				"WHERE "+
				"cust.dbid=cpid.customerId AND cpid.carSeriyId=cs.dbid ";
		sql=sql+ " AND cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED +" AND cpid.pidStatus!=-1";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		sql=sql+" GROUP BY " +
				" cs.dbid " +
				" ORDER BY num DESC;"; 
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Count> counts=new ArrayList<Count>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			counts = ResultSetUtil.getDateResult(counts, resultSet, Count.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return counts;
	}
	
	public List<Count> queryMonthNum(int enterpriseId) {
		String sql="SELECT "
				+ "	DATE_FORMAT(cpid.createTime,'%Y-%m') AS createDate,"
				+ " COUNT(*) num"
				+ " FROM"
				+ "  cust_customerpidbookingrecord cpid,cust_customer cust "
				+ " WHERE"
				+ " cpid.customerId=cust.dbid AND  cpid.pidStatus!=2 "
				+ "GROUP BY DATE_FORMAT(cpid.createTime,'%Y-%m') "
				+ "ORDER BY COUNT(*) DESC ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<Count> counts=new ArrayList<Count>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String createDate = resultSet.getString("createDate");
				Integer num = resultSet.getInt("num");
				Count carSerCount=new Count();
				carSerCount.setName(createDate);
				carSerCount.setNum(num);
				counts.add(carSerCount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return counts;
	}
	/**
	 * 功能描述：获取订单客户关注车型
	 * @param orderUsers
	 * @param type
	 * @return
	 */
	public Map<Count,List<CarSerCount>> queryMonthOrderCarSeriy(List<Count> countMonths,Integer enterpriseId){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cpid.carSeriyId,COUNT(cpid.carSeriyId) AS totalNum "
				+ "	FROM"
				+" cust_customerpidbookingrecord cpid,"
				+ "cust_customer cust "
				+"WHERE cpid.customerId=cust.dbid AND  cpid.pidStatus!="+CustomerPidBookingRecord.FINISHED+" ";
		if(enterpriseId>0){
			sql=sql+" AND cust.enterpriseId=?"+enterpriseId;
		}
		sql=sql+" AND DATE_FORMAT(cpid.createTime,'%Y-%m')='DATEPARAM' ";
		sql=sql	+ "	GROUP BY cpid.carSeriyId "
			+ ")B "
			+ "	ON cs.dbid=B.carSeriyId "
			+ "WHERE cs.`status`=1 AND enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<Count,List<CarSerCount>> map=new TreeMap<Count, List<CarSerCount>>(new SortByUserOrderComparator());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (Count orderUser : countMonths) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("DATEPARAM",orderUser.getName());
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
	 * 统计数据
	 * @param sql
	 * @return
	 */
	private Integer queryCount(String sql){
		int total =0;
		try{
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				total= resultSet.getInt("total");
			}
			createStatement.close();
			jdbcConnection.close();
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return total;
	}
	public class SortByUserOrderComparator implements Comparator<Count> {
		public int compare(Count o1, Count o2) {
			if(o1.getNum()!=null&&o2.getNum()!=null){
				if(o1.getNum().compareTo(o2.getNum())<0){
					return 1;
				}else{
					return  -1;
				}
			}
			return -1;
		}

	}
}
