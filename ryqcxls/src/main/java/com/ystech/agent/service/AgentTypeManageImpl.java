package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentType;
import com.ystech.core.dao.HibernateEntityDao;

@Component("agentTypeManageImpl")
public class AgentTypeManageImpl extends HibernateEntityDao<AgentType>{

}
