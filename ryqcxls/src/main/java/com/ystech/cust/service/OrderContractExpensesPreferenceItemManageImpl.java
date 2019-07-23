package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.OrderContractExpensesPreferenceItem;

@Component("orderContractExpensesPreferenceItemManageImpl")
public class OrderContractExpensesPreferenceItemManageImpl extends HibernateEntityDao<OrderContractExpensesPreferenceItem>{

	public void deleteByOrderId(Integer dbid) {
		String sql="delete from cust_OrderContractExpensesPreferenceItem where orderContractExpensesId="+dbid;
		executeSql(sql);
	}

}
