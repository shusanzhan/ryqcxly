package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerFlowReason;

@Component("customerFlowReasonManageImpl")
public class CustomerFlowReasonManageImpl extends HibernateEntityDao<CustomerFlowReason>{

}
