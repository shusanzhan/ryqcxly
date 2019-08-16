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

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CarSerCount;
import com.ystech.stat.customerrecord.model.SortByDateComparator;
import com.ystech.stat.customerrecord.model.SortByDbidComparator;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearChain;
import com.ystech.stat.customerrecord.model.StaCustomerRecordInfromYearByYearEffChain;
import com.ystech.stat.customerrecord.model.StatCustomerRecordTime;
import com.ystech.stat.customerrecord.model.StatCustomerRecordUser;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.stat.model.core.StaDateNum;
import com.ystech.stat.service.CustomerInfromStaSetManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("staCustomerInvationManageImpl")
public class StaCustomerInvationManageImpl {
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;
	@Resource
	public void setCustomerInfromStaSetManageImpl(
			CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl) {
		this.customerInfromStaSetManageImpl = customerInfromStaSetManageImpl;
	}
	/**
	 * 功能描述：通过日期（天/月）区间查询对应（天/月）网销潜客总数
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<StaDateNum> queryCustomerDateNums(String startDate,String endDate,Enterprise enterprise,int type,int dateType,String customerInfromIds){
		List<StaDateNum> staCustomerRecordDateNums=new ArrayList<StaDateNum>();
		String sql="SELECT"
				+ "	DATE_FORMAT(cust.createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate"
				+ ",COUNT(*) AS totalNum "
				+ "FROM"
				+ "	cust_customer cust,sta_customerinfromstaset cis "
				+ "WHERE"
				+ "	cust.enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" and cust.customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cust.createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cust.createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(null!=customerInfromIds){
			sql=sql+" AND cust.customerInfromId IN("+customerInfromIds+") ";
		}
		sql=sql	+ "	GROUP BY DATE_FORMAT(cust.createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")";
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
	 * 功能描述：查询每（天/月）个网销平台潜客数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public Map<StaDateNum,List<CustomerInfromStaSet>> queryCustomerInfromStaSetCustomerByDate(List<StaDateNum> staDateNums,Enterprise enterprise,int type,int dateType){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,"
				+ "		COUNT(*) AS totalNum "
				+ "		FROM cust_customer "
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+"  AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE'";
				sql=sql+ "		GROUP BY customerInfromId"
				+ "		)B "
				+ "ON cis.customerInfromId=B.customerInfromId where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CustomerInfromStaSet>> map=new HashMap<StaDateNum, List<CustomerInfromStaSet>>(staDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staDateNums) {
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
	 * 功能描述：通过日期（天/月）区间查询对应（天/月）网销邀约潜客总数
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<StaDateNum> queryCustomerInvitationDateNums(String startDate,String endDate,Enterprise enterprise,int type,int dateType,String customerInfromIds){
		List<StaDateNum> staCustomerRecordDateNums=new ArrayList<StaDateNum>();
		String sql="SELECT"
				+ "	DATE_FORMAT(cust.comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+") AS createDate"
				+ ",COUNT(*) AS totalNum "
				+ "FROM"
				+ "	cust_customer cust,sta_customerinfromstaset cis "
				+ "WHERE"
				+ "	cust.enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" and cust.customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cust.comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(cust.comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		if(null!=customerInfromIds){
			sql=sql+" AND cust.customerInfromId IN("+customerInfromIds+") ";
		}
		sql=sql	+ "	GROUP BY DATE_FORMAT(cust.comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")";
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
	 * 功能描述：查询每（天/月）个网销平台潜客邀约到店数据数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public Map<StaDateNum,List<CustomerInfromStaSet>> queryCustomerInfromStaSetCustomerInvitationByDate(List<StaDateNum> staCustomerRecordDateNums,Enterprise enterprise,int type,int dateType){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,"
				+ "		COUNT(*) AS totalNum "
				+ "		FROM cust_customer "
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+"  AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE'";
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
	 * 功能描述：查询（天/月）网销平台潜客到店总数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetCustomerInvitationByDateToatal(String startDate,String endDate,Enterprise enterprise,int type,int dateType){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,COUNT(customerInfromId) AS totalNum"
				+ "		FROM cust_customer "
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type;
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
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
	 * 功能描述：查询（天/月）网销平台潜客总数据
	 * @param staCustomerRecordDateNums
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetCustomerByDateToatal(String startDate,String endDate,Enterprise enterprise,int type,int dateType){
		String sql="SELECT"
				+ " cis.*,IFNULL(SUM(B.totalNum),0) as totalNum  "
				+ "FROM sta_customerinfromstaset cis "
				+ "LEFT JOIN"
				+ "("
				+ "		SELECT  customerInfromId,COUNT(customerInfromId) AS totalNum"
				+ "		FROM cust_customer "
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type;
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
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
	 * 功能描述：获取当月到店潜客数和邀约到店数据
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetCustomerInvitationSummary(String startDate,String endDate,Enterprise enterprise,int dateType,int type){
		List<CustomerInfromStaSet> customerInfromStaSets=new ArrayList<CustomerInfromStaSet>();
		 String sql="SELECT"
				+ " cis.*,"
				+ " IFNULL(SUM(B.totalNum),0) AS totalNum,"
				+ "	IFNULL(SUM(B.effTotalNum),0) AS effTotalNum,"
				+ " IFNULL(SUM(B.effTotalNum)/SUM(B.totalNum),0)*100 AS effPer "
				+ "	FROM"
				+ " sta_customerinfromstaset cis LEFT JOIN"
				+ "	("
				+ "		SELECT"
				+ "		customerInfromId,"
				+ "		COUNT(*) AS totalNum,"
				+ "		COUNT(IF(comeShopStatus>=2,TRUE,NULL)) AS effTotalNum "
				+ "		FROM cust_customer"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
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
	 * 功能描述：获取各网销邀约到店关注车型
	 * @param customerInfromStaSets
	 * @param type
	 * @return
	 */
	public Map<CustomerInfromStaSet,List<CarSerCount>> queryCustomerInfromStaSetCarSeriy(List<CustomerInfromStaSet> customerInfromStaSets,String startDate,String endDate,int type,Enterprise enterprise,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId	AND enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId IN(CUSTOMERINFROMIDS) AND customerTypeId="+type+" AND comeShopStatus>=2 ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
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
	 * 功能描述：获取当月网销邀约到店看车车型-总数据
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public List<CarSerCount> findCustomerRecordCarSeriyTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT carseriy.dbid AS serid,carseriy.`name` AS serName,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy carseriy LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE 1=1 AND cust.dbid=cb.customerId AND comeShopStatus>=2  ";
			if(type>0){
				sql=sql+ " AND customerTypeId="+type;
			}
			if(null!=enterprise){
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
			}
			if(null!=customerInfromIds){
				sql=sql+" AND customerInfromId IN("+customerInfromIds+") ";
			}
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
			}
			sql=sql	+ "	GROUP BY carSeriyId "
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
	 * 功能描述：获取网销邀约到店看车车型-总数据
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public List<CarSerCount> findCarSeriyInvitationSummaryAllTotal(String startDate,String endDate,int type,Enterprise enterprise,int dateType,String customerInfromIds){
		String sql="SELECT carseriy.dbid AS serid,carseriy.`name` AS serName,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy carseriy LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE 1=1 AND cust.dbid=cb.customerId AND comeShopStatus>=2  ";
		if(type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=customerInfromIds){
			sql=sql+" AND customerInfromId IN("+customerInfromIds+") ";
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql	+ "	GROUP BY carSeriyId "
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
	 * 功能描述：总网销线索邀约到店统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param dateType
	 * @return
	 */
	public List<CustomerInfromStaSet> queryCustomerInfromStaSetCustomerInvitationSummaryAll(String startDate,String endDate,Enterprise enterprise,int dateType,int type){
		List<CustomerInfromStaSet> customerInfromStaSets=new ArrayList<CustomerInfromStaSet>();
		 String sql="SELECT"
				+ " cis.*,"
				+ " IFNULL(SUM(A.totalNum+C.totalNum),0) AS totalNum,"
				+ " IFNULL(SUM(A.totalNum),0) AS addNum,"
				+ "	IFNULL(SUM(C.totalNum),0) AS keepNum,"
				+ "	IFNULL(SUM(B.totalNum),0) AS effTotalNum,"
				+ " IFNULL(SUM(B.totalNum)/SUM(A.totalNum+C.totalNum),0)*100 AS effPer "
				+ "	FROM"
				+ " sta_customerinfromstaset cis LEFT JOIN"
				+ "	("
				+ "		SELECT"
				+ "		customerInfromId,"
				+ "		COUNT(customerInfromId) AS totalNum"
				+ "		FROM cust_customer"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" AND customerTypeId="+type+"  ";
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
			}
			sql=sql	+ " GROUP BY customerInfromId "
				+ ")A ON cis.customerInfromId=A.customerInfromId "
				+ " LEFT JOIN "
				+ "("
				+ "SELECT "
				+ "customerInfromId,COUNT(customerInfromId) AS totalNum "
				+ "FROM "
				+ "cust_customer "
				+ " WHERE "
				+ " enterpriseId="+enterprise.getDbid()+" and customerTypeId="+type+" AND comeShopStatus>=2 ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql		+ "		GROUP BY customerInfromId"
				+ "		)B"
				+ " ON cis.customerInfromId=B.customerInfromId";
		Date dateMonth = DateUtil.stringDatePatten(startDate,"yyyy-MM");
		String dateMonthStr = DateUtil.formatPatten(dateMonth, "yyyy-MM");
	    sql=sql+"	LEFT JOIN("
	    		+ "			SELECT"
	    		+ "				customerInfromId,"
	    		+ "				COUNT(customerInfromId) AS totalNum"
	    		+ "				FROM"
	    		+ "				cust_customer cust,sta_customercopy scust"
	    		+ "				WHERE"
	    		+ "    cust.enterpriseId="+enterprise.getDbid()+" AND	 customerTypeId=3 AND DATE_FORMAT(scust.createDate,'%Y-%m')>='"+dateMonthStr+"' AND scust.customerId=cust.dbid"
	    		+ "				GROUP BY customerInfromId"
	    		+ "		)C		ON cis.customerInfromId=C.customerInfromId";
	    sql=sql	+ " where cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1 GROUP BY codeNum";
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
	 * 功能描述：获取各网销邀约到店关注车型
	 * @param customerInfromStaSets
	 * @param type
	 * @return
	 */
	public Map<CustomerInfromStaSet,List<CarSerCount>> queryCustomerInfromStaSetCarSeriyInvitationAll(List<CustomerInfromStaSet> customerInfromStaSets,String startDate,String endDate,int type,Enterprise enterprise,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId	AND enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId IN(CUSTOMERINFROMIDS) AND customerTypeId="+type+" AND comeShopStatus>=2 ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
			
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
	 * 功能描述：当月线索到店客户关注车型
	 * @param staCustomerRecordDateNums
	 * @param type
	 * @return
	 */
	public Map<StaDateNum,List<CarSerCount>> findCustomerInvitationCarSeriy(List<StaDateNum> staCustomerRecordDateNums,int type,Enterprise enterprise,int dateType,String customerInfromIds,int selectType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		cb.carSeriyId,COUNT(cb.carSeriyId) AS totalNum FROM cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ "	 cust.dbid=cb.customerId AND enterpriseId="+enterprise.getDbid()+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")='QUERYDATE' AND customerTypeId="+type+" ";
			if(null!=customerInfromIds){
				sql=sql+" AND customerInfromId IN("+customerInfromIds+") ";
			}
			if(selectType==1){
				StaDateNum staDateNum = staCustomerRecordDateNums.get(0);
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+staDateNum.getCreateDate()+"' ";
				StaDateNum staDateNum2 = staCustomerRecordDateNums.get((staCustomerRecordDateNums.size()-1));
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+staDateNum2.getCreateDate()+"' ";
						
			}
			sql=sql	+ "	GROUP BY cb.carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StaDateNum,List<CarSerCount>> map=new HashMap<StaDateNum, List<CarSerCount>>(staCustomerRecordDateNums.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StaDateNum staCustomerRecordDateNum : staCustomerRecordDateNums) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String date = DateUtil.formatPatten(staCustomerRecordDateNum.getCreateDate(),dateType==1?"yyyy-MM-dd":"yyyy-MM");
				String querySql=sql.replace("QUERYDATE",date);
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(staCustomerRecordDateNum, customerRecordTargets);
			}
			Map<StaDateNum,List<CarSerCount>> sortMap =new TreeMap<StaDateNum, List<CarSerCount>>(new SortByDateComparator());
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
	 * 功能描述：获取当月潜客网销邀约客户到店数统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<StatCustomerRecordUser> findCustomerRecordUser(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType,int userBussiType){
		String sql="SELECT "
				+ "us.dbid,us.realName,IFNULL(B.totalNum,0) AS totalNum,"
				+ "IFNULL(B.creatorFolderNum,0) AS  creatorFolderNum,"
				+ "B.creatorFolderNum/B.totalNum*100 AS creatorFolderPer "
				+ "FROM "
				+ "sys_user us LEFT JOIN("
				+ "	SELECT	invitationSalerId,"
				+ "	COUNT(IF(customerTypeId="+type+",TRUE,NULL)) AS totalNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&comeShopStatus>=2,TRUE,NULL)) AS creatorFolderNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 ";
				if(type!=null&&type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY invitationSalerId"
				+ ")B ON us.dbid=B.invitationSalerId "
				+ "WHERE us.bussiType="+userBussiType+" AND us.userState=1";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
			try {
				Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
				Statement createStatement = jdbcConnection.createStatement();
				ResultSet resultSet = createStatement.executeQuery(sql);
				statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			 	createStatement.close();
				jdbcConnection.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return statCustomerRecordUsers;	
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public Map<StatCustomerRecordUser,List<CarSerCount>> findCustomerRecordCarSeriyByUserId(List<StatCustomerRecordUser> statCustomerRecordUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND	invitationSalerId=USERID AND comeShopStatus>=2 ";
				if(type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StatCustomerRecordUser,List<CarSerCount>> map=new HashMap<StatCustomerRecordUser, List<CarSerCount>>(statCustomerRecordUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StatCustomerRecordUser user : statCustomerRecordUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<StatCustomerRecordUser,List<CarSerCount>> sortMap =new TreeMap<StatCustomerRecordUser, List<CarSerCount>>(new SortByDbidComparator());
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
	 * 功能描述：获取展厅销售顾问接待线索以及建档客户
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public StatCustomerRecordUser findCustomerRecordUserTotal(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="Select"
				+ " IFNULL(B.totalNum,0) AS totalNum,"
				+ " IFNULL(B.creatorFolderNum,0) AS creatorFolderNum,"
				+ " IFNULL(B.creatorFolderNum/B.totalNum,0) AS creatorFolderPer"
				+ "  from "
				+ "(SELECT	"
				+ "	COUNT(IF(customerTypeId="+type+",TRUE,NULL)) AS totalNum,"
				+ "	COUNT(IF(customerTypeId="+type+"&&comeShopStatus>=2,TRUE,NULL)) AS creatorFolderNum"
				+ "	FROM"
				+ "	cust_customer"
				+ "	WHERE"
				+ "	1=1 ";
				if(type!=null&&type>0){
					sql=sql+ " AND customerTypeId="+type;
				}
				if(null!=enterprise){
					sql=sql+" AND enterpriseId="+enterprise.getDbid();
				}
				if(null!=startDate&&startDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
				}
				if(null!=endDate&&endDate.trim().length()>0){
					sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
				}
				sql=sql+")B";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if (!statCustomerRecordUsers.isEmpty()) {
			return statCustomerRecordUsers.get(0);
		}
		return null;	
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数统计
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public List<StatCustomerRecordUser> findCustomerRecordUserAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType,int userBussiType){
		String sql="SELECT "
				+ "us.dbid,us.realName,"
				+ " IFNULL((A.totalNum+C.totalNum),0) AS totalNum,"
				+ " IFNULL(A.totalNum,0) AS addNum,"
				+ "	IFNULL(C.totalNum,0) AS keepNum,"
				+ "IFNULL(B.creatorFolderNum,0) AS  creatorFolderNum,"
				+ " B.creatorFolderNum/(A.totalNum+C.totalNum)*100 AS creatorFolderPer "
				+ "FROM "
				+ "sys_user us LEFT JOIN"
				+ "	("
				+ "		SELECT"
				+ "		invitationSalerId,"
				+ "		COUNT(invitationSalerId) AS totalNum"
				+ "		FROM cust_customer"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" AND customerTypeId="+type+" ";
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql		+ " GROUP BY invitationSalerId "
				+ ")A ON us.dbid=A.invitationSalerId"
				+ " LEFT JOIN "
				+ "("
				+ "	SELECT	invitationSalerId,"
				+ "	COUNT(IF(customerTypeId="+type+",TRUE,NULL)) AS creatorFolderNum"
				+ "	FROM"
				+ "	cust_customer "
				+ "	WHERE comeShopStatus>=2 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ "	GROUP BY invitationSalerId "
				+ ")B ON us.dbid=B.invitationSalerId ";
		Date dateMonth = DateUtil.stringDatePatten(startDate,"yyyy-MM");
		String dateMonthStr = DateUtil.formatPatten(dateMonth, "yyyy-MM");
	    sql=sql+"	LEFT JOIN("
	    		+ "			SELECT"
	    		+ "				invitationSalerId,"
	    		+ "				COUNT(invitationSalerId) AS totalNum"
	    		+ "				FROM"
	    		+ "				cust_customer cust,sta_customercopy scust"
	    		+ "				WHERE"
	    		+ "		cust.enterpriseId="+enterprise.getDbid()+" AND customerTypeId=3 AND DATE_FORMAT(scust.createDate,'%Y-%m')>='"+dateMonthStr+"' AND scust.customerId=cust.dbid"
	    		+ "				GROUP BY invitationSalerId "
	    		+ "		)C	ON us.dbid=C.invitationSalerId";
		sql=sql	+ " WHERE us.bussiType="+userBussiType+" AND us.userState=1";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return statCustomerRecordUsers;	
	}
	/**
	 * 功能描述：获取总网销邀约到店客户汇总
	 * @param startDate
	 * @param endDate
	 * @param enterprise
	 * @param type
	 * @return
	 */
	public StatCustomerRecordUser findCustomerRecordUserTotalAll(String startDate,String endDate,Enterprise enterprise,Integer type,int dateType){
		String sql="SELECT "
				+ " IFNULL((A.totalNum+C.totalNum),0) AS totalNum,"
				+ " IFNULL(A.totalNum,0) AS addNum,"
				+ "	IFNULL(C.totalNum,0) AS keepNum,"
				+ "IFNULL(B.creatorFolderNum,0) AS  creatorFolderNum,"
				+ " B.creatorFolderNum/(A.totalNum+C.totalNum)*100 AS creatorFolderPer "
				+ "FROM "
				+ "	("
				+ "		SELECT"
				+ "		COUNT(invitationSalerId) AS totalNum"
				+ "		FROM cust_customer"
				+ "		WHERE"
				+ "		enterpriseId="+enterprise.getDbid()+" AND customerTypeId="+type+" ";
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(createFolderTime,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
			}
			sql=sql	+ ")A "
				+ " , "
				+ "("
				+ "	SELECT	"
				+ "	COUNT(IF(customerTypeId="+type+",TRUE,NULL)) AS creatorFolderNum"
				+ "	FROM"
				+ "	cust_customer "
				+ "	WHERE comeShopStatus>=2 ";
		if(type!=null&&type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ ")B,";
		Date dateMonth = DateUtil.stringDatePatten(startDate,"yyyy-MM");
		String dateMonthStr = DateUtil.formatPatten(dateMonth, "yyyy-MM");
	    sql=sql+"("
	    		+ "			SELECT"
	    		+ "				COUNT(invitationSalerId) AS totalNum"
	    		+ "				FROM"
	    		+ "				cust_customer cust,sta_customercopy scust"
	    		+ "				WHERE"
	    		+ "		cust.enterpriseId="+enterprise.getDbid()+" AND customerTypeId=3 AND DATE_FORMAT(scust.createDate,'%Y-%m')>='"+dateMonthStr+"' AND scust.customerId=cust.dbid";
	    if(null!=enterprise){
			sql=sql+" AND cust.enterpriseId="+enterprise.getDbid();
		}
	    sql=sql+ "		)C";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		List<StatCustomerRecordUser> statCustomerRecordUsers=new ArrayList<StatCustomerRecordUser>();
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			statCustomerRecordUsers = ResultSetUtil.getDateResult(statCustomerRecordUsers, resultSet, StatCustomerRecordUser.class);
			createStatement.close();
			jdbcConnection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		if (!statCustomerRecordUsers.isEmpty()) {
			return statCustomerRecordUsers.get(0);
		}
		return null;	
	}
	/**
	 * 功能描述：获取当月潜客网销邀约客户到店数-关注车型统计
	 * @param type
	 * @return
	 */
	public Map<StatCustomerRecordUser,List<CarSerCount>> findCustomerRecordCarSeriyByUserIdAll(List<StatCustomerRecordUser> statCustomerRecordUsers,int type,Enterprise enterprise,String startDate,String endDate,int dateType){
		String sql="SELECT cs.`name` AS serName,cs.dbid AS serid,IFNULL(B.totalNum,0) AS countNum "
				+ "FROM set_carseriy cs LEFT JOIN ("
				+ "	SELECT "
				+ "		carSeriyId,COUNT(carSeriyId) AS totalNum "
				+ "	FROM"
				+ " cust_customer cust,cust_customerbussi cb "
				+ " WHERE"
				+ " cust.dbid=cb.customerId AND	invitationSalerId=USERID AND comeShopStatus>=2 ";
		if(type>0){
			sql=sql+ " AND customerTypeId="+type;
		}
		if(null!=enterprise){
			sql=sql+" AND enterpriseId="+enterprise.getDbid();
		}
		if(null!=startDate&&startDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")>='"+startDate+"' ";
		}
		if(null!=endDate&&endDate.trim().length()>0){
			sql=sql+" AND DATE_FORMAT(comeShopDate,"+(dateType==1?"'%Y-%m-%d'":"'%Y-%m'")+")<='"+endDate+"' ";
		}
		sql=sql+ "	GROUP BY carSeriyId "
				+ ")B "
				+ "	ON cs.dbid=B.carSeriyId "
				+ "WHERE cs.`status`=1 AND enterpriseId="+enterprise.getDbid() ;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Map<StatCustomerRecordUser,List<CarSerCount>> map=new HashMap<StatCustomerRecordUser, List<CarSerCount>>(statCustomerRecordUsers.size());
		try {
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			for (StatCustomerRecordUser user : statCustomerRecordUsers) {
				List<CarSerCount> customerRecordTargets=new ArrayList<CarSerCount>();
				String querySql=sql.replace("USERID",user.getDbid()+"");
				ResultSet resultSet = createStatement.executeQuery(querySql);
				customerRecordTargets = ResultSetUtil.getDateResult(customerRecordTargets, resultSet, CarSerCount.class);
				map.put(user, customerRecordTargets);
			}
			Map<StatCustomerRecordUser,List<CarSerCount>> sortMap =new TreeMap<StatCustomerRecordUser, List<CarSerCount>>(new SortByDbidComparator());
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
	
	public List<StaCustomerRecordInfromYearByYearChain> queryCustomerComeShopInfromYearByYearChain(Date startDate, int type, Enterprise enterprise, int dateType,int coplexDateType,int comeShopStatus) {
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
				+ "		cust.customerInfromId,"
				+ "		COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "		COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "		COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum"
				+ "		FROM"
				+ "		cust_customer cust,sta_customerinfromstaset cis"
				+ "		WHERE"
				+ "		cust.enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" AND staStatus=1";
		if(type>0){
			sql=sql+" and cust.customerTypeId="+type;
		}
		if(comeShopStatus>0){
			if(comeShopStatus>=2){
				sql=sql+" and cust.comeShopStatus>="+comeShopStatus;	
			}
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
	public List<StaCustomerRecordInfromYearByYearEffChain> queryCustomerRecordInfromYearByYearEffChain(	Date startDate, int type, Enterprise enterprise, int dateType,int coplexDateType) {
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
				+ "cust.customerInfromId,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"',TRUE,NULL)) AS nowNum,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+nowDate+"'&&comeShopStatus>=2,TRUE,NULL)) AS efftNum,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"',TRUE,NULL)) AS preNum,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+preDate+"'&&comeShopStatus>=2,TRUE,NULL)) AS preEfftNum,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"',TRUE,NULL)) AS yearByYearNum,"
				+ "COUNT(IF(DATE_FORMAT("+(coplexDateType==1?"cust.createFolderTime":"cust.comeShopDate")+","+(dateType==1?"'%Y-%m'":"'%Y'")+")='"+yearByYearDate+"'&&comeShopStatus>=2,TRUE,NULL)) AS yearByYearEfftNum "
				+ "FROM "
				+ "cust_customer cust,sta_customerinfromstaset cis "
				+ "		WHERE"
				+ "		cust.enterpriseId="+enterprise.getDbid()+" AND cust.customerInfromId=cis.customerInfromId AND cis.enterpriseId="+enterprise.getDbid()+" ";
		if(type>0){
			sql=sql+" and cust.customerTypeId="+type;
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
}
