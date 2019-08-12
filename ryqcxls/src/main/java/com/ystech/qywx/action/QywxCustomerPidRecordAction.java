package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.ApprovalRecordPidBookingRecord;
import com.ystech.cust.model.CarVinCode;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerImageApproval;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingCancelRecord;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerPidCancel;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OrderContractDecore;
import com.ystech.cust.model.OrderContractExpenses;
import com.ystech.cust.model.TimeoutsTrackRecord;
import com.ystech.cust.service.ApprovalRecordPidBookingRecordManageImpl;
import com.ystech.cust.service.CarVinCodeManageImpl;
import com.ystech.cust.service.CustomerImageApprovalManageImpl;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerPidBookingCancelRecordManageImpl;
import com.ystech.cust.service.CustomerPidBookingRecordManageImpl;
import com.ystech.cust.service.CustomerPidCancelManageImpl;
import com.ystech.cust.service.OrderContractDecoreManageImpl;
import com.ystech.cust.service.OrderContractExpensesManageImpl;
import com.ystech.cust.service.OrderContractManageImpl;
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

@Component("qywxCustomerPidRecordAction")
@Scope("prototype")
public class QywxCustomerPidRecordAction extends BaseController{
	private CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CustomerPidCancelManageImpl customerPidCancelManageImpl;
	private ApprovalRecordPidBookingRecordManageImpl approvalRecordPidBookingRecordManageImpl;
	private OrderContractDecoreManageImpl orderContractDecoreManageImpl;
	private OrderContractExpensesManageImpl orderContractExpensesManageImpl;
	private OrderContractManageImpl orderContractManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl;
	private CarVinCodeManageImpl carVinCodeManageImpl;
	private UserManageImpl userManageImpl;
	private QywxSendMessageUtil qywxSendMessageUtil;
	private CustomerPidBookingCancelRecordManageImpl customerPidBookingCancelRecordManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarColorManageImpl carColorManageImpl;
	private BrandManageImpl brandManageImpl;
	private CustomerPidBookingRecord customerPidBookingRecord;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerImageApprovalManageImpl customerImageApprovalManageImpl;
	private HttpServletRequest request=getRequest();
	
	public CustomerPidBookingRecord getCustomerPidBookingRecord() {
		return customerPidBookingRecord;
	}
	public void setCustomerPidBookingRecord(
			CustomerPidBookingRecord customerPidBookingRecord) {
		this.customerPidBookingRecord = customerPidBookingRecord;
	}
	@Resource
	public void setCustomerPidBookingRecordManageImpl(
			CustomerPidBookingRecordManageImpl customerPidBookingRecordManageImpl) {
		this.customerPidBookingRecordManageImpl = customerPidBookingRecordManageImpl;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setCustomerPidCancelManageImpl(
			CustomerPidCancelManageImpl customerPidCancelManageImpl) {
		this.customerPidCancelManageImpl = customerPidCancelManageImpl;
	}
	@Resource
	public void setApprovalRecordPidBookingRecordManageImpl(
			ApprovalRecordPidBookingRecordManageImpl approvalRecordPidBookingRecordManageImpl) {
		this.approvalRecordPidBookingRecordManageImpl = approvalRecordPidBookingRecordManageImpl;
	}
	@Resource
	public void setQywxSendMessageUtil(QywxSendMessageUtil qywxSendMessageUtil) {
		this.qywxSendMessageUtil = qywxSendMessageUtil;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
	public void setOrderContractManageImpl(
			OrderContractManageImpl orderContractManageImpl) {
		this.orderContractManageImpl = orderContractManageImpl;
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
	public void setTimeoutsTrackRecordManageImpl(
			TimeoutsTrackRecordManageImpl timeoutsTrackRecordManageImpl) {
		this.timeoutsTrackRecordManageImpl = timeoutsTrackRecordManageImpl;
	}
	@Resource
	public void setCarVinCodeManageImpl(CarVinCodeManageImpl carVinCodeManageImpl) {
		this.carVinCodeManageImpl = carVinCodeManageImpl;
	}
	@Resource
	public void setCustomerPidBookingCancelRecordManageImpl(
			CustomerPidBookingCancelRecordManageImpl customerPidBookingCancelRecordManageImpl) {
		this.customerPidBookingCancelRecordManageImpl = customerPidBookingCancelRecordManageImpl;
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
	public void setCustomerImageApprovalManageImpl(
			CustomerImageApprovalManageImpl customerImageApprovalManageImpl) {
		this.customerImageApprovalManageImpl = customerImageApprovalManageImpl;
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
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			User sessionUser = getSessionUser();
			Enterprise enterprise = sessionUser.getEnterprise();
			Customer customer = customerMangeImpl.get(customerId);
			
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),-1);
			request.setAttribute("carSeriys", carSeriys);
			
			//车型
			CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
			if(customerLastBussi!=null){
				CarSeriy carSeriy = customerLastBussi.getCarSeriy();
				if(null!=carSeriy){
					List<CarModel> carModels = carModelManageImpl.findBy("carseries.dbid",carSeriy.getDbid());
					request.setAttribute("carModels", carModels);
					
					List<CarColor> carColors = carColorManageImpl.findBy("carseries.dbid", carSeriy.getDbid());
					request.setAttribute("carColors", carColors);
				}
			}
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			
			CustomerPidBookingCancelRecord customerPidBookingCancelRecord = customerPidBookingCancelRecordManageImpl.findUniqueBy("customerId",customerId);
			request.setAttribute("customerPidBookingCancelRecord", customerPidBookingCancelRecord);
			
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}

	/**
	 * 功能描述：编辑交车预约记录
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustomerPidBookingRecord customerPidBookingRecord2 = customerPidBookingRecordManageImpl.get(dbid);
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			
			List<CarModel> carModels = carModelManageImpl.getAll();
			request.setAttribute("carModels", carModels);
			
			request.setAttribute("customer", customerPidBookingRecord2.getCustomer());
		}
		return "edit";
	}
	/**
	 * 功能描述：更新交车预约记录表
	 * 参数描述： 
	 * 逻辑描述：交车预约记录在打印合同时就生成（orderContractAction），
	 * 此处是对交车预约记录数据进行编辑；更新最终能交车记录的交车信息（CustomerLastBussi），CustomerBussi表
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		String orderDate = request.getParameter("customerPidBookingRecord.orderDate");
	    Date modifyTime = ParamUtil.getDateParam(request, "customerPidBookingRecord.modifyTime", "yyyy-MM-dd");
	    //车型信息
	    Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
	    Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
	    Integer carColorId = ParamUtil.getIntParam(request, "carColorId", -1);
	    Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		try{
				User sessionUser = getSessionUser();
				Enterprise enterprise = sessionUser.getEnterprise();
				if(brandId>0){
					Brand brand = brandManageImpl.get(brandId);
					customerPidBookingRecord.setBrand(brand);
				}
				if(carSeriyId>0){
					CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
					customerPidBookingRecord.setCarSeriy(carSeriy);
				}
				//车型信息
				if(carModelId>0){
					CarModel carModel = carModelManageImpl.get(carModelId);
					customerPidBookingRecord.setCarModel(carModel);
				}
				//车型信息
				if(carColorId>0){
					CarColor carColor = carColorManageImpl.get(carColorId);
					customerPidBookingRecord.setCarColor(carColor);
				}
				//先获取合同流失记录交车预约创建日期
				CustomerPidBookingCancelRecord customerPidBookingCancelRecord = customerPidBookingCancelRecordManageImpl.findUniqueBy("customerId",customerId);
				request.setAttribute("customerPidBookingCancelRecord", customerPidBookingCancelRecord);
				//初始化时间
				if(null==customerPidBookingCancelRecord){
					customerPidBookingRecord.setCreateTime(new Date());
				}else{
					customerPidBookingRecord.setCreateTime(customerPidBookingCancelRecord.getBookingDate());
				}
		    	customerPidBookingRecord.setModifyTime(modifyTime);
			    
				Customer customer = customerMangeImpl.get(customerId);
				//初始化交车预约未创建
				customerPidBookingRecord.setPidStatus(CustomerPidBookingRecord.FINISHED);
				//设置跨店销售为默认正常状态
				customerPidBookingRecord.setKdStatus(CustomerPidBookingRecord.KDCOMM);
				//设置回访状态
				customerPidBookingRecord.setHfStatus(CustomerPidBookingRecord.HFWATING);
				customerPidBookingRecord.setOutStockCheckStatus(CustomerPidBookingRecord.OUTCHECKDEFAULT);
				customerPidBookingRecord.setCustomer(customer);

				//设置物流信息为提交
				customerPidBookingRecord.setWlStatus(CustomerPidBookingRecord.WLDEALED);
				customerPidBookingRecord.setOrderDate(DateUtil.stringDateWithHHMM(orderDate));
				customerPidBookingRecord.setPidStatus(CustomerPidBookingRecord.FINISHED);
				customerPidBookingRecord.setHfStatus(CustomerPidBookingRecord.HFWATING);
				//归档日期
				customerPidBookingRecord.setCwDate(new Date());
				customerPidBookingRecord.setCartrialerWlStatus(CustomerPidBookingRecord.WLDEALED);
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord);
				//删除重复数据
				customerPidBookingRecordManageImpl.deleteDuplicateDataByCustomerId(customerId);
				
				if(null!=customer&&customer.getDbid()>0){
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "F");
					customer.setCustomerPhase(customerPhase);
					User user = customer.getUser();
					//跟新销售顾问的所在部门
					User user2 = userManageImpl.get(user.getDbid());
					customer.setSuccessDepartment(user2.getDepartment());
				}
				customerMangeImpl.save(customer);
				
				
				//归档初始化 图片上传表
				Integer customerType = customer.getRecordType();
				if(customerType==(int)Customer.CUSTOMERTYPECOMM){
					CustomerImageApproval cApproval = customerImageApprovalManageImpl.findUniqueBy("customer.dbid", customer.getDbid());
					if(null==cApproval){
						CustomerImageApproval customerImageApproval=new CustomerImageApproval();
						customerImageApproval.setCustomer(customer);
						customerImageApproval.setDrivingApproval(null);
						customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSCOMM);
						customerImageApproval.setHandCarApproval(null);
						customerImageApproval.setHandCarStatus(CustomerImageApproval.UPLOADSTATSCOMM);
						customerImageApproval.setStatus(CustomerImageApproval.STATUSCOMM);
						customerImageApprovalManageImpl.save(customerImageApproval);
					}
				}
				
				//发送微信消息
				String url="/qywxCustomer/customerDetail?customerId="+customer.getDbid();
				String carName="";
				if(enterprise.getBussiType()==3){
					carName=customerPidBookingRecord.getBrand().getName()+""+customerPidBookingRecord.getCarSeriy().getName()+""+
							customerPidBookingRecord.getCarModel().getName()+""+customer.getCarColorStr();
				}
				if(enterprise.getBussiType()!=3){
					carName=customerPidBookingRecord.getBrand().getName()+""+customerPidBookingRecord.getCarSeriy().getName()+""+
							customerPidBookingRecord.getCarModel().getName()+""+customerPidBookingRecord.getCarColor().getName();
				}
				String dis="";
				if(null!=customer.getDepartment()){
					dis=customer.getDepartment().getName();
				}
				if(null!=customer.getUser()){
					dis=dis+"["+customer.getUser().getRealName()+"]";
				}
				dis=dis+"提报交车预约，预约车型："+carName;
				
				//qywxSendMessageUtil.sendMessagePart(url, dis, "交车预约申请处理通知", request);
				customerOperatorLogManageImpl.saveCustomerOperatorLog(customerId, "客户归档成功", dis);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomer/orderCustomer", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：总/副总理审批（合同流失审批）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String generalManagerList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where   cpid.customerId=cu.dbid  ";
			List param= new ArrayList();
			sql=sql+" and cpid.pidStatus = ? ";
			sql=sql+" order by cpid.pidStatus DESC,cpid.createTime DESC limit 5";
			
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			request.setAttribute("customers", customers);
			String countSql = StringUtils.substringBefore(sql, "order by");
			long count = customerMangeImpl.countSqlResult(sql,param.toArray());
			request.setAttribute("count", count);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "generalManagerList";
	}
	/**
	 * 功能描述：展厅经理（合同流失审批）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String roomManagerList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where   cpid.customerId=cu.dbid ";
			List param= new ArrayList();
			sql=sql+" and cpid.pidStatus = ? ";
			sql=sql+" order by cpid.pidStatus DESC,cpid.createTime DESC limit 5";
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			request.setAttribute("customers", customers);
			String countSql = StringUtils.substringBefore(sql, "order by");
			long count = customerMangeImpl.countSqlResult(sql,param.toArray());
			request.setAttribute("count", count);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "roomManagerList";
	}
	/**
	 * 功能描述：销售副总审批页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String approvalRoomManager() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Customer customer = customerMangeImpl.get(dbid);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			if(customerPidBookingRecord2.getPidStatus()>3){
				request.setAttribute("message", customer.getName()+"已经审批完成，请勿重复审批！");
				request.setAttribute("url","/qywxCustomerPidRecord/saleManagerList");
				return "error";
			}
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			
			List<CustomerPidCancel> customerPidCancels = customerPidCancelManageImpl.findBy("customerPidBookingRecord.dbid",customerPidBookingRecord2.getDbid());
			request.setAttribute("customerPidCancels", customerPidCancels);
			if(null!=customerPidCancels&&customerPidCancels.size()>0){
				int size = customerPidCancels.size();
				request.setAttribute("customerPidCancel", customerPidCancels.get(size-1));
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "approvalRoomManager";
	}
	/**
	 * 功能描述：展厅经理（合同流失审批）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String saleManagerList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid where   cpid.customerId=cu.dbid ";
			List param= new ArrayList();
			sql=sql+" and cpid.pidStatus = ? ";
			sql=sql+" order by cpid.pidStatus DESC,cpid.createTime DESC limit 5";
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			request.setAttribute("customers", customers);
			String countSql = StringUtils.substringBefore(sql, "order by");
			long count = customerMangeImpl.countSqlResult(sql,param.toArray());
			request.setAttribute("count", count);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "saleManagerList";
	}
	/**
	 * 功能描述：展厅经理 审批合同流失
	 * 参数描述：
	 * 逻辑描述：1、首先更新交车预约信息表的状态；
	 * 			 2、保存审批信息记录表
	 * @return
	 * @throws Exception
	 */
	public void saveRoomApprovalOrder() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer customerPidCancelId = ParamUtil.getIntParam(request, "customerPidCancelId", -1);
		Integer pidStatus = ParamUtil.getIntParam(request, "pidStatus", -1);
		String sugg = request.getParameter("sugg");
		User currentUser = getSessionUser();
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				customerPidBookingRecord2.setPidStatus(pidStatus);
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
				
				//合同流失申请记录
				CustomerPidCancel customerPidCancel = customerPidCancelManageImpl.get(customerPidCancelId);
				
				ApprovalRecordPidBookingRecord approvalRecordPidBookingRecord=new ApprovalRecordPidBookingRecord();
				if(null!=currentUser){
					approvalRecordPidBookingRecord.setApprovalId(currentUser.getDbid());
					approvalRecordPidBookingRecord.setApprovalName(currentUser.getRealName());
				}
				approvalRecordPidBookingRecord.setApprovalTime(new Date());
				approvalRecordPidBookingRecord.setCustomerPidCancel(customerPidCancel);
				approvalRecordPidBookingRecord.setResult(pidStatus);
				approvalRecordPidBookingRecord.setSugg(sugg);
				approvalRecordPidBookingRecordManageImpl.save(approvalRecordPidBookingRecord);
				
				//发送合同流失 微信通知信息
				sendMessage(pidStatus, customerPidBookingRecord2);
				
			}else{
				renderErrorMsg(new Throwable("请选择操作数据！"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomerPidRecord/roomManagerList", "保存信息成功！");
		return ;
	}
	/**
	 * 功能描述：总经理审批页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String approvalGeneralManager() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Customer customer = customerMangeImpl.get(dbid);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			if(null==customerPidBookingRecord2){
				request.setAttribute("message", customer.getName()+"已经审批完成，请勿重复审批！");
				request.setAttribute("url","/qywxCustomerPidRecord/generalManagerList");
				return "error";
			}
			/*if(customerPidBookingRecord2.getPidStatus()==CustomerPidBookingRecord.XIAOSFZSBMIT){
				request.setAttribute("customer", customer);
				request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
				request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
				
				List<CustomerPidCancel> customerPidCancels = customerPidCancelManageImpl.findBy("customerPidBookingRecord.dbid",customerPidBookingRecord2.getDbid());
				request.setAttribute("customerPidCancels", customerPidCancels);
				if(null!=customerPidCancels&&customerPidCancels.size()>0){
					int size = customerPidCancels.size();
					request.setAttribute("customerPidCancel", customerPidCancels.get(size-1));
				}
			}else{
				request.setAttribute("message", customer.getName()+"已经审批完成，请勿重复审批！");
				request.setAttribute("url","/qywxCustomerPidRecord/generalManagerList");
				return "error";
			}*/
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "approvalGeneralManager";
	}
	/**
	 * 功能描述：总经理合同审批记录信息
	 * 参数描述：
	 * 逻辑描述：
	 * 1、首先更新交车预约信息表的状态；
	 * 2、保存审批信息记录表
	 * 3、如果有车订单则释放车架号
	 * 4、释放车架号同时提醒物流部
	 * @return
	 * @throws Exception
	 */
	public void saveApprovalGeneralManager() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer pidStatus = ParamUtil.getIntParam(request, "pidStatus", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String sugg = request.getParameter("sugg");
		User currentUser = getSessionUser();
		Integer customerPidCancelId = ParamUtil.getIntParam(request, "customerPidCancelId", -1);
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				customerPidBookingRecord2.setPidStatus(pidStatus);
				customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
				
				//合同申请记录
				CustomerPidCancel customerPidCancel = customerPidCancelManageImpl.get(customerPidCancelId);
				
				ApprovalRecordPidBookingRecord approvalRecordPidBookingRecord=new ApprovalRecordPidBookingRecord();
				approvalRecordPidBookingRecord.setApprovalId(currentUser.getDbid());
				approvalRecordPidBookingRecord.setApprovalName(currentUser.getRealName());
				approvalRecordPidBookingRecord.setApprovalTime(new Date());
				approvalRecordPidBookingRecord.setCustomerPidCancel(customerPidCancel);
				approvalRecordPidBookingRecord.setResult(pidStatus);
				approvalRecordPidBookingRecord.setSugg(sugg);
				approvalRecordPidBookingRecordManageImpl.save(approvalRecordPidBookingRecord);
				
				//总经理同意合同流失，情况该客户的所有信息
				/*if((int)pidStatus==(int)CustomerPidBookingRecord.APPROVALSUCCESS){
					//删除合同信息
					cancelContract(customerId);
				}*/
				
				//发送合同流失 微信通知信息
				sendMessage(pidStatus, customerPidBookingRecord2);
			}else{
				renderErrorMsg(new Throwable("请选择操作数据！"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomerPidRecord/generalManagerList", "保存信息成功！");
		return ;
	}
	/***
	 * 发送订单审批结果通知
	 * @param status
	 * @param orderContract
	 * @throws Exception
	 */
	private void sendMessage(Integer status,CustomerPidBookingRecord customerPidBookingRecord) throws Exception{
		HttpServletRequest request = this.getRequest();
		if(null==customerPidBookingRecord){
			return ;
		}
		Customer customer = customerPidBookingRecord.getCustomer();
		if(null==customer){
			return ;
		}
		String toUserParam = customerPidBookingRecord.getCustomer().getUser().getUserId();
		String url="/qywxCustomer/customerDetail?customerId="+customer.getDbid();
		String dis="";
		String type="";
		if(status==7){
			dis="展厅经理驳回"+customer.getName()+"合同流失申请";
			type="合同流失审批驳回通知";
		}
		if(status==4){
			dis="展厅经理同意"+customer.getName()+"合同流失申请";
			type="合同流失审批同意通知";
			
			//合同流失消息通知总经理
			String url2="/qywxCustomerPidRecord/approvalGeneralManager?dbid="+customer.getDbid();
			String des2=customer.getDepartment().getName()+"["+customer.getBussiStaff()+"]发起合同流失，请尽快处理。";
			qywxSendMessageUtil.sendMessageSingle(null,url2,des2,"合同流失总经理审批通知",request);
		}
		if(status==5){
			dis="总/副总经理同意"+customer.getName()+"合同流失申请。";
			type="合同流失审批同意通知";
			
			//合同流失消息通知物流部
			String url2="/qywxCustomer/customerDetail?customerId="+customer.getDbid();
			String des2="";
			if(null!=customerPidBookingRecord.getVinCode()&&customerPidBookingRecord.getVinCode().trim().length()>0){
				des2=customer.getDepartment().getName()+"["+customer.getBussiStaff()+"]发起合同流失，总/副总经理审批已经完成，车架号【"+customerPidBookingRecord.getVinCode()+"】自动释放";
				qywxSendMessageUtil.sendMessageSingle(null,url2,des2,"合同流失释放车架号通知",request);
			}
		}
		if(status==6){
			dis="总/副总经理驳回"+customer.getName()+"合同申请";
			type="合同流失审批驳回通知";
		}
		qywxSendMessageUtil.sendMessageSingle(toUserParam, url, dis, type, request);
	}
	/**
	 * 功能描述：取消合同
	 * 参数描述：customerId
	 * 逻辑描述：根据customerId获取客户信息，
	 * 1、删除客户成交结果信息
	 * 2、订单信息
	 * 3、订单商品信息
	 * 4、订单审批信息
	 * 5、交车预约信息
	 * 6、合同流失审批记录
	 * 7、交款确认单
	 * 8、装饰确认单
	 * 9、修改追踪记录 
	 * 10、释放车架号factoryOrder
	 * 通过客户信息获取交车信息，
	 * 交车申请审批信息，
	 * 交车审批记录信息。取消合同删除交车预约记录、审批记录
	 * @return
	 * @throws Exception
	 */
	private void cancelContract(Integer customerId) throws Exception {
		User currentUser = getSessionUser();
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				//最终成交结果
				CustomerLastBussi customerLastBussi = customer.getCustomerLastBussi();
				if(null!=customerLastBussi){
					customerLastBussiManageImpl.delete(customerLastBussi);
				}
				//订单信息  自动级联删除订单商品信息、订单审批记录
				OrderContract orderContract = customer.getOrderContract();
				if(null!=orderContract){
					//删除费用明细
					List<OrderContractExpenses> orderContractExpenses = orderContractExpensesManageImpl.findBy("customer.dbid", customer.getDbid());
					if(null!=orderContractExpenses){
						for (OrderContractExpenses orderContractExpenses2 : orderContractExpenses) {
							orderContractExpensesManageImpl.delete(orderContractExpenses2);
						}
					}
					orderContractManageImpl.delete(orderContract);
				}
				//删除加装装饰信息
				List<OrderContractDecore> orderContractDecores = orderContractDecoreManageImpl.findBy("orderContract.dbid", orderContract.getDbid());
				if(null!=orderContractDecores&&orderContractDecores.size()>0){
					for (OrderContractDecore orderContractDecore : orderContractDecores) {
						orderContractDecoreManageImpl.delete(orderContractDecore);
					}
				}
				
				//代交车记录 删除交车记录、交车审批记录
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				if(null!=customerPidBookingRecord2){
					//删除客户交车预约记录信息
					customerPidBookingRecordManageImpl.delete(customerPidBookingRecord2);
				}
				
				
				//修改订单状态为新添加  修改客户状态信息
				customer.setOrderContractStatus(Customer.ORDERNOT);
				customer.setLastResult(Customer.NORMAL);
				CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name","A");
				customer.setCustomerPhase(customerPhase);
				customerMangeImpl.save(customer);
				
				//追踪超时记录 合同流失状态修改
				TimeoutsTrackRecord timeoutsTrackRecord = customer.getTimeoutsTrackRecord();
				if(null!=timeoutsTrackRecord&&timeoutsTrackRecord.getDbid()>0){
					timeoutsTrackRecord.setIsContrackReturn(true);
					timeoutsTrackRecord.setContrackReturnDate(new Date());
					timeoutsTrackRecordManageImpl.save(timeoutsTrackRecord);
				}
			}else{
				System.out.println("请选择取消合同数据！");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			return ;
		}
		System.out.println("取消合同成功！");
		return ;
	}
	/**
	 * 功能描述：合同流失申请页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String orderContractCancel() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			Customer customer = customerMangeImpl.get(customerId);
			CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "orderContractCancel";
	}
	/**
	 * 功能描述：保存订合同流失申请记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOrderContractCancel() throws Exception {
		Integer dbid=customerPidBookingRecord.getDbid();
		String cancelNote = request.getParameter("cancelNote");
		User sessionUser = getSessionUser();
		try{
			 if(null!=dbid){
				 CustomerPidBookingRecord customerPidBookingRecord2 = customerPidBookingRecordManageImpl.get(dbid);
				    customerPidBookingRecord2.setPidStatus(CustomerPidBookingRecord.STATUSWATING);
				  //设置跨店销售为默认正常状态
					customerPidBookingRecord.setKdStatus(CustomerPidBookingRecord.KDCOMM);
				    //合同流失申请 修改交车合同状态
				    customerPidBookingRecordManageImpl.save(customerPidBookingRecord2);
				    
				    //合同流失申请记录信息
				    CustomerPidCancel customerPidCancel=new CustomerPidCancel();
				    customerPidCancel.setCreateDate(new Date());
				    customerPidCancel.setCustomerPidBookingRecord(customerPidBookingRecord2);
				    customerPidCancel.setNote(cancelNote);
				    customerPidCancelManageImpl.save(customerPidCancel);
				    
				    //保存客户合同流失日志
				    customerOperatorLogManageImpl.saveCustomerOperatorLog(customerPidBookingRecord2.getCustomer().getDbid(), "客户合同流失申请", "",sessionUser);
				    
				  //发送微信消息
				    String url="/qywxCustomerPidRecord/approvalSaleManager?dbid="+customerPidBookingRecord2.getCustomer().getDbid();
					String des=sessionUser.getDepartment().getName()+"["+ sessionUser.getRealName()+"]发起合同流失，请尽快处理。";
					qywxSendMessageUtil.sendMessagePart(url,des,"合同流失审批通知",request);
			 }else{
				 renderErrorMsg(new Throwable("请选择操作数据"), "");
				 return ;
			 }
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/qywxCustomer/waitingHandCar", "申请发送成功!");
		return ;
	}
	/**
	 * 功能描述：撤销归档客户
	 * 参数描述：customerId
	 * 逻辑描述：通过customerId设置客户状态为归档
	 * @return
	 * @throws Exception
	 */
	public void cancelCustomerFile() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		User currentUser = getSessionUser();
		try{
				if(customerId<0){
					renderErrorMsg(new Throwable("请选撤销择归档数据！"), "");
					return ;
				}
				
				List<CustomerPidBookingRecord> customerPidBookingRecords = customerPidBookingRecordManageImpl.findBy("customer.dbid",customerId);
				if(null==customerPidBookingRecords||customerPidBookingRecords.isEmpty()){
					renderErrorMsg(new Throwable("请选撤销择归档数据！"), "");
					return ;
				}
				
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				String vinCode = customerPidBookingRecord2.getVinCode();
				
				if(null!=customer&&customer.getDbid()>0){
					CustomerPhase customerPhase = customerPhaseManageImpl.findUniqueBy("name", "O");
					customer.setCustomerPhase(customerPhase);
					customer.setKdStatus(Customer.KDCOMM);
					customer.setDmsStatus(Customer.DMSCOMM);
					customer.setSourceEnterprise(null);
				}
				customerMangeImpl.save(customer);
				
				customerPidBookingRecordManageImpl.delete(customerPidBookingRecord2);
				//推荐客户修改状态为客户流失
				RecommendCustomer recommendCustomer = customer.getRecommendCustomer();
				if(null!=recommendCustomer){
					recommendCustomer.setTradeStatus(RecommendCustomer.TRADECOMM);
					recommendCustomerManageImpl.save(recommendCustomer);
					saveAgentOperatorLog("推荐客户撤销客户档案", "推荐客户撤销客户档案", customerId, currentUser);
				}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/qywxCustomer/successCustomer"+query, "客户撤销归档成功！");
		return ;
	}
	/**
	 * 功能描述：查看审批记录
	 * 参数描述：根据customerID
	 * 逻辑描述：根据customerId获取会员信息交车记录申请信息；查询审批记录信息
	 * @return
	 * @throws Exception
	 */
	public String approvalDetail() throws Exception {
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				Customer customer = customerMangeImpl.get(customerId);
				CustomerPidBookingRecord customerPidBookingRecord2 = customer.getCustomerPidBookingRecord();
				if(null!=customerPidBookingRecord2){
					/*List<ApprovalRecordPidBookingRecord> approvalRecordPidBookingRecords = approvalRecordPidBookingRecordManageImpl.findBy("customerPidBookingRecord.dbid",customerPidBookingRecord2.getDbid());
					request.setAttribute("approvalRecordPidBookingRecords", approvalRecordPidBookingRecords);*/
					
					List<CustomerPidCancel> customerPidCancels = customerPidCancelManageImpl.findBy("customerPidBookingRecord.dbid",customerPidBookingRecord2.getDbid());
					request.setAttribute("customerPidCancels", customerPidCancels);
				}
				request.setAttribute("customer", customer);
				request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
				request.setAttribute("customerPidBookingRecord", customerPidBookingRecord2);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "approvalDetail";
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
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	@Resource
	public void setAgentOperatorLogManageImpl(
			AgentOperatorLogManageImpl agentOperatorLogManageImpl) {
		this.agentOperatorLogManageImpl = agentOperatorLogManageImpl;
	}
	
}
