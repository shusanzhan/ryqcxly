/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.SmsTemplate;

/**
 * @author shusanzhan
 * @date 2014-7-26
 */
@Component("SmsTemplateManageImpl")
public class SmsTemplateManageImpl extends HibernateEntityDao<SmsTemplate>{

}
