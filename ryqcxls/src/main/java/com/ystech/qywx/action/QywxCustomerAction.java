package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.util.CheckIdCardUtils;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.ApprovalRecord;
import com.ystech.cust.model.BuyCarBudget;
import com.ystech.cust.model.BuyCarCare;
import com.ystech.cust.model.BuyCarMainUse;
import com.ystech.cust.model.BuyCarTarget;
import com.ystech.cust.model.BuyCarType;
import com.ystech.cust.model.CustMarketingAct;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerFlowReason;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerPidCancel;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.model.Educational;
import com.ystech.cust.model.Industry;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.OrderContractExpensesChargeItem;
import com.ystech.cust.model.OrderContractExpensesPreferenceItem;
import com.ystech.cust.model.OrderContractProduct;
import com.ystech.cust.model.Paperwork;
import com.ystech.cust.model.Profession;
import com.ystech.cust.service.ApprovalRecordManageImpl;
import com.ystech.cust.service.BuyCarBudgetManageImpl;
import com.ystech.cust.service.BuyCarCareManageImpl;
import com.ystech.cust.service.BuyCarMainUseManageImpl;
import com.ystech.cust.service.BuyCarTargetManageImpl;
import com.ystech.cust.service.BuyCarTypeManageImpl;
import com.ystech.cust.service.CustMarketingActManageImpl;
import com.ystech.cust.service.CustomerBussiManageImpl;
import com.ystech.cust.service.CustomerFlowReasonManageImpl;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.CustomerPidCancelManageImpl;
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.cust.service.EducationalManageImpl;
import com.ystech.cust.service.IndustryManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.cust.service.PaperworkManageImpl;
import com.ystech.cust.service.ProfessionManageImpl;
import com.ystech.cust.service.TimeoutsTrackRecordManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
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

@Component("qywxCustomerAction")
@Scope("prototype")
public class QywxCustomerAction extends BaseController{
	private static int errorNum=1;
	private Customer customer;
	private CustomerTrack customerTrack;
	private CustomerShoppingRecord customerShoppingRecord;
	private CustomerBussi customerBussi;
	private CustomerMangeImpl customerMangeImpl;
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarColorManageImpl carColorManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerBussiManageImpl customerBussiManageImpl;
	private TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl;
	private OrderContractProductManageImpl orderContractProductManageImpl;
	private CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private ApprovalRecordManageImpl approvalRecordManageImpl;
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	private UserManageImpl userManageImpl;
	private CustomerPidCancelManageImpl customerPidCancelManageImpl;
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private CustomerTractUtile customerTractUtile;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private AreaManageImpl areaManageImpl;
	private IndustryManageImpl industryManageImpl;
	private EducationalManageImpl educationalManageImpl;
	private BuyCarCareManageImpl buyCarCareManageImpl;
	private BuyCarTargetManageImpl buyCarTargetManageImpl;
	private BuyCarTypeManageImpl buyCarTypeManageImpl;
	private BuyCarBudgetManageImpl buyCarBudgetManageImpl;
	private BuyCarMainUseManageImpl buyCarMainUseManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private PaperworkManageImpl paperworkManageImpl;
	private ProfessionManageImpl professionManageImpl;
	private CustMarketingActManageImpl custMarketingActManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private CustomerLastBussi customerLastBussi;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private CustomerFlowReasonManageImpl customerFlowReasonManageImpl;
	
	public CustomerTrack getCustomerTrack() {
		return customerTrack;
	}

	public void setCustomerTrack(CustomerTrack customerTrack) {
		this.customerTrack = customerTrack;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	
	public Customer getCustomer() {
		return customer;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
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
	public void setCustomerBussiManageImpl(
			CustomerBussiManageImpl customerBussiManageImpl) {
		this.customerBussiManageImpl = customerBussiManageImpl;
	}
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
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
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource	
	public void setOrderContractProductManageImpl(
			OrderContractProductManageImpl orderContractProductManageImpl) {
		this.orderContractProductManageImpl = orderContractProductManageImpl;
	}
	@Resource
	public void setApprovalRecordManageImpl(
			ApprovalRecordManageImpl approvalRecordManageImpl) {
		this.approvalRecordManageImpl = approvalRecordManageImpl;
	}

	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	
	public CustomerShoppingRecord getCustomerShoppingRecord() {
		return customerShoppingRecord;
	}

	public void setCustomerShoppingRecord(
			CustomerShoppingRecord customerShoppingRecord) {
		this.customerShoppingRecord = customerShoppingRecord;
	}
	@Resource
	public void setTimeoutsTrackRecordManageImpl(
			TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl) {
		this.timeoutsTrackRecordManageImpl = timeoutsTrackRecordManageImpl;
	}
	@Resource
	public void setCustomerShoppingRecordManageImpl(
			CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl) {
		this.customerShoppingRecordManageImpl = customerShoppingRecordManageImpl;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
	}
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setOrderContractExpensesChargeItemManageImpl(
			OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl) {
		this.orderContractExpensesChargeItemManageImpl = orderContractExpensesChargeItemManageImpl;
	}
	@Resource
	public void setOrderContractExpensesPreferenceItemManageImpl(
			OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl) {
		this.orderContractExpensesPreferenceItemManageImpl = orderContractExpensesPreferenceItemManageImpl;
	}
	@Resource
	public void setCustomerPidCancelManageImpl(
			CustomerPidCancelManageImpl customerPidCancelManageImpl) {
		this.customerPidCancelManageImpl = customerPidCancelManageImpl;
	}

	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}

	public CustomerBussi getCustomerBussi() {
		return customerBussi;
	}

	public void setCustomerBussi(CustomerBussi customerBussi) {
		this.customerBussi = customerBussi;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}

	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setCustomerFlowReasonManageImpl(
			CustomerFlowReasonManageImpl customerFlowReasonManageImpl) {
		this.customerFlowReasonManageImpl = customerFlowReasonManageImpl;
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
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		try {
			User user = getSessionUser();
			Enterprise enterprise = user.getEnterprise();
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			request.setAttribute("enterprise", enterprise);
			if(customerRecordId>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
				request.setAttribute("customerRecord", customerRecord);
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerRecord.getCustomerInfrom());
				request.setAttribute("customerInfromSelect", customerInfromSelect);
				
				if(null!=customerRecord&&customerRecord.getDbid()>0){
					Brand brand = customerRecord.getBrand();
					if(null!=brand){
						//意向车型
						List<CarSeriy>  carSeriys= carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brand.getDbid());

						request.setAttribute("carSeriys", carSeriys);
					}
					CarSeriy carSeriy = customerRecord.getCarSeriy();
					if(null!=carSeriy){
						List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(), brand.getDbid(), carSeriy.getDbid());
						request.setAttribute("carModels", carModels);
					}
				}
			}else{
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "add";
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
			User user = getSessionUser();
			countTrack(user);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	/**
	 * 功能描述：客户资料查询
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			User currentUser = getSessionUser();
			Enterprise enterprise = currentUser.getEnterprise();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			
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
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp  "
					+ "where bussiStaffId=?  and cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid and custp.type=? ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			param.add(CustomerPhase.TYPESHOW);
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				param.add(customerPhaseId);
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
			if(trackingPhaseId>0){
				sql=sql+" and cb.trackingPhaseId=? ";
				param.add(trackingPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(customerInfromId>0){
				sql=sql+" and cu.customerInfromId=? ";
				param.add(customerInfromId);
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
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			sql=sql+"order by createFolderTime DESC";
			
			Page<Customer> page= customerMangeImpl.pagedQuerySql(pageNo,pageSize,Customer.class,sql,param.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
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
	public String edit() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
				
				request.setAttribute("customerBussi", customer2.getCustomerBussi());
				
				request.setAttribute("customerShoppingRecord", customer2.getCustomerShoppingRecord());
				//地域信息
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				request.setAttribute("areas", areas);
				if(null!=customer2.getArea()){
					String areaSelect = areaSelect(customer2.getArea());
					request.setAttribute("areaSelect", areaSelect);
				}
				List<Department> departments = departmentManageImpl.getAll();
				request.setAttribute("departments", departments);
				
				//职业信息表
				List<Profession> professions = professionManageImpl.getAll();
				request.setAttribute("professions", professions);
				//行业信息
				List<Industry> industries = industryManageImpl.getAll();
				request.setAttribute("industries", industries);
				//学历信息
				List<Educational> educationals = educationalManageImpl.getAll();
				request.setAttribute("educationals", educationals);
				
				//证件类型
				List<Paperwork> paperworks = paperworkManageImpl.getAll();
				request.setAttribute("paperworks", paperworks);
				
				//购车关注是项
				List<BuyCarCare> buyCarCares = buyCarCareManageImpl.getAll();
				request.setAttribute("buyCarCares", buyCarCares);
				
				//购车目的
				List<BuyCarTarget> buyCarTargets = buyCarTargetManageImpl.getAll();
				request.setAttribute("buyCarTargets", buyCarTargets);
				//购车类型
				List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
				request.setAttribute("buyCarTypes", buyCarTypes);
				
				//品牌
				List<Brand> brands = brandManageImpl.getAll();
				request.setAttribute("brands", brands);
				
				//意向车型
				CustomerBussi  customerBussi=customer2.getCustomerBussi();
				if(null!=customerBussi&&customerBussi.getDbid()>0){
					Brand brand = customerBussi.getBrand();
					if(null!=brand){
						//意向车型
						List<CarSeriy>  carSeriys= carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carSeriys", carSeriys);
					}
					CarSeriy carSeriy = customerBussi.getCarSeriy();
					if(null!=carSeriy){
						List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carModels", carModels);
					}
					
				}
				
				//购车预算
				List<BuyCarBudget> buyCarBudgets = buyCarBudgetManageImpl.getAll();
				request.setAttribute("buyCarBudgets", buyCarBudgets);
				//购车主要是用人
				List<BuyCarMainUse> buyCarMainUses = buyCarMainUseManageImpl.getAll();
				request.setAttribute("buyCarMainUses", buyCarMainUses);
				//意向级别
				List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
				request.setAttribute("customerPhases", customerPhases);
				
				
				
				if(null!=customer2.getCustomerInfrom()){
					String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customer2.getCustomerInfrom());
					request.setAttribute("customerInfromSelect", customerInfromSelect);
				}else{
					String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(null);
					request.setAttribute("customerInfromSelect", customerInfromSelect);
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：到店登记
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String comeShopRecord(){
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId",-1);
		Integer comeShopeStatus = ParamUtil.getIntParam(request, "comeShopeStatus",-1);
		User user = getSessionUser();
		Enterprise enterprise = user.getEnterprise();
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		try {
			if(customerRecordId>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
				request.setAttribute("customerRecord",customerRecord);
			}
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			
			request.setAttribute("customerBussi", customer2.getCustomerBussi());
			
			request.setAttribute("customerShoppingRecord", customer2.getCustomerShoppingRecord());
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			if(null!=customer2.getArea()){
				String areaSelect = areaSelect(customer2.getArea());
				request.setAttribute("areaSelect", areaSelect);
			}
			List<Department> departments = departmentManageImpl.getAll();
			request.setAttribute("departments", departments);
			
			
			//职业信息表
			List<Profession> professions = professionManageImpl.getAll();
			request.setAttribute("professions", professions);
			//行业信息
			List<Industry> industries = industryManageImpl.getAll();
			request.setAttribute("industries", industries);
			//学历信息
			List<Educational> educationals = educationalManageImpl.getAll();
			request.setAttribute("educationals", educationals);
			
			//证件类型
			List<Paperwork> paperworks = paperworkManageImpl.getAll();
			request.setAttribute("paperworks", paperworks);
			
			//购车关注是项
			List<BuyCarCare> buyCarCares = buyCarCareManageImpl.getAll();
			request.setAttribute("buyCarCares", buyCarCares);
			
			//购车目的
			List<BuyCarTarget> buyCarTargets = buyCarTargetManageImpl.getAll();
			request.setAttribute("buyCarTargets", buyCarTargets);
			//购车类型
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			
			//品牌
			List<Brand> brands = brandManageImpl.getAll();
			request.setAttribute("brands", brands);
			
			//意向车型
			CustomerBussi  customerBussi=customer2.getCustomerBussi();
			if(null!=customerBussi&&customerBussi.getDbid()>0){
				Brand brand = customerBussi.getBrand();
				if(null!=brand){
					//意向车型
					List<CarSeriy>  carSeriys= carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carSeriys", carSeriys);
				}
				CarSeriy carSeriy = customerBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carModels", carModels);
				}
				
			}
			
			//购车预算
			List<BuyCarBudget> buyCarBudgets = buyCarBudgetManageImpl.getAll();
			request.setAttribute("buyCarBudgets", buyCarBudgets);
			//购车主要是用人
			List<BuyCarMainUse> buyCarMainUses = buyCarMainUseManageImpl.getAll();
			request.setAttribute("buyCarMainUses", buyCarMainUses);
			
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findByCustIdAndUserId(customerId, user.getDbid());
			if(null!=customerTracks&&customerTracks.size()>0){
				CustomerTrack customerTrack2 = customerTracks.get(0);
				request.setAttribute("customerTrack", customerTrack2);
			}else{
				//默认创建任务为15天
				Date addDay = DateUtil.addDay(new Date(), 15);
				CustomerTrack customerTrack=customerTractUtile.createOtherCustomerTask(customer2,addDay,user);
				request.setAttribute("customerTrack", customerTrack);
			}
			List<CustMarketingAct> custMarketingActs = custMarketingActManageImpl.executeSql("SELECT * FROM cust_marketingact WHERE DATE_FORMAT(NOW(),'%y-%m-%d')>=actStartDate AND actEndDate>=DATE_FORMAT(NOW(),'%y-%m-%d') and enterpriseId="+enterprise.getDbid(), null);
			request.setAttribute("custMarketingActs", custMarketingActs);
			
			
		} catch (Exception e) {
		}
		if(comeShopeStatus==1){
			return "comeShopRecordSuccess";
		}
		if(comeShopeStatus==2){
			return "comeShopRecord";
		}
			
		return "comeShopRecord";
	}
	/**
	 * 功能描述：保存到店登记记录
	 * 参数描述：
	 * 逻辑描述：1、完善客户基础信息；
	 * 			 2、保存客户到店信息
	 * 			 3、完成客户需求评估
	 * 			 4、更新客户跟踪回访记录
	 * 			 5、更新回访活动信息
	 * @return
	 * @throws Exception
	 */
	public void saveComeShopRecord(){
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer customerTrackId = ParamUtil.getIntParam(request, "customerTrackId", -1);
		Integer custMarketingActId = ParamUtil.getIntParam(request, "custMarketingActId", -1);
		try{
			User currentUser = getSessionUser();
			Customer customer2 = customerMangeImpl.get(customer.getDbid());
			if(customerTrackId==null){
				renderErrorMsg(new Throwable("无跟踪任务!"), "");
				return ;
			}
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(customerTrackId);
			if(null==customerTrack2){
				renderErrorMsg(new Throwable("无跟踪任务!"), "");
				return ;
			}
			customerId=customer2.getDbid();
			Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			if(areaId>0){
				Area area = areaManageImpl.get(areaId);
				if(null!=area){
					customer2.setArea(area);
				}
			}
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerBussi.setCarModel(carModel);
			}
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi.setBrand(brand);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerBussi.setCarSeriy(carSeriy);
			}
			customer2.setAddress(customer.getAddress());
			customer2.setCarColorStr(customer.getCarColorStr());
			customer2.setCarModelStr(customer.getCarModelStr());
			customer2.setMobilePhone(customer.getMobilePhone());
			customer2.setName(customer.getName());
			if(null!=customer.getNavPrice()){
				customer2.setNavPrice(customer.getNavPrice());
			}
			customer2.setNote(customer.getNote());
			customer2.setSex(customer.getSex());
			customer2.setTryCarStatus(tryCarStatus);
			//试乘试驾状态
			if(tryCarStatus==2){
				customer2.setTryCarDate(new Date());
			}
			customer2.setTryCarStatus(tryCarStatus);
			Integer trackNum = customer2.getTrackNum();
			if(trackNum!=null){
				trackNum=trackNum+1;
			}else{
				trackNum=1;
			}
			Integer comeShopStatus = customer2.getComeShopStatus();
			if (comeShopStatus==null||comeShopStatus==1) {
				customer2.setComeShopStatus(2);
				customer2.setComeShopDate(new Date());
				customer2.setComeShopNum(1);
			}else{
				if (comeShopStatus==1) {
					customer2.setComeShopNum(2);
					customer2.setComeShopDate(new Date());
					customer2.setComeShopNum(1);
				}
				if (comeShopStatus==2) {
					customer2.setComeShopStatus(3);
					customer2.setComeShopNum(2);
					customer2.setTwoComeShopDate(new Date());
				}
				if (comeShopStatus==3) {
					Integer comeShopNum = customer2.getComeShopNum();
					customer2.setComeShopNum(comeShopNum++);
					customer2.setTwoComeShopDate(new Date());
				}
			}
			customer2.setTrackNum(trackNum);
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			if(customerPhaseId>0){
				CustomerPhase customerPhase = customerPhaseManageImpl.get(customerPhaseId);
				//客户跟踪后的级别
				customer.setCustomerPhase(customerPhase);
				customerTrack2.setAfterCustomerPhase(customerPhase);
			}
			
			customer2.setReceptierSaler(currentUser);
			customer2.setReceptierSalerName(currentUser.getRealName());
			customerMangeImpl.save(customer2);
			
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer2.getDbid(), "更新客户信息", "");
			/****************************保存customer 信息*******************************/
			
			
			/******************************保存来店登记信息 start******************************/
			CustomerShoppingRecord customerShoppingRecord2 = customerShoppingRecordManageImpl.get(customerShoppingRecord.getDbid());
			customerShoppingRecord2.setCustomer(customer2);
			customerShoppingRecord2.setCarModel(customerShoppingRecord.getCarModel());
			customerShoppingRecord2.setComeInTime(customerShoppingRecord.getComeInTime());
			customerShoppingRecord2.setCustomerNum(customerShoppingRecord.getCustomerNum());
			customerShoppingRecord2.setFarwayTime(customerShoppingRecord.getFarwayTime());
			customerShoppingRecord2.setIsFirst(customerShoppingRecord.getIsFirst());
			customerShoppingRecord2.setIsGetCar(customerShoppingRecord.getIsGetCar());
			customerShoppingRecord2.setReceptionExperience(customerShoppingRecord.getReceptionExperience());
			customerShoppingRecord2.setTryDriver(customerShoppingRecord.getTryDriver());
			customerShoppingRecord2.setWaitingTime(customerShoppingRecord.getWaitingTime());
			customerShoppingRecordManageImpl.save(customerShoppingRecord2);
			customerShoppingRecordManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
			/******************************保存来店登记信息 end******************************/
			
			
			
			/****************************保存customerBussi 信息*******************************/
			CustomerBussi customerBussi2 = customerBussiManageImpl.get(customerBussi.getDbid());
			customerBussi2.setCustomer(customer2);
			Integer buyCarCareId = ParamUtil.getIntParam(request, "buyCarCareId", -1);
			if(buyCarCareId>0){
				BuyCarCare buyCarCare = buyCarCareManageImpl.get(buyCarCareId);
				customerBussi2.setBuyCarCare(buyCarCare);
			}
			Integer buyCarTargetId = ParamUtil.getIntParam(request, "buyCarTargetId", -1);
			if(buyCarTargetId>0){
				BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(buyCarTargetId);
				customerBussi2.setBuyCarTarget(buyCarTarget);
			}
			Integer buyCarTypeId = ParamUtil.getIntParam(request, "buyCarTypeId", -1);
			if(buyCarTypeId>0){
				BuyCarType buyCarType = buyCarTypeManageImpl.get(buyCarTypeId);
				customerBussi2.setBuyCarType(buyCarType);
			}
			
			Integer buyCarBudgetId = ParamUtil.getIntParam(request, "buyCarBudgetId", -1);
			if(buyCarBudgetId>0){
				BuyCarBudget buyCarBudget = buyCarBudgetManageImpl.get(buyCarBudgetId);
				customerBussi2.setBuyCarBudget(buyCarBudget);
			}
			Integer buyCarMainUseId = ParamUtil.getIntParam(request, "buyCarMainUseId", -1);
			if(buyCarMainUseId>0){
				BuyCarMainUse buyCarMainUse = buyCarMainUseManageImpl.get(buyCarMainUseId);
				customerBussi2.setBuyCarMainUse(buyCarMainUse);
			}
			customerBussi2.setAfterPlan(customerBussi.getAfterPlan());
			customerBussi2.setCustomerCareAbout(customerBussi.getCustomerCareAbout());
			customerBussi2.setCustomerNeed(customerBussi.getCustomerNeed());
			customerBussi2.setCustomerSpecification(customerBussi.getCustomerSpecification());
			customerBussi2.setNote(customerBussi.getNote());
			customerBussiManageImpl.save(customerBussi2);
			customerBussiManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
			//更新
			customerRecordManageImpl.updateCustomerRecord(customerRecordId, customer2, customerBussi2,CustomerRecord.RESULTTRACK);
			//初始化跟踪记录基本信息
			if(customerTrack.getTrackType()==(int)CustomerTrack.TYPEACT){
				if (custMarketingActId<0) {
					renderErrorMsg(new Throwable("请选择活动!"), "");
					return ;
				}
				CustMarketingAct custMarketingAct = custMarketingActManageImpl.get(custMarketingActId);
				customerTrack.setCustMarketingAct(custMarketingAct);
			}
			customerTrack2.setTrackDate(new Date());
			customerTrack2.setDealMethod(customerTrack.getDealMethod());
			customerTrack2.setFeedBackResult(customerTrack.getFeedBackResult());
			customerTrack2.setResult(customerTrack.getResult());
			customerTrack2.setTrackContent(customerTrack.getTrackContent());
			customerTrack2.setTrackType(customerTrack.getTrackType());
			customerTrack2.setTrackMethod(customerTrack.getTrackMethod());
			customerTrack2.setTurnBackResult(customerTrack.getTurnBackResult());
			customerTrack2.setCustMarketingAct(customerTrack.getCustMarketingAct());
			//下次跟踪时间
			String nextReservationTime = request.getParameter("customerTrack.nextReservationTime");
			Date string2Date=null;
			if(null!=nextReservationTime){
				string2Date = DateUtil.stringDateWithHHMM(nextReservationTime);
			}
			customerTractUtile.dealPreTaskAndCreateTask(customer2, customerTrack2, string2Date,currentUser);
			
			
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer2.getDbid(), "客户跟踪记录登记", "");
			
			CustMarketingAct custMarketingAct = customerTrack2.getCustMarketingAct();
			if(null!=custMarketingAct){
				//设置邀约总次数
				Integer inviteNum = custMarketingAct.getInviteNum();
				if(null!=inviteNum){
					inviteNum=inviteNum+1;
				}else{
					inviteNum=1;
				}
				custMarketingAct.setInviteNum(inviteNum);
				//设置有效邀约次数
				Integer turnBackResult = customerTrack2.getTurnBackResult();
				if(turnBackResult==CustomerTrack.TYPEACT){
					Integer intentionCustNum = custMarketingAct.getIntentionCustNum();
					if(null!=intentionCustNum){
						intentionCustNum=intentionCustNum+1;
					}else{
						intentionCustNum=1;
					}
					custMarketingAct.setIntentionCustNum(intentionCustNum);
				}
				custMarketingActManageImpl.save(custMarketingAct);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			errorNum=errorNum+1;
			if(errorNum>=3){
				renderErrorMsg(new Throwable("保存发生错误，请联系管理员"), "");
			}else{
				renderErrorMsg(new Throwable("保存发生错误，请稍后再试"), "");
			}
			return ;
		}
		errorNum=1;
		renderMsg("/qywxCustomerRecord/querySalerList","保存数据成功");
		return;
	}
	/**
	 * 功能描述：保存到店登记记录
	 * 参数描述：
	 * 逻辑描述：1、完善客户基础信息；
	 * 			 2、保存客户到店信息
	 * 			 3、完成客户需求评估
	 * 			 4、更新客户跟踪回访记录
	 * 			 5、更新回访活动信息
	 * @return
	 * @throws Exception
	 */
	public void saveComeShopingRecordSuccess(){
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		try{
			User currentUser = getSessionUser();
			Customer customer2 = customerMangeImpl.get(customer.getDbid());
			customerId=customer2.getDbid();
			//获取修改后的追踪级别
			if(null!=customer.getIcard()&&customer.getIcard().trim().length()>0){
				String icard = customer.getIcard();
				customer2.setIcard(icard);
				if(CheckIdCardUtils.validateCard(icard)){
					int age = CheckIdCardUtils.getAgeByIdCard(icard);
					String birthDay = CheckIdCardUtils.getBirthByIdCard(icard);
					customer2.setAge(age);
					customer2.setNbirthday(DateUtil.string2Date(birthDay));
					String gender = CheckIdCardUtils.getGenderByIdCard(icard);
					if(gender.equals("M")){
						customer2.setSex("男");
					}
					if(gender.equals("F")){
						customer2.setSex("女");
					}
				}
			}
			Integer paperworkId = ParamUtil.getIntParam(request, "paperworkId", -1);
			if(paperworkId>0){
				Paperwork paperwork = paperworkManageImpl.get(paperworkId);
				customer2.setPaperwork(paperwork);
			}
			Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			if(areaId>0){
				Area area = areaManageImpl.get(areaId);
				if(null!=area){
					customer2.setArea(area);
				}
			}
			//客户来源
			Integer recommendCustomerId = ParamUtil.getIntParam(request, "recommendCustomerId", -1);
			Integer industryId = ParamUtil.getIntParam(request, "industryId", -1);
			if(industryId>0){
				Industry industry = industryManageImpl.get(industryId);
				customer2.setIndustry(industry);
			}
			Integer professionId = ParamUtil.getIntParam(request, "professionId", -1);
			if(professionId>0){
				Profession profession = professionManageImpl.get(professionId);
				customer2.setProfession(profession);
			}
			Integer educationalId = ParamUtil.getIntParam(request, "educationalId", -1);
			if(educationalId>0){
				Educational educational = educationalManageImpl.get(educationalId);
				customer2.setEducational(educational);
			}
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerBussi.setCarModel(carModel);
			}
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi.setBrand(brand);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerBussi.setCarSeriy(carSeriy);
			}
			if(recommendCustomerId>0){
				RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerId);
				customer2.setRecommendCustomer(recommendCustomer);
			}
			customer2.setAddress(customer.getAddress());
			customer2.setCarColorStr(customer.getCarColorStr());
			customer2.setCarModelStr(customer.getCarModelStr());
			customer2.setCompanyName1(customer.getCompanyName1());
			customer2.setEmail(customer.getEmail());
			customer2.setFamily(customer.getFamily());
			customer2.setIcard(customer.getIcard());
			customer2.setMobilePhone(customer.getMobilePhone());
			customer2.setName(customer.getName());
			if(null!=customer.getNavPrice()){
				customer2.setNavPrice(customer.getNavPrice());
			}
			customer2.setNbirthday(customer.getNbirthday());
			customer2.setAge(customer.getAge());
			customer2.setNote(customer.getNote());
			customer2.setPhone(customer.getPhone());
			customer2.setQq(customer.getQq());
			customer2.setSex(customer.getSex());
			customer2.setZipCode(customer.getZipCode());
			customer2.setTryCarStatus(tryCarStatus);
			//试乘试驾状态
			if(tryCarStatus==2){
				customer2.setTryCarDate(new Date());
			}
			Integer trackNum = customer2.getTrackNum();
			if(trackNum!=null){
				trackNum=trackNum+1;
			}else{
				trackNum=1;
			}
			Integer comeShopStatus = customer2.getComeShopStatus();
			if (null==comeShopStatus||comeShopStatus==1) {
				customer2.setComeShopStatus(2);
				customer2.setComeShopDate(new Date());
				customer2.setComeShopNum(1);
			}else{
				if (comeShopStatus==2) {
					customer2.setComeShopStatus(3);
					customer2.setComeShopNum(2);
					customer2.setTwoComeShopDate(new Date());
				}
				if (comeShopStatus==3) {
					Integer comeShopNum = customer2.getComeShopNum();
					customer2.setComeShopNum(comeShopNum++);
					customer2.setTwoComeShopDate(new Date());
				}
			}
			customer2.setTrackNum(trackNum);
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			if(customerPhaseId>0){
				CustomerPhase customerPhase = customerPhaseManageImpl.get(customerPhaseId);
				//客户跟踪后的级别
				customer2.setCustomerPhase(customerPhase);
			}
			customer2.setReceptierSaler(currentUser);
			customer2.setReceptierSalerName(currentUser.getRealName());
			//更新销售顾问信息
			customer2.setUser(currentUser);
			customer2.setBussiStaff(currentUser.getRealName());
			Department department = currentUser.getDepartment();
			if(null!=department){
				customer2.setSuccessDepartment(department);
			}
			
			customerMangeImpl.save(customer2);
			
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer2.getDbid(), "更新客户信息", "");
			/****************************保存customer 信息*******************************/
			
			
			/******************************保存来店登记信息 start******************************/
			CustomerShoppingRecord customerShoppingRecord2 = customerShoppingRecordManageImpl.get(customerShoppingRecord.getDbid());
			customerShoppingRecord2.setCustomer(customer2);
			customerShoppingRecord2.setCarModel(customerShoppingRecord.getCarModel());
			customerShoppingRecord2.setComeInTime(customerShoppingRecord.getComeInTime());
			customerShoppingRecord2.setCustomerNum(customerShoppingRecord.getCustomerNum());
			customerShoppingRecord2.setFarwayTime(customerShoppingRecord.getFarwayTime());
			customerShoppingRecord2.setIsFirst(customerShoppingRecord.getIsFirst());
			customerShoppingRecord2.setIsGetCar(customerShoppingRecord.getIsGetCar());
			customerShoppingRecord2.setReceptionExperience(customerShoppingRecord.getReceptionExperience());
			customerShoppingRecord2.setTryDriver(customerShoppingRecord.getTryDriver());
			customerShoppingRecord2.setWaitingTime(customerShoppingRecord.getWaitingTime());
			customerShoppingRecordManageImpl.save(customerShoppingRecord2);
			customerShoppingRecordManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
			/******************************保存来店登记信息 end******************************/
			
			
			
			/****************************保存customerBussi 信息*******************************/
			CustomerBussi customerBussi2 = customerBussiManageImpl.get(customerBussi.getDbid());
			customerBussi2.setCustomer(customer2);
			Integer buyCarCareId = ParamUtil.getIntParam(request, "buyCarCareId", -1);
			if(buyCarCareId>0){
				BuyCarCare buyCarCare = buyCarCareManageImpl.get(buyCarCareId);
				customerBussi2.setBuyCarCare(buyCarCare);
			}
			Integer buyCarTargetId = ParamUtil.getIntParam(request, "buyCarTargetId", -1);
			if(buyCarTargetId>0){
				BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(buyCarTargetId);
				customerBussi2.setBuyCarTarget(buyCarTarget);
			}
			Integer buyCarTypeId = ParamUtil.getIntParam(request, "buyCarTypeId", -1);
			if(buyCarTypeId>0){
				BuyCarType buyCarType = buyCarTypeManageImpl.get(buyCarTypeId);
				customerBussi2.setBuyCarType(buyCarType);
			}
			
			Integer buyCarBudgetId = ParamUtil.getIntParam(request, "buyCarBudgetId", -1);
			if(buyCarBudgetId>0){
				BuyCarBudget buyCarBudget = buyCarBudgetManageImpl.get(buyCarBudgetId);
				customerBussi2.setBuyCarBudget(buyCarBudget);
			}
			Integer buyCarMainUseId = ParamUtil.getIntParam(request, "buyCarMainUseId", -1);
			if(buyCarMainUseId>0){
				BuyCarMainUse buyCarMainUse = buyCarMainUseManageImpl.get(buyCarMainUseId);
				customerBussi2.setBuyCarMainUse(buyCarMainUse);
			}
			customerBussi2.setAfterPlan(customerBussi.getAfterPlan());
			customerBussi2.setCustomerCareAbout(customerBussi.getCustomerCareAbout());
			customerBussi2.setCustomerNeed(customerBussi.getCustomerNeed());
			customerBussi2.setCustomerSpecification(customerBussi.getCustomerSpecification());
			customerBussi2.setNote(customerBussi.getNote());
			customerBussiManageImpl.save(customerBussi2);
			customerBussiManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			//更新
			customerRecordManageImpl.updateCustomerRecord(customerRecordId, customer2, customerBussi2,CustomerRecord.RESULTTRACK);
		} catch (Exception e) {
			e.printStackTrace();
			errorNum=errorNum+1;
			if(errorNum>=3){
				renderErrorMsg(new Throwable("保存发生错误，请联系管理员"), "");
			}else{
				renderErrorMsg(new Throwable("保存发生错误，请稍后再试"), "");
			}
			return ;
		}
		errorNum=1;
		renderMsg("/qywxOrderContract/addOrderContract?customerId="+customerId+"&editType=1","保存数据成功");
		return;
	}
	/**
	 * 功能描述：流失客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User user = getSessionUser();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		try {
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			Enterprise enterprise = user.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			String sql="select * from cust_Customer cu,cust_CustomerBussi as cb where cb.customerId=cu.dbid and bussiStaffId=?  and cu.lastResult>?";
			List params=new ArrayList();
			params.add(user.getDbid());
			//表示购买其他车
			params.add(Customer.SUCCESS);
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				params.add(customerPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				params.add("%"+name+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cb.carSeriyId=? ";
				params.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cb.brandId=? ";
				params.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cb.carModelId=? ";
				params.add(carModelId);
			}
			sql=sql+" order by cu.createFolderTime DESC";
			
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "outFlow";
	}
	/**
	 * 功能描述：流失客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryLeaderOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String startApprovalTime = request.getParameter("startApprovalTime");
		String endApprovalTime = request.getParameter("endApprovalTime");
		String startFolderTime = request.getParameter("startFolderTime");
		String endFolderTime = request.getParameter("endFolderTime");
		String mobilePhone = request.getParameter("mobilePhone");
		String userName = request.getParameter("userName");
		String name = request.getParameter("name");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer customerFlowReasonId = ParamUtil.getIntParam(request, "customerFlowReasonId", -1);
		Integer cityCrossCustomerId = ParamUtil.getIntParam(request, "cityCrossCustomerId", -1);
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		try {
			Enterprise enterprise = user.getEnterprise();
			Department department = user.getDepartment();
			if(user.getQueryOtherDataStatus()==(int)User.QUERYYES){
				List<User> users = userManageImpl.findBy("enterprise.dbid",enterprise.getDbid());
				request.setAttribute("users", users);
			}else{
				List<User> users = userManageImpl.findBy("department.dbid",department.getDbid());
				request.setAttribute("users", users);
			}
			

			List<CustomerFlowReason> customerFlowReasons = customerFlowReasonManageImpl.getAll();
			request.setAttribute("customerFlowReasons", customerFlowReasons);
			
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
			
			
			String sql="select cu.* from "
					+ "cust_Customer as cu,cust_CustomerLastBussi as clb,cust_customerbussi cb "
					+ "where clb.customerId=cu.dbid and cu.lastResult>? AND cb.customerId=cu.dbid ";
			if(enterprise.getDbid()>0){
				sql=sql+" AND cu.enterpriseId="+enterprise.getDbid();
			}
			List param= new ArrayList();
			param.add(Customer.SUCCESS);
			if(customerFlowReasonId>0){
				sql=sql+" and  clb.customerFlowReasonId=? ";
				param.add(customerFlowReasonId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and clb.createTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and clb.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
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
			if(null!=startApprovalTime&&startApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate>= ? ";
				param.add(DateUtil.string2Date(startApprovalTime));
			}
			if(null!=endApprovalTime&&endApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate< ? ";
				param.add(DateUtil.nextDay(endApprovalTime));
			}
			if(approvalStatus>=0){
				sql=sql+" and clb.approvalStatus=? ";
				param.add(approvalStatus);
			}
			if(null!=startFolderTime&&startFolderTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime>= ? ";
				param.add(DateUtil.string2Date(startFolderTime));
			}
			if(null!=endFolderTime&&endFolderTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime< ? ";
				param.add(DateUtil.nextDay(endFolderTime));
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(cityCrossCustomerId>0){
				sql=sql+"  and  cu.cityCrossCustomerId=? ";
				param.add(cityCrossCustomerId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			sql=sql+" order by clb.approvalStatus,clb.approvalDate DESC ";
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
			long  dayCustomerNum = customerMangeImpl.countSqlResult(sql, param.toArray());
			request.setAttribute("dayCustomerNum", dayCustomerNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderOutFlow";
	}
	/**
	 * 功能描述：订单客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User user = getSessionUser();
		Integer status = ParamUtil.getIntParam(request, "status", -1);
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
		try{
			Enterprise enterprise = user.getEnterprise();
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
			String sql="select * from cust_orderContract as orderc,"
					+ " cust_Customer as cu,"
					+ "cust_CustomerBussi as cb  where"
					+ " cu.bussiStaffId=?  and orderc.customerId=cu.dbid AND  cb.customerId=cu.dbid ";
			List param= new ArrayList();
			param.add(user.getDbid());
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
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
				sql=sql+" and createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=startOrderTime&&startOrderTime.trim().length()>0){
				sql=sql+" and createTime >= ? ";
				param.add(DateUtil.string2Date(startOrderTime));
			}
			if(null!=endOrderTime&&endOrderTime.trim().length()>0){
				sql=sql+" and createTime < ? ";
				param.add(DateUtil.nextDay(endOrderTime));
			}
			sql=sql+" order by createTime DESC";
			Page<OrderContract> page= orderContractManageImpl.pagedQuerySql(pageNo, pageSize, OrderContract.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "orderCustomer";
	}
	/**
	 * 功能描述：待交车客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String waitingHandCar() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		try {
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			Enterprise enterprise = user.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where bussiStaffId=?  and cpid.customerId=cu.dbid and cpid.pidStatus>=? and cpid.pidStatus!=2";
			List params=new ArrayList();
			params.add(user.getDbid());
			params.add(CustomerPidBookingRecord.PRINT);
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				params.add(customerPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				params.add("%"+name+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cpid.carSeriyId=? ";
				params.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cpid.brandId=? ";
				params.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				params.add(carModelId);
			}
			sql=sql+" order by cu.createFolderTime DESC";
			List<Customer> customers = customerMangeImpl.executeSql(sql,params.toArray());
			request.setAttribute("customers", customers);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "waitingHandCar";
	}
	/**
	 * 功能描述：待交车客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String successCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
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
		try {
			Enterprise enterprise = user.getEnterprise();
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
			param.add(user.getDbid());
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
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "successCustomer";
	}
	/**
	 * 功能描述：客户资料明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
			
			//客户跟踪记录
			List<CustomerTrack> customertracks = customerTrackManageImpl.find("from CustomerTrack where taskDealStatus=2 AND customer.dbid=? ", new Object[]{customer2.getDbid()});
			request.setAttribute("customertracks", customertracks);
			
			
			//最终结果信息
			CustomerLastBussi customerLastBussi = customer2.getCustomerLastBussi();
			request.setAttribute("customerLastBussi", customerLastBussi);
			
			//客户订单信息
			OrderContract orderContract = customer2.getOrderContract();
			request.setAttribute("orderContract", orderContract);
			
			if(null!=orderContract){
				List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract.getDbid());
				request.setAttribute("orderContractProducts", orderContractProducts);
				
				//审批记录
				List<ApprovalRecord> approvalRecords = approvalRecordManageImpl.findBy("orderContract.dbid", orderContract.getDbid());
				request.setAttribute("approvalRecords", approvalRecords);
			}
			
			//客户交车记录
			CustomerPidBookingRecord customerPidBookingRecord = customer2.getCustomerPidBookingRecord();
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
			//合同流失审批记录
			if(null!=customerPidBookingRecord){
				List<CustomerPidCancel> customerPidCancels = customerPidCancelManageImpl.findBy("customerPidBookingRecord.dbid",customerPidBookingRecord.getDbid());
				request.setAttribute("customerPidCancels", customerPidCancels);
				if(null!=customerPidCancels&&customerPidCancels.size()>0){
					int size = customerPidCancels.size();
					request.setAttribute("customerPidCancel", customerPidCancels.get(size-1));
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerDetail";
	}
	/**
	 * 功能描述：订单明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			//意向车型
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				request.setAttribute("orderContract", orderContract2);
				request.setAttribute("customer", orderContract2.getCustomer());
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", dbid);
				if(null!=orderContractDecores&&orderContractDecores.size()==1){
					OrderContractDecore orderContractDecore = orderContractDecores.get(0);
					request.setAttribute("orderContractDecore", orderContractDecore);
				}
				Customer customer = orderContract2.getCustomer();
				if(null!=customer){
					List<OrderContractExpenses> orderContractExpenseses = orderContractExpensesManageImpl.findBy("customer.dbid", customer.getDbid());
					if(null!=orderContractExpenseses&&orderContractExpenseses.size()==1){
						OrderContractExpenses orderContractExpenses = orderContractExpenseses.get(0);
						request.setAttribute("orderContractExpenses", orderContractExpenses);
						
						List<OrderContractExpensesChargeItem> orderContractExpensesChargeItems = orderContractExpensesChargeItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
						request.setAttribute("orderContractExpensesChargeItems", orderContractExpensesChargeItems);
						List<OrderContractExpensesPreferenceItem> orderContractExpensesPreferenceItems = orderContractExpensesPreferenceItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
						request.setAttribute("orderContractExpensesPreferenceItems", orderContractExpensesPreferenceItems);
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "orderDetail";
	}
	/**
	 * 功能描述：查询成交客户
	 * 参数描述：部门ID，车系Id
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String querySuccess() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer departmentId = ParamUtil.getIntParam(request,"departmentId",-1);
		Integer carSeriyId = ParamUtil.getIntParam(request,"carSeriyId",-1);
		String startTime = request.getParameter("start");
		String endTime = request.getParameter("end");
		Date start=null;
		Date end=null;
		try {
			if(null!=startTime&&startTime.trim().length()>0){
				String date =new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date(startTime));
				start = DateUtil.string2Date(date);
			}else{
				start=new Date();
			}
			if(null!=endTime&&endTime.trim().length()>0){
				String date =new java.text.SimpleDateFormat("yyyy-MM-dd").format(new Date(endTime));
				end=DateUtil.nextDay(date);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where   cpid.customerId=cu.dbid  AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED ;
			List param= new ArrayList();
			sql=sql+" and cu.successDepartmentId =? ";
			param.add(departmentId);
			sql=sql+" and cpid.carSeriyId =? ";
			param.add(carSeriyId);
			sql=sql+" AND cpid.modifyTime>='"+DateUtil.format(start)+"'" +" AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
			sql=sql+" order by cpid.createTime DESC ";
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			request.setAttribute("customers", customers);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "querySuccess";
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
		HttpSession session = request.getSession();
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		try {
			String mobilePhone = request.getParameter("customer.mobilePhone");
			//User user=(User)session.getAttribute("user");
			User user = getSessionUser();
			if(null==user){
				renderErrorMsg(new Throwable("未获取到用户信息！"),"");
				return ;
			}
			Customer customer2 = validateCustomer(mobilePhone, user.getDbid());
			if(null!=customer2){
				renderErrorMsg(new Throwable("电话号码已存在系统中，请确认！"),"");
				return ;
			}
			if(customerInfromId<0){
				renderErrorMsg(new Throwable("请选择客户来源！"),"");
				return ;
			}
			
			if(null==customer){
				customer=new Customer();
			}
			CustomerRecord customerRecord=null;
			//设置来店次数
			if(customerRecordId>0){
				customerRecord = customerRecordManageImpl.get(customerRecordId);
				if(null!=customerRecord){
					customer.setComeShopNum(customerRecord.getComeinNum());
				}else{
					customer.setComeShopNum(1);
				}
				User agentUser = customerRecord.getAgentUser();
				if(null!=agentUser){
					user=customerRecord.getSaler();
				}
			}else{
				customer.setComeShopNum(1);
			}
			//设置互动次数
			customer.setTrackNum(0);
			
			Enterprise enterprise = user.getEnterprise();
			String no=DateUtil.generatedName(new Date());
			customer.setSn(no);
			if(null==customer.getDbid()||customer.getDbid()<=0){
				//客户最终状态
				customer.setLastResult(Customer.NORMAL);
				//客户订单状态
				customer.setOrderContractStatus(Customer.ORDERNOT);
			}
			CustomerInfrom customerInfrom = customerInfromManageImpl.get(customerInfromId);
			if(null!=customerInfrom){
				customer.setCustomerInfrom(customerInfrom);
			}
			customer.setBussiStaff(user.getRealName());
			customer.setDepartment(user.getDepartment());
			customer.setUser(user);
			customer.setBussiStaff(user.getRealName());
			String name = request.getParameter("customer.name");
			customer.setName(name);
			customer.setMobilePhone(mobilePhone);
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			if(null==customerBussi){
				customerBussi=new CustomerBussi(); 
			}
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerBussi.setCarModel(carModel);
			}
			Integer firstCustomerPhaseDbid = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			CustomerPhase customerPhase=null;
			if(firstCustomerPhaseDbid>0){
				customerPhase = customerPhaseManageImpl.get(firstCustomerPhaseDbid);
				customer.setFirstCustomerPhase(customerPhase);
				//需修改状态
				customer.setCustomerPhase(customerPhase);
			}
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi.setBrand(brand);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerBussi.setCarSeriy(carSeriy);
			}
			customer.setRecordType(Customer.CUSTOMERTYPECOMM);
			customer.setKdStatus(Customer.KDCOMM);
			customer.setDmsStatus(Customer.DMSCOMM);
			customer.setCreateFolderTime(new Date());
			customer.setEnterprise(enterprise);
			Integer bussiType = enterprise.getBussiType();
			if(null==bussiType){
				customer.setBussiType(1);
			}else{
				customer.setBussiType(bussiType);
			}
			customer.setLoanFinStatus(1);
			customer.setLoanType(1);
			customer.setCustCartrialerStatus(1);
			customer.setSourceEnterprise(enterprise);
			customerMangeImpl.save(customer);
			
			
			customerBussi.setCustomer(customer);
			customerBussiManageImpl.save(customerBussi);
			
			if(null==customerShoppingRecord){
				customerShoppingRecord=new CustomerShoppingRecord();
			}
			customerShoppingRecord.setCustomer(customer);
			if(null!=customerRecord){
				customerShoppingRecord.setComeInTime(customerRecord.getComeInTime());
				customerShoppingRecord.setCustomerNum(customerRecord.getCustomerNum());
				
			}
			customerShoppingRecordManageImpl.save(customerShoppingRecord);
			
			
			/**********************************************保存超时信息表********************************************************/
			
			//更新线索记录
			if(null!=customerRecord){
				customerRecord.setResultStatus(CustomerRecord.RESULTRECORD);
				customerRecord.setName(customer.getName());
				customerRecord.setMobilePhone(customer.getMobilePhone());
				customerRecord.setBrand(customerBussi.getBrand());
				customerRecord.setCarModel(customerBussi.getCarModel());
				customerRecord.setCarSeriy(customerBussi.getCarSeriy());
				customerRecord.setResultDate(new Date());
				customerRecord.setCustomer(customer);
				customerRecordManageImpl.save(customerRecord);
			}
			//创建客户跟踪任务
			customerTractUtile.createCustomerToCreateTask(customer);
			Integer type = ParamUtil.getIntParam(request, "type", 1);
			if(type==1){
				renderMsg("/qywxCustomerRecord/querySalerList", "保存客户信息成，返回线索列表页面");
			}
			if(type==2){
				renderMsg("/qywxCustomer/list", "保存客户信息成功,返回客户登记列表页面");
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
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
	public void saveEdit() {
		HttpServletRequest request = getRequest();
		User currentUser = getSessionUser();
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", 1);
		try{
			Customer customer2 = customerMangeImpl.get(customer.getDbid());
			//获取修改后的追踪级别
			if(null!=customer.getIcard()&&customer.getIcard().trim().length()>0){
				String icard = customer.getIcard();
				if(CheckIdCardUtils.validateCard(icard)){
					int age = CheckIdCardUtils.getAgeByIdCard(icard);
					String birthDay = CheckIdCardUtils.getBirthByIdCard(icard);
					customer2.setAge(age);
					customer2.setNbirthday(DateUtil.string2Date(birthDay));
					String gender = CheckIdCardUtils.getGenderByIdCard(icard);
					if(gender.equals("M")){
						customer2.setSex("男");
					}
					if(gender.equals("F")){
						customer2.setSex("女");
					}
				}
			}
			Integer paperworkId = ParamUtil.getIntParam(request, "paperworkId", -1);
			if(paperworkId>0){
				Paperwork paperwork = paperworkManageImpl.get(paperworkId);
				customer2.setPaperwork(paperwork);
			}
			Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			if(areaId>0){
				Area area = areaManageImpl.get(areaId);
				if(null!=area){
					customer2.setArea(area);
				}
			}
			//客户来源
			Integer recommendCustomerId = ParamUtil.getIntParam(request, "recommendCustomerId", -1);
			customer2.setDepartment(currentUser.getDepartment());
			customer2.setSuccessDepartment(currentUser.getDepartment());
			
			Integer industryId = ParamUtil.getIntParam(request, "industryId", -1);
			if(industryId>0){
				Industry industry = industryManageImpl.get(industryId);
				customer2.setIndustry(industry);
			}
			Integer professionId = ParamUtil.getIntParam(request, "professionId", -1);
			if(professionId>0){
				Profession profession = professionManageImpl.get(professionId);
				customer2.setProfession(profession);
			}
			Integer educationalId = ParamUtil.getIntParam(request, "educationalId", -1);
			if(educationalId>0){
				Educational educational = educationalManageImpl.get(educationalId);
				customer2.setEducational(educational);
			}
			if(recommendCustomerId>0){
				RecommendCustomer recommendCustomer = recommendCustomerManageImpl.get(recommendCustomerId);
				customer2.setRecommendCustomer(recommendCustomer);
			}
			Enterprise enterprise = currentUser.getEnterprise();
			customer2.setEnterprise(enterprise);
			customer2.setAddress(customer.getAddress());
			customer2.setCarColorStr(customer.getCarColorStr());
			customer2.setCarModelStr(customer.getCarModelStr());
			customer2.setCompanyName1(customer.getCompanyName1());
			customer2.setEmail(customer.getEmail());
			customer2.setFamily(customer.getFamily());
			customer2.setIcard(customer.getIcard());
			customer2.setMobilePhone(customer.getMobilePhone());
			customer2.setName(customer.getName());
			if(null!=customer.getNavPrice()){
				customer2.setNavPrice(customer.getNavPrice());
			}
			customer2.setNbirthday(customer.getNbirthday());
			customer2.setAge(customer.getAge());
			customer2.setNote(customer.getNote());
			customer2.setPhone(customer.getPhone());
			customer2.setQq(customer.getQq());
			customer2.setSex(customer.getSex());
			customer2.setZipCode(customer.getZipCode());
			customer2.setTryCarStatus(tryCarStatus);
			//试乘试驾状态
			if(tryCarStatus==2){
				customer2.setTryCarDate(new Date());
			}
			customer2.setTryCarStatus(tryCarStatus);
			customerMangeImpl.save(customer2);
			
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer2.getDbid(), "更新客户信息", "");
			/****************************保存customer 信息*******************************/
			
			
			/******************************保存来店登记信息 start******************************/
			CustomerShoppingRecord customerShoppingRecord2 = customerShoppingRecordManageImpl.get(customerShoppingRecord.getDbid());
			customerShoppingRecord2.setCustomer(customer2);
			customerShoppingRecord2.setCarModel(customerShoppingRecord.getCarModel());
			customerShoppingRecord2.setComeInTime(customerShoppingRecord.getComeInTime());
			customerShoppingRecord2.setCustomerNum(customerShoppingRecord.getCustomerNum());
			customerShoppingRecord2.setFarwayTime(customerShoppingRecord.getFarwayTime());
			customerShoppingRecord2.setIsFirst(customerShoppingRecord.getIsFirst());
			customerShoppingRecord2.setIsGetCar(customerShoppingRecord.getIsGetCar());
			customerShoppingRecord2.setReceptionExperience(customerShoppingRecord.getReceptionExperience());
			customerShoppingRecord2.setTryDriver(customerShoppingRecord.getTryDriver());
			customerShoppingRecord2.setWaitingTime(customerShoppingRecord.getWaitingTime());
			customerShoppingRecordManageImpl.save(customerShoppingRecord2);
			customerShoppingRecordManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
			/******************************保存来店登记信息 end******************************/
			
			
			
			/****************************保存customerBussi 信息*******************************/
			CustomerBussi customerBussi2 = customerBussiManageImpl.get(customerBussi.getDbid());
			customerBussi2.setCustomer(customer2);
			Integer buyCarCareId = ParamUtil.getIntParam(request, "buyCarCareId", -1);
			if(buyCarCareId>0){
				BuyCarCare buyCarCare = buyCarCareManageImpl.get(buyCarCareId);
				customerBussi2.setBuyCarCare(buyCarCare);
			}
			Integer buyCarTargetId = ParamUtil.getIntParam(request, "buyCarTargetId", -1);
			if(buyCarTargetId>0){
				BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(buyCarTargetId);
				customerBussi2.setBuyCarTarget(buyCarTarget);
			}
			Integer buyCarTypeId = ParamUtil.getIntParam(request, "buyCarTypeId", -1);
			if(buyCarTypeId>0){
				BuyCarType buyCarType = buyCarTypeManageImpl.get(buyCarTypeId);
				customerBussi2.setBuyCarType(buyCarType);
			}
			
			Integer buyCarBudgetId = ParamUtil.getIntParam(request, "buyCarBudgetId", -1);
			if(buyCarBudgetId>0){
				BuyCarBudget buyCarBudget = buyCarBudgetManageImpl.get(buyCarBudgetId);
				customerBussi2.setBuyCarBudget(buyCarBudget);
			}
			Integer buyCarMainUseId = ParamUtil.getIntParam(request, "buyCarMainUseId", -1);
			if(buyCarMainUseId>0){
				BuyCarMainUse buyCarMainUse = buyCarMainUseManageImpl.get(buyCarMainUseId);
				customerBussi2.setBuyCarMainUse(buyCarMainUse);
			}
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerBussi2.setCarModel(carModel);
			}
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi2.setBrand(brand);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			if(carSeriyId>0){
				CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerBussi2.setCarSeriy(carSeriy);
			}
			customerBussi2.setAfterPlan(customerBussi.getAfterPlan());
			customerBussi2.setCustomerCareAbout(customerBussi.getCustomerCareAbout());
			customerBussi2.setCustomerNeed(customerBussi.getCustomerNeed());
			customerBussi2.setCustomerSpecification(customerBussi.getCustomerSpecification());
			customerBussi2.setNote(customerBussi.getNote());
			customerBussiManageImpl.save(customerBussi2);
			customerBussiManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		Integer type = ParamUtil.getIntParam(request, "type",-1);
		renderMsg("/qywxCustomer/list", "保存数据成功！");
		return;
	}
	/**
	 * 验证销售顾问填写两个相同的客户信息
	 * @param name
	 * @param mobilePhone
	 * @return
	 */
	public Customer validateCustomer(String mobilePhone,Integer bussiStaffId){
		if(null!=mobilePhone&&mobilePhone.trim().length()>0){
			List<Customer> customers = customerMangeImpl.find("from Customer where  mobilePhone=? and bussiStaffId=? ", new Object[]{mobilePhone,bussiStaffId});
			if(null!=customers&&customers.size()>0){
				for (Customer customer : customers) {
					CustomerPhase customerPhase = customer.getCustomerPhase();
					if(customerPhase.getName().equals("F")){
						return null;
					}
					return customer;
				}
			}else{
				return null;
			}
		}
		return null;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerTrackId = ParamUtil.getIntParam(request, "customerTrackId", -1);
		try {
			CustomerTrack customerTrack = customerTrackManageImpl.get(customerTrackId);
			request.setAttribute("customerTrack", customerTrack);
			request.setAttribute("customer", customerTrack.getCustomer());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewCustomerTrack";
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
			if(brandId>0){
				List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brandId,CarSeriy.STATUSCOMM});
				StringBuffer buffer=new StringBuffer();
				if(null!=carSeriys&&carSeriys.size()>0){
					buffer.append("<option>请选择车系...</option>");
					for (CarSeriy carSeriy : carSeriys) {
						buffer.append("<option value='"+carSeriy.getDbid()+"'>"+carSeriy.getName()+"</option>");
					}
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
	public void ajaxCarSeriyContent() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try{
			if(brandId>0){
				List<CarSeriy> carSeriys = carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brandId,CarSeriy.STATUSCOMM});
				StringBuffer buffer=new StringBuffer();
				if(null!=carSeriys&&carSeriys.size()>0){
					buffer.append("<select class=\"form-control\" id=\"carSeriyId\" name=\"carSeriyId\"  onchange=\"ajaxCarModel('carSeriyId')\">");
					buffer.append("<option>请选择车系...</option>");
					for (CarSeriy carSeriy : carSeriys) {
						buffer.append("<option value='"+carSeriy.getDbid()+"'>"+carSeriy.getName()+"</option>");
					}
					buffer.append("</select>");
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
				List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriyId,CarSeriy.STATUSCOMM});
				StringBuffer buffer=new StringBuffer();
				if(null!=carModels&&carModels.size()>0){
					buffer.append("<option value=''>请选择车型...</option>");
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"&nbsp;&nbsp;价格:"+carModel.getNavPrice()+"</option>");
					}
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
	public void test() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String code = request.getParameter("code");
			JSONObject jsonObject=new JSONObject();
			jsonObject.put("code", code);
			renderJson(jsonObject.toString());
			System.err.println("========================="+jsonObject.toString());
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
	public String test2() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String code = request.getParameter("code");
			request.setAttribute("code", code);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "test";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCarModelBySeriyContent() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			if(carSeriyId>0){
				List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriyId,CarSeriy.STATUSCOMM});
				StringBuffer buffer=new StringBuffer();
				if(null!=carModels&&carModels.size()>0){
					buffer.append("<select id='carModelId' name='carModelId' class=\"form-control\">");
					buffer.append("<option value=''>请选择车型...</option>");
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"</option>");
					}
					buffer.append("</select>");
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
	private void countTrack(User user){
		HttpServletRequest request = this.getRequest();
		try {
			/////////////////////////今日需要回访客户=次日回访客户+到期回访客户///////////////////////
			String theNextSql="select * from  cust_customertrack AS custtrack,cust_customer AS cust"+
					" where "+ 
					" cust.dbid=custtrack.customerId AND cust.lastResult<2  "+
					" AND cust.bussiStaffId="+user.getDbid()+" AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
					"  AND ("
					+ "(custtrack.nextReservationTime<date_sub(curdate(),interval -1 day) AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+") "
					+ "or "
					+ "(DATE_FORMAT(custtrack.nextReservationTime,'%Y-%m-%d')=date_sub(curdate(),interval 0 day) AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSETWO+")"
					+ ")  order By cust.lastResult ";
			long  todayTommorwNum = customerMangeImpl.countSqlResult(theNextSql, null);
			request.setAttribute("todayNum", todayTommorwNum);
			
			////////////////////////////////////////今日需要回访客户  end/////////////////////////////////
			
			////////////////////////////////////////明日需要回访客户=今天登记客户（次日回访）+明日需要回访客户  开始/////////////////////////////////
			String tomSqlTotal="select * from  cust_customertrack AS custtrack,cust_customer AS cust"+
					" where "+ 
					" cust.dbid=custtrack.customerId  AND  custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
					" AND cust.bussiStaffId="+user.getDbid()+" AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
					"  AND DATE_FORMAT(custtrack.nextReservationTime,'%Y-%m-%d')=date_sub(curdate(),interval -1 day)";
			long  tomTommorwNum = customerMangeImpl.countSqlResult(tomSqlTotal, null);
			request.setAttribute("tomNum", tomTommorwNum);
			////////////////////////////////////////明日需要回访客户=今天登记客户（次日回访）+明日需要回访客户  结束/////////////////////////////////
			
			
			//最近3天需跟进客户
			String trackSql="select * from cust_customertrack AS custtrack,cust_customer AS cust " +
					" where " +
					" cust.bussiStaffId="+user.getDbid()+" AND cust.dbid=custtrack.customerId AND custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+
					"  AND "
					+ " custtrack.nextReservationTime<date_sub(curdate(),interval -4 day) AND custtrack.nextReservationTime>date_sub(curdate(),interval -1 day) AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
					"  order by nextReservationTime ";
			long  threeDayNum = customerMangeImpl.countSqlResult(trackSql, null);
			request.setAttribute("threeDayNum", threeDayNum);
		} catch (Exception e) {
		}
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCarSeriyOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try{
			if(brandId>0){
				List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("brand.dbid",brandId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carSeriys&&carSeriys.size()>0){
					for (CarSeriy carSeriy : carSeriys) {
						buffer.append("<option value='"+carSeriy.getDbid()+"'>"+carSeriy.getBrand().getName()+" "+carSeriy.getName()+"</option>");
					}
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
	public void ajaxCarModelBySeriyOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			if(carSeriyId>0){
				List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriyId);
				StringBuffer buffer=new StringBuffer();
				if(null!=carModels&&carModels.size()>0){
					for (CarModel carModel : carModels) {
						buffer.append("<option value='"+carModel.getDbid()+"'>"+carModel.getName()+"&nbsp;&nbsp;价格:"+carModel.getNavPrice()+"</option>");
					}
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
	public void ajaxCarColorStatus() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try{
			StringBuffer buffer=new StringBuffer();
			if(carSeriyId>0){
				List<CarColor> carColors = carColorManageImpl.findBy("carseries.dbid",carSeriyId);
				if(null!=carColors&&carColors.size()>0){
					for (CarColor carColor : carColors) {
						buffer.append("<option value='"+carColor.getDbid()+"'>"+carColor.getName()+"</option>");
					}
					renderText(buffer.toString());
				}else{
					renderText(buffer.toString());
				}
			}else{
				renderText(buffer.toString());
				return ;
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
	 * 功能描述：客户资料查询
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String leaderList() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer cityCrossId = ParamUtil.getIntParam(request, "cityCrossId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
		Integer comeType = ParamUtil.getIntParam(request, "comeType", -1);
		Integer bussiStaffId = ParamUtil.getIntParam(request, "bussiStaffId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		String name = request.getParameter("name");
		String receptierSalerName = request.getParameter("receptierSalerName");
		String invitationSalerName = request.getParameter("invitationSalerName");
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String tryCarStartTime = request.getParameter("tryCarStartTime");
		String tryCarEndTime = request.getParameter("tryCarEndTime");
		String comeShopStartTime = request.getParameter("comeShopStartTime");
		String comeShopEndTime = request.getParameter("comeShopEndTime");
		try {
			Enterprise enterprise = user.getEnterprise();
			Department department = user.getDepartment();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			
			if(customerInfromId>0){
				CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(customerInfromId);
				String cusString = customerInfromManageImpl.getCustomerInfrom(customerInfrom2);
				request.setAttribute("customerInfromSelect", cusString);
			}else{
				String cusString = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", cusString);
			}
			
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			
			if(user.getQueryOtherDataStatus()==(int)User.QUERYYES){
				List<User> users = userManageImpl.findBy("enterprise.dbid",enterprise.getDbid());
				request.setAttribute("users", users);
			}else{
				List<User> users = userManageImpl.findBy("department.dbid",department.getDbid());
				request.setAttribute("users", users);
			}
			
			
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String sql="select cu.* from " +
					"	cust_Customer as cu"
					+ " LEFT JOIN "
					+ " cust_CustomerBussi as cb"
					+ " ON cb.customerId=cu.dbid "
					+ " LEFT JOIN "
					+ " cust_customerlastbussi custlb "
					+ " ON cu.dbid=custlb.customerId "
					+ "   where  1=1 ";
			if(enterprise.getDbid()>0){
				sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
			}
			List param= new ArrayList();
			if(customerPhaseId>0){
				sql=sql+" and customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(trackingPhaseId>0){
				sql=sql+" and cb.trackingPhaseId=? ";
				param.add(trackingPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=receptierSalerName&&receptierSalerName.trim().length()>0){
				sql=sql+" and cu.receptierSalerName like ? ";
				param.add("%"+receptierSalerName+"%");
			}
			if(null!=invitationSalerName&&invitationSalerName.trim().length()>0){
				sql=sql+" and cu.invitationSalerName like ? ";
				param.add("%"+invitationSalerName+"%");
			}
			if(null!=lastResult&&lastResult>=0){
				sql=sql+" and cu.lastResult = ? ";
				param.add(lastResult);
			}
			if(null!=comeShopStatus&&comeShopStatus>0){
				sql=sql+" and cu.comeShopStatus = ? ";
				param.add(comeShopStatus);
			}
			if(customerInfromId>0){
				sql=sql+" and cu.customerInfromId=? ";
				param.add(customerInfromId);
			}
			if(customerTypeId>0){
				sql=sql+" and cu.customerTypeId=? ";
				param.add(customerTypeId);
			}
			if(carSeriyId>0){
				sql=sql+" and cb.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(comeType>0){
				sql=sql+" and cu.customerTypeId=? ";
				param.add(comeType);
			}
			if(bussiStaffId>0){
				sql=sql+" and cu.bussiStaffId=? ";
				param.add(bussiStaffId);
			}
			if(cityCrossId>0){
				sql=sql+" and cu.cityCrossCustomerId=? ";
				param.add(cityCrossId);
			}
			if(brandId>0){
				sql=sql+" and cb.brandId=? ";
				param.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cb.carModelId=? ";
				param.add(carModelId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
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
			sql=sql+" order by createFolderTime DESC";
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderList";
	}
	/**
	 * 功能描述：领导订单客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryLeaderOrderCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "r", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer customerTypeId = ParamUtil.getIntParam(request, "customerTypeId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String name = request.getParameter("name");
		String userName = request.getParameter("userName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String startOrderTime = request.getParameter("startOrderTime");
		String endOrderTime = request.getParameter("endOrderTime");
		String tryCarStartTime = request.getParameter("tryCarStartTime");
		String tryCarEndTime = request.getParameter("tryCarEndTime");
		String comeShopStartTime = request.getParameter("comeShopStartTime");
		String comeShopEndTime = request.getParameter("comeShopEndTime");
		try {
			Enterprise enterprise = user.getEnterprise();
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
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarColor> carColors = carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			
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
			String currentDepIds = departmentManageImpl.getDepartmentIds(user.getDepartment());
			String sql="select * from cust_orderContract as orderc,"
					+ " cust_Customer as cu,"
					+ "cust_CustomerBussi as cb  where"
					+ " orderc.customerId=cu.dbid AND  cb.customerId=cu.dbid ";
			if(enterprise.getDbid()>0){
				sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
			}
			List param= new ArrayList();
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
				sql=sql+" and cb.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cb.brandId=? ";
				param.add(brandId);
			}
			if(carColorId>0){
				sql=sql+" and cb.carColorId=? ";
				param.add(carColorId);
			}
			if(carModelId>0){
				sql=sql+" and cb.carModelId=? ";
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
				sql=sql+" and createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=startOrderTime&&startOrderTime.trim().length()>0){
				sql=sql+" and orderc.createTime >= ? ";
				param.add(DateUtil.string2Date(startOrderTime));
			}
			if(null!=endOrderTime&&endOrderTime.trim().length()>0){
				sql=sql+" and orderc.createTime < ? ";
				param.add(DateUtil.nextDay(endOrderTime));
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and cu.createFolderTime < ? ";
				param.add(DateUtil.nextDay(endTime));
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
			sql=sql+" order by createTime DESC";
			Page<OrderContract> page = orderContractManageImpl.pagedQuerySql(pageNo, pageSize, OrderContract.class, sql, param.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderOrderCustomer";
	}
	/**
	 * 功能描述：待交车客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryLeaderWaitingHandCar() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String startDate= request.getParameter("startDate");
		String endDate= request.getParameter("endDate");
		try {
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			Enterprise enterprise = user.getEnterprise();
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String selSql="";
			if(user.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cu.enterpriseId in("+user.getCompnayIds()+") ";
			}else{
				selSql=selSql+" cu.departmentId="+user.getDepartment().getDbid();
			}
			
			String sql="select * from cust_Customer as cu,"
					+ "cust_CustomerPidBookingRecord as cpid "
					+ "where "+selSql+" and cpid.customerId=cu.dbid and cpid.pidStatus!=2";
			List params=new ArrayList();
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				params.add(customerPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				params.add("%"+name+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cpid.carSeriyId=? ";
				params.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cpid.brandId=? ";
				params.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				params.add(carModelId);
			}
			if(startDate==null&&startDate==null){
				sql=sql+" AND  cpid.createTime>=date_sub(curdate(),interval 0 day) ";
			}else{
				if(startDate!=null&&startDate.trim().length()>0){
					sql=sql+" and cpid.createTime>='"+startDate+"' ";
				}
				if(endDate!=null&&endDate.trim().length()>0){
					sql=sql+" and cpid.createTime<='"+endDate+"' ";
				}
			}
			sql=sql+" order by cpid.createTime DESC";
			List<Customer> customers = customerMangeImpl.executeSql(sql,params.toArray());
			request.setAttribute("customers", customers);
			
			long  dayCustomerNum = customerMangeImpl.countSqlResult(sql, params.toArray());
			request.setAttribute("dayCustomerNum", dayCustomerNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderWaitingHandCar";
	}
	/**
	 * 功能描述：待交车客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryLeaderSuccessCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
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
		try {
			Enterprise enterprise = user.getEnterprise();
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
					+ " cust_Customer as cu,"
					+ " cust_CustomerPidBookingRecord as cpid "
					+ "  where"
					+ " cpid.customerId=cu.dbid   and cpid.pidStatus=? ";
			sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
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
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderSuccessCustomer";
	}
	/**
	 * @param memberInfo2
	 */
	private String areaSelect(Area area) {
		StringBuffer buffer=new StringBuffer();
		if(null!=area){
			String treePath = area.getTreePath();
			String[] split = treePath.split(",");
			if(split.length>1){
				//父节点
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				if(null!=areas&&areas.size()>0){
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
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
						buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
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
					buffer.append("<select id='ar' name='ar' class='midea text' onchange='ajaxArea(this)'>");
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
			}
		}else{
			return null;
		}
		return buffer.toString();
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}

	@Resource
	public void setIndustryManageImpl(IndustryManageImpl industryManageImpl) {
		this.industryManageImpl = industryManageImpl;
	}

	@Resource
	public void setEducationalManageImpl(EducationalManageImpl educationalManageImpl) {
		this.educationalManageImpl = educationalManageImpl;
	}


	@Resource
	public void setBuyCarCareManageImpl(BuyCarCareManageImpl buyCarCareManageImpl) {
		this.buyCarCareManageImpl = buyCarCareManageImpl;
	}

	@Resource
	public void setBuyCarTargetManageImpl(
			BuyCarTargetManageImpl buyCarTargetManageImpl) {
		this.buyCarTargetManageImpl = buyCarTargetManageImpl;
	}

	@Resource
	public void setBuyCarTypeManageImpl(BuyCarTypeManageImpl buyCarTypeManageImpl) {
		this.buyCarTypeManageImpl = buyCarTypeManageImpl;
	}
	@Resource
	public void setBuyCarBudgetManageImpl(
			BuyCarBudgetManageImpl buyCarBudgetManageImpl) {
		this.buyCarBudgetManageImpl = buyCarBudgetManageImpl;
	}
	@Resource
	public void setBuyCarMainUseManageImpl(
			BuyCarMainUseManageImpl buyCarMainUseManageImpl) {
		this.buyCarMainUseManageImpl = buyCarMainUseManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setPaperworkManageImpl(PaperworkManageImpl paperworkManageImpl) {
		this.paperworkManageImpl = paperworkManageImpl;
	}
	@Resource
	public void setProfessionManageImpl(ProfessionManageImpl professionManageImpl) {
		this.professionManageImpl = professionManageImpl;
	}
	@Resource
	public void setCustMarketingActManageImpl(
			CustMarketingActManageImpl custMarketingActManageImpl) {
		this.custMarketingActManageImpl = custMarketingActManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	
}
