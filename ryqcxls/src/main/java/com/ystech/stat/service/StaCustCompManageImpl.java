package com.ystech.stat.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.dao.ResultSetUtil;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.stat.model.StaCustComp;

@Component("staCustCompManageImpl")
public class StaCustCompManageImpl extends HibernateEntityDao<StaCustComp>{

	@SuppressWarnings("deprecation")
	public List<StaCustComp> queryEntStaCustComp(String tartDate,String endDate){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String querySql="";
		if(null!=tartDate){
			querySql=querySql+" AND cust.createFolderTime>='"+tartDate+"' ";
		}
		if(null!=endDate){
			querySql=querySql+" AND cust.createFolderTime<'"+endDate+"' ";
		}
		Calendar instance = Calendar.getInstance();
		int month = instance.get(Calendar.MONTH);
		if(null!=endDate){
			Date date = DateUtil.string2Date(endDate);
			 month= date.getMonth();
		}
		instance.set(Calendar.MONTH, month-1);
		Date time = instance.getTime();
		String format = DateUtil.format(time);
		String sql="SELECT "
				+ "A.entId,A.entName,"
				+ "A.recordNum,A.recordMonthNum,A.recordOverplusNum,(A.recordMonthNum-A.flowMonthNum) AS recordMonthAddNum,"
				+ "A.flowNum,A.flowNum/A.recordNum AS flowMonthPer,A.flowMonthNum,A.flowMonthNum/A.recordMonthNum AS flowMonthPer,"
				+ "A.comeShopNum,A.comeShopNum/A.recordNum AS comeShopPer,A.comeShopMonthNum,A.comeShopMonthNum/A.recordNum AS comeShopMonthPer,"
				+ "A.comeShopSucessNum,A.comeShopSucessNum/A.comeShopNum AS comeShopSucessPer,A.comeShopMonthSuccessNum,"
				+ "A.comeShopMonthSuccessNum/A.comeShopMonthNum AS comeShopMonthSuccessPer,"
				+ "A.twoTimesComeShopNum,A.twoTimesComeShopNum/A.comeShopNum AS twoTimesComeShopPer,A.twoTimesComeShopMonthNum,"
				+ "A.twoTimesComeShopMonthNum/A.comeShopMonthNum AS twoTimesComeShopMonthPer,"
				+ "A.twoTimesComeShopSucessNum,A.twoTimesComeShopSucessNum/A.twoTimesComeShopNum AS twoTimesComeShopSucessPer,"
				+ "A.twoTimesComeShopMonthSucessNum,A.twoTimesComeShopMonthSucessNum/A.twoTimesComeShopMonthNum AS twoTimesComeShopMonthSucessPer,"
				+ "A.tryCarNum,A.tryCarNum/A.comeShopNum AS tryCarPer,A.tryCarMonthNum,A.tryCarMonthNum/A.comeShopMonthNum AS tryCarMonthPer,"
				+ "A.tryCarSuccessNum,A.tryCarSuccessNum/A.tryCarNum AS tryCarSucessPer,A.tryCarMonthSuccessNum,"
				+ "A.tryCarMonthSuccessNum/A.tryCarMonthNum AS tryCarMonthSuccessPer,"
				+ "A.customerSuccessNum,A.customerSuccessNum/A.recordNum AS customerSuccessPer,A.customerMonthSuccessNum,"
				+ "A.customerMonthSuccessNum/A.recordMonthNum AS customerMonthSuccessPer,B.trackNum,B.trackNum/A.recordNum AS trackAva,"
				+ "B.trackOverTimeNum,B.trackOverTimeNum/B.trackNum AS trackOverTimePer,B.trackMonthNum,B.trackMonthOverTimeNum,"
				+ "B.trackMonthOverTimeNum/B.trackMonthNum AS trackMonthOverTimePer "
				+ "FROM ("
				+ "	SELECT	"
				+ " ent.dbid as entId,"
				+ "	ent.name as entName,"
				+ "	COUNT(ent.dbid) AS recordNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.createFolderTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS recordMonthNum,"
				+ "	COUNT(IF(cust.lastResult=0,TRUE,NULL)) AS recordOverplusNum,"
				+ "	COUNT(IF(cust.lastResult>1&&custcl.approvalStatus=1,TRUE,NULL)) AS flowNum,"
				+ "	COUNT(IF(DATE_FORMAT(custcl.approvalDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.lastResult>1,TRUE,NULL)) as flowMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1,TRUE,NULL)) AS comeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.comeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1,TRUE,NULL)) AS comeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopMonthSuccessNum,"
				+ "	COUNT(IF(cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.twoComeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopMonthSucessNum,"
				+ "	COUNT(IF(cpid.pidStatus=2,TRUE,NULL)) AS customerSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2,TRUE,NULL)) AS customerMonthSuccessNum,"
				+ "	COUNT(if(custsh.isTryDriver=1,TRUE,NULL)) AS tryCarNum,"
				+ "	COUNT(if(DATE_FORMAT(cust.tryCarDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthNum,"
				+ "	COUNT(if(custsh.isTryDriver=1&&cpid.pidStatus=2,TRUE,NULL)) AS tryCarSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthSuccessNum"
				+ "	FROM"
				+ "	sys_enterprise ent,cust_customer cust"
				+ "	LEFT JOIN"
				+ "	cust_customerlastbussi custcl"
				+ "	ON"
				+ "	cust.dbid= custcl.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customerpidbookingrecord cpid"
				+ "	ON  cust.dbid=cpid.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customershoppingrecord custsh"
				+ "	ON cust.dbid=custsh.customerId"
				+ "	WHERE"
				+ "	ent.dbid=cust.enterpriseId AND cust.recordType=1"
				+ "	GROUP BY ent.dbid"
				+ "	ORDER BY COUNT(ent.dbid) DESC"
				+ ") A "
				+ "LEFT JOIN"
				+ "("
				+ "	SELECT cust.enterpriseId,"
				+ "	COUNT(*) trackNum,"
				+ "	COUNT(IF(track.taskOverTimeStatus=2,true,NULL)) AS trackOverTimeNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS trackMonthNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&track.taskOverTimeStatus=2,TRUE,NULL)) AS trackMonthOverTimeNum"
				+ "	FROM"
				+ "	cust_customer cust LEFT JOIN cust_customertrack track ON cust.dbid=track.customerId"
				+ "	WHERE"
				+ "	cust.recordType=1 AND taskDealStatus>1"
				+ "	GROUP BY cust.enterpriseId"
				+ ")B "
				+ "ON A.entId=B.enterpriseId ";
			DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
			Connection jdbcConnection;
			try {
					jdbcConnection = databaseUnitHelper.getJdbcConnection();
					Statement createStatement = jdbcConnection.createStatement();
					ResultSet resultSet = createStatement.executeQuery(sql);
					staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
					resultSet.close();
					createStatement.close();
					jdbcConnection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return staCustComps;
		}
	/**
	 * 查询分公司部门数据
	 * @param entId
	 * @return
	 */
	public List<StaCustComp> queryDepStaCustComp(Integer entId,String tartDate,String endDate){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String select=" ";
		if(null!=tartDate){
			select=select+" AND cust.createFolderTime>='"+tartDate+"' ";
		}
		if(null!=endDate){
			select=select+" AND cust.createFolderTime<'"+endDate+"' ";
		}
		if(null!=entId&&entId>0){
			select=select+" AND cust.enterpriseId="+entId+" ";
		}
		Calendar instance = Calendar.getInstance();
		int month = instance.get(Calendar.MONTH);
		if(null!=endDate){
			Date date = DateUtil.string2Date(endDate);
			 month= date.getMonth();
		}
		instance.set(Calendar.MONTH, month-1);
		Date time = instance.getTime();
		String format = DateUtil.format(time);
		String sql="SELECT "
				+ "A.entId,"
				+ "A.depId,A.depName,"
				+ "A.recordNum,A.recordMonthNum,A.recordOverplusNum,(A.recordMonthNum-A.flowMonthNum) AS recordMonthAddNum,"
				+ "A.flowNum,A.flowNum/A.recordNum AS flowMonthPer,A.flowMonthNum,A.flowMonthNum/A.recordMonthNum AS flowMonthPer,"
				+ "A.comeShopNum,A.comeShopNum/A.recordNum AS comeShopPer,A.comeShopMonthNum,A.comeShopMonthNum/A.recordNum AS comeShopMonthPer,"
				+ "A.comeShopSucessNum,A.comeShopSucessNum/A.comeShopNum AS comeShopSucessPer,A.comeShopMonthSuccessNum,"
				+ "A.comeShopMonthSuccessNum/A.comeShopMonthNum AS comeShopMonthSuccessPer,"
				+ "A.twoTimesComeShopNum,A.twoTimesComeShopNum/A.comeShopNum AS twoTimesComeShopPer,A.twoTimesComeShopMonthNum,"
				+ "A.twoTimesComeShopMonthNum/A.comeShopMonthNum AS twoTimesComeShopMonthPer,"
				+ "A.twoTimesComeShopSucessNum,A.twoTimesComeShopSucessNum/A.twoTimesComeShopNum AS twoTimesComeShopSucessPer,"
				+ "A.twoTimesComeShopMonthSucessNum,A.twoTimesComeShopMonthSucessNum/A.twoTimesComeShopMonthNum AS twoTimesComeShopMonthSucessPer,"
				+ "A.tryCarNum,A.tryCarNum/A.comeShopNum AS tryCarPer,A.tryCarMonthNum,A.tryCarMonthNum/A.comeShopMonthNum AS tryCarMonthPer,"
				+ "A.tryCarSuccessNum,A.tryCarSuccessNum/A.tryCarNum AS tryCarSucessPer,A.tryCarMonthSuccessNum,"
				+ "A.tryCarMonthSuccessNum/A.tryCarMonthNum AS tryCarMonthSuccessPer,"
				+ "A.customerSuccessNum,A.customerSuccessNum/A.recordNum AS customerSuccessPer,A.customerMonthSuccessNum,"
				+ "A.customerMonthSuccessNum/A.recordMonthNum AS customerMonthSuccessPer,B.trackNum,B.trackNum/A.recordNum AS trackAva,"
				+ "B.trackOverTimeNum,B.trackOverTimeNum/B.trackNum AS trackOverTimePer,B.trackMonthNum,B.trackMonthOverTimeNum,"
				+ "B.trackMonthOverTimeNum/B.trackMonthNum AS trackMonthOverTimePer "
				+ "FROM ("
				+ "	SELECT "
				+ "	cust.enterpriseId AS entId,"
				+ " dep.dbid AS depId,"
				+ "	dep.name AS depName,"
				+ "	COUNT(dep.dbid) AS recordNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.createFolderTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS recordMonthNum,"
				+ "	COUNT(IF(cust.lastResult=0,TRUE,NULL)) AS recordOverplusNum,"
				+ "	COUNT(IF(cust.lastResult>1&&custcl.approvalStatus=1,TRUE,NULL)) AS flowNum,"
				+ "	COUNT(IF(DATE_FORMAT(custcl.approvalDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.lastResult>1,TRUE,NULL)) as flowMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1,TRUE,NULL)) AS comeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.comeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1,TRUE,NULL)) AS comeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopMonthSuccessNum,"
				+ "	COUNT(IF(cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.twoComeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopMonthSucessNum,"
				+ "	COUNT(IF(cpid.pidStatus=2,TRUE,NULL)) AS customerSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2,TRUE,NULL)) AS customerMonthSuccessNum,"
				+ "	COUNT(if(custsh.isTryDriver=1,TRUE,NULL)) AS tryCarNum,"
				+ "	COUNT(if(DATE_FORMAT(cust.tryCarDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthNum,"
				+ "	COUNT(if(custsh.isTryDriver=1&&cpid.pidStatus=2,TRUE,NULL)) AS tryCarSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthSuccessNum"
				+ "	FROM"
				+ "	sys_department dep,cust_customer cust"
				+ "	LEFT JOIN"
				+ "	cust_customerlastbussi custcl"
				+ "	ON"
				+ "	cust.dbid= custcl.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customerpidbookingrecord cpid"
				+ "	ON  cust.dbid=cpid.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customershoppingrecord custsh"
				+ "	ON cust.dbid=custsh.customerId"
				+ "	WHERE"
				+ "	 dep.dbid=cust.departmentId AND cust.recordType=1 "+select
				+ "	 GROUP BY dep.dbid"
				+ "	ORDER BY COUNT(dep.dbid) DESC"
				+ ") A "
				+ "LEFT JOIN("
				+ "	SELECT"
				+ "	cust.departmentId,"
				+ "	COUNT(*) trackNum,"
				+ "	COUNT(IF(track.taskOverTimeStatus=2,true,NULL)) AS trackOverTimeNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS trackMonthNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&track.taskOverTimeStatus=2,TRUE,NULL)) AS trackMonthOverTimeNum"
				+ "	FROM"
				+ "	cust_customer cust LEFT JOIN cust_customertrack track ON cust.dbid=track.customerId"
				+ "	WHERE"
				+ "	cust.recordType=1 AND taskDealStatus>1 "+select
				+ "	GROUP BY cust.departmentId"
				+ ")B "
				+ "ON A.depId=B.departmentId";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return staCustComps;
	}
	/**
	 * 查询分公司部门数据
	 * @param entId
	 * @return
	 */
	public List<StaCustComp> queryUserStaCustComp(Integer entId,Integer depId,String tartDate,String endDate){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String select=" ";
		if(null!=entId&&entId>0){
			select=select+" AND cust.enterpriseId="+entId+" ";
		}
		if(null!=depId&&depId>0){
			select=select+" AND cust.departmentId="+depId+" ";
		}
		if(null!=tartDate){
			select=select+" AND cust.createFolderTime>='"+tartDate+"' ";
		}
		if(null!=endDate){
			select=select+" AND cust.createFolderTime<'"+endDate+"' ";
		}
		Calendar instance = Calendar.getInstance();
		int month = instance.get(Calendar.MONTH);
		if(null!=endDate){
			Date date = DateUtil.string2Date(endDate);
			 month= date.getMonth();
		}
		instance.set(Calendar.MONTH, month-1);
		Date time = instance.getTime();
		String format = DateUtil.format(time);
		String sql="SELECT "
				+ "A.entId,A.depId,A.userId,A.userName,"
				+ "A.recordNum,A.recordMonthNum,A.recordOverplusNum,(A.recordMonthNum-A.flowMonthNum) AS recordMonthAddNum,"
				+ "A.flowNum,A.flowNum/A.recordNum AS flowMonthPer,A.flowMonthNum,A.flowMonthNum/A.recordMonthNum AS flowMonthPer,"
				+ "A.comeShopNum,A.comeShopNum/A.recordNum AS comeShopPer,A.comeShopMonthNum,A.comeShopMonthNum/A.recordNum AS comeShopMonthPer,"
				+ "A.comeShopSucessNum,A.comeShopSucessNum/A.comeShopNum AS comeShopSucessPer,A.comeShopMonthSuccessNum,"
				+ "A.comeShopMonthSuccessNum/A.comeShopMonthNum AS comeShopMonthSuccessPer,"
				+ "A.twoTimesComeShopNum,A.twoTimesComeShopNum/A.comeShopNum AS twoTimesComeShopPer,A.twoTimesComeShopMonthNum,"
				+ "A.twoTimesComeShopMonthNum/A.comeShopMonthNum AS twoTimesComeShopMonthPer,"
				+ "A.twoTimesComeShopSucessNum,A.twoTimesComeShopSucessNum/A.twoTimesComeShopNum AS twoTimesComeShopSucessPer,"
				+ "A.twoTimesComeShopMonthSucessNum,A.twoTimesComeShopMonthSucessNum/A.twoTimesComeShopMonthNum AS twoTimesComeShopMonthSucessPer,"
				+ "A.tryCarNum,A.tryCarNum/A.comeShopNum AS tryCarPer,A.tryCarMonthNum,A.tryCarMonthNum/A.comeShopMonthNum AS tryCarMonthPer,"
				+ "A.tryCarSuccessNum,A.tryCarSuccessNum/A.tryCarNum AS tryCarSucessPer,A.tryCarMonthSuccessNum,"
				+ "A.tryCarMonthSuccessNum/A.tryCarMonthNum AS tryCarMonthSuccessPer,"
				+ "A.customerSuccessNum,A.customerSuccessNum/A.recordNum AS customerSuccessPer,A.customerMonthSuccessNum,"
				+ "A.customerMonthSuccessNum/A.recordMonthNum AS customerMonthSuccessPer,B.trackNum,B.trackNum/A.recordNum AS trackAva,"
				+ "B.trackOverTimeNum,B.trackOverTimeNum/B.trackNum AS trackOverTimePer,B.trackMonthNum,B.trackMonthOverTimeNum,"
				+ "B.trackMonthOverTimeNum/B.trackMonthNum AS trackMonthOverTimePer "
				+ "FROM ("
				+ "	SELECT"
				+ "	cust.enterpriseId as entId,"
				+ "  cust.departmentId AS depId,"
				+ "	cust.bussiStaffId AS userId,"
				+ "	cust.bussiStaff AS userName,"
				+ "	COUNT(cust.bussiStaffId) AS recordNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.createFolderTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS recordMonthNum,"
				+ "	COUNT(IF(cust.lastResult=0,TRUE,NULL)) AS recordOverplusNum,"
				+ "	COUNT(IF(cust.lastResult>1&&custcl.approvalStatus=1,TRUE,NULL)) AS flowNum,"
				+ "	COUNT(IF(DATE_FORMAT(custcl.approvalDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.lastResult>1,TRUE,NULL)) as flowMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1,TRUE,NULL)) AS comeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.comeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1,TRUE,NULL)) AS comeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>=1&&cpid.pidStatus=2,TRUE,NULL)) AS comeShopMonthSuccessNum,"
				+ "	COUNT(IF(cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopNum,"
				+ "	COUNT(IF(DATE_FORMAT(cust.twoComeShopDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1,TRUE,NULL)) AS twoTimesComeShopMonthNum,"
				+ "	COUNT(IF(cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopSucessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cust.comeShopNum>1&&cpid.pidStatus=2,TRUE,NULL)) AS twoTimesComeShopMonthSucessNum,"
				+ "	COUNT(IF(cpid.pidStatus=2,TRUE,NULL)) AS customerSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2,TRUE,NULL)) AS customerMonthSuccessNum,"
				+ "	COUNT(if(custsh.isTryDriver=1,TRUE,NULL)) AS tryCarNum,"
				+ "	COUNT(if(DATE_FORMAT(cust.tryCarDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthNum,"
				+ "	COUNT(if(custsh.isTryDriver=1&&cpid.pidStatus=2,TRUE,NULL)) AS tryCarSuccessNum,"
				+ "	COUNT(IF(DATE_FORMAT(cpid.modifyTime,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&cpid.pidStatus=2&&custsh.isTryDriver=1,TRUE,NULL)) AS tryCarMonthSuccessNum"
				+ "	FROM"
				+ "	cust_customer cust"
				+ "	LEFT JOIN"
				+ "	cust_customerlastbussi custcl"
				+ "	ON"
				+ "	cust.dbid= custcl.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customerpidbookingrecord cpid"
				+ "	ON  cust.dbid=cpid.customerId"
				+ "	LEFT JOIN"
				+ "	 cust_customershoppingrecord custsh"
				+ "	ON cust.dbid=custsh.customerId"
				+ "	WHERE"
				+ "	 cust.recordType=1 AND cust.enterpriseId=1 "+select
				+ "	GROUP BY cust.bussiStaffId"
				+ "	ORDER BY COUNT(cust.bussiStaffId) DESC"
				+ ") A "
				+ "LEFT JOIN"
				+ "("
				+ "	SELECT cust.bussiStaffId,"
				+ "	COUNT(*) trackNum,"
				+ "	COUNT(IF(track.taskOverTimeStatus=2,true,NULL)) AS trackOverTimeNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m'),TRUE,NULL)) AS trackMonthNum,"
				+ "	COUNT(IF(DATE_FORMAT(track.finishDate,'%Y-%m')=DATE_FORMAT('"+format+"','%Y-%m')&&track.taskOverTimeStatus=2,TRUE,NULL)) AS trackMonthOverTimeNum"
				+ "	FROM"
				+ "	cust_customer cust LEFT JOIN cust_customertrack track ON cust.dbid=track.customerId"
				+ "	WHERE"
				+ "	cust.recordType=1 AND taskDealStatus>1 "+select
				+ "	GROUP BY cust.bussiStaffId"
				+ ")B "
				+ "ON A.userId=B.bussiStaffId";
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return staCustComps;
	}
	
	/**
	 * 查询
	 * @param type
	 * @param dbid
	 * @return
	 */
	public List<StaCustComp> queryEntByYear(Integer type,Integer dbid){
		String sql="select * from sta_custcomp where 1=1 ";
		if(type==1){
			sql=sql+" AND entId="+dbid;
		}
		if(type==2){
			sql=sql+" AND depId="+dbid;
		}
		if(type==3){
			sql=sql+" AND userId="+dbid;
		}
		sql=sql+" AND DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.formatPatten(new Date(), "yyyy")+"'";
		List<StaCustComp> staCustComps = executeSql(sql,null);
		
		return staCustComps;
	}
	
	/**
	 * 查询
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public Map<Integer,StaCustComp> queryAllYear(){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String sql="SELECT "
				+ "SUM(recordNum) AS recordNum,SUM(recordMonthNum) AS recordMonthNum,SUM(recordOverplusNum) AS recordOverplusNum,SUM(recordMonthAddNum) AS recordMonthAddNum,"
				+ "SUM(flowNum) AS flowNum,SUM(flowNum)/SUM(recordNum) AS flowPer,SUM(flowMonthNum) AS flowMonthNum,"
				+ "SUM(flowMonthNum)/SUM(recordMonthNum) AS flowMonthPer,SUM(comeShopNum) AS comeShopNum,"
				+ "SUM(comeShopNum)/SUM(recordNum) AS comeShopPer,SUM(comeShopMonthNum) AS comeShopMonthNum,"
				+ "SUM(comeShopMonthNum)/SUM(recordNum) AS comeShopMonthPer,SUM(comeShopSucessNum) AS comeShopSucessNum,"
				+ "SUM(comeShopSucessNum)/SUM(comeShopNum) AS comeShopSucessPer,SUM(comeShopMonthSuccessNum) AS comeShopMonthSuccessNum,"
				+ "SUM(comeShopMonthSuccessNum)/SUM(comeShopMonthNum) AS comeShopMonthSuccessPer,SUM(twoTimesComeShopNum) AS twoTimesComeShopNum,"
				+ "SUM(twoTimesComeShopNum)/SUM(comeShopNum) AS twoTimesComeShopPer,SUM(twoTimesComeShopMonthNum) AS twoTimesComeShopMonthNum,"
				+ "SUM(twoTimesComeShopMonthNum)/SUM(comeShopMonthNum) AS twoTimesComeShopMonthPer,SUM(twoTimesComeShopSucessNum) as twoTimesComeShopSucessNum,"
				+ "SUM(twoTimesComeShopSucessNum)/SUM(twoTimesComeShopNum) AS twoTimesComeShopSucessPer,"
				+ "SUM(twoTimesComeShopMonthSucessNum)/SUM(twoTimesComeShopMonthNum) AS twoTimesComeShopMonthSucessPer,"
				+ "SUM(tryCarNum) AS tryCarNum,SUM(tryCarNum)/SUM(comeShopNum) AS tryCarPer,SUM(tryCarMonthNum) AS tryCarMonthNum,"
				+ "SUM(tryCarMonthNum)/SUM(comeShopMonthNum) AS tryCarMonthPer,SUM(tryCarSuccessNum) AS tryCarSuccessNum,"
				+ "SUM(tryCarSuccessNum)/SUM(tryCarNum) AS tryCarSucessPer,SUM(tryCarMonthSuccessNum) AS tryCarMonthSuccessNum,"
				+ "SUM(tryCarMonthSuccessNum)/SUM(tryCarMonthNum) AS tryCarMonthSuccessPer,SUM(customerSuccessNum) AS customerSuccessNum,"
				+ "SUM(customerSuccessNum)/SUM(recordNum) AS customerSuccessPer,SUM(customerMonthSuccessNum) AS customerMonthSuccessNum,"
				+ "SUM(customerMonthSuccessNum)/SUM(recordMonthNum) AS customerMonthSuccessPer,SUM(trackNum) AS trackNum,"
				+ "SUM(trackNum)/SUM(recordNum) AS trackAva,SUM(trackOverTimeNum) AS trackOverTimeNum,"
				+ "SUM(trackOverTimeNum)/SUM(trackNum) AS trackOverTimePer,SUM(trackMonthNum) AS trackMonthNum,"
				+ "SUM(trackMonthOverTimeNum) AS trackMonthOverTimeNum,SUM(trackMonthOverTimeNum)/SUM(trackMonthNum) AS trackMonthOverTimePer,createDate "
				+ "FROM "
				+ "sta_custcomp "
				+ "where "
				+ "1=1 AND DATE_FORMAT(createDate,'%Y')=DATE_FORMAT(NOW(),'%Y') AND entId IS NOT NULL "
				+ "GROUP BY DATE_FORMAT(createDate,'%Y-%m')";
		Map<Integer, StaCustComp> map=new HashMap<Integer,StaCustComp>();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
			for (int i = 0; i <12; i++) {
				if(null!=staCustComps&&!staCustComps.isEmpty()){
					boolean status=false;
					for (StaCustComp staCustComp : staCustComps) {
						Date createDate = staCustComp.getCreateDate();
						if(null!=createDate){
							int month = createDate.getMonth();
							if(month==i){
								status=true;
								map.put(Integer.valueOf(i), staCustComp);
							}
						}
					}
					if(status==false){
						map.put(Integer.valueOf(i), null);
					}
				}else{
					map.put(Integer.valueOf(i), null);
				}
			}
			map=sortMapByKey(map, true);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 查询
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public Map<Integer,StaCustComp> queryAllYearByEntId(Integer entId){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String sql="SELECT"
				+ "		* "
				+ "		FROM"
				+ "		sta_custcomp where 1=1 AND DATE_FORMAT(createDate,'%Y')='"+DateUtil.formatPatten(new Date(), "yyyy")+"' AND entId="+entId+ "  "
				+ "		GROUP BY DATE_FORMAT(createDate,'%Y-%m')";
		Map<Integer, StaCustComp> map=new HashMap<Integer,StaCustComp>();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
			for (int i = 0; i <12; i++) {
				if(null!=staCustComps&&!staCustComps.isEmpty()){
					boolean status=false;
					for (StaCustComp staCustComp : staCustComps) {
						Date createDate = staCustComp.getCreateDate();
						int month = createDate.getMonth();
						if(month==i){
							status=true;
							map.put(Integer.valueOf(i), staCustComp);
						}
					}
					if(status==false){
						map.put(Integer.valueOf(i), null);
					}
				}else{
					map.put(Integer.valueOf(i), null);
				}
			}
			map=sortMapByKey(map, true);
			resultSet.close();
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	/**
	 * 查询
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public Map<Integer,StaCustComp> queryAllYearByDepId(Integer depId){
		List<StaCustComp> staCustComps=new ArrayList<StaCustComp>();
		String sql="SELECT"
				+ "		* "
				+ "		FROM"
				+ "		sta_custcomp where 1=1 AND DATE_FORMAT(createDate,'%Y')='"+DateUtil.formatPatten(new Date(), "yyyy")+"' AND depId="+depId+ "  "
				+ "		GROUP BY DATE_FORMAT(createDate,'%Y-%m')";
		Map<Integer, StaCustComp> map=new HashMap<Integer,StaCustComp>();
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcConnection;
		try {
			jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			staCustComps = ResultSetUtil.getDateResult(staCustComps, resultSet, StaCustComp.class);
			for (int i = 0; i <12; i++) {
				if(null!=staCustComps&&!staCustComps.isEmpty()){
					boolean status=false;
					for (StaCustComp staCustComp : staCustComps) {
						Date createDate = staCustComp.getCreateDate();
						int month = createDate.getMonth();
						if(month==i){
							status=true;
							map.put(Integer.valueOf(i), staCustComp);
						}
					}
					if(status==false){
						map.put(Integer.valueOf(i), null);
					}
				}else{
					map.put(Integer.valueOf(i), null);
				}
			}
			map=sortMapByKey(map, true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public static Map<Integer, StaCustComp> sortMapByKey(Map<Integer, StaCustComp> oriMap, final boolean isRise) {
	    if (oriMap == null || oriMap.isEmpty()) {
	        return null;
	    }

	    Map<Integer, StaCustComp> sortMap = new TreeMap<Integer, StaCustComp>(new Comparator<Integer>() {
	        public int compare(Integer o1, Integer o2) {
	            if (isRise) {
	                // 升序排序
	                return o1.compareTo(o2);
	            } else {
	                // 降序排序
	                return o2.compareTo(o1);
	            }
	        }
	    });
	    sortMap.putAll(oriMap);
	    return sortMap;
	}
}
