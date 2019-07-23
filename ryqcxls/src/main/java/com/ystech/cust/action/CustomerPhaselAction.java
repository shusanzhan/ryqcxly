/**
 * 
 */
package com.ystech.cust.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.service.CustomerPhaseManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("customerPhaseAction")
@Scope("prototype")
public class CustomerPhaselAction extends BaseController{
	private CustomerPhase customerPhase;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	
	public CustomerPhase getCustomerPhase() {
		return customerPhase;
	}

	public void setCustomerPhase(CustomerPhase customerPhase) {
		this.customerPhase = customerPhase;
	}

	public CustomerPhaseManageImpl getCustomerPhaseManageImpl() {
		return customerPhaseManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
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
		String username = request.getParameter("name");
		try {
			String sql="select * from cust_CustomerPhase where 1=1 ";
			List params=new ArrayList();
			if(null!=username&&username.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+username+"%");
			}
			Page page = customerPhaseManageImpl.pagedQuerySql(pageNo, pageSize,CustomerPhase.class,sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			// TODO: handle exception
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
		try {
			if(dbid>0){
				CustomerPhase customerPhase = customerPhaseManageImpl.get(dbid);
				request.setAttribute("customerPhase", customerPhase);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
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
		//slide.setBussiId(currentBussi);
		try{
			customerPhaseManageImpl.save(customerPhase);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerPhase/queryList", "保存数据成功！");
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
					customerPhaseManageImpl.deleteById(dbid);
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
		renderMsg("/customerPhase/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajax() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerPhase customerPhase2 = customerPhaseManageImpl.get(dbid);
			if(customerPhase2.getType()==(int)CustomerPhase.TYPESHOW){
				Integer trackDay = customerPhase2.getTrackDay();
				if(null!=trackDay&&trackDay>0){
					renderText(trackDay+"");
					return ;
				}else{
					renderText("0");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderText("0");
		return;
	}

}
