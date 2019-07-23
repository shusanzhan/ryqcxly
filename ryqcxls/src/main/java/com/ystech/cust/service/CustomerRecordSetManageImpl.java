package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerRecordSet;

@Component("customerRecordSetManageImpl")
public class CustomerRecordSetManageImpl extends HibernateEntityDao<CustomerRecordSet>{

}
