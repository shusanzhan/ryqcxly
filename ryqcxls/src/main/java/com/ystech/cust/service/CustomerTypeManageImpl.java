package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerType;

@Component("customerTypeManageImpl")
public class CustomerTypeManageImpl extends HibernateEntityDao<CustomerType>{

}
