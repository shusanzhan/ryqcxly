/**
 * 
 */
package com.ystech.cust.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.TurnCustomerRecord;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.TurnCustomerRecordManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.PositionManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

/**
 * @author shusanzhan
 * @date 2014-5-12
 */
@Component("turnCustomerRecordAction")
@Scope("prototype")
public class TurnCustomerRecordAction extends BaseController{
	private TurnCustomerRecordManageImpl turnCustomerRecordManageImpl;
	private UserManageImpl userManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private PositionManageImpl positionManageImpl;
	private DepartmentManageImpl departmentManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	@Resource
	public void setTurnCustomerRecordManageImpl(
			TurnCustomerRecordManageImpl turnCustomerRecordManageImpl) {
		this.turnCustomerRecordManageImpl = turnCustomerRecordManageImpl;
	}

	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setPositionManageImpl(PositionManageImpl positionManageImpl) {
		this.positionManageImpl = positionManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}



	private HttpServletRequest request = getRequest();
	/**
	 * 功能描述：转单记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			Page<TurnCustomerRecord> page = turnCustomerRecordManageImpl.pagedQuerySql(pageNo, pageSize,TurnCustomerRecord.class, "select * from cust_TurnCustomerRecord where operatorId="+currentUser.getDbid()+" order by createTime DESC", null);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：转单记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String querySaleDirectorList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			Page<TurnCustomerRecord> page = turnCustomerRecordManageImpl.pagedQuerySql(pageNo, pageSize,TurnCustomerRecord.class,  "select * from cust_TurnCustomerRecord where operatorId="+currentUser.getDbid()+" order by createTime DESC", null);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "saleDirectorList";
	}
	/**
	 * 功能描述：转单记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryLeaderList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		String operatorName = request.getParameter("operatorName");
		try{
			List params=new ArrayList();
			String sql="select * from cust_TurnCustomerRecord where 1=1 ";
			if(null!=operatorName&&operatorName.trim().length()>0){
				sql=sql+" and operatorName like ? ";
				params.add("%"+operatorName+"%");
			}
			sql=sql+" order by createTime DESC";
			Page<TurnCustomerRecord> page = turnCustomerRecordManageImpl.pagedQuerySql(pageNo, pageSize,TurnCustomerRecord.class,sql, params.toArray());
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderList";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			String departmentIds2 = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			List<User> users = userManageImpl.executeSql("select * from sys_user where  departmentId in ("+departmentIds2+")", null);
			request.setAttribute("users", users);
			if(dbid>0){
				List<Customer> customers = customerMangeImpl.findBy("bussiStaffId", dbid);
				request.setAttribute("customers", customers);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String addRoom() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				List<User> userSubs = userManageImpl.findBy("enterprise.dbid", enterprise.getDbid());
				request.setAttribute("users", userSubs);
			}else{
				List<User> userSubs = userManageImpl.findBy("department.dbid", currentUser.getDepartment().getDbid());
				request.setAttribute("users", userSubs);
			}
			
			if(dbid>0){
				List<Customer> customers = customerMangeImpl.findBy("bussiStaffId", dbid);
				request.setAttribute("customers", customers);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "addRoom";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String addSaleDirector() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			String departmentIds2 = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			List<User> users = userManageImpl.executeSql("select * from sys_user where  departmentId in ("+departmentIds2+")", null);
			request.setAttribute("users", users);
			if(dbid>0){
				List<Customer> customers = customerMangeImpl.findBy("bussiStaffId", dbid);
				request.setAttribute("customers", customers);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "addSaleDirector";
	}
	
	/**
	 * 功能描述：客户转单信息表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		Integer reBussiStaff = ParamUtil.getIntParam(request, "reBussiStaff", -1);
		Integer type = ParamUtil.getIntParam(request, "type", 0);
		Integer tarBussiStaff = ParamUtil.getIntParam(request, "tarBussiStaff", -1);
		Integer[] customerIds = ParamUtil.getIntArrayByIds(request, "customerIds");
		String customerNames = request.getParameter("customerNames");
		String note=request.getParameter("note");
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			User reBussiStaffUser = userManageImpl.get(reBussiStaff);
			User tarBussiStaffUser = userManageImpl.get(tarBussiStaff);
			//更改客户销售人员
			for (Integer dbid : customerIds) {
				Customer customer = customerMangeImpl.get(dbid);
				customer.setBussiStaff(tarBussiStaffUser.getRealName());
				customer.setUser(tarBussiStaffUser);
				customerMangeImpl.save(customer);
				
				List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid="+dbid+" AND taskDealStatus=1  AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE, null);
				if(null!=customerTracks&&!customerTracks.isEmpty()){
					CustomerTrack customerTrack = customerTracks.get(0);
					customerTrack.setUserId(tarBussiStaffUser.getDbid());
					customerTrackManageImpl.save(customerTrack);
				}
			}
			//保存转单记录信息
			TurnCustomerRecord customerRecord=new TurnCustomerRecord();
			String string = Arrays.toString(customerIds);
			customerRecord.setCustomerIds(string);
			customerRecord.setCustomerName(customerNames);
			customerRecord.setCreateTime(new Date());
			customerRecord.setNote(note);
			customerRecord.setOperatorId(currentUser.getDbid());
			customerRecord.setOperatorName(currentUser.getRealName());
			customerRecord.setReBussiStaff(reBussiStaffUser.getRealName());
			customerRecord.setTarBussiStaff(tarBussiStaffUser.getRealName());
			turnCustomerRecordManageImpl.save(customerRecord);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		 }
		if(type==0){
			renderMsg("/turnCustomerRecord/queryLeaderList", "保存数据成功！");
		}
		if(type==2){
			renderMsg("/turnCustomerRecord/queryList", "保存数据成功！");
		}
		if(type==3){
			renderMsg("/turnCustomerRecord/saleDirectorList", "保存数据成功！");
		}
		if(type==1){
			renderMsg("/turnCustomerRecord/add", "保存数据成功！");
		}
		if(type==4){
			renderMsg("/turnCustomerRecord/addRoom", "保存数据成功！");
		}
		if(type==5){
			renderMsg("/turnCustomerRecord/addSaleDirector", "保存数据成功！");
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
	public String view() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				TurnCustomerRecord turnCustomerRecord = turnCustomerRecordManageImpl.get(dbid);
				request.setAttribute("turnCustomerRecord", turnCustomerRecord);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "view";
	}
	/**
	 * 功能描述：取消客户转单
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void canncelTurn() throws Exception {
		HttpServletRequest request2 = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request2, "dbid", -1);
		try{
			TurnCustomerRecord turnCustomerRecord = turnCustomerRecordManageImpl.get(dbid);
			User reUser = userManageImpl.findUniqueBy("realName",turnCustomerRecord.getReBussiStaff());
			String customerIdStr = turnCustomerRecord.getCustomerIds().replace("[", "").replace("]","");
			String[] customerIds = customerIdStr.split(",");
			//更改客户销售人员
			for (String dbids : customerIds) {
				if(null!=dbids&&dbids.trim().length()>0){
					dbids=dbids.replaceAll(" ", "");
					int parseInt = Integer.parseInt(dbids);
					Customer customer = customerMangeImpl.get(parseInt);
					customer.setBussiStaff(reUser.getRealName());
					customer.setUser(reUser);
					customerMangeImpl.save(customer);
					
					List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid="+dbid+" taskDealStatus=1 AND   AND customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE, null);
					if(null!=customerTracks&&customerTracks.isEmpty()){
						CustomerTrack customerTrack = customerTracks.get(0);
						customerTrack.setUserId(reUser.getDbid());
						customerTrackManageImpl.save(customerTrack);
					}
				}
			}
			//保存转单记录信息
			turnCustomerRecordManageImpl.save(turnCustomerRecord);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/turnCustomerRecord/queryLeaderList", "撤销数据成功！");
		return ;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		Integer type = ParamUtil.getIntParam(request, "type", 0);
		try{
			if(null!=dbids&&dbids.length>0){
				try {
					for (Integer dbid : dbids) {
						turnCustomerRecordManageImpl.deleteById(dbid);
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
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		if(type==0){
			renderMsg("/turnCustomerRecord/queryLeaderList", "保存数据成功！");
		}
		if(type==2){
			renderMsg("/turnCustomerRecord/queryList", "保存数据成功！");
		}
		if(type==3){
			renderMsg("/turnCustomerRecord/saleDirectorList", "保存数据成功！");
		}
		if(type==1){
			renderMsg("/turnCustomerRecord/add", "保存数据成功！");
		}
		return;
	}
	/**
	 * 功能描述：根据用户Id查询客户信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerSelect() throws Exception {
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String startDate=request.getParameter("startDate");
		String endDate=request.getParameter("endDate");
		String sql="select * from  cust_Customer where 1=1 ";
		List param=new ArrayList();
		try{
			
			if(customerPhaseId>0){
				sql=sql+" and customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(userId>0){
				sql=sql+" and bussiStaffId=? ";
				param.add(userId);
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=startDate&&startDate.trim().length()>0){
				sql=sql+" and createFolderTime>='"+startDate+"'";
			}
			if(null!=endDate&&endDate.trim().length()>0){
				sql=sql+" and createFolderTime<? ";
				param.add(DateUtil.nextDay(endDate));
			}
			if(null!=startDate||null!=endDate){
				List<Customer> customers = customerMangeImpl.executeSql(sql,param.toArray());
				request.setAttribute("customers", customers);
			}
			
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		request.setAttribute("userId", userId);
		return "customerSelect";
	}
}
