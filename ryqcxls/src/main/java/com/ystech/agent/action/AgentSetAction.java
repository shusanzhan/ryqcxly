package com.ystech.agent.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.util.TokenHelper;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentSet;
import com.ystech.agent.model.AgentSetLevel;
import com.ystech.agent.service.AgentSetLevelManageImpl;
import com.ystech.agent.service.AgentSetManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Reward;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("agentSetAction")
@Scope("prototype")
public class AgentSetAction extends BaseController{
	private AgentSetManageImpl agentSetManageImpl;
	private AgentSet agentSet;
	private AgentSetLevelManageImpl agentSetLevelManageImpl;
	@Resource
	public void setAgentSetManageImpl(AgentSetManageImpl agentSetManageImpl) {
		this.agentSetManageImpl = agentSetManageImpl;
	}
	public void setAgentSet(AgentSet agentSet) {
		this.agentSet = agentSet;
	}
	public AgentSet getAgentSet() {
		return agentSet;
	}
	@Resource
	public void setAgentSetLevelManageImpl(
			AgentSetLevelManageImpl agentSetLevelManageImpl) {
		this.agentSetLevelManageImpl = agentSetLevelManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String enterpriseName = request.getParameter("enterpriseName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * "
					+ "from "
					+ "agent_agentset "
					+ "where 1=1 AND dbid>1 ";
			List params=new ArrayList();
			if(enterprise.getDbid()>0){
				sql=sql+" AND  enterpriseId=? "; 
				params.add(enterprise.getDbid());
			}
			if(null!=enterpriseName&&enterpriseName.trim().length()>0){
				sql=sql+" AND enterpriseName like ? ";
				params.add("%"+enterpriseName+"%");
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" AND createTime>=? ";
				params.add(startTime);
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" AND createTime<=? ";
				params.add(endTime);
			}
			sql=sql+" order by createTime DESC ";
			Page<AgentSet> page = agentSetManageImpl.pagedQuerySql(pageNo, pageSize,AgentSet.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<AgentSet> agentSets = agentSetManageImpl.find("from AgentSet where enterpriseId=? ",new Object[]{enterprise.getDbid()});
			if(null!=agentSets&&agentSets.size()>0){
				AgentSet agentSet2 = agentSets.get(0);
				request.setAttribute("agentSet", agentSet2);
				List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.findBy("agentSetId", agentSet2.getDbid());
				request.setAttribute("agentSetLevels", agentSetLevels);
			}else{
				AgentSet agentSet2 = agentSetManageImpl.get(1);
				request.setAttribute("agentSet", agentSet2);
				List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.findBy("agentSetId", agentSet2.getDbid());
				request.setAttribute("agentSetLevels", agentSetLevels);
			}
			request.setAttribute("enterprise", enterprise);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String superEdit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
				AgentSet agentSet2 = agentSetManageImpl.get(dbid);
				request.setAttribute("agentSet", agentSet2);
				List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.findBy("agentSetId", agentSet2.getDbid());
				request.setAttribute("agentSetLevels", agentSetLevels);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		//经纪人注册是否开启推荐权限
		Integer authAgentStatus = ParamUtil.getIntParam(request, "authAgentStatus", 2);
		//开启拉取推荐经纪人权限
		Integer regParentRewardStatus = ParamUtil.getIntParam(request, "regParentRewardStatus", 2);
		Integer regRewardStatus = ParamUtil.getIntParam(request, "regRewardStatus", 2);
		Integer agentRewardStatus = ParamUtil.getIntParam(request, "agentRewardStatus", 2);
		Integer agentRewardParentStatus = ParamUtil.getIntParam(request, "agentRewardParentStatus", 2);
		Integer agentRewardModel = ParamUtil.getIntParam(request, "agentRewardModel", 1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		Integer dbid = agentSet.getDbid();
		try {
			 if(!validToken()) {
				renderErrorMsg(new Throwable("请勿重复提交表单"), "");
				return ;
			 }
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null==dbid){
				agentSet.setAgentRewardStatus(agentRewardStatus);
				agentSet.setRegParentRewardStatus(regParentRewardStatus);
				agentSet.setAuthAgentStatus(authAgentStatus);
				agentSet.setRegRewardStatus(regRewardStatus);
				agentSet.setAgentRewardParentStatus(agentRewardParentStatus);
				agentSet.setAgentRewardModel(agentRewardModel);
				agentSet.setCreateTime(new Date());
				agentSet.setModifyTime(new Date());
				agentSet.setEnterpriseName(enterprise.getName());
				agentSet.setEnterprise(enterprise);
				agentSetManageImpl.save(agentSet);
			}else{
				AgentSet agentSet2 = agentSetManageImpl.get(dbid);
				agentSet2.setAgentRewardStatus(agentRewardStatus);
				agentSet2.setRegParentRewardStatus(regParentRewardStatus);
				agentSet2.setAuthAgentStatus(authAgentStatus);
				agentSet2.setRegRewardStatus(regRewardStatus);
				agentSet2.setAgentRewardParentStatus(agentRewardParentStatus);
				agentSet2.setAgentRewardModel(agentRewardModel);
				agentSet2.setAgentRewardNum(agentSet.getAgentRewardNum());
				agentSet2.setAgentRewardParentNum(agentSet.getAgentRewardParentNum());
				agentSet2.setRegParentRewardNum(agentSet.getRegParentRewardNum());
				agentSet2.setRegRewardNum(agentSet.getRegRewardNum());
				agentSet2.setModifyTime(new Date());
				agentSetManageImpl.save(agentSet2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		if(type==1){
			renderMsg("/agentSet/superEdit?dbid="+dbid+"&type=1", "保存数据成功");
		}else{
			renderMsg("/agentSet/edit", "保存数据成功");
		}
		return;
	}
}
