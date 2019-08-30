/**
 * 
 */
package com.ystech.cust.action;

import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentMesgManageImpl;
import com.ystech.agent.service.AgentMessageUtil;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerFlowReason;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractProduct;
import com.ystech.cust.model.TimeoutsTrackRecord;
import com.ystech.cust.service.CustomerBussiManageImpl;
import com.ystech.cust.service.CustomerFlowReasonManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.OrderContractProductManageImpl;
import com.ystech.cust.service.TimeoutsTrackRecordManageImpl;
import com.ystech.qywx.core.QywxSendMessageUtil;
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

/**
 * @author shusanzhan
 * @date 2014-2-25
 */
@Component("customerLastBussiAction")
@Scope("prototype")
public class CustomerLastBussiAction extends BaseController{
	private CustomerLastBussi customerLastBussi;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CarColorManageImpl carColorManageImpl;
	private TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerBussiManageImpl customerBussiManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractProductManageImpl orderContractProductManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractManageImpl orderContractManageImpl;
	private CustomerFlowReasonManageImpl customerFlowReasonManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	private CustomerTractUtile customerTractUtile;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private AgentMesgManageImpl agentMesgManageImpl;
	private QywxSendMessageUtil qywxSendMessageUtil;
	private UserManageImpl userManageImpl;
	public CustomerLastBussi getCustomerLastBussi() {
		return customerLastBussi;
	}
	public void setCustomerLastBussi(CustomerLastBussi customerLastBussi) {
		this.customerLastBussi = customerLastBussi;
	}
	public CustomerLastBussiManageImpl getCustomerLastBussiManageImpl() {
		return customerLastBussiManageImpl;
	}
	@Resource
	public void setCustomerLastBussiManageImpl(
			CustomerLastBussiManageImpl customerLastBussiManageImpl) {
		this.customerLastBussiManageImpl = customerLastBussiManageImpl;
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
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setCarColorManageImpl(CarColorManageImpl carColorManageImpl) {
		this.carColorManageImpl = carColorManageImpl;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setTimeoutsTrackRecordManageImpl(
			TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl) {
		this.timeoutsTrackRecordManageImpl = timeoutsTrackRecordManageImpl;
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
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
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
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setCustomerFlowReasonManageImpl(
			CustomerFlowReasonManageImpl customerFlowReasonManageImpl) {
		this.customerFlowReasonManageImpl = customerFlowReasonManageImpl;
	}
	@Resource
	public void setAgentOperatorLogManageImpl(
			AgentOperatorLogManageImpl agentOperatorLogManageImpl) {
		this.agentOperatorLogManageImpl = agentOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setAgentMesgManageImpl(AgentMesgManageImpl agentMesgManageImpl) {
		this.agentMesgManageImpl = agentMesgManageImpl;
	}
	@Resource
	public void setQywxSendMessageUtil(QywxSendMessageUtil qywxSendMessageUtil) {
		this.qywxSendMessageUtil = qywxSendMessageUtil;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	* 功能描述：选择成交结果
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String selectResult() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		if(customerId>0){
			//客户信息
			Customer customer = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer);
		}
		return "selectResult";
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String customerFlow() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				//客户信息
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				
				CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
				request.setAttribute("customerLastBussi", customerLastBussi2);
				
				List<CustomerFlowReason> customerFlowReasons = customerFlowReasonManageImpl.getAll();
				request.setAttribute("customerFlowReasons", customerFlowReasons);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerFlow";
	}

	/**
	 * 功能描述： 修改车辆信息
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modify() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(customerId>0){
				//客户信息
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				
				CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
				request.setAttribute("customerLastBussi", customerLastBussi2);
				
				//品牌
				List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
				request.setAttribute("brands", brands);
				//意向车型
				if(null!=customerLastBussi2&&customerLastBussi2.getDbid()>0){
					Brand brand = customerLastBussi2.getBrand();
					if(null!=brand){
						//意向车型
						List<CarSeriy>  carSeriys= carSeriyManageImpl.find(" from CarSeriy where brand.dbid=? and status=?", new Object[]{brand.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carSeriys", carSeriys);
					}
					CarSeriy carSeriy = customerLastBussi2.getCarSeriy();
					if(null!=carSeriy){
						List<CarModel> carModels = carModelManageImpl.find("from CarModel where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carModels", carModels);
						
						List<CarColor> carColors = carColorManageImpl.find("from CarColor where carseries.dbid=? and status=?", new Object[]{carSeriy.getDbid(),CarSeriy.STATUSCOMM});
						request.setAttribute("carColors", carColors);
					}
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "modify";
	}

	/**
	 * 功能描述：保存最终结果信息 
	 * 参数描述：
	 * 逻辑描述：1、保存customerLastResult表信息
	 * 			 2、更新customer表的lastResult字段
	 * 			 3、如果是成交结果为2、3情况，那么需要领导审批
	 * 			 4、如果成交为1，那么修改客户级别为O，如果成交结果为2、3流失，那么客户级别为C级
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Customer customer2=null;
		Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
		Integer customerFlowReasonId = ParamUtil.getIntParam(request, "customerFlowReasonId", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		try{
			Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
			if(customerId>0){
				customer2 = customerMangeImpl.get(customerId);
				if(customer2==null){
					renderErrorMsg(new Throwable("保存数据失败!"), "");
					return ;
				}
				//客户业务信息表
				customerLastBussi.setCustomer(customer2);
				if(lastResult>0){
					customer2.setLastResult(lastResult);
				}else{
					customer2.setLastResult(Customer.NORMAL);
				}
			}
			
			//当成交结果为客户流失 提交领导审批
			//当成交结果为客户流失 提交领导审批
			if(lastResult>=2){
				customerLastBussi.setApprovalStatus(CustomerLastBussi.APPROVALWATING);
				String customerFlowReasonStr="";
				if(customerFlowReasonId>0){
					CustomerFlowReason customerFlowReason = customerFlowReasonManageImpl.get(customerFlowReasonId);
					customerLastBussi.setCustomerFlowReason(customerFlowReason);
					customerFlowReasonStr=customerFlowReason.getName();
				}
				//流失客户
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "L");
				customer2.setCustomerPhase(customerPhase);
				
				  //发送微信消息 已经结束
				String dis="客户姓名："+customer2.getName()+",流失原因："+customerFlowReasonStr;
				if(null!=customer2.getUser()){
					User user2 = customer2.getUser();
					List<User> users = userManageImpl.findBySendWechatMessageUser(user2.getEnterprise());
					for (User user : users) {
						String touser = "R"+user.getUserId();
						String url="/qywxCustomerOutFlow/outFlowDetail?dbid="+customer2.getDbid()+"&type=1";
						qywxSendMessageUtil.sendMessageSingle(touser, url, dis, "客户流失审批通知", request);
					}
				}
			}
			
			
			//保存跟踪记录信息
			List<CustomerLastBussi> customerLastBussis = customerLastBussiManageImpl.findBy("customer.dbid", customerLastBussi.getCustomer().getDbid());
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
			//更新客户成交结果状态
			customerMangeImpl.save(customer2);
			//保存客户操作日志
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer2.getDbid(), "提交客户成交结果", "");
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		if(type==2){
			renderMsg("/main/salerContent", "保存数据成功！");
		}else{
			renderMsg("/custCustomer/customerShoppingRecordqueryList", "保存数据成功！");
		}
		return ;
	}
	/**
	 * @param customerLastBussi2
	 */
	private void update(CustomerLastBussi customerLastBussi2) {
		customerLastBussi2.setApprovalDate(customerLastBussi.getApprovalDate());
		customerLastBussi2.setApprovalPersonId(customerLastBussi.getApprovalStatus());
		customerLastBussi2.setApprovalPersonName(customerLastBussi.getApprovalPersonName());
		customerLastBussi2.setApprovalStatus(customerLastBussi.getApprovalStatus());
		customerLastBussi2.setCarColor(customerLastBussi.getCarColor());
		customerLastBussi2.setBrand(customerLastBussi.getBrand());
		customerLastBussi2.setCarModel(customerLastBussi.getCarModel());
		customerLastBussi2.setCarPlateNo(customerLastBussi.getCarPlateNo());
		customerLastBussi2.setCarSeriy(customerLastBussi.getCarSeriy());
		customerLastBussi2.setCustomer(customerLastBussi.getCustomer());
		customerLastBussi2.setIsBoutique(customerLastBussi.getIsBoutique());
		customerLastBussi2.setIsBuySafe(customerLastBussi.getIsBuySafe());
		customerLastBussi2.setIsCarPlate(customerLastBussi.getIsCarPlate());
		customerLastBussi2.setNote(customerLastBussi.getNote());
		customerLastBussiManageImpl.save(customerLastBussi2);
	}
	/**
	 * 功能描述：保存最终结果信息 
	 * 参数描述：
	 * 逻辑描述：1、保存customerLastResult表信息
	 * 			 2、更新customer表的lastResult字段
	 * 			 3、如果是成交结果为2、3情况，那么需要领导审批
	 * 			 4、如果成交为1，那么修改客户级别为O，如果成交结果为2、3流失，那么客户级别为C级
	 * @return
	 * @throws Exception
	 */
	public void saveModify() throws Exception {
		HttpServletRequest request = getRequest();
		Customer customer2=null;
		CustomerBussi customerBussi=null;
		try{
				Integer dbid = customerLastBussi.getDbid();
				Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
				if(customerId>0){
					customer2 = customerMangeImpl.get(customerId);
					if(customer2==null){
						renderErrorMsg(new Throwable("保存数据失败!"), "");
						return ;
					}
					//客户业务信息表
					customerBussi=customer2.getCustomerBussi();
					customerLastBussi.setCustomer(customer2);
				}
				
				//成交客户
				//更新客户业务信息表中的车型、品牌、车系信息
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "O");
				customer2.setCustomerPhase(customerPhase);
				
				Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
				Integer carColor = ParamUtil.getIntParam(request, "carColor", -1);
				Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
				Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
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
				if(carColor>0){
					CarColor carColor2 = carColorManageImpl.get(carColor);
					customerLastBussi.setCarColor(carColor2);
				}else{
					renderErrorMsg(new Throwable("请选择车辆颜色"), "");
					return ;
				}
				
				
				//表单重复提交
				if(null!=dbid&&dbid>0){
					CustomerLastBussi customerLastBussi2 = customerLastBussiManageImpl.get(dbid);
					update(customerLastBussi2);
				}
				//更新客户业务表车型、车系
				customerBussiManageImpl.save(customerBussi);
				
				//如果提交过订单，那么需要修改订单的费用，删除装饰通知单
				List<OrderContract> orderContracts = orderContractManageImpl.findBy("customer.dbid", customer2.getDbid());
				if(null!=orderContracts&&orderContracts.size()==1){
					OrderContract orderContract = orderContracts.get(0);
						
					//删除订商品单信息
					List<OrderContractProduct> orderContractProducts = orderContractProductManageImpl.findBy("ordercontract.dbid", orderContract.getDbid());
					if(null!=orderContractProducts&&orderContractProducts.size()>0){
						for (OrderContractProduct orderContractProduct : orderContractProducts) {
							orderContractProductManageImpl.delete(orderContractProduct);
						}
					}
					
					//删除费用明细
					orderContractExpensesManageImpl.deleteBy(customer2.getDbid());
					
					//删除附加通知单
					orderContractDecoreManageImpl.deleteBy(orderContract.getDbid());
					
					//删除订单信息
					orderContractManageImpl.delete(orderContract);
				}
				
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/custCustomer/customerShoppingRecordqueryList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：流失客户转换为登记客户
	 * 参数描述：客户Id
	 * 逻辑描述：根据客户id信息，获取客户信息。
	 * 还原登记客户：需要删除最终结果信息，并且也要删除审批记录信息，修改客户的状态为默认状态
	 * @return
	 * @throws Exception
	 */
	public void turnOutFlowerCustomerToCustomer() throws Exception {
		HttpServletRequest request = getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			if(dbid>0){
				//删除成交记录信息
				Customer customer = customerMangeImpl.get(dbid);
				TimeoutsTrackRecord timeoutsTrackRecord = customer.getTimeoutsTrackRecord();
				CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
				customerLastBussiManageImpl.delete(customerLastBussi2);
				//修改客户成交结果信息
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "C");
				customer.setLastResult(Customer.NORMAL);
				customer.setCustomerPhase(customerPhase);
				customerMangeImpl.save(customer);
				
				//流失客户转登记客户 创建任务
				customerTractUtile.createFlowCustomerTask(customer,customerPhase);
				
				//推荐客户修改状态为客户流失
				RecommendCustomer recommendCustomer = customer.getRecommendCustomer();
				if(null!=recommendCustomer){
					recommendCustomer.setTradeStatus(RecommendCustomer.TRADECOMM);
					recommendCustomerManageImpl.save(recommendCustomer);
					saveAgentOperatorLog("流失客户转为登记客户", "推荐客户流失转为登记客户", customer.getDbid(), currentUser);
				}
				//保存客户操作日志
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "流失客户转为登记客户", "");
				
			}else {
				renderErrorMsg(new Throwable("请选择操作数据！"), "");
				return;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/custCustomer/queryOutFlow", "流失客户已经转换为登记客户，请到登记客户页面查看！");
		return ;
	}
	
	/**
	 * 功能描述：销售经理审批页面跳转
	 * 参数描述：客户信息ID
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String approval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				//客户信息
				Customer customer = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer);
				CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
				request.setAttribute("customerLastBussi", customerLastBussi2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "approvalLastResult";
	}
	/**
	 * 功能描述：销售经理审批记录保持
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveApproval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		//1、审批同意；2、驳回
		Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
				customerLastBussi2.setApprovalDate(new Date());
				customerLastBussi2.setApprovalPersonId(currentUser.getDbid());
				customerLastBussi2.setApprovalPersonName(currentUser.getRealName());
				customerLastBussi2.setApprovalStatus(lastResult);
				//1、审批同意
				if(lastResult==1){
					customerLastBussiManageImpl.save(customerLastBussi2);
					
					customerTractUtile.colseAbnormalTask(customer, CustomerTrack.TASKFINISHTYPECUSTOMERFLOW);
					//推荐客户修改状态为客户流失
					RecommendCustomer recommendCustomer = customer.getRecommendCustomer();
					if(null!=recommendCustomer){
						recommendCustomer.setTradeStatus(RecommendCustomer.TRADEFAIL);
						recommendCustomerManageImpl.save(recommendCustomer);
						saveAgentOperatorLog("推荐客户流失，交易失败", "推荐客户流失"+currentUser.getRealName()+"审批同意", customerId, currentUser);
						
						String agentMessage="客户流失通知，您的推荐【"+recommendCustomer.getName()+"】已流失。流失原因："+customerLastBussi2.getCustomerFlowReason().getName()+".";
						AgentMessageUtil.saveAgentMessage(agentMesgManageImpl, agentMessage, recommendCustomer.getMember());
					}
					//保存客户操作日志
					customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "客户流失审批同意", currentUser.getRealName()+"同意客户流失");
				}
				//2、驳回
				if(lastResult==2){
					customer.setLastResult(Customer.NORMAL);
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "C");
					customer.setCustomerPhase(customerPhase);
					customerMangeImpl.save(customer);
					customerLastBussiManageImpl.save(customerLastBussi2);
				}
			}	
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		if(type>0){
			if(type==1){
				renderMsg("/custCustomer/queryRoomManageOutFlow", "审批成功！");
			}
			if(type==2){
				renderMsg("/custCustomer/queryLeaderOutFlow", "审批成功！");
			}
			if(type==3){
				renderMsg("/main/mangerContent", "审批成功！");
			}
		}else{
			renderMsg("/custCustomer/queryRoomManageOutFlow", "审批成功！");
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
					customerLastBussiManageImpl.deleteById(dbid);
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
		renderMsg("/customerTrack/queryList"+query, "删除数据成功！");
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
	public void saveCarNo() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer huiminTemplateId = ParamUtil.getIntParam(request, "huiminTemplateId", -1);
		String carPlateNoe = request.getParameter("carPlateNo");
		try{
			String decode="";
			if(null!=carPlateNoe&&carPlateNoe.trim().length()>0){
				decode = URLDecoder.decode(carPlateNoe, "UTF-8");
			}
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
					customerLastBussi2.setCarPlateNo(decode);
					customerLastBussiManageImpl.save(customerLastBussi2);
					renderMsg("/customerPidBookingRecord/printHuimin?customerId="+customerId+"&huiminTemplateId="+huiminTemplateId, "保存数据成功！");
					return ;
				}else{
					renderErrorMsg(new Throwable("保存数据失败！"), "");
					return ;
				}
			}else{
				renderErrorMsg(new Throwable("保存数据失败！"), "");
				return ;
			}
		}catch (Exception e) {
			renderErrorMsg(e, "");
			return ;
		}
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
