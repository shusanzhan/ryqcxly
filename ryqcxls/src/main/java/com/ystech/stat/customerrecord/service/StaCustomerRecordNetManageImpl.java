package com.ystech.stat.customerrecord.service;

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

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.SortByDbidComparator;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearChain;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearEffChain;
import com.ystech.stat.customerrecord.model.StatCustomerRecordTime;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.stat.service.CustomerInfromStaSetManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("staCustomerRecordNetManageImpl")
public class StaCustomerRecordNetManageImpl extends StaCustomerRecordDao{
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;
		
	@Resource
	public void setCustomerInfromStaSetManageImpl(
			CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl) {
		this.customerInfromStaSetManageImpl = customerInfromStaSetManageImpl;
	}

	/**
	 * 功能描述：通过日期（天/月）区间查询对应（天/月）公司的总数据
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<StaDateNum> queryStaCustomerRecordDateNums(String startDate,String endDate,Enterprise enterprise,int type,int dateType,int resultStatus,String customerInfromIds){
		List<StaDateNum> staCustomerRecordDateNums=new ArrayList<StaDateNum>();
		String sql="SELECT"
				+ "	DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate"
				+ ",COUNT(*) AS totalNum "
				+ "FROM"
				+ "	cust_customerrecord cr,sta_customerinfromstaset cis "
				+ "WHERE"
				+ "	cr.enterpriseId="+enterprise.getDbid()+" AND cr.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" and cr.customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(resultStatus==1){
			sql=sql+" AND cr.resultStatus<"+CustomerRecord.RESULTINVALIT +" and cr.resultStatus>"+CustomerRecord.RESULTCOMM;
		}else if(resultStatus==2){
			sql=sql+" AND cr.resultStatus="+CustomerRecord.RESULTINVALIT;
		}
		if(null!=customerInfromIds){
			sql=sql+" AND cr.customerInfromId IN("+customerInfromIds+") ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql	+ "	GROUP BY DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustomerRecordDateNums = ResultSetUtil.getDateResult(staCustomerRecordDateNums, resultSet, StaDateNum.class);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		sortResult(startDate, endDate, staCustomerRecordDateNums, dateType);
		return staCustomerRecordDateNums;
	}
	
	/**
	 * 功能描述：查询每（天/月）个网销平台数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public Map<StaDateNum,List<CustomerInfromStaSet>> queryCustomerInfromStaSetByDate(List<StaDateNum> staCustomerRecordDateNums,Enterprise enterprise,int type,int dateType,int resultStatus){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,"
				+ "		COUNT(*) AS totalNum "
				+ "		FROM cust_customerrecord"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+"  AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE'";
				if(resultStatus==1){
					sql=sql+" AND resultStatus<"+CustomerRecord.RESULTINVALIT +" and resultStatus>"+CustomerRecord.RESULTCOMM;
				}else if(resultStatus==2){
					sql=sql+" AND resultStatus="+CustomerRecord.RESULTINVALIT;
				}
				sql=sql+ "		GROUP BY customerInfromId"
				+ "		)B "
				+ "ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CustomerInfromStaSet>> map=new HashMap<StaDateNum, List<CustomerInfromStaSet>>(staCustomerRecordDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staCustomerRecordDateNums) {
				List<CustomerInfromStaSet> customerRecordTargets=new ArrayList<CustomerInfromStaSet>();
				String date = DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CustomerInfromStaSet.class);
				map.put(staCustomerRecordDateNum, customerRecordTargets);
			}
			 Map<StaDateNum,List<CustomerInfromStaSet>> sortMap =new TreeMap<StaDateNum, List<CustomerInfromStaSet>>(new SortByDateComparator());
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
	 * 功能描述：查询每（天/月）个网销平台数据有效率
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public Map<StaDateNum,List<CustomerInfromStaSet>> queryCustomerInfromStaSetEffByDate(List<StaDateNum> staCustomerRecordDateNums,Enterprise enterprise,int type,int dateType){
		String sql="SELECT"
				+ " cis.*,"
				+ "	IFNULL(SUM(B.effTotalNum),0) as totalNum,"
				+ " IFNULL(SUM(B.effTotalNum),0) AS effTotalNum,"
				+ " IFNULL(SUM(B.effTotalNum)/SUM(B.effTotalNum)*100,0) AS  effPer "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,"
				+ "		COUNT(customerInfromId) AS totalNum,"
				+ "		COUNT(IF(resultStatus=2,TRUE,NULL)) AS effTotalNum"
				+ "		FROM cust_customerrecord"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE'";
		sql=sql+ "		GROUP BY customerInfromId"
				+ "		)B "
				+ "ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CustomerInfromStaSet>> map=new HashMap<StaDateNum, List<CustomerInfromStaSet>>(staCustomerRecordDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staCustomerRecordDateNums) {
				List<CustomerInfromStaSet> customerRecordTargets=new ArrayList<CustomerInfromStaSet>();
				String date = DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CustomerInfromStaSet.class);
				map.put(staCustomerRecordDateNum, customerRecordTargets);
			}
			Map<StaDateNum,List<CustomerInfromStaSet>> sortMap =new TreeMap<StaDateNum, List<CustomerInfromStaSet>>(new SortByDateComparator());
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
	 * 功能描述：查询（天/月）网销平台数据总数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetByDateToatal(String startDate,String endDate,Enterprise enterprise,int type,int dateType,int resultStatus){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,COUNT(customerInfromId) AS totalNum"
				+ "		FROM cust_customerrecord"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type;
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(resultStatus==1){
			sql=sql+" AND resultStatus<"+CustomerRecord.RESULTINVALIT +" and resultStatus>"+CustomerRecord.RESULTCOMM;
		}else if(resultStatus==2){
			sql=sql+" AND resultStatus="+CustomerRecord.RESULTINVALIT;
		}
				sql=sql+ "		GROUP BY customerInfromId"
				+ "		)B "
				+ "ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<CustomerInfromStaSet> customerRecordTargets=new ArrayList<CustomerInfromStaSet>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CustomerInfromStaSet.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return customerRecordTargets;
	}
	/**
	 * 功能描述：获取各平台线索汇总数据
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetSummary(String startDate,String endDate,Enterprise enterprise,int dateType,int type){
		List<CustomerInfromStaSet> customerInfromStaSets=new ArrayList<CustomerInfromStaSet>();
		 String sql="SELECT"
				+ " cis.*,SUM(B.totalNum) AS totalNum,"
				+ "	SUM(B.effTotalNum) AS effTotalNum,"
				+ "	SUM(B.invTotalNum) AS invTotalNum,"
				+ " IFNULL(SUM(B.effTotalNum)/SUM(B.totalNum),0)*100 AS effPer "
				+ "	FROM"
				+ " sta_customerinfromstaset cis LEFT JOIN"
				+ "	("
				+ "		SELECT"
				+ "		customerInfromId,"
				+ "		COUNT(*) AS totalNum,"
				+ "		COUNT(IF(resultStatus>1&&resultStatus<4,TRUE,NULL)) AS effTotalNum,"
				+ "		COUNT(IF(resultStatus=4,TRUE,NULL)) AS invTotalNum"
				+ "		FROM cust_customerrecord"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql		+ "		GROUP BY customerInfromId"
				+ "		)B"
				+ " ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			customerInfromStaSets=ResultSetUtil.getDateResult(customerInfromStaSets, resultSet, CustomerInfromStaSet.class);
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return customerInfromStaSets;
	}
	/**
	 * 功能描述：获取各网销平台线下关注车型
	 * @param customerInfromStaSets
	 * @param type
	 * @return
	 */
	public Map<CustomerInfromStaSet,List<CarSerCount>> queryCustomerInfromStaSetCarSeriy(List<CustomerInfromStaSet> customerInfromStaSets,String startDate,String endDate,int type,Enterprise enterprise,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customerrecord "
				+ " WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" AND customerInfromId IN(CUSTOMERINFROMIDS) and customerTypeId="+type+" AND `status`=1 AND resultStatus=2";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
			sql=sql	+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<CustomerInfromStaSet,List<CarSerCount>> map=new HashMap<CustomerInfromStaSet, List<CarSerCount>>(customerInfromStaSets.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String customerInfromIds = customerInfromStaSetManageImpl.findCustomerInfromIdsByCodeNum(enterprise.getDbid(), customerInfromStaSet.getCodeNum());
				String querySql=sql.replace("CUSTOMERINFROMIDS",customerInfromIds);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(customerInfromStaSet, customerRecordTargets);
			}
			 Map<CustomerInfromStaSet,List<CarSerCount>> sortMap =new TreeMap<CustomerInfromStaSet, List<CarSerCount>>(new SortByDbidComparator());
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
				if(type==1){
					sql=sql+" AND recordType=1 ";
				}
			}
			if(null!=enterprise){
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
			}
			if(null!=customerInfromIds){
				sql=sql+" AND customerInfromId IN("+customerInfromIds+") ";
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
	 * 功能描述：获取网线线索同比环比
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param resultStatus
	 * @return
	 */
	public List<StaCustomerRecordInfromYearByYearChain> queryCustomerRecordInfromYearByYearChain(Date startDate,int type,Enterprise enterprise,int dateType,int resultStatus){
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
				+ "	cis.dbid,cis.alias,"
				+ "		IFNULL(SUM(B.nowNum),0) as nowNum,"
				+ "		IFNULL(SUM(B.preNum),0) as preNum,"
				+ "		IFNULL(SUM(B.yearByYearNum),0) as yearByYearNum,"
				+ "		IFNULL((SUM(B.nowNum)-SUM(B.preNum))/SUM(B.preNum),0)*100 AS chainPer,"
				+ "		IFNULL((SUM(B.nowNum)-SUM(B.yearByYearNum))/SUM(B.yearByYearNum),0)*100 AS yreaByYearPer"
				+ "		FROM"
				+ "		sta_customerinfromstaset cis"
				+ "		LEFT JOIN"
				+ "		("
				+ "		SELECT"
				+ "		cr.customerInfromId,"
				+ "		COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "		COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "		COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "		cust_customerrecord cr,sta_customerinfromstaset cis"
				+ "		WHERE"
				+ "		cr.enterpriseId="+enterprise.getDbid()+" AND cr.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1";
		if(type>0){
			sql=sql+" and cr.customerTypeId="+type;
		}
		if(resultStatus>0){
			sql=sql+" and cr.resultStatus="+resultStatus;
		}
		sql=sql+ "	GROUP BY cis.customerInfromId"
					+ "		)B"
					+ "		ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaCustomerRecordInfromYearByYearChain> staCustomerRecordInfromYearByYearChains=new ArrayList<StaCustomerRecordInfromYearByYearChain>();
		try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				staCustomerRecordInfromYearByYearChains = ResultSetUtil.getDateResult(staCustomerRecordInfromYearByYearChains, resultSet, StaCustomerRecordInfromYearByYearChain.class);
				for (StaCustomerRecordInfromYearByYearChain staCustomerRecordInfromYearByYearChain : staCustomerRecordInfromYearByYearChains) {
					staCustomerRecordInfromYearByYearChain.setNowDate(nowDate);
					staCustomerRecordInfromYearByYearChain.setPreDate(preDate);
					staCustomerRecordInfromYearByYearChain.setYearByYearDate(yearByYearDate);
				}
				resultSet.close();
				createStatement.close();
				jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return staCustomerRecordInfromYearByYearChains;
	}
	
	/**
	 * 功能描述：获取网线线索有效率同比/环比
	 * @param startDate
	 * @param type
	 * @param enterprise
	 * @param dateType
	 * @param resultStatus
	 * @return
	 */
	public List<StaCustomerRecordInfromYearByYearEffChain> queryCustomerRecordInfromYearByYearEffChain(Date startDate,int type,Enterprise enterprise,int dateType){
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
		String sql="SELECT "
				+ "cis.dbid,cis.alias AS name, "
				+ "IFNULL(SUM(B.nowNum),0) as nowNum,"
				+ "IFNULL(SUM(B.efftNum)/SUM(B.nowNum),0)*100 AS nowEffPer,"
				+ "IFNULL(SUM(B.preNum),0) as preNum,"
				+ "IFNULL(SUM(B.preEfftNum)/SUM(B.preNum),0)*100 AS preEffPer,"
				+ "IFNULL(SUM(B.yearByYearNum),0) as yearByYearNum,"
				+ "IFNULL(SUM(B.yearByYearEfftNum)/SUM(B.yearByYearNum),0)*100 AS yearByYearEffPer "
				+ "FROM "
				+ "sta_customerinfromstaset cis "
				+ "LEFT JOIN ( "
				+ "SELECT "
				+ "cr.customerInfromId,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"'&&resultStatus=2,TRUE,NULL)) AS efftNum,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"'&&resultStatus=2,TRUE,NULL)) AS preEfftNum,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum,"
				+ "COUNT(IF(DATE_FORMAT(cr.createDate,"+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"'&&resultStatus=2,TRUE,NULL)) AS yearByYearEfftNum "
				+ "FROM "
				+ "cust_customerrecord cr,sta_customerinfromstaset cis "
				+ "		WHERE"
				+ "		cr.enterpriseId="+enterprise.getDbid()+" AND cr.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1";
		if(type>0){
			sql=sql+" and cr.customerTypeId="+type;
		}
		sql=sql+ "	GROUP BY cis.customerInfromId"
				+ "		)B"
				+ "		ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StaCustomerRecordInfromYearByYearEffChain> staCustomerRecordInfromYearByYearChains=new ArrayList<StaCustomerRecordInfromYearByYearEffChain>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustomerRecordInfromYearByYearChains = ResultSetUtil.getDateResult(staCustomerRecordInfromYearByYearChains, resultSet, StaCustomerRecordInfromYearByYearEffChain.class);
			for (StaCustomerRecordInfromYearByYearEffChain staCustomerRecordInfromYearByYearChain : staCustomerRecordInfromYearByYearChains) {
				staCustomerRecordInfromYearByYearChain.setNowDate(nowDate);
				staCustomerRecordInfromYearByYearChain.setPreDate(preDate);
				staCustomerRecordInfromYearByYearChain.setYearByYearDate(yearByYearDate);
			}
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return staCustomerRecordInfromYearByYearChains;
	}
	
	 /**
	 * 功能描述：无数据日期自动设置为零，并对最终结果按日期从新排序
	 * @param startDate
	 * @param endDate
	 * @param staCustomerRecordDateNums
	 */
	private void sortResult(String startDate, String endDate,List<StaDateNum> staCustomerRecordDateNums,int dateType) {
		if(dateType==1){
			Date beginDate = DateUtil.string2Date(startDate);
			Date eDate = DateUtil.string2Date(endDate);
			int towIntervalDays = DateUtil.getTowIntervalDays(beginDate, eDate)+1;
			int size=staCustomerRecordDateNums.size();
			if(towIntervalDays!=size&&size<towIntervalDays){
				for (int i = 0; i <towIntervalDays; i++) {
					Date date = DateUtil.addDay(beginDate, i);
					boolean status=false;
					for (StaDateNum statCustomerRecordTime : staCustomerRecordDateNums) {
						if(statCustomerRecordTime.getCreateDate().compareTo(date)==0){
							status=true;
							break;
						}
					}
					if(status==false){
						StatCustomerRecordTime statCustomerRecordTime = new StatCustomerRecordTime(date);
						staCustomerRecordDateNums.add(statCustomerRecordTime);
					}
				}
			}
			Collections.sort(staCustomerRecordDateNums,new SortByDateComparator());
		}
		if(dateType==2){
			Date beginDate = DateUtil.stringDatePatten(startDate,"yyyy-MM");
			Date eDate = DateUtil.stringDatePatten(endDate,"yyyy-MM");
			int towIntervalMonth = DateUtil.getIntervalMonths(beginDate, eDate);
			int size=staCustomerRecordDateNums.size();
			if(towIntervalMonth!=size&&size<towIntervalMonth){
				for (int i = 0; i <towIntervalMonth; i++) {
					Date date = DateUtil.addMonth(beginDate, i);
					String temp = DateUtil.formatPatten(date, "yyyy-MM");
					boolean status=false;
					for (StaDateNum statCustomerRecordTime : staCustomerRecordDateNums) {
						String hasTemp = DateUtil.formatPatten(statCustomerRecordTime.getCreateDate(), "yyyy-MM");
						if(hasTemp.equals(temp)){
							status=true;
							break;
						}
					}
					if(status==false){
						StatCustomerRecordTime statCustomerRecordTime = new StatCustomerRecordTime(date);
						staCustomerRecordDateNums.add(statCustomerRecordTime);
					}
				}
			}
			Collections.sort(staCustomerRecordDateNums,new SortByDateComparator());
		}
	}
}
