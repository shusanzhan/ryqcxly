package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.core.dao.HibernateEntityDao;

@Component("agentOperatorLogManageImpl")
public class AgentOperatorLogManageImpl extends HibernateEntityDao<AgentOperatorLog>{

}
