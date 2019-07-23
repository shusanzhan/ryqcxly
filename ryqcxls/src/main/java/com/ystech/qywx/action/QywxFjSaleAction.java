package com.ystech.qywx.action;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.DateUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.FjSaler;
import com.ystech.cust.service.FjSalerManageImpl;

@Component("qywxFjSaleAction")
@Scope("prototype")
public class QywxFjSaleAction extends BaseController{
	private FjSalerManageImpl fjSalerManageImpl;
	@Resource
	public void setFjSalerManageImpl(FjSalerManageImpl fjSalerManageImpl) {
		this.fjSalerManageImpl = fjSalerManageImpl;
	}
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
			getValue(dateSql);
			//统计总数据
			getTotal(dateSql);
			
			//二网数据
			getTotalNet(dateSql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "day";
	}
	private void getValue(String dateSql) {
		HttpServletRequest request=this.getRequest();
		//附加总金额列表
		/*List<FjSaler> fjzjeSalers = fjSalerManageImpl.findByFjzje(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("fjzjeSalers", fjzjeSalers);*/
		
		List<FjSaler> decoreFjSalers = fjSalerManageImpl.findByDecore(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("decoreFjSalers", decoreFjSalers);
		
		List<FjSaler> netDecoreFjSalers = fjSalerManageImpl.findByDecore(dateSql, Customer.CUSTOMERTYPENETTOW);
		request.setAttribute("netDecoreFjSalers", netDecoreFjSalers);
		
		List<FjSaler> loanFjSalers = fjSalerManageImpl.findByLoan(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("loanFjSalers", loanFjSalers);
		
		List<FjSaler> netLoanFjSalers = fjSalerManageImpl.findByLoan(dateSql, Customer.CUSTOMERTYPENETTOW);
		request.setAttribute("netLoanFjSalers", netLoanFjSalers);
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
			getValue(dateSql);
			//统计总数据
			getTotal(dateSql);
			
			//二网数据
			getTotalNet(dateSql);
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
			getValue(dateSql);
			//统计总数据
			getTotal(dateSql);
			
			
			//二网数据
			getTotalNet(dateSql);
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
			getValue(dateSql);
			getTotal( dateSql);
			
			//二网数据
			getTotalNet(dateSql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "year";
	}
	/**
	 * 获取统计总数据
	 * @param dateSql
	 */
	private void getTotal( String dateSql) {
		HttpServletRequest request=this.getRequest();
		Object success = fjSalerManageImpl.countSuccess(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("success", success);
		List<FjSaler> countLoans = fjSalerManageImpl.countLoan(dateSql, Customer.CUSTOMERTYPECOMM);
		if (null!=countLoans&&countLoans.size()>0) {
			FjSaler fjSaler = countLoans.get(0);
			request.setAttribute("countLoan", fjSaler);
			
			BigInteger bigSuBigInteger=(BigInteger) success;
			float floatValue = bigSuBigInteger.floatValue();
			if(floatValue>0){
				Integer loanNum = fjSaler.getLoanNum();
				float per= loanNum/floatValue;
				request.setAttribute("perLoan", per);
			}else{
				request.setAttribute("perLoan", "0.0");
			}
		}
		Object countDecore = fjSalerManageImpl.countDecore(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("countDecore", countDecore);
		Object countFjzje = fjSalerManageImpl.countFjzje(dateSql, Customer.CUSTOMERTYPECOMM);
		request.setAttribute("countFjzje", countFjzje);
	}
	/**
	 * 获取统计总数据 二网
	 * @param dateSql
	 */
	private void getTotalNet( String dateSql) {
		HttpServletRequest request=this.getRequest();
		Object success = fjSalerManageImpl.countSuccess(dateSql, Customer.CUSTOMERTYPENETTOW);
		request.setAttribute("netSuccess", success);
		List<FjSaler> countLoans = fjSalerManageImpl.countLoan(dateSql, Customer.CUSTOMERTYPENETTOW);
		if (null!=countLoans&&countLoans.size()>0) {
			FjSaler fjSaler = countLoans.get(0);
			request.setAttribute("netCountLoan", fjSaler);
			
			BigInteger bigSuBigInteger=(BigInteger) success;
			float floatValue = bigSuBigInteger.floatValue();
			if(floatValue>0){
				Integer loanNum = fjSaler.getLoanNum();
				float per= loanNum/floatValue;
				request.setAttribute("netPerLoan", per);
			}else{
				request.setAttribute("netPerLoan", "0.0");
			}
		}
		Object countDecore = fjSalerManageImpl.countDecore(dateSql, Customer.CUSTOMERTYPENETTOW);
		request.setAttribute("netCountDecore", countDecore);
		Object countFjzje = fjSalerManageImpl.countFjzje(dateSql, Customer.CUSTOMERTYPENETTOW);
		request.setAttribute("netCountFjzje", countFjzje);
	}

}
