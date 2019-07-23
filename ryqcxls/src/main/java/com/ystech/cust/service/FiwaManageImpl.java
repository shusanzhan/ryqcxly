/**
 * 
 */
package com.ystech.cust.service;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.Fiwa;
import com.ystech.cust.model.Fiwaresult;

/**
 * @author shusanzhan
 * @date 2014-7-10
 */
@Component("fiwaManageImpl")
public class FiwaManageImpl extends HibernateEntityDao<Fiwa>{
	
	public void updateDate(Fiwaresult fiwaresult){
		String upate="update fiwa set isWin="+Fiwa.WIN+" where dg="+fiwaresult.getDg()+"  and agt="+fiwaresult.getAgt();
		String upatesql="update fiwa set isWin="+Fiwa.LOSE+" where dg!="+fiwaresult.getDg()+"  or agt!="+fiwaresult.getAgt();
		executeSql(upate);
		executeSql(upatesql);
	}
}
