package com.ystech.weixin.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.mem.model.Member;
import com.ystech.weixin.model.WeixinNewsitem;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("weixinNewsitemManageImpl")
public class WeixinNewsitemManageImpl extends HibernateEntityDao<WeixinNewsitem>{
	public WeixinNewsitem getWeixinNewsitem(Member member){
		String sql="select wni.* "
				+ "from "
				+ "	weixin_newsitem wni,weixin_newstemplate wnt "
				+ "where wni.templateid=wnt.dbid AND  wnt.tempType=2 ";
		List<WeixinNewsitem> weixinNewsitems=null;
		if(null!=member){
			Enterprise enterprise = member.getEnterprise();
			if(null!=enterprise){
				sql=sql+" AND wnt.enterpriseId="+enterprise.getDbid();
				weixinNewsitems = executeSql(sql, null);
			}
		}
		if(null==weixinNewsitems||weixinNewsitems.isEmpty()){
			sql=sql+" AND wnt.enterpriseId=0";
			weixinNewsitems = executeSql(sql, null);
		}
		if(null==weixinNewsitems){
			return null;
		}
		return weixinNewsitems.get(0);
	}
}
