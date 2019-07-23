/**
 * 
 */
package com.ystech.xwqr.set.action;

import java.util.ArrayList;
import java.util.Calendar;
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
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-17
 */
@Component("carModelAction")
@Scope("prototype")
public class CarModelAction extends BaseController{
	private CarModel carModel;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private BrandManageImpl brandManageImpl;
	public CarModel getCarModel() {
		return carModel;
	}

	public void setCarModel(CarModel carModel) {
		this.carModel = carModel;
	}
	@Resource
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
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
		Integer carSeriyid = ParamUtil.getIntParam(request, "carSeriesId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String name = request.getParameter("name");
		
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			String hql="select * from set_CarModel where 1=1   ";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				hql=hql+" AND enterpriseId=? ";
				params.add(enterprise.getDbid());
			}
			if(null!=name&&name.trim().length()>0){
				hql=hql+" and name like ? ";
				params.add("%"+name+"%");
			}
			if(brandId>0){
				hql=hql+" and brandId=? ";
				params.add(brandId);
			}
			if(carSeriyid>0){
				hql=hql+" and carSeriesId=? ";
				params.add(carSeriyid);
			}
			hql=hql+" order by status,carSeriesId";
			Page<CarModel> page= carModelManageImpl.pagedQuerySql(pageNo, pageSize,CarModel.class,hql,params.toArray());
			request.setAttribute("page", page);
		}catch (Exception e){
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
	@SuppressWarnings("deprecation")
	public String add() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			int[] years = getYears();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where enterpriseId="+enterprise.getDbid(), null);
			request.setAttribute("carSeriys", carSeriys);
			request.setAttribute("brands",brands);
			request.setAttribute("years", years);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}

	/**
	 * 
	 */
	private int[] getYears() {
		Calendar cal = Calendar.getInstance();
	    int year = cal.get(Calendar.YEAR);
	    year=year+1;
		int[] years=new int[year-1999];
		for (int i = 0; i <years.length; i++) {
			years[i]=year-i;
		}
		return years;
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
		try{
			int[] years = getYears();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(dbid>0){
				CarModel carModel2 = carModelManageImpl.get(dbid);
				request.setAttribute("carModel", carModel2);
				Brand brand = carModel2.getBrand();
				List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brand.getDbid());
				request.setAttribute("carSeriys", carSeriys);
			}
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			request.setAttribute("years", years);
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
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = carModel.getDbid()==null?0:carModel.getDbid();
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			if(brandId>0){
				Brand brand = brandManageImpl.get(brandId);
				carModel.setBrand(brand);
			}
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				carModel.setCarseries(carSeriy);
			}
			String sql="select * FROM set_carModel where carSeriesId="+carSeriyId+" and `name`='"+carModel.getName()+"' AND enterpriseId="+enterprise.getDbid()+" AND dbid!="+dbid;
			List<CarModel> carModels = carModelManageImpl.executeSql(sql,null);
			if(null!=carModels&&carModels.size()>0){
				renderErrorMsg(new Throwable("添加车型失败，【"+carModel.getName()+"】车型已经存在"), "");
				return ;
			}
			if(dbid==null||dbid<=0){
				carModel.setStatus(CarModel.STATUSCOMM);
				carModel.setEnterpriseId(enterprise.getDbid());
				carModelManageImpl.save(carModel);
			}else{
				CarModel carModel2 = carModelManageImpl.get(dbid);
				carModel2.setBrand(carModel.getBrand());
				carModel2.setCarseries(carModel.getCarseries());
				carModel2.setName(carModel.getName());
				carModel2.setYearModel(carModel.getYearModel());
				carModel2.setNavPrice(carModel.getNavPrice());
				carModel2.setPicture(carModel.getPicture());
				carModel2.setContent(carModel.getContent());
				carModel2.setSalePrice(carModel.getSalePrice());
				carModel2.setCarseries(carModel.getCarseries());
				carModelManageImpl.save(carModel2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/carModel/queryList", "保存数据成功！");
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
					carModelManageImpl.deleteById(dbid);
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
		renderMsg("/carModel/queryList"+query, "删除数据成功！");
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
				CarModel carModel2 = carModelManageImpl.get(dbid);
				Integer userState = carModel2.getStatus();
				if(null!=userState){
					if(userState==CarModel.STATUSCOMM){
						carModel2.setStatus(CarModel.STATUSSTOP);
					}else if(userState==CarModel.STATUSSTOP){
						carModel2.setStatus(CarModel.STATUSCOMM);
					}
				}
				carModelManageImpl.save(carModel2);
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
		renderMsg("/carModel/queryList"+query, "设置成功！");
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCarModel() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			if(carSeriyId>0){
				List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriyId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carModels&&carModels.size()>0){
					buffer.append("<select id='carModel' name='carModel' style='border:1px solid #c7c7c7;	width: 80px;margin-left: 12px;height: 28px;'>");
					buffer.append("<option>请选择车型...</option>");
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"</option>");
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
	public void ajaxCarModelBySeriy() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			if(carSeriyId>0){
				List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriyId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carModels&&carModels.size()>0){
					buffer.append("<select id='carModelId' name='carModelId' class='mideaX text' checkType=\"integer,1\" tip=\"请选择意向车型！\">");
					buffer.append("<option value=''>请选择车型...</option>");
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"&nbsp;&nbsp;价格:"+carModel.getSalePrice()+"</option>");
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
	public void ajaxCarModelBySeriyStatus() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			StringBuffer buffer=new StringBuffer();
			if(carSeriyId>0){
				List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=? ",new Object[]{carSeriyId,CarModel.STATUSCOMM});
				if(null!=carModels&&carModels.size()>0){
					buffer.append("<select id='carModelId' name='carModelId' class='mideaX text' checkType=\"integer,1\" tip=\"请选择意向车型！\">");
					buffer.append("<option value=''>请选择车型...</option>");
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"&nbsp;&nbsp;价格:"+carModel.getSalePrice()+"</option>");
					}
					buffer.append("</select> ");
					renderText(buffer.toString());
				}else{
					buffer.append("<select id='carModelId' name='carModelId' class='mideaX text' checkType=\"integer,1\" tip=\"请选择意向车型！\">");
					buffer.append("<option value=''>请先选择车系...</option>");
					buffer.append("</select> ");
				}
			}else{
				buffer.append("<select id='carModelId' name='carModelId' class='mideaX text' checkType=\"integer,1\" tip=\"请选择意向车型！\">");
					buffer.append("<option value=''>请先选择车系...</option>");
				buffer.append("</select> ");
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
