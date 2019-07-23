/**
 * 
 */
package com.ystech.cust.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Product;
import com.ystech.cust.model.ProductCategory;
import com.ystech.cust.service.ProductCategoryManageImpl;
import com.ystech.cust.service.ProductManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-20
 * 
 */
@Component("productAction")
@Scope("prototype")
public class ProductAction extends BaseController{
	private Product product;
	private ProductManageImpl productManageImpl;
	private ProductCategoryManageImpl productCategoryManageImpl;
	private BrandManageImpl brandManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	@Resource
	public void setProductManageImpl(ProductManageImpl productManageImpl) {
		this.productManageImpl = productManageImpl;
	}
	@Resource
	public void setProductCategoryManageImpl(
			ProductCategoryManageImpl productCategoryManageImpl) {
		this.productCategoryManageImpl = productCategoryManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
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
		String name = request.getParameter("name");
		String sn = request.getParameter("sn");
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer categoryId = ParamUtil.getIntParam(request, "categoryId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql = "select * from cust_Product  where 1=1 ";
			List param = new ArrayList();
			sql = sql + " and type = ?";
			sql = sql + " and stopStatus = ?";
			param.add(Product.TYPEPRODCUT);
			param.add(Product.STOPCOMM);
			sql = sql + " and enterpriseId ="+enterprise.getDbid();
			if (null != name && name.trim().length() > 0) {
				sql = sql + " and name like ? ";
				param.add("%" + name + "%");
			}
			if (null != sn && sn.trim().length() > 0) {
				sql = sql + " and sn like ? ";
				param.add("%" + sn + "%");
			}
			if (null != brandId && brandId > 0) {
				sql = sql + " and brandIds like '%"+brandId+",%'";
			}
			if (null != categoryId && categoryId > 0) {
				sql = sql + " and productCategoryId = ?";
				param.add(categoryId);
			}
			Page<Product> page=productManageImpl.pagedQuerySql(pageNo, pageSize,Product.class,sql,param.toArray());
			//下来选择商品类型
			ProductCategory productCategory=productCategoryManageImpl.get(categoryId);
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(), productCategory);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
			//选择上品牌品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			request.setAttribute("page", page);
		}catch (Exception e) {
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
	@SuppressWarnings("unchecked")
	public String querySalerList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer categoryId = ParamUtil.getIntParam(request, "categoryId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql = "select * from cust_Product  where 1=1 ";
			List param = new ArrayList();
			sql = sql + " and type = ?";
			sql = sql + " and stopStatus = ?";
			param.add(Product.TYPEPRODCUT);
			param.add(Product.STOPCOMM);
			sql = sql + " and enterpriseIds LIKE '%"+enterprise.getDbid()+",%' ";
			if (null != name && name.trim().length() > 0) {
				sql = sql + " and name like ? ";
				param.add("%" + name + "%");
			}
			if (null != brandId && brandId > 0) {
				sql = sql + " and brandIds like '%"+brandId+",%'";
			}
			if (null != categoryId && categoryId > 0) {
				sql = sql + " and productCategoryId = ?";
				param.add(categoryId);
			}
			Page<Product> page=productManageImpl.pagedQuerySql(pageNo, pageSize,Product.class,sql,param.toArray());
			//下来选择商品类型
			ProductCategory productCategory=productCategoryManageImpl.get(categoryId);
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(), productCategory);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
			//选择上品牌品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			request.setAttribute("page", page);
		}catch (Exception e) {
		}
		return "salerList";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryStopList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer categoryId = ParamUtil.getIntParam(request, "categoryId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql = "select * from cust_Product  where 1=1 ";
			List param = new ArrayList();
			sql = sql + " and type = ?";
			sql = sql + " and stopStatus = ?";
			param.add(Product.TYPEPRODCUT);
			param.add(Product.STOPYEAS);
			sql = sql + " and enterpriseId ="+enterprise.getDbid();
			if (null != name && name.trim().length() > 0) {
				sql = sql + " and name like ? ";
				param.add("%" + name + "%");
			}
			if (null != brandId && brandId > 0) {
				sql = sql + " and brandIds like '%"+brandId+",%'";
			}
			if (null != categoryId && categoryId > 0) {
				sql = sql + " and productCategoryId = ?";
				param.add(categoryId);
			}
			Page<Product> page=productManageImpl.pagedQuerySql(pageNo, pageSize,Product.class,sql,param.toArray());
			//下来选择商品类型
			ProductCategory productCategory=productCategoryManageImpl.get(categoryId);
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(enterprise.getDbid(), productCategory);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
			//选择上品牌品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			request.setAttribute("page", page);
		}catch (Exception e) {
		}
		return "stopList";
	}
	/**
	 * 功能描述：库存预警
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String warmStockNum() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer stockStatus = ParamUtil.getIntParam(request, "stockStatus", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql = "select * from cust_Product  where 1=1 AND enterpriseId=? ";
			List param = new ArrayList();
			param.add(enterprise.getDbid());
			if(stockStatus>0){
				sql = sql + " and stockStatus =?";
				param.add(stockStatus);
			}
			sql = sql + " and type = ?";
			param.add(Product.TYPEPRODCUT);
			sql=sql+ " and stockStatus>? ";
			param.add(Product.STOCKSTATUSCOMM);
			List<Product> products = productManageImpl.executeSql(sql, param.toArray());
			request.setAttribute("products", products);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "warmStockNum";
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
		Integer currentBussi = enterprise.getDbid();
		try{
			//下来选择商品类型
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(currentBussi, null);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
			//选择上品牌品牌
			String brand = getBrand(null);
			request.setAttribute("brandCheck", brand);
			
			String carSeriyIds =enterprise.getDbid()+",";
			String[] dbids = carSeriyIds.split(",");
			String check = getEnterprise(dbids);
			request.setAttribute("check", check);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		Integer currentBussi = enterprise.getDbid();
		if(dbid>0){
		
			//选择上品牌品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			Product product2 = productManageImpl.get(dbid);
			request.setAttribute("product", product2);
			String brandIds = product2.getBrandIds();
			if(null!=brandIds&&brandIds.trim().length()>0){
				String[] split = brandIds.split(",");
				String brand = getBrand(split);
				request.setAttribute("brandCheck", brand);
			}else{
				String brand = getBrand(null);
				request.setAttribute("brandCheck", brand);
			}
			
			String enterpriseIds = product2.getEnterpriseIds();
			String[] dbids = enterpriseIds.split(",");
			String check = getEnterprise(dbids);
			request.setAttribute("check", check);
			//下来选择商品类型
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(currentBussi, product2.getProductcategory());
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
		}
		return "edit";
	}
	/**
	 * 功能描述： 查看商品
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String viewProduct() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "productId", -1);
		try {
			if(dbid>0){
				Product product2 = productManageImpl.get(dbid);
				request.setAttribute("product", product2);
				if(null!=product2){
					if(product2.getType()==2){
						return "viewPackage";
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "viewProduct";
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
		Integer productCategoryDbid = ParamUtil.getIntParam(request, "productCategoryDbid", -1);
		Integer commType = ParamUtil.getIntParam(request, "product.commType", -1);
		String[] parameterValues = request.getParameterValues("enterpriseId");
		String[] brandIds = request.getParameterValues("brandId");
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//****************************商品信息第一次添加保存************************************************//
			if(productCategoryDbid>0){
				ProductCategory productCategory = productCategoryManageImpl.get(productCategoryDbid);
				product.setProductcategory(productCategory);
			}
			if(commType==2){
				if(null==brandIds||brandIds.length<=0){
					renderErrorMsg(new Throwable("请选择可用品牌"), "");
					return ;
				}
			}
			StringBuffer brandIdStr=new StringBuffer();
			StringBuffer brandNamesStr=new StringBuffer();
			for (String brandId : brandIds) {
				if(null!=brandId){
					Brand brand = brandManageImpl.get(Integer.parseInt(brandId));
					brandNamesStr.append(brand.getName()+",");
				}
				brandIdStr.append(brandId+",");
			}
			product.setBrandIds(brandIdStr.toString());
			product.setBrandNames(brandNamesStr.toString());
			String no = product.getSn();
			if(null==no||no.trim().length()<=0){
				no=DateUtil.generatedName(new Date());
				product.setSn(no);
			}
			StringBuffer buffer=new StringBuffer();
			if(null!=parameterValues&&parameterValues.length>0){
				for (String string : parameterValues) {
					
					buffer.append(string+",");
				}
			}else{
				renderErrorMsg(new Throwable("错误：可见范围不能为空"), "");
				return ;
			}
			product.setEnterpriseIds(buffer.toString());
			if(null!=product.getDbid()&&product.getDbid()>0){
				Product product2 = productManageImpl.get(product.getDbid());
				
				product2.setBrandIds(product.getBrandIds());
				product2.setPrice(product.getPrice());
				product2.setCostPrice(product.getCostPrice());
				product2.setIsGift(product.getIsGift());
				product2.setName(product.getName());
				product2.setSn(product.getSn());
				product2.setNote(product.getNote());
				product2.setSpecification(product.getSpecification());
				product2.setProductcategory(product.getProductcategory());
				product2.setIntegral(product.getIntegral());
				product2.setUnit(product.getUnit());
				
				//启用库存
				product2.setIsStock(product.getIsStock());
				product2.setStockNum(product.getStockNum());
				//启用销售追踪记录
				product2.setIsTrack(product.getIsTrack());
				product2.setTrackTimeLong(product.getTrackTimeLong());
				product2.setConstructCostPrice(product.getConstructCostPrice());
				//启用是否是礼物
				product2.setIsGift(product.getIsGift());
				product2.setDeductionScore(product.getDeductionScore());
				//启用是否为提成
				product2.setIsDeductPercentage(product.getIsDeductPercentage());
				product2.setDeductPercert(product.getDeductPercert());
				product2.setNote(product.getNote());
				product2.setSalerCostPrice(product.getSalerCostPrice());
				product2.setStartStockNum(product.getStartStockNum());
				product2.setMaxStockNum(product.getMaxStockNum());
				product2.setMinStockNum(product.getMinStockNum());
				Integer stockNum = product.getStockNum();
				Integer maxStockNum = product.getMaxStockNum();
				Integer minStockNum = product.getMinStockNum();
				product2.setEnterpriseIds(product.getEnterpriseIds());
				product2.setBrandIds(product.getBrandIds());
				product2.setBrandNames(product.getBrandNames());
				product2.setCommType(product.getCommType());
				product2.setStockStatus(Product.STOCKSTATUSCOMM);
				if(stockNum>maxStockNum){
					product2.setStockStatus(Product.STOCKSTATUSMAX);
				}
				if(stockNum<minStockNum){
					product2.setStockStatus(Product.STOCKSTATUSMIN);
				}
				productManageImpl.save(product2);
				
				//更新加装
				BigDecimal costPrice = product2.getCostPrice();
				if(null!=costPrice){
					int price = costPrice.intValue();
				}
			}else{
				//初始化日期
				product.setCreateTime(new Date());
				product.setModifyTime(new Date());
				product.setType(Product.TYPEPRODCUT);
				product.setStopStatus(Product.STOPCOMM);
				product.setEnterpriseId(enterprise.getDbid());
				Integer stockNum = product.getStockNum();
				Integer maxStockNum = product.getMaxStockNum();
				Integer minStockNum = product.getMinStockNum();
				product.setStockStatus(Product.STOCKSTATUSCOMM);
				if(stockNum>maxStockNum){
					product.setStockStatus(Product.STOCKSTATUSMAX);
				}
				if(stockNum<minStockNum){
					product.setStockStatus(Product.STOCKSTATUSMIN);
				}
				productManageImpl.save(product);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/product/queryList?pageSize"+pageSize+"&currentPage="+pageNo, "保存数据成功！");
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
					productManageImpl.deleteById(dbid);
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
		renderMsg("/product/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoProduct() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			String pingyin = request.getParameter("q");
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			List<Product> products=new ArrayList<Product>();
			String sql="select * from cust_Product where enterpriseIds LIKE '%"+enterprise.getDbid()+",%' AND  ((brandIds like '%"+brandId+",%' AND commType=2 ) OR commType=1 ) and (sn like ?  or pingyin like ? or name like ? ) and stopStatus="+Product.STOPCOMM;
			products= productManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%"});
			if(null==products||products.size()<0){
				products = productManageImpl.getAll();
			}
			JSONArray  array=new JSONArray();
			if(null!=products&&products.size()>0){
				for (Product product : products) {
					JSONObject object=new JSONObject();
					object.put("dbid", product.getDbid());
					object.put("name", product.getName());
					object.put("sn", product.getSn());
					object.put("price", product.getPrice());
					object.put("costPrice", product.getCostPrice());
					object.put("unit", product.getUnit());
					//object.put("brand", product.getBrand().getName());
					if(null!=product.getSalerCostPrice()){
						object.put("salerCostPrice", product.getSalerCostPrice());
					}else{
						object.put("salerCostPrice", 0);
					}
					ProductCategory productcategory = product.getProductcategory();
					if(null!=productcategory){
						object.put("productcategoryName", productcategory.getName());
					}else{
						object.put("productcategoryName", "");
					}
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：商品选择
	 * 参数描述：
	 * 逻辑描述：1、套餐选择商品
	 * @return
	 * @throws Exception
	 */
	public String productSelect() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer categoryId = ParamUtil.getIntParam(request, "categoryId", -1);
		String name = request.getParameter("name");		
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		try {
			Integer currentBussi = enterprise.getDbid();
			//下来选择商品类型
			//下来选择商品类型
			String productCateGorySelect = productCategoryManageImpl.getProductCateGorySelect(currentBussi, null);
			request.setAttribute("productCateGorySelect", productCateGorySelect);
			
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			String hql="select * from cust_Product where 1=1 and enterpriseId="+enterprise.getDbid()+" and stopStatus="+Product.STOPCOMM;
			List params=new ArrayList();
			hql=hql+" and type=? ";
			params.add(Product.TYPEPRODCUT);
			if(categoryId>0){
				hql=hql+" and productcategoryId=? ";
				params.add(categoryId);
			}
			if(null!=name&&name.trim().length()>0){
				hql=hql+" and name like ? ";
				params.add("%"+name+"%");
			}
			List<Product> products = productManageImpl.executeSql(hql, params.toArray());
			request.setAttribute("products", products);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "productSelect";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoProductByName() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			List<Product> products=new ArrayList<Product>();
			
			String sql="select * from cust_Product where enterpriseIds LIKE '%"+enterprise.getDbid()+",%' and type="+Product.TYPEPRODCUT+ " and (sn like ?  or pingyin like ? or name like ? ) and stopStatus="+Product.STOPCOMM;
			products= productManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%"});
			if(null==products||products.size()<0){
				products = productManageImpl.getAll();
			}
			JSONArray  array=new JSONArray();
			if(null!=products&&products.size()>0){
				for (Product product : products) {
					JSONObject object=new JSONObject();
					object.put("dbid", product.getDbid());
					object.put("name", product.getName());
					object.put("sn", product.getSn());
					object.put("unit", product.getUnit());
					object.put("productType", product.getProductcategory().getName());
					object.put("price", product.getPrice());
					object.put("costPrice", product.getCostPrice());
					if(null!=product.getSalerCostPrice()){
						object.put("salerCostPrice", product.getSalerCostPrice());
					}else{
						object.put("salerCostPrice", 0);
					}
					/*if(null!=product.getBrand()){
						object.put("brand", product.getBrand().getName());
					}else{
						object.put("brand", "");
					}*/
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：启用或者停用商品
	 */
	public void stopOrStart() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		String query = ParamUtil.getQueryUrl(request);
		Integer stopStatus=1;
		try{
			if(dbid>0){
				Product product2 = productManageImpl.get(dbid);
				stopStatus = product2.getStopStatus();
				if(null!=stopStatus){
					if(stopStatus==1){
						product2.setStopStatus(Product.STOPYEAS);
					}else if(stopStatus==2){
						product2.setStopStatus(Product.STOPCOMM);
					}
				}
				productManageImpl.save(product2);
				
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		if(stopStatus==(int)Product.STOPCOMM){
			renderMsg("/product/queryList"+query, "设置成功！");
		}
		if(stopStatus==(int)Product.STOPYEAS){
			renderMsg("/product/queryStopList"+query, "设置成功！");
		}
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoProductBySale() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
				String pingyin = request.getParameter("q");
				if(null==pingyin||pingyin.trim().length()<0){
					renderJson("1");
					return ;
				}
				User sessionUser = getSessionUser();
				Enterprise enterprise = sessionUser.getEnterprise();
				String sql="select * from isale_purchaseproduct ipur,cust_product pro where pro.dbid=ipur.productId and ipur.finishStatus=1 " +
						"and pro.enterpriseIds LIKE '%"+enterprise.getDbid()+",%' and pro.type="+Product.TYPEPRODCUT+ " " +
						"and (pro.sn like ?  or pro.pingyin like ? or pro.name like ? ) and pro.stopStatus="+Product.STOPCOMM;
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	public void ajaxStockNum(){
		HttpServletRequest request = this.getRequest();
		Integer productId = ParamUtil.getIntParam(request, "productId", -1);
		try {
			if(productId>0){
				Product product2 = productManageImpl.get(productId);
				JSONObject object=new JSONObject();
				String numStr="<span style='font-size: 20px;color: red;margin:0 5px;'>"+product2.getStockNum()+"</span>";
				object.put("stockTip","【"+product2.getName()+"】：当前库存量"+numStr);
				renderJson(object.toString());
			}else{
				renderJson("1");
			}
		} catch (Exception e) {
			// TODO: handle exception
			renderJson("1");
		}
		return ;
	}
	private String getEnterprise(String[] dbids){
		List<Enterprise> enterprises = enterpriseManageImpl.getAll();
		StringBuffer buffer=new StringBuffer();
		if(null!=enterprises&&enterprises.size()>0){
			for (Enterprise enterprise : enterprises) {
				buffer.append("<div style=\"min-width: 80px;float: left;height: 28px\">");
					buffer.append("<label style=\"width: 120px;\">");
					boolean status=false;
					for (String dbid : dbids) {
						if(null!=dbid&&dbid.trim().length()>0){
							int db = Integer.parseInt(dbid);
							if(db==enterprise.getDbid()){
								status=true;
							}
						}
					}
					if(status==false){
						buffer.append("<input type=\"checkbox\" id=\"enterpriseId\" name=\"enterpriseId\" value='"+enterprise.getDbid()+"'>"+enterprise.getName()+"");
					}
					if(status==true){
						buffer.append("<input type=\"checkbox\" id=\"enterpriseId\" name=\"enterpriseId\" checked=\"checked\" value='"+enterprise.getDbid()+"'>"+enterprise.getName()+"");
					}
					buffer.append("</label> ");
				buffer.append("</div> ");
			}
			renderText(buffer.toString());
		}else{
			renderText("error");
		}
		return buffer.toString();
	}
	private String getBrand(String[] dbids){
		StringBuffer buffer=new StringBuffer();
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
		if(null!=brands&&brands.size()>0){
			for (Brand brand : brands) {
				buffer.append("<div style=\"min-width: 80px;float: left;height: 28px\">");
					buffer.append("<label style=\"width: 120px;\">");
					boolean status=false;
					if(null!=dbids){
						for (String dbid : dbids) {
							if(null!=dbid&&dbid.trim().length()>0){
								int db = Integer.parseInt(dbid);
								if(db==brand.getDbid()){
									status=true;
								}
							}
						}
					}
					if(status==false){
						buffer.append("<input type=\"checkbox\" id=\"brandId\" name=\"brandId\" value='"+brand.getDbid()+"'>"+brand.getName()+"");
					}
					if(status==true){
						buffer.append("<input type=\"checkbox\" id=\"brandId\" name=\"brandId\" checked=\"checked\" value='"+brand.getDbid()+"'>"+brand.getName()+"");
					}
					buffer.append("</label> ");
				buffer.append("</div> ");
			}
			renderText(buffer.toString());
		}else{
			renderText("error");
		}
		return buffer.toString();
	}
}
