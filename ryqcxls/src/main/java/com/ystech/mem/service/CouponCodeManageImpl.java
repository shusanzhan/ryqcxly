package com.ystech.mem.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.dao.Page;
import com.ystech.mem.model.CouponCode;

@Component("couponCodeManageImpl")
public class CouponCodeManageImpl extends HibernateEntityDao<CouponCode>{
	/**
	 * @param pageNo
	 * @param pageSize
	 * @param dbid
	 * @param code
	 * @param mobilePhone
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Page<CouponCode> queryCouponCode(Integer pageNo, Integer pageSize,
			Integer dbid, String code, String mobilePhone) {
		List param=new ArrayList();
		String sql="select * from CouponCode as cc,member as mb where cc.couponId=? and cc.memberId=mb.dbid ";
		param.add(dbid);
		if(null!=code&&code.trim().length()>0){
			sql=sql+" and cc.code like ?";
			param.add("%"+code+"%");
		}
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			sql=sql+" and mb.mobilePhone like ?";
			param.add("%"+mobilePhone+"%");
		}
		Page page = pagedQuerySql(pageNo, pageSize, CouponCode.class, sql, param.toArray());
		return page;
	}
}
