package com.ystech.stat.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("customerInfromStaSetServiceImpl")
public class CustomerInfromStaSetServiceImpl {
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	
	@Resource
	public void setCustomerInfromStaSetManageImpl(
			CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl) {
		this.customerInfromStaSetManageImpl = customerInfromStaSetManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	
	/**
	 * 功能描述：查询统计项目
	 * @param enterprise
	 * @return
	 */
	public List<CustomerInfromStaSet> queryByCustomerInfromStaSetByEntparseId(Enterprise enterprise){
		updateCustomerInfromSTaSet(enterprise);
		String sql="select * from sta_CustomerInfromStaSet where staStatus=1 AND enterpriseId="+enterprise.getDbid()+" group by codeNum";
		List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetManageImpl.executeSql(sql, null);
		return customerInfromStaSets;
	}
	/**
	 * 功能描述：查询编辑客户数据
	 * @param enterprise
	 * @return
	 */
	public List<CustomerInfromStaSet> queryByCustomerInfromSatSetByEntparseId(Enterprise enterprise){
		String sql="select * from sta_CustomerInfromStaSet where AND enterpriseId="+enterprise.getDbid();
		List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetManageImpl.executeSql(sql, null);
		return customerInfromStaSets;
	}
	
	private void updateCustomerInfromSTaSet(Enterprise enterprise){
		List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetManageImpl.findBy("enterpriseId", enterprise.getDbid());
		List<CustomerInfrom> customerInfroms = customerInfromManageImpl.findBy("parent.dbid",4);
		if(null==customerInfromStaSets||customerInfromStaSets.isEmpty()){
			customerInfromStaSets=new ArrayList<CustomerInfromStaSet>();
			for (CustomerInfrom customerInfrom : customerInfroms) {
				CustomerInfromStaSet customerInfromStaSet=new CustomerInfromStaSet(customerInfrom, enterprise);
				customerInfromStaSetManageImpl.save(customerInfromStaSet);
			}
		}else{
			if(customerInfroms.size()!=customerInfromStaSets.size()){
				List<CustomerInfrom> tempCustomerInfroms=new ArrayList<CustomerInfrom>();
				for (CustomerInfrom customerInfrom : customerInfroms) {
					boolean status=false;
					for (CustomerInfromStaSet customerInfromStaSet : customerInfromStaSets) {
						if(customerInfrom.getDbid()==(int)customerInfromStaSet.getCustomerInfrom().getDbid()){
							status=true;
							break;
						}
					}
					if(status==false){
						tempCustomerInfroms.add(customerInfrom);
					}
				}
				if(tempCustomerInfroms.size()>0){
					for (CustomerInfrom customerInfrom : tempCustomerInfroms) {
						CustomerInfromStaSet customerInfromStaSet=new CustomerInfromStaSet(customerInfrom, enterprise);
						customerInfromStaSetManageImpl.save(customerInfromStaSet);
						customerInfromStaSets.add(customerInfromStaSet);
					}
				}
			}
		}
	}
	
	
	
}
