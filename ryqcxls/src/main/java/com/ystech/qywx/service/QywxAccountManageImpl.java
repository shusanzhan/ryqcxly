package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.QywxAccount;

@Component("qywxAccountManageImpl")
public class QywxAccountManageImpl extends HibernateEntityDao<QywxAccount>{

}
