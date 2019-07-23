package com.ystech.qywx.action;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DatabaseUnitHelper;
import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.set.model.LoanType;

@Component("qywxHfLoanTypeAction")
@Scope("prototype")
public class QywxHfLoanTypeAction extends BaseController{
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String day() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		Date start=null;
		Date end=null;
		try{
			SimpleDateFormat format=new SimpleDateFormat("MM月dd日");
			if(null!=startTime&&startTime.trim().length()>0){
				start = DateUtil.string2Date(startTime);
				end=DateUtil.nextDay(start);
			}else{
				start=new Date();
				end=DateUtil.nextDay(new Date());
			}
			request.setAttribute("startTime", start);
			String dateSql=" AND cpid.modifyTime>='"+DateUtil.format(start)+"' AND cpid.modifyTime<'"+DateUtil.format(end)+"'";
			
			
			getTotalNum(dateSql);
			List<LoanType> selLoanTypes = queryDate(dateSql, 1);
			String sefTableLoanType = getTableString(selLoanTypes, dateSql, 1);
			request.setAttribute("sefTableLoanType", sefTableLoanType);
			List<LoanType> netLoanTypes = queryDate(dateSql, 2);
			String netTableLoanType = getTableString(netLoanTypes, dateSql, 2);
			request.setAttribute("netTableLoanType", netTableLoanType);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "day";
	}
	private void getTotalNum(String dateSql) {
		HttpServletRequest request = this.getRequest();
		int totalNum = queryTotalNum(dateSql, 0);
		request.setAttribute("totalNum", totalNum);
		int selfTotalNum = queryTotalNum(dateSql, 1);
		request.setAttribute("selfTotalNum", selfTotalNum);
		int netTotalNum = queryTotalNum(dateSql, 2);
		request.setAttribute("netTotalNum", netTotalNum);
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String week() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			String dateSql=" and TO_DAYS(NOW()) - TO_DAYS(cpid.modifyTime) <7 ";
			List<LoanType> selLoanTypes = queryDate(dateSql, 1);
			String sefTableLoanType = getTableString(selLoanTypes, dateSql, 1);
			request.setAttribute("sefTableLoanType", sefTableLoanType);
			List<LoanType> netLoanTypes = queryDate(dateSql, 2);
			String netTableLoanType = getTableString(netLoanTypes, dateSql, 2);
			request.setAttribute("netTableLoanType", netTableLoanType);
			
			getTotalNum(dateSql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "week";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String month() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("start", start);
			String dateSql=" and DATE_FORMAT(cpid.modifyTime,'%Y-%m')='"+start+"' ";
			List<LoanType> selLoanTypes = queryDate(dateSql, 1);
			String sefTableLoanType = getTableString(selLoanTypes, dateSql, 1);
			request.setAttribute("sefTableLoanType", sefTableLoanType);
			List<LoanType> netLoanTypes = queryDate(dateSql, 2);
			String netTableLoanType = getTableString(netLoanTypes, dateSql, 2);
			request.setAttribute("netTableLoanType", netTableLoanType);
			
			getTotalNum(dateSql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "month";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String year() throws Exception {
		HttpServletRequest request = this.getRequest();
		String startTime = request.getParameter("startTime");
		String start=null;
		try{
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(null!=startTime&&startTime.trim().length()>0){
				start = startTime;
			}else{
				start=format.format(new Date());
			}
			request.setAttribute("monthDay",start);
			request.setAttribute("nowMonthDay",format.format(new Date()));
			String dateSql=" and YEAR(cpid.modifyTime)='"+start+"' ";
			List<LoanType> selLoanTypes = queryDate(dateSql, 1);
			String sefTableLoanType = getTableString(selLoanTypes, dateSql, 1);
			request.setAttribute("sefTableLoanType", sefTableLoanType);
			List<LoanType> netLoanTypes = queryDate(dateSql, 2);
			String netTableLoanType = getTableString(netLoanTypes, dateSql, 2);
			request.setAttribute("netTableLoanType", netTableLoanType);
			
			getTotalNum(dateSql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "year";
	}
	/**
	 * 公用时间查询方法
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	private List<LoanType> queryDate(String dateSql,Integer customerType){
		String sql="SELECT A.dbid,A.`name`,B.totalNum " +
				"FROM" +
				"(" +
				"	SELECT dbid,`name` FROM set_loantype WHERE parentId IS NULL" +
				")A " +
				"LEFT JOIN " +
				"(SELECT loan.dbid,loan.`name`,COUNT(loan.dbid) AS totalNum " +
				"FROM " +
				"set_loantype loan,cust_customer cust,cust_customerpidbookingrecord cpid,cust_ordercontractexpenses oce " +
				"WHERE " +
				"cust.dbid=cpid.customerId AND cust.dbid=oce.customerId" +
				" AND oce.loanTypeId=loan.dbid AND loan.parentId IS NULL  AND cpid.pidStatus=2 AND cust.customerType=" +customerType+" "+dateSql+
				" GROUP BY loan.dbid )" +
				"B ON A.dbid=B.dbid order by B.totalNum DESC";
		List<LoanType> loanTypes=new ArrayList<LoanType>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				LoanType loanType=new LoanType();
				int dbid = resultSet.getInt("dbid");
				String name = resultSet.getString("name");
				int totalNum = resultSet.getInt("totalNum");
				loanType.setDbid(dbid);
				loanType.setName(name);
				loanType.setTotalNum(totalNum);
				loanTypes.add(loanType);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return loanTypes;
	}
	/**
	 * 统计总数
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	private int queryTotalNum(String dateSql,Integer customerType){
		String sql="SELECT COUNT(loan.dbid) AS totalNum " +
				"FROM " +
				"set_loantype loan,cust_customer cust,cust_customerpidbookingrecord cpid,cust_ordercontractexpenses oce " +
				"WHERE " +
				"cust.dbid=cpid.customerId AND cust.dbid=oce.customerId" +
				" AND oce.loanTypeId=loan.dbid  AND cpid.pidStatus=2 "+dateSql;
		if(customerType>0){
			sql=sql+" AND cust.customerType=" +customerType;
		}
		int totalNum=0;
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				totalNum = resultSet.getInt("totalNum");
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		return totalNum;
	}
	/**
	 * 公用时间查询方法
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	private List<LoanType> queryDateChild(String dateSql,Integer customerType,LoanType parent){
		String sql="SELECT loan.dbid,loan.`name`,COUNT(loan.dbid) AS totalNum " +
				"FROM " +
				"set_loantype loan,cust_customer cust,cust_customerpidbookingrecord cpid,cust_ordercontractexpenses oce " +
				"WHERE " +
				"cust.dbid=cpid.customerId AND cust.dbid=oce.customerId" +
				" AND oce.loanTypeId=loan.dbid AND loan.parentId="+parent.getDbid()+"  AND cpid.pidStatus=2 AND cust.customerType=" +customerType+" "+dateSql+
				" GROUP BY loan.dbid order by totalNum DESC";
		List<LoanType> loanTypes=new ArrayList<LoanType>();
		try {
			DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
			Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
			Statement createStatement = jdbcConnection.createStatement();
			ResultSet resultSet = createStatement.executeQuery(sql);
			while (resultSet.next()) {
				LoanType loanType=new LoanType();
				int dbid = resultSet.getInt("dbid");
				String name = resultSet.getString("name");
				int totalNum = resultSet.getInt("totalNum");
				loanType.setDbid(dbid);
				loanType.setName(name);
				loanType.setTotalNum(totalNum);
				loanTypes.add(loanType);
			}
			createStatement.close();
			jdbcConnection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return loanTypes;
	}
	/**
	 * 获取组装数据
	 * @param parents
	 * @param dateSql
	 * @param customerType
	 * @return
	 */
	private String getTableString(List<LoanType> parents,String dateSql,Integer customerType){
		StringBuffer buffer=new StringBuffer();
		if(null==parents||parents.size()<=0){
			buffer.append("<tr>");
				buffer.append("<td id='trTd' align='center' colspan='3'>无数据</td>");
			buffer.append("</tr>");
			return buffer.toString();
		}
		for(int i=0;i<parents.size();i++){
			LoanType loanType = parents.get(i);
			List<LoanType> childs = queryDateChild(dateSql, customerType, loanType);
			if(null==childs||childs.size()<=0){
				buffer.append("<tr>");
					buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;'>"+loanType.getName()+"</td>");
					buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;'>无</td>");
					buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;'>"+loanType.getTotalNum()+"</td>");
				buffer.append("</tr>");
			}else{
				int j=0;
				int totolNum=loanType.getTotalNum();
				for (LoanType loanType2 : childs) {
					if(j==0){
						buffer.append("<tr>");
						buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;' rowspan='"+(childs.size()+1)+"'>"+loanType.getName()+"["+loanType.getTotalNum()+"]</td>");
						if(null!=loanType2.getName()){
							buffer.append("<td align='center'>"+loanType2.getName()+"</td>");
						}else{
							buffer.append("<td align='center'>无</td>");
						}
						buffer.append("<td align='center'><a href='javascript:void(-1)'>"+loanType2.getTotalNum()+"</a></td>");
						buffer.append("</tr>");
						totolNum=totolNum+loanType2.getTotalNum();
					}else{
						buffer.append("<tr>");
						if(null!=loanType2.getName()){
							buffer.append("<td align='center'>"+loanType2.getName()+"</td>");
						}else{
							buffer.append("<td align='center'>无</td>");
						}
						buffer.append("<td align='center'><a href='javascript:void(-1)'>"+loanType2.getTotalNum()+"</a></td>");
						buffer.append("</tr>");
						totolNum=totolNum+loanType2.getTotalNum();
					}
					j++;
				}
				buffer.append("<tr> <td align='right' colspan='2'>合计："+totolNum+"</td></tr>");
			}
		}
		return buffer.toString();
	}
}
