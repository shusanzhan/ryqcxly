/**
 * 
 */
package com.ystech.cust.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.ProductCategory;
import com.ystech.cust.service.ProductCategoryManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;

/**
 * @author shusanzhan
 * @date 2014-1-8
 */
@Component("productCategoryAction")
@Scope("prototype")
public class ProductCategoryAction extends BaseController{
	private ProductCategory productCategory;
	private ProductCategoryManageImpl productCategoryManageImpl;
	private BrandManageImpl brandManageImpl;
	public ProductCategory getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setProductCategoryManageImpl(
			ProductCategoryManageImpl productCategoryManageImpl) {
		this.productCategoryManageImpl = productCategoryManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<ProductCategory>	productCategories = productCategoryManageImpl.find("from ProductCategory where enterpriseId=? and parent.dbid IS NULL", new Object[]{enterprise.getDbid()});
			request.setAttribute("productCategories", productCategories);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(),null);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
		}catch (Exception e) {
			log.error(e);
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			if(dbid>0){
				ProductCategory productCategory2 = productCategoryManageImpl.get(dbid);
				String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(),productCategory2.getParent());
				request.setAttribute("productCateGorySelect", productCateGorySelect);
				request.setAttribute("productCategory", productCategory2);
			}else{
				String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(),null);
				request.setAttribute("productCateGorySelect", productCateGorySelect);
			}
			
		}catch (Exception e) {
			log.error(e);
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
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parendId = ParamUtil.getIntParam(request, "parentId", -1);
		Integer[] brandIds = ParamUtil.getIntArray(request, "brandDbids");
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		if(parendId>-1){
			try{
				ProductCategory parent=null;
				if(parendId>0){
					parent = productCategoryManageImpl.get(parendId);
					productCategory.setParent(parent);
				}
				productCategory.setEnterpriseId(enterprise.getDbid());
				//绑定品牌与类型的关系
				/*brandes.clear();
				if(null!=brandIds&&brandIds.length>0){
					for (Integer brandId : brandIds) {
						Brand brand = brandManageImpl.get(brandId);
						brandes.add(brand);
					}
				}*/
				//第一添加数据 保存
				if(null==productCategory.getDbid()||productCategory.getDbid()<=0)
				{
					productCategory.setModifyTime(new Date());
					productCategory.setCreateTime(new Date());
					//productCategory.setBrands(brandes);
					productCategoryManageImpl.save(productCategory);
				}else{
					//修改时保存数据
					ProductCategory productCategory2 = productCategoryManageImpl.get(productCategory.getDbid());
					productCategory2.setModifyTime(new Date());
					productCategory2.setName(productCategory.getName());
					productCategory2.setOrderNum(productCategory.getOrderNum());
					productCategory2.setParent(productCategory.getParent());
					//productCategory2.setBrands(brandes);
					productCategoryManageImpl.save(productCategory2);
				}
				
			}catch (Exception e) {
				log.error(e);
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("系统异常！"), "");
			return;
		}
		renderMsg("/productCategory/queryList", "保存数据成功！");
		return ;
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
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(null!=dbid&&dbid>0){
			try {
					List<ProductCategory> childs = productCategoryManageImpl.findBy("parent.dbid", dbid);
					if(null!=childs&&childs.size()>0){
						renderErrorMsg(new Throwable("该数据有子级分类，请先删除子级分类在删除数据！"), "");
						return ;
					}else{
						productCategoryManageImpl.deleteById(dbid);
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
		renderMsg("/productCategory/queryList"+query, "删除数据成功！");
		return;
	}
	
}
