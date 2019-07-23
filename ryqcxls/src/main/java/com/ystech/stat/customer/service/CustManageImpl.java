package com.ystech.stat.customer.service;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.TreeMap;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.cust.model.CarSerCount;
import com.ystech.stat.customer.model.CustPhase;
import com.ystech.stat.customer.model.CustUser;

@Component("custManageImpl")
public class CustManageImpl {
	/**
	 * 功能描述：销售顾问统计-总
	 * @param enterpriseId
	 * @return
	 */
	public CustUser findByCustUsersAll(Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		String sql="SELECT "
				+ "IFNULL(COUNT(*),0) AS totalNum "
				+ "FROM "
				+ "cust_customer cust "
				+ "WHERE "
				+ "cust.lastResult=0 AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CustUser> custUsers=new ArrayList<CustUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			custUsers = ResultSetUtil.getDateResult(custUsers, resultSet, CustUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(!custUsers.isEmpty()){
			return custUsers.get(0);
		}
		return null;
	}
	/**
	 * 功能描述：销售顾问统计
	 * @param enterpriseId
	 * @return
	 */
	public List<CustUser> findByCustUsers(Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		String sql="SELECT "
				+ "bussiStaffId AS bussiStaffId,"
				+ "bussiStaff as bussiStaff,"
				+ "IFNULL(COUNT(*),0) AS totalNum "
				+ "FROM "
				+ "cust_customer cust "
				+ "WHERE "
				+ "cust.lastResult=0 AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ " GROUP BY bussiStaffId";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CustUser> custUsers=new ArrayList<CustUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			custUsers = ResultSetUtil.getDateResult(custUsers, resultSet, CustUser.class);
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return custUsers;
	}
	
	
	/**
	 * 功能描述：销售顾问-客户级别统计分析
	 * @param custUsers
	 * @param enterpriseId
	 * @return
	 */
	public Map<CustUser,List<CustPhase>> findByCustPhases(List<CustUser> custUsers,Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		Map<CustUser, List<CustPhase>> map=new TreeMap<CustUser, List<CustPhase>>(new CustUserComparator());
		String sql="SELECT "
				+ "custp.dbid,"
				+ "custp.`name`,"
				+ "IFNULL(A.totalNum,0) AS totalNum "
				+ "FROM "
				+ "cust_customerphase custp "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		cust.customerPhaseId,"
				+ "		COUNT(*) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust"
				+ "	WHERE"
				+ "		cust.lastResult=0 AND bussiStaffId=PARMUSERID AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql		+ "	GROUP BY"
				+ "		cust.customerPhaseId "
				+ ")A "
				+ "ON custp.dbid=A.customerPhaseId "
				+ "WHERE "
				+ "custp.warmStatus=2 ";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (CustUser custUser : custUsers) {
				List<CustPhase> custPhases=new ArrayList<CustPhase>();
				String tempSql=sql.replace("PARMUSERID", custUser.getBussiStaffId()+"");
				ResultSet resultSet = createStatement.executeQuery(tempSql);
				custPhases = ResultSetUtil.getDateResult(custPhases, resultSet, CustPhase.class);
				map.put(custUser, custPhases);
			}
		 	createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：销售顾问-车型统计汇总统计
	 * @param custUsers
	 * @param enterpriseId
	 * @return
	 */
	public Map<CustUser,List<CarSerCount>> findByCustUserCarSerCount(List<CustUser> custUsers,Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		Map<CustUser,List<CarSerCount>> map=new TreeMap<CustUser,List<CarSerCount>>(new CustUserComparator());
		String sql="SELECT "
				+ " cs.`name` AS serName,"
				+ "	cs.dbid AS serid,"
				+ "	IFNULL(B.totalNum,0) AS countNum"
				+ " FROM set_carseriy cs "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		custb.carSeriyId,COUNT(custb.carSeriyId) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_customerbussi custb"
				+ "	ON"
				+ "		cust.dbid=custb.customerId"
				+ "	WHERE"
				+ "		cust.lastResult=0  and bussiStaffId=PARMUSERID AND enterpriseId="+enterpriseId;
				if(tryCarStatus>0){
					sql=sql+" AND tryCarStatus="+tryCarStatus;
				}
				if(comeShopStatus>0){
					sql=sql+" AND comeShopStatus="+comeShopStatus;
				}
				sql=sql				+ "	GROUP BY"
				+ "	custb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ " WHERE cs.`status`=1 AND enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (CustUser custUser : custUsers) {
				List<CarSerCount> casCarSerCounts=new ArrayList<CarSerCount>();
				String tempSql=sql.replace("PARMUSERID", custUser.getBussiStaffId()+"");
				ResultSet resultSet = createStatement.executeQuery(tempSql);
				casCarSerCounts = ResultSetUtil.getDateResult(casCarSerCounts, resultSet, CarSerCount.class);
				map.put(custUser, casCarSerCounts);
			}
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 功能描述：销售顾问-车型统计汇总统计_总数据
	 * @param custUsers
	 * @param enterpriseId
	 * @return
	 */
	public List<CarSerCount> findByCustUserCarSerCountAll(Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		List<CarSerCount> casCarSerCounts=new ArrayList<CarSerCount>();
		String sql="SELECT "
				+ " cs.`name` AS serName,"
				+ "	cs.dbid AS serid,"
				+ "	IFNULL(B.totalNum,0) AS countNum"
				+ " FROM set_carseriy cs "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		custb.carSeriyId,COUNT(custb.carSeriyId) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_customerbussi custb"
				+ "	ON"
				+ "		cust.dbid=custb.customerId"
				+ "	WHERE"
				+ "		cust.lastResult=0   AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql
				+ "	GROUP BY"
				+ "	custb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ " WHERE cs.`status`=1 AND enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			casCarSerCounts = ResultSetUtil.getDateResult(casCarSerCounts, resultSet, CarSerCount.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return casCarSerCounts;
	}
	/**
	 * 功能描述：销售顾问-客户级别-车型统计
	 * @param custUsers
	 * @param enterpriseId
	 * @return
	 */
	public Map<CustUser,Map<CustPhase,List<CarSerCount>>> findByCarSerCount(Map<CustUser,List<CustPhase>> mapUsers,Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		Map<CustUser,Map<CustPhase,List<CarSerCount>>> map=new TreeMap<CustUser,Map<CustPhase,List<CarSerCount>>>(new CustUserComparator());
		String sql="SELECT "
				+ " cs.`name` AS serName,"
				+ "	cs.dbid AS serid,"
				+ "	IFNULL(B.totalNum,0) AS countNum"
				+ " FROM set_carseriy cs "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		custb.carSeriyId,COUNT(custb.carSeriyId) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_customerbussi custb"
				+ "	ON"
				+ "		cust.dbid=custb.customerId"
				+ "	WHERE"
				+ "		cust.lastResult=0 AND customerPhaseId=PARAMPHASE and bussiStaffId=PARMUSERID AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql
				+ "	GROUP BY"
				+ "	custb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ " WHERE cs.`status`=1 AND enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			Set<Entry<CustUser, List<CustPhase>>> entrySet = mapUsers.entrySet();
			for (Entry<CustUser, List<CustPhase>> entry : entrySet) {
				CustUser key = entry.getKey();
				List<CustPhase> value = entry.getValue();
				Map<CustPhase,List<CarSerCount>> tempMap=new TreeMap<CustPhase, List<CarSerCount>>(new CustPhaseComparator());
				for (CustPhase custPhase : value) {
					List<CarSerCount> casCarSerCounts=new ArrayList<CarSerCount>();
					String tempSql=sql.replace("PARMUSERID", key.getBussiStaffId()+"").replace("PARAMPHASE", custPhase.getDbid()+"");
					ResultSet resultSet = createStatement.executeQuery(tempSql);
					casCarSerCounts = ResultSetUtil.getDateResult(casCarSerCounts, resultSet, CarSerCount.class);
					tempMap.put(custPhase, casCarSerCounts);
				}
				map.put(key, tempMap);
			}
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	
	/**
	 * 功能描述：销售顾问统计
	 * @param enterpriseId
	 * @return
	 */
	public List<CustPhase> findByCustPhases(Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		String sql="SELECT "
				+ "custp.dbid,"
				+ "custp.`name`,"
				+ "A.totalNum "
				+ "FROM "
				+ "cust_customerphase custp "
				+ "INNER JOIN "
				+ "( "
				+ "	SELECT"
				+ "		cust.customerPhaseId,"
				+ "		COUNT(*) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust"
				+ "	WHERE"
				+ "		cust.lastResult=0 AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql
				+ "	GROUP BY"
				+ "		cust.customerPhaseId"
				+ ")A "
				+ "ON custp.dbid=A.customerPhaseId "
				+ "WHERE "
				+ "custp.warmStatus=2;";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CustPhase> custUsers=new ArrayList<CustPhase>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			custUsers = ResultSetUtil.getDateResult(custUsers, resultSet, CustPhase.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return custUsers;
	}
	/**
	 * 功能描述：客户级别-车型统计
	 * @param custUsers
	 * @param enterpriseId
	 * @return
	 */
	public Map<CustPhase,List<CarSerCount>> findByCustPhaseCarSerCount(List<CustPhase> custPhases,Integer enterpriseId,Integer tryCarStatus,Integer comeShopStatus){
		Map<CustPhase,List<CarSerCount>> map=new TreeMap<CustPhase,List<CarSerCount>>(new CustPhaseComparator());
		String sql="SELECT "
				+ " cs.`name` AS serName,"
				+ "	cs.dbid AS serid,"
				+ "	IFNULL(B.totalNum,0) AS countNum"
				+ " FROM set_carseriy cs "
				+ "LEFT JOIN ("
				+ "	SELECT"
				+ "		custb.carSeriyId,COUNT(custb.carSeriyId) AS totalNum"
				+ "	FROM"
				+ "		cust_customer cust INNER JOIN"
				+ "		cust_customerbussi custb"
				+ "	ON"
				+ "		cust.dbid=custb.customerId"
				+ "	WHERE"
				+ "		cust.lastResult=0 AND customerPhaseId=PARAMPHASE AND enterpriseId="+enterpriseId;
		if(tryCarStatus>0){
			sql=sql+" AND tryCarStatus="+tryCarStatus;
		}
		if(comeShopStatus>0){
			sql=sql+" AND comeShopStatus="+comeShopStatus;
		}
		sql=sql
				+ "	GROUP BY"
				+ "	custb.carSeriyId"
				+ ")B ON cs.dbid=B.carSeriyId "
				+ " WHERE cs.`status`=1 AND enterpriseId="+enterpriseId;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (CustPhase custPhase : custPhases) {
				List<CarSerCount> casCarSerCounts=new ArrayList<CarSerCount>();
				String tempSql=sql.replace("PARAMPHASE", custPhase.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(tempSql);
				casCarSerCounts = ResultSetUtil.getDateResult(casCarSerCounts, resultSet, CarSerCount.class);
				map.put(custPhase, casCarSerCounts);
			}
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	private static class CustUserComparator implements Comparator<CustUser>, Serializable {
        public int compare(CustUser g1, CustUser g2) {
        	 if (g2.getTotalNum() == null) {
                 return 1;
             }
             if (g1.getTotalNum() == null) {
                 return -1;
             }
            return g2.getTotalNum().compareTo(g1.getTotalNum());
        }
    }
	private static class CustPhaseComparator implements Comparator<CustPhase>, Serializable {
		public int compare(CustPhase g1, CustPhase g2) {
			return g1.getDbid().compareTo(g2.getDbid());
		}
	}
}
