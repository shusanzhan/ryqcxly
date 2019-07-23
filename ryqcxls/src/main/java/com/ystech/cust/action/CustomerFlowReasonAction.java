/**
 * 
 */
package com.ystech.cust.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerFlowReason;
import com.ystech.cust.service.CustomerFlowReasonManageImpl;

/**
 * @author shusanzhan
 * @date 2014-1-16
 */
@Component("customerFlowReasonAction")
@Scope("prototype")
public class CustomerFlowReasonAction extends BaseController{
	private CustomerFlowReason customerFlowReason;
	private CustomerFlowReasonManageImpl customerFlowReasonManageImpl;
	


	public CustomerFlowReason getCustomerFlowReason() {
		return customerFlowReason;
	}

	public void setCustomerFlowReason(CustomerFlowReason customerFlowReason) {
		this.customerFlowReason = customerFlowReason;
	}

	public CustomerFlowReasonManageImpl getCustomerFlowReasonManageImpl() {
		return customerFlowReasonManageImpl;
	}
	@Resource
	public void setCustomerFlowReasonManageImpl(
			CustomerFlowReasonManageImpl customerFlowReasonManageImpl) {
		this.customerFlowReasonManageImpl = customerFlowReasonManageImpl;
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		try{
			HttpServletRequest request = this.getRequest();
			Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
			Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
			String name = request.getParameter("name");
			SecurityUserHolder securityUserHolder=new SecurityUserHolder();
			try {
				Page<CustomerFlowReason> page=null;
				if(null!=name&&name.trim().length()>0){
					page = customerFlowReasonManageImpl.pagedQuerySql(pageNo, pageSize,CustomerFlowReason.class, "select * from cust_CustomerFlowReason where   name like '%"+name+"%'", new Object[]{});
				}else{
					page = customerFlowReasonManageImpl.pagedQuerySql(pageNo, pageSize, CustomerFlowReason.class,"select * from cust_CustomerFlowReason  ", new Object[]{});
				}
				request.setAttribute("page", page);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "edit";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustomerFlowReason customerFlowReason = customerFlowReasonManageImpl.get(dbid);
			request.setAttribute("customerFlowReason", customerFlowReason);
		}
		return "edit";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		try{
			Integer dbid = customerFlowReason.getDbid();
			if(dbid==null||dbid<=0){
				customerFlowReason.setCreateDate(new Date());
				customerFlowReason.setModifyDate(new Date());
				
			}else{
				customerFlowReason.setModifyDate(new Date());
			}
			customerFlowReasonManageImpl.save(customerFlowReason);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerFlowReason/queryList", "保存数据成功！");
		return ;
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					//删除数据时判断是否有会员在使用
					customerFlowReasonManageImpl.deleteById(dbid);
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("未选中数据！"), "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/customerFlowReason/queryList"+query, "删除数据成功！");
		return;
	}
}
