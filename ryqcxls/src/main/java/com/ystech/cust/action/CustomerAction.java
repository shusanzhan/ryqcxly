/**
 * 
 */
package com.ystech.cust.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.json.JSONArray;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.excel.CustomerOutFlowToExcel;
import com.ystech.core.excel.CustomerToExcel;
import com.ystech.core.security.SecurityUserHolder;
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
import com.ystech.cust.model.CustomerOperatorLog;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.model.Educational;
import com.ystech.cust.model.Industry;
import com.ystech.cust.model.OrderContract;
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
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.cust.service.EducationalManageImpl;
import com.ystech.cust.service.IndustryManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.cust.service.PaperworkManageImpl;
import com.ystech.cust.service.ProfessionManageImpl;
import com.ystech.cust.service.TimeoutsTrackRecordManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.SystemInfo;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.SystemInfoMangeImpl;
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
 * @author shusanzhan
 * @date 2014-2-21
 */
@Component("custCustomerAction")
@Scope("prototype")
public class CustomerAction extends BaseController{
	private static int errorNum=1;
	private Customer customer;
	private CustomerTrack customerTrack;
	private CustomerBussi customerBussi;
	private CustomerShoppingRecord customerShoppingRecord;
	private CustomerBussiManageImpl customerBussiManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private PaperworkManageImpl paperworkManageImpl;
	private ProfessionManageImpl professionManageImpl;
	private AreaManageImpl areaManageImpl;
	private IndustryManageImpl industryManageImpl;
	private EducationalManageImpl educationalManageImpl;
	private BuyCarCareManageImpl buyCarCareManageImpl;
	private BuyCarTargetManageImpl buyCarTargetManageImpl;
	private BuyCarTypeManageImpl buyCarTypeManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private BuyCarBudgetManageImpl buyCarBudgetManageImpl;
	private BuyCarMainUseManageImpl buyCarMainUseManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl;
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	private OrderContractProductManageImpl orderContractProductManageImpl;
	private ApprovalRecordManageImpl approvalRecordManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarColorManageImpl carColorManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private UserManageImpl userManageImpl;
	private CustomerLastBussi customerLastBussi;
	private TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl;
	private BrandManageImpl brandManageImpl;
	HttpServletRequest request=getRequest();
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerFlowReasonManageImpl customerFlowReasonManageImpl;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private CustomerTractUtile customerTractUtile;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private SystemInfoMangeImpl systemInfoMangeImpl;
	private CustMarketingActManageImpl custMarketingActManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public CustomerMangeImpl getCustomerMangeImpl() {
		return customerMangeImpl;
	}
	
	public CustomerShoppingRecord getCustomerShoppingRecord() {
		return customerShoppingRecord;
	}
	public void setCustomerShoppingRecord(
			CustomerShoppingRecord customerShoppingRecord) {
		this.customerShoppingRecord = customerShoppingRecord;
	}
	
	public CustomerTrack getCustomerTrack() {
		return customerTrack;
	}
	public void setCustomerTrack(CustomerTrack customerTrack) {
		this.customerTrack = customerTrack;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	@Resource
	public void setPaperworkManageImpl(PaperworkManageImpl paperworkManageImpl) {
		this.paperworkManageImpl = paperworkManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setProfessionManageImpl(ProfessionManageImpl professionManageImpl) {
		this.professionManageImpl = professionManageImpl;
	}
	@Resource
	public void setIndustryManageImpl(IndustryManageImpl industryManageImpl) {
		this.industryManageImpl = industryManageImpl;
	}
	@Resource
	public void setCustomerFlowReasonManageImpl(
			CustomerFlowReasonManageImpl customerFlowReasonManageImpl) {
		this.customerFlowReasonManageImpl = customerFlowReasonManageImpl;
	}
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
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
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
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
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
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
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setOrderContractProductManageImpl(
			OrderContractProductManageImpl orderContractProductManageImpl) {
		this.orderContractProductManageImpl = orderContractProductManageImpl;
	}
	public CustomerBussi getCustomerBussi() {
		return customerBussi;
	}
	public void setCustomerBussi(CustomerBussi customerBussi) {
		this.customerBussi = customerBussi;
	}
	@Resource
	public void setCustomerBussiManageImpl(
			CustomerBussiManageImpl customerBussiManageImpl) {
		this.customerBussiManageImpl = customerBussiManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
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
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setApprovalRecordManageImpl(
			ApprovalRecordManageImpl approvalRecordManageImpl) {
		this.approvalRecordManageImpl = approvalRecordManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	public CustomerLastBussi getCustomerLastBussi() {
		return customerLastBussi;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	@Resource
	public void setSystemInfoMangeImpl(SystemInfoMangeImpl systemInfoMangeImpl) {
		this.systemInfoMangeImpl = systemInfoMangeImpl;
	}
	@Resource 
	public void setCustMarketingActManageImpl(
			CustMarketingActManageImpl custMarketingActManageImpl) {
		this.custMarketingActManageImpl = custMarketingActManageImpl;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	/**
	 * 功能描述：验证客户页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String validateMember() throws Exception {
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		try {
			CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
			request.setAttribute("customerRecord", customerRecord);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "validateMember";
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
			User saler = SecurityUserHolder.getCurrentUser();
			SystemInfo systemInfo = systemInfoMangeImpl.get(SystemInfo.ROOT);
			org.json.JSONObject object = customerMangeImpl.validateCustomer(mobilePhone, saler, systemInfo);
			renderJson(object.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exceptionser
	 */
	public String addShoppingRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
			if(null!=mobilePhone){
				customerRecord.setMobilePhone(mobilePhone);
			}
			request.setAttribute("customerRecord", customerRecord);
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			
			
			//购车类型
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			//意向车型
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
			List<CarColor> carColors = carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
			request.setAttribute("carColors", carColors);
			//品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			if(null!=customerRecord.getCustomerInfrom()){
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(customerRecord.getCustomerInfrom());
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}else{
				String customerInfromSelect = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", customerInfromSelect);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "addShoppingRecord";
	}
	/**
	 * 验证销售顾问填写两个相同的客户信息
	 * @param name
	 * @param mobilePhone
	 * @return
	 */
	public Customer validateCustomer(String mobilePhone,Integer customerRecordId){
		User currentUser = SecurityUserHolder.getCurrentUser();
		try {
			CustomerRecord customerRecord2 = customerRecordManageImpl.get(customerRecordId);
			User agentUser = customerRecord2.getAgentUser();
			if(null!=agentUser){
				currentUser=customerRecord2.getSaler();
			}
			List<Customer> customers = customerMangeImpl.executeSql("select * from cust_Customer where  mobilePhone=? and bussiStaffId=? ", new Object[]{mobilePhone,currentUser.getDbid()});
			if(null!=customers&&customers.size()>0){
				Customer customer2 = customers.get(0);
				return customer2;
			}
		} catch (Exception e) {
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
	public void saveCustomerShoppingRecord(){
		HttpServletRequest request = this.getRequest();
		Integer red = ParamUtil.getIntParam(request, "red", 0);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", 1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		try{
			//验证添加相同的客户信息
			User currentUser = SecurityUserHolder.getCurrentUser();
			/**保持customer 信息**/
			String no = customer.getSn();
			if(null==no||no.trim().length()<=0){
				no=DateUtil.generatedName(new Date());
				customer.setSn(no);
			}
			if(null==customer.getDbid()||customer.getDbid()<=0){
				//客户最终状态
				customer.setLastResult(Customer.NORMAL);
				//客户订单状态
				customer.setOrderContractStatus(Customer.ORDERNOT);
			}
			CustomerRecord customerRecord=null;
			if(customerRecordId>0){
				customerRecord = customerRecordManageImpl.get(customerRecordId);
				if(null!=customerRecord){
					customer.setCustomerType(customerRecord.getCustomerType());
					User agentUser = customerRecord.getAgentUser();
					if(null!=agentUser){
						currentUser=customerRecord.getSaler();
					}
				}
			}
			//设置互动次数
			customer.setTrackNum(0);
			
			customer.setUser(currentUser);
			customer.setBussiStaff(currentUser.getRealName());
			//设置客户追踪状态
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			CustomerPhase customerPhase=null;
			if(customerPhaseId>0){
				customerPhase = customerPhaseManageImpl.get(customerPhaseId);
				//固定初始状态
				customer.setFirstCustomerPhase(customerPhase);
				//需修改状态
				customer.setCustomerPhase(customerPhase);
				//如果意向级别为O级 那么设置客户的状态为成交状态
				if(null!=customerPhase){
					if(customerPhase.getName().equals("O")){
						customer.setLastResult(1);
					}
				}
			}
			if(null!=customer.getIcard()&&customer.getIcard().trim().length()>0){
				String icard = customer.getIcard();
				if(CheckIdCardUtils.validateCard(icard)){
					int age = CheckIdCardUtils.getAgeByIdCard(icard);
					String birthDay = CheckIdCardUtils.getBirthByIdCard(icard);
					customer.setAge(age);
					customer.setNbirthday(DateUtil.string2Date(birthDay));
					String gender = CheckIdCardUtils.getGenderByIdCard(icard);
					if(gender.equals("M")){
						customer.setSex("男");
					}
					if(gender.equals("F")){
						customer.setSex("女");
					}
				}
			}
			//客户来源
			if(customerInfromId>0){
				CustomerInfrom customerInfrom = customerInfromManageImpl.get(customerInfromId);
				customer.setCustomerInfrom(customerInfrom);
				CustomerInfrom parent = customerInfrom.getParent();
				if(null==parent){
					customerShoppingRecord.setComeType(customerInfrom.getDbid());
				}else{
					customerShoppingRecord.setComeType(parent.getDbid());
				}
				
				//客户来店
				if(customerInfromId==1){
					customer.setComeShopDate(new Date());
					customer.setComeShopNum(1);
					customer.setComeShopStatus(2);
				}else{
					customer.setComeShopNum(0);
					customer.setComeShopStatus(1);
				}
			}
			
			
			Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
			if(areaId>0){
				Area area = areaManageImpl.get(areaId);
				customer.setArea(area);
			}
			
			customer.setDepartment(currentUser.getDepartment());
			customer.setSuccessDepartment(currentUser.getDepartment());
			customer.setRecordType(Customer.CUSTOMERTYPECOMM);
			customer.setKdStatus(Customer.KDCOMM);
			customer.setDmsStatus(Customer.DMSCOMM);
			customer.setCreateFolderTime(new Date());
			//设置邀约人员
			customer.setInvitationSaler(currentUser);
			customer.setInvitationSalerName(currentUser.getRealName());
			//设置接待人员
			customer.setReceptierSaler(currentUser);
			customer.setReceptierSalerName(currentUser.getRealName());
			Enterprise enterprise = currentUser.getEnterprise();
			customer.setEnterprise(enterprise);
			//试乘试驾状态
			if(tryCarStatus==2){
				customer.setTryCarDate(new Date());
			}
			customer.setTryCarStatus(tryCarStatus);
			
			customerMangeImpl.save(customer);
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "登记客户信息", "");
			/****************************保存customer 信息*******************************/
			
			/******************************保存来店登记信息 start******************************/
			customerShoppingRecord.setCustomer(customer);
			customerShoppingRecordManageImpl.save(customerShoppingRecord);
			
			/******************************保存来店登记信息 end******************************/
			
			/****************************保存customerBussi 信息*******************************/
			customerBussi.setCustomer(customer);
			
			Integer buyCarCareId = ParamUtil.getIntParam(request, "buyCarCareId", -1);
			if(buyCarCareId>0){
				BuyCarCare buyCarCare = buyCarCareManageImpl.get(buyCarCareId);
				customerBussi.setBuyCarCare(buyCarCare);
			}
			Integer buyCarTargetId = ParamUtil.getIntParam(request, "buyCarTargetId", -1);
			if(buyCarTargetId>0){
				BuyCarTarget buyCarTarget = buyCarTargetManageImpl.get(buyCarTargetId);
				customerBussi.setBuyCarTarget(buyCarTarget);
			}
			Integer buyCarTypeId = ParamUtil.getIntParam(request, "buyCarTypeId", -1);
			if(buyCarTypeId>0){
				BuyCarType buyCarType = buyCarTypeManageImpl.get(buyCarTypeId);
				customerBussi.setBuyCarType(buyCarType);
			}
			
			//车辆品牌
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Brand brand=null;
			if(brandId>0){
				brand = brandManageImpl.get(brandId);
				customerBussi.setBrand(brand);
			}
			
			//意向车型
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			CarModel carModel=null;
			if(carModelId>0){
				 carModel = carModelManageImpl.get(carModelId);
				customerBussi.setCarModel(carModel);
			}
			//意向车型
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			CarSeriy carSeriy=null;
			if(carSeriyId>0){
				 carSeriy = carSeriyManageImpl.get(carSeriyId);
				customerBussi.setCarSeriy(carSeriy);
			}
			
			Integer buyCarBudgetId = ParamUtil.getIntParam(request, "buyCarBudgetId", -1);
			if(buyCarBudgetId>0){
				BuyCarBudget buyCarBudget = buyCarBudgetManageImpl.get(buyCarBudgetId);
				customerBussi.setBuyCarBudget(buyCarBudget);
			}
			Integer buyCarMainUseId = ParamUtil.getIntParam(request, "buyCarMainUseId", -1);
			if(buyCarMainUseId>0){
				BuyCarMainUse buyCarMainUse = buyCarMainUseManageImpl.get(buyCarMainUseId);
				customerBussi.setBuyCarMainUse(buyCarMainUse);
			}
			customerBussiManageImpl.save(customerBussi);
			
			//**************************************保存最终成交结果***********************************************//
			if(null!=customerPhase){
				if(customerPhase.getName().equals("O")){
					Integer carColor = ParamUtil.getIntParam(request, "carColor", -1);
					customerLastBussi.setBrand(brand);
					customerLastBussi.setCarModel(carModel);
					customerLastBussi.setCarSeriy(carSeriy);
					customerLastBussi.setCustomer(customer);
					if(carColor>0){
						CarColor carColor2 = carColorManageImpl.get(carColor);
						customerLastBussi.setCarColor(carColor2);
					}
					customerLastBussi.setCreateTime(new Date());
					customerLastBussiManageImpl.save(customerLastBussi);
				}
			}
			
			
			//更新线索记录
			customerRecordManageImpl.updateCustomerRecord(customerRecordId, customer, customerBussi,CustomerRecord.RESULTRECORD);
			//创建客户跟踪任务
			customerTractUtile.createCustomerToCreateTask(customer);
		}catch (Exception e) {
			renderErrorMsg(e, "保存数据失败！");
			e.printStackTrace();
			log.error(e);
			return ;
		}
		if(red==0){
			//renderMsg("/custCustomer/addShoppingRecord", "保存数据成功！");
			//renderMsg("/custCustomer/customerShoppingRecordqueryList", "保存数据成功！");
		}else if(red==1){
			//renderMsg("/custCustomer/addShoppingRecord", "保存数据成功！");
		}
		renderMsg("/customerRecord/querySalerList", "保存数据成功！");
		return ;
	}
	
	/**
	 * 功能描述：试驾协议书
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String testDriveAgreement() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "testDriveAgreement";
	}
	/**
	 * 功能描述：试驾满意度调查
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String satisfactionAssessment() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "satisfactionAssessment";
	}
	/**
	 * 功能描述：商谈报价单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String negotiationsQuote() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "negotiationsQuote";
	}
	/**
	 * 功能描述：十项核心流程调查
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String tenCoreSurvey() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "tenCoreSurver";
	}
	/**
	 * 功能描述：交车确认单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String handerOverCar() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
				
				List<CustomerPidBookingRecord> customerPidBookingRecords = customerPidBookingRecordManageImpl.findBy("customer.dbid", customer2.getDbid());
				if(null!=customerPidBookingRecords&&customerPidBookingRecords.size()>0){
					request.setAttribute("customerPidBookingRecord", customerPidBookingRecords.get(0));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "handerOverCar";
	}
	/**
	 * 功能描述：客户档案信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFolder() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
			
			List<BuyCarCare> buyCarCares = buyCarCareManageImpl.getAll();
			request.setAttribute("buyCarCares", buyCarCares);
			
			List<BuyCarTarget> buyCarTargets = buyCarTargetManageImpl.getAll();
			request.setAttribute("buyCarTargets", buyCarTargets);
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		if(type==1){
			return "customerFolderPer";
		}
		if(type==2){
			return "customerFolderDep";
		}
		return "customerFolderPer";
	}
	
	/**
	 * 功能描述：客户合同
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String contract() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				Customer customer2 = customerMangeImpl.get(dbid);
				request.setAttribute("customer", customer2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "contract";
	}
	/**
	 * 功能描述：客户跟踪单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String trakingCard() throws Exception {
		HttpServletRequest request = this.getRequest();
		
		try{
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			Customer customer2 = customerMangeImpl.get(dbid);
			request.setAttribute("customer", customer2);
			if(null!=customer2){
				request.setAttribute("customerBussi", customer2.getCustomerBussi());
				
				List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customer2.getDbid(),CustomerTrack.TASKFINISHTYPECOMM});
				request.setAttribute("customertracks", customerTracks);
				
			}
			
			
			
			List<BuyCarCare> buyCarCares = buyCarCareManageImpl.getAll();
			request.setAttribute("buyCarCares", buyCarCares);
			
			List<BuyCarTarget> buyCarTargets = buyCarTargetManageImpl.getAll();
			request.setAttribute("buyCarTargets", buyCarTargets);
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "trakingCard";
	}
	
	/**
	 * 功能描述：客户档案信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String argType() throws Exception {
		return "argType";
	}
	/**
	 * 功能描述：销售人员登记记录列表
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String customerShoppingRecordqueryList() throws Exception {
		HttpServletRequest request = this.getRequest();
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			//意向购车时间
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
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			
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
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "customerShoppingRecord";
	}
	/**
	 * 功能描述：销售人发送短信列表
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String customerSelect() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			if(carSeriyId>0){
				//车型
				List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid", carSeriyId);
				request.setAttribute("carModels", carModels);
			}else{
				//车型
				List<CarModel> carModels = carModelManageImpl.getAll();
				request.setAttribute("carModels", carModels);
			}
			String hql="select * from cust_Customer where bussiStaffId=? and customerPhase.dbid>=1 and customerPhase.dbid<=4 ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			if(customerPhaseId>0){
				hql=hql+" and customerPhase.dbid=? ";
				param.add(customerPhaseId);
			}
			if(lastResult>-1){
				hql=hql+" and lastResult=? ";
				param.add(lastResult);
			}
			if(trackingPhaseId>0){
				hql=hql+" and customerBussi.trackingPhase.dbid=? ";
				param.add(trackingPhaseId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				hql=hql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(carSeriyId>0){
				hql=hql+" and customerBussi.carSeriy.dbid=? ";
				param.add(carSeriyId);
			}
			if(carModelId>0){
				hql=hql+" and customerBussi.carModel.dbid=? ";
				param.add(carModelId);
			}
			hql=hql+"order by createFolderTime DESC";
			
			List<Customer> customers = customerMangeImpl.find(hql, param.toArray());
			request.setAttribute("customers", customers);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "customerSelect";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String customerLeaderShoppingRecordqueryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer cityCrossId = ParamUtil.getIntParam(request, "cityCrossId", -1);
		Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer comeType = ParamUtil.getIntParam(request, "comeType", -1);
		Integer isTryDriver = ParamUtil.getIntParam(request, "isTryDriver", -1);
		Integer infoFromId = ParamUtil.getIntParam(request, "infoFromId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		String name = request.getParameter("name");
		String receptierSalerName = request.getParameter("receptierSalerName");
		String invitationSalerName = request.getParameter("invitationSalerName");
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userName = request.getParameter("userName");
		String tryCarStartTime = request.getParameter("tryCarStartTime");
		String tryCarEndTime = request.getParameter("tryCarEndTime");
		String comeShopStartTime = request.getParameter("comeShopStartTime");
		String comeShopEndTime = request.getParameter("comeShopEndTime");
		String approvalStartDate = request.getParameter("approvalStartDate");
		String approvalEndDate = request.getParameter("approvalEndDate");
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos&&!systemInfos.isEmpty()){
				SystemInfo systemInfo = systemInfos.get(0);
				request.setAttribute("systemInfo", systemInfo);
			}
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
			//信息来源
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
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and bussiStaff like ? ";
				param.add("%"+userName+"%");
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
				sql=sql+" and lastResult = ? ";
				param.add(lastResult);
			}
			if(customerPhaseId>0){
				sql=sql+" and customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(trackingPhaseId>0){
				sql=sql+" and cb.trackingPhaseId=? ";
				param.add(trackingPhaseId);
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.departmentId in ("+departmentIds+")";
			}
			if(brandId>0){
				sql=sql+" and cb.brandId=? ";
				param.add(brandId);
			}
			if(carSeriyId>0){
				sql=sql+" and cb.carSeriyId=? ";
				param.add(carSeriyId);
			}
			if(approvalStatus>0){
				sql=sql+" and custlb.approvalStatus=? ";
				param.add(approvalStatus);
			}
			if(infoFromId>0){
				sql=sql+" and cu.infoFromId=? ";
				param.add(infoFromId);
			}
			if(customerInfromId>0){
				String customerInfromIds = customerInfromManageImpl.getCustomerInfromIds(customerInfromId);
				sql=sql+" and cu.customerInfromId in("+customerInfromIds+")" ;;
			}
			if(carModelId>0){
				sql=sql+" and cb.carModelId=? ";
				param.add(carModelId);
			}
			if(cityCrossId>0){
				sql=sql+" and cityCrossCustomerId=? ";
				param.add(cityCrossId);
			}
			if(comeType>0){
				sql=sql+" and cu.customerTypeId=? ";
				param.add(comeType);
			}
			if(isTryDriver>0){
				sql=sql+" and cu.TryCarStatus=? ";
				param.add(isTryDriver);
			}
			if(comeShopStatus>0){
				sql=sql+" and cu.comeShopStatus=? ";
				param.add(comeShopStatus);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createFolderTime >= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createFolderTime < ? ";
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
			if(null!=approvalStartDate&&approvalStartDate.trim().length()>0){
				sql=sql+" and custlb.approvalDate >= ? ";
				param.add(DateUtil.string2Date(approvalStartDate));
			}
			if(null!=approvalEndDate&&approvalEndDate.trim().length()>0){
				sql=sql+" and custlb.approvalDate < ? ";
				param.add(DateUtil.nextDay(approvalEndDate));
			}
			if(null!=comeShopStartTime&&comeShopStartTime.trim().length()>0){
				sql=sql+" and ( cu.comeShopDate >=? OR  cu.twoComeShopDate >=? ) ";
				param.add(DateUtil.string2Date(comeShopStartTime));
				param.add(DateUtil.string2Date(comeShopStartTime));
			}
			if(null!=comeShopEndTime&&comeShopEndTime.trim().length()>0){
				sql=sql+" and (cu.comeShopDate <? OR cu.twoComeShopDate<?) ";
				param.add(DateUtil.nextDay(comeShopEndTime));
				param.add(DateUtil.nextDay(comeShopEndTime));
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
			}
			sql=sql+" order by createFolderTime DESC";
			
			Page<Customer> page= customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "leaderCustomerShoppingRecord";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String exportCustomer() throws Exception {
		
		return "export";
	}
	/**
	 * 功能描述：登记记录列表
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
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from "
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp  "
					+ "where bussiStaffId=?  and cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid and custp.type=? ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			param.add(CustomerPhase.TYPESHOW);
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
			sql=sql+"order by createFolderTime DESC";
			Page<Customer> page = customerMangeImpl.pagedQuerySql(pageNo, pageSize,Customer.class,sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "list";
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//地域信息
			List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("areas", areas);
			
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
			//意向车型
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			//购车预算
			List<BuyCarBudget> buyCarBudgets = buyCarBudgetManageImpl.getAll();
			request.setAttribute("buyCarBudgets", buyCarBudgets);
			//购车主要是用人
			List<BuyCarMainUse> buyCarMainUses = buyCarMainUseManageImpl.getAll();
			request.setAttribute("buyCarMainUses", buyCarMainUses);
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
				List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
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
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save(){
		HttpServletRequest request = getRequest();
		User currentUser = SecurityUserHolder.getCurrentUser();
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", 1);
		try{
			Customer customer2 = customerMangeImpl.get(customer.getDbid());
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
			customerBussi2.setOtherMainDescription(customerBussi.getOtherMainDescription());
			customerBussiManageImpl.save(customerBussi2);
			customerBussiManageImpl.deleteDuplicateDataByCustomerId(customer2.getDbid());
			
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		Integer type = ParamUtil.getIntParam(request, "type",-1);
		if(type==2){
			renderMsg("/customerRecord/querySalerList", "保存数据成功！");
		}else{
			renderMsg("/custCustomer/customerShoppingRecordqueryList", "保存数据成功！");
		}
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
					Customer customer2 = customerMangeImpl.get(dbid);
					CustomerBussi customerBussi2 = customer2.getCustomerBussi();
					if(null!=customerBussi2){
						customerBussiManageImpl.delete(customerBussi2);
					}
					customerMangeImpl.deleteById(dbid);
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
		renderMsg("/custCustomer/customerShoppingRecordqueryList"+query, "删除数据成功！");
		return;
	}
	
	/**
	 * 功能描述：流失客户
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerFlowReasonId = ParamUtil.getIntParam(request, "customerFlowReasonId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String flowStartTime = request.getParameter("flowStartTime");
		String flowEndTime = request.getParameter("flowEndTime");
		String note = request.getParameter("note");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			
			List<CustomerFlowReason> customerFlowReasons = customerFlowReasonManageImpl.getAll();
			request.setAttribute("customerFlowReasons",customerFlowReasons);
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from "
					+ "cust_Customer as cu "
					+ "left JOIN cust_CustomerLastBussi as clb ON clb.customerId=cu.dbid "
					+ "left JOIN cust_CustomerBussi as cb on cb.customerId=cu.dbid "
					+ "where bussiStaffId=?  and cu.lastResult>? ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			//表示购买其他车
			param.add(Customer.SUCCESS);
			if(carModelId>0){
				sql=sql+" and clb.lastBuyCarModelId=? ";
				param.add(carModelId);
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
			}
			if(comeShopStatus>0){
				sql=sql+" and cu.comeShopStatus=? ";
				param.add(comeShopStatus);
			}
			if(customerFlowReasonId>0){
				sql=sql+" and clb.customerFlowReasonId=? ";
				param.add(customerFlowReasonId);
			}
			if(null!=note&&note.trim().length()>0){
				sql=sql+" and clb.note like ? ";
				param.add("%"+note+"%");
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
			if(null!=flowStartTime&&flowStartTime.trim().length()>0){
				sql=sql+" and approvalDate >= ? ";
				param.add(DateUtil.string2Date(flowStartTime));
			}
			if(null!=flowEndTime&&flowEndTime.trim().length()>0){
				sql=sql+" and approvalDate < ? ";
				param.add(DateUtil.nextDay(flowEndTime));
			}
			sql=sql+"order by createFolderTime DESC";
			Page<Customer> page= customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "outFlow";
	}
	/**
	 * 功能描述：领导审批流失客户
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryLeaderOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
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
		Integer approvalStatus = ParamUtil.getIntParam(request, "approvalStatus", -1);
		Integer cityCrossCustomerId = ParamUtil.getIntParam(request, "cityCrossCustomerId", -1);
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
			
			String sql="select cu.* " +
					"	from " +
					"	cust_Customer as cu,cust_CustomerLastBussi as clb,cust_customerbussi cb  " +
					"	where  " +
					"	clb.customerId=cu.dbid and cu.lastResult>? AND cb.customerId=cu.dbid ";
			if(enterprise.getDbid()>0){
				sql=sql+" and cu.enterpriseId="+enterprise.getDbid();
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
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and clb.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(approvalStatus>=0){
				sql=sql+" and clb.approvalStatus=? ";
				param.add(approvalStatus);
			}
			if(null!=startApprovalTime&&startApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate>= ? ";
				param.add(DateUtil.string2Date(startApprovalTime));
			}
			if(null!=endApprovalTime&&endApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate< ? ";
				param.add(DateUtil.nextDay(endApprovalTime));
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
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.departmentId in ("+departmentIds+")";
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
			
			Page<Customer> page= customerMangeImpl.pagedQuerySql(pageNo, pageSize, Customer.class, sql, param.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "outLeaderFlow";
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
	/**
	 * 功能描述：客户档案信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFile() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(customerId>0){
				//客户基本信息
				Customer customer2 = customerMangeImpl.get(customerId);
				
				request.setAttribute("customer", customer2);
				
				//客户业务信息
				CustomerBussi customerBussi2 = customer2.getCustomerBussi();
				request.setAttribute("customerBussi", customerBussi2);
				
				
				CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
				request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
				
				//客户跟踪记录
				List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customerId,CustomerTrack.TASKFINISHTYPECOMM});
				request.setAttribute("customertracks", customerTracks);
				
				List<CustomerOperatorLog> customerOperatorLogs = customerOperatorLogManageImpl.findBy("customerId", customer2.getDbid());
				request.setAttribute("customerOperatorLogs", customerOperatorLogs);
				
				
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
				
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFile";
	}
	/**
	 * 功能描述：销售副总导出来电登记记录表
	 * @throws Exception
	 */
	public void exportExcel() throws Exception {
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		String fileName="客户信息登记表";
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer cityCrossId = ParamUtil.getIntParam(request, "cityCrossId", -1);
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			Department department = departmentManageImpl.get(departmentId);
			String departmentIds2 = departmentManageImpl.getDepartmentIds(department);
			List<Customer> customers = customerMangeImpl.queryToExcel(pageNo, pageSize, userId, customerPhaseId, trackingPhaseId,
					departmentIds2,carSeriyId, carModelId,cityCrossId,mobilePhone,startTime,endTime);
			String filePath = CustomerToExcel.writeExcel(fileName, customers);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：展厅经理导出excel数据
	 * @throws Exception
	 */
	public void exportRoomManageExcel() throws Exception {
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		String fileName="客户信息登记表";
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
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Department department = currentUser.getDepartment();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
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
			
			String sql="select * from "
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp "
					+ " where cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid and custp.type=? ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" AND cu.enterpriseId="+enterprise.getDbid();
			}else{
				sql=sql+" AND cu.departmentId="+department.getDbid();
			}
			List param= new ArrayList();
			param.add(CustomerPhase.TYPESHOW);
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
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			String filePath = CustomerToExcel.writeExcel(fileName, customers);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 功能描述：销售副总导出来电登记记录表
	 * @throws Exception
	 */
	public void exportOutFlowExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = this.getResponse();
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
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
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select cu.* " +
					"	from " +
					"	cust_Customer as cu,cust_CustomerLastBussi as clb,cust_customerbussi cb  " +
					"	where  " +
					"	clb.customerId=cu.dbid and cu.lastResult>? AND cb.customerId=cu.dbid ";
			String currentDepIds = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
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
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and clb.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=startApprovalTime&&startApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate>= ? ";
				param.add(DateUtil.string2Date(startApprovalTime));
			}
			if(null!=endApprovalTime&&endApprovalTime.trim().length()>0){
				sql=sql+" and clb.approvalDate< ? ";
				param.add(DateUtil.nextDay(endApprovalTime));
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
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and cu.departmentId in ("+departmentIds+")";
				//param.add("("+departmentIds+")");
			}
			if(approvalStatus>=0){
				sql=sql+" and clb.approvalStatus=? ";
				param.add(approvalStatus);
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
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			String fileName="客户流失"+DateUtil.format(new Date())+"日导出数据";
			String filePath = CustomerOutFlowToExcel.writeExcel(fileName, customers);
			downFile(request, response, filePath);
		}
		catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	/**
	 * 功能描述：展厅经理登记客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryRoomManageList() throws Exception {
		HttpServletRequest request = this.getRequest();
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
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Department department = currentUser.getDepartment();
			
			List<SystemInfo> systemInfos = systemInfoMangeImpl.getAll();
			if(null!=systemInfos&&!systemInfos.isEmpty()){
				SystemInfo systemInfo = systemInfos.get(0);
				request.setAttribute("systemInfo", systemInfo);
			}
			
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
			
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
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
			
			String sql="select * from "
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp "
					+ " where cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid and custp.type=? ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" AND cu.enterpriseId="+enterprise.getDbid();
			}else{
				sql=sql+" AND cu.departmentId="+department.getDbid();
			}
			List param= new ArrayList();
			param.add(CustomerPhase.TYPESHOW);
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
		return "roomManageList";
	}
	/**
	 * 功能描述：展厅经理流失客户
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryRoomManageOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
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
		
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			User currentUser = SecurityUserHolder.getCurrentUser();
			Department department = currentUser.getDepartment();
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
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
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" AND cu.enterpriseId="+enterprise.getDbid();
			}else{
				sql=sql+" AND cu.departmentId="+department.getDbid();
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
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "outRoomManageFlow";
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
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
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
			
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findByCustIdAndUserId(customerId, currentUser.getDbid());
			if(null!=customerTracks&&customerTracks.size()>0){
				CustomerTrack customerTrack2 = customerTracks.get(0);
				request.setAttribute("customerTrack", customerTrack2);
			}else{
				//默认创建任务为15天
				Date addDay = DateUtil.addDay(new Date(), 15);
				CustomerTrack customerTrack=customerTractUtile.createOtherCustomerTask(customer2,addDay,currentUser);
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
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		Integer customerTrackId = ParamUtil.getIntParam(request, "customerTrackId", -1);
		Integer custMarketingActId = ParamUtil.getIntParam(request, "custMarketingActId", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
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
			customerBussi2.setOtherMainDescription(customerBussi.getOtherMainDescription());
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
		renderMsg("/custCustomer/customerFile?dbid="+customerId+"&type=1","保存数据成功");
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
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
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
			customerBussi2.setOtherMainDescription(customerBussi.getOtherMainDescription());
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
		renderMsg("/orderContract/addOrderContract?customerId="+customerId+"&editType=1","保存数据成功");
		return;
	}
	
	/**
	 * 功能描述：网销人员邀约到店客户列表
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryInvitationList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String receptierSalerName = request.getParameter("receptierSalerName");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//意向购车时间
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
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			
			String sql="select * from "
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp  "
					+ "where invitationSalerId=?  and cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid  AND invitationSalerId!=receptierSalerId ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(tryCarStatus>0){
				sql=sql+" and cu.tryCarStatus=? ";
				param.add(tryCarStatus);
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
			if(null!=receptierSalerName&&receptierSalerName.trim().length()>0){
				sql=sql+" and cu.receptierSalerName like ? ";
				param.add("%"+receptierSalerName+"%");
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
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "invitationList";
	}
	/**
	 * 功能描述：谈判组人员，谈判客户列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryReceptierList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer trackingPhaseId = ParamUtil.getIntParam(request, "trackingPhaseId", -1);
		Integer customerInfromId = ParamUtil.getIntParam(request, "customerInfromId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer comeShopStatus = ParamUtil.getIntParam(request, "comeShopStatus", -1);
		Integer tryCarStatus = ParamUtil.getIntParam(request, "tryCarStatus", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
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
			
			User currentUser = SecurityUserHolder.getCurrentUser();
			
			//我线索待处理
			List<CustomerRecord> customerRecords = customerRecordManageImpl.queryMyTask(currentUser.getDbid());
			request.setAttribute("customerRecords", customerRecords);
			
			Map<Integer, Integer> map=new HashMap<Integer,Integer>();
			
			String sql="select * from "
					+ "cust_Customer as cu,cust_CustomerBussi as cb,cust_customerPhase custp  "
					+ "where receptierSalerId=?  and cb.customerId=cu.dbid and cu.customerPhaseId=custp.dbid and custp.type=? ";
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
		}
		return "receptierList";
	}
	/**
	 * 功能描述：玻璃无忧卡
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String glass() {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer",customer2);
		} catch (Exception e) {
		}
		return "glass";
	}
	/**
	 * 功能描述：玻璃无忧卡
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String loveCarTrace() {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer",customer2);
		} catch (Exception e) {
		}
		return "loveCarTrace";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void ajaxCustomer(){
		HttpServletRequest request = this.getRequest();
		String customerName = ParamUtil.getParamUTF8(request, "q");
		try {
			List<Customer> customers = customerMangeImpl.executeSql("select * from cust_Customer where  mobilePhone like ? or name like ?  AND lastResult=0 ", new Object[]{"%"+customerName+"%","%"+customerName+"%"});
			JSONArray  array=new JSONArray();
			if(null!=customers&&!customers.isEmpty()){
				for (Customer customer : customers) {
					JSONObject object=new JSONObject();
					object.put("dbid", customer.getDbid());
					object.put("name", customer.getName());
					object.put("mobilePhone", customer.getMobilePhone());
					object.put("saler", customer.getBussiStaff());
					array.put(object);
				}
			}
			renderJson(array.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return ;
	}
	
}
