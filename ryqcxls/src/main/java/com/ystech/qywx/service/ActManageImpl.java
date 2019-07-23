package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.Act;

@Component("actManageImpl")
public class ActManageImpl extends HibernateEntityDao<Act>{

}
