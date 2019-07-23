/**
 * 
 */
package com.ystech.cust.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.dao.Page;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.OrderContract;

/**
 * @author shusanzhan
 * @date 2014-3-11
 */
@Component("orderContractManageImpl")
public class OrderContractManageImpl extends HibernateEntityDao<OrderContract>{

	/**
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param mobilePhone
	 * @return
	 */
	public Page<OrderContract> pageQueryBy(Integer pageNo, Integer pageSize,
			Integer userId, String mobilePhone,Integer status) {
		String sql="select * from cust_orderContract as orderc, cust_Customer as cu  where cu.bussiStaffId=?  and orderc.customerId=cu.dbid and orderc.status!=? and orderc.status!=?";
		List param= new ArrayList();
		param.add(userId);
		param.add(OrderContract.WATINGDECORE);
		param.add(OrderContract.PRINT);
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(status>0){
			sql=sql+" and orderc.status = ? ";
			param.add(status);
		}
		sql=sql+" order by createTime DESC";
		Page<OrderContract> page = pagedQuerySql(pageNo, pageSize,OrderContract.class,sql, param.toArray());
		return page;
	}
	/**
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param mobilePhone
	 * @param status 
	 * @param endTime 
	 * @param startTime 
	 * @param userId 
	 * @param departmentId 
	 * @return
	 */
	public Page<OrderContract> pageQueryManagerOrder(Integer pageNo, Integer pageSize,String mobilePhone, String departmentIds2, String userName, String startTime, String endTime, Integer status) {
		String sql="select * from cust_Customer as cu , cust_orderContract as orderc  where  orderc.customerId=cu.dbid and orderc.status>"+OrderContract.WATINGDECORE +" and orderc.status<"+OrderContract.PRINT;
		List param= new ArrayList();
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		//二网客户订单不查询
		sql=sql+" and cu.customerType=?";
		param.add(Customer.CUSTOMERTYPECOMM);
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and cu.bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=departmentIds2&&departmentIds2.trim().length()>0){
			sql=sql+" and departmentId in ("+departmentIds2+")";
			//param.add("("+departmentIds+")");
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and orderc.createTime>= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and orderc.createTime< ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		if(status>0){
			 sql=sql+"  and  orderc.status=? ";
			 param.add(status);
		}
		sql=sql+" order by orderc.createTime DESC";
		Page<OrderContract> page = pagedQuerySql(pageNo, pageSize, OrderContract.class, sql, param.toArray());
		return page;
	}
	/**
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param mobilePhone
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Page<OrderContract> pageQueryGMSManagerOrder(Integer pageNo, Integer pageSize,String mobilePhone,String departmentIds, String userName, String startTime, String endTime) {
		String sql="select * from cust_Customer as cu , cust_orderContract as orderc  where  orderc.customerId=cu.dbid  and orderc.status!=? ";
		List param= new ArrayList();
		param.add(OrderContract.PRINT);
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(null!=userName&&userName.trim().length()>0){
			sql=sql+" and cu.bussiStaff like ? ";
			param.add("%"+userName+"%");
		}
		if(null!=departmentIds&&departmentIds.trim().length()>0){
			sql=sql+" and departmentId in ("+departmentIds+")";
		}
		if(null!=startTime&&startTime.trim().length()>0){
			sql=sql+" and orderc.createTime>= ? ";
			param.add(DateUtil.string2Date(startTime));
		}
		if(null!=endTime&&endTime.trim().length()>0){
			sql=sql+" and orderc.createTime< ? ";
			param.add(DateUtil.nextDay(endTime));
		}
		sql=sql+" order by orderc.createTime DESC";
		Page<OrderContract> page = pagedQuerySql(pageNo, pageSize, OrderContract.class, sql, param.toArray());
		return page;
	}
	public Object count(String sql){
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
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param mobilePhone
	 * @return
	 */
	public Page<OrderContract> pageQueryRoomManageBy(Integer pageNo, Integer pageSize,
			Integer userId, String mobilePhone,Integer status,String buffIds) {
		String sql="select * from cust_orderContract as orderc, cust_Customer as cu  where cu.bussiStaffId in("+buffIds+")  and orderc.customerId=cu.dbid and orderc.status!=? and orderc.status!=?";
		List param= new ArrayList();
		param.add(OrderContract.WATINGDECORE);
		param.add(OrderContract.PRINT);
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and cu.mobilePhone like ? ";
			param.add("%"+mobilePhone+"%");
		}
		if(userId>0){
			sql=sql+" and cu.bussiStaffId=? ";
			param.add(userId);
		}
		if(status>0){
			sql=sql+" and orderc.status = ? ";
			param.add(status);
		}
		sql=sql+" order by createTime DESC";
		Page<OrderContract> page = pagedQuerySql(pageNo, pageSize,OrderContract.class,sql, param.toArray());
		return page;
	}
}
