package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.AppDepartment;

@Component("appDepartmentManageImpl")
public class AppDepartmentManageImpl extends HibernateEntityDao<AppDepartment>{

}
