/**
 * 
 */
package com.ystech.cust.action;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

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
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("orderContractDecoreAction")
@Scope("prototype")
public class OrderContractDecoreAction extends BaseController{
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractDecoreItemManageImpl orderContractDecoreItemManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private OrderContractDecore orderContractDecore;
	private ProductManageImpl productManageImpl;
	private CustomerTractUtile customerTractUtile;
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	private HttpServletRequest request=this.getRequest();
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
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setProductManageImpl(ProductManageImpl productManageImpl) {
		this.productManageImpl = productManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	public OrderContractDecore getOrderContractDecore() {
		return orderContractDecore;
	}
	public void setOrderContractDecore(OrderContractDecore orderContractDecore) {
		this.orderContractDecore = orderContractDecore;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
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
		return "decoreNotice";
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
		//确定是保存数据为草稿还是提交审批
		Integer smtType = ParamUtil.getIntParam(request2, "smtType", 1);
		
		//更新
		//确定保持成功后页面是否跳转到订单列表页面，还是来店登记页面
		Integer editType = ParamUtil.getIntParam(request2, "editType", -1);
		Integer modifyType = ParamUtil.getIntParam(request2, "modifyType", -1);
		Integer customerId=0;
		Integer dbid=null;
		try{
			if(orderContractId<0){
				renderErrorMsg(new Throwable("请先提报订单信息！"),"");
				return ;
			}
			OrderContract orderContract = orderContractManageImpl.get(orderContractId);
			OrderContractExpenses orderContractExpenses = orderContractExpensesManageImpl.get(orderContractExpenseId);
			dbid = orderContractDecore.getDbid();
			Customer customer = orderContract.getCustomer();
			customerId=customer.getDbid();
			if(dbid==null||dbid<0){
				orderContractDecore.setOrderContract(orderContract);
				orderContractDecore.setCustomer(customer);
				orderContractDecoreManageImpl.save(orderContractDecore);
				orderContractDecoreManageImpl.deleteDuplicateDataByCustomerId(customerId);
				saveOrderContractProduct(request2, orderContractDecore);
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "合同添加装饰保存草稿","");
				//整车盈利估算
				Double totalGrofitPrice= orderContractExpenses.getTotalGrofitPrice();
				if(null==totalGrofitPrice){
					totalGrofitPrice=Double.valueOf(0);
				}
				Double salerTotalPrice = orderContractDecore.getSalerTotalPrice();		
				if(salerTotalPrice!=null){
					totalGrofitPrice=totalGrofitPrice-salerTotalPrice;
					//装饰销售顾问结算价
					orderContractExpenses.setDecoreCostMoney(salerTotalPrice);
					//装饰销售利润
					Double decoreMoney = orderContractExpenses.getDecoreMoney();
					if(decoreMoney==null){
						decoreMoney=Double.valueOf(0);
					}
					Double decoreGrofitPrice=decoreMoney-salerTotalPrice;
					orderContractExpenses.setDecoreGrofitPrice(decoreGrofitPrice);
					//总毛利
					orderContractExpenses.setTotalGrofitPrice(totalGrofitPrice);
				}else{
					salerTotalPrice=Double.valueOf(0);
					//装饰销售顾问结算价
					orderContractExpenses.setDecoreCostMoney(salerTotalPrice);
					//装饰销售利润
					Double decoreMoney = orderContractExpenses.getDecoreMoney();
					if(decoreMoney==null){
						decoreMoney=Double.valueOf(0);
					}
					Double decoreGrofitPrice=decoreMoney-salerTotalPrice;
					orderContractExpenses.setDecoreGrofitPrice(decoreGrofitPrice);
				}
				orderContractExpensesManageImpl.save(orderContractExpenses);
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
				
				//整车盈利估算
				Double totalGrofitPrice= orderContractExpenses.getTotalGrofitPrice();
				if(null==totalGrofitPrice){
					totalGrofitPrice=Double.valueOf(0);
				}
				Double salerTotalPrice = orderContractDecore.getSalerTotalPrice();		
				if(salerTotalPrice!=null){
					totalGrofitPrice=totalGrofitPrice-salerTotalPrice;
					//装饰销售顾问结算价
					orderContractExpenses.setDecoreCostMoney(salerTotalPrice);
					//装饰销售利润
					Double decoreMoney = orderContractExpenses.getDecoreMoney();
					if(decoreMoney==null){
						decoreMoney=Double.valueOf(0);
					}
					Double decoreGrofitPrice=decoreMoney-salerTotalPrice;
					orderContractExpenses.setDecoreGrofitPrice(decoreGrofitPrice);
					//总毛利
					orderContractExpenses.setTotalGrofitPrice(totalGrofitPrice);
				}else{
					salerTotalPrice=Double.valueOf(0);
					//装饰销售顾问结算价
					orderContractExpenses.setDecoreCostMoney(salerTotalPrice);
					//装饰销售利润
					Double decoreMoney = orderContractExpenses.getDecoreMoney();
					if(decoreMoney==null){
						decoreMoney=Double.valueOf(0);
					}
					Double decoreGrofitPrice=decoreMoney-salerTotalPrice;
					orderContractExpenses.setDecoreGrofitPrice(decoreGrofitPrice);
				}
				orderContractExpensesManageImpl.save(orderContractExpenses);
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
				
				//提交订单关闭任务
				customerTractUtile.colseAbnormalTask(customer, CustomerTrack.TASKFINISHTYPEORDER);
				
				//记录客户操作日志
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "合同提交审批","",customer.getUser());
			}
			
			//归档 初始化装饰信息表/////////////////////////END///////////////////////////
			////////////////////更新物流部核查装饰通知单/////////////////////////////
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "保存数据失败！");
			return ;		
		}
		if(editType==1){
			renderMsg("/customer/customerShoppingRecordqueryList", "保存订单数据成功！");
			return ;
		}
		if(editType==3){
			renderMsg("${ctx }/outboundOrder/editOutbound?customerId="+customerId+"&modifyType="+modifyType, "保存订单数据成功！");
			return ;
		}
		if(editType==2) {
			renderMsg("/orderContract/queryList", "保存订单数据成功！");
			return ;
		}
		//销售顾问处理系统遗留问题
		if(editType==4) {
			renderMsg("/customerPidBookingRecord/queryWatingList", "保存订单数据成功！");
			return ;
		}
		renderMsg("/customer/customerShoppingRecordqueryList", "保存订单数据成功！");
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
