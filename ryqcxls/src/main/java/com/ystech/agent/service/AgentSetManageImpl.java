package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentSet;
import com.ystech.core.dao.HibernateEntityDao;

@Component("agentSetManageImpl")
public class AgentSetManageImpl extends HibernateEntityDao<AgentSet>{

}
