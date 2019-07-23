package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.RecommendCustomer;
import com.ystech.core.dao.HibernateEntityDao;

@Component("recommendCustomerManageImpl")
public class RecommendCustomerManageImpl extends HibernateEntityDao<RecommendCustomer>{

}
