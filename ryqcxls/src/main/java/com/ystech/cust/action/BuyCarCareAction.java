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
import com.ystech.cust.model.BuyCarCare;
import com.ystech.cust.service.BuyCarCareManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("buyCarCareAction")
@Scope("prototype")
public class BuyCarCareAction extends BaseController{
	private BuyCarCare buyCarCare;
	private BuyCarCareManageImpl buyCarCareManageImpl;
	public BuyCarCare getBuyCarCare() {
		return buyCarCare;
	}
	public void setBuyCarCare(BuyCarCare buyCarCare) {
		this.buyCarCare = buyCarCare;
	}
	public BuyCarCareManageImpl getBuyCarCareManageImpl() {
		return buyCarCareManageImpl;
	}
	@Resource
	public void setBuyCarCareManageImpl(BuyCarCareManageImpl buyCarCareManageImpl) {
		this.buyCarCareManageImpl = buyCarCareManageImpl;
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
			Page<BuyCarCare> page=null;
			if(null!=username&&username.trim().length()>0){
				page = buyCarCareManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarCare.class, "select * from cust_BuyCarCare where name like '%"+username+"%'", new Object[]{});
			}else{
				page = buyCarCareManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarCare.class, "select * from cust_BuyCarCare  ", new Object[]{});
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
			BuyCarCare buyCarCare = buyCarCareManageImpl.get(dbid);
			request.setAttribute("buyCarCare", buyCarCare);
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
				buyCarCareManageImpl.save(buyCarCare);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/buyCarCare/queryList", "保存数据成功！");
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
						buyCarCareManageImpl.deleteById(dbid);
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
		renderMsg("/buyCarCare/queryList"+query, "删除数据成功！");
		return;
	}

	
}
