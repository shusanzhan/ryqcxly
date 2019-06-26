package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.App;

@Component("appManageImpl")
public class AppManageImpl extends HibernateEntityDao<App>{

}
