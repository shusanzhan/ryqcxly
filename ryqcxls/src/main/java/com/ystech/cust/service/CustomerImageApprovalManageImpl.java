package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerImageApproval;

@Component("customerImageApprovalManageImpl")
public class CustomerImageApprovalManageImpl extends HibernateEntityDao<CustomerImageApproval>{
	public void deleteBy(Integer customerId){
		String sql="delete from cust_CustomerImageApproval where customerId="+customerId;
		executeSql(sql);
	}
}
