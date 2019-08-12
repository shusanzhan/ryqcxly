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
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;

@Component("agentSetLevelAction")
@Scope("prototype")
public class AgentSetLevelAction extends BaseController{
	private AgentSetLevelManageImpl agentSetLevelManageImpl;
	private AgentSetManageImpl agentSetManageImpl;
	@Resource
	public void setAgentSetLevelManageImpl(
			AgentSetLevelManageImpl agentSetLevelManageImpl) {
		this.agentSetLevelManageImpl = agentSetLevelManageImpl;
	}
	@Resource
	public void setAgentSetManageImpl(AgentSetManageImpl agentSetManageImpl) {
		this.agentSetManageImpl = agentSetManageImpl;
	}

	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = getRequest();
		Integer agentSetId = ParamUtil.getIntParam(request, "agentSetId", -1);
		try {
				if(agentSetId>0){
					List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.findBy("agentSetId", agentSetId);
					request.setAttribute("agentSetLevels", agentSetLevels);
				}
		} catch (Exception e) {
			// TODO: handle exception
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
		HttpServletRequest request = getRequest();
		Integer agentSetId = ParamUtil.getIntParam(request, "agentSetId", -1);
		String beginNums = request.getParameter("beginNums");
		String endNums = request.getParameter("endNums");
		String rewardMoneyNums = request.getParameter("rewardMoneyNums");
		try {
			if(agentSetId<0){
				renderText("error");
				return ;
			}
			if(!validToken()){
				renderText("error");
				return ;
			}
			AgentSet agentSet = agentSetManageImpl.get(agentSetId);
			agentSet.setAgentRewardModel(2);
			agentSetManageImpl.save(agentSet);
			//先判断是否存在脏数据
			if(null!=beginNums&&beginNums.trim().length()>0){
				String[] begins = beginNums.split(",");
				String[] ends = endNums.split(",");
				String[] rewardNums = rewardMoneyNums.split(",");
				if(null!=begins&&begins.length>0){
					int i=0;
					for (String begin : begins) {
						try {
							int beginNum = Integer.parseInt(begin);
							if(beginNum<0){
								renderText("error");
								return ;
							}
							int endNum = Integer.parseInt(ends[i]);
							if(endNum<0){
								renderText("error");
								return ;
							}
							String rewardNum = rewardNums[i];
							if(null==rewardNum||rewardNum.trim().length()<=0){
								renderText("error");
								return ;
							}
						} catch (Exception e) {
							renderText("error");
							return ;
						}
						i++;
					}
				}else{
					renderText("error");
					return ;
				}
			}
			List<AgentSetLevel> agentSetLevels = agentSetLevelManageImpl.findBy("agentSetId", agentSetId);
			for (AgentSetLevel agentSetLevel : agentSetLevels) {
				agentSetLevelManageImpl.delete(agentSetLevel);
			}
			if(null!=beginNums&&beginNums.trim().length()>0){
				String[] begins = beginNums.split(",");
				String[] ends = endNums.split(",");
				String[] rewardNums = rewardMoneyNums.split(",");
				if(null!=begins&&begins.length>0){
					int i=0;
					for (String begin : begins) {
						AgentSetLevel agentSetLevel=new AgentSetLevel();
						int beginNum = Integer.parseInt(begin);
						agentSetLevel.setAgentSetId(agentSetId);
						agentSetLevel.setBeginNum(beginNum);
						agentSetLevel.setCreateTime(new Date());
						int endNum = Integer.parseInt(ends[i]);
						agentSetLevel.setEndNum(endNum);
						agentSetLevel.setModifyTime(new Date());
						agentSetLevel.setRewardMoney(Float.valueOf(rewardNums[i]));
						agentSetLevelManageImpl.save(agentSetLevel);
						i++;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderText("error");
			return ;
		}
		renderText("success");
		return;
	}
}
