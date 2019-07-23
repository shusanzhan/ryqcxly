package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerImage;

@Component("customerImageManageImpl")
public class CustomerImageManageImpl extends HibernateEntityDao<CustomerImage>{

}
