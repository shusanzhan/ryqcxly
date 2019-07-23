package com.ystech.cust.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.xwqr.model.sys.User;

@Component("customerRecordManageImpl")
public class CustomerRecordManageImpl extends HibernateEntityDao<CustomerRecord>{
	/**
	 * 查询当日进店看车数据
	 * @param currentUser
	 * @return
	 */
	public long findTodayComeShopNum(User currentUser,int type){
		Date date=new Date();
		String sql="select count(*) "
				+ "from "
				+ "cust_CustomerRecord where createDate>='"+DateUtil.format(date)+"' AND salerId="+currentUser.getDbid()+" AND status="+CustomerRecord.STATUSCOMM+" AND customerTypeId="+type;
		long lo = countSql(sql);
		return lo;
	}
	/**
	 * 查询当日进店看车建档数据
	 * @param currentUser
	 * @return
	 */
	public long findTodayComeShopCreatorFolderNum(User currentUser,int type){
		Date date=new Date();
		String sql="select count(*) "
				+ "from "
				+ "cust_CustomerRecord where createDate>='"+DateUtil.format(date)+"' AND salerId="+currentUser.getDbid()+" AND status="+CustomerRecord.STATUSCOMM+" and customerTypeId="+type+" AND resultStatus="+CustomerRecord.RESULTRECORD;
		long lo = countSql(sql);
		return lo;
	}
	/**
	 * 查询当月进店看车数据
	 * @param currentUser
	 * @return
	 */
	public long findMonthComeShopNum(User currentUser,int type){
		String sql="select count(*) "
				+ "from "
				+ "cust_CustomerRecord where DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"' AND salerId="+currentUser.getDbid()+" AND status="+CustomerRecord.STATUSCOMM+" and customerTypeId="+type;
		long lo = countSql(sql);
		return lo;
	}
	/**
	 * 查询当月进店看车建档数据
	 * @param currentUser
	 * @return
	 */
	public long findMonthComeShopCreatorFolderNum(User currentUser,int type){
		String sql="select count(*) "
				+ "from "
				+ "cust_CustomerRecord where DATE_FORMAT(createDate,'%Y-%m')='"+DateUtil.getNowMonth()+"' AND salerId="+currentUser.getDbid()+" AND status="+CustomerRecord.STATUSCOMM+" and customerTypeId="+type+" AND resultStatus="+CustomerRecord.RESULTRECORD;
		long lo = countSql(sql);
		return lo;
	}
	/**
	 * 功能描述：查询我的来店登记未处理记录
	 * @param userId
	 * @return
	 */
	public List<CustomerRecord> queryMyTask(Integer userId){
		String sql="select * from cust_CustomerRecord where status=? and customerTypeId=? AND resultStatus=? ";
		List param=new ArrayList();
		param.add(CustomerRecord.STATUSCOMM);
		param.add(CustomerRecord.TYPECOMESHOP);
		param.add(CustomerRecord.RESULTCOMM);
		sql=sql+" and (salerId=? or agentPersonId=?)";
		param.add(userId);
		param.add(userId);
		sql=sql+" order by resultStatus,createDate DESC";
		List<CustomerRecord> customerRecords = executeSql(sql, param.toArray());
		return customerRecords;
	}
	/**
	 * 功能描述：更新来店记录
	 * @param customerRecordId
	 * @param customer
	 * @param customerBussi
	 */
	public void updateCustomerRecord(int customerRecordId,Customer customer,CustomerBussi customerBussi,int resultStatus){
		//更新线索记录
		if(customerRecordId>0){
			CustomerRecord customerRecord = get(customerRecordId);  
			customerRecord.setResultStatus(resultStatus);
			customerRecord.setName(customer.getName());
			customerRecord.setMobilePhone(customer.getMobilePhone());
			customerRecord.setBrand(customerBussi.getBrand());
			customerRecord.setCarModel(customerBussi.getCarModel());
			customerRecord.setCarSeriy(customerBussi.getCarSeriy());
			customerRecord.setResultDate(new Date());
			customerRecord.setCustomer(customer);
			this.save(customerRecord);
			getSession().flush();
		}
	}
}
