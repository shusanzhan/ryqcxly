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
import com.ystech.core.excel.CustomerSalerTrackCountToExcel;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustMarketingAct;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerTrackCount;
import com.ystech.cust.service.CustMarketingActManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-24
 */
@Component("customerTrackAction")
@Scope("prototype")
public class CustomerTrackAction extends BaseController{
	private CustomerTractUtile customerTractUtile;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustomerTrack customerTrack;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private Customer customer;
	private CustomerMangeImpl customerMangeImpl;
	private DepartmentManageImpl departmentManageImpl;
	private UserManageImpl userManageImpl;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustMarketingActManageImpl custMarketingActManageImpl;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private CustomerSalerTrackCountToExcel customerSalerTrackCountToExcel;
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl;
	public CustomerTrack getCustomerTrack() {
		return customerTrack;
	}
	public void setCustomerTrack(CustomerTrack customerTrack) {
		this.customerTrack = customerTrack;
	}
	public CustomerTrackManageImpl getCustomerTrackManageImpl() {
		return customerTrackManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public CustomerMangeImpl getCustomerMangeImpl() {
		return customerMangeImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}
	@Resource
	public void setCustMarketingActManageImpl(
			CustMarketingActManageImpl custMarketingActManageImpl) {
		this.custMarketingActManageImpl = custMarketingActManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
	}
	@Resource
	public void setCustomerSalerTrackCountToExcel(
			CustomerSalerTrackCountToExcel customerSalerTrackCountToExcel) {
		this.customerSalerTrackCountToExcel = customerSalerTrackCountToExcel;
	}
	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
	public void setCustomerShoppingRecordManageImpl(
			CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl) {
		this.customerShoppingRecordManageImpl = customerShoppingRecordManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "static-access","rawtypes" })
	public String queryWaitingList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		SecurityUserHolder holder=new SecurityUserHolder();
		User currentUser = holder.getCurrentUser();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		String name = request.getParameter("name");
		String phone= request.getParameter("phone");
		String sql="select * from cust_customertrack as track,cust_Customer as cu where cu.dbid=track.customerId and  track.userId=? and track.taskDealStatus=? AND cu.lastResult<2 ";
		try{
			List param=new ArrayList();
			param.add(currentUser.getDbid());
			param.add(CustomerTrack.TASKDEALSTATUSCREATE);
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=phone&&phone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+phone+"%");
			}
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			sql=sql+"order by track.finishDate DESC";
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			Page<CustomerTrack> page= customerTrackManageImpl.pagedQuerySql(pageNo, pageSize, CustomerTrack.class, sql,param.toArray());
			List<CustomerTrack> result = page.getResult();
			Date date=new Date();
			for (CustomerTrack customerTrack : result) {
				int intervalDays = DateUtil.getTowIntervalDays(date,customerTrack.getNextReservationTime());
				customerTrack.setDayNum(intervalDays);
			}
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "waitingList";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "static-access","rawtypes" })
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		SecurityUserHolder holder=new SecurityUserHolder();
		User currentUser = holder.getCurrentUser();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer taskOverTimeStatus = ParamUtil.getIntParam(request, "taskOverTimeStatus", -1);
		Integer taskDealStatus = ParamUtil.getIntParam(request, "taskDealStatus", -1);
		String name = request.getParameter("name");
		String phone= request.getParameter("phone");
		String sql="select * from cust_customertrack as track,cust_Customer as cu where cu.dbid=track.customerId and  track.userId=? and track.taskDealStatus>=? ";
		try{
				List param=new ArrayList();
				param.add(currentUser.getDbid());
				param.add(CustomerTrack.TASKDEALSTATUSDEALED);
				if(null!=name&&name.trim().length()>0){
					sql=sql+" and cu.name like ? ";
					param.add("%"+name+"%");
				}
				if(null!=phone&&phone.trim().length()>0){
					sql=sql+" and cu.mobilePhone like ? ";
					param.add("%"+phone+"%");
				}
				if(customerPhaseId>0){
					sql=sql+" and cu.customerPhaseId=? ";
					param.add(customerPhaseId);
				}
				if(taskOverTimeStatus>0){
					sql=sql+" and track.taskOverTimeStatus=? ";
					param.add(taskOverTimeStatus);
				}
				if(taskDealStatus>0){
					sql=sql+" and track.taskDealStatus=? ";
					param.add(taskDealStatus);
				}
				sql=sql+"order by track.finishDate DESC";
				List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
				request.setAttribute("customerPhases", customerPhases);
				Page<CustomerTrack> page= customerTrackManageImpl.pagedQuerySql(pageNo, pageSize, CustomerTrack.class, sql,param.toArray());
				request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "static-access" })
	public String queryRoomManageList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer bussiStaffId = ParamUtil.getIntParam(request, "bussiStaffId", -1);
		Integer isNewlyAdd = ParamUtil.getIntParam(request, "isNewlyAdd", -1);
		String name = request.getParameter("name");
		String phone= request.getParameter("phone");
		String userName = request.getParameter("userName");
		Integer taskDealStatus = ParamUtil.getIntParam(request, "taskDealStatus", -1);
		Integer taskOverTimeStatus = ParamUtil.getIntParam(request, "taskOverTimeStatus", -1);
		try{
			
			
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			User currentUser = SecurityUserHolder.getCurrentUser();
			Department department = currentUser.getDepartment();
			String sql="select ct.createTime,ct.custMarketingActId,ct.customerId,ct.beforeCustomerPhaseId,ct.afterCustomerPhaseId,ct.dbid,"
					+ "ct.dealMethod,ct.feedBackResult,"
					+ "ct.hasDealed,ct.hasDealed,ct.isOverTime,ct.modifyTime,ct.nextReservationTime,ct.readStatus,ct.result,ct.salesDate,"
					+ "ct.salesManager,ct.salesNote,ct.salesReadStatus,ct.showroomManagerSuggested,ct.trackContent,ct.trackDate,ct.trackMethod,"
					+ "ct.trackType,ct.turnBackResult,ct.userId,ct.customerPhaseType,ct.taskCreateType,ct.taskFinishType,ct.taskCreateTime"
					+ ",ct.taskDealStatus,ct.taskOverTimeStatus,ct.taskOverTimeNum,ct.taskType,ct.finishDate,ct.taskOverTimeAssementState "
					+ "from "
					+ "cust_CustomerTrack as ct "
					+ "LEFT JOIN cust_customer AS cu ON ct.customerId=cu.dbid WHERE 1=1 ";
			sql=sql+" and ct.taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED;
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				selSql=selSql+" AND cu.enterpriseId="+enterprise.getDbid()+" ";
			}else{
				selSql=selSql+" AND cu.departmentId="+department.getDbid()+" ";
			}
			sql=sql+selSql;
			List param=new ArrayList();
			if(customerPhaseId>0){
				sql=sql+" and cu.customerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(taskDealStatus>0){
				sql=sql+" and ct.taskDealStatus=? ";
				param.add(taskDealStatus);
			}
			if(taskOverTimeStatus>0){
				sql=sql+" and ct.taskOverTimeStatus=? ";
				param.add(taskOverTimeStatus);
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=phone&&phone.trim().length()>0){
				sql=sql+"  and  cu.mobilePhone like ? ";
				param.add("%"+phone+"%");
			}
			sql=sql+" order by createFolderTime DESC";
			Page<CustomerTrack> page= customerTrackManageImpl.pagedQuerySql(pageNo, pageSize, CustomerTrack.class, sql,param.toArray());
			request.setAttribute("page", page);
			
			List<CustomerTrack> todayCustomerTracks = customerTrackManageImpl.findByLeaderTodayTrack(selSql,bussiStaffId);
			request.setAttribute("todayCustomerTracks", todayCustomerTracks);
			
			//审阅跟踪记录
			String waitingReadSql="select * from cust_customertrack as custtrack,Cust_customer AS cu " +
					" where "+
					" cu.dbid=custtrack.customerId AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+" AND custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED+
					" "+selSql+"  AND  custtrack.readStatus="+CustomerTrack.COMMON +" limit 10 ";
			
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSqlQuery(CustomerTrack.class, waitingReadSql, null).list();
			request.setAttribute("customerTracks", customerTracks);
			
			long waitingReadNum = customerTrackManageImpl.countSqlResult(waitingReadSql, null);
			request.setAttribute("waitingReadNum", waitingReadNum);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "roomManageList";
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "static-access" })
	public String queryLeaderList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String mobilePhone = request.getParameter("mobilePhone");
		String userName = request.getParameter("userName");
		String name = request.getParameter("name");
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer taskDealStatus = ParamUtil.getIntParam(request, "taskDealStatus", -1);
		Integer taskOverTimeStatus = ParamUtil.getIntParam(request, "taskOverTimeStatus", -1);
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
			
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			String currentDepIds = departmentManageImpl.getDepartmentIds(currentUser.getDepartment());
			
			
			//车系
			List<Brand> brands = brandManageImpl.findByEnterpriseId(enterprise.getDbid());
			request.setAttribute("brands", brands);
			//车系
			List<CarSeriy> carSeriys = carSeriyManageImpl.findByEnterpriseIdAndBrandId(enterprise.getDbid(),brandId);
			request.setAttribute("carSeriys", carSeriys);
			
			List<CarModel> carModels = carModelManageImpl.findByEnterpriseIdAndBrandIdAndCarSeriyId(enterprise.getDbid(),brandId,carSeriyId);
			request.setAttribute("carModels", carModels);
			
			String sql="select ct.createTime,ct.custMarketingActId,ct.customerId,ct.beforeCustomerPhaseId,ct.afterCustomerPhaseId,ct.dbid,"
					+ "ct.dealMethod,ct.feedBackResult,"
					+ "ct.hasDealed,ct.hasDealed,ct.isOverTime,ct.modifyTime,ct.nextReservationTime,ct.readStatus,ct.result,ct.salesDate,"
					+ "ct.salesManager,ct.salesNote,ct.salesReadStatus,ct.showroomManagerSuggested,ct.trackContent,ct.trackDate,ct.trackMethod,"
					+ "ct.trackType,ct.turnBackResult,ct.userId,ct.customerPhaseType,ct.taskCreateType,ct.taskFinishType,ct.taskCreateTime"
					+ ",ct.taskDealStatus,ct.taskOverTimeStatus,ct.taskOverTimeNum,ct.taskType,ct.finishDate,ct.taskOverTimeAssementState "
					+ "from "
					+ "cust_CustomerTrack as ct "
					+ "LEFT JOIN cust_customer AS cu ON ct.customerId=cu.dbid "
					+ "LEFT JOIN cust_customerbussi  AS cb ON cu.dbid=cb.customerId WHERE 1=1 ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cu.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				sql=sql+" and cu.departmentId in ("+currentDepIds+")";
			}
			List param=new ArrayList();
			if(customerPhaseId>0){
				sql=sql+" and ct.beforecustomerPhaseId=? ";
				param.add(customerPhaseId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and ct.createTime>= ? ";
				param.add(DateUtil.string2Date(startTime));
			}
			if(taskDealStatus>0){
				sql=sql+" and ct.taskDealStatus=? ";
				param.add(taskDealStatus);
			}
			if(taskOverTimeStatus>0){
				sql=sql+" and ct.taskOverTimeStatus=? ";
				param.add(taskOverTimeStatus);
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and ct.createTime< ? ";
				param.add(DateUtil.nextDay(endTime));
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=departmentIds&&departmentIds.trim().length()>0){
				sql=sql+" and departmentId in ("+departmentIds+")";
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+"  and  cu.mobilePhone=? ";
				param.add(mobilePhone);
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
			sql=sql+"order by ct.salesReadStatus,ct.createTime DESC";
			Page<CustomerTrack> page= customerTrackManageImpl.pagedQuerySql(pageNo, pageSize, CustomerTrack.class, sql,param.toArray());
			request.setAttribute("page", page);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderList";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		HttpServletRequest request = getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql("SELECT * FROM cust_customertrack where customerId=? and taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+"  ORDER BY createTime DESC LIMIT 1 ", new Object[]{customer2.getDbid()});
			if(null!=customerTracks&&customerTracks.size()>0){
				CustomerTrack customerTrack2 = customerTracks.get(0);
				request.setAttribute("customerTrack", customerTrack2);
			}else{
				//默认创建任务为15天
				Date addDay = DateUtil.addDay(new Date(), 15);
				CustomerTrack customerTrack=customerTractUtile.createOtherCustomerTask(customer2,addDay,currentUser);
				request.setAttribute("customerTrack", customerTrack);
			}
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CustMarketingAct> custMarketingActs = custMarketingActManageImpl.executeSql("SELECT * FROM cust_marketingact WHERE DATE_FORMAT(NOW(),'%y-%m-%d')>=actStartDate AND actEndDate>=DATE_FORMAT(NOW(),'%y-%m-%d') and enterpriseId="+enterprise.getDbid(), null);
			request.setAttribute("custMarketingActs", custMarketingActs);
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
	 * 
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
			request.setAttribute("customerTrack", customerTrack2);
			
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
		}
		return "view";
	}
	/**
	 * 功能描述：单个客户信息--系统主页进入
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String personCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				Customer customer2 = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer2);
				List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql("select * from cust_CustomerTrack as customerTrack where customerTrack.customer.dbid=? order by customerTrack.createTime ", customerId);
				request.setAttribute("customerTracks", customerTracks);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "personCustomerTrack";
	}
	/**
	 * 功能描述：单个客户信息--跟踪明细列表进入
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String personCustomerTrackRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				Customer customer2 = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer2);
				List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customerId,CustomerTrack.TASKFINISHTYPECOMM});
				request.setAttribute("customerTracks", customerTracks);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "personCustomerTrackRecord";
	}
	/**
	 * 功能描述：销售经理--跟踪明细列表进入
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String leaderCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try{
			if(customerId>0){
				Customer customer2 = customerMangeImpl.get(customerId);
				request.setAttribute("customer", customer2);
				List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql("select * from cust_CustomerTrack as customerTrack where customerId=? order by customerTrack.createTime DESC ", customerId);
				request.setAttribute("customerTracks", customerTracks);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderCustomerTrack";
	}
	/**
	 * 功能描述：销售经理--跟踪明细列表进入
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String leaderApproval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
				request.setAttribute("customerTrack", customerTrack2);
				
				request.setAttribute("customer", customerTrack2.getCustomer());
				
				List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
				request.setAttribute("customerPhases", customerPhases);
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "leaderApproval";
	}
	/**
	 * 功能描述：销售经理审批保存
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveLeaderApproval() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer typeR = ParamUtil.getIntParam(request, "typeR", 1);
		String salesNote = request.getParameter("salesNote");
		User currentUser = SecurityUserHolder.getCurrentUser();
		Integer customerId=0;
		try {
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
			customerTrack2.setSalesReadStatus(2);
			customerTrack2.setSalesDate(new Date());
			customerTrack2.setSalesNote(salesNote);
			customerTrack2.setSalesManager(currentUser.getRealName());
			customerTrackManageImpl.save(customerTrack2);
			customerId=customerTrack2.getCustomer().getDbid();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		if(typeR==1){
			renderMsg("/customerTrack/leaderCustomerTrack?customerId="+customerId+"&redirect=3", "保存数据成功！");
		}
		if(typeR==2){
			renderMsg("/customerTrack/queryLeaderList", "保存数据成功！");
		}
		return;
	}
	/**
	 * 功能描述： 添加跟踪记录信息
	 * 参数描述： 1、首先判断该客户是否是次日回访，有true，false
	 * 	在true情况下：a、判断客户是否处于O、A、B、C四个状态，如果处于4个状态，那么需要填写次日回访记录
	 * 
	 * 				  b、在a条件满足的情况下，判断客户是否处于合同流失下来的需要次日回访的客户，判断客户是否是流失客户转换回来的客户
	 * 
	 * 				  c、是合同流失客户但是不是流失客户，那么获取客户的次日跟踪日期为操作合同流失日期
	 * 
	 * 				  d、是流失客户转换回来的客户，那么获取客户的次日跟踪记录为转换客户日期
	 * 
	 * 				  f、如果既是合同流失客户又是流失客户转换客户，那么数据出现问题，请及时联系管理员解决
	 * 
	 * 				  g、如果上面情况都不满足那么获取客户的创建日期为追踪超时日期
	 * 				  h、如果客户不出意外O、A、B、C三个状态，那么就没有超时之说
	 * 
	 * 在false情况下：a、判断客户是否处于A、B、C三个状态，如果处于3个状态，那么需要填写次日回访记录
	 * 				  b、在a条件满足的情况下，那么A为7日内回访、B、级为10日回访；C、为15日回访
	 * 				  c、a条件不满足下不做追踪操作。
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer dbid=customerTrack.getDbid();
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer type = ParamUtil.getIntParam(request, "typeRedirect", -1);
		Integer custMarketingActId = ParamUtil.getIntParam(request, "custMarketingActId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer isTryDriver = ParamUtil.getIntParam(request, "customerShoppingRecord.isTryDriver", -1);
		String tryDriver = request.getParameter("customerShoppingRecord.tryDriver");
		try{	
			User currentUser = SecurityUserHolder.getCurrentUser();
			Customer customer = customerMangeImpl.get(customerId);
			if(null==customer){
				renderErrorMsg(new Throwable("请选择客户在操作!"), "");
				return ;
			}
			if(dbid==null){
				renderErrorMsg(new Throwable("无跟踪任务!"), "");
				return ;
			}
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
			if(null==customerTrack2){
				renderErrorMsg(new Throwable("无跟踪任务!"), "");
				return ;
			}
			//初始化跟踪记录基本信息
			if(dbid==null||dbid<0){
				customerTrack.setCreateTime(new Date());
				customerTrack.setModifyTime(new Date());
				customerTrack.setSalesReadStatus(1);
			}else{
				customerTrack.setModifyTime(new Date());
			}
			if(customerTrack.getTrackType()==(int)CustomerTrack.TYPEACT){
				if (custMarketingActId<0) {
					renderErrorMsg(new Throwable("请选择活动!"), "");
					return ;
				}
				CustMarketingAct custMarketingAct = custMarketingActManageImpl.get(custMarketingActId);
				customerTrack.setCustMarketingAct(custMarketingAct);
			}
			customerTrack2.setTrackDate(new Date());
			customerTrack2.setDealMethod(customerTrack.getDealMethod());
			customerTrack2.setFeedBackResult(customerTrack.getFeedBackResult());
			customerTrack2.setResult(customerTrack.getResult());
			customerTrack2.setTrackContent(customerTrack.getTrackContent());
			customerTrack2.setTrackType(customerTrack.getTrackType());
			customerTrack2.setTrackMethod(customerTrack.getTrackMethod());
			customerTrack2.setTurnBackResult(customerTrack.getTurnBackResult());
			customerTrack2.setCustMarketingAct(customerTrack.getCustMarketingAct());
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			if(customerPhaseId>0){
				CustomerPhase customerPhase = customerPhaseManageImpl.get(customerPhaseId);
				//客户跟踪后的级别
				customer.setCustomerPhase(customerPhase);
				customerTrack2.setAfterCustomerPhase(customerPhase);
			}
			//下次跟踪时间
			String nextReservationTime = request.getParameter("customerTrack.nextReservationTime");
			Date string2Date=null;
			if(null!=nextReservationTime){
				string2Date = DateUtil.stringDateWithHHMM(nextReservationTime);
			}
			customerTractUtile.dealPreTaskAndCreateTask(customer, customerTrack2, string2Date,currentUser);
			
			//更新跟踪回访 客户次数
			Integer trackMethod = customerTrack.getTrackMethod();
			if(trackMethod==2){
				Integer comeShopNum = customer.getComeShopNum();
				if(comeShopNum!=null){
					comeShopNum=comeShopNum+1;
				}else{
					comeShopNum=1;
				}
				customer.setComeShopNum(comeShopNum);
			}
			Integer trackNum = customer.getTrackNum();
			if(trackNum!=null){
				trackNum=trackNum+1;
			}else{
				trackNum=1;
			}
			customer.setTrackNum(trackNum);
			//更新客户信息的跟踪状态
			customerMangeImpl.save(customer);
			Integer trackType = customerTrack.getTrackType();
			if(isTryDriver>0&&trackMethod==2&&trackType>=2){
				CustomerShoppingRecord customerShoppingRecord = customer.getCustomerShoppingRecord();
				customerShoppingRecord.setIsTryDriver(isTryDriver);
				customerShoppingRecord.setTryDriver(tryDriver);
				customerShoppingRecordManageImpl.save(customerShoppingRecord);
			}
			
			
			customerOperatorLogManageImpl.saveCustomerOperatorLog(customer.getDbid(), "客户跟踪记录登记", "");
			
			CustMarketingAct custMarketingAct = customerTrack2.getCustMarketingAct();
			if(null!=custMarketingAct){
				//设置邀约总次数
				Integer inviteNum = custMarketingAct.getInviteNum();
				if(null!=inviteNum){
					inviteNum=inviteNum+1;
				}else{
					inviteNum=1;
				}
				custMarketingAct.setInviteNum(inviteNum);
				//设置有效邀约次数
				Integer turnBackResult = customerTrack2.getTurnBackResult();
				if(turnBackResult==customerTrack.TYPEACT){
					Integer intentionCustNum = custMarketingAct.getIntentionCustNum();
					if(null!=intentionCustNum){
						intentionCustNum=intentionCustNum+1;
					}else{
						intentionCustNum=1;
					}
					custMarketingAct.setIntentionCustNum(intentionCustNum);
				}
				custMarketingActManageImpl.save(custMarketingAct);
			}
			
			//更新线索资料
			if(customerRecordId>0){
				CustomerRecord customerRecord = customerRecordManageImpl.get(customerRecordId);
				//更新线索资料
				CustomerBussi customerBussi = customer.getCustomerBussi();
				customerRecord.setResultStatus(CustomerRecord.RESULTTRACK);
				customerRecord.setName(customer.getName());
				customerRecord.setMobilePhone(customer.getMobilePhone());
				customerRecord.setBrand(customerBussi.getBrand());
				customerRecord.setCarModel(customerBussi.getCarModel());
				customerRecord.setCarSeriy(customerBussi.getCarSeriy());
				customerRecord.setResultDate(new Date());
				customerRecord.setCustomer(customer);
				customerRecordManageImpl.save(customerRecord);
				
			}
				
				if(type==1){
					renderMsg("/main/salerContent", "保存数据成功！");
					return ;
				}
				else if(type==3){
					renderMsg("/customerTrack/personCustomerTrack?customerId="+customer.getDbid(), "保存数据成功！");
					return ;
				}
				else if(type==4){
					Integer redirect = ParamUtil.getIntParam(request, "redirect", 1);
					renderMsg("/customerTrack/personCustomerTrackRecord?customerId="+customer.getDbid()+"&redirect="+redirect, "保存数据成功！");
				}
				else if(type==5){
					renderMsg("/customerRecord/querySalerList", "保存数据成功！");
				}
				else if(type==6){
					renderMsg("/customerTrack/dayCustomerTrack", "保存数据成功！");
				}
				else if(type==7){
					renderMsg("/customerTrack/tomorrwCustomerTrack", "保存数据成功！");
				}
				else{
					 if(dbid==null||dbid<0){
						renderMsg("/customer/customerShoppingRecordqueryList?pageSize="+pageSize+"&currentPage="+pageNo, "保存数据成功！");
					}else if(dbid>0){
						renderMsg("/customerTrack/queryWaitingList?pageSize="+pageSize+"&currentPage="+pageNo, "保存数据成功！");
					}
				}
				return ;
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		
	}
	/**
	 * 功能描述：当日需要回访用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String dayCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			//查询今日需要回访客户
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBySalerTodayTrack(currentUser);
			request.setAttribute("customerTracks", customerTracks);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "dayCustomerTrack";
	}
	/**
	 * 功能描述：当日需要回访用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String tomorrwCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBySalerTommorrowTrack(currentUser);
			request.setAttribute("customerTracks", customerTracks);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "tomorrwCustomerTrack";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String leaderView() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
			request.setAttribute("customerTrack", customerTrack2);
			
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
		}
		return "leaderView";
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
					customerTrackManageImpl.deleteById(dbid);
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
	 * 功能描述：当日需要回访用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String dayRoomManageCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Department department = currentUser.getDepartment();
			
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" AND cu.enterpriseId in("+currentUser.getCompnayIds()+") ";
			}else{
				selSql=selSql+" AND cu.departmentId="+department.getDbid();
			}
			List<CustomerTrack> todayCustomerTracks = customerTrackManageImpl.findByLeaderTodayTrack(selSql, salerId);
			request.setAttribute("todayCustomerTracks", todayCustomerTracks);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "dayRoomManageCustomerTrack";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String readCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			CustomerTrack customerTrack = customerTrackManageImpl.get(dbid);
			request.setAttribute("customerTrack", customerTrack);
			request.setAttribute("customer", customerTrack.getCustomer());

			User currentUser = SecurityUserHolder.getCurrentUser();
			Department department = currentUser.getDepartment();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				selSql=selSql+"cust.enterpriseId="+enterprise.getDbid();
			}else{
				selSql=selSql+"cust.departmentId="+department.getDbid();
			}
			//审阅跟踪记录
			String waitingReadSql="select * from cust_customertrack as custtrack,cust_customer AS cust " +
					" where "+
					" cust.dbid=custtrack.customerId AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+" AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED+
					" AND "+selSql+" AND  custtrack.readStatus="+CustomerTrack.COMMON ;
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSqlQuery(CustomerTrack.class, waitingReadSql, null).list();
			/*判断页面是否有上一条，下一条数据*/
			int size = customerTracks.size();
			int index=0;
			for(int i=0;i<customerTracks.size();i++){
				if(customerTrack.getDbid()==customerTracks.get(i).getDbid()){
					index=i+1;
					break;
				}
			}
			if(index==size&&index==1){
				request.setAttribute("customerTrack", customerTrack);
			}
			if(index==1&&index<size){
				request.setAttribute("customerTrack", customerTrack);
				request.setAttribute("next", customerTracks.get(index));
			}
			if(index<size&&index>1){
				request.setAttribute("customerTrack", customerTrack);
				request.setAttribute("next", customerTracks.get(index));
			}
			
			return "readCustomerTrack";
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "readCustomerTrack";
	}
	/**
	 * 功能描述：包括审批记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveReadCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		Integer nextId = ParamUtil.getIntParam(request, "nextId", -1);
		String showroomManagerSuggested = request.getParameter("showroomManagerSuggested");
		try {
			CustomerTrack customerTrack2 = customerTrackManageImpl.get(dbid);
			customerTrack2.setReadStatus(CustomerTrack.COMMONREADED);
			customerTrack2.setShowroomManagerSuggested(showroomManagerSuggested);
			customerTrackManageImpl.save(customerTrack2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		if(type==1){
			renderMsg("/customerTrack/readCustomerTrack?dbid="+nextId, "保存成功,更新下一条数据");
		}
		if(type==2){
			renderMsg("/customerTrack/queryRoomManageList", "保存成功");
		}
		if(type==3){
			renderMsg("/customerTrack/watingReadCustomerTrack", "保存成功");
		}
		return;
	}
	/**
	 * 功能描述：查看所有待审批记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String watingReadCustomerTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User currentUser = SecurityUserHolder.getCurrentUser();
			Department department = currentUser.getDepartment();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				selSql=selSql+" AND cust.enterpriseId="+enterprise.getDbid();
			}else{
				selSql=selSql+" AND cust.departmentId="+department.getDbid();
			}
			
			//审阅跟踪记录
			String waitingReadSql="select * from cust_customertrack as custtrack,cust_customer AS cust " +
					" where "+
					" cust.dbid=custtrack.customerId AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+" AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED+
					selSql+" AND  custtrack.readStatus="+CustomerTrack.COMMON ;
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSqlQuery(CustomerTrack.class, waitingReadSql, null).list();
			request.setAttribute("customerTracks", customerTracks);
			long waitingReadNum = customerTrackManageImpl.countSqlResult(waitingReadSql, null);
			request.setAttribute("waitingReadNum", waitingReadNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "watingReadCustomerTrack";
	}
	/**
	* 功能描述：经销商回访统计分析
	* 参数描述：
	* 逻辑描述：
	* @return
	* @throws Exception
	*/
	public String queryCustomerTrackCountList() throws Exception {
		HttpServletRequest request = getRequest();
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String userName=request.getParameter("userName");
		Date start=null;
		Date end=null;
		try {
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
			}else{
				start=DateUtil.string2Date(DateUtil.getNowMonthFirstDay()) ;
			}
			if(null!=endTime&&endTime.trim().length()>0){
				end=DateUtil.nextDay(endTime);
			}else{
				end=DateUtil.nextDay(new Date());
			}
			String beginDate=DateUtil.format(start);
			String endDate=DateUtil.format(end);
			User currentUser = SecurityUserHolder.getCurrentUser();
			Integer enterpriseId=null;
			Integer departmentId=null;
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				Enterprise enterprise = SecurityUserHolder.getEnterprise();
				enterpriseId=enterprise.getDbid();
			}else{
				departmentId = currentUser.getDepartment().getDbid();
			}
			List<CustomerTrackCount> customerTrackCounts = customerTractUtile.querySalerCustomerTrackCount(beginDate, endDate, userName, enterpriseId,departmentId);
			request.setAttribute("customerTrackCounts", customerTrackCounts);
			request.setAttribute("beginDate", beginDate);
			request.setAttribute("endDate", endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "customerTrackCountList";
	}
	/**
	 * 功能描述：查询到期回访时间段的回访明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String salerCustomerTrackDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer userId = ParamUtil.getIntParam(request, "userId", -1);
		Integer taskDealStatus = ParamUtil.getIntParam(request, "taskDealStatus", -1);
		Integer taskOverTimeStatus = ParamUtil.getIntParam(request, "taskOverTimeStatus", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		
		try{
			User user = userManageImpl.get(userId);
			request.setAttribute("user", user);
			String sql="select * from cust_CustomerTrack track,cust_customer cust where cust.dbid=track.customerId And cust.bussiStaffId="+userId+" and taskOverTimeStatus="+CustomerTrack.TASKOVERTIMESTATUSED;
			if(taskDealStatus>0){
				sql=sql+" AND taskDealStatus="+taskDealStatus;
			}
			if(taskOverTimeStatus>0){
				sql=sql+" AND taskOverTimeStatus="+taskOverTimeStatus;
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" AND nextReservationTime>='"+startTime+"'";
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" AND nextReservationTime<='"+endTime+"'";
			}
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql(sql, null);
			request.setAttribute("customerTracks", customerTracks);
			
			request.setAttribute("startTime", startTime);
			request.setAttribute("endTime", endTime);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "salerCustomerTrackDetail";
	}
}
