/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Product;

/**
 * @author shusanzhan
 * @date 2014-2-20
 */
@Component("productManageImpl")
public class ProductManageImpl extends HibernateEntityDao<Product> {



}
