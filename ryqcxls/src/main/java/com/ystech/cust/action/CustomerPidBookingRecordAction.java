/**
 * 
 */
package com.ystech.cust.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.excel.CustomerPidBookingRecordToExcel;
import com.ystech.core.excel.CustomerSuccessToExcel;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarVinCode;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerImageApproval;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingCancelRecord;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerPidCancel;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.TimeoutsTrackRecord;
import com.ystech.cust.service.CarVinCodeManageImpl;
import com.ystech.cust.service.CustomerImageApprovalManageImpl;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerPidBookingCancelRecordManageImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.CustomerPidCancelManageImpl;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.TimeoutsTrackRecordManageImpl;
import com.ystech.qywx.core.QywxSendMessageUtil;
import com.ystech.qywx.model.RedBag;
import com.ystech.qywx.service.RedBagManageImpl;
import com.ystech.qywx.service.SendRedBagUtil;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarColor;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarColorManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * 功能描述：交车预约表，类似合同管理
 * @author shusanzhan
 * @date 2014-2-28
 */
@Component("customerPidBookingRecordAction")
@Scope("prototype")
public class CustomerPidBookingRecordAction extends BaseController{
	private CustomerPidBookingRecord customerPidBookingRecord;
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractManageImpl orderContractManageImpl;
	private BrandManageImpl brandManageImpl;
	private UserManageImpl userManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerPidCancelManageImpl customerPidCancelManageImpl;
	private HttpServletRequest request=getRequest();
	private CarColorManageImpl carColorManageImpl;
	private CarVinCodeManageImpl carVinCodeManageImpl;
	private TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
    private QywxSendMessageUtil qywxSendMessageUtil;
    private CustomerSuccessToExcel customerSuccessToExcel;
    private CustomerPidBookingRecordToExcel customerPidBookingRecordToExcel;
    private CustomerPidBookingCancelRecordManageImpl customerPidBookingCancelRecordManageImpl;
    private CustomerImageApprovalManageImpl customerImageApprovalManageImpl;
    private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
    private RedBagManageImpl redBagManageImpl;
    private SendRedBagUtil sendRedBagUtil;
    private RecommendCustomerManageImpl recommendCustomerManageImpl;
    private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
    
	public CustomerPidBookingRecord getCustomerPidBookingRecord() {
		return customerPidBookingRecord;
	}
	public void setCustomerPidBookingRecord(
			CustomerPidBookingRecord customerPidBookingRecord) {
		this.customerPidBookingRecord = customerPidBookingRecord;
	}
	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
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
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
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
	@Resource
	public void setCustomerPidCancelManageImpl(
			CustomerPidCancelManageImpl customerPidCancelManageImpl) {
		this.customerPidCancelManageImpl = customerPidCancelManageImpl;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource
	public void setCarVinCodeManageImpl(CarVinCodeManageImpl carVinCodeManageImpl) {
		this.carVinCodeManageImpl = carVinCodeManageImpl;
	}
	@Resource
	public void setTimeoutsTrackRecordManageImpl(
			TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl) {
		this.timeoutsTrackRecordManageImpl = timeoutsTrackRecordManageImpl;
	}
	
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	@Resource
	public void setQywxSendMessageUtil(QywxSendMessageUtil qywxSendMessageUtil) {
		this.qywxSendMessageUtil = qywxSendMessageUtil;
	}
	@Resource
	public void setCustomerSuccessToExcel(
			CustomerSuccessToExcel customerSuccessToExcel) {
		this.customerSuccessToExcel = customerSuccessToExcel;
	}
	@Resource
	public void setCustomerPidBookingRecordToExcel(
			CustomerPidBookingRecordToExcel customerPidBookingRecordToExcel) {
		this.customerPidBookingRecordToExcel = customerPidBookingRecordToExcel;
	}
	@Resource
	public void setCustomerPidBookingCancelRecordManageImpl(
			CustomerPidBookingCancelRecordManageImpl customerPidBookingCancelRecordManageImpl) {
		this.customerPidBookingCancelRecordManageImpl = customerPidBookingCancelRecordManageImpl;
	}
	@Resource
	public void setCustomerImageApprovalManageImpl(
			CustomerImageApprovalManageImpl customerImageApprovalManageImpl) {
		this.customerImageApprovalManageImpl = customerImageApprovalManageImpl;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setRedBagManageImpl(RedBagManageImpl redBagManageImpl) {
		this.redBagManageImpl = redBagManageImpl;
	}
	@Resource
	public void setSendRedBagUtil(SendRedBagUtil sendRedBagUtil) {
		this.sendRedBagUtil = sendRedBagUtil;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setAgentOperatorLogManageImpl(
			AgentOperatorLogManageImpl agentOperatorLogManageImpl) {
		this.agentOperatorLogManageImpl = agentOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	/** 
	 * 功能描述：查询代交车记录（打印合同记录）
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryWatingList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer wlStatus = ParamUtil.getIntParam(request, "wlStatus", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			//意向购车时间
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			Page<Customer> page= customerMangeImpl.queryOrderContract(pageNo,pageSize,currentUser.getDbid(),wlStatus,mobilePhone);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "watingList";
	}
	/**
	 * 功能描述：查询代交车记录（打印合同记录）销售副总经理
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryApprovalWatingList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer wlStatus = ParamUtil.getIntParam(request, "wlStatus", -1);
		Integer hasCarOrder = ParamUtil.getIntParam(request, "hasCarOrder", -1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer pidStatus = ParamUtil.getIntParam(request, "pidStatus", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userName = request.getParameter("userName");
		String name = request.getParameter("name");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String departmentIds=null;
			if(departmentId>0){
				Department department = departmentManageImpl.get(departmentId);
				String departmentSelect = departmentManageImpl.getDepartmentSelect(department,null);
				request.setAttribute("departmentSelect", departmentSelect);
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
			}else{
				String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
				request.setAttribute("departmentSelect", departmentSelect);
			}
			//车系
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarColor>  carColors= carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			String currentDepIds = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_customerLastBussi clb where clb.customerId=cu.dbid and cpid.customerId=cu.dbid and cpid.pidStatus>=? and cpid.pidStatus!=2 ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
			}
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.PRINT);
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.createTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.departmentId in ("+departmentIds+")";
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and clb.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and clb.brandId=? ";
				param.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				param.add(carModelId);
			}
			if(carColorId>0){
				sql=sql+" and clb.carColor=? ";
				param.add(carColorId);
			}
			if(wlStatus>-1){
				sql=sql+" and cpid.wlStatus = ? ";
				param.add(wlStatus);
			}
			if(pidStatus>-1){
				sql=sql+" and cpid.pidStatus = ? ";
				param.add(pidStatus);
			}
			if(null!=hasCarOrder&&hasCarOrder>0){
				sql=sql+" and cpid.hasCarOrder=? ";
					param.add(hasCarOrder);
			}
			sql=sql+" order by cpid.pidStatus DESC,cpid.createTime DESC";
			
			Page<Customer> page= customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "watingApprovalList";
	}
	/**
	 * 功能描述：查询代交车记录（打印合同记录）销总经理
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryManageWatingList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer wlStatus = ParamUtil.getIntParam(request, "wlStatus", -1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer hasCarOrder = ParamUtil.getIntParam(request, "hasCarOrder", -1);
		Integer pidStatus = ParamUtil.getIntParam(request, "pidStatus", -1);
		String startTime = request.getParameter("startTime");
		String userName = request.getParameter("userName");
		String endTime = request.getParameter("endTime");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			
			Page<Customer> page= customerMangeImpl.queryOrderManageContract(pageNo,pageSize,pidStatus,mobilePhone,wlStatus,departmentIds,userName,startTime,endTime,hasCarOrder);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "watingManageList";
	}
	/**
	 * 功能描述：成交客户信息表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String customerSuccess() throws Exception {
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		String mobilePhone = request.getParameter("mobilePhone");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String startOrderTime = request.getParameter("startOrderTime");
		String endOrderTime = request.getParameter("endOrderTime");
		String startSuccessTime = request.getParameter("startSuccessTime");
		String endSuccessTime = request.getParameter("endSuccessTime");
		String vinCode = request.getParameter("vinCode");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			if(customerInfromId>0){
				CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(customerInfromId);
				String cusString = customerInfromManageImpl.getCustomerInfrom(customerInfrom2);
				request.setAttribute("customerInfromSelect", cusString);
			}else{
				String cusString = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", cusString);
			}
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String sql="select * from "
					+ "cust_Customer as cu,"
					+ " cust_CustomerPidBookingRecord as cpid "
					+ "  where"
					+ "  cpid.customerId=cu.dbid AND cu.bussiStaffId=?  and cpid.pidStatus=? ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			param.add(CustomerPidBookingRecord.FINISHED);
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cpid.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
			}
			if(brandId>0){
				sql=sql+" and cpid.brandId=? ";
				param.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				param.add(carModelId);
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
			}
			if(customerTypeId>0){
				sql=sql+" and cu.customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(comeShopStatus>0){
				sql=sql+" and cu.comeShopStatus=? ";
				param.add(comeShopStatus);
			}
			if(customerInfromId>0){
				sql=sql+" and cu.customerInfromId=? ";
				param.add(customerInfromId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=startOrderTime&&startOrderTime.trim().length()>0){
				sql=sql+" and cpid.orderDate >= ? ";
				param.add(DateUtil.string2Date(startOrderTime));
			}
			if(null!=endOrderTime&&endOrderTime.trim().length()>0){
				sql=sql+" and cpid.orderDate < ? ";
				param.add(DateUtil.nextDay(endOrderTime));
			}
			if(null!=startSuccessTime&&startSuccessTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startSuccessTime));
			}
			if(null!=endSuccessTime&&endSuccessTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endSuccessTime));
			}
			sql=sql+" order by cpid.modifyTime DESC";
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccess";
	}
	/**
	 * 功能描述：成交客户信息表(物流部成交客户)
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String wlbCustomerManageSuccess() throws Exception {
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String customerName = request.getParameter("customerName");
		String userName = request.getParameter("userName");
		String vinCode = request.getParameter("vinCode");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("user", currentUser);
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
			//车系
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			List<CarColor>  carColors= carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_customerbussi as cb  where  cpid.customerId=cu.dbid and cb.customerId=cu.dbid and cpid.pidStatus=?";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and (cu.enterpriseId in("+currentUser.getCompnayIds()+") or cu.sourceEnterPriseId in("+currentUser.getCompnayIds()+"))";
			}else{
				sql=sql+" and (cu.enterpriseId="+enterprise.getDbid()+" or cu.sourceEnterPriseId="+enterprise.getDbid()+" )";
			}
			@SuppressWarnings("rawtypes")
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.FINISHED);
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=customerName&&customerName.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+customerName+"%");
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
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
			if(carColorId>0){
				sql=sql+" and cpid.carColorid=? ";
				param.add(carColorId);
			}
			sql=sql+" order by cpid.modifyTime DESC";
			
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "wlbCustomerManageSuccess";
	}
	/**
	 * 功能描述：成交客户信息表(装饰部查看)
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String decoreCustomerManageSuccess() throws Exception {
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String customerName = request.getParameter("customerName");
		String userName = request.getParameter("userName");
		String vinCode = request.getParameter("vinCode");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("user", currentUser);
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
			//车系
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			List<CarColor>  carColors= carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_CustomerBussi as cb  where  cpid.customerId=cu.dbid and cb.customerId=cu.dbid and cpid.pidStatus=?";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and (cu.enterpriseId in("+currentUser.getCompnayIds()+") or cu.sourceEnterPriseId in("+currentUser.getCompnayIds()+"))";
			}else{
				sql=sql+" and (cu.enterpriseId="+enterprise.getDbid()+" or cu.sourceEnterPriseId="+enterprise.getDbid()+" )";
			}
			@SuppressWarnings("rawtypes")
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.FINISHED);
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=customerName&&customerName.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+customerName+"%");
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
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
			if(carColorId>0){
				sql=sql+" and cpid.carColorid=? ";
				param.add(carColorId);
			}
			sql=sql+" order by cpid.modifyTime DESC";
			
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "decoreCustomerManageSuccess";
	}
	/**
	 * 功能描述：成交客户信息表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerManageSuccess() throws Exception {
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userName = request.getParameter("userName");
		String vinCode = request.getParameter("vinCode");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String name = request.getParameter("name");
		String startOrderTime = request.getParameter("startOrderTime");
		String endOrderTime = request.getParameter("endOrderTime");
		String tryCarStartTime = request.getParameter("tryCarStartTime");
		String tryCarEndTime = request.getParameter("tryCarEndTime");
		String comeShopStartTime = request.getParameter("comeShopStartTime");
		String comeShopEndTime = request.getParameter("comeShopEndTime");
		String startSuccessTime = request.getParameter("startSuccessTime");
		String endSuccessTime = request.getParameter("endSuccessTime");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			if(customerInfromId>0){
				CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(customerInfromId);
				String cusString = customerInfromManageImpl.getCustomerInfrom(customerInfrom2);
				request.setAttribute("customerInfromSelect", cusString);
			}else{
				String cusString = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", cusString);
			}
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			List<CarColor> carColors = carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			String sql="select * from "
					+ "cust_Customer as cu,"
					+ " cust_CustomerPidBookingRecord as cpid "
					+ "  where"
					+ "  cpid.customerId=cu.dbid   and cpid.pidStatus=? ";
			if(enterprise.getDbid()>0){
				sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
			}
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.FINISHED);
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cpid.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(carColorId>0){
				sql=sql+" and cpid.carColorId=? ";
				param.add(carColorId);
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
			}
			if(brandId>0){
				sql=sql+" and cpid.brandId=? ";
				param.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				param.add(carModelId);
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
			}
			if(customerTypeId>0){
				sql=sql+" and cu.customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(comeShopStatus>0){
				sql=sql+" and cu.comeShopStatus=? ";
				param.add(comeShopStatus);
			}
			if(customerInfromId>0){
				sql=sql+" and cu.customerInfromId=? ";
				param.add(customerInfromId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=startOrderTime&&startOrderTime.trim().length()>0){
				sql=sql+" and cpid.orderDate >= ? ";
				param.add(DateUtil.string2Date(startOrderTime));
			}
			if(null!=endOrderTime&&endOrderTime.trim().length()>0){
				sql=sql+" and cpid.orderDate < ? ";
				param.add(DateUtil.nextDay(endOrderTime));
			}
			if(null!=startSuccessTime&&startSuccessTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startSuccessTime));
			}
			if(null!=endSuccessTime&&endSuccessTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endSuccessTime));
			}
			if(null!=tryCarStartTime&&tryCarStartTime.trim().length()>0){
				sql=sql+" and cu.tryCarDate >= ? ";
				param.add(DateUtil.string2Date(tryCarStartTime));
			}
			if(null!=tryCarEndTime&&tryCarEndTime.trim().length()>0){
				sql=sql+" and cu.tryCarDate < ? ";
				param.add(DateUtil.nextDay(tryCarEndTime));
			}
			if(null!=comeShopStartTime&&comeShopStartTime.trim().length()>0){
				sql=sql+" and cu.comeShopDate >= ? ";
				param.add(DateUtil.string2Date(comeShopStartTime));
			}
			if(null!=comeShopEndTime&&comeShopEndTime.trim().length()>0){
				sql=sql+" and cu.comeShopDate < ? ";
				param.add(DateUtil.nextDay(comeShopEndTime));
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
			}
			sql=sql+" order BY cpid.modifyTime DESC ";
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerManageSuccess";
	}
	/**
	 * 功能描述：客户部成交客户信息表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String serviceCustomerManageSuccess() throws Exception {
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		String userName = request.getParameter("userName");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String vinCode = request.getParameter("vinCode");
		String endTime = request.getParameter("endTime");
		String customerName = request.getParameter("customerName");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			User currentUser = SecurityUserHolder.getCurrentUser();
			String departmentIds=null;
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Department parent = departmentManageImpl.get(Department.ROOT);
				if(departmentId>0){
					Department department = departmentManageImpl.get(departmentId);
					String departmentSelect = departmentManageImpl.getDepartmentSelect(department,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
					departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				}else{
					String departmentSelect = departmentManageImpl.getDepartmentSelect(null,enterprise.getDbid());
					request.setAttribute("departmentSelect", departmentSelect);
				}
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
			
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where  cpid.customerId=cu.dbid and cpid.pidStatus=?";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				String currentDepIds = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
			}
			@SuppressWarnings("rawtypes")
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.FINISHED);
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=customerName&&customerName.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+customerName+"%");
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
			}
			sql=sql+" order by cpid.modifyTime DESC";
			Page<Customer> page = customerMangeImpl.queryCustomerSuccess(pageSize,pageNo,mobilePhone,departmentIds,userName,startTime,endTime,customerName,null);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "serviceCustomerManageSuccess";
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
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Customer customer = customerMangeImpl.get(customerId);
			
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			//车型
			CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
			if(customerLastBussi!=null){
				CarSeriy carSeriy = customerLastBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriy.getDbid());
					request.setAttribute("carModels", carModels);
					
					List<CarColor> carColors = carColorManageImpl.findBy("carseries.dbid", carSeriy.getDbid());
					request.setAttribute("carColors", carColors);
				}
			}
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			
			CustomerPidBookingCancelRecord customerPidBookingCancelRecord = customerPidBookingCancelRecordManageImpl.findUniqueBy("customerId",customerId);
			request.setAttribute("customerPidBookingCancelRecord", customerPidBookingCancelRecord);
			
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}

	/**
	 * 功能描述：编辑交车预约记录
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
			CustomerPidBookingRecord customerPidBookingRecord2 = customerPidBookingRecordManageImpl.get(dbid);
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			
			request.setAttribute("customer", customerPidBookingRecord2.getCustomer());
		}
		return "edit";
	}
	/**
	 * 功能描述： 物流部编辑信息
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String wlbEdit() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Customer customer = customerMangeImpl.get(customerId);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			//车型
			CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
			if(customerLastBussi!=null){
				CarSeriy carSeriy = customerLastBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriy.getDbid());
					request.setAttribute("carModels", carModels);
				}
			}
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", customer.getDbid());
			if(null!=orderContractDecores&&orderContractDecores.size()==1){
				OrderContractDecore orderContractDecore = orderContractDecores.get(0);
				request.setAttribute("orderContractDecore", orderContractDecore);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "wlbEdit";
	}
	/**
	 * 功能描述：更新交车预约记录表
	 * 参数描述： 
	 * 逻辑描述：交车预约记录在打印合同时就生成（orderContractAction），
	 * 此处是对交车预约记录数据进行编辑；更新最终能交车记录的交车信息（CustomerLastBussi），CustomerBussi表
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		String orderDate = request.getParameter("customerPidBookingRecord.orderDate");
	    Date modifyTime = ParamUtil.getDateParam(request, "customerPidBookingRecord.modifyTime", "yyyy-MM-dd");
	    //车型信息
	    Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
	    Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
	    Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
	    Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		try{
				if(brandId>0){
					Brand brand = brandManageImpl.get(brandId);
					customerPidBookingRecord.setBrand(brand);
				}
				if(carSeriyId>0){
					CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
					customerPidBookingRecord.setCarSeriy(carSeriy);
				}
				//车型信息
				if(carModelId>0){
					CarModel carModel = carModelManageImpl.get(carModelId);
					customerPidBookingRecord.setCarModel(carModel);
				}
				//车型信息
				if(carColorId>0){
					CarColor carColor = carColorManageImpl.get(carColorId);
					customerPidBookingRecord.setCarColor(carColor);
				}
				//先获取合同流失记录交车预约创建日期
				CustomerPidBookingCancelRecord customerPidBookingCancelRecord = customerPidBookingCancelRecordManageImpl.findUniqueBy("customerId",customerId);
				request.setAttribute("customerPidBookingCancelRecord", customerPidBookingCancelRecord);
				//初始化时间
				if(null==customerPidBookingCancelRecord){
					customerPidBookingRecord.setCreateTime(new Date());
				}else{
					customerPidBookingRecord.setCreateTime(customerPidBookingCancelRecord.getBookingDate());
				}
		    	customerPidBookingRecord.setModifyTime(modifyTime);
			    
				Customer customer = customerMangeImpl.get(customerId);
				//初始化交车预约未创建
				customerPidBookingRecord.setPidStatus(CustomerPidBookingRecord.FINISHED);
				//设置跨店销售为默认正常状态
				customerPidBookingRecord.setKdStatus(CustomerPidBookingRecord.KDCOMM);
				//设置回访状态
				customerPidBookingRecord.setHfStatus(CustomerPidBookingRecord.HFWATING);
				customerPidBookingRecord.setOutStockCheckStatus(CustomerPidBookingRecord.OUTCHECKDEFAULT);
				customerPidBookingRecord.setCustomer(customer);

				//设置物流信息为提交
				customerPidBookingRecord.setWlStatus(CustomerPidBookingRecord.WLDEALED);
				customerPidBookingRecord.setOrderDate(DateUtil.stringDateWithHHMM(orderDate));
				customerPidBookingRecord.setPidStatus(CustomerPidBookingRecord.FINISHED);
				customerPidBookingRecord.setHfStatus(CustomerPidBookingRecord.HFWATING);
				customerPidBookingRecord.setCartrialerWlStatus(CustomerPidBookingRecord.WLDEALED);
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord);
				//删除重复数据
				customerPidBookingRecordManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				if(null!=customer&&customer.getDbid()>0){
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "F");
					customer.setCustomerPhase(customerPhase);
					User user = customer.getUser();
					//跟新销售顾问的所在部门
					User user2 = userManageImpl.get(user.getDbid());
					customer.setSuccessDepartment(user2.getDepartment());
				}
				customerMangeImpl.save(customer);
				
				
				//归档初始化 图片上传表
				Integer customerType = customer.getRecordType();
				if(customerType==(int)Customer.CUSTOMERTYPECOMM){
					CustomerImageApproval cApproval = customerImageApprovalManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
					if(null==cApproval){
						CustomerImageApproval customerImageApproval=new CustomerImageApproval();
						customerImageApproval.setCustomer(customer);
						customerImageApproval.setDrivingApproval(null);
						customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSCOMM);
						customerImageApproval.setHandCarApproval(null);
						customerImageApproval.setHandCarStatus(CustomerImageApproval.UPLOADSTATSCOMM);
						customerImageApproval.setStatus(CustomerImageApproval.STATUSCOMM);
						customerImageApprovalManageImpl.save(customerImageApproval);
					}
				}
				
				//发送微信消息
				String url="/qywxCustomer/customerDetail?customerId="+customer.getDbid();
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				String carName="";
				if(enterprise.getBussiType()==3){
					carName=customerPidBookingRecord.getBrand().getName()+""+customerPidBookingRecord.getCarSeriy().getName()+""+
							customerPidBookingRecord.getCarModel().getName()+""+customer.getCarColorStr();
				}
				if(enterprise.getBussiType()!=3){
					carName=customerPidBookingRecord.getBrand().getName()+""+customerPidBookingRecord.getCarSeriy().getName()+""+
							customerPidBookingRecord.getCarModel().getName()+""+customerPidBookingRecord.getCarColor().getName();
				}
				String dis="";
				if(null!=customer.getDepartment()){
					dis=customer.getDepartment().getName();
				}
				if(null!=customer.getUser()){
					dis=dis+"["+customer.getUser().getRealName()+"]";
				}
				dis=dis+"提报交车预约，预约车型："+carName;
				
				//qywxSendMessageUtil.sendMessagePart(url, dis, "交车预约申请处理通知", request);
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customerId, "客户归档成功", dis);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerPidBookingRecord/customerSuccess", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：合同流失申请页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderContractCancel() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			Customer customer = customerMangeImpl.get(customerId);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "orderContractCancel";
	}
	/**
	 * 功能描述：保存订合同流失申请记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOrderContractCancel() throws Exception {
		Integer dbid=customerPidBookingRecord.getDbid();
		String cancelNote = request.getParameter("cancelNote");
		try{
			 if(null!=dbid){
			    CustomerPidBookingRecord customerPidBookingRecord2 = customerPidBookingRecordManageImpl.get(dbid);
			    customerPidBookingRecord2.setPidStatus(CustomerPidBookingRecord.STATUSWATING);
			  //设置跨店销售为默认正常状态
				customerPidBookingRecord.setKdStatus(CustomerPidBookingRecord.KDCOMM);
			    //合同流失申请 修改交车合同状态
			    customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
			    
			    //合同流失申请记录信息
			    CustomerPidCancel customerPidCancel=new CustomerPidCancel();
			    customerPidCancel.setCreateDate(new Date());
			    customerPidCancel.setCustomerPidBookingRecord(customerPidBookingRecord2);
			    customerPidCancel.setNote(cancelNote);
			    customerPidCancelManageImpl.save(customerPidCancel);
			    
			    //发起合同流失审批流程
			    User currentUser2 = SecurityUserHolder.getCurrentUser();
			    //保存客户合同流失日志
			    customerOperatorLogManageImpl.saveCustomerOperatorLog(customerPidBookingRecord2.getCustomer().getDbid(), "客户合同流失申请", "");
			    
			 }else{
				 renderErrorMsg(new Throwable("请选择操作数据"), "");
				 return ;
			 }
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerPidBookingRecord/queryWatingList", "申请发送成功!");
		return ;
	}
	/**
	 * 功能描述：客户归档跳转页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String toCutomerFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "toCutomerFile";
	}
	/**
	 * 功能描述：客户状态设置为归档状态
	 * 参数描述：customerId
	 * 逻辑描述：通过customerId设置客户状态为归档,
	 * 1、设置车辆为出库状态；
	 * 2、保存车辆操作日志；
	 * 3、设置客户等级为F，更新客户等级
	 * 4、设置交车预约状态为成交
	 * 5、初始化回访记录信息表
	 * 
	 * @return
	 * @throws Exception
	 */
	public void customerFile() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer dmsStatus = ParamUtil.getIntParam(request, "dmsStatus", -1);
		Date fileDate = ParamUtil.getDateParam(request, "fileDate");
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				if(null!=customer&&customer.getDbid()>0){
					if(customerPidBookingRecord2.getKdStatus()>(int)CustomerPidBookingRecord.KDCOMM){
						customer.setKdStatus(Customer.KDYEAS);
						if(dmsStatus>0){
							customer.setDmsStatus(dmsStatus);
						}
					}
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "F");
					customer.setCustomerPhase(customerPhase);
					User user = customer.getUser();
					//跟新销售顾问的所在部门
					User user2 = userManageImpl.get(user.getDbid());
					customer.setSuccessDepartment(user2.getDepartment());
				}
				customerMangeImpl.save(customer);
				
				customerPidBookingRecord2.setPidStatus(CustomerPidBookingRecord.FINISHED);
				customerPidBookingRecord2.setHfStatus(CustomerPidBookingRecord.HFWATING);
				//归档日期
				customerPidBookingRecord2.setModifyTime(fileDate);
				customerPidBookingRecord2.setCwDate(new Date());
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
				
				Date modifyTime = customerPidBookingRecord2.getModifyTime();
				Calendar instance = Calendar.getInstance();
				instance.set(2015, 9, 1, 0, 0);
				Date time = instance.getTime();
				//10月一号以后的数据 
				if(modifyTime.after(time)){
					//归档初始化 图片上传表
					Integer customerType = customer.getRecordType();
					if(customerType==(int)Customer.CUSTOMERTYPECOMM){
						CustomerImageApproval cApproval = customerImageApprovalManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
						if(null==cApproval){
							CustomerImageApproval customerImageApproval=new CustomerImageApproval();
							customerImageApproval.setCustomer(customer);
							customerImageApproval.setDrivingApproval(null);
							customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSCOMM);
							customerImageApproval.setHandCarApproval(null);
							customerImageApproval.setHandCarStatus(CustomerImageApproval.UPLOADSTATSCOMM);
							customerImageApproval.setStatus(CustomerImageApproval.STATUSCOMM);
							customerImageApprovalManageImpl.save(customerImageApproval);
						}
					}
				}
				
				//推荐客户修改状态为客户流失
				RecommendCustomer recommendCustomer = customer.getRecommendCustomer();
				if(null!=recommendCustomer){
					if(RecommendCustomer.TRADESUCCESS!=(int)recommendCustomer.getTradeStatus()){
						recommendCustomer.setTradeStatus(RecommendCustomer.TRADESUCCESS);
						recommendCustomerManageImpl.save(recommendCustomer);
						//保存返利记录
						saveAgentOperatorLog("推荐客成交", "推荐客户成交提报档案", customerId, currentUser);
					}
				}
			}else{
				renderErrorMsg(new Throwable("请选择归档数据！"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/customerPidBookingRecord/queryWlbWatingList"+query, "客户归档成功！");
		return ;
	}
	/**
	 * 功能描述：撤销归档客户
	 * 参数描述：customerId
	 * 逻辑描述：通过customerId设置客户状态为归档
	 * @return
	 * @throws Exception
	 */
	public void cancelCustomerFile() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
				if(customerId<0){
					renderErrorMsg(new Throwable("请选撤销择归档数据！"), "");
					return ;
				}
				
				List<CustomerPidBookingRecord> customerPidBookingRecords = customerPidBookingRecordManageImpl.findBy("customer.dbid",customerId);
				if(null==customerPidBookingRecords||customerPidBookingRecords.isEmpty()){
					renderErrorMsg(new Throwable("请选撤销择归档数据！"), "");
					return ;
				}
				
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				String vinCode = customerPidBookingRecord2.getVinCode();
				
				if(null!=customer&&customer.getDbid()>0){
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "O");
					customer.setCustomerPhase(customerPhase);
					customer.setKdStatus(Customer.KDCOMM);
					customer.setDmsStatus(Customer.DMSCOMM);
					customer.setSourceEnterprise(null);
				}
				customerMangeImpl.save(customer);
				
				customerPidBookingRecordManageImpl.delete(customerPidBookingRecord2);
				
				
				//推荐客户修改状态为客户流失
				RecommendCustomer recommendCustomer = customer.getRecommendCustomer();
				if(null!=recommendCustomer){
					recommendCustomer.setTradeStatus(RecommendCustomer.TRADECOMM);
					recommendCustomerManageImpl.save(recommendCustomer);
					saveAgentOperatorLog("推荐客户撤销客户档案", "推荐客户撤销客户档案", customerId, currentUser);
				}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/customerPidBookingRecord/customerSuccess"+query, "客户撤销归档成功！");
		return ;
	}
	/**
	 * 功能描述：交车预约删除 
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
					customerPidBookingRecordManageImpl.deleteById(dbid);
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
		renderMsg("/customerPidBookingRecord/queryList"+query, "删除数据成功！");
		return;
	}
	
	/**
	 * 功能描述：取消车架号
	 * 参数描述：customerPidDbid
	 * 逻辑描述：
	 * 			1、清空customerPid物流部操作数据。
	 * 			2、还原车辆未默认状态
	 * 			3、记录vin码流失日志
	 * 			4、出库单核查状态重置未未核查
	 * @return
	 * @throws Exception
	 */
	public void cancelVinCode() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pidDbid = ParamUtil.getIntParam(request, "pidDbid", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		String vinCode=request.getParameter("vinCode");
		CustomerPidBookingRecord customerPidBookingRecord2=null;
		try {
			if(null!=vinCode&&vinCode.trim().length()>0){
				List<CustomerPidBookingRecord> customerPidBookingRecords = customerPidBookingRecordManageImpl.findBy("vinCode", vinCode);
				if(null!=customerPidBookingRecords&&customerPidBookingRecords.size()>0){
					customerPidBookingRecord2=customerPidBookingRecords.get(0);
				}
			}else{
				customerPidBookingRecord2= customerPidBookingRecordManageImpl.get(pidDbid);
			}
			String reulvinCode=null;
			int kdStatus=1;
			Customer customer=null;
			if(customerPidBookingRecord2!=null){
				kdStatus=customerPidBookingRecord2.getKdStatus();
				
				reulvinCode= customerPidBookingRecord2.getVinCode();
				//////////////////////清空customerPidBookingRecord表的物流部交车记录//////////////////////////////
				//网点
				customerPidBookingRecord2.setWebSite(null);
				//库存点
				customerPidBookingRecord2.setCarSource(null);
				customerPidBookingRecord2.setRewardMoney(0);
				customerPidBookingRecord2.setVinCode(null);
				customerPidBookingRecord2.setKdStatus(CustomerPidBookingRecord.KDCOMM);
				//设置出库单核查状态为 未核查
				customerPidBookingRecord2.setOutStockCheckStatus(CustomerPidBookingRecord.OUTCHECKDEFAULT);
				//设置无车
				customerPidBookingRecord2.setHasCarOrder(CustomerPidBookingRecord.HASCARORDERNO);
				
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
				
				customer = customerPidBookingRecord2.getCustomer();
				
			}
    		if(null==reulvinCode){
    			reulvinCode=vinCode;
    		}
    		if(reulvinCode==null){
    			renderErrorMsg(new Throwable("释放车架号出错，无车架号信息"), "");
    			return ;
    		}
		    //发送微信消息 已经结束
			if(null!=customer&&null!=customer.getUser()){
				String touser=customer.getUser().getUserId();
				String url="/qywxCustomer/customerDetail?customerId="+customer.getDbid();
				String dis="物流部已经释放车架号，车架号"+reulvinCode;
				qywxSendMessageUtil.sendMessageSingle(touser, url, dis, "释放车架号通知", request);
			}
		    
		    if(null==vinCode||vinCode.trim().length()<=0){
		    	renderMsg("/customerPidBookingRecord/queryWlbWatingList", "【"+reulvinCode+"】释放车架号成功！");
		    }else{
		    	renderMsg("/factoryOrder/queryWlbStock", "【"+vinCode+"】释放车架号成功！");
		    }
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		return ;
	}
	/**
	 * 功能描述：销售顾问查看物流部处理情况
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewWlbCustomerPidRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				request.setAttribute("customerPidBookingRecord",customerPidBookingRecord2);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewWlbCus";
	}
	/**
	 * 功能描述：取消合同
	 * 参数描述：customerId
	 * 逻辑描述：根据customerId获取客户信息，
	 * 1、删除客户成交结果信息
	 * 2、订单信息
	 * 3、订单商品信息
	 * 4、订单审批信息
	 * 5、交车预约信息
	 * 6、合同流失审批记录
	 * 7、交款确认单
	 * 8、装饰确认单
	 * 9、修改追踪记录 
	 * 10、释放车架号factoryOrder
	 * 11、删除图片上传表数据
	 * 通过客户信息获取交车信息，
	 * 交车申请审批信息，
	 * 交车审批记录信息。取消合同删除交车预约记录、审批记录
	 * @return
	 * @throws Exception
	 */
	private void cancelContract(Integer customerId) throws Exception {
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				//最终成交结果
				CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
				if(null!=customerLastBussi){
					customerLastBussiManageImpl.delete(customerLastBussi);
				}
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				
				//保存交车预约创建时间
				CustomerPidBookingCancelRecord customerPidBookingCancelRecord = customerPidBookingCancelRecordManageImpl.findUniqueBy("customerId", customer.getDbid());
				if(null==customerPidBookingCancelRecord){
					customerPidBookingCancelRecord=new CustomerPidBookingCancelRecord();
					customerPidBookingCancelRecord.setCustomerId(customerId);
					customerPidBookingCancelRecord.setBookingDate(customerPidBookingRecord2.getCreateTime());
				}else{
					customerPidBookingCancelRecord.setBookingDate(customerPidBookingRecord2.getCreateTime());
				}
				customerPidBookingCancelRecordManageImpl.save(customerPidBookingCancelRecord);
				
				//订单信息  自动级联删除订单商品信息、订单审批记录
				OrderContract orderContract = customer.getOrderContract();
				if(null!=orderContract){
					//删除费用明细
					List<OrderContractExpenses> orderContractExpenses = orderContractExpensesManageImpl.findBy("customer.dbid", customer.getDbid());
					if(null!=orderContractExpenses){
						for (OrderContractExpenses orderContractExpenses2 : orderContractExpenses) {
							orderContractExpensesManageImpl.delete(orderContractExpenses2);
						}
					}
					orderContractManageImpl.delete(orderContract);
				}
				//删除加装装饰信息
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", orderContract.getDbid());
				if(null!=orderContractDecores&&orderContractDecores.size()>0){
					for (OrderContractDecore orderContractDecore : orderContractDecores) {
						orderContractDecoreManageImpl.delete(orderContractDecore);
					}
				}
				
				//代交车记录 删除交车记录、交车审批记录
				if(null!=customerPidBookingRecord2){
					//删除客户交车预约记录信息
					customerPidBookingRecordManageImpl.delete(customerPidBookingRecord2);
				}
				
				
				//修改订单状态为新添加  修改客户状态信息
				customer.setOrderContractStatus(Customer.ORDERNOT);
				customer.setLastResult(Customer.NORMAL);
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name","A");
				customer.setCustomerPhase(customerPhase);
				customerMangeImpl.save(customer);
				
				//追踪超时记录 合同流失状态修改
				TimeoutsTrackRecord timeoutsTrackRecord = customer.getTimeoutsTrackRecord();
				if(null!=timeoutsTrackRecord&&timeoutsTrackRecord.getDbid()>0){
					timeoutsTrackRecord.setIsContrackReturn(true);
					timeoutsTrackRecord.setContrackReturnDate(new Date());
					timeoutsTrackRecordManageImpl.save(timeoutsTrackRecord);
				}
				
				//删除图片上传数据库
				customerImageApprovalManageImpl.deleteBy(customerId);
				
			}else{
				System.out.println("请选择取消合同数据！");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return ;
		}
		System.out.println("取消合同成功！");
		return ;
	}
	/**
	 * 功能描述：挂车物流邦车处理
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String wlbCartrialerEdit() {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Customer customer = customerMangeImpl.get(customerId);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			//车型
			CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
			if(customerLastBussi!=null){
				CarSeriy carSeriy = customerLastBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriy.getDbid());
					request.setAttribute("carModels", carModels);
				}
			}
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", customer.getDbid());
			if(null!=orderContractDecores&&orderContractDecores.size()==1){
				OrderContractDecore orderContractDecore = orderContractDecores.get(0);
				request.setAttribute("orderContractDecore", orderContractDecore);
			}
		} catch (Exception e) {
			log.error(e);
		}
		return "wlbCartrialerEdit";
	}
	/**
	 * 功能描述：导出库存到excel
	 * @throws Exception
	 */
	public void exportExcel() throws Exception {
		HttpServletResponse response = getResponse();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String customerName = request.getParameter("customerName");
		String vinCode = request.getParameter("vinCode");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		String userName = request.getParameter("userName");
		String fileName="";
		try{
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
			Department department = departmentManageImpl.get(departmentId);
			String departmentIds = departmentManageImpl.getDepartmentIds(department);
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_CustomerBussi as cb  where  cpid.customerId=cu.dbid and cb.customerId=cu.dbid and cpid.pidStatus=?";
			@SuppressWarnings("rawtypes")
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.FINISHED);
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and (cu.enterpriseId in("+currentUser.getCompnayIds()+") or cu.sourceEnterPriseId in("+currentUser.getCompnayIds()+"))";
			}else{
				sql=sql+" and (cu.enterpriseId="+enterprise.getDbid()+" or cu.sourceEnterPriseId="+enterprise.getDbid()+" )";
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.successDepartmentId in ("+departmentIds+")";
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.modifyTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=customerName&&customerName.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+customerName+"%");
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
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
			if(carColorId>0){
				sql=sql+" and cpid.carColorid=? ";
				param.add(carColorId);
			}
			sql=sql+" order by cpid.modifyTime DESC";
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			String filePath = customerSuccessToExcel.writeExcel(fileName, customers);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：导出库存到excel
	 * @throws Exception
	 */
	public void exportCustomerPidExcel() throws Exception {
		HttpServletResponse response = getResponse();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String vinCode = request.getParameter("paramVinCode");
		String name = request.getParameter("name");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
		Integer hasCarOrder = ParamUtil.getIntParam(request, "hasCarOrder", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer pidStatus = ParamUtil.getIntParam(request, "pidStatus", -1);
		Integer wlStatus = ParamUtil.getIntParam(request, "wlStatus", -1);
		Integer orderNum = ParamUtil.getIntParam(request, "orderNum", -1);
		Integer appOrder = ParamUtil.getIntParam(request, "appOrder", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String fileName="";
		try{
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
			if(departmentId>0){
				departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
			}
			
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_CustomerBussi as cb  " +
					" where  cpid.customerId=cu.dbid and cb.customerId=cu.dbid and cpid.pidStatus>=? and cpid.wlStatus>=? and cpid.pidStatus!=2";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
			}
			List param= new ArrayList();
			param.add(CustomerPidBookingRecord.PRINT);
			param.add(CustomerPidBookingRecord.WLWATING);
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				param.add("%"+vinCode+"%");
			}
			if(null!=wlStatus&&wlStatus>0){
				sql=sql+" and cpid.wlStatus=? ";
				param.add(wlStatus);
			}
			if(null!=userId&&userId>0){
				sql=sql+" and cu.bussiStaffId=? ";
				param.add(userId);
			}
			if(null!=hasCarOrder&&hasCarOrder>0){
				sql=sql+" and cpid.hasCarOrder=? ";
					param.add(hasCarOrder);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cpid.createTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cpid.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=departmentIds){
				System.out.println(departmentIds);
				sql=sql+" and cu.departmentId in("+departmentIds+")";
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
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
			if(pidStatus>0){
				sql=sql+" and cpid.pidStatus=? ";
				param.add(pidStatus);
			}
			if(carColorId>0){
				sql=sql+" and cpid.carColorid=? ";
				param.add(carColorId);
			}
			if(appOrder==-1&&orderNum==-1){
				sql=sql+" order by cpid.wlStatus,cpid.createTime";
			}
			if(appOrder==1){
				sql=sql+" order by cpid.wlCreateTime DESC";
			}
			if(appOrder==2){
				sql=sql+" order by cpid.wlCreateTime";
			}
			if(orderNum==1){
				sql=sql+" order by cpid.bookingDate DESC";
			}
			if(orderNum==2){
				sql=sql+" order by cpid.bookingDate";
			}
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			String filePath = customerPidBookingRecordToExcel.writeExcel(fileName, customers);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：提交财务
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void subCwCpidCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerPidBookingRecord customerPidBookingRecord2 = customerPidBookingRecordManageImpl.get(dbid);
			if(null==customerPidBookingRecord2){
				renderErrorMsg(new Throwable("提报失败，无装饰客户"), "");
				return ;
			}
			Customer customer = customerPidBookingRecord2.getCustomer();
			if(customer==null){
				renderErrorMsg(new Throwable("提报失败，客户资料为空"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerPidBookingRecord/wlbCustomerManageSuccess", "提报财务数据成功");
		return;
	}
	/**
	 * 功能描述：批量提交财务
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void subCwCpidMoreCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArrayByIds(request, "dbids");
		try {
			StringBuffer errors=new StringBuffer();
			boolean status=false;
			for (Integer dbid : dbids) {
				Customer customer = customerMangeImpl.get(dbid);
				if(customer==null){
					errors.append("提报失败，客户资料为空");
					errors.append("\n");
					status=true;
					continue;
				}
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				if(null==customerPidBookingRecord2){
					errors.append("提报失败，无保险客户,");
					errors.append("\n");
					status=true;
					continue;
				}
				
			}
			if(status==true){
				renderErrorMsg(new Throwable(errors.toString()), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/customerPidBookingRecord/wlbCustomerManageSuccess", "提报财务数据成功");
		return;
	}
	
	/**
	 * 功能描述：保存操作日志
	 * @param type
	 * @param note
	 * @param finCustomerId
	 */
	public void saveAgentOperatorLog(String type,String note,Integer customerId,User currentUser){
		AgentOperatorLog agentOperatorLog=new AgentOperatorLog();
		agentOperatorLog.setCustomerId(customerId);
		agentOperatorLog.setNote(note);
		agentOperatorLog.setOperateDate(new Date());
		agentOperatorLog.setOperator(currentUser.getRealName());
		agentOperatorLog.setType(type);
		agentOperatorLogManageImpl.save(agentOperatorLog);
	}
}
