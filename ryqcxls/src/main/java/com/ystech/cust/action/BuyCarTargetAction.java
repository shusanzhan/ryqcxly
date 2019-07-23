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
import com.ystech.cust.model.BuyCarTarget;
import com.ystech.cust.service.BuyCarTargetManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("buyCarTargetAction")
@Scope("prototype")
public class BuyCarTargetAction extends BaseController {
	private BuyCarTarget buyCarTarget;
	private BuyCarTargetManageImpl buyCarTargetManageImpl;
	public BuyCarTarget getBuyCarTarget() {
		return buyCarTarget;
	}
	public void setBuyCarTarget(BuyCarTarget buyCarTarget) {
		this.buyCarTarget = buyCarTarget;
	}
	public BuyCarTargetManageImpl getBuyCarTargetManageImpl() {
		return buyCarTargetManageImpl;
	}
	@Resource
	public void setBuyCarTargetManageImpl(
			BuyCarTargetManageImpl buyCarTargetManageImpl) {
		this.buyCarTargetManageImpl = buyCarTargetManageImpl;
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
		Page<BuyCarTarget> page=null;
		if(null!=username&&username.trim().length()>0){
			page = buyCarTargetManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarTarget.class, "select * from cust_BuyCarTarget where name like '%"+username+"%'", new Object[]{});
		}else{
			page = buyCarTargetManageImpl.pagedQuerySql(pageNo, pageSize,BuyCarTarget.class, "select * from cust_BuyCarTarget  ", new Object[]{});
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
		System.out.println("=====");
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
			BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(dbid);
			request.setAttribute("buyCarTarget", buyCarTarget);
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
				buyCarTargetManageImpl.save(buyCarTarget);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/buyCarTarget/queryList", "保存数据成功！");
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
						buyCarTargetManageImpl.deleteById(dbid);
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
		renderMsg("/buyCarTarget/queryList"+query, "删除数据成功！");
		return;
	}
}
