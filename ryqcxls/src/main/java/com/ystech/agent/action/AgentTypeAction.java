package com.ystech.agent.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.AgentType;
import com.ystech.agent.service.AgentTypeManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("agentTypeAction")
@Scope("prototype")
public class AgentTypeAction extends BaseController{
	private AgentType agentType;
	private AgentTypeManageImpl agentTypeManageImpl;
	
	public AgentType getAgentType() {
		return agentType;
	}

	public void setAgentType(AgentType agentType) {
		this.agentType = agentType;
	}
	@Resource
	public void setAgentTypeManageImpl(AgentTypeManageImpl agentTypeManageImpl) {
		this.agentTypeManageImpl = agentTypeManageImpl;
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
		try{
				String sql="select * from agent_agentType where 1=1  ";
				List params=new ArrayList();
				if(null!=name&&name.trim().length()>0){
					sql=sql+" and name like ? ";
					params.add("%"+name+"%");
				}
				sql=sql+" order by orderNum ";
				Page<AgentType> page= agentTypeManageImpl.pagedQuerySql(pageNo, pageSize,AgentType.class, sql, params.toArray());
				request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
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
		try {
			if(dbid>0){
				AgentType agentType2 = agentTypeManageImpl.get(dbid);
				request.setAttribute("agentType", agentType2);
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
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		try{
			Integer dbid = agentType.getDbid();
			if(dbid==null||dbid<=0){
				agentType.setEnterpriseId(enterprise.getDbid());
				agentType.setCreateTime(new Date());
				agentType.setModifyTime(new Date());
				agentTypeManageImpl.save(agentType);
			}else{
				agentType.setEnterpriseId(enterprise.getDbid());
				agentType.setModifyTime(new Date());
				agentTypeManageImpl.save(agentType);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/agentType/queryList", "保存数据成功！");
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
					agentTypeManageImpl.deleteById(dbid);
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
		renderMsg("/agentType/queryList"+query, "删除数据成功！");
		return;
	}
}
