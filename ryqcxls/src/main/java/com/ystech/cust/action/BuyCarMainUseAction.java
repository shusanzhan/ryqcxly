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
import com.ystech.cust.model.BuyCarMainUse;
import com.ystech.cust.service.BuyCarMainUseManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("buyCarMainUseAction")
@Scope("prototype")
public class BuyCarMainUseAction extends BaseController{
	private BuyCarMainUse buyCarMainUse;
	private BuyCarMainUseManageImpl buyCarMainUseManageImpl;
	public BuyCarMainUse getBuyCarMainUse() {
		return buyCarMainUse;
	}
	public void setBuyCarMainUse(BuyCarMainUse buyCarMainUse) {
		this.buyCarMainUse = buyCarMainUse;
	}
	public BuyCarMainUseManageImpl getBuyCarMainUseManageImpl() {
		return buyCarMainUseManageImpl;
	}
	@Resource
	public void setBuyCarMainUseManageImpl(
			BuyCarMainUseManageImpl buyCarMainUseManageImpl) {
		this.buyCarMainUseManageImpl = buyCarMainUseManageImpl;
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
		Page<BuyCarMainUse> page=null;
		if(null!=username&&username.trim().length()>0){
			page = buyCarMainUseManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarMainUse.class, "select * from cust_BuyCarMainUse where name like '%"+username+"%'", new Object[]{});
		}else{
			page = buyCarMainUseManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarMainUse.class, "select * from cust_BuyCarMainUse  ", new Object[]{});
		}
		request.setAttribute("page", page);
		return "list";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		System.out.println("=========");
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
			BuyCarMainUse buyCarMainUse2 = buyCarMainUseManageImpl.get(dbid);
			request.setAttribute("buyCarMainUse", buyCarMainUse2);
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
				buyCarMainUseManageImpl.save(buyCarMainUse);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/buyCarMainUse/queryList", "保存数据成功！");
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
						buyCarMainUseManageImpl.deleteById(dbid);
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
		renderMsg("/buyCarMainUse/queryList"+query, "删除数据成功！");
		return;
	}

}
