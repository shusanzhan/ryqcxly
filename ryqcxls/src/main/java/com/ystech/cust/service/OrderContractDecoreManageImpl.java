package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.OrderContractDecore;

@Component("orderContractDecoreManageImpl")
public class OrderContractDecoreManageImpl extends HibernateEntityDao<OrderContractDecore>{
	public void deleteBy(Integer orderContractId){
		executeSql("delete from cust_orderContractDecore where orderContractId="+orderContractId);
	}

	public void updateOrderContractDecore(Integer dbid) {
		String update="UPDATE " +
				"cust_ordercontractdecore od,(SELECT dbid, SUM(price) AS price FROM cust_ordercontractdecoreitem WHERE orderContractDecoreId="+dbid+") re " +
				"SET od.giveTotalPrice=re.price WHERE od.dbid="+dbid;
		executeSql(update);
	}
}
