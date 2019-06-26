package com.ystech.xwqr.service.sys;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.model.sys.SystemInfo;

@Component("systemInfoMangeImpl")
public class SystemInfoMangeImpl extends HibernateEntityDao<SystemInfo>{
	public SystemInfo getSystemInfo(){
		//用户配置信息
		SystemInfo systemInfo=null;
		List<SystemInfo> systemInfos =getAll();
		if(null!=systemInfos){
			systemInfo=systemInfos.get(0);
		}
		return systemInfo;
	}
}
