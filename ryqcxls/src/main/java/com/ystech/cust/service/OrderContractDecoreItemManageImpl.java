package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.OrderContractDecoreItem;

@Component("orderContractDecoreItemManageImpl")
public class OrderContractDecoreItemManageImpl extends HibernateEntityDao<OrderContractDecoreItem>{

	public void updateItemByOrderContractDecoreId(Integer dbid) {
		String updateSql="update OrderContractDecoreItem set type="+OrderContractDecoreItem.TYPEZS+" where orderContractDecoreId="+dbid;
		executeSql(updateSql);
	}

}
