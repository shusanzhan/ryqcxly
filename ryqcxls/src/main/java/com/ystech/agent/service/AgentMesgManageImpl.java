package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentMesg;
import com.ystech.core.dao.HibernateEntityDao;

@Component("agentMesgManageImpl")
public class AgentMesgManageImpl extends HibernateEntityDao<AgentMesg>{

}
