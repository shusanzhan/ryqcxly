package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.OrderContractExpenses;

@Component("orderContractExpensesManageImpl")
public class OrderContractExpensesManageImpl extends HibernateEntityDao<OrderContractExpenses>{

	public void deleteBy(Integer customerId) {
		int executeSql = executeSql("delete from cust_ordercontractexpenses where customerId="+customerId);
		System.out.println("========"+executeSql);
	}
	
}
