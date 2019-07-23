package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CityCrossCustomerCount;
import com.ystech.cust.model.DayComeShop;
import com.ystech.cust.model.InfoFromTotal;

@Component("roomManageStaticManageImpl")
public class RoomManageStaticManageImpl {
	/**
	 * 进店来店数据统计
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public List<DayComeShop> queryCountDayComeShop(String dateMonth,String selSql,Integer comeType) {
		List<DayComeShop> resultDayComeShops=new ArrayList<DayComeShop>();
		List<DayComeShop> dayComeShops=new ArrayList<DayComeShop>();
		String sql = "";
		sql=sql+" SELECT a.oneDay AS oneDay,a.countNum AS countNum,ROUND(a.countNum/b.countNum*100,2) AS per  FROM " +
				" (SELECT" +
				"	DATE_FORMAT(cust.createFolderTime,'%e') as oneDay,COUNT(*) AS countNum " +
				"   FROM" +
				"	cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"   where " +
				"   cust.dbid=custsr.customerId AND custsr.comeType= "+comeType;
			sql=sql+" AND DATE_FORMAT(cust.createFolderTime,'%Y-%m')='"+dateMonth +"'";
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql;
		}
		sql=sql+"   group by oneDay )a," +
				" ( " +
				"	SELECT	COUNT(*) AS countNum " +
				"   FROM " +
				"   cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"   where" +
				"   cust.dbid=custsr.customerId  AND custsr.comeType="+comeType;
		sql=sql+" AND DATE_FORMAT(cust.createFolderTime,'%Y-%m')='"+dateMonth +"'";
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql;
		}
		sql=sql+")b";

		System.out.println(sql);
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
				double per = resultSet.getDouble("per");
				DayComeShop dayComeShop=new DayComeShop();
				dayComeShop.setCountNum(countNum);
				dayComeShop.setPer(per);
				dayComeShop.setDay(oneDay);
				dayComeShops.add(dayComeShop);
			}
			createStatement.close();
			jdbcConnection.close();
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
						dayComeShop2.setPer(Double.valueOf("0"));
						resultDayComeShops.add(dayComeShop2);	
					}
				}
			}
		}else{
			for (int i = 1; i <=lastDayOfMonth ; i++) {
				DayComeShop dayComeShop2 = new DayComeShop();
				dayComeShop2.setDay(i);
				dayComeShop2.setCountNum(0);
				dayComeShop2.setPer(Double.valueOf("0"));
				resultDayComeShops.add(dayComeShop2);
			}
		}
		
		return resultDayComeShops;
	}
	/**
	 * 功能描述：获取车型统计数据
	 * @param startDate
	 * @param endDate
	 * @param saleSql
	 * @return
	 */
	public List<CarSerCount> queryCountCar(Date startDate,Date endDate,String saleSql) {
		List<CarSerCount> carSerCounts=new ArrayList<CarSerCount>();
		String sql="SELECT a.carName as serName,a.carsId as serId,a.countNum as countNum,ROUND(a.countNum/b.total*100,2) AS per FROM" +
		"(SELECT " +
		"	cars.itemType AS itemType,cars.`name` AS carName,cars.dbid AS carsId, COUNT(cars.`name`) AS countNum " +
		" FROM " +
		"	set_carseriy AS cars,cust_customerbussi AS cb,cust_customer AS cust " +
		" WHERE " +
		" cars.dbid=cb.carSeriyId AND cb.customerId=cust.dbid " ;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=saleSql&&saleSql.trim().length()>0){
			sql=sql+" and "+saleSql;
		}
		sql=sql+" GROUP BY itemType,carName" +
		")a , ";
		sql=sql+"(SELECT COUNT(*) AS total	" +
				" FROM 	cust_customer AS cust,cust_customerbussi AS cb " +
				"	where 	cust.dbid=cb.customerId ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=saleSql&&saleSql.trim().length()>0){
			sql=sql+" and "+saleSql;
		}	
		sql=sql+")b ";
		
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
				Double per = resultSet.getDouble("per");
				CarSerCount carSerCount=new CarSerCount();
				carSerCount.setSerName(serName);
				carSerCount.setSerid(serid);
				carSerCount.setCountNum(countNum);
				carSerCount.setPer(per);
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
	 * 功能描述：获取意向车型客户
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	public Integer queryCountCarTotal(Date startDate,Date endDate,String useSql){
		int total =0;
		String sql="";
		sql=sql+"SELECT COUNT(*) AS total	" +
				" FROM 	cust_customer AS cust,cust_customerbussi AS cb " +
				"	where 	cust.dbid=cb.customerId ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=useSql&&useSql.trim().length()>0){
			sql=sql+" and "+useSql;
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
	 * 统计分析：渠道统计
	 * @param startDate
	 * @param endDate
	 * @param selSql
	 * @return
	 */
	public List<InfoFromTotal> queryCountInfo(Date startDate,Date endDate,String selSql) {
		List<InfoFromTotal> infoFromTotal=new ArrayList<InfoFromTotal>();
		String sql="SELECT A.dbid,A.inName,A.totalCount AS totalCount,ROUND(A.totalCount/B.totalCount*100,2) AS per FROM" +
				"(" +
				" SELECT info.dbid AS dbid, info.`name` AS inName,COUNT(info.dbid) AS totalCount" +
				" from cust_infofrom AS info,cust_customer AS cust" +
				" where cust.infoFromId=info.dbid AND info.dbid>58 " ;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql+" ";
		}
		sql=sql+"GROUP BY info.`name` ORDER BY dbid" +
				")A,";
		sql=sql+"(SELECT COUNT(*) AS totalCount " +
				" FROM cust_infofrom AS info,cust_customer AS cust " +
				" WHERE cust.infoFromId=info.dbid  AND info.dbid>58 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql+"";
		}	
		sql=sql+")B ";
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String inName = resultSet.getString("inName");
				Integer dbid = resultSet.getInt("dbid");
				Integer totalCount = resultSet.getInt("totalCount");
				Double per = resultSet.getDouble("per");
				InfoFromTotal carSerCount=new InfoFromTotal();
				carSerCount.setInName(inName);
				carSerCount.setDbid(dbid);
				carSerCount.setTotalCount(totalCount);
				carSerCount.setPer(per);
				infoFromTotal.add(carSerCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return infoFromTotal;
	}
	/**
	 * 查询渠道分析总数
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	public Integer queryCountInfoTotal(Date startDate,Date endDate,String userIds){
		int total =0;
		String sql="";
		sql=sql+"SELECT COUNT(*) AS totalCount " +
				" FROM cust_infofrom AS info,cust_customer AS cust " +
				" WHERE cust.infoFromId=info.dbid ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
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
				total= resultSet.getInt("totalCount");
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
	 * 功能描述：统计同城交叉客户
	 * @param startDate
	 * @param endDate
	 * @param selSql
	 * @return
	 */
	public List<CityCrossCustomerCount> queryCityCrossCustomerCounts(Date startDate,Date endDate,String selSql) {
		List<CityCrossCustomerCount> cityCrossCustomerCounts=new ArrayList<CityCrossCustomerCount>();
		String sql="SELECT " +
				   " city.dbid AS dbid,city.`name` AS cityName, count(city.dbid)  AS totalCount "+
				   " FROM "+
				   " cust_customer AS cust,cust_citycrosscustomer as city "+
				   " WHERE "+
				   " city.dbid=cust.cityCrossCustomerId  " +
				   " AND " +
				   " city.dbid>1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql+" ";
		}
		sql =sql+" GROUP BY city.`name` ORDER BY city.dbid ";
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String cityName = resultSet.getString("cityName");
				Integer dbid = resultSet.getInt("dbid");
				Integer totalCount = resultSet.getInt("totalCount");
				CityCrossCustomerCount cityCrossCustomerCount=new CityCrossCustomerCount();
				cityCrossCustomerCount.setName(cityName);
				cityCrossCustomerCount.setDbid(dbid);
				cityCrossCustomerCount.setTotalCount(totalCount);
				cityCrossCustomerCounts.add(cityCrossCustomerCount);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return cityCrossCustomerCounts;
	}
	/**
	 * 功能描述：统计同城交叉客户 总计
	 * @param startDate
	 * @param endDate
	 * @param departmentIds
	 * @return
	 */
	public Integer queryCityCrossCustomerCount(Date startDate,Date endDate,String userIds) {
		Integer count=null;
		String sql="SELECT " +
				" count(*) as countNum "+
				" FROM "+
				" cust_customer AS cust,cust_citycrosscustomer as city "+
				" WHERE "+
				" city.dbid=cust.cityCrossCustomerId  " +
				" AND " +
				" city.dbid>1 ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=userIds&&userIds.trim().length()>0){
			sql=sql+" and cust.bussiStaffId in ("+userIds+")";
		}
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				count=resultSet.getInt("countNum");
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return count;
	}
	
	/**
	 * 功能描述：来店方式统计
	 * @param dateMonth
	 * @param userIds
	 * @param comeType
	 * @return
	 */
	public Object queryCountDayComeShopCount(String dateMonth,String userIds,Integer comeType) {
		int total =0;
		String sql="SELECT count(*) as total FROM cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"	WHERE" +
				"	cust.dbid=custsr.customerId AND  custsr.comeType="+comeType+
				" AND DATE_FORMAT(cust.createFolderTime,'%Y-%m')='"+dateMonth +"'";
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
	 * 试乘试驾率统计
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param selSql
	 * @return
	 */
	public Integer[] queryTryCar(Date startDate,Date endDate,Integer userId,String selSql) {
		String sql="SELECT COUNT(*) as countNum FROM cust_customer AS cust,cust_customershoppingrecord csr  WHERE cust.dbid=csr.customerId ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(userId>0){
			sql=sql+" and  cust.bussiStaffId="+userId;
		}
		if(null!=selSql&&selSql.trim().length()>0){
			sql=sql+" and "+selSql+" ";
		}
		sql=sql+" GROUP BY csr.isTryDriver ";
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			int row = resultSet.getRow();
			Integer[] count=new Integer[row];
			resultSet.beforeFirst();
			int i=0;
			while (resultSet.next()) {
				count[i]=resultSet.getInt("countNum");
				i++;
			}
			createStatement.close();
			jdbcConnection.close();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 功能描述：统计试乘试驾数据
	 * 
	 */
	public Integer queryTryCarCount(Date startDate,Date endDate,Integer userId,String userIds) {
		Integer count=0;
		String sql="SELECT COUNT(*) as countNum FROM cust_customer AS cust,cust_customershoppingrecord csr  WHERE cust.dbid=csr.customerId ";
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(userId>0){
			sql=sql+" and  cust.bussiStaffId="+userId;
		}
		if(null!=userIds&&userIds.trim().length()>0){
			sql=sql+" and cust.bussiStaffId in ("+userIds+")";
		}
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				count=resultSet.getInt("countNum");
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return count;
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
}
