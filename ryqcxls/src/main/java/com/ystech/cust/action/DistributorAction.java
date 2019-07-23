/**
 * 
 */
package com.ystech.cust.action;

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
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.Distributor;
import com.ystech.cust.model.DistributorBrand;
import com.ystech.cust.model.DistributorBuff;
import com.ystech.cust.model.DistributorChargePerson;
import com.ystech.cust.model.DistributorSuboutlet;
import com.ystech.cust.model.DistributorType;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.DistributorBrandManageImpl;
import com.ystech.cust.service.DistributorBuffManageImpl;
import com.ystech.cust.service.DistributorChargePersonManageImpl;
import com.ystech.cust.service.DistributorManageImpl;
import com.ystech.cust.service.DistributorSuboutletManageImpl;
import com.ystech.cust.service.DistributorTypeManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

/**
 * @author shusanzhan
 * @date 2014-8-9
 */
@Component("distributorAction")
@Scope("prototype")
public class DistributorAction extends BaseController{
	private Distributor distributor;
	private DistributorManageImpl distributorManageImpl;
	private AreaManageImpl areaManageImpl;
	private DistributorTypeManageImpl distributorTypeManageImpl;
	private DistributorBuffManageImpl distributorBuffManageImpl;
	private DistributorBrandManageImpl distributorBrandManageImpl;
	private DistributorChargePersonManageImpl distributorChargePersonManageImpl;
	private DistributorSuboutletManageImpl distributorSuboutletManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private UserManageImpl userManageImpl;
	private HttpServletRequest request=this.getRequest();
	public Distributor getDistributor() {
		return distributor;
	}
	public void setDistributor(Distributor distributor) {
		this.distributor = distributor;
	}
	public DistributorManageImpl getDistributorManageImpl() {
		return distributorManageImpl;
	}
	@Resource
	public void setDistributorManageImpl(DistributorManageImpl distributorManageImpl) {
		this.distributorManageImpl = distributorManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setDistributorTypeManageImpl(
			DistributorTypeManageImpl distributorTypeManageImpl) {
		this.distributorTypeManageImpl = distributorTypeManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setDistributorBuffManageImpl(
			DistributorBuffManageImpl distributorBuffManageImpl) {
		this.distributorBuffManageImpl = distributorBuffManageImpl;
	}
	@Resource
	public void setDistributorBrandManageImpl(
			DistributorBrandManageImpl distributorBrandManageImpl) {
		this.distributorBrandManageImpl = distributorBrandManageImpl;
	}
	@Resource
	public void setDistributorChargePersonManageImpl(
			DistributorChargePersonManageImpl distributorChargePersonManageImpl) {
		this.distributorChargePersonManageImpl = distributorChargePersonManageImpl;
	}
	@Resource
	public void setDistributorSuboutletManageImpl(
			DistributorSuboutletManageImpl distributorSuboutletManageImpl) {
		this.distributorSuboutletManageImpl = distributorSuboutletManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
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
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer distributorTypeId = ParamUtil.getIntParam(request, "distributorTypeId", -1);
		String name = request.getParameter("name");
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			List param=new ArrayList();
			String hql="select * from cust_Distributor where 1=1 ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				hql=hql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				hql=hql+" and enterpriseId="+currentUser.getEnterprise().getDbid();
			}
			if(null!=name&&name.trim().length()>0){
				hql=hql+" and name like ? ";
				param.add("%"+name+"%");
			}
			if(type>0){
				hql=hql+" and type=? ";
				param.add(type);
			}
			if(distributorTypeId>0){
				hql=hql+" and distributorTypeId=? ";
				param.add(distributorTypeId);
			}
			Page<Distributor> page=distributorManageImpl.pagedQuerySql(pageNo, pageSize,Distributor.class, hql,param.toArray());
			request.setAttribute("page", page);
			
			//
			List<DistributorType> distributorTypes = distributorTypeManageImpl.getAll();
			request.setAttribute("distributorTypes", distributorTypes);
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
	public String chocie() throws Exception {
		return "chocie";
	}
	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			List<DistributorType> distributorTypes = distributorTypeManageImpl.findBy("companyId", enterprise.getDbid());
			request.setAttribute("distributorTypes", distributorTypes);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "edit";
	}
	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String editEn() throws Exception {
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			if(dbid>0){
				Distributor distributor2 = distributorManageImpl.get(dbid);
				request.setAttribute("distributor", distributor2);
				
				Area legalArea = distributor2.getLegalArea();
				if(null!=legalArea){
					String areaSelect = areaSelect(legalArea,"areaLabel","legalAreaId");
					request.setAttribute("areaSelect", areaSelect);
				}
				Area compnayArea = distributor2.getCompanyArea();
				if(null!=compnayArea){
					String companyAreaSelect = areaSelect(compnayArea,"companyAreaLabel","companyAreaId");
					request.setAttribute("companyAreaSelect", companyAreaSelect);
				}
				
			}else{
				//地域信息
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				request.setAttribute("areas", areas);
			}
			

			List<DistributorType> distributorTypes = distributorTypeManageImpl.findBy("companyId", enterprise.getDbid());
			request.setAttribute("distributorTypes", distributorTypes);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "editEn";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request,"dbid", -1);
		try{
			Distributor distributor2 = distributorManageImpl.get(dbid);
			request.setAttribute("distributor", distributor2);
			
			List<DistributorChargePerson> distributorChargePersons = distributorChargePersonManageImpl.findBy("distributorId", dbid);
			request.setAttribute("distributorChargePersons", distributorChargePersons);
			
			List<DistributorBuff> distributorBuffs = distributorBuffManageImpl.findBy("distributorId", dbid);
			request.setAttribute("distributorBuffs", distributorBuffs);
			
			List<DistributorBrand> distributorBrands = distributorBrandManageImpl.findBy("distributorId", dbid);
			request.setAttribute("distributorBrands", distributorBrands);
			
			List<DistributorSuboutlet> distributorSuboutlets = distributorSuboutletManageImpl.findBy("distributorId", dbid);
			request.setAttribute("distributorSuboutlets", distributorSuboutlets);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "view";
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
			if(dbid>0){
				Distributor distributor2 = distributorManageImpl.get(dbid);
				request.setAttribute("distributor", distributor2);
				
				Area legalArea = distributor2.getLegalArea();
				if(null!=legalArea){
					String areaSelect = areaSelect(legalArea,"areaLabel","legalAreaId");
					request.setAttribute("areaSelect", areaSelect);
				}
				Area compnayArea = distributor2.getCompanyArea();
				if(null!=compnayArea){
					String companyAreaSelect = areaSelect(compnayArea,"companyAreaLabel","companyAreaId");
					request.setAttribute("companyAreaSelect", companyAreaSelect);
				}
				
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				List<DistributorType> distributorTypes = distributorTypeManageImpl.findBy("companyId", enterprise.getDbid());
				request.setAttribute("distributorTypes", distributorTypes);
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
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer legalAreaId = ParamUtil.getIntParam(request, "legalAreaId", -1);
		Integer companyAreaId = ParamUtil.getIntParam(request, "companyAreaId", -1);
		Integer distributorTypeId = ParamUtil.getIntParam(request, "distributorTypeId", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			if(distributor.getType()==(int)1){
				if(userId<0){
					renderErrorMsg(new Throwable("区域专员为空，请先输入区域专员"), "");
					return ;
				}
			}
			if(userId>0){
				User user = userManageImpl.get(userId);
				distributor.setUser(user);
				distributor.setEnterprise(user.getEnterprise());
				distributor.setDepartment(user.getDepartment());
			}else{
				distributor.setEnterprise(currentUser.getEnterprise());
			}
			if(legalAreaId>0){
				Area area = areaManageImpl.get(legalAreaId);
				distributor.setLegalArea(area);
			}
			if(companyAreaId>0){
				Area companyArea = areaManageImpl.get(companyAreaId);
				distributor.setCompanyArea(companyArea);
			}
			if(distributorTypeId>0){
				DistributorType distributorType = distributorTypeManageImpl.get(distributorTypeId);
				distributor.setDistributorType(distributorType);
			}
			distributor.setCreatorId(currentUser.getDbid());
			distributor.setCreatorName(currentUser.getRealName());
			Integer dbid = distributor.getDbid();
			if(dbid==null||dbid<=0){
				List<Distributor> distributors = distributorManageImpl.find("from Distributor where name=? and user.dbid=? ", new Object[]{distributor.getName(),currentUser.getDbid()});
				if(null!=distributors&&distributors.size()>0){
					renderErrorMsg(new Throwable("系统中车经销商称已经存在了,请换一个名称!"), "");
					return ;
				}
				distributor.setCreateTime(new Date());
				distributor.setModifyTime(new Date());
				distributorManageImpl.save(distributor);
			}else{
				List<Distributor> distributors = distributorManageImpl.find("from Distributor where name=? and user.dbid=? and dbid!=?",new Object[]{distributor.getName(),currentUser.getDbid(),dbid});
				if(null!=distributors&&distributors.size()>0){
					renderErrorMsg(new Throwable("系统中经销商名称已经存在了,请换一个名称!"), "");
					return ;
				}
				distributor.setModifyTime(new Date());
				distributorManageImpl.save(distributor);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributor/queryList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：转区域专员
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String changeUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer distributorId = ParamUtil.getIntParam(request, "distributorId", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		try {
			Distributor distributor2 = distributorManageImpl.get(distributorId);
			request.setAttribute("distributor", distributor2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "changeUser";
	}
	/**
	 * 功能描述：保存转区域专员
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveChangeuser() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer distributorId = ParamUtil.getIntParam(request, "distributorId", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		try {
			Distributor distributor2 = distributorManageImpl.get(distributorId);
			if(userId<=0){
				renderErrorMsg(new Throwable("区域专员为空，请先输入区域专员"), "");
				return ;
			}
			User user = userManageImpl.get(userId);
			distributor2.setUser(user);
			distributor2.setEnterprise(user.getEnterprise());
			distributor2.setDepartment(user.getDepartment());
			distributorManageImpl.save(distributor2);
		} catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributor/queryList", "保存数据成功！");
		return;
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
					Distributor distributor2 = distributorManageImpl.get(dbid);
					List<Customer> customers = customerMangeImpl.findBy("distributor.dbid", dbid);
					if(null!=customers&&customers.size()>0){
						renderErrorMsg(new Throwable(distributor2.getName()+"登记有客户不能删除，请确认！"), "");
						return ;
					}
					distributorManageImpl.deleteById(dbid);
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
		renderMsg("/distributor/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：转为合作商
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void turnOn() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		String query = ParamUtil.getQueryUrl(request);
		try {
			Distributor distributor2 = distributorManageImpl.get(dbid);
			if(distributor2.getType()==1){
				distributor2.setType(2);
			}
			distributorManageImpl.save(distributor2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributor/queryList"+query, "设置成功！");
		return;
	}
	/**
	 * @param memberInfo2
	 */
	private String areaSelect(Area area,String areaLabel,String legalAreaId) {
		StringBuffer buffer=new StringBuffer();
		if(null!=area){
			String treePath = area.getTreePath();
			String[] split = treePath.split(",");
			if(split.length>0){
				//父节点
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				if(null!=areas&&areas.size()>0){
					buffer.append("<select id='ar' name='ar' class='small text' onchange='ajaxArea(\""+areaLabel+"\",this,\""+legalAreaId+"\")'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas) {
						if(ar.getDbid()==Integer.parseInt(split[1])){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
				for (int i=2; i<split.length ; i++) {
					List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[i-1]));
					if(null!=areas2&&areas2.size()>0){
						buffer.append("<select id='ar' name='ar' class='small text' onchange='ajaxArea(\""+areaLabel+"\",this,\""+legalAreaId+"\")'>");
						buffer.append("<option>请选择...</option>");
						for (Area ar : areas2) {
							if(ar.getDbid()==Integer.parseInt(split[i])){
								buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}else{
								buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
							}
						}
						buffer.append("</select> ");
					}
				}
				//最后一个下拉框
				List<Area> areas2 = areaManageImpl.findBy("area.dbid",Integer.parseInt(split[split.length-1]));
				if(null!=areas2&&areas2.size()>0){
					buffer.append("<select id='ar' name='ar' class='small text' onchange='ajaxArea(\""+areaLabel+"\",this,\""+legalAreaId+"\")'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas2) {
						if(ar.getDbid()==area.getDbid()){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
			}else{
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				if(null!=areas&&areas.size()>0){
					buffer.append("<select id='ar' name='ar' class='small text' onchange='ajaxArea(\""+areaLabel+"\",this,\""+legalAreaId+"\")'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : areas) {
						if(ar.getDbid()==(int)area.getDbid()){
							buffer.append("<option selected='selected' value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}else{
							buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
						}
					}
					buffer.append("</select> ");
				}
				
				List<Area> paentAreas = areaManageImpl.find("from Area where area.dbid=? ", new Object[]{area.getDbid()});
				if(null!=paentAreas&&paentAreas.size()>0){
					buffer.append("<select id='ar' name='ar' class='small text' onchange='ajaxArea(\""+areaLabel+"\",this,\""+legalAreaId+"\")'>");
					buffer.append("<option>请选择...</option>");
					for (Area ar : paentAreas) {
						buffer.append("<option value='"+ar.getDbid()+"'>"+ar.getName()+"</option>");
					}
					buffer.append("</select> ");
				}
				
			}
		}else{
			return null;
		}
		return buffer.toString();
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void auto() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			pingyin=new String(pingyin.getBytes("iso8859-1"),"utf-8");
			pingyin = pingyin.toUpperCase();
			List<Distributor> distributors=new ArrayList<Distributor>();
			String sql="select * from cust_Distributor where ((pinyin like ? or name like ?) and userId="+currentUser.getDbid()+" and type=1) or ((pinyin like ? or name like ?) and enterpriseId="+enterprise.getDbid()+" and type=2)";
			distributors= distributorManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%"});
			if(null==distributors||distributors.size()<=0){
				distributors = distributorManageImpl.findBy("user.dbid", currentUser.getDbid());
			}
			JSONArray  array=new JSONArray();
			if(null!=distributors&&distributors.size()>0){
				for (Distributor distributor: distributors) {
					JSONObject object=new JSONObject();
					object.put("dbid", distributor.getDbid());
					object.put("name", distributor.getName());
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
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoByFin() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			pingyin=new String(pingyin.getBytes("iso8859-1"),"utf-8");
			pingyin = pingyin.toUpperCase();
			List<Distributor> distributors=new ArrayList<Distributor>();
			String entSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				entSql=entSql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				entSql=entSql+" and enterpriseId="+enterprise.getDbid();
			}
			String sql="select * from cust_Distributor where ((pinyin like ? or name like ?) "+entSql+" and type=1) or ((pinyin like ? or name like ?) "+entSql+" and type=2)";
			distributors= distributorManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%","%"+pingyin+"%"});
			JSONArray  array=new JSONArray();
			if(null!=distributors&&distributors.size()>0){
				for (Distributor distributor: distributors) {
					JSONObject object=new JSONObject();
					object.put("dbid", distributor.getDbid());
					object.put("name", distributor.getName());
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
		return;
	}
}
