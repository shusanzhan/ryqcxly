/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Sms;

/**
 * @author shusanzhan
 * @date 2014-7-26
 */
@Component("smsManageImpl")
public class SmsManageImpl extends HibernateEntityDao<Sms>{

}
