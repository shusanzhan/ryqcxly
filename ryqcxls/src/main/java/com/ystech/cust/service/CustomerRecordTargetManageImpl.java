package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerRecordTarget;

@Component("customerRecordTargetManageImpl")
public class CustomerRecordTargetManageImpl extends HibernateEntityDao<CustomerRecordTarget>{

}
