package com.ystech.qywx.action;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

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
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerPidCancel;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
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
import com.ystech.cust.service.CustomerBussiManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.CustomerPidCancelManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.EducationalManageImpl;
import com.ystech.cust.service.IndustryManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.cust.service.PaperworkManageImpl;
import com.ystech.cust.service.ProfessionManageImpl;
import com.ystech.cust.service.TimeoutsTrackRecordManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarColorManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxCustomerFileAction")
@Scope("prototype")
public class QywxCustomerFileAction extends BaseController{
	private Customer customer;
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
	private CustomerPidCancelManageImpl customerPidCancelManageImpl;
	HttpServletRequest request=getRequest();
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
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
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
	public void setCustomerPidCancelManageImpl(
			CustomerPidCancelManageImpl customerPidCancelManageImpl) {
		this.customerPidCancelManageImpl = customerPidCancelManageImpl;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String fileDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
			
			//客户跟踪记录
			Set<CustomerTrack> customertracks = customer2.getCustomertracks();
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
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "fileDetail";
	}
	/**
	 * 功能描述：来电登记
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerShoppingRecord() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerShoppingRecord";
	}
	/**
	 * 功能描述：客户档案
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerFile() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
			//职业信息表
			List<Profession> professions = professionManageImpl.getAll();
			request.setAttribute("professions", professions);
			//行业信息
			List<Industry> industries = industryManageImpl.getAll();
			request.setAttribute("industries", industries);
			//学历信息
			List<Educational> educationals = educationalManageImpl.getAll();
			request.setAttribute("educationals", educationals);
			//兴趣爱好
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFile";
	}
	/**
	 * 功能描述：保存基础档案信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCustomerFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			if(customerId<=0){
				renderErrorMsg(new Throwable("请选择客户"), "");
				return ;
			}
			Customer customer2 = customerMangeImpl.get(customerId);
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
			customer2.setCompanyName1(customer.getCompanyName1());
			customer2.setFamily(customer.getFamily());
			customer2.setQq(customer.getQq());
			customer2.setZipCode(customer.getZipCode());
			customer2.setEmail(customer.getEmail());
			customer2.setNote(customer.getNote());
			customerMangeImpl.save(customer2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomerFile/fileDetail?dbid="+customerId,"更新证件信息成功");
		return;
	}
	/**
	 * 功能描述：修改客户证件信息页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String cardInfo() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				
				//地域信息
				List<Area> areas = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
				request.setAttribute("areas", areas);
				if(null!=customer.getArea()){
					String areaSelect = areaSelect(customer.getArea());
					request.setAttribute("areaSelect", areaSelect);
				}
				
				//证件类型
				List<Paperwork> paperworks = paperworkManageImpl.getAll();
				request.setAttribute("paperworks", paperworks);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "cardInfo";
	}
	/**
	 * 功能描述：保存客户证件信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCardInfo() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		Integer paperworkId = ParamUtil.getIntParam(request, "paperworkId", -1);
		String icard = request.getParameter("icard");
		String customerName = request.getParameter("customerName");
		String mobilePhone = request.getParameter("mobilePhone");
		String address = request.getParameter("address");
		try {
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				customer.setIcard(icard);
				if(null!=icard&&icard.length()>0){
					if(CheckIdCardUtils.validateCard(icard)){
					int age = CheckIdCardUtils.getAgeByIdCard(icard);
						String birthDay = CheckIdCardUtils.getBirthByIdCard(icard);
						customer.setAge(age);
						customer.setNbirthday(DateUtil.string2Date(birthDay));
						String gender = CheckIdCardUtils.getGenderByIdCard(icard);
						if(gender.equals("M")){
							customer.setAge(1);
						}
						if(gender.equals("F")){
							customer.setAge(2);
						}
					}
				}
				if(areaId>0){
					Area area = areaManageImpl.get(areaId);
					customer.setArea(area);
				}
				if(paperworkId>0){
					Paperwork paperwork = paperworkManageImpl.get(paperworkId);
					customer.setPaperwork(paperwork);
				}
				customer.setAddress(address);
				customer.setName(customerName);
				customer.setMobilePhone(mobilePhone);
				customerMangeImpl.save(customer);
			}else{
				renderErrorMsg(new Throwable("请选择客户"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		if(type==1){
			renderMsg("/qywxCustomerFile/fileDetail?dbid="+customerId,"更新证件信息成功");
		}
		if(type==2){
			renderMsg("/qywxOrderContract/addOrderContract?customerId="+customerId+"&editType=1","更新证件信息成功");
		}
		return;
	}
	/**
	 * 功能描述：保存来电登记
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCustomerShoppingRecord() throws Exception {
		try {
			Integer dbid = customer.getDbid();
			if(null==dbid){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
			CustomerShoppingRecord customerShoppingRecord2 = customerShoppingRecordManageImpl.get(customerShoppingRecord.getDbid());
			if(null==customerShoppingRecord2){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
			Integer isTryDriver = customerShoppingRecord.getIsTryDriver();
			if(null==isTryDriver){
				customerShoppingRecord.setIsTryDriver(2);
			}
			customerShoppingRecord2.setComeInTime(customerShoppingRecord.getComeInTime());
			customerShoppingRecord2.setFarwayTime(customerShoppingRecord.getFarwayTime());
			customerShoppingRecord2.setWaitingTime(customerShoppingRecord.getWaitingTime());
			customerShoppingRecord2.setCustomerNum(customerShoppingRecord.getCustomerNum());
			customerShoppingRecord2.setIsTryDriver(customerShoppingRecord.getIsTryDriver());
			customerShoppingRecord2.setIsFirst(customerShoppingRecord.getIsFirst());
			customerShoppingRecord2.setIsGetCar(customerShoppingRecord.getIsGetCar());
			customerShoppingRecord2.setTryDriver(customerShoppingRecord.getTryDriver());
			customerShoppingRecord2.setCarModel(customerShoppingRecord.getCarModel());
			customerShoppingRecord2.setReceptionExperience(customerShoppingRecord.getReceptionExperience());
			
			customerShoppingRecordManageImpl.save(customerShoppingRecord2);
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			log.error(e);
			return ;
		}
		renderMsg("/qywxCustomerFile/fileDetail?dbid="+customer.getDbid(),"保存数据成功");
		return ;
	}
	/**
	 * 功能描述：接待结果
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerBussi() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerBussi";
	}
	/**
	 * 功能描述：接待结果
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerBussiNeed() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			User user = customer2.getUser();
			Enterprise enterprise = user.getEnterprise();
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			//购车预算
			List<BuyCarBudget> buyCarBudgets = buyCarBudgetManageImpl.getAll();
			request.setAttribute("buyCarBudgets", buyCarBudgets);
			//购车主要是用人
			List<BuyCarMainUse> buyCarMainUses = buyCarMainUseManageImpl.getAll();
			request.setAttribute("buyCarMainUses", buyCarMainUses);
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			
			//购车关注是项
			List<BuyCarCare> buyCarCares = buyCarCareManageImpl.getAll();
			request.setAttribute("buyCarCares", buyCarCares);
			
			//购车目的
			List<BuyCarTarget> buyCarTargets = buyCarTargetManageImpl.getAll();
			request.setAttribute("buyCarTargets", buyCarTargets);
			//购车类型
			List<BuyCarType> buyCarTypes = buyCarTypeManageImpl.getAll();
			request.setAttribute("buyCarTypes", buyCarTypes);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerBussiNeed";
	}
	/**
	 * 功能描述：更新接待结果
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCustomerBussiNeed() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer dbid = customerBussi.getDbid();
			if(null==dbid){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
			CustomerBussi customerBussi2 = customerBussiManageImpl.get(dbid);
			if(null==customerBussi2){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
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
			customerBussi2.setNote(customerBussi.getNote());
			customerBussiManageImpl.save(customerBussi2);
			Integer customerId = customer.getDbid();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderMsg("/qywxCustomerFile/fileDetail?dbid="+customer.getDbid(),"保存数据成功");
		return;
	}
	/**
	 * 功能描述：更新接待结果
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCustomerBussi() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer dbid = customerBussi.getDbid();
			if(null==dbid){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
			CustomerBussi customerBussi2 = customerBussiManageImpl.get(dbid);
			if(null==customerBussi2){
				renderErrorMsg(new Throwable("数据发生错误，请稍后再试..."), "");
				return ;
			}
			customerBussi2.setAfterPlan(customerBussi.getAfterPlan());
			customerBussi2.setCustomerSpecification(customerBussi.getCustomerSpecification());
			customerBussi2.setCustomerNeed(customerBussi.getCustomerNeed());
			customerBussi2.setCustomerCareAbout(customerBussi.getCustomerCareAbout());
			customerBussi2.setOtherMainDescription(customerBussi.getOtherMainDescription());
			customerBussiManageImpl.save(customerBussi2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		renderMsg("/qywxCustomerFile/fileDetail?dbid="+customer.getDbid(),"保存数据成功");
		return;
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
}
