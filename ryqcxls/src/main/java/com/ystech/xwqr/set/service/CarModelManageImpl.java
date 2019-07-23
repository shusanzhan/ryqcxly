/**
 * 
 */
package com.ystech.xwqr.set.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.set.model.CarModel;

/**
 * @author shusanzhan
 * @date 2014-2-17
 */
@Component("carModelManageImpl")
public class CarModelManageImpl extends HibernateEntityDao<CarModel>{
	public List<CarModel> findByEnterpriseIdAndBrandIdAndCarSeriyId(Integer enterpriseId,Integer brandId,Integer carSeriyId){
		String hql=" from CarModel where 1=1";
		if(enterpriseId!=null&&enterpriseId>0){
			hql=hql+" AND enterpriseId="+enterpriseId;
		}
		if(brandId!=null&&brandId>0){
			hql=hql+" AND brand.dbid="+brandId;
		}
		if(carSeriyId!=null&&carSeriyId>0){
			hql=hql+" AND carseries.dbid="+carSeriyId;
		}
		List<CarModel> carModels = find(hql, null);
		return carModels;
	}
}
