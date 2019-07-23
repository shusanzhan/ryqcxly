package com.ystech.agent.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.Agent;
import com.ystech.agent.model.AgentCompany;
import com.ystech.agent.model.RecommendCustomer;
import com.ystech.agent.service.AgentCompanyManageImpl;
import com.ystech.agent.service.AgentManageImpl;
import com.ystech.agent.service.RecommendCustomerManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;

@Component("agentCompanyAction")
@Scope("prototype")
public class AgentCompanyAction extends BaseController{
	private AgentCompanyManageImpl agentCompanyManageImpl;
	private AgentCompany agentCompany;
	private AgentManageImpl agentManageImpl;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	public AgentCompany getAgentCompany() {
		return agentCompany;
	}
	public void setAgentCompany(AgentCompany agentCompany) {
		this.agentCompany = agentCompany;
	}
	@Resource
	public void setAgentCompanyManageImpl(
			AgentCompanyManageImpl agentCompanyManageImpl) {
		this.agentCompanyManageImpl = agentCompanyManageImpl;
	}
	@Resource
	public void setAgentManageImpl(AgentManageImpl agentManageImpl) {
		this.agentManageImpl = agentManageImpl;
	}
	@Resource
	public void setRecommendCustomerManageImpl(
			RecommendCustomerManageImpl recommendCustomerManageImpl) {
		this.recommendCustomerManageImpl = recommendCustomerManageImpl;
	}
	/**
	 * 功能描述：经销商经纪人
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startDate");
		String endTime = request.getParameter("endDate");
		try {
			String sql="select * from agent_agentcompany ac,agent_agent ag where ag.dbid=ac.agentId ";
			List params=new ArrayList();
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and ag.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and ag.name like ? ";
				params.add("%"+name+"%");
			}
			 if (null!=startTime&&startTime.trim().length()>0) {
				sql=sql+"  and ac.createDate>='"+startTime+"'";
			}
			 if (null!=endTime&&endTime.trim().length()>0) {
				 sql=sql+" and ac.createDate<='"+endTime+"'";
			 }
			Page<AgentCompany> page = agentCompanyManageImpl.pagedQuerySql(pageNo, pageSize, AgentCompany.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：推荐人档案
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String agentFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			AgentCompany agentCompany2 = agentCompanyManageImpl.get(dbid);
			request.setAttribute("agentCompany", agentCompany2);
			//推荐到我店人数
			if(null!=agentCompany2){
				Agent agent = agentCompany2.getAgent();
				List<RecommendCustomer> recommendCustomers = recommendCustomerManageImpl.find("from RecommendCustomer where agent.dbid=? and company.dbid=? ", new Object[]{agent.getDbid(),agentCompany2.getCompanyId()});
				request.setAttribute("recommendCustomers", recommendCustomers);
				
				//历史推荐人数
				List<RecommendCustomer> hisRecommendCustomers = recommendCustomerManageImpl.findBy("agent.dbid", agent.getDbid());
				request.setAttribute("hisRecommendCustomers", hisRecommendCustomers);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "agentFile";
	}
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request, "dbids");
		try {
			if(null!=dbids&&dbids.length>0){
				for (Integer dbid : dbids) {
					agentCompanyManageImpl.deleteById(dbid);
				}
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"),"");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/agentCompany/queryList", "保存数据成功！");
		return ;
	}
	
}
