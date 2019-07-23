/**
 * 
 */
package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.DayComeShop;
import com.ystech.cust.model.OverTimeUserCount;
import com.ystech.qywx.model.Count;

/**
 * @author shusanzhan
 * @date 2014-5-15
 */
@Component("statisticalSalerManageImpl")
public class StatisticalSalerManageImpl {
	
	public Object queryCountLevelCount(Date startDate,Date endDate,Integer userId,Integer customerPhaseId) {
		int total =0;
		String sql="SELECT  COUNT(*) AS total " +
				" FROM cust_customer AS cust,cust_customerphase AS custph" +
				" WHERE cust.customerPhaseId=custph.dbid " +
				" and cust.customerPhaseId="+customerPhaseId;
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		try {
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
	public List<CustomerPhase> queryCountLevel(Date startDate,Date endDate,Integer userId,Integer type) {
		String sql="SELECT "
				+ "	cp.`name`,IFNULL(b.totalNum,0) AS totalNum FROM cust_customerphase cp LEFT JOIN"
				+ "(SELECT  cp.dbid AS dbid ,COUNT(cust.customerPhaseId) AS totalNum " +
				" FROM cust_customer cust,cust_customerphase cp " +
				" WHERE cust.customerPhaseId=cp.dbid ";
		if(type!=null&&type>0){
			sql=sql+" AND cp.type="+type;
		}
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" AND cust.createFolderTime<='"+DateUtil.format(endDate) +"'";
		}
		sql=sql+" GROUP BY cp.dbid  ) B "
				+ "ON cp.dbid=B.dbid WHERE 1=1 ";
		if(type!=null&&type>0){
			sql=sql+" AND cp.type="+type;
		}
		List<CustomerPhase> customerPhases=new ArrayList<CustomerPhase>();
		Connection jdbcConnection=null;
		Statement createStatement=null;
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				CustomerPhase customerPhase=new CustomerPhase();
				String name= resultSet.getString("name");
				Integer totalNum= resultSet.getInt("totalNum");
				customerPhase.setName(name);;
				customerPhase.setTotalNum(totalNum);
				customerPhases.add(customerPhase);
				
			}
			createStatement.close();
			jdbcConnection.close();
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		finally{
			if(jdbcConnection!=null){
				try {
					jdbcConnection.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				jdbcConnection=null;
			}
			if(createStatement==null){
				try {
					createStatement.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			createStatement=null;
		}
		return customerPhases;
	}
	
	/**
	 * 功能描述：查询当天的来店数据统计分析情况
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param customerPhaseId
	 * @return
	 */
	public Object queryCountFirstLevelCount(Date startDate,Date endDate,Integer userId,Integer customerPhaseId) {
		int total =0;
		String sql="SELECT  COUNT(*) AS total " +
				" FROM cust_customer AS cust,cust_customerphase AS custph" +
				" WHERE cust.firstCustomerPhaseId=custph.dbid " +
				" and cust.firstCustomerPhaseId="+customerPhaseId+
				" AND cust.createFolderTime>='"+DateUtil.format(startDate)+"'" +
				" AND cust.createFolderTime<'"+DateUtil.format(endDate)+"' AND recordType=1";
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		try {
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
	/**
	 * 功能描述：查询当天的来店数据统计分析情况
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param customerPhaseId
	 * @return
	 */
	public Object queryCountFirstLevelCountByEnterPrise(Date startDate,Date endDate,Integer userId,Integer customerPhaseId,String entSql) {
		int total =0;
		String sql="SELECT  COUNT(*) AS total " +
				" FROM cust_customer AS cust,cust_customerphase AS custph" +
				" WHERE cust.firstCustomerPhaseId=custph.dbid " +
				" and cust.firstCustomerPhaseId="+customerPhaseId+
				" AND cust.createFolderTime>='"+DateUtil.format(startDate)+"'" +
				" AND cust.createFolderTime<'"+DateUtil.format(endDate)+"' AND recordType=1 ";
		if(null!=entSql){
			sql=sql+entSql;
		}
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		try {
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
	/**
	 * 查询客户等级信息
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param customerPhaseId
	 * @return
	 */
	public List<DayComeShop> queryLevlelDayComeShop(Date startDate,Date endDate,Integer userId,Integer customerPhaseId) {
		List<DayComeShop> resultDayComeShops=new ArrayList<DayComeShop>();
		List<DayComeShop> dayComeShops=new ArrayList<DayComeShop>();
		Calendar cal = Calendar.getInstance();
		int month = cal.get(Calendar.MONTH);
		String monString="";
		if(month<10){
			monString="0"+(month+1);
		}
		String sql = "SELECT DATE_FORMAT(cust.createFolderTime,'%e') as oneDay, COUNT(*) AS countNum " +
				"  FROM cust_customer AS cust,cust_customerphase AS custph " +
				"  WHERE cust.customerPhaseId=custph.dbid AND  DATE_FORMAT(cust.createFolderTime,'%m')='"+monString+"'" +
				" and cust.customerPhaseId=" +customerPhaseId;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		sql=sql+" GROUP BY oneDay order BY oneDay";
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				Integer oneDay = resultSet.getInt("oneDay");
				Integer countNum = resultSet.getInt("countNum");
				DayComeShop dayComeShop=new DayComeShop();
				dayComeShop.setCountNum(countNum);
				dayComeShop.setDay(oneDay);
				dayComeShops.add(dayComeShop);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		int lastDayOfMonth = getLastDayOfMonth();
		if(null!=dayComeShops&&dayComeShops.size()>0){
			if(dayComeShops.size()==lastDayOfMonth){
				return dayComeShops;
			}
			else{
				for (int i = 1; i <=lastDayOfMonth ; i++) {
					boolean state=false;
					for (DayComeShop dayComeShop : dayComeShops) {
						if(dayComeShop.getDay()==i){
							state=true;
							resultDayComeShops.add(dayComeShop);
						}
					}
					if(state==false){
						DayComeShop dayComeShop2 = new DayComeShop();
						dayComeShop2.setDay(i);
						dayComeShop2.setCountNum(0);
						resultDayComeShops.add(dayComeShop2);	
					}
				}
			}
		}else{
			for (int i = 1; i <=lastDayOfMonth ; i++) {
				DayComeShop dayComeShop2 = new DayComeShop();
				dayComeShop2.setDay(i);
				dayComeShop2.setCountNum(0);
				resultDayComeShops.add(dayComeShop2);
			}
		}
		
		return resultDayComeShops;
	}
	/**
	 * 查询客户等是否自有车情况
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param customerPhaseId
	 * @return
	 */
	public List<DayComeShop> queryHasCarShop(Date startDate,Date endDate,Integer userId) {
		List<DayComeShop> resultDayComeShops=new ArrayList<DayComeShop>();
		List<DayComeShop> dayComeShops=new ArrayList<DayComeShop>();
		String sql = "SELECT cpbr.hasCarWl AS harcarWl, COUNT(cpbr.hasCarWl) AS countNum " +
				"FROM cust_customer AS cust,cust_customerpidbookingrecord AS cpbr " +
				"WHERE " +
				" cust.dbid=cpbr.customerId AND cust.bussiStaffId="+userId +
				" AND createFolderTime>='"+DateUtil.format(startDate)+"' AND createFolderTime<'"+DateUtil.format(endDate)+"'  AND cpbr.wlStatus=" +CustomerPidBookingRecord.WLDEALED+
				" GROUP BY hasCarWl order by hasCarWl ";
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				Integer harcarWl = resultSet.getInt("harcarWl");
				Integer countNum = resultSet.getInt("countNum");
				DayComeShop dayComeShop=new DayComeShop();
				dayComeShop.setCountNum(countNum);
				dayComeShop.setDay(harcarWl);
				dayComeShops.add(dayComeShop);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		int hascarLength = 7;
		if(null!=dayComeShops&&dayComeShops.size()>0){
			if(dayComeShops.size()==hascarLength){
				return dayComeShops;
			}
			else{
				for (int i = 1; i <=hascarLength ; i++) {
					boolean state=false;
					for (DayComeShop dayComeShop : dayComeShops) {
						if(dayComeShop.getDay()==i){
							state=true;
							resultDayComeShops.add(dayComeShop);
						}
					}
					if(state==false){
						DayComeShop dayComeShop2 = new DayComeShop();
						dayComeShop2.setDay(i);
						dayComeShop2.setCountNum(0);
						resultDayComeShops.add(dayComeShop2);	
					}
				}
			}
		}else{
			for (int i = 1; i <=hascarLength ; i++) {
				DayComeShop dayComeShop2 = new DayComeShop();
				dayComeShop2.setDay(i);
				dayComeShop2.setCountNum(0);
				resultDayComeShops.add(dayComeShop2);
			}
		}
		
		return resultDayComeShops;
	}
	/**
	 * 功能描述：统计超时信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public List<OverTimeUserCount> queryOverTime(Integer userId) throws Exception {
		List<OverTimeUserCount> overTimeUserCounts=new ArrayList<OverTimeUserCount>();
		String sql="SELECT A.dbid, A.`name`,A.theNextDayTimeOutNum,B.trackingTotalNum FROM " +
				"(SELECT cust.dbid as dbid, cust.`name` AS `name`,timeout.theNextDayTimeOutNum " +
				"FROM " +
				"cust_customer AS cust,cust_timeoutstrackrecord AS timeout " +
				"where " +
				" cust.dbid=timeout.customerId AND cust.bussiStaffId=" +userId+
				" AND timeout.isNewlyAdd=true "+
				" AND timeout.theNextDayTimeOutNum>0 AND timeout.isNewlyAdd=TRUE)A  " +
				"LEFT OUTER JOIN" +
				"(" +
				"SELECT  cust.dbid as dbid, cust.`name` AS `name`,IFNULL(timeout.trackingTimeoutNum+timeout.trackingTotalNum,0 )AS trackingTotalNum " +
				"FROM " +
				"cust_customer AS cust,cust_timeoutstrackrecord AS timeout " +
				"where " +
				" cust.dbid=timeout.customerId AND cust.bussiStaffId= " +userId+
				" AND timeout.isNewlyAdd=false AND (timeout.trackingTimeoutNum>0 OR timeout.trackingTotalNum>0)" +
				")B " +
				" ON A.dbid=B.dbid";
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				Integer customerId = resultSet.getInt("dbid");
				Integer theNextDayTimeOutNum = resultSet.getInt("theNextDayTimeOutNum");
				Integer trackingTimeOutNum = resultSet.getInt("trackingTotalNum");
				String name = resultSet.getString("name");
				OverTimeUserCount overTimeCount=new OverTimeUserCount ();
				overTimeCount.setCustomerId(customerId);
				overTimeCount.setName(name);
				overTimeCount.setTheNextDayTimeOutNum(theNextDayTimeOutNum);
				overTimeCount.setTrackingTimeOutNum(trackingTimeOutNum);
				overTimeUserCounts.add(overTimeCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return overTimeUserCounts;
	}
	/**
	 * 统计数据
	 * @param sql
	 * @return
	 */
	public Object queryCount(String sql){
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
	/**
	 * 查询我的
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param departmentIds
	 * @return
	 */
	public List<CarSerCount> querySuccessCustomer(Date startDate,Date endDate,Integer userId,String departmentIds) {
		List<CarSerCount> carSerCounts=new ArrayList<CarSerCount>();
		String sql="SELECT " +
				"	A.dbid as serid,A.`name` as serName,COUNT(A.dbid) as countNum " +
				" from" +
				"	(" +
				"		SELECT" +
				"			stLevel.dbid,stLevel.`name`,sfac.vinCode" +
				"		FROM" +
				"			s_storeagelevel stLevel,s_factoryorder sfac" +
				"		WHERE" +
				"	sfac.storeAgeLevelId=stLevel.dbid" +
				"	)A," +
				"(" +
				"	SELECT" +
				"		cpid.vinCode" +
				"	FROM" +
				"		cust_customerpidbookingrecord cpid,cust_customer cu" +
				"	WHERE" +
				"		cpid.customerId=cu.dbid and cpid.pidStatus=2 ";
		if(userId>0){
			sql=sql+"AND cu.bussiStaffId="+userId;
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
		}
		if(null!=startDate){
			sql=sql+" AND cu.createFolderTime>='"+DateUtil.format(startDate)+"'";
		}
		if(null!=startDate){
			sql=sql+" and cu.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		sql=sql+" )B " +
				" WHERE " +
				" B.vinCode=A.vinCode GROUP BY A.dbid";
		System.err.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String serName = resultSet.getString("serName");
				Integer serid = resultSet.getInt("serid");
				Integer countNum = resultSet.getInt("countNum");
				CarSerCount carSerCount=new CarSerCount();
				carSerCount.setSerName(serName);
				carSerCount.setSerid(serid);
				carSerCount.setCountNum(countNum);
				carSerCounts.add(carSerCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return carSerCounts;
	}
	/**
	 * 功能描述：查询当天的来店数据统计分析情况
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param customerPhaseId
	 * @return
	 */
	public Object queryCountFirstLevelCount(Date startDate,Date endDate,Integer userId,Integer customerPhaseId,String userIds) {
		int total =0;
		String sql="SELECT  COUNT(*) AS total " +
				" FROM cust_customer AS cust,cust_customerphase AS custph" +
				" WHERE cust.firstCustomerPhaseId=custph.dbid " +
				" and cust.firstCustomerPhaseId="+customerPhaseId+
				" AND cust.createFolderTime>='"+DateUtil.format(startDate)+"'" +
				" AND cust.createFolderTime<'"+DateUtil.format(endDate)+"' AND recordType=1";
		if(null!=userId&&userId>0){
			sql=sql+" and cust.bussiStaffId="+userId;
		}
		if(null!=userIds&&userIds.trim().length()>0){
			sql=sql+" and cust.bussiStaffId in ("+userIds+")";
		}
		try {
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
	/**
	 * 功能描述：统一查询统计数据
	 * @param sql
	 * @return
	 */
	public List<Count> exceuteCountSql(String sql){
		List<Count> counts=new ArrayList<Count>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
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
				counts.add(carSerCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return counts;
	}
	/**
	 * 
	 * @param year
	 *            int 年份
	 * @param month
	 *            int 月份
	 * 
	 * @return int 某年某月的最后一天
	 */
	public static int getLastDayOfMonth() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.MONTH, 6);
		int i = cal.get(Calendar.MONTH);
		// 某年某月的最后一天
		return cal.getActualMaximum(Calendar.DATE);
	}
	public static void main(String[] args) {
		System.out.println(getLastDayOfMonth());
	}
}
