/**
 * 
 */
package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CarseriyItemTypeCount;
import com.ystech.cust.model.CityCrossCustomerCount;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.DateNum;
import com.ystech.cust.model.DayComeShop;
import com.ystech.cust.model.HasCar;
import com.ystech.cust.model.HasNoCarOrder;
import com.ystech.cust.model.InfoFromTotal;

/**
 * @author shusanzhan
 * @date 2014-5-15
 */
@Component("statisticalManageImpl")
public class StatisticalManageImpl {
	/**
	 * 功能描述：统计餐桌的翻台率
	 * @param date
	 * @return
	 */
	public List<CarseriyItemTypeCount> queryCountDeskDay(Integer comeType,Date startDate,Date endDate,String departmentIds) {
		List<CarseriyItemTypeCount> lastCarseriyItemTypeCounts = new ArrayList<CarseriyItemTypeCount>();
		List<CarseriyItemTypeCount> statisticalDesks = new ArrayList<CarseriyItemTypeCount>();
		String sql = "";
		sql=sql+"SELECT "
			+" cars.itemType AS itemType, count(cars.itemType)  AS countNum "
		    +" FROM  "
		    +" cust_customer AS cust,set_carseriy as cars,cust_customerbussi AS custb,cust_customershoppingrecord AS custsr "
		    +" WHERE " 
		    +" custb.customerId=cust.dbid "
		    +" AND "
		    +" custb.carSeriyId=cars.dbid  "
		    +" AND "
		    +" custsr.customerId=cust.dbid "
		    +" AND " +
		    " custsr.comeType="+comeType;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=endDate){
			sql=sql+" and  cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
		}
		sql=sql+" GROUP BY cars.itemType ORDER BY itemType";
		
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				Integer itemType = resultSet.getInt("itemType");
				Integer countNum = resultSet.getInt("countNum");
				CarseriyItemTypeCount statisticalDesk = new CarseriyItemTypeCount(itemType,countNum);
				statisticalDesks.add(statisticalDesk);
			}
			//当获取的数据小于4条数据时，那么肯定有一个数据类型为空
			for (int i = 1; i < 5; i++) {
				CarseriyItemTypeCount statisticalDesk =null;
				boolean state=false;
				for (CarseriyItemTypeCount carseriyItemTypeCount : statisticalDesks) {
					if(carseriyItemTypeCount.getItemType()==i){
						statisticalDesk =carseriyItemTypeCount;
						state=true;
						break;
					}
				}
				if(state==false){
					statisticalDesk = new CarseriyItemTypeCount(i,0);
				}
				lastCarseriyItemTypeCounts.add(statisticalDesk);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return lastCarseriyItemTypeCounts;
	}
	
	public List<CarSerCount> queryCountCar(Date startDate,Date endDate,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 渠道统计
	 * @param startDate
	 * @param endDate
	 * @param departmentIds
	 * @return
	 */
	public List<InfoFromTotal> queryCountInfo(Date startDate,Date endDate,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 功能描述：统计同城交叉客户
	 * @param startDate
	 * @param endDate
	 * @param departmentIds
	 * @return
	 */
	public List<CityCrossCustomerCount> queryCityCrossCustomerCounts(Date startDate,Date endDate,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	public Integer queryCityCrossCustomerCount(Date startDate,Date endDate,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 获取意向车型客户
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	public Integer queryCountCarTotal(Date startDate,Date endDate,String departmentIds){
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 查询渠道分析总数
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	public Integer queryCountInfoTotal(Date startDate,Date endDate,String departmentIds){
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 功能描述：获取车型 的主力车型
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public Map<Integer,Integer> queryCarseryNum() throws Exception {
		String sql="SELECT  itemType ,COUNT(itemType) AS countNum FROM set_carseriy GROUP BY itemType ";
		Map<Integer,Integer> map=new HashMap<Integer, Integer>();
		DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
		Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
		Statement createStatement = jdbcConnection.createStatement();
		ResultSet resultSet = createStatement.executeQuery(sql);
		resultSet.last();
		resultSet.beforeFirst();
		while (resultSet.next()) {
			Integer itemType = resultSet.getInt("itemType");
			Integer countNum = resultSet.getInt("countNum");
			map.put(itemType,countNum);
		}
		return map;
	}
	/**
	 * 进店来店数据统计
	 * @param startDate
	 * @param endDate
	 * @param departmentId
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public List<DayComeShop> queryCountDayComeShop(Date startDate,Date endDate1,String departmentIds,Integer comeType) {
		List<DayComeShop> resultDayComeShops=new ArrayList<DayComeShop>();
		List<DayComeShop> dayComeShops=new ArrayList<DayComeShop>();
		int month = startDate.getMonth();
		String monString="";
		if(month<10){
			monString="0"+(month+1);
		}
		String sql = "";
		sql=sql+" SELECT a.oneDay AS oneDay,a.countNum AS countNum,ROUND(a.countNum/b.countNum*100,2) AS per  FROM " +
				" (SELECT" +
				"	DATE_FORMAT(cust.createFolderTime,'%e') as oneDay,COUNT(*) AS countNum " +
				"   FROM" +
				"	cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"   where " +
				"   cust.dbid=custsr.customerId AND DATE_FORMAT(cust.createFolderTime,'%m')='"+monString+"' AND custsr.comeType= "+comeType;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
		}
		sql=sql+"   group by oneDay )a," +
				" ( " +
				"	SELECT	COUNT(*) AS countNum " +
				"   FROM " +
				"   cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"   where" +
				"   cust.dbid=custsr.customerId AND DATE_FORMAT(cust.createFolderTime,'%m')='"+monString+"' AND custsr.comeType="+comeType;
		if(null!=startDate){
			sql=sql+" AND cust.createFolderTime>='"+DateUtil.format(startDate) +"'";
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	
	public Object queryCountDayComeShopCount(Date startDate,Date endDate,String departmentIds,Integer comeType) {
		int total =0;
		String sql="SELECT count(*) as total FROM cust_customer AS cust,cust_customershoppingrecord AS custsr " +
				"	WHERE" +
				"	cust.dbid=custsr.customerId AND  custsr.comeType="+comeType+
				" AND cust.createFolderTime>='"+DateUtil.format(startDate)+"'" +
				"   AND cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
		}
		System.err.println(sql);
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
	public Object queryCountLevelCount(Date startDate,Date endDate,String departmentIds,Integer customerPhaseId) {
		int total =0;
		String sql="SELECT  COUNT(*) AS total " +
				" FROM cust_customer AS cust,cust_customerphase AS custph" +
				" WHERE cust.customerPhaseId=custph.dbid " +
				" and cust.customerPhaseId="+customerPhaseId+
				" AND cust.createFolderTime>='"+DateUtil.format(startDate)+"'" +
				" AND cust.createFolderTime<'"+DateUtil.format(endDate)+"'";
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
		}
		System.err.println(sql);
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
	 * @param departmentId
	 * @param customerPhaseId
	 * @return
	 */
	public List<DayComeShop> queryLevlelDayComeShop(Date startDate,Date endDate,String departmentIds,Integer customerPhaseId) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
		}
		sql=sql+"GROUP BY oneDay order BY oneDay";
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
				DayComeShop dayComeShop=new DayComeShop();
				dayComeShop.setCountNum(countNum);
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
	 * 获取会员拥有车辆类型情况
	 * @return
	 */
	public  List<HasCar> countHashCar() {
		List<HasCar> hasCars=new ArrayList<HasCar>();
		String sql="SELECT hascar as hasCarType, COUNT(*) AS countNum FROM mem_member GROUP BY hasCar ";
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				Integer hasCarType = resultSet.getInt("hasCarType");
				Integer countNum = resultSet.getInt("countNum");
				HasCar hasCar=new HasCar();
				hasCar.setCountNum(countNum);
				hasCar.setHasCarType(hasCarType);
				hasCars.add(hasCar);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return hasCars;
	}
	/**
	 * 功能描述：无车订单
	 * @return
	 */
	public List<HasNoCarOrder> queryHasNoCarOrders(Integer enterpriseId){
		String sql="SELECT " +
				"	carseriy.`name` AS carSeriyName,carmodel.`name` AS carModelName,carcolor.name AS color,COUNT(carModelid)AS countNum  " +
				" FROM	cust_customerpidbookingrecord AS custpid,set_carseriy AS carseriy,set_carmodel AS carmodel,set_carcolor AS carcolor,cust_customer cust" +
				" WHERE" +
				"	custpid.carSeriyId=carseriy.dbid AND custpid.carModelid=carmodel.dbid AND custpid.carColorId=carcolor.dbid and cust.dbid=custpid.customerId " +
				" ANd hasCarOrder="+CustomerPidBookingRecord.HASCARORDERNO+" and cust.enterpriseId="+enterpriseId+" and custpid.pidStatus>=1 and custpid.wlStatus=2 and custpid.pidStatus!=2" +
				"   GROUP BY carSeriyId,carModelid,custpid.carColorId ORDER BY carSeriyId ";
		List<HasNoCarOrder> carOrders=new ArrayList<HasNoCarOrder>();
		System.out.println(sql);
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				String carSeriyName = resultSet.getString("carSeriyName");
				String carModelName = resultSet.getString("carModelName");
				Integer countNum = resultSet.getInt("countNum");
				String color = resultSet.getString("color");
				HasNoCarOrder hasNocar=new HasNoCarOrder();
				hasNocar.setCountNum(countNum);
				hasNocar.setCarModelName(carModelName);
				hasNocar.setCarSeriyName(carSeriyName);
				hasNocar.setColor(color);
				carOrders.add(hasNocar);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return carOrders;
	}
	/**
	 * 试乘试驾率统计
	 * @param startDate
	 * @param endDate
	 * @param userId
	 * @param departmentIds
	 * @return
	 */
	public Integer[] queryTryCar(Date startDate,Date endDate,Integer userId,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	 * 
	 */
	public Integer queryTryCarCount(Date startDate,Date endDate,Integer userId,String departmentIds) {
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
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and cust.departmentId in ("+departmentIds+")";
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
	/***
	 * 统计库存
	 * @param startDate
	 * @param endDate
	 * @param departmentIds
	 * @return
	 */
	public List<CarSerCount> querStatic(String sql) {
		List<CarSerCount> carSerCounts=new ArrayList<CarSerCount>();
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
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String querySql(CarSerCount carSerCount) throws Exception {
		try {
			System.out.println(carSerCount.getSerid());
			String sql="SELECT cs.dbid,cs.`name`,COUNT(cs.dbid) AS carSTotal "+
					"FROM "+
					"set_carseriy cs,s_factoryorder sf "+ 
					"WHERE cs.dbid=sf.carSeriyId AND sf.carStatus!=3 AND sf.storeAgeLevelId="+carSerCount.getSerid()+
					" GROUP BY cs.dbid,sf.storeAgeLevelId";
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			StringBuffer buffer=new StringBuffer();
			resultSet.last();
			resultSet.beforeFirst();
			int j=0;
			int rowCount=0;
			while (resultSet.next()) {
				if(j==0){
					buffer.append("<tr>");
					buffer.append("<td align='center' rowspan='"+rowCount+"'>"+carSerCount.getSerName()+"</td>");
					buffer.append("<td align='center' rowspan='"+rowCount+"'>"+carSerCount.getCountNum()+"</td>");
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
					buffer.append("<td align='center'>"+resultSet.getString("carSTotal")+"</td>");
					buffer.append("</tr>");
				}else{
					buffer.append("<tr>");
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
					buffer.append("<td align='center'>"+resultSet.getString("carSTotal")+"</td>");
					buffer.append("</tr>");
				}
				j++;
			}
			createStatement.close();
			jdbcConnection.close();
			return buffer.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 查询最近一周的集客记录
	 * @return
	 */
	public List<DateNum> queryCustomerWeek(String sql){
		List<DateNum> dateNums=new ArrayList<DateNum>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				DateNum dateNum=new DateNum();
				String date = resultSet.getString("createFolderTime");
				int totalNum = resultSet.getInt("totalNum");
				dateNum.setDate(date);
				dateNum.setTotalNum(totalNum);
				dateNums.add(dateNum);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return dateNums;
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
