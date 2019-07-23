package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.cust.model.SalerProfit;

@Component("salerProfitManageImpl")
public class SalerProfitManageImpl {
	/**
	 * 分公司毛利
	 * @param enterprseId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> queryEnterpriseSaler(Integer enterprseId,String beginDate,String endDate,String saler,Integer brandId,Integer carseriyId,String depId){
		List params=new ArrayList();
		String sql="SELECT"
				+ " cust.dbid AS customerId ,cust.`name`,cust.mobilePhone,dep.`name` AS depName,cust.bussiStaff,"
				+ "br.`name` AS brandName,cs.`name` AS csName,cm.`name` AS cmName,cl.`name` AS carColorName,"
				+ "oce.totalPrice,IFNULL(oce.carSalerPrice,0) AS carSalerPrice,"
				+ "IFNULL(oce.carGrofitPrice,0) AS carGrofitPrice,"
				+ "IFNULL(oce.ajsxf,0) AS ajsxf,IFNULL(oce.advanceTotalPrice,0) AS advanceTotalPrice,"
				+ "IFNULL(oce.decoreGrofitPrice,0) AS decoreGrofitPrice,IFNULL(oce.ajsxfGrofit,oce.ajsxf) AS ajsxfGrofit,"
				+ "IFNULL(oce.insMoneyGrofit ,0) AS insMoneyGrofit,"
				+ "(IFNULL(oce.carGrofitPrice,0)+IFNULL(oce.decoreGrofitPrice,0)+IFNULL(oce.ajsxfGrofit,IFNULL(oce.ajsxf,0))+IFNULL(oce.insMoneyGrofit,0)) AS profitMoney   "
				+ " FROM"
				+ " cust_customer cust,cust_ordercontract oc,cust_ordercontractexpenses oce ,"
				+ "sys_department dep,cust_customerpidbookingrecord cpid,set_brand br,set_carseriy cs,set_carmodel cm,set_carcolor cl"
				+ " WHERE"
				+ "	cust.dbid=oc.customerId AND cust.dbid=oce.customerId AND cust.departmentId=dep.dbid AND cpid.customerId=cust.dbid  "
				+ " AND cpid.brandId=br.dbid AND cs.dbid=cpid.carSeriyId AND cm.dbid=cpid.carModelid AND cl.dbid=cpid.carColorId "	
				+" AND cpid.modifyTime>='"+beginDate+"' AND cpid.modifyTime<'"+endDate+"'  and cust.enterpriseId="+enterprseId+" AND cpid.pidStatus=2 ";
		if(null!=saler&&saler.trim().length()>0){
			sql=sql+" AND cust.bussiStaff like  '%"+saler+"%' ";
		}
		if(null!=brandId&&brandId>0){
			sql=sql+" AND cpid.brandId="+brandId;
		}
		if(null!=carseriyId&&carseriyId>0){
			sql=sql+" AND cpid.carSeriyId="+carseriyId;
		}
		if(null!=depId&&depId.trim().length()>0){
			sql=sql+" and cust.departmentId in("+depId+")";
		}
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("customerId");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("name");
				salerProfit.setName(name);
				String mobilePhone = resultSet.getString("mobilePhone");
				salerProfit.setMobilePhone(mobilePhone);
				String depName = resultSet.getString("depName");
				salerProfit.setDepName(depName);
				String bussiStaff = resultSet.getString("bussiStaff");
				salerProfit.setBussiStaff(bussiStaff);
				String brandName = resultSet.getString("brandName");
				salerProfit.setBrandName(brandName);
				String csName = resultSet.getString("csName");
				salerProfit.setCsName(csName);
				String cmName = resultSet.getString("cmName");
				salerProfit.setCmName(cmName);
				String carColorName = resultSet.getString("carColorName");
				salerProfit.setCarColorName(carColorName);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float ajsxf = resultSet.getFloat("ajsxf");
				salerProfit.setAjsxf(ajsxf);
				Float carGrofitPrice = resultSet.getFloat("carGrofitPrice");
				salerProfit.setCarGrofitPrice(carGrofitPrice);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float decoreGrofitPrice = resultSet.getFloat("decoreGrofitPrice");
				salerProfit.setDecoreGrofitPrice(decoreGrofitPrice);
				Float ajsxfGrofit = resultSet.getFloat("ajsxfGrofit");
				salerProfit.setAjsxfGrofit(ajsxfGrofit);
				Float insSalerPrice = resultSet.getFloat("insMoneyGrofit");
				salerProfit.setInsSalerPrice(insSalerPrice);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 我的毛利统计
	 * @param userId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> queryMySaler(Integer userId,String beginDate,String endDate){
		String sql="SELECT M.customerId,M.`name`,M.mobilePhone,M.depName,M.bussiStaff,M.brandName,M.csName,M.cmName,M.carColorName," +
				"	M.totalPrice,M.carSalerPrice,M.ajsxf,M.advanceTotalPrice,M.salerTotalPrice,M.salerPrice,IFNULL(N.salerBasePrice,0) AS insSalerPrice," +
				"   (M.prof+IFNULL(N.salerBasePrice,0)) AS profitMoney " +
				"   FROM" +
				"(	" +
				"	SELECT A.customerId,A.`name`,A.mobilePhone,A.depName,A.bussiStaff,A.brandName,A.csName,A.cmName,A.carColorName," +
				"		A.totalPrice,A.carSalerPrice,A.ajsxf,A.advanceTotalPrice,A.salerTotalPrice,IFNULL(B.salerPrice,0) AS salerPrice," +
				"	    (A.totalPrice-A.carSalerPrice-A.advanceTotalPrice-A.salerTotalPrice-A.ajsxf+IFNULL(B.salerPrice,0)) AS prof" +
				"		FROM " +
				"			(SELECT " +
				"					cust.dbid AS customerId ,cust.`name`,cust.mobilePhone,dep.`name` AS depName,cust.bussiStaff," +
				"					br.`name` AS brandName,cs.`name` AS csName,cm.`name` AS cmName,cl.`name` AS carColorName," +
				"					oce.totalPrice,oce.carSalerPrice,oce.ajsxf,oce.advanceTotalPrice,IFNULL(ocd.salerTotalPrice,0) AS salerTotalPrice" +
				"					FROM 	" +
				"					cust_customer cust,cust_ordercontract oc,cust_ordercontractexpenses oce ,cust_ordercontractdecore ocd,sys_department dep,cust_customerpidbookingrecord cpid,set_brand br,set_carseriy cs,set_carmodel cm,set_carcolor cl" +
				"					WHERE " +
				"					cust.dbid=oc.customerId AND cust.dbid=oce.customerId AND cust.departmentId=dep.dbid AND cpid.customerId=cust.dbid AND ocd.customerId=cust.dbid" +
				"					AND cpid.brandId=br.dbid AND cs.dbid=cpid.carSeriyId AND cm.dbid=cpid.carModelid AND cl.dbid=cpid.carColorId " +
				"					AND cpid.modifyTime>='"+beginDate+"' AND cpid.modifyTime<'"+endDate+"' and cust.bussiStaffId="+userId+" AND cpid.pidStatus=2" +
				"			)A" +
				"	LEFT JOIN" +
				"			(" +
				"			SELECT " +
				"					fcust.customerId AS customerId,fcl.salerPrice  AS salerPrice  " +
				"					FROM " +
				"					fin_fincustomer fcust,fin_fincustomerloan fcl WHERE fcust.dbid=fcl.customerId " +
				"		)B" +
				"	ON" +
				"	A.customerId=B.customerId " +
				")M " +
				"LEFT JOIN  " +
				"		(" +
				"		SELECT " +
				"		cpid.customerId,ic.salerBasePrice " +
				"		FROM " +
				"	ins_insurancerecord ic,ins_customer icust,cust_customerpidbookingrecord cpid,cust_customer cust" +
				"	WHERE " +
				"	cpid.customerId=icust.customerId  AND ic.customerId=icust.dbid AND cpid.customerId=cust.dbid " +
				"	and cpid.pidStatus=2 AND cpid.modifyTime>='"+beginDate+"' AND cpid.modifyTime<'"+endDate+"' AND cust.bussiStaffId="+userId +
				")N " +
				"ON M.customerId=N.customerId";
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("customerId");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("name");
				salerProfit.setName(name);
				String mobilePhone = resultSet.getString("mobilePhone");
				salerProfit.setMobilePhone(mobilePhone);
				String depName = resultSet.getString("depName");
				salerProfit.setDepName(depName);
				String bussiStaff = resultSet.getString("bussiStaff");
				salerProfit.setBussiStaff(bussiStaff);
				String brandName = resultSet.getString("brandName");
				salerProfit.setBrandName(brandName);
				String csName = resultSet.getString("csName");
				salerProfit.setCsName(csName);
				String cmName = resultSet.getString("cmName");
				salerProfit.setCmName(cmName);
				String carColorName = resultSet.getString("carColorName");
				salerProfit.setCarColorName(carColorName);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float ajsxf = resultSet.getFloat("ajsxf");
				salerProfit.setAjsxf(ajsxf);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float salerTotalPrice = resultSet.getFloat("salerTotalPrice");
				salerProfit.setDecoreGrofitPrice(salerTotalPrice);
				Float salerPrice = resultSet.getFloat("salerPrice");
				salerProfit.setSalerPrice(salerPrice);
				Float insSalerPrice = resultSet.getFloat("insSalerPrice");
				salerProfit.setInsSalerPrice(insSalerPrice);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 领导统计数据
	 * @param userId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> queryEnterPriseProfit(String custSql){
		String sql="SELECT "
				+ "ent.dbid,ent.`name`,COUNT(ent.dbid) AS num,SUM(R.totalPrice) AS totalPrice ," +
				"SUM(R.carSalerPrice) AS carSalerPrice,SUM(R.advanceTotalPrice) AS advanceTotalPrice," +
				"SUM(R.decoreGrofitPrice) AS decoreGrofitPrice,SUM(R.ajsxfGrofit) AS ajsxfGrofit," +
				"SUM(R.insMoneyGrofit) AS insMoneyGrofit,SUM(R.profitMoney) AS profitMoney " +
				" FROM " +
				"sys_enterprise ent," +
				"(SELECT" +
				"	cust.dbid AS customerId,cust.enterpriseId,"
				+ "oce.totalPrice,oce.carSalerPrice,"
				+ " oce.advanceTotalPrice,IFNULL(oce.decoreGrofitPrice,0) AS decoreGrofitPrice,"
				+ "IFNULL(oce.ajsxfGrofit,oce.ajsxf) AS ajsxfGrofit,oce.preInsMoney,IFNULL(oce.insMoneyGrofit,0) AS insMoneyGrofit,"
				+ "(IFNULL(oce.carGrofitPrice,0)+IFNULL(oce.decoreGrofitPrice,0)+IFNULL(oce.ajsxfGrofit,IFNULL(oce.ajsxf,0))+IFNULL(oce.insMoneyGrofit,0)) AS profitMoney  " +
				"	FROM" +
				"	cust_customer cust,cust_ordercontractexpenses oce ,cust_ordercontractdecore ocd,cust_customerpidbookingrecord cpid " +
				"	WHERE" +
				"	cust.dbid=oce.customerId AND cpid.customerId=cust.dbid AND ocd.customerId=cust.dbid " +
				"	   AND cpid.pidStatus=2 " +custSql+
				")R " +
				"WHERE " +
				"ent.dbid=R.enterpriseId " +
				"GROUP BY " +
				"R.enterpriseId";
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("dbid");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("name");
				salerProfit.setName(name);
				int num = resultSet.getInt("num");
				salerProfit.setNum(num);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float decoreGrofitPrice = resultSet.getFloat("decoreGrofitPrice");
				salerProfit.setDecoreGrofitPrice(decoreGrofitPrice);
				Float ajsxfGrofit = resultSet.getFloat("ajsxfGrofit");
				salerProfit.setAjsxfGrofit(ajsxfGrofit);
				Float insMoneyGrofit = resultSet.getFloat("insMoneyGrofit");
				salerProfit.setInsSalerPrice(insMoneyGrofit);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 领导统计数据:部门明细
	 * @param userId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> queryDepProfit(String custSql){
		String sql="SELECT " +
				"ent.dbid,ent.`name`,COUNT(ent.dbid) AS num,SUM(R.totalPrice) AS totalPrice ," +
				"SUM(R.carSalerPrice) AS carSalerPrice,SUM(R.advanceTotalPrice) AS advanceTotalPrice," +
				"SUM(R.decoreGrofitPrice) AS decoreGrofitPrice,SUM(R.ajsxfGrofit) AS ajsxfGrofit," +
				"SUM(R.insMoneyGrofit) AS insMoneyGrofit,SUM(R.profitMoney) AS profitMoney " +
				" FROM " +
				"sys_department ent," +
				"(SELECT" +
				"	cust.dbid AS customerId,cust.departmentId,"
				+ " oce.totalPrice,oce.carSalerPrice,"
				+ " oce.advanceTotalPrice,IFNULL(oce.decoreGrofitPrice,0) AS decoreGrofitPrice,"
				+ "IFNULL(oce.ajsxfGrofit,oce.ajsxf) AS ajsxfGrofit,oce.preInsMoney,IFNULL(oce.insMoneyGrofit,0) AS insMoneyGrofit,"
				+ "(IFNULL(oce.carGrofitPrice,0)+IFNULL(oce.decoreGrofitPrice,0)+IFNULL(oce.ajsxfGrofit,IFNULL(oce.ajsxf,0))+IFNULL(oce.insMoneyGrofit,0)) AS profitMoney  " +
				"	FROM" +
				"	cust_customer cust,cust_ordercontractexpenses oce ,cust_ordercontractdecore ocd,cust_customerpidbookingrecord cpid " +
				"	WHERE" +
				"	 cust.dbid=oce.customerId AND cpid.customerId=cust.dbid AND ocd.customerId=cust.dbid " +
				"	   AND cpid.pidStatus=2 " +custSql+
				")R " +
				" WHERE " +
				"ent.dbid=R.departmentId " +
				"GROUP BY " +
				"R.departmentId";
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("dbid");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("name");
				salerProfit.setName(name);
				int num = resultSet.getInt("num");
				salerProfit.setNum(num);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float decoreGrofitPrice = resultSet.getFloat("decoreGrofitPrice");
				salerProfit.setDecoreGrofitPrice(decoreGrofitPrice);
				Float ajsxfGrofit = resultSet.getFloat("ajsxfGrofit");
				salerProfit.setAjsxfGrofit(ajsxfGrofit);
				Float insMoneyGrofit = resultSet.getFloat("insMoneyGrofit");
				salerProfit.setInsSalerPrice(insMoneyGrofit);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 领导统计数据:销售顾问明细
	 * @param userId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> querySalerProfit(String finSql,String custSql){
		String sql="SELECT us.dbid,us.realName,COUNT(us.dbid) AS num," +
				"SUM(R.totalPrice) AS totalPrice ," +
				"SUM(R.carSalerPrice) AS carSalerPrice,SUM(R.advanceTotalPrice) AS advanceTotalPrice," +
				"SUM(R.decoreGrofitPrice) AS decoreGrofitPrice,SUM(R.ajsxfGrofit) AS ajsxfGrofit," +
				"SUM(R.insMoneyGrofit) AS insMoneyGrofit,SUM(R.profitMoney) AS profitMoney " +
				" FROM " +
				"sys_user us," +
				"(SELECT" +
				"	cust.dbid AS customerId,cust.bussiStaffId,"
				+ " oce.totalPrice,oce.carSalerPrice,"
				+ " oce.advanceTotalPrice,IFNULL(oce.decoreGrofitPrice,0) AS decoreGrofitPrice,"
				+ "IFNULL(oce.ajsxfGrofit,oce.ajsxf) AS ajsxfGrofit,oce.preInsMoney,IFNULL(oce.insMoneyGrofit,0) AS insMoneyGrofit,"
				+ "(IFNULL(oce.carGrofitPrice,0)+IFNULL(oce.decoreGrofitPrice,0)+IFNULL(oce.ajsxfGrofit,IFNULL(oce.ajsxf,0))+IFNULL(oce.insMoneyGrofit,0)) AS profitMoney  " +
				"	FROM" +
				"	cust_customer cust,cust_ordercontractexpenses oce ,cust_ordercontractdecore ocd,cust_customerpidbookingrecord cpid" +
				"	WHERE" +
				"	 cust.dbid=oce.customerId AND cpid.customerId=cust.dbid AND ocd.customerId=cust.dbid " +
				"	   AND cpid.pidStatus=2 " +custSql+
				")R " +
				"WHERE " +
				"us.dbid=R.bussiStaffId " +
				"GROUP BY " +
				"R.bussiStaffId order by SUM(R.profitMoney) DESC";
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("dbid");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("realName");
				salerProfit.setName(name);
				int num = resultSet.getInt("num");
				salerProfit.setNum(num);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float decoreGrofitPrice = resultSet.getFloat("decoreGrofitPrice");
				salerProfit.setDecoreGrofitPrice(decoreGrofitPrice);
				Float ajsxfGrofit = resultSet.getFloat("ajsxfGrofit");
				salerProfit.setAjsxfGrofit(ajsxfGrofit);
				Float insMoneyGrofit = resultSet.getFloat("insMoneyGrofit");
				salerProfit.setInsSalerPrice(insMoneyGrofit);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 领导统计数据:销售顾问明细
	 * @param userId
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public List<SalerProfit> queryCarSeriyProfit(String finSql,String custSql){
		String sql="SELECT cs.dbid,cs.name,COUNT(cs.dbid) AS num," +
				"SUM(R.totalPrice) AS totalPrice ," +
				"SUM(R.carSalerPrice) AS carSalerPrice,SUM(R.advanceTotalPrice) AS advanceTotalPrice," +
				"SUM(R.decoreGrofitPrice) AS decoreGrofitPrice,SUM(R.ajsxfGrofit) AS ajsxfGrofit," +
				"SUM(R.insMoneyGrofit) AS insMoneyGrofit,SUM(R.profitMoney) AS profitMoney " +
				" FROM " +
				"set_carseriy cs," +
				"(SELECT" +
				"	cust.dbid AS customerId,cpid.carSeriyId,"
				+ " oce.totalPrice,oce.carSalerPrice,"
				+ " oce.advanceTotalPrice,IFNULL(oce.decoreGrofitPrice,0) AS decoreGrofitPrice,"
				+ "IFNULL(oce.ajsxfGrofit,oce.ajsxf) AS ajsxfGrofit,oce.preInsMoney,IFNULL(oce.insMoneyGrofit,0) AS insMoneyGrofit,"
				+ "(IFNULL(oce.carGrofitPrice,0)+IFNULL(oce.decoreGrofitPrice,0)+IFNULL(oce.ajsxfGrofit,IFNULL(oce.ajsxf,0))+IFNULL(oce.insMoneyGrofit,0)) AS profitMoney  " +
				"	FROM" +
				"	cust_customer cust,cust_ordercontractexpenses oce ,cust_ordercontractdecore ocd,cust_customerpidbookingrecord cpid" +
				"	WHERE" +
				"	 cust.dbid=oce.customerId AND cpid.customerId=cust.dbid AND ocd.customerId=cust.dbid " +
				"	   AND cpid.pidStatus=2 " +custSql+
				")R " +
				"WHERE " +
				"cs.dbid=R.carSeriyId " +
				"GROUP BY " +
				"R.carSeriyId order by SUM(R.profitMoney) DESC";
		try {
			List<SalerProfit> salerProfits=new ArrayList<SalerProfit>();
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			resultSet.last();
			resultSet.beforeFirst();
			while (resultSet.next()) {
				SalerProfit salerProfit = new SalerProfit();
				Integer customerId = resultSet.getInt("dbid");
				salerProfit.setCustomerId(customerId);
				String name = resultSet.getString("name");
				salerProfit.setName(name);
				int num = resultSet.getInt("num");
				salerProfit.setNum(num);
				Float totalPrice = resultSet.getFloat("totalPrice");
				salerProfit.setTotalPrice(totalPrice);
				Float carSalerPrice = resultSet.getFloat("carSalerPrice");
				salerProfit.setCarSalerPrice(carSalerPrice);
				Float advanceTotalPrice = resultSet.getFloat("advanceTotalPrice");
				salerProfit.setAdvanceTotalPrice(advanceTotalPrice);
				Float decoreGrofitPrice = resultSet.getFloat("decoreGrofitPrice");
				salerProfit.setDecoreGrofitPrice(decoreGrofitPrice);
				Float ajsxfGrofit = resultSet.getFloat("ajsxfGrofit");
				salerProfit.setAjsxfGrofit(ajsxfGrofit);
				Float insMoneyGrofit = resultSet.getFloat("insMoneyGrofit");
				salerProfit.setInsSalerPrice(insMoneyGrofit);
				Float profitMoney = resultSet.getFloat("profitMoney");
				salerProfit.setProfitMoney(profitMoney);
				salerProfits.add(salerProfit);
			}
			if(createStatement != null)createStatement.close();  
            if(jdbcConnection != null)jdbcConnection.close();  
			return salerProfits;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
