package com.ystech.stat.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.LogUtil;
import com.ystech.stat.model.StaCustomerCopy;

@Component("staCustomerCopyManageImpl")
public class StaCustomerCopyManageImpl extends HibernateEntityDao<StaCustomerCopy>{
	/**
	 * 功能描述：每月批量更新数据（只有一次）
	 */
	public void insertBatch(){
		try {
			
		} catch (Exception e) {
			LogUtil.error("潜客基盘扎异常", e);
		}
	}
}
