package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.FlowReason;
import com.ystech.core.dao.HibernateEntityDao;

@Component("flowReasonManageImpl")
public class FlowReasonManageImpl extends HibernateEntityDao<FlowReason>{

}
