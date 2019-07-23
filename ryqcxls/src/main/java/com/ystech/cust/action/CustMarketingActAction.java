package com.ystech.cust.action;

import java.util.ArrayList;
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
import com.ystech.cust.model.CustMarketingAct;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.CustomerTrackMarketingCount;
import com.ystech.cust.service.CustMarketingActManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.cust.service.StatisticalSalerManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("custMarketingActAction")
@Scope("prototype")
public class CustMarketingActAction extends BaseController{
	private CustMarketingAct custMarketingAct;
	private CustMarketingActManageImpl custMarketingActManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	private StatisticalSalerManageImpl statisticalSalerManageImpl;
	public CustMarketingAct getCustMarketingAct() {
		return custMarketingAct;
	}
	public void setCustMarketingAct(CustMarketingAct custMarketingAct) {
		this.custMarketingAct = custMarketingAct;
	}
	@Resource
	public void setCustMarketingActManageImpl(
			CustMarketingActManageImpl custMarketingActManageImpl) {
		this.custMarketingActManageImpl = custMarketingActManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}
	@Resource
	public void setStatisticalSalerManageImpl(
			StatisticalSalerManageImpl statisticalSalerManageImpl) {
		this.statisticalSalerManageImpl = statisticalSalerManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			 String sql="select * from cust_MarketingAct where 1=1  AND enterpriseId=? ";
			 List params=new ArrayList();
			 params.add(enterprise.getDbid());
			 if(null!=name&&name.trim().length()>0){
				 sql=sql+" and name like ? ";
				 params.add("%"+name+"%");
			 }
			 if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createDate>= ? ";
				params.add(DateUtil.string2Date(startTime));
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createDate< ? ";
				params.add(DateUtil.nextDay(endTime));
			}
			 Page<CustMarketingAct> page= custMarketingActManageImpl.pagedQuerySql(pageNo, pageSize, CustMarketingAct.class, sql, params.toArray());
			 request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：邀约明细
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String inviteDetail() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustMarketingAct custMarketingAct2 = custMarketingActManageImpl.get(dbid);
			List<CustomerTrack> customerTracks = customerTrackManageImpl.findBy("custMarketingAct.dbid", dbid);
			request.setAttribute("customerTracks", customerTracks);
			request.setAttribute("custMarketingAct", custMarketingAct2);
			
			String resultAccSql="select count(*) as total from cust_CustomerTrack where turnBackResult=1 and custMarketingActId="+dbid+"  group by custMarketingActId";
			Object accCount = statisticalSalerManageImpl.queryCount(resultAccSql);
			request.setAttribute("accCount", accCount);
			String resultAccSql2="select count(*) as total from cust_CustomerTrack where turnBackResult=2 and custMarketingActId="+dbid+"  group by custMarketingActId";
			Object waitingCount = statisticalSalerManageImpl.queryCount(resultAccSql2);
			request.setAttribute("waitingCount", waitingCount);
			String resultAccSql3="select count(*) as total from cust_CustomerTrack where turnBackResult=3 and custMarketingActId="+dbid+"  group by custMarketingActId";
			Object disCount = statisticalSalerManageImpl.queryCount(resultAccSql3);
			request.setAttribute("disCount", disCount);
			
			String sql="SELECT " +
					"dep.`name` as depName,us.realName as userName,COUNT(*) AS total,SUM(IF(ct.turnBackResult=1,1,0)) AS accTotal," +
					"SUM(IF(ct.turnBackResult=2,1,0)) AS waitingTotal,SUM(IF(ct.turnBackResult=3,1,0)) AS disTotal " +
					" from " +
					"cust_customertrack ct,sys_user us,sys_department dep " +
					"WHERE " +
					"us.dbid=ct.userId AND us.departmentId=dep.dbid AND ct.custMarketingActId="+dbid+" GROUP BY us.dbid ORDER BY COUNT(*) ";
			List<CustomerTrackMarketingCount> customerTrackMarketingCounts = custMarketingActManageImpl.findby(sql);
			request.setAttribute("customerTrackMarketingCounts", customerTrackMarketingCounts);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "inviteDetail";
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			CustMarketingAct custMarketingAct2 = custMarketingActManageImpl.get(dbid);
			request.setAttribute("custMarketingAct", custMarketingAct2);
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
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = custMarketingAct.getDbid();
			if(dbid==null||dbid<=0){
				custMarketingAct.setCreateDate(new Date());
				custMarketingAct.setModifyDate(new Date());
				custMarketingAct.setEnterpriseId(enterprise.getDbid());
				custMarketingAct.setInviteNum(0);
				custMarketingAct.setIntentionCustNum(0);
				custMarketingActManageImpl.save(custMarketingAct);
			}else{
				CustMarketingAct custMarketingAct2 = custMarketingActManageImpl.get(dbid);
				custMarketingAct2.setActEndDate(custMarketingAct.getActEndDate());
				custMarketingAct2.setActStartDate(custMarketingAct.getActStartDate());
				custMarketingAct2.setName(custMarketingAct.getName());
				custMarketingAct2.setTargetPersonNum(custMarketingAct.getTargetPersonNum());
				custMarketingAct2.setContent(custMarketingAct.getContent());
				custMarketingActManageImpl.save(custMarketingAct2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/custMarketingAct/queryList", "保存数据成功！");
		return ;
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
					custMarketingActManageImpl.deleteById(dbid);
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
		renderMsg("/custMarketingAct/queryList"+query, "删除数据成功！");
		return;
	}

}
