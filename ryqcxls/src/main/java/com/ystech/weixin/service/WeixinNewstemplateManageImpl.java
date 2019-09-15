package com.ystech.weixin.service;

import java.util.List;

import org.springframework.stereotype.Component;




import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.weixin.model.WeixinNewstemplate;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("weixinNewstemplateManageImpl")
public class WeixinNewstemplateManageImpl extends HibernateEntityDao<WeixinNewstemplate>{
	public java.util.List<WeixinNewstemplate> queryByEnt(){
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(enterprise.getDbid()<0){
				return null;
			}
			String sql="select * "
					+ "from "
					+ "	weixin_newstemplate  "
					+ "where tempType=2";
				sql=sql+" AND enterpriseId="+enterprise.getDbid();
		List<WeixinNewstemplate> weixinNewsitems = executeSql(sql, null);
		return weixinNewsitems;
	}
}
