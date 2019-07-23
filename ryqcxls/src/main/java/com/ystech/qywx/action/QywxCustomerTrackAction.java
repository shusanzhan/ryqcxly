package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustMarketingAct;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.service.CustMarketingActManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerOperatorLogManageImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerRecordManageImpl;
import com.ystech.cust.service.CustomerShoppingRecordManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.CustomerTractUtile;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxCustomerTrackAction")
@Scope("prototype")
public class QywxCustomerTrackAction extends BaseController{
	private CustomerTrack customerTrack;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private CustMarketingActManageImpl custMarketingActManageImpl;
	private UserManageImpl userManageImpl;
	private CustomerTractUtile customerTractUtile;
	private CustomerOperatorLogManageImpl customerOperatorLogManageImpl;
	private CustomerRecordManageImpl customerRecordManageImpl;
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CustomerShoppingRecordManageImpl customerShoppingRecordManageImpl;
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	public CustomerTrack getCustomerTrack() {
		return customerTrack;
	}
	public void setCustomerTrack(CustomerTrack customerTrack) {
		this.customerTrack = customerTrack;
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
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setCustomerTractUtile(CustomerTractUtile customerTractUtile) {
		this.customerTractUtile = customerTractUtile;
	}
	@Resource
	public void setCustomerOperatorLogManageImpl(
			CustomerOperatorLogManageImpl customerOperatorLogManageImpl) {
		this.customerOperatorLogManageImpl = customerOperatorLogManageImpl;
	}
	@Resource
	public void setCustomerRecordManageImpl(
			CustomerRecordManageImpl customerRecordManageImpl) {
		this.customerRecordManageImpl = customerRecordManageImpl;
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
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
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
		User sessionUser = getSessionUser();
		Enterprise enterprise = sessionUser.getEnterprise();
		try{
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findByCustIdAndUserId(customerId, sessionUser.getDbid());
			if(null!=customerTracks&&customerTracks.size()>0){
				CustomerTrack customerTrack2 = customerTracks.get(0);
				request.setAttribute("customerTrack", customerTrack2);
			}else{
				//默认创建任务为15天
				Date addDay = DateUtil.addDay(new Date(), 15);
				CustomerTrack customerTrack=customerTractUtile.createOtherCustomerTask(customer2,addDay,sessionUser);
				request.setAttribute("customerTrack", customerTrack);
			}
			List<CustMarketingAct> custMarketingActs = custMarketingActManageImpl.executeSql("SELECT * FROM cust_marketingact WHERE DATE_FORMAT(NOW(),'%y-%m-%d')>=actStartDate AND actEndDate>=DATE_FORMAT(NOW(),'%y-%m-%d') and enterpriseId="+enterprise.getDbid(), null);
			request.setAttribute("custMarketingActs", custMarketingActs);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
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
		Integer type = ParamUtil.getIntParam(request, "typeRedirect", -1);
		Integer custMarketingActId = ParamUtil.getIntParam(request, "custMarketingActId", -1);
		Integer customerRecordId = ParamUtil.getIntParam(request, "customerRecordId", -1);
		Integer isTryDriver = ParamUtil.getIntParam(request, "customerShoppingRecord.isTryDriver", -1);
		String tryDriver = request.getParameter("customerShoppingRecord.tryDriver");
		try{	
			User sessionUser = getSessionUser();
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
				string2Date = DateUtil.string2Date(nextReservationTime);
			}
			customerTractUtile.dealPreTaskAndCreateTask(customer, customerTrack2, string2Date,sessionUser);
			
			Integer trackNum = customer.getTrackNum();
			if(trackNum!=null){
				trackNum=trackNum+1;
			}else{
				trackNum=1;
			}
			customer.setTrackNum(trackNum);
			
			//更新客户信息的跟踪状态
			customerMangeImpl.save(customer);
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
					//客户登记列表
					renderMsg("/qywxCustomer/list", "保存数据成功！");
					return ;
				}
				else if(type==2){
					//客户订单列表
					renderMsg("/qywxCustomer/orderCustomer", "保存数据成功！");
					return ;
				}
				else if(type==3){
					//带交车列表
					renderMsg("/qywxCustomer/waitingHandCar", "保存数据成功！");
				}
				else if(type==4){
					//带交车列表
					renderMsg("/qywxCustomerRecord/querySalerList", "保存数据成功！");
				}
				else if(type==5){
					//带交车列表
					renderMsg("/qywxCustomerTrack/salerTodayTrack", "保存数据成功！");
				}
				else if(type==6){
					//带交车列表
					renderMsg("/qywxCustomerTrack/salerTommorrowTrack", "保存数据成功！");
				}
				else if(type==7){
					//带交车列表
					renderMsg("/qywxCustomerTrack/salerThreeDayTrack", "保存数据成功！");
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
	 * 功能描述：待审阅回访记录
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerTrackRecord() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			//审阅跟踪记录
			String waitingReadSql="select * from cust_customertrack as custtrack, cust_customer AS cust " +
					" where "+
					" cust.dbid=custtrack.customerId AND  custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+ " AND taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED+
					" AND "+selSql+" AND  custtrack.readStatus="+CustomerTrack.COMMON +" limit 10 ";
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSqlQuery(CustomerTrack.class, waitingReadSql, null).list();
			request.setAttribute("customerTracks", customerTracks);
			long waitingReadNum = customerTrackManageImpl.countSqlResult(waitingReadSql, null);
			request.setAttribute("waitingReadNum", waitingReadNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerTrackRecord";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerTrackDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid",-1);
		try {
			CustomerTrack customerTrack = customerTrackManageImpl.get(dbid);
			request.setAttribute("customerTrack", customerTrack);
			User sessionUser = getSessionUser();
			
			String selSql="";
			if(sessionUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+sessionUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+sessionUser.getDepartment().getDbid();
			}
			
			String waitingReadSql="select * from cust_customertrack as custtrack, cust_customer AS cust " +
					" where "+
					" cust.dbid=custtrack.customerId AND  custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+ " AND taskDealStatus="+CustomerTrack.TASKDEALSTATUSDEALED+
					" AND "+selSql+" AND  custtrack.readStatus="+CustomerTrack.COMMON +"  ";
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
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerTrackDetail";
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
		String showroomManagerSuggested = request.getParameter("sugg");
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
			renderMsg("/qywxCustomerTrack/customerTrackDetail?dbid="+nextId, "保存成功,更新下一条数据");
		}
		if(type==2){
			renderMsg("/qywxCustomerTrack/customerTrackRecord", "保存成功");
		}
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryCompList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
		Integer taskOverTimeStatus = ParamUtil.getIntParam(request, "taskOverTimeStatus", -1);
		Integer taskDealStatus = ParamUtil.getIntParam(request, "taskDealStatus", -1);
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String name = request.getParameter("name");
		String phone= request.getParameter("phone");
		String userName= request.getParameter("userName");
		String startFinishDate= request.getParameter("startFinishDate");
		String endFinishDate= request.getParameter("endFinishDate");
		try{
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.findBy("type", CustomerPhase.TYPESHOW);
			request.setAttribute("customerPhases", customerPhases);
			List<Brand> brands = brandManageImpl.getAll();
			request.setAttribute("brands", brands);
			String hql="from CarModel where 1=1 ";
			if(brandId>0){
				//车系
				List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("brand.dbid", brandId);
				hql=hql+" and brand.dbid="+brandId;
				request.setAttribute("carSeriys", carSeriys);
			}else{
				//车系
				List<CarSeriy> carSeriys = carSeriyManageImpl.getAll();
				request.setAttribute("carSeriys", carSeriys);
			}
			
			if(carSeriyId>0){
				//车型
				hql=hql+" and carseries.dbid="+carSeriyId;
			}
			List<CarModel> carModels = carModelManageImpl.find(hql, null);
			request.setAttribute("carModels", carModels);
			User sessionUser = getSessionUser();
			String sql="select * from cust_customertrack as track,cust_Customer as cu,cust_CustomerBussi as cb "
					+ "where"
					+ " cu.dbid=track.customerId and track.taskDealStatus>=? AND cb.customerId=cu.dbid ";
			List param=new ArrayList();
			if(sessionUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" AND cu.enterpriseId in("+sessionUser.getCompnayIds()+") ";
			}else{
				sql=sql+" AND cu.departmentId="+sessionUser.getDepartment().getDbid();
			}
			param.add(CustomerTrack.TASKDEALSTATUSDEALED);
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=phone&&phone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				param.add("%"+phone+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				sql=sql+" and cu.bussiStaff like ? ";
				param.add("%"+userName+"%");
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
			if(startFinishDate==null&&endFinishDate==null){
				sql=sql+" AND  track.finishDate>=date_sub(curdate(),interval 0 day) ";
			}else{
				if(startFinishDate!=null&&startFinishDate.trim().length()>0){
					sql=sql+" and track.finishDate>='"+startFinishDate+"' ";
				}
				if(endFinishDate!=null&&endFinishDate.trim().length()>0){
					sql=sql+" and track.finishDate<='"+DateUtil.format(DateUtil.nextDay(endFinishDate)) +"' ";
				}
			}
			sql=sql+"order by track.finishDate DESC";
			
			List<CustomerTrack> customerTracks = customerTrackManageImpl.executeSql(sql,param.toArray());
			request.setAttribute("customerTracks", customerTracks);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "compList";
	}
	/**
	 * 功能描述：次日需要跟踪客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String tommorrowNeedTrackCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User sessionUser = getSessionUser();
			String selSql="";
			if(sessionUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId in("+sessionUser.getCompnayIds()+") ";
			}else{
				selSql=selSql+" cust.departmentId="+sessionUser.getDepartment().getDbid();
			}
			//查询今日需要回访客户
			String theNextSql="select * from  cust_customertrack AS custtrack,cust_customer AS cust"+
					" where "+ 
					" cust.dbid=custtrack.customerId  AND  custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE+
					" AND "+selSql+" AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
					"  AND DATE_FORMAT(custtrack.nextReservationTime,'%Y-%m-%d')=date_sub(curdate(),interval -1 day) limit 100 ";
			List<CustomerTrack> dayCustomers = customerTrackManageImpl.executeSql(theNextSql, null);
			request.setAttribute("dayCustomers", dayCustomers);
			long  dayCustomerNum = customerMangeImpl.countSqlResult(theNextSql, null);
			request.setAttribute("dayCustomerNum", dayCustomerNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "tommorrowNeedTrackCustomer";
	}
	/**
	 * 功能描述：待跟踪客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String needTrackCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer salerId = ParamUtil.getIntParam(request, "salerId", -1);
		try {
			//
			User sessionUser = getSessionUser();
			String selSql="";
			if(sessionUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cu.enterpriseId="+sessionUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cu.departmentId="+sessionUser.getDepartment().getDbid();
			}
			
			//查询今日需要回访客户
			String theNextSql="select * from  cust_customertrack AS custtrack,cust_customer AS cu"+
					" where "+ 
					" cu.dbid=custtrack.customerId  AND "+selSql+"  AND  custtrack.taskDealStatus="+CustomerTrack.TASKDEALSTATUSCREATE+ 
					"  AND  custtrack.nextReservationTime<=date_sub(curdate(),interval -1 day) AND custtrack.customerPhaseType="+CustomerTrack.CUSTOMERPAHSEONE;
			if(salerId>0){
				theNextSql=theNextSql+" AND custtrack.userId="+salerId;
			}
			List<CustomerTrack> todayCustomerTracks = customerTrackManageImpl.executeSql(theNextSql, null);
			request.setAttribute("nextDaycCustomers", todayCustomerTracks);
			long  theNextNum = customerMangeImpl.countSqlResult(theNextSql, null);
			request.setAttribute("theNextNum", theNextNum);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "needTrackCustomer";
	}
	/**
	 * 功能描述：今天需回访踪客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String salerTodayTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User sessionUser = getSessionUser();
			//查询今日需要回访客户
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBySalerTodayTrack(sessionUser);
			request.setAttribute("customerTracks", customerTracks);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "salerTodayTrack";
	}
	/**
	 * 功能描述：明日需回访客户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String salerTommorrowTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			//次日需要访问客户
			User sessionUser = getSessionUser();
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBySalerTommorrowTrack(sessionUser);
			request.setAttribute("customerTracks", customerTracks);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "salerTommorrowTrack";
	}
	/**
	 * 功能描述：未来3天需要跟进回访
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String salerThreeDayTrack() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			User sessionUser = getSessionUser();
			//查询今日需要回访客户
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBySalerThreeDayTrack(sessionUser);
			request.setAttribute("customerTracks", customerTracks);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "salerThreeDayTrack";
	}
}
