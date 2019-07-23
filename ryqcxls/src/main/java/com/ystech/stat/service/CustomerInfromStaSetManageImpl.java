package com.ystech.stat.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("customerInfromStaSetManageImpl")
public class CustomerInfromStaSetManageImpl extends HibernateEntityDao<CustomerInfromStaSet>{
	/**
	 * 功能描述：通过codeNum获取信息来源IDs
	 * @param enterpriseId
	 * @param codeNum
	 * @return
	 */
	public String findCustomerInfromIdsByCodeNum(int enterpriseId,int codeNum){
		List<CustomerInfromStaSet> customerInfromStaSets = find("from CustomerInfromStaSet where enterpriseId=? AND codeNum=? ", new Object[]{enterpriseId,codeNum});
		StringBuffer buffer=new StringBuffer();
		if(null!=customerInfromStaSets&&!customerInfromStaSets.isEmpty()){
			for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
				CustomerInfrom customerInfrom = customerInfromStaSet.getCustomerInfrom();
				if(null!=customerInfrom){
					buffer.append(customerInfrom.getDbid()+",");
				}
			}
		}
		String infromIds = buffer.toString();
		if(infromIds!=null&&infromIds.trim().length()>0){
			infromIds=infromIds.substring(0,(infromIds.length()-1));
		}
		return infromIds;
	}
	/**
	 * 功能描述：查询公司所有客户来源
	 * @param enterprise
	 * @return
	 */
	public String queryByCustomerInfromIdsByEntparseId(Enterprise enterprise){
		String sql="select * from sta_CustomerInfromStaSet where staStatus=1 AND enterpriseId="+enterprise.getDbid();
		List<CustomerInfromStaSet> customerInfromStaSets = executeSql(sql, null);
		StringBuffer buffer=new StringBuffer();
		if(null!=customerInfromStaSets&&!customerInfromStaSets.isEmpty()){
			for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
				CustomerInfrom customerInfrom = customerInfromStaSet.getCustomerInfrom();
				if(null!=customerInfrom){
					buffer.append(customerInfrom.getDbid()+",");
				}
			}
		}
		String infromIds = buffer.toString();
		if(infromIds!=null&&infromIds.trim().length()>0){
			infromIds=infromIds.substring(0,(infromIds.length()-1));
		}
		return infromIds;
	}
}
