package com.ystech.cust.action;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.excel.CustomerRecordCustomerToExcel;
import com.ystech.core.excel.CustomerRecordExcel;
import com.ystech.core.excel.CustomerRecordToExcel;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.FileNameUtil;
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
import com.ystech.stat.customerrecord.model.StatCustomerRecord;
import com.ystech.stat.customerrecord.service.StaCustomerRecordRoomManageImpl;
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

@Component("customerRecordAction")
@Scope("prototype")
public class CustomerRecordAction extends BaseController{
	private File file;
	private String fileFileName;
	private String fileContentType;
	private String[] allowFiles = { ".xls", ".xlsx" };
	// 文件大小限制，单位KB
	private int maxSize = 10240;
	private CustomerMangeImpl customerMangeImpl;
	private CustomerRecord customerRecord;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerRecordTargetManageImpl customerRecordTargetManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private UserManageImpl userManageImpl;
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CustomerRecordToExcel customerRecordToExcel;
	private CustomerRecordClubInvalidReasonManageImpl customerRecordClubInvalidReasonManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerRecordCustomerToExcel customerRecordCustomerToExcel;
	private DepartmentManageImpl departmentManageImpl;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	private StaCustomerRecordRoomManageImpl staCustomerRecordManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	@Resource
	public void setCustomerRecordTargetManageImpl(
			CustomerRecordTargetManageImpl customerRecordTargetManageImpl) {
		this.customerRecordTargetManageImpl = customerRecordTargetManageImpl;
	}
	
	public CustomerRecord getCustomerRecord() {
		return customerRecord;
	}

	public void setCustomerRecord(CustomerRecord customerRecord) {
		this.customerRecord = customerRecord;
	}
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
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
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}

	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
	public void setCustomerRecordToExcel(CustomerRecordToExcel customerRecordToExcel) {
		this.customerRecordToExcel = customerRecordToExcel;
	}
	
	@Resource
	public void setCustomerRecordCustomerToExcel(
			CustomerRecordCustomerToExcel customerRecordCustomerToExcel) {
		this.customerRecordCustomerToExcel = customerRecordCustomerToExcel;
	}
	
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}

	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	 @Resource
	public void setStaCustomerRecordManageImpl(
			StaCustomerRecordRoomManageImpl staCustomerRecordManageImpl) {
		this.staCustomerRecordManageImpl = staCustomerRecordManageImpl;
	}
	 @Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
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
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		Integer overtimeStatus = ParamUtil.getIntParam(request, "overtimeStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String saler = request.getParameter("saler");
		String creator = request.getParameter("creator");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			 User currentUser = SecurityUserHolder.getCurrentUser();
			 String sql="select * from cust_CustomerRecord where 1=1 ";
			 List param=new ArrayList();
			 sql=sql+" and creatorId=? ";
			 param.add(currentUser.getDbid());
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
			 if(customerTypeId>0){
				 sql=sql+" and customerTypeId=? ";
				 param.add(customerTypeId);
			 }
			 if(null!=saler&&saler.trim().length()>0){
				 sql=sql+" and salerName like ? ";
				 param.add("%"+saler+"%");
			 }
			 if(null!=creator&&creator.trim().length()>0){
				 sql=sql+" and creator like ? ";
				 param.add("%"+creator+"%");
			 }
			 if(null!=creator&&creator.trim().length()>0){
				 sql=sql+" and creator like ? ";
				 param.add("%"+creator+"%");
			 }
			 if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				 sql=sql+" and mobilePhone like ? ";
				 param.add("%"+mobilePhone+"%");
			 }
			 if(null!=name&&name.trim().length()>0){
				 sql=sql+" and name like ? ";
				 param.add("%"+name+"%");
			 }
			 
			 if(comeinNum>0){
				 sql=sql+" and comeinNum=? AND customerTypeId=1 and status="+CustomerRecord.STATUSCOMM;
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
			
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<StatCustomerRecord> statCustomerRecords = staCustomerRecordManageImpl.findByEnterpriseIdAndRoom(enterprise);
			request.setAttribute("statCustomerRecords", statCustomerRecords);
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
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
	public String queryLeaderValidList() throws Exception {
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String departmentIds=null;
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Department parent = departmentManageImpl.get(Department.ROOT);
			/*	if(departmentId>0){
					Department department = departmentManageImpl.get(departmentId);
					String departmentSelect = departmentManageImpl.getDepartmentSelect(department,parent);
					request.setAttribute("departmentSelect", departmentSelect);
					departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				}else{
					String departmentSelect = departmentManageImpl.getDepartmentSelect(null,parent);
					request.setAttribute("departmentSelect", departmentSelect);
				}*/
			}else{
				if(departmentId>0){
					Department department = departmentManageImpl.get(departmentId);
					String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
					departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				}else{
					String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
				}
			}
			
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			String hql="select * from set_carmodel where 1=1 ";
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			if(carSeriyId>0){
				//车型
				hql=hql+" and carSeriesId="+carSeriyId;
			}
			List<CarModel> carModels = carModelManageImpl.executeSql(hql, null);
			request.setAttribute("carModels", carModels);
			
			
			String sql="select * from cust_CustomerRecord custre,cust_Customer cust ,cust_CustomerBussi as cb where custre.customerId=cust.dbid and cb.customerId=cust.dbid ";
			List param=new ArrayList();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and custre.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
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
		return "leaderValidList";
	}
	/**
	 * 功能描述：销售顾问线索
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
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			String sql="select * from cust_CustomerRecord where status=? ";
			List param=new ArrayList();
			param.add(CustomerRecord.STATUSCOMM);
			sql=sql+" and (salerId=? or agentPersonId=?)";
			param.add(currentUser.getDbid());
			param.add(currentUser.getDbid());
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(customerTypeId>0){
				sql=sql+" and customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(resultStatus>0){
				sql=sql+" and resultStatus=? ";
				param.add(resultStatus);
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
			
			List<StatCustomerRecord> statCustomerRecords = staCustomerRecordManageImpl.findBySalerId(currentUser);
			request.setAttribute("statCustomerRecords", statCustomerRecords);

		}catch (Exception e) {
			e.printStackTrace();
		}
		return "salerList";
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
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer comeInType = ParamUtil.getIntParam(request, "comeInType", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		Integer overtimeStatus = ParamUtil.getIntParam(request, "overtimeStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String saler = request.getParameter("saler");
		String creator = request.getParameter("creator");
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from cust_CustomerRecord where status=? AND customerID IS NOT NULL ";
			List param=new ArrayList();
			param.add(CustomerRecord.STATUSCOMM);
			sql=sql+" and creatorId=? ";
			param.add(currentUser.getDbid());
			 if(comeInType>0){
				 sql=sql+" and comeInType=? ";
				 param.add(comeInType);
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
			 if(customerTypeId>0){
				 sql=sql+" and customerTypeId=? ";
				 param.add(customerTypeId);
			 }
			 if(null!=saler&&saler.trim().length()>0){
				 sql=sql+" and salerName like ? ";
				 param.add("%"+saler+"%");
			 }
			 if(null!=creator&&creator.trim().length()>0){
				 sql=sql+" and creator like ? ";
				 param.add("%"+creator+"%");
			 }
			 if(null!=creator&&creator.trim().length()>0){
				 sql=sql+" and creator like ? ";
				 param.add("%"+creator+"%");
			 }
			 if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				 sql=sql+" and mobilePhone like ? ";
				 param.add("%"+mobilePhone+"%");
			 }
			 if(null!=name&&name.trim().length()>0){
				 sql=sql+" and name like ? ";
				 param.add("%"+name+"%");
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
	 * @return
	 * @throws Exception
	 */
	public String importExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "importExcel";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String saveImportExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		User currentUser2 = SecurityUserHolder.getCurrentUser();
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		File dataFile = null;
		DatabaseUnitHelper databaseUnitHelper=new DatabaseUnitHelper();
		Connection jdbcUpdate = databaseUnitHelper.getJdbcConnection();
		jdbcUpdate.setAutoCommit(false);
		String insertSeql="INSERT INTO cust_customerrecord " +
				"	(comeInTime,customerNum,customerTypeId,createDate,modifyDate,salerId,targetId,name,sex," +
				"	 mobilePhone,customerInfromId,note,creatorId,status,resultStatus,invalidReasonId,invalidNote,enterpriseId,comeinNum,resultDate," +
				"		brandId,carSeriyId,carModelId,carColorId,address,carModels,overtimeStatus,overtimeNum,salerName,carModelStr,creator)" +
				"  VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement prepareStatement = jdbcUpdate.prepareStatement(insertSeql);
		try {
			Long startTime = System.currentTimeMillis();  
			if (null != file && !file.getName().trim().equals("")) {// getName()返回文件名称，如果是空字符串，说明没有选择文件。
				dataFile = FileNameUtil.getResourceFile(fileFileName);
				FileUtils.copyFile(file, dataFile);
				boolean checkFileType = checkFileType(dataFile.getName());
				if (checkFileType) {
					CustomerRecordExcel customerRecordExcel=new CustomerRecordExcel(customerRecordManageImpl,customerInfromManageImpl,userManageImpl);
					boolean validateDocument = CustomerRecordExcel.validateDocument(dataFile);
					if (validateDocument) {
						boolean validateForm = CustomerRecordExcel.validateForm(dataFile);
						if (validateForm) {
							List<StringBuffer> errorMessges = customerRecordExcel.validateFactoryOrder(dataFile);
							if(null==errorMessges||errorMessges.size()<=0){
								List<CustomerRecord> customerRecords = customerRecordExcel.getFactoryOrders(dataFile);
								for (CustomerRecord customerRecord : customerRecords) {
									prepareStatement.setInt(1,8);
									prepareStatement.setInt(2,1);
									prepareStatement.setInt(3,3);//网络导入数据
									prepareStatement.setString(4,DateUtil.format2(customerRecord.getCreateDate()));
									prepareStatement.setString(5,DateUtil.format2(customerRecord.getCreateDate()));
									prepareStatement.setInt(6,customerRecord.getSaler().getDbid());
									prepareStatement.setInt(7, 1);//来电目的 咨询
									prepareStatement.setString(8,customerRecord.getName());//客户姓名
									prepareStatement.setString(9, customerRecord.getSex());//客户性别
									prepareStatement.setString(10, customerRecord.getMobilePhone());//联系电话
									prepareStatement.setInt(11,customerRecord.getCustomerInfrom().getDbid());//客户来源
									prepareStatement.setString(12,"");//备注
									prepareStatement.setInt(13, currentUser2.getDbid());//创建人
									prepareStatement.setInt(14, CustomerRecord.STATUSCOMM);//线索有效状态
									prepareStatement.setInt(15, customerRecord.RESULTCOMM);//客户销售顾问登记状态
									prepareStatement.setString(16, null);//无效客户原因
									prepareStatement.setString(17,null);//无效客户备注
									prepareStatement.setInt(18, enterprise.getDbid());//所在公司
									prepareStatement.setInt(19,0);//进店人数
									prepareStatement.setDate(20,null);
									prepareStatement.setInt(21, -1);//品牌
									prepareStatement.setInt(22, -1);//车系
									prepareStatement.setInt(23,-1);//车型
									prepareStatement.setInt(24,-1);//颜色
									prepareStatement.setString(25, customerRecord.getAddress());
									prepareStatement.setString(26,customerRecord.getCarModels());
									prepareStatement.setInt(27,CustomerRecord.OVERTIMECOMM);
									prepareStatement.setInt(28,0);
									prepareStatement.setString(29,customerRecord.getSaler().getRealName());
									prepareStatement.setString(30,customerRecord.getCarModels());
									prepareStatement.setString(31,currentUser2.getRealName());
									prepareStatement.addBatch();
								}
								prepareStatement.executeBatch();
								jdbcUpdate.commit();
								
								prepareStatement.close();
								jdbcUpdate.close();
								Long endTime = System.currentTimeMillis();  
								SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss:SS");  
								System.out.println("用时：" + sdf.format(new Date(endTime - startTime)));  
							}else {
								String str="<table>";
								for (StringBuffer string : errorMessges) {
									str=str+"<tr><td>"+string.toString()+"</td></tr>";
								}
								str=str+"</table>";
							   request.setAttribute("error", str);
							   return "error";
							}
						} else {
							request.setAttribute("error","文件模块错误!");
							return "error";
						}
					} else {
						request.setAttribute("error","文件内容为空!");
						return "error";
					}
				} else {
					request.setAttribute("error","上传文件类型错误!");
					return "error";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error","上传失败!");
			return "error";
		}
		if (dataFile == null && !dataFile.exists()) {
			request.setAttribute("error","上传失败!");
			return "error";
		}
		request.setAttribute("success","上传数据成功!");
		return "success";
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
			}
			int comeInDate = getComeInDate();
			request.setAttribute("comeInDate", comeInDate);
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
			User user = SecurityUserHolder.getCurrentUser();
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
				CustomerType customerType = customerTypeManageImpl.get(customerTypeId);
				customerRecord2.setCustomerType(customerType);
				customerRecord2.setComeInTime(customerRecord.getComeInTime());
				customerRecord2.setCustomerType(customerRecord.getCustomerType());
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
			renderMsg("/customerRecord/queryList", "保存数据成功！");
		}
		if(red==2){
			renderMsg("/customerRecord/editComeShop", "保存数据成功！");
		}
		if(red==3){
			renderMsg("/customerRecord/editPhone", "保存数据成功！");
		}
		return ;
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
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			
			request.setAttribute("enterprise", enterprise);
			
			List<CustomerRecordTarget> customerRecordTargets = customerRecordTargetManageImpl.findBy("type", CustomerRecordTarget.TYPECOMIN);
			request.setAttribute("customerRecordTargets", customerRecordTargets);
			
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
		} catch (Exception e) {
		}
		return "salerEdit";
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
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		try{
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
			User user = SecurityUserHolder.getCurrentUser();
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
				customerRecord.setUser(user);
				customerRecord.setCreator(user.getRealName());
				if(null!=user){
					Enterprise enterprise = user.getEnterprise();
					if(null!=enterprise){
						customerRecord.setEnterprise(enterprise);
					}
				}
				customerRecord.setCustomerType(customerType);
				customerRecord.setCreateDate(new Date());
				customerRecord.setModifyDate(new Date());
				customerRecord.setResultStatus(CustomerRecord.RESULTCOMM);
				customerRecord.setStatus(CustomerRecord.STATUSCOMM);
				customerRecord.setSaler(user);
				customerRecord.setSalerName(user.getRealName());
				customerRecord.setComeinNum(0);
				customerRecord.setOvertimeStatus(CustomerRecord.OVERTIMECOMM);
				customerRecord.setOvertimeNum(0);
				customerRecordManageImpl.save(customerRecord);
			}else{
				CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
				customerRecord2.setComeInTime(customerRecord.getComeInTime());
				customerRecord2.setCustomerType(customerType);
				customerRecord2.setCustomerNum(customerRecord.getCustomerNum());
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
				customerRecord2.setModifyDate(new Date());
				customerRecord2.setComeInHour(customerRecord.getComeInHour());
				customerRecord2.setCarModelStr(customerRecord.getCarModelStr());
				customerRecordManageImpl.save(customerRecord2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerRecord/querySalerList", "保存数据成功！");
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
		if(type==1){
			renderMsg("/customerRecord/queryList"+query, "删除数据成功！");
		}else{
			renderMsg("/customerRecord/queryLeaderList"+query, "删除数据成功！");
		}
		return;
	}
	/**
	 * 功能描述：查看线索明细
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
	 * 功能描述：销售顾问处理线索（无效客户）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String invalid() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try {
			if(type==1){
				Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
				CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
				request.setAttribute("customerRecord", customerRecord2);
			}
			if(type==2){
				String names = ParamUtil.getParamUTF8(request, "names");
				request.setAttribute("names", names);
			}
			List<CustomerRecordClubInvalidReason> customerRecordClubInvalidReasons = customerRecordClubInvalidReasonManageImpl.getAll();
			request.setAttribute("customerRecordClubInvalidReasons", customerRecordClubInvalidReasons);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "invalid";
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
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer customerRecordClubInvalidReasonId = ParamUtil.getIntParam(request, "customerRecordClubInvalidReasonId", -1);
		String invalidNote = request.getParameter("note");
		try {
			if(type<1||type>2){
				renderErrorMsg(new Throwable("保存失败，未知操作"), "");
				return ;
			}
			CustomerRecordClubInvalidReason customerRecordClubInvalidReason = customerRecordClubInvalidReasonManageImpl.get(customerRecordClubInvalidReasonId);
			if(type==1){
				Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
				CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
				customerRecord2.setInvalidNote(invalidNote);
				customerRecord2.setCustomerRecordClubInvalidReason(customerRecordClubInvalidReason);
				customerRecord2.setResultStatus(CustomerRecord.RESULTINVALIT);
				customerRecord2.setResultDate(new Date());
				customerRecordManageImpl.save(customerRecord2);
			}
			if(type==2){
				Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
				for (Integer dbid : dbids) {
					CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
					customerRecord2.setInvalidNote(invalidNote);
					customerRecord2.setCustomerRecordClubInvalidReason(customerRecordClubInvalidReason);
					customerRecord2.setResultStatus(CustomerRecord.RESULTINVALIT);
					customerRecord2.setResultDate(new Date());
					customerRecordManageImpl.save(customerRecord2);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerRecord/querySalerList", "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：客户二次到店绑定客户页面跳转
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String bindCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			request.setAttribute("customerRecord", customerRecord2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "bindCustomer";
	}
	/**
	 * 功能描述：客户二次到店绑定客户保存
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveBindCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(dbid);
			Customer customer = customerMangeImpl.get(customerId);
			if(null==customer){
				renderErrorMsg(new Throwable("保存数据错误，无绑定客户"), "");
				return;
			}
			customerRecord2.setResultDate(new Date());
			customerRecord2.setCustomer(customer);
			customerRecordManageImpl.save(customerRecord2);
			Integer comeShopNum = customer.getComeShopNum();
			if(null==comeShopNum){
				comeShopNum=1;
			}else{
				comeShopNum=comeShopNum+1;
			}
			customer.setComeShopNum(comeShopNum);
			customerMangeImpl.save(customer);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return;
		}
		renderMsg("/customerRecord/querySalerList", "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：获取二次进店客户资料
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxUserCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			List<Customer> customers=new ArrayList<Customer>();
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(null==currentUser){
				currentUser = getSessionUser();
			}
			if(null==currentUser){
				return ;
			}
			String sql="select * from cust_customer where 1=1 ";
			if(null!=currentUser){
				sql=sql+" and bussiStaffId="+currentUser.getDbid();
			}else{
				return ;
			}
			sql=sql+" and (name like ?  or mobilePhone like ? ) ";
			customers= customerMangeImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			JSONArray  array=new JSONArray();
			if(null!=customers&&customers.size()>0){
				for (Customer customer : customers) {
					JSONObject object=new JSONObject();
					object.put("dbid", customer.getDbid());
					object.put("name", customer.getName());
					if(null!=customer.getUser()){
						object.put("salerId", customer.getUser().getDbid());
						object.put("salerName", customer.getBussiStaff());
					}
					object.put("mobilePhone", customer.getMobilePhone());
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			return ;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}
	/**
	 * 功能描述：获取二次进店客户资料
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String pingyin = request.getParameter("q");
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}
			List<Customer> customers=new ArrayList<Customer>();
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(null==currentUser){
				currentUser = getSessionUser();
			}
			if(null==currentUser){
				return ;
			}
			String sql="select * from cust_customer where 1=1 ";
			if(currentUser.getUserId().contains("super")||currentUser.getUserId().contains("zhaochendi")){
				
			}else{
				if(null==enterprise){
					enterprise = currentUser.getEnterprise();
				}
				if(null!=enterprise){
					sql=sql+" and enterpriseId="+enterprise.getDbid();
				}else{
					return ;
				}
			}
			sql=sql+" and (name like ?  or mobilePhone like ? ) ";
			customers= customerMangeImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			JSONArray  array=new JSONArray();
			if(null!=customers&&customers.size()>0){
				for (Customer customer : customers) {
					JSONObject object=new JSONObject();
					object.put("dbid", customer.getDbid());
					object.put("name", customer.getName());
					if(null!=customer.getUser()){
						object.put("salerId", customer.getUser().getDbid());
						object.put("salerName", customer.getBussiStaff());
					}
					object.put("mobilePhone", customer.getMobilePhone());
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			return ;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return;
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
		User currentUser = SecurityUserHolder.getCurrentUser();
		JSONObject object=new JSONObject();
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
			if (customerType!=null&&customerType.getDbid()==CustomerRecord.COMEINNUMCOMM) {
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
			object.put("url","/custCustomer/edit?dbid="+customer.getDbid()+"&type=2");
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
	 * @return
	 * @throws Exception
	 */
	public void downExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = getResponse();
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer comeinNum = ParamUtil.getIntParam(request, "comeinNum", -1);
		Integer resultStatus = ParamUtil.getIntParam(request, "resultStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String resultStartTime = request.getParameter("resultStartTime");
		String resultEndTime = request.getParameter("resultEndTime");
		String saler = request.getParameter("saler");
		try{
			String fileName="";
			if(null!=startTime&&startTime.trim().length()>0){
				fileName=fileName+""+startTime;
			}
			
			if(null!=endTime&&endTime.trim().length()>0){
				fileName=fileName+"至"+endTime;
			}else{
				fileName=fileName+"至"+DateUtil.format(new Date());
			}
			String sql="select * from cust_CustomerRecord where 1=1 ";
			List param=new ArrayList();
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and enterpriseId="+enterprise.getDbid();
			}
			if(customerTypeId>0){
				sql=sql+" and customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(status>0){
				sql=sql+" and status=? ";
				param.add(status);
			}
			if(resultStatus>0){
				sql=sql+" and resultStatus=? ";
				param.add(resultStatus);
			}
			if(null!=saler&&saler.trim().length()>0){
				sql=sql+" and salerName like ? ";
				param.add("%"+saler+"%");
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
			if(null!=resultStartTime&&resultStartTime.trim().length()>0){
				sql=sql+" and resultDate>= ? ";
				param.add(DateUtil.string2Date(resultStartTime));
			}
			if(null!=resultEndTime&&resultEndTime.trim().length()>0){
				sql=sql+" and resultDate< ? ";
				param.add(DateUtil.nextDay(resultEndTime));
			}
			fileName=fileName+"登记线索资料";
			sql=sql+" order by resultStatus,createDate DESC";
			List<CustomerRecord> customerRecords = customerRecordManageImpl.executeSql(sql, param.toArray());
			String file = customerRecordToExcel.writeExcel(fileName, customerRecords);
			downFile(request, response, file);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
	public void downCustomerExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = this.getResponse();
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
			String fileName="";
			if(null!=startTime&&startTime.trim().length()>0){
				fileName=fileName+""+startTime;
			}
			
			if(null!=endTime&&endTime.trim().length()>0){
				fileName=fileName+"至"+endTime;
			}else{
				fileName=fileName+"至"+DateUtil.format(new Date());
			}
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String departmentIds=null;
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Department parent = departmentManageImpl.get(Department.ROOT);
				/*if(departmentId>0){
					Department department = departmentManageImpl.get(departmentId);
					String departmentSelect = departmentManageImpl.getDepartmentSelect(department,parent);
					request.setAttribute("departmentSelect", departmentSelect);
					departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				}else{
					String departmentSelect = departmentManageImpl.getDepartmentSelect(null,parent);
					request.setAttribute("departmentSelect", departmentSelect);
				}*/
			}else{
				if(departmentId>0){
					Department department = departmentManageImpl.get(departmentId);
					String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
					departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				}else{
					String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
				}
			}
			String sql="select * from cust_CustomerRecord custre,cust_Customer cust ,cust_CustomerBussi as cb where custre.customerId=cust.dbid and cb.customerId=cust.dbid ";
			List param=new ArrayList();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and custre.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
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
			List<CustomerRecord> customerRecords = customerRecordManageImpl.executeSql(sql, param.toArray());
			String file = customerRecordCustomerToExcel.writeExcel(fileName, customerRecords);
			downFile(request, response, file);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	/**
	 * 文件类型判断
	 * 
	 * @param fileName
	 * @return
	 */
	private boolean checkFileType(String fileName) {
		Iterator<String> type = Arrays.asList(this.allowFiles).iterator();
		while (type.hasNext()) {
			String ext = type.next();
			if (fileName.toLowerCase().endsWith(ext)) {
				return true;
			}
		}
		return false;
	}
	
	private int getComeInDate(){
		int min=0;
		Calendar cal = Calendar.getInstance();
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		int minute = cal.get(Calendar.MINUTE);
		if(minute>=30){
			min=hour+1;
		}else{
			min=hour;
		}
		return min;
	}
	

	
}

