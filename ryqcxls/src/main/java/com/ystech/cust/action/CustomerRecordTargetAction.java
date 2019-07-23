package com.ystech.cust.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerRecordTarget;
import com.ystech.cust.service.CustomerRecordTargetManageImpl;

@Component("customerRecordTargetAction")
@Scope("prototype")
public class CustomerRecordTargetAction extends BaseController{
	private CustomerRecordTarget customerRecordTarget;
	private CustomerRecordTargetManageImpl customerRecordTargetManageImpl;
	public CustomerRecordTarget getCustomerRecordTarget() {
		return customerRecordTarget;
	}
	public void setCustomerRecordTarget(CustomerRecordTarget customerRecordTarget) {
		this.customerRecordTarget = customerRecordTarget;
	}
	@Resource
	public void setCustomerRecordTargetManageImpl(
			CustomerRecordTargetManageImpl customerRecordTargetManageImpl) {
		this.customerRecordTargetManageImpl = customerRecordTargetManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String username = request.getParameter("title");
		try{
			 Page<CustomerRecordTarget> page= customerRecordTargetManageImpl.pagedQuerySql(pageNo, pageSize,CustomerRecordTarget.class, "select * from cust_CustomerRecordTarget", new Object[]{});
			 request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustomerRecordTarget customerRecordTarget2 = customerRecordTargetManageImpl.get(dbid);
			request.setAttribute("customerRecordTarget", customerRecordTarget2);
		}
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Integer dbid = customerRecordTarget.getDbid();
			if(dbid==null||dbid<=0){
				customerRecordTarget.setCreateDate(new Date());
				customerRecordTarget.setModifyDate(new Date());
				customerRecordTargetManageImpl.save(customerRecordTarget);
			}else{
				customerRecordTargetManageImpl.save(customerRecordTarget);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerRecordTarget/queryList", "保存数据成功！");
		return ;
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
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
					customerRecordTargetManageImpl.deleteById(dbid);
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
		renderMsg("/customerRecordTarget/queryList"+query, "删除数据成功！");
		return;
	}
	
}
