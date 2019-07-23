/**
 * 
 */
package com.ystech.xwqr.set.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-1-7
 * 品牌管理Action
 */
@Component("userBrandAction")
@Scope("prototype")
public class UserBrandAction extends BaseController{
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private Brand brand;
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}

	public Brand getBrand() {
		return brand;
	}
	public void setBrand(Brand brand) {
		this.brand = brand;
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
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String name = request.getParameter("name");
			String sql="select * from set_Brand where 1=1  ";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				sql=sql+" AND enterpriseId=?";
				params.add(enterprise.getDbid());
			}
			
			if(null!=name&&name.trim().length()>0){
				sql=sql+" AND name like ? ";
				params.add("%"+name+"%");
			}
			Page<Brand> page= brandManageImpl.pagedQuerySql(pageNo, pageSize,Brand.class,sql,params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
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
		if(dbid>0){
			Brand brand = brandManageImpl.get(dbid);
			request.setAttribute("brand", brand);
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = brand.getDbid();
			if(dbid==null){
				dbid=0;
			}
			List<Brand> brands = brandManageImpl.find("from Brand where name=? AND enterpriseId=? AND dbid!=? ",new Object[]{brand.getName(),enterprise.getDbid(),dbid});
			if(null!=brands&&brands.size()>0){
				renderErrorMsg(new Throwable("添加数据失败，系统已经存在该名称"),"");
				return ;
			}
			if(dbid==null||dbid<=0){
					brand.setCreateTime(new Date());
					brand.setModifyTime(new Date());
					brand.setEnterpriseId(enterprise.getDbid());
					brandManageImpl.save(brand);
			}else{
					Brand brand2 = brandManageImpl.get(brand.getDbid());
					brand2.setModifyTime(new Date());
					brand2.setIntroduction(brand.getIntroduction());
					brand2.setLogo(brand.getLogo());
					brand2.setName(brand.getName());
					brand2.setOrderNum(brand.getOrderNum());
					brand2.setType(brand.getType());
					brand2.setUrl(brand.getUrl());
					brandManageImpl.save(brand2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/userBrand/queryList", "保存数据成功！");
		return ;
	}
	
	/**
	 * 功能描述：s
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					Brand brand2 = brandManageImpl.get(dbid);
					List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("brand.dbid", brand2.getDbid());
					if(null!=carSeriys&&carSeriys.size()>0){
						renderErrorMsg(new Throwable("品牌数据存在应用，删除数据前请先删除应用数据！"), "");
						return ;
					}else{
						brandManageImpl.deleteById(dbid);
					}
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
		renderMsg("/userBrand/queryList"+query, "删除数据成功！");
		return;
	}
	
}
