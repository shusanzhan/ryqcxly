package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.MessageTemplate;

@Component("messageTemplateManageImpl")
public class MessageTemplateManageImpl extends HibernateEntityDao<MessageTemplate>{

}
