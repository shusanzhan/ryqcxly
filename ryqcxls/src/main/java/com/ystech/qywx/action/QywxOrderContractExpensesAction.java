package com.ystech.qywx.action;

import java.math.BigDecimal;
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
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.OrderContractExpensesChargeItem;
import com.ystech.cust.model.OrderContractExpensesPreferenceItem;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.OrderContractDecoreItemManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesChargeItemManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractExpensesPreferenceItemManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.set.model.CarModelSalePolicy;
import com.ystech.xwqr.set.model.ChargeItem;
import com.ystech.xwqr.set.model.LoanType;
import com.ystech.xwqr.set.model.PreferenceItem;
import com.ystech.xwqr.set.service.CarModelSalePolicyManageImpl;
import com.ystech.xwqr.set.service.ChargeItemManageImpl;
import com.ystech.xwqr.set.service.PreferenceItemManageImpl;

@Component("qywxOrderContractExpensesAction")
@Scope("prototype")
public class QywxOrderContractExpensesAction extends BaseController{
	private OrderContractManageImpl orderContractManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl;
	private ChargeItemManageImpl chargeItemManageImpl;
	private PreferenceItemManageImpl preferenceItemManageImpl;
	private OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private OrderContractExpenses orderContractExpenses;
	private HttpServletRequest request=this.getRequest();
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractDecoreItemManageImpl orderContractDecoreItemManageImpl;
	private CarModelSalePolicyManageImpl carModelSalePolicyManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	public OrderContractExpenses getOrderContractExpenses() {
		return orderContractExpenses;
	}
	public void setOrderContractExpenses(OrderContractExpenses orderContractExpenses) {
		this.orderContractExpenses = orderContractExpenses;
	}
	@Resource
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
	}
	@Resource
	public void setOrderContractExpensesManageImpl(
			OrderContractExpensesManageImpl orderContractExpensesManageImpl) {
		this.orderContractExpensesManageImpl = orderContractExpensesManageImpl;
	}
	@Resource
	public void setOrderContractExpensesPreferenceItemManageImpl(
			OrderContractExpensesPreferenceItemManageImpl orderContractExpensesPreferenceItemManageImpl) {
		this.orderContractExpensesPreferenceItemManageImpl = orderContractExpensesPreferenceItemManageImpl;
	}
	@Resource
	public void setOrderContractExpensesChargeItemManageImpl(
			OrderContractExpensesChargeItemManageImpl orderContractExpensesChargeItemManageImpl) {
		this.orderContractExpensesChargeItemManageImpl = orderContractExpensesChargeItemManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setChargeItemManageImpl(ChargeItemManageImpl chargeItemManageImpl) {
		this.chargeItemManageImpl = chargeItemManageImpl;
	}
	@Resource
	public void setOrderContractDecoreManageImpl(
			OrderContractDecoreManageImpl orderContractDecoreManageImpl) {
		this.orderContractDecoreManageImpl = orderContractDecoreManageImpl;
	}
	@Resource
	public void setPreferenceItemManageImpl(
			PreferenceItemManageImpl preferenceItemManageImpl) {
		this.preferenceItemManageImpl = preferenceItemManageImpl;
	}
	@Resource
	public void setOrderContractDecoreItemManageImpl(
			OrderContractDecoreItemManageImpl orderContractDecoreItemManageImpl) {
		this.orderContractDecoreItemManageImpl = orderContractDecoreItemManageImpl;
	}
	@Resource
	public void setCarModelSalePolicyManageImpl(
			CarModelSalePolicyManageImpl carModelSalePolicyManageImpl) {
		this.carModelSalePolicyManageImpl = carModelSalePolicyManageImpl;
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
	public String orderContractExpenses() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer editType = ParamUtil.getIntParam(request, "editType", -1);
		OrderContractExpenses orderContractExpenses=null;
		Integer bussiType=1;
		try{
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				if(null!=customer){
					request.setAttribute("customer",customer);
					OrderContract orderContract = customer.getOrderContract();
					request.setAttribute("orderContract", orderContract);
					List<OrderContractExpenses> orderContractExpenseses = orderContractExpensesManageImpl.findBy("customer.dbid", customerId);
					if(null!=orderContractExpenseses&&orderContractExpenseses.size()==1){
						orderContractExpenses = orderContractExpenseses.get(0);
						request.setAttribute("orderContractExpenses", orderContractExpenses);
						
						CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
						if(customerLastBussi!=null){
							//查询销售顾问的销售结算价
							if(null!=enterprise){
								CarModelSalePolicy carModelSalePolicy = carModelSalePolicyManageImpl.findUnique("from CarModelSalePolicy where carModel.dbid="+customerLastBussi.getCarModel().getDbid()+" and enterpriseId="+enterprise.getDbid(), null);
								request.setAttribute("carModelSalePolicy", carModelSalePolicy);
							}
						}
						
						
						List<OrderContractExpensesChargeItem> orderContractExpensesChargeItems = orderContractExpensesChargeItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
						request.setAttribute("orderContractExpensesChargeItems", orderContractExpensesChargeItems);
						List<OrderContractExpensesPreferenceItem> orderContractExpensesPreferenceItems = orderContractExpensesPreferenceItemManageImpl.findBy("ordercontractexpenses.dbid", orderContractExpenses.getDbid());
						request.setAttribute("orderContractExpensesPreferenceItems", orderContractExpensesPreferenceItems);
					}else{
						CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
						if(customerLastBussi!=null){
							//查询销售顾问的销售结算价
							if(null!=enterprise){
								CarModelSalePolicy carModelSalePolicy = carModelSalePolicyManageImpl.findUnique("from CarModelSalePolicy where carModel.dbid="+customerLastBussi.getCarModel().getDbid()+" and enterpriseId="+enterprise.getDbid(), null);
								request.setAttribute("carModelSalePolicy", carModelSalePolicy);
							}
						}
					}
					bussiType = customer.getBussiType();
				}
				request.setAttribute("editOrderContractExpenses", editType);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		if(bussiType==1){
			return "edit";
		}
		if(bussiType==2){
			return "trialer";
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
		Integer loanTypeId = ParamUtil.getIntParam(request2, "loanTypeId", -1);
		Integer customerId = null;
		//确定保持成功后页面是否跳转到订单列表页面，还是来店登记页面
		Integer editType = ParamUtil.getIntParam(request2, "editType", -1);
		Integer dbid=null;
		try{
			User sessionUser = getSessionUser();
			if(orderContractId<0){
				renderErrorMsg(new Throwable("请先提报订单信息！"),"");
				return ;
			}
			OrderContract orderContract = orderContractManageImpl.get(orderContractId);
			Customer customer = orderContract.getCustomer();
			customerId=customer.getDbid();
			if(orderContractExpenses.getDbid()==null||orderContractExpenses.getDbid()<0){
				orderContractExpenses.setOrderContract(orderContract);
				orderContractExpenses.setCustomer(customer);
				Double carGrofit = orderContractExpenses.getCarGrofit();
				orderContractExpenses.setCarGrofitPrice(carGrofit);
				Double totalGrofit = orderContractExpenses.getTotalGrofit();
				Double insGrofit = orderContractExpenses.getinsGrofit();
				orderContractExpenses.setInsMoneyGrofit(insGrofit);
				orderContractExpenses.setTotalGrofitPrice(totalGrofit);
				orderContractExpenses.setAjsxBase(Double.valueOf(0));
				orderContractExpenses.setInsMoney(Double.valueOf(0));
				orderContractExpenses.setInsMoneyBase(Double.valueOf(0));
				//保存收费项目明细
				orderContractExpensesManageImpl.save(orderContractExpenses);
				//删除重复数据
				orderContractExpensesManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				//保存优惠项目
				savePreferenceItemProduct(request2, orderContractExpenses);
				//保存收费项目
				saveChargeItemProduct(request2, orderContractExpenses);
				if(null!=orderContractExpenses.getOrderMoney()){
					orderContract.setOrderMoney(new BigDecimal(orderContractExpenses.getOrderMoney()));
				}
				if(null!=orderContractExpenses.getBigOrderMoney()){
					orderContract.setBigOrderMoney(orderContractExpenses.getBigOrderMoney());
				}
				orderContract.setTotalPrice(orderContractExpenses.getTotalPrice());
				orderContractManageImpl.save(orderContract);
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "创建合同费用明细", "创建合同费用明细",sessionUser);
			}else{
				//销售顾问编辑数据、或物流部编辑数据
				double oldeDecoreMoney =0;
				OrderContractExpenses orderContractExpenses2 = orderContractExpensesManageImpl.get(orderContractExpenses.getDbid());
				Double decoreMoney = orderContractExpenses2.getDecoreMoney();
				if(null!=decoreMoney){
					oldeDecoreMoney=decoreMoney.doubleValue();
				}
				Set<OrderContractExpensesChargeItem>  ordercontractexpenseschargeitems= orderContractExpenses2.getOrdercontractexpenseschargeitems();
				Set<OrderContractExpensesPreferenceItem>  orderContractExpensesPreferenceItems = orderContractExpenses2.getOrdercontractexpensespreferenceitems();
				//删除数据
				orderContractExpensesChargeItemManageImpl.deleteByOrderId(orderContractExpenses2.getDbid());
				orderContractExpensesPreferenceItemManageImpl.deleteByOrderId(orderContractExpenses2.getDbid());
				
				orderContractExpenses2.setBigOrderMoney(orderContractExpenses.getBigOrderMoney());
				orderContractExpenses2.setOrderMoney(orderContractExpenses.getOrderMoney());
				orderContractExpenses2.setSalePrice(orderContractExpenses.getSalePrice());
				orderContractExpenses2.setPreferentialTogether(orderContractExpenses.getPreferentialTogether());
				orderContractExpenses2.setTotalPrice(orderContractExpenses.getTotalPrice());
				orderContractExpenses2.setFjzje(orderContractExpenses.getFjzje());
				orderContractExpenses2.setSpecialPermNote(orderContractExpenses.getSpecialPermNote());
				orderContractExpenses2.setSpecialPermPrice(orderContractExpenses.getSpecialPermPrice());
				orderContractExpenses2.setDecoreMoney(orderContractExpenses.getDecoreMoney());
				orderContractExpenses2.setBuyCarType(orderContractExpenses.getBuyCarType());
				orderContractExpenses2.setAdvanceTotalPrice(orderContractExpenses.getAdvanceTotalPrice());
				orderContractExpenses2.setPayWay(orderContractExpenses.getPayWay());
				orderContractExpenses2.setAjsxf(orderContractExpenses.getAjsxf());
				orderContractExpenses2.setSfk(orderContractExpenses.getSfk());
				orderContractExpenses2.setLoanType(orderContractExpenses.getLoanType());
				orderContractExpenses2.setDaikuan(orderContractExpenses.getDaikuan());
				orderContractExpenses2.setRevenuePrice(orderContractExpenses.getRevenuePrice());
				orderContractExpenses2.setCarSalerPrice(orderContractExpenses.getCarSalerPrice());
				orderContractExpenses2.setCarActurePrice(orderContractExpenses.getCarActurePrice());
				orderContractExpenses2.setCashBenefit(orderContractExpenses.getCashBenefit());
				//设置初始值
				orderContractExpenses2.setDecoreCostMoney(orderContractExpenses.getDecoreCostMoney());
				orderContractExpenses2.setDecoreGrofitPrice(orderContractExpenses.getDecoreGrofitPrice());
				orderContractExpenses2.setOtherCostFeePrice(orderContractExpenses.getOtherCostFeePrice());
				orderContractExpenses2.setOtherFeePrice(orderContractExpenses.getOtherFeePrice());
				Double carGrofit = orderContractExpenses.getCarGrofit();
				orderContractExpenses2.setCarGrofitPrice(carGrofit);
				Double totalGrofit = orderContractExpenses.getTotalGrofit();
				orderContractExpenses2.setTotalGrofitPrice(totalGrofit);
				if(null==orderContractExpenses.getInsMoney()||orderContractExpenses.getInsMoney()<=0){
					Double insGrofit = orderContractExpenses.getinsGrofit();
					orderContractExpenses2.setInsMoneyGrofit(insGrofit);
				}
				orderContractExpenses2.setAjsxfGrofit(orderContractExpenses.getAjsxfGrofit());
				orderContractExpenses2.setNote(orderContractExpenses.getNote());
				orderContractExpenses2.setColorPrice(orderContractExpenses.getColorPrice());
				orderContractExpenses2.setMasterDecoreMoney(orderContractExpenses.getMasterDecoreMoney());
				orderContractExpenses2.setAttachDecoreMoney(orderContractExpenses.getAttachDecoreMoney());
				orderContractExpenses2.setNoWllowancePrice(orderContractExpenses.getNoWllowancePrice());

				orderContractExpenses2.setPaymentPer(orderContractExpenses.getPaymentPer());
				orderContractExpenses2.setTrailerPrice(orderContractExpenses.getTrailerPrice());
				orderContractExpenses2.setTrailerSalerPrice(orderContractExpenses.getTrailerSalerPrice());
				orderContractExpenses2.setPreInsMoney(orderContractExpenses.getPreInsMoney());
				orderContractExpenses2.setInsaranceRenewalDepositPrice(orderContractExpenses.getInsaranceRenewalDepositPrice());
				orderContractExpenses2.setLoanPaybackMonthMoney(orderContractExpenses.getLoanPaybackMonthMoney());
				orderContractExpenses2.setLoanPaymentInterest(orderContractExpenses.getLoanPaymentInterest());
				orderContractExpenses2.setLoanPaymentPrice(orderContractExpenses.getLoanPaymentPrice());
				orderContractExpenses2.setLoanPaymentTerm(orderContractExpenses.getLoanPaymentTerm());
				orderContractExpenses2.setLoanPaymentType(orderContractExpenses.getLoanPaymentType());
				orderContractExpenses2.setCarTotalPrice(orderContractExpenses.getCarTotalPrice());
				orderContractExpenses2.setActureCollectedPrice(orderContractExpenses.getActureCollectedPrice());
				orderContractExpenses2.setLowInvoicePrice(orderContractExpenses.getLowInvoicePrice());
				orderContractExpenses2.setLoanCarPrice(orderContractExpenses.getLoanCarPrice());

				orderContractExpensesManageImpl.save(orderContractExpenses2);
				
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "编辑合同费用明细", "编辑合同费用明细",sessionUser);
				//删除重复数据
				orderContractExpensesManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				//保存优惠项目
				savePreferenceItemProduct(request2, orderContractExpenses);
				//保存收费项目
				saveChargeItemProduct(request2, orderContractExpenses);
				if(null!=orderContractExpenses.getOrderMoney()){
					orderContract.setOrderMoney(new BigDecimal(orderContractExpenses.getOrderMoney()));
				}
				if(null!=orderContractExpenses.getBigOrderMoney()){
					orderContract.setBigOrderMoney(orderContractExpenses.getBigOrderMoney());
				}
				orderContract.setTotalPrice(orderContractExpenses.getTotalPrice());
				orderContractManageImpl.save(orderContract);
				
				double newDecoreMoney =0;
				if(null!=orderContractExpenses.getDecoreMoney()){
					newDecoreMoney=orderContractExpenses.getDecoreMoney().doubleValue();
				}
				//更新装饰总表数据，一是实收合计，二是折扣率
				if(newDecoreMoney!=oldeDecoreMoney){
					List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid",orderContract.getDbid());
					if(null!=orderContractDecores&&orderContractDecores.size()>0){
						OrderContractDecore orderContractDecore = orderContractDecores.get(0);
						orderContractDecore.setActurePrice(newDecoreMoney);
						Double decoreSaleTotalPrce = orderContractDecore.getDecoreSaleTotalPrce();
						if(newDecoreMoney<=0){
							orderContractDecore.setDecoreSaleTotalPrce(new Double(0));
						}
						if(null!=decoreSaleTotalPrce&&decoreSaleTotalPrce>0){
							Double zkl= newDecoreMoney/decoreSaleTotalPrce*100;
							orderContractDecore.setZkl(zkl.toString()+"%");
						}else{
							orderContractDecore.setZkl("0.0%");
						}
						orderContractDecoreManageImpl.save(orderContractDecore);
						
						//更新装饰通知单为赠送
						if(newDecoreMoney<=0){
							orderContractDecoreItemManageImpl.updateItemByOrderContractDecoreId(orderContractDecore.getDbid());
							orderContractDecoreManageImpl.updateOrderContractDecore(orderContractDecore.getDbid());
						}
						
						
					}
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "保存数据失败！");
			return ;		
		}
		renderMsg("/qywxOrderContractDecore/orderContractDecore?customerId="+customerId+"&editType="+editType, "保存数据成功,正在跳转到附加装饰通知单页面！");
		return ;
	}
	
	
	//保存收费明细
	private void saveChargeItemProduct(HttpServletRequest request2,
			OrderContractExpenses orderContractExpenses2) {
		String[] chargeItemDbids = request.getParameterValues("chargeItemDbid");
		String[] chargeItemPrices = request.getParameterValues("chargeItemPrice");
		String[] costPrices = request.getParameterValues("costPrice");
		String[] chargeItemNotes = request.getParameterValues("chargeItemNote");
		if(null!=chargeItemDbids&&chargeItemDbids.length>0){
			int length = chargeItemDbids.length;
			for (int i=0;i<length;i++) {
				String chargeItemDbid = chargeItemDbids[i];
				if((null==chargeItemDbid||chargeItemDbid.trim().length()<=0)){
					continue;
				}
				OrderContractExpensesChargeItem orderContractExpensesChargeItem=new OrderContractExpensesChargeItem();
				orderContractExpensesChargeItem.setOrdercontractexpenses(orderContractExpenses2);
				int chargeItemId = Integer.parseInt(chargeItemDbid);
				ChargeItem chargeItem = chargeItemManageImpl.get(chargeItemId);
				if(null!=chargeItem){
					orderContractExpensesChargeItem.setChargeItemId(chargeItem.getDbid());
					orderContractExpensesChargeItem.setChargeItemName(chargeItem.getName());
				}
				
				String chargeItemPrice = chargeItemPrices[i];
				if(null!=chargeItemPrice&&chargeItemPrice.trim().length()>0){
					orderContractExpensesChargeItem.setPrice(new Double(chargeItemPrice));
				}
				if(null!=costPrices&&costPrices.length>0){
					String costPrice = costPrices[i];
					if(null!=costPrice&&costPrice.trim().length()>0){
						orderContractExpensesChargeItem.setCostPrice(new Double(costPrice));
					}
				}
				
				String note = chargeItemNotes[i];
				if(null!=note&&note.trim().length()>0){
					orderContractExpensesChargeItem.setNote(note);
				}
				orderContractExpensesChargeItemManageImpl.save(orderContractExpensesChargeItem);
			}
		}
	}
	//保存优惠项目
	private void savePreferenceItemProduct(HttpServletRequest request2,
			OrderContractExpenses orderContractExpenses2) {
		String[] preferenceItemDbids = request.getParameterValues("preferenceItemDbid");
		String[] preferencePrices = request.getParameterValues("preferencePrice");
		String[] preferenceNotes = request.getParameterValues("preferenceNote");
		if(null!=preferenceItemDbids&&preferenceItemDbids.length>0){
			int length = preferenceItemDbids.length;
			for (int i=0;i<length;i++) {
				String preferenceItemDbid = preferenceItemDbids[i];
				if((null==preferenceItemDbid||preferenceItemDbid.trim().length()<=0)){
					continue;
				}
				OrderContractExpensesPreferenceItem	orderContractExpensesPreferenceItem=new OrderContractExpensesPreferenceItem();
				orderContractExpensesPreferenceItem.setOrdercontractexpenses(orderContractExpenses2);
				int preferenceItemId = Integer.parseInt(preferenceItemDbid);
				PreferenceItem preferenceItem = preferenceItemManageImpl.get(preferenceItemId);
				if(null!=preferenceItem){
					orderContractExpensesPreferenceItem.setPreferenceItemId(preferenceItem.getDbid());
					orderContractExpensesPreferenceItem.setPreferenceItemName(preferenceItem.getName());
				}
				
				String preferencePrice = preferencePrices[i];
				if(null!=preferencePrice&&preferencePrice.trim().length()>0){
					orderContractExpensesPreferenceItem.setPrice(new Double(preferencePrice));
				}
				
				String note = preferenceNotes[i];
				if(null!=note&&note.trim().length()>0){
					orderContractExpensesPreferenceItem.setNote(note);
				}
				orderContractExpensesPreferenceItemManageImpl.save(orderContractExpensesPreferenceItem);
				
			}
		}
	}
	
}
