package com.ystech.cust.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerRecordSet;
import com.ystech.cust.service.CustomerRecordSetManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("customerRecordSetAction")
@Scope("prototype")
public class CustomerRecordSetAction extends BaseController{
	private CustomerRecordSet customerRecordSet;
	private CustomerRecordSetManageImpl customerRecordSetManageImpl;
	
	/**
	 * @return the customerRecordSet
	 */
	public CustomerRecordSet getCustomerRecordSet() {
		return customerRecordSet;
	}
	/**
	 * @param customerRecordSet the customerRecordSet to set
	 */
	public void setCustomerRecordSet(CustomerRecordSet customerRecordSet) {
		this.customerRecordSet = customerRecordSet;
	}
	@Resource
	public void setCustomerRecordSetManageImpl(
			CustomerRecordSetManageImpl customerRecordSetManageImpl) {
		this.customerRecordSetManageImpl = customerRecordSetManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CustomerRecordSet> customerRecordSets = customerRecordSetManageImpl.getAll();
			if(null!=customerRecordSets&&customerRecordSets.size()>0){
				request.setAttribute("customerRecordSet", customerRecordSets.get(0));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = customerRecordSet.getDbid();
			customerRecordSet.setEnterpriseId(enterprise.getDbid());
			if(null==dbid||dbid<=0){
				customerRecordSet.setCreateDate(new Date());
				customerRecordSet.setModifyDate(new Date());
			}else{
				customerRecordSet.setModifyDate(new Date());
			}
			customerRecordSetManageImpl.save(customerRecordSet);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerRecordSet/edit", "设置成功！");
		return;
	}
}
