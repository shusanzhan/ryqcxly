/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerShoppingRecord;

/**
 * @author shusanzhan
 * @date 2014-2-27
 */
@Component("customerShoppingRecordManageImpl")
public class CustomerShoppingRecordManageImpl extends HibernateEntityDao<CustomerShoppingRecord>{

}
