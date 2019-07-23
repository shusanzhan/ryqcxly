/**
 * 
 */
package com.ystech.cust.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.InfoFrom;
import com.ystech.cust.service.InfoFromManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("infoFromAction")
@Scope("prototype")
public class InfoFromAction extends BaseController{
	private InfoFrom infoFrom;
	private InfoFromManageImpl infoFromManageImpl;
	private BrandManageImpl brandManageImpl;

	public InfoFrom getInfoFrom() {
		return infoFrom;
	}

	public void setInfoFrom(InfoFrom infoFrom) {
		this.infoFrom = infoFrom;
	}

	public InfoFromManageImpl getInfoFromManageImpl() {
		return infoFromManageImpl;
	}
	@Resource
	public void setInfoFromManageImpl(InfoFromManageImpl infoFromManageImpl) {
		this.infoFromManageImpl = infoFromManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
			Page<InfoFrom> page=null;
			if(null!=username&&username.trim().length()>0){
				page = infoFromManageImpl.pagedQuerySql(pageNo, pageSize,InfoFrom.class, "select * from cust_InfoFrom where enterpriseId=? and name like '%"+username+"%'", new Object[]{enterprise.getDbid()});
			}else{
				page = infoFromManageImpl.pagedQuerySql(pageNo, pageSize,InfoFrom.class, "select * from cust_InfoFrom  where enterpriseId=?", new Object[]{enterprise.getDbid()});
			}
			request.setAttribute("page", page);
		} catch (Exception e) {
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
		HttpServletRequest request = this.getRequest();
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
		request.setAttribute("brands", brands);
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
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
		request.setAttribute("brands", brands);
		if(dbid>0){
			InfoFrom infoFrom = infoFromManageImpl.get(dbid);
			request.setAttribute("infoFrom", infoFrom);
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
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Brand brand = brandManageImpl.get(brandId);
			infoFrom.setBrand(brand);
			infoFrom.setEnterpriseId(enterprise.getDbid());
			infoFromManageImpl.save(infoFrom);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/infoFrom/queryList", "保存数据成功！");
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
					infoFromManageImpl.deleteById(dbid);
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
		renderMsg("/infoFrom/queryList"+query, "删除数据成功！");
		return;
	}
}
