package com.ystech.cust.service;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.cust.model.CustomerOperatorLog;
import com.ystech.xwqr.model.sys.User;

@Component("customerOperatorLogManageImpl")
public class CustomerOperatorLogManageImpl extends HibernateEntityDao<CustomerOperatorLog>{
	public void saveCustomerOperatorLog(Integer customerId,String type,String note){
		User currentUser = SecurityUserHolder.getCurrentUser();
		CustomerOperatorLog customerOperatorLog=new CustomerOperatorLog();
		customerOperatorLog.setCustomerId(customerId);
		customerOperatorLog.setOperateDate(new Date());
		if(null!=currentUser){
			customerOperatorLog.setOperator(currentUser.getRealName());
		}
		customerOperatorLog.setType(type);
		customerOperatorLog.setNote(note);
		save(customerOperatorLog);
	}
	public void saveCustomerOperatorLog(Integer customerId,String type,String note,User user){
		CustomerOperatorLog customerOperatorLog=new CustomerOperatorLog();
		customerOperatorLog.setCustomerId(customerId);
		customerOperatorLog.setOperateDate(new Date());
		if(null!=user){
			customerOperatorLog.setOperator(user.getRealName());
		}
		customerOperatorLog.setType(type);
		customerOperatorLog.setNote(note);
		save(customerOperatorLog);
	}
}
