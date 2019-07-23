/**
 * 
 */
package com.ystech.xwqr.set.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.set.model.CarSeriy;

/**
 * @author shusanzhan
 * @date 2014-2-17
 */
@Component("carSeriyManageImpl")
public class CarSeriyManageImpl extends HibernateEntityDao<CarSeriy>{
	public List<CarSeriy> findByEnterpriseIdAndBrandId(Integer enterpriseId,Integer brandId){
		String hql=" from CarSeriy where 1=1";
		if(enterpriseId!=null&&enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		if(brandId!=null&&brandId>0){
			hql=hql+" AND brand.dbid="+brandId;
		}
		List<CarSeriy> carSeriys = find(hql, null);
		return carSeriys;
	}
	/**
	 * 查询ajax数据
	 * @param enterpriseId
	 * @param brandId
	 * @return
	 */
	public List<CarSeriy> findAjaxByEnterpriseIdAndBrandId(Integer enterpriseId,Integer brandId){
		String hql=" from CarSeriy where 1=1 and status="+CarSeriy.STATUSCOMM;
		if(enterpriseId!=null&&enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		if(brandId!=null&&brandId>0){
			hql=hql+" AND brand.dbid="+brandId;
		}
		List<CarSeriy> carSeriys = find(hql, null);
		return carSeriys;
	}
}
