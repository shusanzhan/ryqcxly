/**
 * 
 */
package com.ystech.xwqr.set.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.set.model.CarColor;

/**
 * @author shusanzhan
 * @date 2014-6-21
 */
@Component("carColorManageImpl")
public class CarColorManageImpl extends HibernateEntityDao<CarColor>{
	public List<CarColor> findByEnterpriseIdAndBrandIdAndCarSeriyId(Integer enterpriseId,Integer brandId,Integer carSeriyId){
		String hql=" from CarColor where 1=1";
		if(enterpriseId!=null&&enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		if(brandId!=null&&brandId>0){
			hql=hql+" AND brandId="+brandId;
		}
		if(carSeriyId!=null&&carSeriyId>0){
			hql=hql+" AND carseries.dbid="+carSeriyId;
		}
		List<CarColor> carModels = find(hql, null);
		return carModels;
	}
	/**
	 * 
	 * @param enterpriseId
	 * @return
	 */
	public List<CarColor> findAjaxByEnterpriseId(Integer enterpriseId){
		String hql=" from CarColor where 1=1";
		if(enterpriseId!=null&&enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		hql=hql+" AND status="+CarColor.STATUSCOMM;
		List<CarColor> carModels = find(hql, null);
		return carModels;
	}
}
