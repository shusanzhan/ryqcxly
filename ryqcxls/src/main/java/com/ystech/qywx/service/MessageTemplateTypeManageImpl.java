package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.MessageTemplateType;

@Component("messageTemplateTypeManageImpl")
public class MessageTemplateTypeManageImpl extends HibernateEntityDao<MessageTemplateType>{

}
