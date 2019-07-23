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
import com.ystech.cust.model.Industry;
import com.ystech.cust.service.IndustryManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;


/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("industryAction")
@Scope("prototype")
public class IndustryAction extends BaseController{
	private Industry industry;
	private IndustryManageImpl industryManageImpl;
	private BrandManageImpl brandManageImpl;
	public Industry getIndustry() {
		return industry;
	}
	public void setIndustry(Industry industry) {
		this.industry = industry;
	}
	public IndustryManageImpl getIndustryManageImpl() {
		return industryManageImpl;
	}
	@Resource
	public void setIndustryManageImpl(IndustryManageImpl industryManageImpl) {
		this.industryManageImpl = industryManageImpl;
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
		String username = request.getParameter("name");
		Page<Industry> page=null;
		if(null!=username&&username.trim().length()>0){
			page = industryManageImpl.pagedQuerySql(pageNo, pageSize,Industry.class, "select * from cust_Industry where name like '%"+username+"%'", new Object[]{});
		}else{
			page = industryManageImpl.pagedQuerySql(pageNo, pageSize,Industry.class, "select * from cust_Industry   ", new Object[]{});
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
			 Industry industry2 = industryManageImpl.get(dbid);
			request.setAttribute("industry", industry2);
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
			Brand brand = brandManageImpl.get(brandId);
			industry.setBrand(brand);
			industryManageImpl.save(industry);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/industry/queryList", "保存数据成功！");
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
					industryManageImpl.deleteById(dbid);
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
		renderMsg("/industry/queryList"+query, "删除数据成功！");
		return;
	}

	
}
