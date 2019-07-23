/**
 * 
 */
package com.ystech.xwqr.service.sys;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2013-6-2
 */
@Component("enterpriseManageImpl")
public class EnterpriseManageImpl extends HibernateEntityDao<Enterprise>{
	public void updateTurnCustomerToCompnay(Enterprise company2,Enterprise nextCompany){
		String customerSql="UPDATE "
				+ " cust_customer SET companyId="+nextCompany.getDbid()+",backNetType=2,distStatus=1,showStatus=1 WHERE companyId="+company2.getDbid();
		executeSql(customerSql);
	}
}
