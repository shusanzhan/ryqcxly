/**
 * 
 */
package com.ystech.qywx.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractDecoreItem;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.Product;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.cust.service.OrderContractDecoreItemManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.cust.service.ProductManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("qywxOrderContractDecoreAction")
@Scope("prototype")
public class QywxOrderContractDecoreAction extends BaseController{
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractDecoreItemManageImpl orderContractDecoreItemManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private OrderContractDecore orderContractDecore;
	private ProductManageImpl productManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerTractUtile customerTractUtile;
	private HttpServletRequest request=this.getRequest();
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public OrderContractDecore getOrderContractDecore() {
		return orderContractDecore;
	}
	public void setOrderContractDecore(OrderContractDecore orderContractDecore) {
		this.orderContractDecore = orderContractDecore;
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
	public void setOrderContractDecoreItemManageImpl(
			OrderContractDecoreItemManageImpl orderContractDecoreItemManageImpl) {
		this.orderContractDecoreItemManageImpl = orderContractDecoreItemManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setProductManageImpl(ProductManageImpl productManageImpl) {
		this.productManageImpl = productManageImpl;
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
	 * 功能描述：编辑或添加交款确认单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderContractDecore() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer editType = ParamUtil.getIntParam(request, "editType", -1);
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					request.setAttribute("customer",customer);
					CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
					request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
					CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
					request.setAttribute("customerLastBussi", customerLastBussi);
					
					OrderContract orderContract = customer.getOrderContract();
					request.setAttribute("orderContract", orderContract);
					List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("customer.dbid", customerId);
					if(null!=orderContractDecores&&orderContractDecores.size()==1){
						OrderContractDecore orderContractDecore2 = orderContractDecores.get(0);
						request.setAttribute("orderContractDecore", orderContractDecore2);
					}
					List<OrderContractExpenses> orderContractExpenses = orderContractExpensesManageImpl.findBy("customer.dbid", customerId);
					if(null!=orderContractExpenses&&orderContractExpenses.size()>0){
						request.setAttribute("orderContractExpense", orderContractExpenses.get(0));
					}
				}
				request.setAttribute("editType", editType);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：保存交款确认单信息.
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOrderContractDecore() throws Exception {
		HttpServletRequest request2 = this.getRequest();
		Integer orderContractId = ParamUtil.getIntParam(request2, "orderContractId", -1);
		Integer orderContractExpenseId = ParamUtil.getIntParam(request2, "orderContractExpenseId", -1);
		Integer customerId = ParamUtil.getIntParam(request2, "customerId", -1);
		//确定是保存数据为草稿还是提交审批
		Integer smtType = ParamUtil.getIntParam(request2, "smtType", 1);
		
		//更新
		//确定保持成功后页面是否跳转到订单列表页面，还是来店登记页面
		Integer editType = ParamUtil.getIntParam(request2, "editType", -1);
		Integer dbid=null;
		User currentUser = getSessionUser();
		try{
			if(orderContractId<0){
				renderErrorMsg(new Throwable("请先提报订单信息！"),"");
				return ;
			}
			OrderContractExpenses orderContractExpenses = orderContractExpensesManageImpl.get(orderContractExpenseId);
			Customer customer = customerMangeImpl.get(customerId);
			OrderContract orderContract = orderContractManageImpl.get(orderContractId);
			dbid = orderContractDecore.getDbid();
			//更新做合同谈判人员信息
			customer.setReceptierSaler(currentUser);
			customer.setReceptierSalerName(currentUser.getRealName());
			//更新接待销售顾问信
			customer.setUser(currentUser);
			customer.setBussiStaff(currentUser.getRealName());
			Department department = currentUser.getDepartment();
			if(null!=department){
				customer.setSuccessDepartment(department);
			}
			if(dbid==null||dbid<0){
				orderContractDecore.setOrderContract(orderContract);
				orderContractDecore.setCustomer(customer);
				orderContractDecoreManageImpl.save(orderContractDecore);
				orderContractDecoreManageImpl.deleteDuplicateDataByCustomerId(customerId);
				saveOrderContractProduct(request2, orderContractDecore);
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "合同添加装饰保存草稿","",customer.getUser());
				//政策盈利估算
				Double carGrofitPrice = orderContractExpenses.getCarGrofitPrice();
				if(null==carGrofitPrice){
					carGrofitPrice=Double.valueOf(0);
				}
				Double salerTotalPrice = orderContractDecore.getSalerTotalPrice();		
				if(salerTotalPrice!=null){
					carGrofitPrice=carGrofitPrice-salerTotalPrice;
					orderContractExpenses.setCarGrofitPrice(carGrofitPrice);
					orderContractExpensesManageImpl.save(orderContractExpenses);
				}
			}else{
				OrderContractDecore orderContractDecore2 = orderContractDecoreManageImpl.get(dbid);
				Set<OrderContractDecoreItem> orderContractDecoreItems = orderContractDecore2.getOrderContractDecoreItem();
				//删除数据
				if(null!=orderContractDecoreItems){
					for (OrderContractDecoreItem orderContractDecoreItem : orderContractDecoreItems) {
						orderContractDecoreItemManageImpl.delete(orderContractDecoreItem);
					}
				}
				
				orderContractDecore2.setDecoreSaleTotalPrce(orderContractDecore.getDecoreSaleTotalPrce());
				orderContractDecore2.setGiveTotalPrice(orderContractDecore.getGiveTotalPrice());
				orderContractDecore2.setZkl(orderContractDecore.getZkl());
				orderContractDecore2.setSalerGrofitPrice(orderContractDecore.getSalerGrofitPrice());
				orderContractDecore2.setSalerTotalPrice(orderContractDecore.getSalerTotalPrice());
				orderContractDecore2.setCostPrice(orderContractDecore.getCostPrice());
				orderContractDecore2.setCostGrofitPrice(orderContractDecore.getCostGrofitPrice());
				orderContractDecoreManageImpl.save(orderContractDecore2);
				orderContractDecoreManageImpl.deleteDuplicateDataByCustomerId(customerId);
				saveOrderContractProduct(request2, orderContractDecore2);
				
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "合同装饰编辑保存草稿","",customer.getUser());
				
				//政策盈利估算
				Double carGrofitPrice = orderContractExpenses.getCarGrofitPrice();
				if(null==carGrofitPrice){
					carGrofitPrice=Double.valueOf(0);
				}
				Double salerTotalPrice = orderContractDecore.getSalerTotalPrice();		
				if(salerTotalPrice!=null){
					carGrofitPrice=carGrofitPrice-salerTotalPrice;
					orderContractExpenses.setCarGrofitPrice(carGrofitPrice);
					orderContractExpensesManageImpl.save(orderContractExpenses);
				}
			}
			if(smtType==2){
				User user = customer.getUser();
				User parent = user.getParent();
				if(null==parent){
					Integer selfApproval = user.getSelfApproval();
					if(selfApproval==(int)User.SELFAPPROVALCOMM){
						renderErrorMsg(new Throwable("无审批人订单提交失败！"),"");
						return ;
					}
				}
				//更新订单状态为创建状态
				orderContract.setStatus(OrderContract.STATUSWATING);
				orderContractManageImpl.save(orderContract);
				
				//更新客户订单状态信息
				customer.setOrderContractStatus(Customer.ORDERYEAS);
				//谁审批的展厅经理就是谁 此处设置展厅经理的数据
				customer.setShowRoomManager(orderContract.getShowRoomManager());
				customerMangeImpl.save(customer);
				
				////////////////////////////////////////发起合同订单审批流程//////////////////////////////////////////
				//提交订单关闭任务
				customerTractUtile.colseAbnormalTask(customer, CustomerTrack.TASKFINISHTYPEORDER);
				
				//记录客户操作日志
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "合同提交审批","",customer.getUser());
			}
			
			//归档 初始化装饰信息表/////////////////////////END///////////////////////////
			////////////////////更新物流部核查装饰通知单/////////////////////////////
			
			
			////////////////////更新物流部核查装饰通知单/////////////////////////////
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "保存数据失败！");
			return ;		
		}
		if(editType==1){
			renderMsg("/qywxCustomer/list", "保存订单数据成功！");
			return ;
		}
		if(editType==2){
			renderMsg("/qywxCustomer/orderCustomer", "保存订单数据成功！");
			return ;
		}
		renderMsg("/qywxCustomer/list", "保存订单数据成功！");
		return ;
	}
	/**
	 * @param request
	 */
	private void saveOrderContractProduct(HttpServletRequest request,OrderContractDecore decoreNotice) {
		String[] productDbids = request.getParameterValues("productDbid");
		String[] type1s = request.getParameterValues("type1");
		String[] nums = request.getParameterValues("num");
		if(null!=productDbids&&productDbids.length>0){
			int length = productDbids.length;
			for (int i=0;i<length;i++) {
				OrderContractDecoreItem orderContractDecoreItem=new OrderContractDecoreItem();
				String productDbid = productDbids[i];
				if((null==productDbid||productDbid.trim().length()<=0)){
					continue;
				}
				int productId = Integer.parseInt(productDbid);
				Product product = productManageImpl.get(productId);
				if(null!=product){
					orderContractDecoreItem.setSerNo(product.getSn());
					orderContractDecoreItem.setItemName(product.getName());
					orderContractDecoreItem.setPrice(product.getPrice().longValue());
					orderContractDecoreItem.setProduct(product);
				}
				
				String typeO = type1s[i];
				if(null!=typeO&&typeO.trim().length()>0){
					orderContractDecoreItem.setType(Integer.parseInt(typeO));
				}
				
				String num = nums[i];
				if(null!=num&&num.trim().length()>0){
					orderContractDecoreItem.setQuality(Integer.parseInt(num));
				}
				
				orderContractDecoreItem.setOrderContractDecore(decoreNotice);
				orderContractDecoreItemManageImpl.save(orderContractDecoreItem);
			}
		}
	}
	/**
	 * 功能描述：打印交款确认单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printOrderContractDecore() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("customerId", customerId);
					if(null!=orderContractDecores&&orderContractDecores.size()==1){
						OrderContractDecore orderContractDecore2 = orderContractDecores.get(0);
						request.setAttribute("customer",customer);
						CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
						request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
						
						CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
						request.setAttribute("customerLastBussi", customerLastBussi);
						
						OrderContract orderContract = customer.getOrderContract();
						request.setAttribute("orderContract", orderContract);
						
						request.setAttribute("orderContractDecore", orderContractDecore2);
					}else{
						return "error";
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "printDecoreNotice";
	}
	
}
