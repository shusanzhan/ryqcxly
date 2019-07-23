/**
 * 
 */
package com.ystech.cust.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;

/**
 * @author shusanzhan
 * @date 2014-5-17
 */
@Component("paymentConfirmationAction")
@Scope("prototype")
public class PaymentConfirmationAction extends BaseController{
    private CustomerMangeImpl customerMangeImpl;
    private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
    private HttpServletRequest request=getRequest();
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	/**
	 * 功能描述：打印交款确认单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printPaymentConfirmation() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer = customerMangeImpl.get(customerId);
			OrderContract orderContract = customer.getOrderContract();
			request.setAttribute("orderContract", orderContract);
			request.setAttribute("customer", customer);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "printPaymentConfirmation";
	}
	/**
	 * 功能描述：打印交款确认单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printDecoreNotice() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			Customer customer = customerMangeImpl.get(customerId);
			if(null!=customer){
				request.setAttribute("customer",customer);
				CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
				request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
				
				CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
				request.setAttribute("customerLastBussi", customerLastBussi);
				
				OrderContract orderContract = customer.getOrderContract();
				request.setAttribute("orderContract", orderContract);
				
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", orderContract.getDbid());
				if(null!=orderContractDecores&&orderContractDecores.size()>0){
					request.setAttribute("orderContractDecore", orderContractDecores.get(0));
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "printDecoreNotice";
	}
}	
