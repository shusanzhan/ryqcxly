package com.ystech.qywx.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CarSerCount;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.DateNum;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.StatisticalManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("qywxSaleReportAction")
@Scope("prototype")
public class QywxSaleReportAction extends BaseController{
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
			String parameter = request.getParameter("");
			System.out.println("===");
		} catch (Exception e) {
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
	public String uun() throws Exception {
		HttpServletRequest request = this.getRequest();
		//查询类型，1、为今天、2、最近7天；3、最近7周；4、按月天；5、年月
		Integer type = ParamUtil.getIntParam(request, "type", 1);
		String startTime = request.getParameter("startTime");
		String title="";
		String dateSql="";
		String orderBySql="";
		try {
			User sessionUser = getSessionUser();
			Date start=null;
			Date end=null;
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
			if(type==2){
				dateSql="TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7";
				orderBySql="GROUP BY DATE_FORMAT(createFolderTime,'%y-%m-%d')";
			}
			
			if(null!=sessionUser){
				
			}
			
			
			String carSql="";
			String depSql="";
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "uun";
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
		//查询类型，1、为今天、2、最近7天；3、最近7周；4、按月天；5、年月
		Integer type = ParamUtil.getIntParam(request, "type", 1);
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
			if(type==1){
				
			}
			
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where  createFolderTime>='"+DateUtil.format(start)+"' AND createFolderTime<'"+DateUtil.format(end)+"' and customerType=1";
			//新增加客户
			Object newsCount = statisticalSalerManageImpl.queryCount(newsCountSql);
			request.setAttribute("newsCount", newsCount);
			
			//登记客户各等级数量
			Object levelCA = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELA);
			Object levelCB = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELB);
			Object levelCC = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELC);
			Object levelCO = statisticalSalerManageImpl.queryCountFirstLevelCount(start, end, null, CustomerPhase.LEVELO);
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
					"	cust.dbid=cbu.customerId AND cbu.carSeriyId=cs.dbid AND cust.createFolderTime>='"+DateUtil.format(start)+"' AND cust.createFolderTime<'"+DateUtil.format(end)+"' and cust.customerType=1"+
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
			
			//统计当天数车系据情况
			String todayCarSerirySql="SELECT cs.dbid as serid,cs.`name` as serName,COUNT(cpid.carSeriyId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerpidbookingrecord cpid,set_carseriy cs " +
					"WHERE" +
					"	cust.dbid=cpid.customerId AND cpid.carSeriyId=cs.dbid AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"'"+
					" GROUP BY cs.dbid ";
			List<CarSerCount> carseriyTotals = statisticalManageImpl.querStatic(todayCarSerirySql);
			request.setAttribute("carseriyTotals", carseriyTotals);
			
			//统计当天品牌数据情况
			String brandSql="SELECT br.dbid as serid,br.`name` as serName,COUNT(cpid.brandId) as countNum " +
					"FROM" +
					"	cust_customer cust,cust_customerpidbookingrecord cpid,set_brand br " +
					"WHERE" +
					"	cust.dbid=cpid.customerId AND cpid.brandId=br.dbid AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"'"+
					" GROUP BY br.dbid ";
			List<CarSerCount> brandTotals = statisticalManageImpl.querStatic(brandSql);
			request.setAttribute("brandTotals", brandTotals);
			
			//自有店数据统计合
			String selfShopTotalSql="SELECT " +
					"COUNT(*) as total " +
					"FROM sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE" +
					" dep.dbid=cust.departmentId AND cpid.customerId=cust.dbid "+
					" AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"' and cust.customerType=1";
			Object selfShopTotal = statisticalSalerManageImpl.queryCount(selfShopTotalSql);
			request.setAttribute("selfShopTotal", selfShopTotal);
			//二网数据统计合
			String netTotalSql="SELECT " +
					"COUNT(*) as total " +
					"FROM	sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE" +
					" dep.dbid=cust.departmentId AND cpid.customerId=cust.dbid "+
					" AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"' and cust.customerType=2";
			Object netTotal = statisticalSalerManageImpl.queryCount(netTotalSql);
			request.setAttribute("netTotal", netTotal);
			//部门查询(一网）
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				List<Department> depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM	sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE" +
					" dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND cpid.customerId=cust.dbid "+
					" AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"' and cust.customerType=1 GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			
			//部门查询(二网）
			Department netDepart = departmentManageImpl.findUniqueBy("name", "网络部");
			if(null!=netDepart){
				String netDepartmentSql="SELECT * FROM sys_department WHERE parentId="+netDepart.getDbid();
				List<Department> netDepatments = departmentManageImpl.executeSql(netDepartmentSql, null);
				request.setAttribute("netDepatments", netDepatments);
			}
			//查询部门数据(二网）
			String netCountUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM sys_department dep,cust_customer cust,cust_customerpidbookingrecord cpid " +
					"WHERE" +
					" dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND cpid.customerId=cust.dbid  "+
					" AND cpid.createTime>='"+DateUtil.format(start)+"' AND cpid.createTime<'"+DateUtil.format(end)+"' and cust.customerType=2 GROUP BY dep.dbid";
			request.setAttribute("netCountUserByDepId", netCountUserByDepId);
		
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
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where  createFolderTime>='"+DateUtil.format(start)+"' AND createFolderTime<'"+DateUtil.format(end)+"' and customerType=1";
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
			String sql="SELECT DATE_FORMAT(createFolderTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(createFolderTime,'%y-%m-%d')) AS totalNum FROM cust_customer" +
					"  WHERE TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1" +
					"  GROUP BY DATE_FORMAT(createFolderTime,'%y-%m-%d')";
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
					" TO_DAYS(NOW()) - TO_DAYS(cust.createFolderTime) <7 AND cust.customerType=1";
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND TO_DAYS(NOW()) - TO_DAYS(cust.createFolderTime) <7 AND cust.customerType=1";
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
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 " +
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
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 " +
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
			//////////////////////////////////////////////////////////////////////部门集客周数据集////////////////////////////////////////////////////////////////////////
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			List<Department> depatments=null;
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM " +
					"cust_customer cust,sys_department dep " +
					"WHERE " +
					"dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 " +
					"GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			StringBuffer buffDepartmentValues=new StringBuffer();
			if(null!=depatments&&depatments.size()>0){
				Set<Department> result=new HashSet<Department>();
				for (Department department : depatments) {
					Set<Department> children = department.getChildren();
					result.addAll(children);
				}
				if (result.size()>0) {
					buffDepartmentValues.append("[");
					int i=0;
					for (Department department : result) {
						String departSql="SELECT " +
								"DATE_FORMAT(cust.createFolderTime,'%m-%d') AS createFolderTime,COUNT(DATE_FORMAT(cust.createFolderTime,'%Y-%m-%d')) AS totalNum " +
								"FROM " +
								"cust_customer cust " +
								"WHERE " +
								"departmentId="+department.getDbid()+" AND TO_DAYS(NOW()) - TO_DAYS(createFolderTime) <7 AND customerType=1 " +
								"GROUP BY DATE_FORMAT(cust.createFolderTime,'%Y-%m-%d')";
						if(i==0){
							buffDepartmentValues.append("{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}else{
							buffDepartmentValues.append(",{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}
						i++;
					}
					buffDepartmentValues.append("]");
				}
			}
			request.setAttribute("buffDepartmentValues", buffDepartmentValues);
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
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where  WEEKOFYEAR(CURDATE())=WEEKOFYEAR(createFolderTime) and YEAR(createFolderTime)=YEAR(CURDATE()) and customerType=1";
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
					"cust_customer " +
					"WHERE " +
					"(WEEKOFYEAR(CURDATE())-WEEKOFYEAR(createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(createFolderTime) AND customerType=1 " +
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
					" (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(createFolderTime) AND customerType=1";
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND cust.customerType=1";
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND cust.customerType=1";
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
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 " +
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
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 " +
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
			//////////////////////////////////////////////////////////////////////部门集客周数据集////////////////////////////////////////////////////////////////////////
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			List<Department> depatments=null;
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM " +
					"cust_customer cust,sys_department dep " +
					"WHERE " +
					"dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 " +
					"GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			StringBuffer buffDepartmentValues=new StringBuffer();
			if(null!=depatments&&depatments.size()>0){
				Set<Department> result=new HashSet<Department>();
				for (Department department : depatments) {
					Set<Department> children = department.getChildren();
					result.addAll(children);
				}
				if (result.size()>0) {
					buffDepartmentValues.append("[");
					int i=0;
					for (Department department : result) {
						String departSql="SELECT " +
								"WEEKOFYEAR(createFolderTime) as createFolderTime,COUNT(*) as totalNum " +
								"FROM " +
								"cust_customer cust " +
								"WHERE " +
								"departmentId="+department.getDbid()+" AND (WEEKOFYEAR(CURDATE())-WEEKOFYEAR(cust.createFolderTime))<7 AND  YEAR(CURDATE())=YEAR(cust.createFolderTime) AND customerType=1 " +
								"GROUP BY WEEKOFYEAR(createFolderTime)";
						if(i==0){
							buffDepartmentValues.append("{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}else{
							buffDepartmentValues.append(",{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}
						i++;
					}
					buffDepartmentValues.append("]");
				}
			}
			request.setAttribute("buffDepartmentValues", buffDepartmentValues);
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
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where  createFolderTime>='"+DateUtil.format(new Date())+"' AND createFolderTime<'"+DateUtil.format(new Date())+"' and customerType=1";
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
			String sql="SELECT DATE_FORMAT(createFolderTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(createFolderTime,'%d')) AS totalNum FROM cust_customer" +
					"  WHERE DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1" +
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
					" DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1";
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1" ;
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1";
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
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +
					"GROUP BY cs.dbid ORDER BY countNum DESC ";
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
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +
							"GROUP BY DATE_FORMAT(createFolderTime,'%d')";
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
			//////////////////////////////////////////////////////////////////////部门集客周数据集////////////////////////////////////////////////////////////////////////
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			List<Department> depatments=null;
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM " +
					"cust_customer cust,sys_department dep " +
					"WHERE " +
					"dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +
					"GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			StringBuffer buffDepartmentValues=new StringBuffer();
			if(null!=depatments&&depatments.size()>0){
				Set<Department> result=new HashSet<Department>();
				for (Department department : depatments) {
					Set<Department> children = department.getChildren();
					result.addAll(children);
				}
				if (result.size()>0) {
					buffDepartmentValues.append("[");
					int i=0;
					for (Department department : result) {
						String departSql="SELECT " +
								"DATE_FORMAT(createFolderTime,'%d') AS createFolderTime,COUNT(DATE_FORMAT(createFolderTime,'%d')) as totalNum " +
								"FROM " +
								"cust_customer cust " +
								"WHERE " +
								"departmentId="+department.getDbid()+" AND DATE_FORMAT(createFolderTime,'%Y-%m')='"+start+"' AND customerType=1 " +
								"GROUP BY DATE_FORMAT(createFolderTime,'%d')";
						if(i==0){
							buffDepartmentValues.append("{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}else{
							buffDepartmentValues.append(",{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}
						i++;
					}
					buffDepartmentValues.append("]");
				}
			}
			request.setAttribute("buffDepartmentValues", buffDepartmentValues);
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
			/*****今天客户情况统计***/
			String newsCountSql="SELECT COUNT(*) as total FROM cust_customer where MONTH(createFolderTime)=MONTH(CURDATE()) and YEAR(createFolderTime)='"+start+"' and customerType=1";
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
			String sql="SELECT MONTH(createFolderTime) AS createFolderTime,COUNT(MONTH(createFolderTime)) AS totalNum FROM cust_customer" +
					"  WHERE YEAR(createFolderTime)='"+start+"' AND customerType=1" +
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
					" YEAR(createFolderTime)='"+start+"' AND customerType=1";
			Object totalWeekNum = statisticalSalerManageImpl.queryCount(totalWeekSql);
			request.setAttribute("totalWeekNum", totalWeekNum);
			
			String comeTypeSql="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND csr.comeType=paramType AND YEAR(createFolderTime)='"+start+"' AND customerType=1";
			//来店
			String comeShopSql ="SELECT " +
					"COUNT(*) as total " +
					"FROM " +
					"cust_customer cust,cust_customershoppingrecord csr " +
					"WHERE " +
					"csr.customerId=cust.dbid AND (csr.comeType=1 or csr.comeType is null ) AND YEAR(createFolderTime)='"+start+"' AND customerType=1";
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
					"cust.dbid=cb.customerId AND cs.dbid=cb.carSeriyId AND YEAR(createFolderTime)='"+start+"' AND customerType=1 " +
					"GROUP BY cs.dbid ORDER BY countNum DESC ";
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
							"cust.dbid=cb.customerId AND cb.carSeriyId="+carSerCount.getSerid()+" AND YEAR(createFolderTime)='"+start+"' AND customerType=1 " +
							"GROUP BY MONTH(createFolderTime)";
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
			//////////////////////////////////////////////////////////////////////部门集客周数据集////////////////////////////////////////////////////////////////////////
			Department saleDepart = departmentManageImpl.findUniqueBy("name", "销售部");
			List<Department> depatments=null;
			if(null!=saleDepart){
				String departmentSql="SELECT * FROM sys_department WHERE parentId="+saleDepart.getDbid();
				depatments = departmentManageImpl.executeSql(departmentSql, null);
				request.setAttribute("depatments", depatments);
			}
			//查询部门数据(一网）
			String countUserByDepId="SELECT " +
					"dep.`name` AS depName,COUNT(dep.dbid) totalNum " +
					"FROM " +
					"cust_customer cust,sys_department dep " +
					"WHERE " +
					"dep.dbid=cust.departmentId AND dep.parentId=paramDepId AND YEAR(createFolderTime)='"+start+"' AND customerType=1 " +
					"GROUP BY dep.dbid";
			request.setAttribute("countUserByDepId", countUserByDepId);
			
			StringBuffer buffDepartmentValues=new StringBuffer();
			if(null!=depatments&&depatments.size()>0){
				Set<Department> result=new HashSet<Department>();
				for (Department department : depatments) {
					Set<Department> children = department.getChildren();
					result.addAll(children);
				}
				if (result.size()>0) {
					buffDepartmentValues.append("[");
					int i=0;
					for (Department department : result) {
						String departSql="SELECT " +
								"MONTH(createFolderTime) AS createFolderTime,COUNT(MONTH(createFolderTime)) AS totalNum " +
								"FROM " +
								"cust_customer cust " +
								"WHERE " +
								"departmentId="+department.getDbid()+" AND YEAR(createFolderTime)='"+start+"' AND customerType=1 " +
								"GROUP BY MONTH(createFolderTime)";
						if(i==0){
							buffDepartmentValues.append("{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}else{
							buffDepartmentValues.append(",{");
							buffDepartmentValues.append("name:'"+department.getName().replace("销售部","")+"',");
							List<DateNum> queryCustomerWeek = statisticalManageImpl.queryCustomerWeek(departSql);
							if(null!=queryCustomerWeek&&queryCustomerWeek.size()>0){
								buffDepartmentValues.append("data:[");
								int j=0;
								for (DateNum dateNum : queryCustomerWeek) {
									if(j==0){
										buffDepartmentValues.append(dateNum.getTotalNum());
									}else{
										buffDepartmentValues.append(","+dateNum.getTotalNum());
									}
									j++;
								}
								buffDepartmentValues.append("]");
							}
							buffDepartmentValues.append("}");
						}
						i++;
					}
					buffDepartmentValues.append("]");
				}
			}
			request.setAttribute("buffDepartmentValues", buffDepartmentValues);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "customerYear";
	}
	
	private String getDepSql(){
		String sql="";
		User currentUser = getSessionUser();
		if(null!=currentUser){
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				sql=sql+" and cust.enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				if(null!=currentUser.getEnterprise()){
					sql=sql+" and cust.enterpriseId="+currentUser.getEnterprise().getDbid();
				}
			}
		}
		return sql;
	}
	private void getString(Enterprise enterprise){
		
	}
}
