package com.ystech.agent.service;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.VerificationCode;
import com.ystech.core.dao.HibernateEntityDao;

@Component("verificationCodeManageImpl")
public class VerificationCodeManageImpl extends HibernateEntityDao<VerificationCode>{

}
