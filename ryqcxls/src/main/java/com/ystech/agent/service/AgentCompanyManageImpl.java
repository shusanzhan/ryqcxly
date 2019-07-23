package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentCompany;
import com.ystech.core.dao.HibernateEntityDao;

@Component("agentCompanyManageImpl")
public class AgentCompanyManageImpl extends HibernateEntityDao<AgentCompany> {

}
