package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.AppUser;

@Component("appUserManageImpl")
public class AppUserManageImpl extends HibernateEntityDao<AppUser>{

}
