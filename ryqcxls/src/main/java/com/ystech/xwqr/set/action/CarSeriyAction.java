/**
 * 
 */
package com.ystech.xwqr.set.action;

import java.util.ArrayList;
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
 * @date 2014-2-17
 */
@Component("carSeriyAction")
@Scope("prototype")
public class CarSeriyAction extends BaseController{
	private CarSeriy carSeriy;
	private CarSeriyManageImpl carSeriyManageImpl;
	private BrandManageImpl brandManageImpl;
	public CarSeriy getCarSeriy() {
		return carSeriy;
	}
	public void setCarSeriy(CarSeriy carSeriy) {
		this.carSeriy = carSeriy;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
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
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String username = request.getParameter("name");
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			String sql="select * from set_CarSeriy where 1=1 ";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				sql=sql+" AND enterpriseId=?  ";
				params.add(enterprise.getDbid());
			}
			if(brandId>0){
				sql=sql+" and brandId=? ";
				params.add(brandId);
			}
			if(null!=username&&username.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+username+"%");
			}
			sql=sql+" order by orderNum";
			Page<CarSeriy> page = carSeriyManageImpl.pagedQuerySql(pageNo, pageSize, CarSeriy.class, sql,params.toArray());
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
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands",brands);
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
		try {
			if(dbid>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(dbid);
				request.setAttribute("carSeriy", carSeriy);
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
				request.setAttribute("brands", brands);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = carSeriy.getDbid();
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			if(brandId>0){
				Brand brand = brandManageImpl.get(brandId);
				carSeriy.setBrand(brand);
			}
			if(dbid==null){
				dbid=0;
			}
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where name=? and brand.dbid=? AND enterpriseId=? AND dbid!=? ",new Object[]{carSeriy.getName(),brandId,enterprise.getDbid(),dbid});
			if(null!=carSeriys&&carSeriys.size()>0){
				renderErrorMsg(new Throwable("添加数据失败，系统已经存在该名称"),"");
				return ;
			}
			if(dbid==null||dbid<=0){
				carSeriy.setStatus(CarSeriy.STATUSCOMM);
				carSeriy.setEnterpriseId(enterprise.getDbid());
				carSeriyManageImpl.save(carSeriy);
			}else{
				CarSeriy carSeriy2 = carSeriyManageImpl.get(dbid);
				carSeriy2.setName(carSeriy.getName());
				carSeriy2.setBrand(carSeriy.getBrand());
				carSeriy2.setDescription(carSeriy.getDescription());
				carSeriy2.setIntroduction(carSeriy.getIntroduction());
				carSeriy2.setNavPrice(carSeriy.getNavPrice());
				carSeriy2.setSalePrice(carSeriy.getSalePrice());
				carSeriy2.setSaleCSPrice(carSeriy.getSaleCSPrice());
				carSeriy2.setPriceFrom(carSeriy.getPriceFrom());
				carSeriy2.setCarLevel(carSeriy.getCarLevel());
				carSeriy2.setCarColors(carSeriy.getCarColors());
				carSeriy2.setCarDriverType(carSeriy.getCarDriverType());
				carSeriy2.setBianxueType(carSeriy.getBianxueType());
				carSeriy2.setPailiang(carSeriy.getPailiang());
				carSeriy2.setHasJk(carSeriy.getHasJk());
				carSeriy2.setHandCarTime(carSeriy.getHandCarTime());
				carSeriy2.setOrderNum(carSeriy.getOrderNum());
				carSeriy2.setZbType(carSeriy.getZbType());
				carSeriy2.setPicture(carSeriy.getPicture());
				carSeriy2.setDescription(carSeriy.getDescription());
				carSeriyManageImpl.save(carSeriy2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/carSeriy/queryList", "保存数据成功！");
		return ;
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
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
					carSeriyManageImpl.deleteById(dbid);
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
		renderMsg("/carSeriy/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：启用或者停用车系
	 */
	public void stopOrStart() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(dbid);
				Integer userState = carSeriy.getStatus();
				if(null!=userState){
					if(userState==CarSeriy.STATUSCOMM){
						carSeriy.setStatus(CarSeriy.STATUSSTOP);
					}else if(userState==CarSeriy.STATUSSTOP){
						carSeriy.setStatus(CarSeriy.STATUSCOMM);
					}
				}
				carSeriyManageImpl.save(carSeriy);
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/carSeriy/queryList"+query, "设置成功！");
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCarSeriy() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(brandId>0){
				List<CarSeriy> carSeriys = carSeriyManageImpl.findAjaxByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carSeriys&&carSeriys.size()>0){
					buffer.append("<select id=\"carSeriyId\" name=\"carSeriyId\" class=\"midea text\" onchange=\"ajaxCarModel('carSeriyId')\" checkType=\"integer,1\"  tip=\"请选择车系\">");
					buffer.append("<option>请选择车系...</option>");
					for (CarSeriy carSeriy : carSeriys) {
						buffer.append("<option value='"+carSeriy.getDbid()+"'>"+carSeriy.getBrand().getName()+" "+carSeriy.getName()+"</option>");
					}
					buffer.append("</select> ");
					renderText(buffer.toString());
				}else{
					renderText("error");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderText("error");
			return ;
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
	public void ajaxCarSeriyByStatus() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(brandId>0){
				List<CarSeriy> carSeriys = carSeriyManageImpl.findAjaxByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carSeriys&&carSeriys.size()>0){
					buffer.append("<select id=\"carSeriyId\" name=\"carSeriyId\" class=\"midea text\" onchange=\"ajaxCarModel('carSeriyId')\" checkType=\"integer,1\"  tip=\"请选择车系\">");
					buffer.append("<option>请选择车系...</option>");
					for (CarSeriy carSeriy : carSeriys) {
						buffer.append("<option value='"+carSeriy.getDbid()+"'>"+carSeriy.getBrand().getName()+" "+carSeriy.getName()+"</option>");
					}
					buffer.append("</select> ");
					renderText(buffer.toString());
				}else{
					renderText("error");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderText("error");
			return ;
		}
		return ;
	}
	
	
}
