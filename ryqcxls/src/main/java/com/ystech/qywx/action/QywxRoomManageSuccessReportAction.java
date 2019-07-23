package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.DateNum;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;
@Component("qywxRoomManageSuccessReportAction")
@Scope("prototype")
public class QywxRoomManageSuccessReportAction extends BaseController{
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	private UserManageImpl userManageImpl;
	private StatisticalManageImpl statisticalManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private DepartmentManageImpl departmentManageImpl;
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	@Resource
	public void setStatisticalManageImpl(StatisticalManageImpl statisticalManageImpl) {
		this.statisticalManageImpl = statisticalManageImpl;
	}
	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	/**
	 * 功能描述：成交客户统计
	 * 参数描述：1、按部门，车系统计；2、按车系统计；3、按经销商类型统计
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unused", "unused" })
	public String customerSuccess() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start)+"成交客户报表";
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date())+"成交客户报表";
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			//统计当天数车系据情况
			String todayCarSerirySql="SELECT cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerpidbookingrecord cpid,set_carseriy cs " +
					"WHERE" +
					"	cust.dbid=cpid.customerId AND cpid.carSeriyId=cs.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" " +
					" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<'"+DateUtil.format(end)+"' And "+selSql+
					" GROUP BY cs.dbid ";
			List<CarSerCount> carseriyTotals = statisticalManageImpl.querStatic(todayCarSerirySql);
			request.setAttribute("carseriyTotals", carseriyTotals);
			
			//统计当天品牌数据情况
			String brandSql="SELECT br.dbid as serid,br.`name` as serName,COUNT(cpid.brandId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerpidbookingrecord cpid,set_brand br " +
					"WHERE" +
					"	cust.dbid=cpid.customerId AND cpid.brandId=br.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" " +
					" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<'"+DateUtil.format(end)+"' And "+selSql+
					" GROUP BY br.dbid ";
			List<CarSerCount> brandTotals = statisticalManageImpl.querStatic(brandSql);
			request.setAttribute("brandTotals", brandTotals);
			
			//自有店数据统计合
			String selfShopTotalSql="SELECT " +
					"COUNT(*) as total " +
					"FROM sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE" +
					" dep.dbid=cust.successDepartmentId AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<'"+DateUtil.format(end)+"' and cust.customerType=1 And "+selSql;
			Object selfShopTotal = statisticalSalerManageImpl.queryCount(selfShopTotalSql);
			request.setAttribute("selfShopTotal", selfShopTotal);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccess";
	}
	/**
	 * 功能描述：成交客户7日报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerSuccess7Day() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start)+"集客报表";
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date())+"集客报表";
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust,cust_customerpidbookingrecord cpid where cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"" +
					" And cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<'"+DateUtil.format(end)+"' And "+selSql;
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			///////////////////////////////////////////////////////////////////////////一周集客趋势图//////////////////////////////////////////////////////////////////
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT DATE_FORMAT(cpid.modifyTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(cpid.modifyTime,'%y-%m-%d')) AS totalNum  "
					+ "FROM cust_customer cust,cust_customerpidbookingrecord cpid  " +
					"  WHERE TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7 AND cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" And "+selSql+
					"  GROUP BY DATE_FORMAT(cpid.modifyTime,'%y-%m-%d')";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				int i=0;
				for (DateNum dateNum : customerWeekDateNums) {
					
					if(i==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					i++;
					if(i!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
						request.setAttribute("avageCustomer", avageCustomer/6);
					}
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					" TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7 AND cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+ " And "+selSql ;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" AND csr.comeType=paramType AND TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7   And "+selSql ;
			//来店
			String comeShopSql = "SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" AND (csr.comeType=1 or csr.comeType is null) AND TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7  And "+selSql ;
			Object comeShopNum = statisticalSalerManageImpl.queryCount(comeShopSql);
			request.setAttribute("comeShopNum", comeShopNum);
			//来电
			String comePhoneSql = comeTypeSql.replace("paramType", "2");
			Object comePhoneNum = statisticalSalerManageImpl.queryCount(comePhoneSql);
			request.setAttribute("comePhoneNum", comePhoneNum);
			//活动
			String comeActiveSql = comeTypeSql.replace("paramType", "3");
			Object comeActiveNum = statisticalSalerManageImpl.queryCount(comeActiveSql);
			request.setAttribute("comeActiveNum", comeActiveNum);
			//特卖会
			String comeSpecelSql = comeTypeSql.replace("paramType", "4");
			Object comeSpecelNum = statisticalSalerManageImpl.queryCount(comeSpecelSql);
			request.setAttribute("comeSpecelNum", comeSpecelNum);
			//////////////////////////////////////////////////////////////////////////////////一周关注前五车系/////////////////////////////////////////////////////////////
			String carserySql="SELECT " +
					" cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"cust.dbid=cpid.customerId AND cs.dbid=cpid.carSeriyId AND TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7 AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"DATE_FORMAT(cpid.modifyTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(cpid.modifyTime,'%Y-%m-%d')) AS totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerpidbookingrecord cpid " +
							"WHERE " +
							"cust.dbid=cpid.customerId AND cpid.carSeriyId="+carSerCount.getSerid()+" AND TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7 AND " +
							"cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
							" GROUP BY DATE_FORMAT(cpid.modifyTime,'%Y-%m-%d')";
					if(i==0){
						buffCarseryValues.append("{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}else{
						buffCarseryValues.append(",{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}
					i++;
				}
				buffCarseryValues.append("]");
				request.setAttribute("buffCarseryValues", buffCarseryValues.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccess7Day";
	}
	/**
	 * 功能描述：成交周
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerSuccessWeek() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start)+"集客报表";
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date())+"集客报表";
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust,cust_customerpidbookingrecord cpid where cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" ANd WEEKOFYEAR(CURDATE())=WEEKOFYEAR(cpid.modifyTime) AND YEAR(CURDATE())=YEAR(cpid.modifyTime)  And "+selSql ;
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			///////////////////////////////////////////////////////////////////////////一周集客趋势图//////////////////////////////////////////////////////////////////
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"WEEKOFYEAR(cpid.modifyTime) AS createFolderTime,COUNT(WEEKOFYEAR(cpid.modifyTime)) AS totalNum  " +
					" FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid  " +
					"  WHERE " +
					"(WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(cpid.modifyTime) AND cust.dbid=cpid.customerId " +
					"And cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					"  GROUP BY WEEKOFYEAR(cpid.modifyTime)";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				int i=0;
				for (DateNum dateNum : customerWeekDateNums) {
					if(i==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					i++;
					if(i!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
					}
				}
				if(i>2){
					request.setAttribute("avageCustomer", avageCustomer/(i-1));
				}else{
					request.setAttribute("avageCustomer", avageCustomer);
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					" (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(cpid.modifyTime) " +
					"AND cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" And  "+selSql ;;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" AND csr.comeType=paramType" +
							" And (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(cpid.modifyTime) And "+selSql ;;
			//来店
			String comeShopSql = "SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" AND (csr.comeType=1 or csr.comeType is null)" +
							" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(cpid.modifyTime)  And "+selSql ;
			Object comeShopNum = statisticalSalerManageImpl.queryCount(comeShopSql);
			request.setAttribute("comeShopNum", comeShopNum);
			//来电
			String comePhoneSql = comeTypeSql.replace("paramType", "2");
			Object comePhoneNum = statisticalSalerManageImpl.queryCount(comePhoneSql);
			request.setAttribute("comePhoneNum", comePhoneNum);
			//活动
			String comeActiveSql = comeTypeSql.replace("paramType", "3");
			Object comeActiveNum = statisticalSalerManageImpl.queryCount(comeActiveSql);
			request.setAttribute("comeActiveNum", comeActiveNum);
			//特卖会
			String comeSpecelSql = comeTypeSql.replace("paramType", "4");
			Object comeSpecelNum = statisticalSalerManageImpl.queryCount(comeSpecelSql);
			request.setAttribute("comeSpecelNum", comeSpecelNum);
			//////////////////////////////////////////////////////////////////////////////////一周关注前五车系/////////////////////////////////////////////////////////////
			String carserySql="SELECT " +
					" cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"cust.dbid=cpid.customerId AND cs.dbid=cpid.carSeriyId AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7" +
					" AND  YEAR(CURDATE())=YEAR(cpid.modifyTime) AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED +"  And "+selSql +
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"WEEKOFYEAR(cpid.modifyTime) AS createFolderTime,COUNT(WEEKOFYEAR(cpid.modifyTime)) AS totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerpidbookingrecord cpid " +
							"WHERE " +
							"cust.dbid=cpid.customerId AND cpid.carSeriyId="+carSerCount.getSerid()+" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cpid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(cpid.modifyTime)" +
									" AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
							" GROUP BY WEEKOFYEAR(cpid.modifyTime)";
					if(i==0){
						buffCarseryValues.append("{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}else{
						buffCarseryValues.append(",{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}
					i++;
				}
				buffCarseryValues.append("]");
				request.setAttribute("buffCarseryValues", buffCarseryValues.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccessWeek";
	}
	/**
	 * 功能描述：成交月
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerSuccessMonth() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
				title=startTime+"集客报表";
			}else{
				title=format.format(new Date())+"集客报表";
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			request.setAttribute("monthDay", start.subSequence(5, 7));
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust,cust_customerpidbookingrecord cpid where cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" And cpid.modifyTime>='"+DateUtil.format(new Date())+"' AND cpid.modifyTime<'"+DateUtil.format(new Date())+"' And "+selSql ;
			
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			///////////////////////////////////////////////////////////////////////////一周集客趋势图//////////////////////////////////////////////////////////////////
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"DATE_FORMAT(cpid.modifyTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(cpid.modifyTime,'%d')) AS totalNum  " +
					" FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid  " +
					"  WHERE " +
					" DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' AND cust.dbid=cpid.customerId And cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					 "  And "+selSql +
					"  GROUP BY DATE_FORMAT(cpid.modifyTime,'%d')";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				int i=0;
				for (DateNum dateNum : customerWeekDateNums) {
					if(i==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					i++;
					if(i!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
					}
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
				if(i>1){
					request.setAttribute("avageCustomer", avageCustomer/(i-1));
				}else{
					request.setAttribute("avageCustomer", avageCustomer/i);
				}
				request.setAttribute("monthNum", i);
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					" DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' AND cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED +" And  "+selSql ;;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					" AND csr.comeType=paramType And  DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' ";
			//来店
			String comeShopSql = "SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					" AND (csr.comeType=1 or csr.comeType is null) AND  DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' ";
			Object comeShopNum = statisticalSalerManageImpl.queryCount(comeShopSql);
			request.setAttribute("comeShopNum", comeShopNum);
			//来电
			String comePhoneSql = comeTypeSql.replace("paramType", "2");
			Object comePhoneNum = statisticalSalerManageImpl.queryCount(comePhoneSql);
			request.setAttribute("comePhoneNum", comePhoneNum);
			//活动
			String comeActiveSql = comeTypeSql.replace("paramType", "3");
			Object comeActiveNum = statisticalSalerManageImpl.queryCount(comeActiveSql);
			request.setAttribute("comeActiveNum", comeActiveNum);
			//特卖会
			String comeSpecelSql = comeTypeSql.replace("paramType", "4");
			Object comeSpecelNum = statisticalSalerManageImpl.queryCount(comeSpecelSql);
			request.setAttribute("comeSpecelNum", comeSpecelNum);
			//////////////////////////////////////////////////////////////////////////////////一周关注前五车系/////////////////////////////////////////////////////////////
			String carserySql="SELECT " +
					" cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"cust.dbid=cpid.customerId AND cs.dbid=cpid.carSeriyId AND DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"DATE_FORMAT(cpid.modifyTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(cpid.modifyTime,'%d')) AS totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerpidbookingrecord cpid " +
							"WHERE " +
							"cust.dbid=cpid.customerId AND cpid.carSeriyId="+carSerCount.getSerid()+" AND  DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
							" GROUP BY DATE_FORMAT(cpid.modifyTime,'%d')";
					if(i==0){
						buffCarseryValues.append("{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}else{
						buffCarseryValues.append(",{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}
					i++;
				}
				buffCarseryValues.append("]");
				request.setAttribute("buffCarseryValues", buffCarseryValues.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccessMonth";
	}
	/**
	 * 功能描述：成交月
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerSuccessYear() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
				title=startTime+"集客报表";
			}else{
				title=format.format(new Date())+"集客报表";
				start=format.format(new Date());
			}
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			request.setAttribute("monthDay",start);
			request.setAttribute("nowMonthDay",format.format(new Date()));
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust,cust_customerpidbookingrecord cpid where cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+
					" And MONTH(cpid.modifyTime)=MONTH(CURDATE()) and YEAR(cpid.modifyTime)='"+start+"'  And "+selSql ;
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			///////////////////////////////////////////////////////////////////////////一周集客趋势图//////////////////////////////////////////////////////////////////
			//集客日期列表
			StringBuffer buffButtomTitles=new StringBuffer();
			//集客数量
			StringBuffer buffValues=new StringBuffer();
			//平均 7天集客数量
			int avageCustomer=0;
			String sql="SELECT " +
					"MONTH(cpid.modifyTime) AS createFolderTime,COUNT(MONTH(cpid.modifyTime)) AS totalNum  " +
					" FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid  " +
					"  WHERE " +
					" YEAR(cpid.modifyTime)='"+start+"' AND cust.dbid=cpid.customerId And cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					"  GROUP BY MONTH(cpid.modifyTime)";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				int i=0;
				for (DateNum dateNum : customerWeekDateNums) {
					if(i==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"月'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"月'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					i++;
					if(i!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
					}
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
				if(i>1){
					if(start.equals(format.format(new Date()))){
						request.setAttribute("avageCustomer", avageCustomer/(i-1));
					}else{
						request.setAttribute("avageCustomer", avageCustomer/i);
					}
				}else{
					request.setAttribute("avageCustomer", avageCustomer/i);
				}
				request.setAttribute("monthNum", i);
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					" YEAR(cpid.modifyTime)='"+start+"' AND cust.dbid=cpid.customerId AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" AND csr.comeType=paramType And  YEAR(cpid.modifyTime)='"+start+"'  And "+selSql ;
			//来店
			String comeShopSql = "SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"csr.customerId=cust.dbid AND cpid.customerId=cust.dbid AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+" AND (csr.comeType=1 or csr.comeType is null) AND  YEAR(cpid.modifyTime)='"+start+"'  And "+selSql ;
			Object comeShopNum = statisticalSalerManageImpl.queryCount(comeShopSql);
			request.setAttribute("comeShopNum", comeShopNum);
			//来电
			String comePhoneSql = comeTypeSql.replace("paramType", "2");
			Object comePhoneNum = statisticalSalerManageImpl.queryCount(comePhoneSql);
			request.setAttribute("comePhoneNum", comePhoneNum);
			//活动
			String comeActiveSql = comeTypeSql.replace("paramType", "3");
			Object comeActiveNum = statisticalSalerManageImpl.queryCount(comeActiveSql);
			request.setAttribute("comeActiveNum", comeActiveNum);
			//特卖会
			String comeSpecelSql = comeTypeSql.replace("paramType", "4");
			Object comeSpecelNum = statisticalSalerManageImpl.queryCount(comeSpecelSql);
			request.setAttribute("comeSpecelNum", comeSpecelNum);
			//////////////////////////////////////////////////////////////////////////////////一周关注前五车系/////////////////////////////////////////////////////////////
			String carserySql="SELECT " +
					" cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE " +
					"cust.dbid=cpid.customerId AND cs.dbid=cpid.carSeriyId AND YEAR(cpid.modifyTime)='"+start+"' AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"MONTH(cpid.modifyTime) AS createFolderTime,COUNT(MONTH(cpid.modifyTime)) AS totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerpidbookingrecord cpid " +
							"WHERE " +
							"cust.dbid=cpid.customerId AND cpid.carSeriyId="+carSerCount.getSerid()+" AND  YEAR(cpid.modifyTime)='"+start+"' AND cpid.pidStatus="+CustomerPidBookingRecord.FINISHED+"  And "+selSql +
							" GROUP BY MONTH(cpid.modifyTime)";
					if(i==0){
						buffCarseryValues.append("{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}else{
						buffCarseryValues.append(",{");
						buffCarseryValues.append("name:'"+carSerCount.getSerName()+"',");
						List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(carserDateSql);
						if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
							buffCarseryValues.append("data:[");
							int j=0;
							for (DateNum dateNum : queryCustomerWeek) {
								if(j==0){
									buffCarseryValues.append(dateNum.getTotalNum());
								}else{
									buffCarseryValues.append(","+dateNum.getTotalNum());
								}
								j++;
							}
							buffCarseryValues.append("]");
						}
						buffCarseryValues.append("}");
					}
					i++;
				}
				buffCarseryValues.append("]");
				request.setAttribute("buffCarseryValues", buffCarseryValues.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerSuccessYear";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void customerSuccessDep() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		//天type：day，7天type：7day，周：week，月：month；年：year
		String type=request.getParameter("type");
		Integer depId = ParamUtil.getIntParam(request, "depId", -1);
		Date start=null;
		try{
			
			String dateParam="";
			if(type.equals("day")){
				if(null!=startTime&&startTime.trim().length()>0){
					start = DateUtil.string2Date(startTime);
				}else{
					start=new Date();
				}
				dateParam=" pid.modifyTime>='"+DateUtil.format(start)+"'" +" AND pid.modifyTime<'"+DateUtil.format(DateUtil.nextDay(start))+"' ";
			}
			if(type.equals("7day")){
				dateParam=" TO_DAYS(NOW()) - TO_DAYS(pid.modifyTime) <7 ";
			}
			if(type.equals("week")){
				dateParam=" (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(pid.modifyTime))<7 AND  YEAR(CURDATE())=YEAR(pid.modifyTime) ";
			}
			if(type.equals("month")){
				SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
				String start2="";
				if(null!=startTime&&startTime.trim().length()>0){
					start2 = startTime;
				}else{
					start2=format.format(new Date());
				}
				dateParam=" DATE_FORMAT(pid.modifyTime,'%Y-%m')='"+start2+"' ";
			}
			
			if(type.equals("year")){
				SimpleDateFormat format=new SimpleDateFormat("yyyy");
				String start2="";
				if(null!=startTime&&startTime.trim().length()>0){
					start2 = startTime;
				}else{
					start2=format.format(new Date());
				}
				dateParam=" YEAR(pid.modifyTime)='"+start2+"' ";
			}
			
			//车系部门统计
			String depatmentSql="SELECT cs.dbid as serid,cs.`name` AS serName,COUNT(cs.dbid) as countNum FROM " +
					"cust_customer cust,cust_customerpidbookingrecord pid,set_carseriy cs " +
					"WHERE " +
					"cust.dbid=pid.customerId AND cust.successDepartmentId="+depId+" AND pid.pidStatus="+CustomerPidBookingRecord.FINISHED+" AND "+dateParam+" AND pid.carSeriyId=cs.dbid " +
					"GROUP BY cs.dbid order by countNum DESC";
			StringBuffer bufferString= new StringBuffer("<table class=\"table table-bordered table-striped\" style='min-width:280px;max-width:320px;'>		" +
					"<tbody>"+
					"<tr>"+
						"<td align=\"center\" width=\"40\">车系</td>"+
						"<td align=\"center\" width=\"40\">数量</td>"+
					"</tr>");
			List<CarSerCount> carSerCounts = statisticalManageImpl.querStatic(depatmentSql);
			if(null!=carSerCounts){
				for (CarSerCount carSerCount : carSerCounts) {
					bufferString.append("<tr>");
					bufferString.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;'>"+carSerCount.getSerName()+"</td>");
					bufferString.append("<td align='center' valign='middle' style=''vertical-align: middle;'>"+carSerCount.getCountNum()+"</td>");
					bufferString.append("</tr>");
				}
			}else{
				bufferString.append("<tr>");
				bufferString.append("<td id='trTd' align='center' colspan='2' valign='middle' style=''vertical-align: middle;'>无车系数据</td>");
				bufferString.append("</tr>");
			}
			bufferString.append("</tbody>");
			bufferString.append("</table>");
			renderHtml(bufferString.toString());
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderHtml("error");
		}
	}
}
