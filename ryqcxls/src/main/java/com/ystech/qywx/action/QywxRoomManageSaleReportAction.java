package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.DateNum;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("qywxRoomManageSaleReportAction")
@Scope("prototype")
public class QywxRoomManageSaleReportAction extends BaseController{
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
	 * 功能描述：当天信息综合分析
	 * 参数描述：
	 * 1、登记客户多少人；
	 * 2、订单多少人；
	 * 3、成交客户多少；
	 * 4、剩余订单
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String todayStatic() throws Exception {
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
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust where  cust.createFolderTime>='"+DateUtil.format(start)+"' AND cust.createFolderTime<'"+DateUtil.format(end)+"' and cust.customerType=1 And "+selSql;
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			
			//登记客户各等级数量
			Object levelCA = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELA,selSql);
			Object levelCB = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELB,selSql);
			Object levelCC = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELC,selSql);
			Object levelCO = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELO,selSql);
			request.setAttribute("levelCA", levelCA);
			request.setAttribute("levelCB", levelCB);
			request.setAttribute("levelCC", levelCC);
			request.setAttribute("levelCO", levelCO);
			
			request.setAttribute("start", start);
			request.setAttribute("title", title);
			
			//统计当天数据情况
			String todayCarSerirySql="SELECT cs.dbid as serid,cs.`name` as serName,COUNT(cbu.carSeriyId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerbussi cbu,set_carseriy cs " +
					"WHERE" +
					"	cust.dbid=cbu.customerId AND cbu.carSeriyId=cs.dbid AND cust.createFolderTime>='"+DateUtil.format(start)+
					"' AND cust.createFolderTime<'"+DateUtil.format(end)+"' and cust.customerType=1 AND "+selSql+
					" GROUP BY cs.dbid ";
			
			List<CarSerCount> todayCarSerirys = statisticalManageImpl.querStatic(todayCarSerirySql);
			request.setAttribute("todayCarSerirys", todayCarSerirys);
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "todayStatic";
	}
	/**
	 * 功能描述：订单客户统计
	 * 参数描述：1、按部门，车系统计；2、按车系统计；3、按经销商类型统计
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unused", "unused" })
	public String customerOrder() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			String title="";
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				title=format.format(start)+"订单报表";
				end=DateUtil.nextDay(start);
			}else{
				title=format.format(new Date())+"订单报表";
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
					"	cust.dbid=cpid.customerId AND cpid.carSeriyId=cs.dbid AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"'"+" AND "+selSql+
					" GROUP BY cs.dbid ";
			List<CarSerCount> carseriyTotals = statisticalManageImpl.querStatic(todayCarSerirySql);
			request.setAttribute("carseriyTotals", carseriyTotals);
			
			//统计当天品牌数据情况
			String brandSql="SELECT br.dbid as serid,br.`name` as serName,COUNT(cpid.brandId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerpidbookingrecord cpid,set_brand br " +
					"WHERE" +
					"	cust.dbid=cpid.customerId AND cpid.brandId=br.dbid AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"'"+" AND "+selSql+
					" GROUP BY br.dbid ";
			List<CarSerCount> brandTotals = statisticalManageImpl.querStatic(brandSql);
			request.setAttribute("brandTotals", brandTotals);
			
			
			
		
			request.setAttribute("start", start);
			request.setAttribute("title", title);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerOrder";
	}
	
	/**
	 * 功能描述：集客7日报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customer7Day() throws Exception {
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
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid()+" ";
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid()+" ";
			}
			
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust where  cust.createFolderTime>='"+DateUtil.format(start)+"' AND cust.createFolderTime<'"+DateUtil.format(end)+"' and cust.customerType=1 And "+selSql;
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
			String sql="SELECT DATE_FORMAT(cust.createFolderTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(cust.createFolderTime,'%y-%m-%d')) AS totalNum FROM cust_customer cust" +
					"  WHERE TO_DAYS(NOW()) - TO_DAYS(cust.createFolderTime) <7 AND cust.customerType=1 AND " +selSql+
					"  GROUP BY DATE_FORMAT(cust.createFolderTime,'%y-%m-%d')";
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
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			request.setAttribute("avageCustomer", avageCustomer/6);
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust " +
					"WHERE " +
					" TO_DAYS(NOW()) - TO_DAYS(cust.createFolderTime) <7 AND cust.customerType=1 AND cust.bussiStaffId AND " +selSql;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND TO_DAYS(NOW()) - TO_DAYS(cust.createFolderTime) <7 AND cust.customerType=1 AND " +selSql;
			//来店
			String comeShopSql = comeTypeSql.replace("paramType", "1");
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
					" cs.dbid as serid,cs.`name` as serName,COUNT(cb.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerbussi cb " +
					"WHERE " +
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 AND " +selSql+ 
					"GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"DATE_FORMAT(cust.createFolderTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(cust.createFolderTime,'%Y-%m-%d')) AS totalNum " +
							"FROM " +
							"cust_customer cust,cust_customerbussi cb " +
							"WHERE " +
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 AND " +selSql +
							"GROUP BY DATE_FORMAT(cust.createFolderTime,'%Y-%m-%d')";
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
		return "customer7Day";
	}
	/**
	 * 功能描述：集客周报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerWeek() throws Exception {
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
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid()+" ";
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid()+" ";
			}
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust where  WEEKOFYEAR(CURDATE())=WEEKOFYEAR(createFolderTime) and YEAR(createFolderTime)=YEAR(CURDATE()) and customerType=1 AND "+selSql;
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
					"WEEKOFYEAR(createFolderTime) as createFolderTime,COUNT(*) as totalNum " +
					"FROM " +
					"cust_customer cust " +
					"WHERE " +
					"(WEEKOFYEAR(CURDATE())-WEEKOFYEAR(createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(createFolderTime) AND customerType=1 AND "+selSql+
					"GROUP BY WEEKOFYEAR(createFolderTime) ORDER BY WEEKOFYEAR(createFolderTime)";
			List<DateNum> customerWeekDateNums = statisticalManageImpl.queryCustomerWeek(sql);
			int param=0;
			if(null!=customerWeekDateNums&&customerWeekDateNums.size()>0){
				buffButtomTitles.append("[");
				buffValues.append("[");
				for (DateNum dateNum : customerWeekDateNums) {
					if(param==0){
						buffButtomTitles.append("'"+dateNum.getDate()+"周'");
						buffValues.append(dateNum.getTotalNum());
					}else{
						buffButtomTitles.append(",'"+dateNum.getDate()+"周'");
						buffValues.append(","+dateNum.getTotalNum());
					}
					param++;
					if(param!=customerWeekDateNums.size()){
						avageCustomer=avageCustomer+dateNum.getTotalNum();
					}
					if(param>1){
						request.setAttribute("avageCustomer", avageCustomer/(param-1));
					}else{
						request.setAttribute("avageCustomer", avageCustomer);
					}
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
				request.setAttribute("paramWeek", param);
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			
			
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//统计最近7周数据总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust " +
					"WHERE " +
					" (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(createFolderTime) AND customerType=1 And "+selSql;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND cust.customerType=1 And "+selSql;
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND cust.customerType=1 And "+selSql;
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
					" cs.dbid as serid,cs.`name` as serName,COUNT(cb.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerbussi cb " +
					"WHERE " +
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 And "+selSql+
					"GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"WEEKOFYEAR(createFolderTime) as createFolderTime,COUNT(*) as totalNum " +
							"FROM " +
							"cust_customer cust,cust_customerbussi cb " +
							"WHERE " +
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 And " +selSql+
							"GROUP BY WEEKOFYEAR(createFolderTime)";
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
		return "customerWeek";
	}
	/**
	 * 功能描述：集客月报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerMonth() throws Exception {
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
			request.setAttribute("monthDay", start.subSequence(5, 7));
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust where  createFolderTime>='"+DateUtil.format(new Date())+"' AND createFolderTime<'"+DateUtil.format(new Date())+"' and customerType=1 AND "+selSql;
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
			String sql="SELECT DATE_FORMAT(createFolderTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(createFolderTime,'%d')) AS totalNum FROM cust_customer cust" +
					"  WHERE DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1" +" AND "+selSql+
					"  GROUP BY DATE_FORMAT(createFolderTime,'%d')";
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
					avageCustomer=avageCustomer+dateNum.getTotalNum();
				}
				buffButtomTitles.append("]");
				buffValues.append("]");
				request.setAttribute("avageCustomer", avageCustomer/i);
			}
			request.setAttribute("buffButtomTitles", buffButtomTitles.toString());
			request.setAttribute("buffValues", buffValues.toString());
			
			//////////////////////////////////////////////////////////////////////////////////集客类型/////////////////////////////////////////////////////////////
			//一周来电总数
			String totalWeekSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust " +
					"WHERE " +
					" DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1  AND "+selSql;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1  AND "+selSql;
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1  AND "+selSql;
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
					" cs.dbid as serid,cs.`name` as serName,COUNT(cb.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerbussi cb " +
					"WHERE " +
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +"  AND "+selSql+
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"DATE_FORMAT(createFolderTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(createFolderTime,'%d')) as totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerbussi cb " +
							"WHERE " +
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +"  AND "+selSql +
							" GROUP BY DATE_FORMAT(createFolderTime,'%d')";
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
		return "customerMonth";
	}
	/**
	 * 功能描述：集客年报
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String customerYear() throws Exception {
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
			request.setAttribute("monthDay",start);
			request.setAttribute("nowMonthDay",format.format(new Date()));
			
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cust.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cust.departmentId="+currentUser.getDepartment().getDbid();
			}
			
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer cust where MONTH(createFolderTime)=MONTH(CURDATE()) and YEAR(createFolderTime)='"+start+"' and customerType=1 And "+selSql;
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
			String sql="SELECT MONTH(createFolderTime) AS createFolderTime,COUNT(MONTH(createFolderTime)) AS totalNum FROM cust_customer cust" +
					"  WHERE YEAR(createFolderTime)='"+start+"' AND customerType=1" +" And "+selSql+
					"  GROUP BY MONTH(createFolderTime)";
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
					"cust_customer cust " +
					"WHERE " +
					" YEAR(createFolderTime)='"+start+"' AND customerType=1 And "+selSql;
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND YEAR(createFolderTime)='"+start+"' AND customerType=1 And "+selSql;
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND YEAR(createFolderTime)='"+start+"' AND customerType=1 And "+selSql;
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
					" cs.dbid as serid,cs.`name` as serName,COUNT(cb.carSeriyId) as countNum " +
					"FROM " +
					"set_carseriy cs,cust_customer cust,cust_customerbussi cb " +
					"WHERE " +
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND YEAR(createFolderTime)='"+start+"' AND customerType=1 And "+selSql+
					" GROUP BY cs.dbid ORDER BY countNum DESC ";
			List<CarSerCount> carSerCountsTop5 = statisticalManageImpl.querStatic(carserySql);
			request.setAttribute("carSerCountsTop5", carSerCountsTop5);
			StringBuffer buffCarseryValues=new StringBuffer();
			if(null!=carSerCountsTop5&&carSerCountsTop5.size()>0){
				buffCarseryValues.append("[");
				int i=0;
				for (CarSerCount carSerCount : carSerCountsTop5) {
					String carserDateSql="SELECT " +
							"MONTH(createFolderTime) AS createFolderTime,COUNT(MONTH(createFolderTime)) AS totalNum  " +
							"FROM " +
							"cust_customer cust,cust_customerbussi cb " +
							"WHERE " +
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND YEAR(createFolderTime)='"+start+"' AND customerType=1 And "+selSql+
							" GROUP BY MONTH(createFolderTime)";
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
		return "customerYear";
	}
	/**
	 * 功能描述：待交车客户统计(留存订单）
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String waitingCustomerCar() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			User currentUser = getSessionUser();
			String selSql="";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				selSql=selSql+" cuts.enterpriseId="+currentUser.getEnterprise().getDbid();
			}else{
				selSql=selSql+" cuts.departmentId="+currentUser.getDepartment().getDbid();
			}
			//待交车客户 总数
			String waitingCarSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus!="+CustomerPidBookingRecord.FINISHED +" AND cpr.pidStatus!=-1 And "+selSql;
			Object waitingCar = statisticalSalerManageImpl.queryCount(waitingCarSql);
			request.setAttribute("waitingCar", waitingCar);
			//正常待交车
			String commonWatingCountSql=" SELECT COUNT(*) as total FROM cust_customer AS cuts,cust_customerpidbookingrecord AS cpr WHERE cuts.dbid=cpr.customerId AND cpr.pidStatus="+CustomerPidBookingRecord.PRINT +" And "+selSql;
			Object commonWatingCount = statisticalSalerManageImpl.queryCount(commonWatingCountSql);
			request.setAttribute("commonWatingCount", commonWatingCount);
		 	
			
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "waitingCustomerCar";
	}
	
}
