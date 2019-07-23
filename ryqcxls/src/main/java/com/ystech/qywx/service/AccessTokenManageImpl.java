package com.ystech.qywx.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.AccessToken;

@Component("accessTokenManageImpl")
public class AccessTokenManageImpl extends HibernateEntityDao<AccessToken>{

	public void updateSql(AccessToken accessTocken) {
		String sql = "update qywx_accesstoken set access_token='"+accessTocken.getAccessToken()+"',expires_in="+accessTocken.getExpiresIn()+",addtime=now() where dbid='"+accessTocken.getDbid()+"'";
    	executeSql(sql);
	}

}
