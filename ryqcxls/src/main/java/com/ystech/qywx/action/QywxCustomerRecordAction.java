package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerRecordClubInvalidReason;
import com.ystech.cust.model.CustomerRecordTarget;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerRecordClubInvalidReasonManageImpl;
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.cust.service.CustomerRecordTargetManageImpl;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.SystemInfoMangeImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxCustomerRecordAction")
@Scope("prototype")
public class QywxCustomerRecordAction extends BaseController{
	private CustomerRecord customerRecord;
	private UserManageImpl userManageImpl;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerRecordClubInvalidReasonManageImpl customerRecordClubInvalidReasonManageImpl;
	private CustomerRecordTargetManageImpl customerRecordTargetManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setCustomerRecordTargetManageImpl(
			CustomerRecordTargetManageImpl customerRecordTargetManageImpl) {
		this.customerRecordTargetManageImpl = customerRecordTargetManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerRecordClubInvalidReasonManageImpl(
			CustomerRecordClubInvalidReasonManageImpl customerRecordClubInvalidReasonManageImpl) {
		this.customerRecordClubInvalidReasonManageImpl = customerRecordClubInvalidReasonManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	public CustomerRecord getCustomerRecord() {
		return customerRecord;
	}
	public void setCustomerRecord(CustomerRecord customerRecord) {
		this.customerRecord = customerRecord;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
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
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			 User currentUser = getSessionUser();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			 String sql="select * from cust_CustomerRecord where 1=1 ";
			 List param=new ArrayList();
			 sql=sql+" and creatorId=? ";
			 param.add(currentUser.getDbid());
			 if(customerTypeId>0){
				 sql=sql+" and customerTypeId=? ";
				 param.add(customerTypeId);
			 }
			 if(status>0){
				 sql=sql+" and status=? ";
				 param.add(status);
			 }
			 if(comeinNum>0){
				 sql=sql+" and comeinNum=? and customerTypeId=1 and status="+CustomerRecord.STATUSCOMM;
				 param.add(comeinNum);
			 }
			 if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+" order by resultStatus,createDate DESC";
			 Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			 request.setAttribute("page", page);
		}catch (Exception e) {
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
	public void ajaxList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			 User currentUser = getSessionUser();
			 String sql="select * from cust_CustomerRecord where 1=1 ";
			 List param=new ArrayList();
			 sql=sql+" and creatorId=? ";
			 param.add(currentUser.getDbid());
			 if(customerTypeId>0){
				 sql=sql+" and customerTypeId=? ";
				 param.add(customerTypeId);
			 }
			 if(status>0){
				 sql=sql+" and status=? ";
				 param.add(status);
			 }
			 if(comeinNum>0){
				 sql=sql+" and comeinNum=? and customerTypeId=1 and status="+CustomerRecord.STATUSCOMM;
				 param.add(comeinNum);
			 }
			 if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+" order by resultStatus,createDate DESC";
			Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			List<CustomerRecord> customers = page.getResult();
			String jsonCustoemr = jsonCustoemr(customers);
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("pageNo", pageNo+1);
			jsonObject.put("pageSize", pageSize);
			jsonObject.put("data", jsonCustoemr);
			renderJson(jsonObject.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return ;
	}
	/**
	 * 功能描述：无效线索
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryInvalidList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize",10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			User currentUser = getSessionUser();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			String sql="select * from cust_CustomerRecord where status=? ";
			List param=new ArrayList();
			param.add(CustomerRecord.STATUSINVAL);
			sql=sql+" and creatorId=? ";
			param.add(currentUser.getDbid());
			if(customerTypeId>0){
				sql=sql+" and customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(comeinNum>0){
				sql=sql+" and comeinNum=? and customerTypeId=1 and status="+CustomerRecord.STATUSCOMM;
				param.add(comeinNum);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+" order by resultStatus,createDate DESC";
			Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "invalidList";
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "add";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String editComeShop() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(dbid);
				request.setAttribute("customerRecord", customerRecord);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerRecord.getCustomerInfrom());
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}else{
				CustomerInfrom customerInfrom=new CustomerInfrom();
				customerInfrom.setDbid(1);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerInfrom);
				request.setAttribute("customerInfromSelect", customerInfromSelect);
				
				int comeInDate = getComeInDate();
				request.setAttribute("comeInDate", comeInDate);
			}
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", CustomerRecordTarget.TYPECOMIN);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "editComeShop";
	}
	
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String editPhone() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(dbid);
				request.setAttribute("customerRecord", customerRecord);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerRecord.getCustomerInfrom());
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}else{
				CustomerInfrom customerInfrom=new CustomerInfrom();
				customerInfrom.setDbid(2);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerInfrom);
				request.setAttribute("customerInfromSelect", customerInfromSelect);
				int comeInDate = getComeInDate();
				request.setAttribute("comeInDate", comeInDate);
			}
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", CustomerRecordTarget.TYPEPHONE);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
		} catch (Exception e) {
		}
		return "editPhone";
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
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer red = ParamUtil.getIntParam(request, "red", 1);
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		Integer agentPersonId = ParamUtil.getIntParam(request, "agentPersonId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer customerRecordTargetId = ParamUtil.getIntParam(request, "customerRecordTargetId", -1);
		try{
			Integer dbid = customerRecord.getDbid();
			if(customerInfromId>0){
				CustomerInfrom customerInfrom = customerInfromManageImpl.get(customerInfromId);
				customerRecord.setCustomerInfrom(customerInfrom);
			}
			if(customerRecordTargetId>0){
				CustomerRecordTarget customerRecordTarget = customerRecordTargetManageImpl.get(customerRecordTargetId);
				customerRecord.setCustomerRecordTarget(customerRecordTarget);
			}
			Integer status = customerRecord.getStatus();
			if(status==(int)CustomerRecord.STATUSCOMM){
				if (salerId<=0) {
					renderErrorMsg(new Throwable("提交错误，销售顾问信息不能为空"), "");
					return ;
				}
			}
			if(salerId>0){
				User user = userManageImpl.get(salerId);
				customerRecord.setSaler(user);
				customerRecord.setSalerName(user.getRealName());
			}
			if(agentPersonId>0){
				User user = userManageImpl.get(agentPersonId);
				customerRecord.setAgentUser(user);
			}
			String comeInTime = customerRecord.getComeInTime();
			if(null!=comeInTime){
				String[] split = comeInTime.split(":");
				if(null!=split&&split.length>0){
					String hour=split[0];
					if(null!=hour){
						int hourInt = Integer.parseInt(hour);
						customerRecord.setComeInHour(hourInt);
					}
				}
			}
			User user = getSessionUser();
			if(dbid==null||dbid<=0){
				customerRecord.setUser(user);
				customerRecord.setCreator(user.getRealName());
				
				if(null!=user){
					Enterprise enterprise = user.getEnterprise();
					if(null!=enterprise){
						customerRecord.setEnterprise(enterprise);
					}
				}
				customerRecord.setCreateDate(new Date());
				customerRecord.setModifyDate(new Date());
				CustomerType customerType = customerTypeManageImpl.get(customerTypeId);
				customerRecord.setCustomerType(customerType);
				if(status==(int)CustomerRecord.STATUSINVAL){
					customerRecord.setResultStatus(CustomerRecord.RESULTINVALIT);
				}else{
					customerRecord.setResultStatus(CustomerRecord.RESULTCOMM);
				}
				customerRecord.setOvertimeNum(0);
				customerRecord.setOvertimeStatus(CustomerRecord.OVERTIMECOMM);
				customerRecordManageImpl.save(customerRecord);
			}else{
				CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
				customerRecord2.setComeInTime(customerRecord.getComeInTime());
				CustomerType customerType = customerTypeManageImpl.get(customerTypeId);
				customerRecord2.setCustomerType(customerType);
				customerRecord2.setComeInType(customerRecord.getComeInType());
				customerRecord2.setCustomerNum(customerRecord.getCustomerNum());
				customerRecord2.setCustomerRecordTarget(customerRecord.getCustomerRecordTarget());
				customerRecord2.setCustomerInfrom(customerRecord.getCustomerInfrom());
				customerRecord2.setMobilePhone(customerRecord.getMobilePhone());
				customerRecord2.setName(customerRecord.getName());
				customerRecord2.setNote(customerRecord.getNote());
				customerRecord2.setSaler(customerRecord.getSaler());
				customerRecord2.setSalerName(customerRecord.getSalerName());
				customerRecord2.setSex(customerRecord.getSex());
				customerRecord2.setStatus(customerRecord.getStatus());
				customerRecord2.setComeinNum(customerRecord.getComeinNum());
				customerRecord2.setModifyDate(new Date());
				customerRecord2.setAgentUser(customerRecord.getAgentUser());
				customerRecord2.setAgentUser(customerRecord.getAgentUser());
				customerRecord2.setComeInHour(customerRecord.getComeInHour());
				customerRecordManageImpl.save(customerRecord2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		if(red==1){
			renderMsg("/qywxCustomerRecord/queryList", "保存数据成功！");
		}
		if(red==2){
			renderMsg("/qywxCustomerRecord/editComeShop", "保存数据成功！");
		}
		if(red==3){
			renderMsg("/qywxCustomerRecord/editPhone", "保存数据成功！");
		}
		return ;
	}

	/**
	 * 功能描述：无效线索
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
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			User currentUser = getSessionUser();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			String sql="select * from cust_CustomerRecord where status=? ";
			List param=new ArrayList();
			param.add(CustomerRecord.STATUSCOMM);
			sql=sql+" and (salerId=? or agentPersonId=?)";
			param.add(currentUser.getDbid());
			param.add(currentUser.getDbid());
			if(customerTypeId>0){
				sql=sql+" and customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(resultStatus>0){
				sql=sql+" and resultStatus=? ";
				param.add(resultStatus);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and like name ? ";
				param.add("%"+name+"%");
			}
			if(comeinNum>=0){
				sql=sql+" and comeinNum=? and  status="+CustomerRecord.STATUSCOMM;
				param.add(comeinNum);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+" order by resultStatus,createDate DESC";
			Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "salerList";
	}
	/**
	 * 功能描述： 销售顾问添加线索
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String salerEdit() throws Exception {
		HttpServletRequest request = this.getRequest();
		User currentUser = getSessionUser();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Enterprise enterprise = currentUser.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			if(dbid>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(dbid);
				request.setAttribute("customerRecord", customerRecord);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerRecord.getCustomerInfrom());
				request.setAttribute("customerInfromSelect", customerInfromSelect);
				
				if(null!=customerRecord&&customerRecord.getDbid()>0){
					Brand brand = customerRecord.getBrand();
					if(null!=brand){
						//意向车型
						List<CarSeriy>  carSeriys= carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carSeriys", carSeriys);
					}
					CarSeriy carSeriy = customerRecord.getCarSeriy();
					if(null!=carSeriy){
						List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carModels", carModels);
					}
				}
			}else{
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			
			
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", CustomerRecordTarget.TYPECOMIN);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
			
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "salerEdit";
	}
	/**
	 * 功能描述：查看明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			request.setAttribute("customerRecord", customerRecord2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "view";
	}
	/**
	 * 功能描述：保存销售顾问添加线索
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void saveSaler() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		try{
			User currentUser = getSessionUser();
			Integer dbid = customerRecord.getDbid();
			if(customerInfromId>0){
				CustomerInfrom customerInfrom = customerInfromManageImpl.get(customerInfromId);
				customerRecord.setCustomerInfrom(customerInfrom);
			}
			if(brandId>0){
				Brand brand = brandManageImpl.get(brandId);
				customerRecord.setBrand(brand);
			}
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerRecord.setCarSeriy(carSeriy);
			}
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerRecord.setCarModel(carModel);
			}
			CustomerType customerType = customerTypeManageImpl.get(customerTypeId);
			String comeInTime = customerRecord.getComeInTime();
			if(null!=comeInTime){
				String[] split = comeInTime.split(":");
				if(null!=split&&split.length>0){
					String hour=split[0];
					if(null!=hour){
						int hourInt = Integer.parseInt(hour);
						customerRecord.setComeInHour(hourInt);
					}
				}
			}
			
			if(dbid==null||dbid<=0){
				customerRecord.setUser(currentUser);
				customerRecord.setCreator(currentUser.getRealName());
				if(null!=currentUser){
					Enterprise enterprise = currentUser.getEnterprise();
					if(null!=enterprise){
						customerRecord.setEnterprise(enterprise);
					}
				}
				customerRecord.setCustomerType(customerType);
				customerRecord.setCreateDate(new Date());
				customerRecord.setModifyDate(new Date());
				customerRecord.setResultStatus(CustomerRecord.RESULTCOMM);
				customerRecord.setStatus(CustomerRecord.STATUSCOMM);
				customerRecord.setSaler(currentUser);
				customerRecord.setSalerName(currentUser.getRealName());
				customerRecord.setComeinNum(0);
				customerRecord.setOvertimeStatus(CustomerRecord.OVERTIMECOMM);
				customerRecord.setOvertimeNum(0);
				customerRecordManageImpl.save(customerRecord);
			}else{
				CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
				customerRecord2.setComeInTime(customerRecord.getComeInTime());
				customerRecord2.setCustomerNum(customerRecord.getCustomerNum());
				customerRecord2.setCustomerType(customerType);
				customerRecord2.setCustomerRecordTarget(customerRecord.getCustomerRecordTarget());
				customerRecord2.setCustomerInfrom(customerRecord.getCustomerInfrom());
				customerRecord2.setMobilePhone(customerRecord.getMobilePhone());
				customerRecord2.setName(customerRecord.getName());
				customerRecord2.setNote(customerRecord.getNote());
				customerRecord2.setSex(customerRecord.getSex());
				customerRecord2.setBrand(customerRecord.getBrand());
				customerRecord2.setCarSeriy(customerRecord.getCarSeriy());
				customerRecord2.setCarModel(customerRecord.getCarModel());
				customerRecord2.setComeinNum(customerRecord.getComeinNum());
				customerRecord2.setCarModelStr(customerRecord.getCarModelStr());
				customerRecord2.setComeInHour(customerRecord.getComeInHour());
				customerRecord2.setModifyDate(new Date());
				customerRecordManageImpl.save(customerRecord2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomerRecord/querySalerList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：验证线索客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String validateCustomerRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "customerRecordId", -1);
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			request.setAttribute("customerRecord", customerRecord2);
			List<CustomerRecordClubInvalidReason> customerRecordClubInvalidReasons = customerRecordClubInvalidReasonManageImpl.getAll();
			request.setAttribute("customerRecordClubInvalidReasons", customerRecordClubInvalidReasons);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "validateCustomerRecord";
	}
	/**
	 * 功能描述：销售顾问处理线索（无效客户）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String invalid() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			request.setAttribute("customerRecord", customerRecord2);
			List<CustomerRecordClubInvalidReason> customerRecordClubInvalidReasons = customerRecordClubInvalidReasonManageImpl.getAll();
			request.setAttribute("customerRecordClubInvalidReasons", customerRecordClubInvalidReasons);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "invalid";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryLeaderList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String saler = request.getParameter("saler");
		String resultStartTime = request.getParameter("resultStartTime");
		String resultEndTime = request.getParameter("resultEndTime");
		Integer overtimeStatus = ParamUtil.getIntParam(request, "overtimeStatus", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		try{
			if(customerInfromId>0){
				CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(customerInfromId);
				String cusString = customerInfromManageImpl.getCustomerInfrom(customerInfrom2);
				request.setAttribute("customerInfromSelect", cusString);
			}else{
				String cusString = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", cusString);
			}
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes",customerTypes);
			String sql="select * from cust_CustomerRecord where 1=1  ";
			List param=new ArrayList();
			User currentUser = getSessionUser();
			Enterprise enterprise = currentUser.getEnterprise();
			if(enterprise.getDbid()>0){
				sql=sql+" and enterpriseId="+enterprise.getDbid();
			}
			if(customerTypeId>0){
				sql=sql+" and customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(customerInfromId>0){
				sql=sql+" and customerInfromId=? ";
				param.add(customerInfromId);
			}
			if(status>0){
				sql=sql+" and status=? ";
				param.add(status);
			}
			if(resultStatus>0){
				sql=sql+" and resultStatus=? ";
				param.add(resultStatus);
			}
			if(overtimeStatus>0){
				sql=sql+" and overtimeStatus=? ";
				param.add(overtimeStatus);
			}
			if(null!=saler&&saler.trim().length()>0){
				sql=sql+" and salerName like ? ";
				param.add("%"+saler+"%");
			}
			
			if(comeinNum>=0){
				sql=sql+" and comeinNum=?  and status="+CustomerRecord.STATUSCOMM;
				param.add(comeinNum);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=resultStartTime&&resultStartTime.trim().length()>0){
				sql=sql+" and resultDate>= ? ";
				param.add(DateUtil.string2Date(resultStartTime));
			}
			if(null!=resultEndTime&&resultEndTime.trim().length()>0){
				sql=sql+" and resultDate< ? ";
				param.add(DateUtil.nextDay(resultEndTime));
			}
			sql=sql+" order by resultStatus,createDate DESC";
			Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "leaderList";
	}
	/**
	 * 功能描述：领导查询有效线索
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryLeaderEffList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer comeShopNum = ParamUtil.getIntParam(request, "comeShopNum", -1);
		Integer trackNum = ParamUtil.getIntParam(request, "trackNum", -1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String resultStartTime = request.getParameter("resultStartTime");
		String resultEndTime = request.getParameter("resultEndTime");
		String custName = request.getParameter("custName");
		String mobilePhone = request.getParameter("mobilePhone");
		String saler = request.getParameter("saler");
		try{
			User currentUser = getSessionUser();
			Enterprise enterprise = currentUser.getEnterprise();
			String departmentIds=null;
			if(departmentId>0){
				Department department = departmentManageImpl.get(departmentId);
				String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
			}else{
				String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
			}
			
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(), brandId, carSeriyId);
			request.setAttribute("carModels", carModels);
			
			
			String sql="select * from cust_CustomerRecord custre,cust_Customer cust ,cust_CustomerBussi as cb where custre.customerId=cust.dbid and cb.customerId=cust.dbid ";
			List param=new ArrayList();
			if(enterprise.getDbid()>0){
				sql=sql+" and custre.enterpriseId="+enterprise.getDbid();
			}
			if(carSeriyId>0){
				sql=sql+" and cb.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cb.brandId=? ";
				param.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cb.carModelId=? ";
				param.add(carModelId);
			}
			if(customerPhaseId>0){
				sql=sql+" and cust.customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(comeShopNum>0){
				if(comeShopNum==6){
					sql=sql+" and cust.comeShopNum>=? ";
				}else{
					sql=sql+" and cust.comeShopNum=? ";
				}
				param.add(comeShopNum);
			}
			if(trackNum>0){
				if(trackNum==6){
					sql=sql+" and cust.trackNum>=? ";
				}else{
					sql=sql+" and cust.trackNum=? ";
				}
				param.add(trackNum);
			}
			if(null!=departmentIds){
				sql=sql+" and cu.departmentId in("+departmentIds+")";
			}
			if(customerTypeId>0){
				sql=sql+" and custre.customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(status>0){
				sql=sql+" and custre.status=? ";
				param.add(status);
			}
			if(resultStatus>0){
				sql=sql+" and custre.resultStatus=? ";
				param.add(resultStatus);
			}
			if(null!=saler&&saler.trim().length()>0){
				sql=sql+" and custre.salerName like ? ";
				param.add("%"+saler+"%");
			}
			if(null!=custName&&custName.trim().length()>0){
				sql=sql+" and cust.name like ? ";
				param.add("%"+custName+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cust.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			
			if(comeinNum>0){
				sql=sql+" and custre.comeinNum=? ";
				param.add(comeinNum);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and custre.createDate>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and custre.createDate< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=resultStartTime&&resultStartTime.trim().length()>0){
				sql=sql+" and custre.resultDate>= ? ";
				param.add(DateUtil.string2Date(resultStartTime));
			}
			if(null!=resultEndTime&&resultEndTime.trim().length()>0){
				sql=sql+" and custre.resultDate< ? ";
				param.add(DateUtil.nextDay(resultEndTime));
			}
			sql=sql+" order by custre.resultStatus,custre.createDate DESC";
			Page<CustomerRecord> page= customerRecordManageImpl.pagedQuerySql(pageNo, pageSize, CustomerRecord.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "leaderEffList";
	}
	/**
	 * 功能描述：销售顾问处理线索（无效客户）保存
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveInvalid() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer customerRecordClubInvalidReasonId = ParamUtil.getIntParam(request, "customerRecordClubInvalidReasonId", -1);
		String invalidNote = request.getParameter("note");
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			CustomerRecordClubInvalidReason customerRecordClubInvalidReason = customerRecordClubInvalidReasonManageImpl.get(customerRecordClubInvalidReasonId);
			customerRecord2.setInvalidNote(invalidNote);
			customerRecord2.setCustomerRecordClubInvalidReason(customerRecordClubInvalidReason);
			customerRecord2.setResultStatus(CustomerRecord.RESULTINVALIT);
			customerRecord2.setResultDate(new Date());
			customerRecordManageImpl.save(customerRecord2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomerRecord/querySalerList", "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：封装推荐客户查询结果分页
	 * @param customers
	 * @return
	 */
	private String jsonCustoemr(List<CustomerRecord> customers){
		JSONArray jsonArray=new JSONArray();
		if(null!=customers&&customers.size()>0){
			for (CustomerRecord customerRecord : customers) {
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("dbid", customerRecord.getDbid());
				if(customerRecord.getName()==null){
					if(null==customerRecord.getCustomer()){
						jsonObject.put("name", "无");
					}else{
						jsonObject.put("name",customerRecord.getCustomer().getName());
					}
				}else{
					jsonObject.put("name",customerRecord.getName());
				}
				Customer customer = customerRecord.getCustomer();
				if(null!=customer){
					jsonObject.put("mobilePhone", customer.getMobilePhone());
				}else{
					jsonObject.put("mobilePhone", "");
				}
				jsonObject.put("address", customerRecord.getAddress());
				CustomerRecordTarget customerRecordTarget = customerRecord.getCustomerRecordTarget();
				if(customerRecordTarget!=null){
					jsonObject.put("customerRecordTarget", customerRecord.getCustomerRecordTarget().getName());
				}else{
					jsonObject.put("customerRecordTarget","无");
				}
				if(customerRecord.getStatus()==1){
					jsonObject.put("statustext", "<span style=\"color:green;\">登记有效</span>");
				}
				if(customerRecord.getStatus()==2){
					jsonObject.put("statustext", "<span style=\"color: red;\">登记无效</span>");
				}
				jsonObject.put("status", customerRecord.getStatus());
				
				jsonObject.put("createDate", DateUtil.format(customerRecord.getCreateDate()));
				CustomerType customerType = customerRecord.getCustomerType();
				if(null!=customerType){
					jsonObject.put("types", "<span style=\"color: red;\">"+customerType.getName()+"</span>");
					jsonObject.put("type", customerType.getDbid());
				}
				else{
					jsonObject.put("types", "<span style=\"color:orange;\">其他</span>");
				}
				if(null!=customerType){
						jsonObject.put("customerTypeStr",customerRecord.getCustomerType().getName());
				}else{
					jsonObject.put("customerTypeStr", "其他");
				}
				
				CustomerInfrom customerInfrom = customerRecord.getCustomerInfrom();
				if(null!=customerInfrom){
					jsonObject.put("customerInfromStr", customerInfrom.getName());
				}else{
					jsonObject.put("customerInfromStr", "");
				}
				
				if(null!=customerRecord.getBrand()){
					jsonObject.put("brand", customerRecord.getBrand().getName());
				}else{
					if(customerRecord.getCarModels()==null||customerRecord.getCarModels().trim().length()<0){
						jsonObject.put("brand", "-");
					}else{
						jsonObject.put("brand", customerRecord.getCarModels());
					}
				}
				if(null!=customerRecord.getCarModel()){
					jsonObject.put("carModel", customerRecord.getCarModel().getName());
				}else{
					jsonObject.put("carModel","");
				}
				if(null!=customerRecord.getCarSeriy()){
					jsonObject.put("carSeriy", customerRecord.getCarSeriy().getName());
				}else {
					jsonObject.put("carSeriy", "");
				}
				
				CustomerType customerType2 = customerRecord.getCustomerType();
				if(null!=customerType2&&customerType2.getDbid()==1){
					String comeInTime = customerRecord.getComeInTime();
					jsonObject.put("comeInTime",comeInTime);
					jsonObject.put("customerNum", customerRecord.getCustomerNum());
				}else{
					jsonObject.put("comeInTime", DateUtil.format3(customerRecord.getCreateDate()));
					jsonObject.put("customerNum", "?");
				}
				
				Integer resultStatus = customerRecord.getResultStatus();
				if(resultStatus==1){
					jsonObject.put("resultStatus", "<span style=\"color: pink;\">等待...</span>");
				}
				if(resultStatus==2){
					jsonObject.put("resultStatus", "<span style=\"color: green;\">转为登记</span>");
				}
				if(resultStatus==3){
					jsonObject.put("resultStatus", "<span style=\"color: red;\">无效</span>");
				}
				if(resultStatus==4){
					jsonObject.put("resultStatus", "<span style=\"color: green;\">已绑定</span>");
				}
				jsonObject.put("result", resultStatus);
				Integer comeinNum = customerRecord.getComeinNum();
				if(null==comeinNum){
					jsonObject.put("comeinNum", "未到店");
				}else{
					if(comeinNum==1){
						jsonObject.put("comeinNum", "初次到店");
					}
					if(comeinNum==2){
						jsonObject.put("comeinNum", "二次来店");
					}
					if(comeinNum==0){
						jsonObject.put("comeinNum", "未到店");
					}
				}
				
				if(null!=customerRecord.getEnterprise()){
					jsonObject.put("companyName", customerRecord.getEnterprise().getName());
				}else{
					jsonObject.put("companyName", "");
				}
				
				
				if(null!=customerRecord.getSaler()){
					jsonObject.put("saler", customerRecord.getSaler().getRealName());
					Department department = customerRecord.getSaler().getDepartment();
					if(null!=department){
						jsonObject.put("dep", department.getName());
					}
				}else{
					jsonObject.put("saler", "");
					jsonObject.put("dep", "");
				}
				if(null!=customerRecord.getAgentUser()){
					jsonObject.put("agentUserName", customerRecord.getAgentUser().getRealName());
				}else{
					jsonObject.put("agentUserName", "");
				}
				jsonObject.put("createDate", DateUtil.format(customerRecord.getCreateDate()));
				jsonObject.put("note", customerRecord.getNote());
				jsonArray.add(jsonObject);
			}
		}
		return jsonArray.toString();
	}
	/**
	 * 功能描述：线索登记验证
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void vlidateCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		User currentUser = getSessionUser();
		org.json.JSONObject object=new org.json.JSONObject();
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(customerRecordId);
			CustomerType customerType = customerRecord2.getCustomerType();
			if(customerType!=null&&customerType.getDbid()==1){
				String mobilePhone = customerRecord2.getMobilePhone();
				if(mobilePhone==null||mobilePhone==""){
					//进店客户
					object.put("state", 1);
				}else{
					SystemInfo systemInfo = systemInfoMangeImpl.get(SystemInfo.ROOT);
					object=customerMangeImpl.validateCustomer(mobilePhone, currentUser, systemInfo);
				}
			}
			else{
				String mobilePhone = customerRecord2.getMobilePhone();
				SystemInfo systemInfo = systemInfoMangeImpl.get(SystemInfo.ROOT);
				object=customerMangeImpl.validateCustomer(mobilePhone, currentUser, systemInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			object.put("state", 0);
		}
		renderJson(object.toString());
		return;
	}
	/**
	 * 功能描述：客户线索处理（线索已经绑定了客户）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void updateCustomerRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		JSONObject object=new JSONObject();
		try {
			CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
			Customer customer = customerMangeImpl.get(customerId);
			if(null==customer){
				object.put("state", 0);
				object.put("mesg","客户资料为空，请重试。如果问题一直存在请联系系统管理员。");
				renderJson(object.toString());
				return ;
			}
			//更新线索资料
			CustomerBussi customerBussi = customer.getCustomerBussi();
			customerRecord.setResultStatus(CustomerRecord.RESULTTRACK);
			customerRecord.setName(customer.getName());
			customerRecord.setMobilePhone(customer.getMobilePhone());
			customerRecord.setBrand(customerBussi.getBrand());
			customerRecord.setCarModel(customerBussi.getCarModel());
			customerRecord.setCarSeriy(customerBussi.getCarSeriy());
			customerRecord.setResultDate(new Date());
			customerRecord.setCustomer(customer);
			customerRecordManageImpl.save(customerRecord);
			
			//客户资料
			Integer trackNum = customer.getTrackNum();
			if(trackNum!=null){
				trackNum=trackNum+1;
			}else{
				trackNum=1;
			}
			customer.setTrackNum(trackNum);
			CustomerType customerType = customerRecord.getCustomerType();
			if (null!=customerType&&customerType.getDbid()==CustomerRecord.COMEINNUMCOMM) {
				Integer comeShopNum = customer.getComeShopNum();
				if(comeShopNum!=null){
					comeShopNum=comeShopNum+1;
				}else{
					comeShopNum=1;
				}
				customer.setComeShopNum(comeShopNum);
			}
			customerMangeImpl.save(customer);
			object.put("state", 1);
			object.put("url","/qywxCustomerFile/fileDetail?dbid="+customer.getDbid()+"&parentMenu=1");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			object.put("state", 0);
			object.put("mesg","系统错误，请重试。如果问题一直存在请联系系统管理员。");
		}
		renderJson(object.toString());
		return;
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
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					customerRecordManageImpl.deleteById(dbid);
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
		renderMsg("/qywxCustomerRecord/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxValidateMember() throws Exception {
		HttpServletRequest request = this.getRequest();
		String mobilePhone = request.getParameter("mobilePhone");
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		try {
			User saler = getSessionUser();
			SystemInfo systemInfo = systemInfoMangeImpl.get(SystemInfo.ROOT);
			org.json.JSONObject object = customerMangeImpl.validateCustomer(mobilePhone, saler, systemInfo);
			renderJson(object.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return ;
	}
	private int getComeInDate(){
		int min=0;
		Calendar cal = Calendar.getInstance();
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		if(hour%2==0){
			hour=hour/2;
			if(minute>=30){
				min=hour+1;
			}else{
				min=hour;
			}
			return min-1;
		}else{
			hour=hour/2+1;
			if(minute>=30){
				min=hour+1;
			}else{
				min=hour;
			}
			return min;
		}
	}
}
