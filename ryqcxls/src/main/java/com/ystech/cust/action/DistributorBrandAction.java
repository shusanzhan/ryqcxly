/**
 * 
 */
package com.ystech.cust.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.DistributorBrand;
import com.ystech.cust.service.DistributorBrandManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;

/**
 * @author shusanzhan
 * @date 2014-8-16
 */
@Component("distributorBrandAction")
@Scope("prototype")
public class DistributorBrandAction extends BaseController {
	private DistributorBrand distributorBrand;
	private DistributorBrandManageImpl distributorBrandManageImpl;
	private BrandManageImpl brandManageImpl;
	
	public DistributorBrand getDistributorBrand() {
		return distributorBrand;
	}
	public void setDistributorBrand(DistributorBrand distributorBrand) {
		this.distributorBrand = distributorBrand;
	}
	@Resource
	public void setDistributorBrandManageImpl(
			DistributorBrandManageImpl distributorBrandManageImpl) {
		this.distributorBrandManageImpl = distributorBrandManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}

	private HttpServletRequest request=getRequest();
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		Integer distributorId = ParamUtil.getIntParam(request, "distributorId", -1);
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		int size=0;
		try{
			List<DistributorBrand> distributorBrands = distributorBrandManageImpl.findBy("distributorId", distributorId);
			if(null!=distributorBrands){
				size = distributorBrands.size();
				request.setAttribute("distributorBrands", distributorBrands);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(size>=1){
			return "list";
		}else{
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			return "edit";
		}
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		try{
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			if(brandId>0){
				Brand brand = brandManageImpl.get(brandId);
				distributorBrand.setBrand(brand);
				distributorBrand.setBrandName(brand.getName());
			}
			distributorBrandManageImpl.save(distributorBrand);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributorBrand/queryList?distributorId="+distributorBrand.getDistributorId(), "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
		request.setAttribute("brands", brands);
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			if(dbid>0){
				DistributorBrand distributorBrand2 = distributorBrandManageImpl.get(dbid);
				request.setAttribute("distributorBrand", distributorBrand2);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request,"dbids",-1);
		try {
				if(dbid>0){
					DistributorBrand distributorBrand2 = distributorBrandManageImpl.get(dbid);
					distributorBrandManageImpl.deleteById(dbid);
					renderMsg("/distributorBrand/queryList?distributorId="+distributorBrand2.getDistributorId(), "删除数据成功！");
					return;
				}else{
					renderErrorMsg(new Throwable("未选中删除数据！"), "");
					return ;
				}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		
	}
}
