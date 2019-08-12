package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.ApprovalRecord;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.OrderContractExpensesChargeItem;
import com.ystech.cust.model.OrderContractExpensesPreferenceItem;
import com.ystech.cust.model.OrderContractProduct;
import com.ystech.cust.service.ApprovalRecordManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarColor;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarColorManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxOrderContractAction")
@Scope("prototype")
public class QywxOrderContractAction extends BaseController{
	private OrderContract orderContract;
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractProductManageImpl orderContractProductManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	private ApprovalRecordManageImpl approvalRecordManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CarColorManageImpl carColorManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private UserManageImpl userManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerLastBussi customerLastBussi;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerTractUtile customerTractUtile;
	public OrderContract getOrderContract() {
		return orderContract;
	}
	public void setOrderContract(OrderContract orderContract) {
		this.orderContract = orderContract;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
	}
	@Resource
	public void setOrderContractProductManageImpl(
			OrderContractProductManageImpl orderContractProductManageImpl) {
		this.orderContractProductManageImpl = orderContractProductManageImpl;
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
	public void setApprovalRecordManageImpl(
			ApprovalRecordManageImpl approvalRecordManageImpl) {
		this.approvalRecordManageImpl = approvalRecordManageImpl;
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
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	
	public CustomerLastBussi getCustomerLastBussi() {
		return customerLastBussi;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			
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
					List<CarSeriy>  carSeriys= carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(), brand.getDbid());
					request.setAttribute("carSeriys", carSeriys);
				}
				CarSeriy carSeriy = customerBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(), brand.getDbid(),carSeriy.getDbid());
					request.setAttribute("carModels", carModels);
					
					List<CarColor> carColors = carColorManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid());
					request.setAttribute("carColors", carColors);
				}
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
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "editOrderContract";
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
		Integer orderContractDbid=orderContract.getDbid();
		try {
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			if(customerId<0){
				renderErrorMsg(new Throwable("请选择客户后在提报订单！"),"");
				return ;
			}
			Customer customer = customerMangeImpl.get(customerId);
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
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		if(null!=orderContractDbid&&orderContractDbid>0){
			renderMsg("/qywxCustomer/orderCustomer", "保存订单数据成功!");
		}else{
			renderMsg("/qywxCustomer/list", "保存订单数据成功！");
		}
		
		return ;
	}
	/**
	 * @param request
	 */
	/**
	 * @param request
	 */
	private void saveOrderContractProduct(HttpServletRequest request,OrderContract orderContract) {
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carColorId = ParamUtil.getIntParam(request, "carColor", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract.getDbid());
		for (OrderContractProduct orderContractProduct2 : orderContractProducts) {
			orderContractProductManageImpl.delete(orderContractProduct2);
		}
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
				
			}else{
				renderErrorMsg(new Throwable("请选择操作数据！"),"");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomer/orderCustomer", "取消订单成功！");
		return ;
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
			System.err.println("=============");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	/**
	 * 功能描述：展厅经理审批页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String roomManageApprovalOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User currentUser = getSessionUser();
			
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cu.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cu.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			String sql="select * from cust_orderContract as orderc, cust_Customer as cu  where "+selSql+"  " +
					" and orderc.customerId=cu.dbid and orderc.status=? ";
			
			List param= new ArrayList();
			sql=sql+" order by createTime DESC";
			List<OrderContract> orderContracts = orderContractManageImpl.executeSql(sql, param.toArray());
			request.setAttribute("orderContracts", orderContracts);
			
			long count = orderContractManageImpl.countSqlResult(sql,param.toArray());
			request.setAttribute("count", count);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "roomManageApprovalOrder";
	}
	/**
	 * 功能描述：展厅经理审批页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String apprvoalRoomMangeOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			//意向车型
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				/*if(orderContract2.getStatus()!=OrderContract.ROOMMANAGEWATING){
					request.setAttribute("message", orderContract2.getCustomer().getName()+"已经审批完成，请勿重复审批！");
					request.setAttribute("url","/qywxOrderContract/roomManageApprovalOrder");
					return "error";
				}*/
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
		return "apprvoalRoomMangeOrder";
	}
	/**
	 * 功能描述：销售副总审批列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String saleManageApprovalOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String sql="select * from " +
					"cust_orderContract as orderc ,cust_Customer as cu" +
					"	where  " +
					"orderc.customerId=cu.dbid  and cu.customerType="+Customer.CUSTOMERTYPECOMM+" order by orderc.createTime limit 5 ";
			List<OrderContract> orderContracts = orderContractManageImpl.executeSql(sql, null);
			request.setAttribute("orderContracts", orderContracts);
			
			String countSql = StringUtils.substringBefore(sql, "order by");
			long count = orderContractManageImpl.countSqlResult(sql,null);
			request.setAttribute("count", count);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "saleManageApprovalOrder";
	}
	/**
	 * 功能描述：总经理（带我审批）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String generalManageApprovalOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String sql="select * from " +
					"cust_orderContract as orderc ,cust_Customer as cu" +
					"	where  " +
					"orderc.customerId=cu.dbid  and cu.customerType="+Customer.CUSTOMERTYPECOMM+" order by orderc.createTime limit 5 ";
			List<OrderContract> orderContracts = orderContractManageImpl.executeSql(sql, null);
			request.setAttribute("orderContracts", orderContracts);
			
			String countSql = StringUtils.substringBefore(sql, "order by");
			long count = orderContractManageImpl.countSqlResult(sql,null);
			request.setAttribute("count", count);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "generalManageApprovalOrder";
	}
	/**
	 * 功能描述：订单明细(销售副总）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String apprvoalOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			//意向车型
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				if(orderContract2.getStatus()>1){
					request.setAttribute("message", orderContract2.getCustomer().getName()+"已经审批完成，请勿重复审批！");
					request.setAttribute("url","/qywxOrderContract/saleManageApprovalOrder");
					return "error";
				}
				request.setAttribute("orderContract", orderContract2);
				request.setAttribute("customer", orderContract2.getCustomer());
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", dbid);
				if(null!=orderContractDecores&&orderContractDecores.size()==1){
					OrderContractDecore orderContractDecore = orderContractDecores.get(0);
					request.setAttribute("orderContractDecore", orderContractDecore);
				}
				//审批记录
				List<ApprovalRecord> approvalRecords = approvalRecordManageImpl.findBy("orderContract.dbid", orderContract2.getDbid());
				request.setAttribute("approvalRecords", approvalRecords);
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
		return "apprvoalSaleMangeOrder";
	}
	/**
	 * 功能描述：订单明细(总经理）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String apprvoalGeneralMangeOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			//意向车型
			if(dbid>0){
				OrderContract orderContract2 = orderContractManageImpl.get(dbid);
				if(orderContract2.getStatus()>4){
					request.setAttribute("message", orderContract2.getCustomer().getName()+"已经审批完成，请勿重复审批！");
					request.setAttribute("url","/qywxOrderContract/generalManageApprovalOrder");
					return "error";
				}
				
				request.setAttribute("orderContract", orderContract2);
				request.setAttribute("customer", orderContract2.getCustomer());
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", dbid);
				if(null!=orderContractDecores&&orderContractDecores.size()==1){
					OrderContractDecore orderContractDecore = orderContractDecores.get(0);
					request.setAttribute("orderContractDecore", orderContractDecore);
				}
				//审批记录
				List<ApprovalRecord> approvalRecords = approvalRecordManageImpl.findBy("orderContract.dbid", orderContract2.getDbid());
				request.setAttribute("approvalRecords", approvalRecords);
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
		return "apprvoalGeneralMangeOrder";
	}
	/**
	 * 功能描述：保存审批信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveApproval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer orderContractId = ParamUtil.getIntParam(request, "orderContractId", -1);
		Integer status = ParamUtil.getIntParam(request, "status", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String note = request.getParameter("sugg");
		User currentUser = getSessionUser();
		try{
			if(orderContractId>0){
					OrderContract orderContract2 = orderContractManageImpl.get(orderContractId);
					ApprovalRecord approvalRecord=new ApprovalRecord();
					//合同审核成功
					orderContract2.setStatus(status);
					if(null!=currentUser){
						if(type==1){
							orderContract2.setShowRoomManager(currentUser.getRealName());
						}
						approvalRecord.setApprovalId(currentUser.getDbid());
						approvalRecord.setApprovalName(currentUser.getRealName());
					}
					approvalRecord.setApprovalTime(new Date());
					approvalRecord.setOrderContract(orderContract2);
					approvalRecord.setSugg(note);
					approvalRecord.setResult(status);
					orderContractManageImpl.save(orderContract2);
					approvalRecordManageImpl.save(approvalRecord);
					
			}else{
				renderErrorMsg(new Throwable("未选择定点信息！"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
		}
		//销售副总审批成功页面跳转
		if(type==1){
			renderMsg("/qywxOrderContract/saleManageApprovalOrder", "保存审批信息成功！");
		}
		//总经理审批成功页面跳转
		if(type==2){
			renderMsg("/qywxOrderContract/generalManageApprovalOrder", "保存审批信息成功！");
		}
		//展厅经理审批
		if(type==3){
			renderMsg("/qywxOrderContract/roomManageApprovalOrder", "保存审批信息成功！");
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
	public String viewApprovalOrderContractDetail() throws Exception {
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
				//审批记录
				List<ApprovalRecord> approvalRecords = approvalRecordManageImpl.findBy("orderContract.dbid", orderContract2.getDbid());
				request.setAttribute("approvalRecords", approvalRecords);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "viewApprovalOrderContractDetail";
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
