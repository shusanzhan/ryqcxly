package com.ystech.cust.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerRecordClubInvalidReason;
import com.ystech.cust.service.CustomerRecordClubInvalidReasonManageImpl;

@Component("customerRecordClubInvalidReasonAction")
@Scope("prototype")
public class CustomerRecordClubInvalidReasonAction extends BaseController{
	private CustomerRecordClubInvalidReason customerRecordClubInvalidReason;
	private CustomerRecordClubInvalidReasonManageImpl customerRecordClubInvalidReasonManageImpl;
	
	public CustomerRecordClubInvalidReason getCustomerRecordClubInvalidReason() {
		return customerRecordClubInvalidReason;
	}

	public void setCustomerRecordClubInvalidReason(
			CustomerRecordClubInvalidReason customerRecordClubInvalidReason) {
		this.customerRecordClubInvalidReason = customerRecordClubInvalidReason;
	}
	@Resource
	public void setCustomerRecordClubInvalidReasonManageImpl(
			CustomerRecordClubInvalidReasonManageImpl customerRecordClubInvalidReasonManageImpl) {
		this.customerRecordClubInvalidReasonManageImpl = customerRecordClubInvalidReasonManageImpl;
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
			 Page<CustomerRecordClubInvalidReason> page= customerRecordClubInvalidReasonManageImpl.pagedQuerySql(pageNo, pageSize,CustomerRecordClubInvalidReason.class, "select * from cust_CustomerRecordClubInvalidReason", new Object[]{});
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
			CustomerRecordClubInvalidReason customerRecordClubInvalidReason2 = customerRecordClubInvalidReasonManageImpl.get(dbid);
			request.setAttribute("customerRecordClubInvalidReason", customerRecordClubInvalidReason2);
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
			Integer dbid = customerRecordClubInvalidReason.getDbid();
			if(dbid==null||dbid<=0){
				customerRecordClubInvalidReason.setCreateDate(new Date());
				customerRecordClubInvalidReason.setModifyDate(new Date());
				customerRecordClubInvalidReasonManageImpl.save(customerRecordClubInvalidReason);
			}else{
				customerRecordClubInvalidReason.setModifyDate(new Date());
				customerRecordClubInvalidReasonManageImpl.save(customerRecordClubInvalidReason);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerRecordClubInvalidReason/queryList", "保存数据成功！");
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
					customerRecordClubInvalidReasonManageImpl.deleteById(dbid);
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
		renderMsg("/customerRecordClubInvalidReason/queryList"+query, "删除数据成功！");
		return;
	}
	
}
