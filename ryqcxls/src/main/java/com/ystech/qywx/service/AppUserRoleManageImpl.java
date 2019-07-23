package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.AppUserRole;

@Component("appUserRoleManageImpl")
public class AppUserRoleManageImpl extends HibernateEntityDao<AppUserRole>{

}
