/**
 * 
 */
package com.ystech.cust.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.DayComeShop;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.model.OverTimeUserCount;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.InfoFromManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

/**
 * @author shusanzhan
 * @date 2014-5-14
 */
@Component("statisticsSalerAction")
@Scope("prototype")
public class StatisticsSalerAction extends BaseController{
	private String[] datas={"新到车辆","预警一级","预警二级","自有一级","自有二级","自有三级","自有重点"};
	private CustomerMangeImpl customerMangeImpl;
	private DepartmentManageImpl departmentManageImpl;
	private HttpServletRequest request=this.getRequest();
	private InfoFromManageImpl infoFromManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl; 
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setInfoFromManageImpl(InfoFromManageImpl infoFromManageImpl) {
		this.infoFromManageImpl = infoFromManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	/**
	 * 功能描述：统计主页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where (lastResult="+Customer.NORMAL+" or (lastResult="+Customer.SUCCESS+" and orderContractStatus="+Customer.ORDERNOT+")) AND bussiStaffId="+currentUser.getDbid();
			
			String canncelCountSql="SELECT COUNT(*) as total FROM cust_customer where lastResult="+Customer.CANCCEL+" AND bussiStaffId="+currentUser.getDbid();

			String orderCountSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_ordercontract AS ord where cuts.dbid=ord.customerId AND ord.`status`>"+OrderContract.WATINGDECORE+" and ord.`status`<"+OrderContract.PRINT +" and cuts.bussiStaffId="+currentUser.getDbid();
			
			String waitingCarSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus!="+CustomerPidBookingRecord.FINISHED +" and cuts.bussiStaffId="+currentUser.getDbid();
			
			String customerSuccessSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus="+CustomerPidBookingRecord.FINISHED +" and cuts.bussiStaffId="+currentUser.getDbid();
			
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			
			Object canncelCount = statisticalSalerManageImpl.queryCount(canncelCountSql);
			request.setAttribute("canncelCount", canncelCount);
			
			Object orderCount = statisticalSalerManageImpl.queryCount(orderCountSql);
			request.setAttribute("orderCount", orderCount);
			
			
			Object waitingCar = statisticalSalerManageImpl.queryCount(waitingCarSql);
			request.setAttribute("waitingCar", waitingCar);
			
			
			Object customerSuccess = statisticalSalerManageImpl.queryCount(customerSuccessSql);
			request.setAttribute("customerSuccess", customerSuccess);
			
			List<OverTimeUserCount> overTimeUserCounts = statisticalSalerManageImpl.queryOverTime(currentUser.getDbid());
			request.setAttribute("overTimeUserCounts", overTimeUserCounts);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String dataStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		User currentUser = SecurityUserHolder.getCurrentUser();
		Integer userDbid = currentUser.getDbid();
		Date start=null;
		Date end=null;
		try{
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
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			String sql="SELECT COUNT(*) as total FROM cust_customer where bussiStaffId="+userDbid;
			if(null!=start){
				sql=sql+" AND createFolderTime>='"+DateUtil.format(start) +"'";
			}
			if(null!=end){
				sql=sql+" AND createFolderTime<='"+DateUtil.format(end) +"'";
			}
			Object newsCount = statisticalSalerManageImpl.queryCount(sql);
			request.setAttribute("newsCount", newsCount);
			List<CustomerPhase> customerPhases = statisticalSalerManageImpl.queryCountLevel(start, end, userDbid,null);
			request.setAttribute("customerPhases", customerPhases);
			StringBuffer buffer=new StringBuffer();
			if(!customerPhases.isEmpty()){
				buffer.append("[");
				int i=0;
				for (CustomerPhase customerPhase : customerPhases) {
					if(i==(customerPhases.size()-1)){
						buffer.append("['"+customerPhase.getName()+"',"+customerPhase.getTotalNum()+"]");
					}else{
						buffer.append("['"+customerPhase.getName()+"',"+customerPhase.getTotalNum()+"],");
					}
				}
				buffer.append("]");
			}else{
				buffer.append("[");
				buffer.append("]");
			}
			request.setAttribute("customerPhaseJson", buffer.toString());
			
			request.setAttribute("start", start);
			request.setAttribute("end", DateUtil.preDay(end));
			
			
			List<DayComeShop> dayComeShops = statisticalSalerManageImpl.queryHasCarShop(start, end, userDbid);
			request.setAttribute("dayComeShops", dayComeShops);
			String jsonCarData = jsonCarData(dayComeShops);
			request.setAttribute("jsonCarData", jsonCarData);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "dataStatistics";
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String levelStatistics() throws Exception {
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Date start=null;
		Date end=null;
		User user = SecurityUserHolder.getCurrentUser();
		try{
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
			Integer userDbid = user.getDbid();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			request.setAttribute("enterprise", enterprise);
			//来店
			List<DayComeShop> levelOs = statisticalSalerManageImpl.queryLevlelDayComeShop(start, end, userDbid, CustomerPhase.LEVELO);
			List<DayComeShop> levelHs = statisticalSalerManageImpl.queryLevlelDayComeShop(start, end, userDbid, CustomerPhase.LEVELH);
			List<DayComeShop> levelAs = statisticalSalerManageImpl.queryLevlelDayComeShop(start, end, userDbid, CustomerPhase.LEVELA);
			List<DayComeShop> levelBs = statisticalSalerManageImpl.queryLevlelDayComeShop(start, end, userDbid, CustomerPhase.LEVELB);
			List<DayComeShop> levelCs = statisticalSalerManageImpl.queryLevlelDayComeShop(start, end, userDbid, CustomerPhase.LEVELC);
			request.setAttribute("levelOs", levelOs);
			request.setAttribute("levelHs", levelHs);
			request.setAttribute("levelAs", levelAs);
			request.setAttribute("levelBs", levelBs);
			request.setAttribute("levelCs", levelCs);
			
			String xSer=new String();
			xSer=xSer+"[";
			for (DayComeShop dayComeShop : levelOs) {
				xSer=xSer+dayComeShop.getDay()+",";
			}
			xSer = xSer.substring(0,xSer.lastIndexOf(","));
			xSer=xSer+"]";
			
			String levelAV = getComeType(levelAs);
			String levelHV = getComeType(levelHs);
			String levelOV = getComeType(levelOs);
			String levelBV = getComeType(levelBs);
			String levelCV = getComeType(levelCs);
			
			request.setAttribute("levelAV", levelAV);
			request.setAttribute("levelHV", levelHV);
			request.setAttribute("levelOV", levelOV);
			request.setAttribute("levelBV", levelBV);
			request.setAttribute("levelCV", levelCV);
			request.setAttribute("xSer", xSer);
		
			
			Object levelCO = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELO);
			Object levelCH = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELH);
			Object levelCA = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELA);
			Object levelCB = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELB);
			Object levelCC = statisticalSalerManageImpl.queryCountLevelCount(start, end, userDbid, CustomerPhase.LEVELC);
			request.setAttribute("levelCO", levelCO);
			request.setAttribute("levelCH", levelCH);
			request.setAttribute("levelCA", levelCA);
			request.setAttribute("levelCB", levelCB);
			request.setAttribute("levelCC", levelCC);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "levelStatistics";
	}
	/**
	 * 来店类型数据值
	 * @param shopings
	 * @return
	 */
	private String getComeType(List<DayComeShop> shopings ){
		String xSerValue=new String();
		xSerValue=xSerValue+"[";
		for (DayComeShop dayComeShop : shopings) {
			xSerValue=xSerValue+dayComeShop.getCountNum()+",";
		}
		xSerValue = xSerValue.substring(0,xSerValue.lastIndexOf(","));
		xSerValue=xSerValue+"]";
		return xSerValue;
	}
	private String jsonCarData(List<DayComeShop> dayComeShops){
		String data="[";
		for (DayComeShop dayComeShop : dayComeShops) {
				data=data+" ['"+datas[dayComeShop.getDay()-1]+"',"+dayComeShop.getCountNum()+"],";
		}
		int lastIndexOf = data.lastIndexOf(",");
		data = data.substring(0, lastIndexOf);
		data=data+"]";
		return data;
	}
	
}
