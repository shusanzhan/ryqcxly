/**
 * 
 */
package com.ystech.cust.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.CheckIdCardUtils;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerType;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.OrderContractExpensesChargeItem;
import com.ystech.cust.model.OrderContractExpensesPreferenceItem;
import com.ystech.cust.model.OrderContractProduct;
import com.ystech.cust.model.Paperwork;
import com.ystech.cust.service.ApprovalRecordManageImpl;
import com.ystech.cust.service.CustomerBussiManageImpl;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.CustomerTypeManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.cust.service.PaperworkManageImpl;
import com.ystech.xwqr.model.sys.Area;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.AreaManageImpl;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;
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
 * @date 2014-3-11
 */
@Component("orderContractAction")
@Scope("prototype")
public class OrderContractAction extends BaseController{
	private OrderContract orderContract;
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractProductManageImpl orderContractProductManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private EnterpriseManageImpl enterpriseManageImpl;
	private ApprovalRecordManageImpl approvalRecordManageImpl;
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private UserManageImpl userManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CarColorManageImpl carColorManageImpl;
	private AreaManageImpl areaManageImpl;
	private PaperworkManageImpl paperworkManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerLastBussi customerLastBussi;
	private CustomerBussiManageImpl customerBussiManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	private CustomerTypeManageImpl customerTypeManageImpl;
	private CustomerTractUtile customerTractUtile;
	public OrderContract getOrderContract() {
		return orderContract;
	}
	public void setOrderContract(OrderContract orderContract) {
		this.orderContract = orderContract;
	}
	
	public CustomerLastBussi getCustomerLastBussi() {
		return customerLastBussi;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
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
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	@Resource
	public void setOrderContractProductManageImpl(
			OrderContractProductManageImpl orderContractProductManageImpl) {
		this.orderContractProductManageImpl = orderContractProductManageImpl;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setApprovalRecordManageImpl(
			ApprovalRecordManageImpl approvalRecordManageImpl) {
		this.approvalRecordManageImpl = approvalRecordManageImpl;
	}
	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
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
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	@Resource
	public void setPaperworkManageImpl(PaperworkManageImpl paperworkManageImpl) {
		this.paperworkManageImpl = paperworkManageImpl;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
	@Resource
	public void setCustomerBussiManageImpl(
			CustomerBussiManageImpl customerBussiManageImpl) {
		this.customerBussiManageImpl = customerBussiManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setCustomerTypeManageImpl(
			CustomerTypeManageImpl customerTypeManageImpl) {
		this.customerTypeManageImpl = customerTypeManageImpl;
	}
	/**
	 * 功能描述：销售人员添加客户订单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String addOrderContract() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			
			CustomerLastBussi customerLastBussi2 = customer2.getCustomerLastBussi();
			request.setAttribute("customerLastBussi", customerLastBussi2);
			//品牌
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			List<OrderContract> orderContracts = orderContractManageImpl.findBy("customer.dbid", customerId);
			//第一次添加订单
			if(null==orderContracts||orderContracts.size()==0){
				//意向车型
				CustomerBussi  customerBussi=customer2.getCustomerBussi();
				request.setAttribute("customerBussi", customerBussi);
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
					
					List<CarColor> carColors = carColorManageImpl.find("from CarColor where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carColors", carColors);
				}
				return "addOrderContract";
			}
			if(null!=orderContracts&&orderContracts.size()==1){
				OrderContract orderContract2 = orderContracts.get(0);
				request.setAttribute("orderContract", orderContract2);
				CustomerLastBussi customerLastBussi3 = customer2.getCustomerLastBussi();
				request.setAttribute("customerLastBussi", customerLastBussi3);
				Brand brand = customerLastBussi3.getBrand();
				if(null!=brand){
					//意向车型
					List<CarSeriy>  carSeriys= carSeriyManageImpl.find("from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carSeriys", carSeriys);
				}
				CarSeriy carSeriy = customerLastBussi3.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carModels", carModels);
					
					List<CarColor> carColors = carColorManageImpl.find("from CarColor where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
					request.setAttribute("carColors", carColors);
				}
				return "editOrderContract";
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "addOrderContract";
	}
	/**
	 * 功能描述：查看订单信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewOrderContract() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				request.setAttribute("orderContract", orderContract2);
				Customer customer = orderContract2.getCustomer();
				request.setAttribute("customer", orderContract2.getCustomer());
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", dbid);
				if(null!=orderContractDecores&&orderContractDecores.size()==1){
					OrderContractDecore orderContractDecore = orderContractDecores.get(0);
					request.setAttribute("orderContractDecore", orderContractDecore);
				}
				
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
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewOrderContract";
	}
	/**
	 * 功能描述：保存订单合同信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOrderContract() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer editType = ParamUtil.getIntParam(request, "editType", -1);
		try {
			if(customerId<0){
				renderErrorMsg(new Throwable("请选择客户后在提报订单！"),"");
				return ;
			}
			Customer customer = customerMangeImpl.get(customerId);
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
			Integer carColor = ParamUtil.getIntParam(request, "carColor", -1);
			Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
			Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
			CustomerBussi customerBussi = customer.getCustomerBussi();
			if(brandId>0){
				Brand brand2 = brandManageImpl.get(brandId);
				customerLastBussi.setBrand(brand2);
				customerBussi.setBrand(brand2);
			}else{
				renderErrorMsg(new Throwable("请选择品牌"), "");
				return ;
			}
			if(carSeriyId>0){
				CarSeriy carSeriy=carSeriyManageImpl.get(carSeriyId);
				customerLastBussi.setCarSeriy(carSeriy);
				customerBussi.setCarSeriy(carSeriy);
			}else{
				renderErrorMsg(new Throwable("请选择车系"), "");
				return ;
			}
			
			if(carModelId>0){
				CarModel carModel = carModelManageImpl.get(carModelId);
				customerLastBussi.setCarModel(carModel);
				customerBussi.setCarModel(carModel);
			}else{
				renderErrorMsg(new Throwable("请选择车型"), "");
				return ;
			}
			if(enterprise.getBussiType()!=3){
				if(carColor>0){
					CarColor carColor2 = carColorManageImpl.get(carColor);
					customerLastBussi.setCarColor(carColor2);
				}else{
					renderErrorMsg(new Throwable("请选择车辆颜色"), "");
					return ;
				}
			}
			customerLastBussi.setCustomer(customer);
			//更新成交结果信息
			List<CustomerLastBussi> customerLastBussis = customerLastBussiManageImpl.findBy("customer.dbid", customerId);
			if(null!=customerLastBussis&&customerLastBussis.size()>0){
				CustomerLastBussi customerLastBussi2 = customerLastBussis.get(0);
				update(customerLastBussi2);
				//删除重复数据
				customerLastBussiManageImpl.deleteDuplicateDataByCustomerId(customerId);
			}else{
				customerLastBussi.setCreateTime(new Date());
				customerLastBussiManageImpl.save(customerLastBussi);
				//删除重复数据
				customerLastBussiManageImpl.deleteDuplicateDataByCustomerId(customerId);
			}
			orderContract.setCustomer(customer);
			
			if(null!=orderContract.getDbid()&&orderContract.getDbid()>0){
				//编辑情况下先删除订单下的物品
				List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract.getDbid());
				if(null!=orderContractProducts&&orderContractProducts.size()>0){
					for (OrderContractProduct orderContractProduct : orderContractProducts) {
						orderContractProductManageImpl.delete(orderContractProduct);
					}
				}
				OrderContract orderContract2 = orderContractManageImpl.get(orderContract.getDbid());
				orderContract2.setAddress(orderContract.getAddress());
				orderContract2.setContactPhone(orderContract.getContactPhone());
				orderContract2.setBank(orderContract.getBank());
				orderContract2.setBankNo(orderContract.getBankNo());
				orderContract2.setBigOrderMoney(orderContract.getBigOrderMoney());
				orderContract2.setCreateTime(orderContract.getCreateTime());
				orderContract2.setHanderOverCarDate(orderContract.getHanderOverCarDate());
				orderContract2.setIcard(orderContract.getIcard());
				orderContract2.setModifyTime(new Date());
				orderContract2.setName(orderContract.getName());
				orderContract2.setNeedRepresentative(orderContract.getNeedRepresentative());
				orderContract2.setNote(orderContract.getNote());
				orderContract2.setOrderMoney(orderContract.getOrderMoney());
				orderContract2.setSalesRepresentative(orderContract.getSalesRepresentative());
				orderContract2.setIsShowNote(orderContract.getIsShowNote());
				orderContract2.setShowRoomManager(orderContract.getShowRoomManager());
				orderContract2.setZipCode(orderContract.getZipCode());
				orderContract2.setTotalPrice(orderContract.getTotalPrice());
				orderContract2.setAdditionalNote(orderContract.getAdditionalNote());
				orderContractManageImpl.save(orderContract2);
				//删除重复数
				orderContractManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "编辑客户合同", "");
			}else{
				//设置订单未草稿
				orderContract.setStatus(OrderContract.PRINT);
				orderContract.setCreateTime(new Date());
				orderContract.setModifyTime(new Date());
				//保存订单信息
				orderContractManageImpl.save(orderContract);
				//删除重复数
				orderContractManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "创建客户合同", "");
			}
			//保存订单商品信息
			saveOrderContractProduct(request,orderContract);
			
			//更新客户业务信息表中的车型、品牌、车系信息
			CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "O");
			customer.setCustomerPhase(customerPhase);
			customer.setLastResult(Customer.SUCCESS);
			String carModelStr = request.getParameter("carModelStr");
			if(null!=carModelStr){
				customer.setCarModelStr(carModelStr);
			}
			String carColorStr = request.getParameter("carColorStr");
			if(null!=carColorStr){
				customer.setCarColorStr(carColorStr);
			}
			String navPrice = request.getParameter("navPrice");
			if(null!=navPrice){
				customer.setNavPrice(navPrice);
			}
			//客户成交购车
			//更新客户订单状态信息
			customer.setShowRoomManager(orderContract.getShowRoomManager());
			//更新客户订单状态信息
			customer.setOrderContractStatus(Customer.ORDERYEAS);
			customerMangeImpl.save(customer);
			
			//提交订单关闭任务
			customerTractUtile.colseAbnormalTask(customer, CustomerTrack.TASKFINISHTYPEORDER);
		} catch (Exception e) {
			renderErrorMsg(e, "");
			log.error(e);
			return ;
		}
		if(null==orderContract.getDbid()){
			renderMsg("/customer/customerShoppingRecordqueryList", "保存订单数据成功！");
		}else{
			renderMsg("/orderContract/queryList", "保存订单数据成功！");
		}
		//renderMsg("/orderContractExpenses/orderContractExpenses?customerId="+customerId+"&editType="+editType, "保存订单数据成功，正在跳转到费用明细页面！");
		
		return ;
	}
	/**
	 * @param request
	 */
	private void saveOrderContractProduct(HttpServletRequest request,OrderContract orderContract) {
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColor", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		OrderContractProduct orderContractProduct=new OrderContractProduct();
		CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
		orderContractProduct.setCarseriy(carSeriy);
		CarModel carModel = carModelManageImpl.get(carModelId);
		orderContractProduct.setCarModel(carModel);
		orderContractProduct.setPrice(orderContract.getOrderMoney());
		CarColor carColor = carColorManageImpl.get(carColorId);
		orderContractProduct.setCarColor(carColor);
		orderContractProduct.setNum("1");
		orderContractProduct.setNote("");
		orderContractProduct.setOrdercontract(orderContract);
		orderContractProductManageImpl.save(orderContractProduct);
	}
	
	/**
	 * 功能描述：订单客户管理
	 * 参数描述：订单状态
	 * 逻辑描述：
	 * A、列表业务操作：
	 * 销售人员
	 * 1、订单客户，查询有销售人员提交的订单信息，在订单未被经理审批的情况下，销售人员可以编辑、取消订单
	 * 申请通过后可以可以打印合同，而对应的编辑、取消订单按钮隐藏，对于驳回的订单销售人员可以在进行编辑、取消处理
	 * 查看客户档案、编辑、取消、打印合同
	 * 经理
	 * 2、对订单申请可以进行查看订单信息，审批订单信息，审批操作有同意不同意查找按钮，可以打印订单
	 * 查看客户档案、打印、审批操作
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
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
			User currentUser = SecurityUserHolder.getCurrentUser();
			String sql="select * from cust_orderContract as orderc,"
					+ " cust_Customer as cu,"
					+ "cust_CustomerBussi as cb  where"
					+ " cu.bussiStaffId=?  and orderc.customerId=cu.dbid AND  cb.customerId=cu.dbid ";
			List param= new ArrayList();
			param.add(currentUser.getDbid());
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
		return "order";
	}
	/**功能描述：订单客户管理 ---经理审批
	 * 参数描述：订单状态
	 * 逻辑描述：
	 * A、列表业务操作：
	 * 销售人员
	 * 1、订单客户，查询有销售人员提交的订单信息，在订单未被经理审批的情况下，销售人员可以编辑、取消订单
	 * 申请通过后可以可以打印合同，而对应的编辑、取消订单按钮隐藏，对于驳回的订单销售人员可以在进行编辑、取消处理
	 * 查看客户档案、编辑、取消、打印合同
	 * 经理
	 * 2、对订单申请可以进行查看订单信息，审批订单信息，审批操作有同意不同意查找按钮，可以打印订单
	 * 查看客户档案、打印、审批操作
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryManagerOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
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
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
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
			List<CustomerType> customerTypes = customerTypeManageImpl.getAll();
			request.setAttribute("customerTypes", customerTypes);
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarColor> carColors = carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(), brandId, carSeriyId);
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
			String currentDepIds = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			String sql="select * from cust_orderContract as orderc,"
					+ " cust_Customer as cu,"
					+ "cust_CustomerBussi as cb  where"
					+ " orderc.customerId=cu.dbid AND  cb.customerId=cu.dbid ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
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
		}catch (Exception e) {
			e.printStackTrace();
			log.equals(e);
		}
		return "managerOrder";
	}
	/**功能描述：取消订单
	 * 参数描述：订单状态
	 * 逻辑描述：只有在订单为审核的情况下、或者订单驳回的情况下可以取消订单
	 * 1、删除订单信息；
	 * 2、删除成交记录信息
	 * 3、修改customer的最终成交结果
	 */
	public void cancelOrderContract() throws Exception{
		HttpServletRequest request = getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			if(null!=dbid&&dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				//删除数据前更新客户状态
				Customer customer = orderContract2.getCustomer();
				customer.setOrderContractStatus(Customer.ORDERNOT);
				customer.setLastResult(Customer.NORMAL);
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name","A");
				customer.setCustomerPhase(customerPhase);
				customerMangeImpl.save(customer);
				
				
				OrderContractExpenses orderContractExpenses = orderContractExpensesManageImpl.findUnique("from OrderContractExpenses where customer.dbid=?", customer.getDbid());
				//删除最终成交构成记录
				CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
				if(null!=customerLastBussi){
					customerLastBussiManageImpl.delete(customerLastBussi);
				}
				
				//删除附加通知单，附加通知产品列表
				orderContractDecoreManageImpl.deleteBy(orderContract2.getDbid());
				
				//删除订单
				orderContractManageImpl.deleteById(dbid);
				
				//删除订单费用明细
				orderContractExpensesManageImpl.deleteBy(customer.getDbid());
				
				if(null!=orderContractExpenses){
					//删除优惠明细
					orderContractExpensesPreferenceItemManageImpl.deleteByOrderId(orderContractExpenses.getDbid());
					//删除收费明细
					orderContractExpensesChargeItemManageImpl.deleteByOrderId(orderContractExpenses.getDbid());
				}
				
				//删除合同审批任务信息
			}else{
				renderErrorMsg(new Throwable("请选择操作数据！"),"");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/orderContract/queryList", "取消订单成功！");
		return ;
	}
	
	/**
	 * 功能描述：查看审批
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String viewApprovalRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				request.setAttribute("orderContract", orderContract2);
				Customer customer2 = orderContract2.getCustomer();
				request.setAttribute("customer", customer2);
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", dbid);
				if(null!=orderContractDecores&&orderContractDecores.size()==1){
					OrderContractDecore orderContractDecore = orderContractDecores.get(0);
					request.setAttribute("orderContractDecore", orderContractDecore);
				}
				List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract2.getDbid());
				request.setAttribute("orderContractProducts", orderContractProducts);
				
				User user = customer2.getUser();
				
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
		return "viewApprovalRecord";
	}
	/**
	 * 功能描述：打印订单页面跳转，同时将客户状态改为代交车客户状态
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printContract() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer bussiType=1;
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			OrderContract orderContract2 = orderContractManageImpl.get(dbid);
			request.setAttribute("orderContract", orderContract2);
			if(null!=orderContract2){
				List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract2.getDbid());
				request.setAttribute("orderContractProducts", orderContractProducts);
				Customer customer = orderContract2.getCustomer();
				bussiType=customer.getBussiType();
			}
			//费用明细
			List<OrderContractExpenses> orderContractExpenseses = orderContractExpensesManageImpl.findBy("customer.dbid", orderContract2.getCustomer().getDbid());
			if(null!=orderContractExpenseses&&orderContractExpenseses.size()==1){
				OrderContractExpenses orderContractExpenses = orderContractExpenseses.get(0);
				request.setAttribute("orderContractExpenses", orderContractExpenses);
				
			}
			//意向车型
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
		
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		if(bussiType==1){
			return "printContract";
		}
		if(bussiType==2){
			return "printTrialerContract";
		}
		return "printContract";
	}
	/**
	 * 功能描述：打印订单页面跳转，同时将客户状态改为代交车客户状态
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printFjContract() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			OrderContract orderContract2 = orderContractManageImpl.get(dbid);
			request.setAttribute("orderContract", orderContract2);
			if(null!=orderContract2){
				List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract2.getDbid());
				request.setAttribute("orderContractProducts", orderContractProducts);
			}
			
			//意向车型
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			List<Enterprise> enterprises = enterpriseManageImpl.getAll();
			if(null!=enterprises&&enterprises.size()>0){
				request.setAttribute("enterprise", enterprises.get(0));
			}
			
			//费用明细
			List<OrderContractExpenses> orderContractExpenseses = orderContractExpensesManageImpl.findBy("customer.dbid", orderContract2.getCustomer().getDbid());
			if(null!=orderContractExpenseses&&orderContractExpenseses.size()==1){
				OrderContractExpenses orderContractExpenses = orderContractExpenseses.get(0);
				request.setAttribute("orderContractExpenses", orderContractExpenses);
				
				List<OrderContractExpensesChargeItem> orderContractExpensesChargeItems = orderContractExpensesChargeItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
				request.setAttribute("orderContractExpensesChargeItems", orderContractExpensesChargeItems);
				List<OrderContractExpensesPreferenceItem> orderContractExpensesPreferenceItems = orderContractExpensesPreferenceItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
				request.setAttribute("orderContractExpensesPreferenceItems", orderContractExpensesPreferenceItems);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "printFjContract";
	}
	
	/**
	 * 功能描述：修改客户证件信息页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String updateCustomerIdCard() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
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
		return "updateCustomerIdCard";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveUpdateCustomerIdCard() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
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
		renderMsg("/orderContract/addOrderContract?customerId="+customerId, "更新证件信息成功！");
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
	/**
	 * @param customerLastBussi2
	 */
	private void update(CustomerLastBussi customerLastBussi2) {
		customerLastBussi2.setApprovalDate(customerLastBussi.getApprovalDate());
		customerLastBussi2.setApprovalPersonId(customerLastBussi.getApprovalStatus());
		customerLastBussi2.setApprovalPersonName(customerLastBussi.getApprovalPersonName());
		customerLastBussi2.setApprovalStatus(customerLastBussi.getApprovalStatus());
		customerLastBussi2.setCarPlateNo(customerLastBussi.getCarPlateNo());
		customerLastBussi2.setCustomer(customerLastBussi.getCustomer());
		customerLastBussi2.setIsBoutique(customerLastBussi.getIsBoutique());
		customerLastBussi2.setIsBuySafe(customerLastBussi.getIsBuySafe());
		customerLastBussi2.setIsCarPlate(customerLastBussi.getIsCarPlate());
		customerLastBussi2.setNote(customerLastBussi.getNote());
		customerLastBussi2.setBrand(customerLastBussi.getBrand());
		customerLastBussi2.setCarColor(customerLastBussi.getCarColor());
		customerLastBussi2.setCarModel(customerLastBussi.getCarModel());
		customerLastBussi2.setCarSeriy(customerLastBussi.getCarSeriy());
		if(null!=customerLastBussi.getCustomerFlowReason()){
			customerLastBussi2.setCustomerFlowReason(customerLastBussi.getCustomerFlowReason());
		}
		customerLastBussiManageImpl.save(customerLastBussi2);
	}
}
