package com.ystech.agent.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentSet;
import com.ystech.agent.model.AgentSetLevel;
import com.ystech.agent.service.AgentSetLevelManageImpl;
import com.ystech.agent.service.AgentSetManageImpl;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer spreadId = ParamUtil.getIntParam(request, "spreadId", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<AgentSet> agentSets = agentSetManageImpl.find("from AgentSet where enterpriseId=? AND spreadId=? ",new Object[]{enterprise.getDbid(),spreadId});
			if(null!=agentSets&&agentSets.size()>0){
				AgentSet agentSet2 = agentSets.get(0);
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
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		//经纪人注册是否开启推荐权限
		Integer authAgentStatus = ParamUtil.getIntParam(request, "authAgentStatus", 2);
		//开启拉取推荐经纪人权限
		Integer regParentRewardStatus = ParamUtil.getIntParam(request, "regParentRewardStatus", 2);
		Integer regRewardStatus = ParamUtil.getIntParam(request, "regRewardStatus", 2);
		Integer agentRewardStatus = ParamUtil.getIntParam(request, "agentRewardStatus", 2);
		Integer spreadId = ParamUtil.getIntParam(request, "spreadId", -1);
		Integer agentRewardParentStatus = ParamUtil.getIntParam(request, "agentRewardParentStatus", 2);
		Integer agentRewardModel = ParamUtil.getIntParam(request, "agentRewardModel", 1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = agentSet.getDbid();
			agentSet.setAgentRewardStatus(agentRewardStatus);
			agentSet.setRegParentRewardStatus(regParentRewardStatus);
			agentSet.setAuthAgentStatus(authAgentStatus);
			agentSet.setRegRewardStatus(regRewardStatus);
			agentSet.setAgentRewardParentStatus(agentRewardParentStatus);
			agentSet.setAgentRewardModel(agentRewardModel);
			agentSet.setSpreadId(spreadId);
			if(null==dbid){
				agentSet.setCreateTime(new Date());
				agentSet.setModifyTime(new Date());
				agentSet.setEnterpriseId(enterprise.getDbid());
			}else{
				agentSet.setModifyTime(new Date());
				agentSet.setEnterpriseId(enterprise.getDbid());
			}
			agentSetManageImpl.save(agentSet);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/spread/queryList", "保存数据成功");
		return;
	}
}
