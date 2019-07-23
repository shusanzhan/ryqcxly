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
import com.ystech.xwqr.set.model.CarColor;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarColorManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("carColorAction")
@Scope("prototype")
public class CarColorAction extends BaseController{
	private CarColor carColor;
	private CarColorManageImpl carColorManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private BrandManageImpl brandManageImpl;
	
	public CarColor getCarColor() {
		return carColor;
	}

	public void setCarColor(CarColor carColor) {
		this.carColor = carColor;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}

	public CarSeriyManageImpl getCarSeriyManageImpl() {
		return carSeriyManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}

	public CarColorManageImpl getCarColorManageImpl() {
		return carColorManageImpl;
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
		Integer carSeriyid = ParamUtil.getIntParam(request, "carSeriesId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String name = request.getParameter("name");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brandId);
			request.setAttribute("carSeriys", carSeriys);
			String hql="select * from set_CarColor where 1=1  ";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				hql=hql+" AND enterpriseId=? ";
				params.add(enterprise.getDbid());
			}
			if(null!=name&&name.trim().length()>0){
				hql=hql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(carSeriyid>0){
				hql=hql+" and  carSeriesId=? ";
				params.add(carSeriyid);
			}
			if(brandId>0){
				hql=hql+" and  brandId=? ";
				params.add(brandId);
			}
			hql=hql+" order by status ";
			Page<CarColor> page = carColorManageImpl.pagedQuerySql(pageNo, pageSize,CarColor.class,hql,params.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), -1);
			request.setAttribute("carSeriys", carSeriys);
		}catch (Exception e) {
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			CarColor carColor2 = carColorManageImpl.get(dbid);
			request.setAttribute("carColor", carColor2);
			CarSeriy carseries = carColor2.getCarseries();
			if(null!=carseries){
				Brand brand = carseries.getBrand();
				List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brand.getDbid());
				request.setAttribute("carSeriys", carSeriys);
			}
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
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				carColor.setCarseries(carSeriy);
			}
			Integer dbid=carColor.getDbid()==null?0:carColor.getDbid();
			String sql="select * FROM set_carColor where  `name`='"+carColor.getName()+"' AND enterpriseId="+enterprise.getDbid()+" AND dbid!="+dbid;
			List<CarColor> carColors = carColorManageImpl.executeSql(sql, null);
			if(null!=carColors&&!carColors.isEmpty()){
				renderErrorMsg(new Throwable("添加数据失败，系统已经存在该名称"),"");
				return ;
			}
			if(dbid==0){
				carColor.setBrandId(brandId);
				carColor.setEnterpriseId(enterprise.getDbid());
				carColor.setStatus(CarColor.STATUSCOMM);
				carColorManageImpl.save(carColor);
			}else{
				CarColor carColor2 = carColorManageImpl.get(carColor.getDbid());
				carColor2.setName(carColor.getName());
				carColor2.setBrandId(brandId);
				carColor2.setNote(carColor.getNote());
				carColor2.setCarseries(carColor.getCarseries());
				carColorManageImpl.save(carColor2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/carColor/queryList", "保存数据成功！");
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
						carColorManageImpl.deleteById(dbid);
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
		renderMsg("/carColor/queryList"+query, "删除数据成功！");
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
				CarColor carColor = carColorManageImpl.get(dbid);
				Integer userState = carColor.getStatus();
				if(null!=userState){
					if(userState==CarModel.STATUSCOMM){
						carColor.setStatus(CarModel.STATUSSTOP);
					}else if(userState==CarModel.STATUSSTOP){
						carColor.setStatus(CarModel.STATUSCOMM);
					}
				}
				carColorManageImpl.save(carColor);
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
		renderMsg("/carColor/queryList"+query, "设置成功！");
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCarColor() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CarColor> carColors = carColorManageImpl.findAjaxByEnterpriseId(enterprise.getDbid());
			StringBuffer buffer=new StringBuffer();
			if(null!=carColors&&carColors.size()>0){
				buffer.append("<select id='carColor' name='carColor' class='mideaX text' tip=\"请选择车辆颜色\">");
				buffer.append("<option value=''>请选择车辆颜色...</option>");
				for (CarColor carColor : carColors) {
					buffer.append("<option value='"+carColor.getDbid()+"'>"+carColor.getName()+"</option>");
				}
				buffer.append("</select><span style=\"color: red\">*</span> ");
				renderText(buffer.toString());
			}else{
				renderText("error");
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
	public void ajaxCarColorStatus() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				List<CarColor> carColors = carColorManageImpl.findAjaxByEnterpriseId(enterprise.getDbid());
				StringBuffer buffer=new StringBuffer();
				if(null!=carColors&&carColors.size()>0){
					buffer.append("<select id='carColor' name='carColor' class='mideaX text' tip=\"请选择车辆颜色\">");
					buffer.append("<option value=''>请选择车辆颜色...</option>");
					for (CarColor carColor : carColors) {
						buffer.append("<option value='"+carColor.getDbid()+"'>"+carColor.getName()+"</option>");
					}
					buffer.append("</select><span style=\"color: red\">*</span> ");
					renderText(buffer.toString());
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
	public void ajaxCarColorByCarModel() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
				StringBuffer buffer=new StringBuffer();
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				List<CarColor> carColors = carColorManageImpl.findAjaxByEnterpriseId(enterprise.getDbid());
				if(null!=carColors&&carColors.size()>0){
					buffer.append("<option value=''>请选择颜色...</option>");
					for (CarColor carColor : carColors) {
						buffer.append("<option value='"+carColor.getDbid()+"'>"+carColor.getName()+"</option>");
					}
					renderText(buffer.toString());
				}else{
					buffer.append("<option value=''>请先选择车系...</option>");
					renderText(buffer.toString());
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
