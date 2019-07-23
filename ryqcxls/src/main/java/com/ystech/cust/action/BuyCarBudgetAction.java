/**
 * 
 */
package com.ystech.cust.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.BuyCarBudget;
import com.ystech.cust.service.BuyCarBudgetManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("buyCarBudgetAction")
@Scope("prototype")
public class BuyCarBudgetAction extends BaseController{
	private BuyCarBudget buyCarBudget;
	private BuyCarBudgetManageImpl buyCarBudgetManageImpl;
	public BuyCarBudget getBuyCarBudget() {
		return buyCarBudget;
	}
	public void setBuyCarBudget(BuyCarBudget buyCarBudget) {
		this.buyCarBudget = buyCarBudget;
	}
	public BuyCarBudgetManageImpl getBuyCarBudgetManageImpl() {
		return buyCarBudgetManageImpl;
	}
	@Resource
	public void setBuyCarBudgetManageImpl(
			BuyCarBudgetManageImpl buyCarBudgetManageImpl) {
		this.buyCarBudgetManageImpl = buyCarBudgetManageImpl;
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
			Page<BuyCarBudget> page=null;
			if(null!=username&&username.trim().length()>0){
				page = buyCarBudgetManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarBudget.class, "select * from cust_BuyCarBudget where name like '%"+username+"%'", new Object[]{});
			}else{
				page = buyCarBudgetManageImpl.pagedQuerySql(pageNo, pageSize, BuyCarBudget.class," select * from cust_BuyCarBudget  ", new Object[]{});
			}
			request.setAttribute("page", page);
		} catch (Exception e) {
			// TODO: handle exception
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
		if(dbid>0){
			BuyCarBudget buyCarBudget2 = buyCarBudgetManageImpl.get(dbid);
			request.setAttribute("buyCarBudget", buyCarBudget2);
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
				buyCarBudgetManageImpl.save(buyCarBudget);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/buyCarBudget/queryList", "保存数据成功！");
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
						buyCarBudgetManageImpl.deleteById(dbid);
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
		renderMsg("/buyCarBudget/queryList"+query, "删除数据成功！");
		return;
	}

}
