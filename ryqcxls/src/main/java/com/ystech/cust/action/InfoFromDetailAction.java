/**
 * 
 */
package com.ystech.cust.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.InfoFromDetail;
import com.ystech.cust.service.InfoFromDetailManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("infoFromDetailAction")
@Scope("prototype")
public class InfoFromDetailAction extends BaseController{
	private InfoFromDetail infoFromDetail;
	private InfoFromDetailManageImpl infoFromDetailManageImpl;


	public InfoFromDetail getInfoFromDetail() {
		return infoFromDetail;
	}

	public void setInfoFromDetail(InfoFromDetail infoFromDetail) {
		this.infoFromDetail = infoFromDetail;
	}

	public InfoFromDetailManageImpl getInfoFromDetailManageImpl() {
		return infoFromDetailManageImpl;
	}
	@Resource
	public void setInfoFromDetailManageImpl(
			InfoFromDetailManageImpl infoFromDetailManageImpl) {
		this.infoFromDetailManageImpl = infoFromDetailManageImpl;
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
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Page<InfoFromDetail> page=null;
			if(null!=username&&username.trim().length()>0){
				page = infoFromDetailManageImpl.pagedQuerySql(pageNo, pageSize,InfoFromDetail.class, "select * from cust_InfoFromDetail where enterpriseId=? and name like '%"+username+"%'", new Object[]{enterprise.getDbid()});
			}else{
				page = infoFromDetailManageImpl.pagedQuerySql(pageNo, pageSize,InfoFromDetail.class, "select * from cust_InfoFromDetail where enterpriseId=?", new Object[]{enterprise.getDbid()});
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
			InfoFromDetail infoFromDetail = infoFromDetailManageImpl.get(dbid);
			request.setAttribute("infoFromDetail", infoFromDetail);
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
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		try{
			infoFromDetail.setEnterpriseId(enterprise.getDbid());
			infoFromDetailManageImpl.save(infoFromDetail);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/infoFromDetail/queryList", "保存数据成功！");
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
					infoFromDetailManageImpl.deleteById(dbid);
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
		renderMsg("/infoFromDetail/queryList"+query, "删除数据成功！");
		return;
	}
}
