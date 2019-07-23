package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.OrderContractExpensesChargeItem;

@Component("orderContractExpensesChargeItemManageImpl")
public class OrderContractExpensesChargeItemManageImpl extends HibernateEntityDao<OrderContractExpensesChargeItem> {

	public void deleteByOrderId(Integer dbid) {
		String sql="delete from cust_OrderContractExpensesChargeItem where orderContractExpressId="+dbid;
		executeSql(sql);
	}
}
