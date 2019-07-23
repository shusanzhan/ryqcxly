package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentOperatorLog;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentOperatorLogManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.service.CustomerLastBussiManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;

@Component("qywxCustomerOutFlowAction")
public class QywxCustomerOutFlowAction extends BaseController{
	private CustomerMangeImpl customerMangeImpl;
	private CustomerLastBussiManageImpl customerLastBussiManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private AgentOperatorLogManageImpl agentOperatorLogManageImpl;
	private CustomerTractUtile customerTractUtile;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
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
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
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
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String outFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User user = getSessionUser();
			String sql="select * from cust_Customer as cu,cust_CustomerLastBussi as clb  where  clb.customerId=cu.dbid and cu.lastResult>? AND clb.approvalStatus=? ";
			String currentDepIds = departmentManageImpl.getDepartmentIds(user.getDepartment());
			if(user.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+user.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
			}
			List param= new ArrayList();
			param.add(Customer.SUCCESS);
			param.add(CustomerLastBussi.APPROVALWATING);
			sql=sql+"order by clb.approvalStatus,cu.createFolderTime";
			List<Customer> customers = customerMangeImpl.executeSql(sql, param.toArray());
			request.setAttribute("customers", customers);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "outFlow";
	}
	/**
	 * 功能描述：流失客户查看明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String outFlowDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Customer customer = customerMangeImpl.get(dbid);
			request.setAttribute("customer", customer);
			request.setAttribute("customerLastBussi", customer.getCustomerLastBussi());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "outFlowDetail";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveOutFlow() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
			//1、审批同意；2、驳回
			Integer lastResult = ParamUtil.getIntParam(request, "lastResult", -1);
			Integer type = ParamUtil.getIntParam(request, "type", -1);
			String notReason = request.getParameter("notReason");
			User currentUser = getSessionUser();
			try{
				if(customerId>0){
					Customer customer = customerMangeImpl.get(customerId);
					CustomerLastBussi customerLastBussi2 = customer.getCustomerLastBussi();
					customerLastBussi2.setApprovalDate(new Date());
					customerLastBussi2.setApprovalPersonId(currentUser.getDbid());
					customerLastBussi2.setApprovalPersonName(currentUser.getRealName());
					customerLastBussi2.setApprovalStatus(lastResult);
					//customerLastBussi2.setNotReason(notReason);
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
			renderMsg("/qywxCustomerOutFlow/outFlow", "审批成功！");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
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
