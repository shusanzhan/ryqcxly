/**
 * 
 */
package com.ystech.xwqr.set.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.set.model.Brand;

/**
 * @author shusanzhan
 * @date 2014-1-6
 */
@Component("brandManageImpl")
public class BrandManageImpl extends HibernateEntityDao<Brand>{
	public List<Brand> findByEnterpriseId(int enterpriseId){
		String hql="from Brand where 1=1 ";
		if(enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		List<Brand> brands =find(hql, null);
		return brands;
	}
}
