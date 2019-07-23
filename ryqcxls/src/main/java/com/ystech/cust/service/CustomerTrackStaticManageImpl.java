package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerTrackStatic;

@Component("customerTrackStaticManageImpl")
public class CustomerTrackStaticManageImpl extends HibernateEntityDao<CustomerTrackStatic>{

	public List<CustomerTrackStatic> findByDate(String date,Integer enterpriseId,Integer depId){
		String sql="select * from cust_CustomerTrackStatic where 1=1 ";
		if(null!=date&&date.trim().length()>0){
			sql=sql+" AND dayDate='"+date+"'";
		}
		if(null!=enterpriseId&&enterpriseId>0){
			sql=sql+" AND entId="+enterpriseId;
		}
		if(null!=depId&&depId>0){
			sql=sql+" AND depId="+depId;
		}
		List<CustomerTrackStatic> customerTrackStatics = executeSql(sql, null);
		return customerTrackStatics;
		
	}
}
