/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.WarmInfo;

/**
 * @author shusanzhan
 * @date 2014-2-28
 */
@Component("warmInfoManageImpl")
public class WarmInfoManageImpl extends HibernateEntityDao<WarmInfo> {

}
