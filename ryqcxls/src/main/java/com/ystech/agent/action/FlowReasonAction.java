/**
 * 
 */
package com.ystech.agent.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.FlowReason;
import com.ystech.agent.service.FlowReasonManageImpl;
import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;

/**
 * @author shusanzhan
 * @date 2014-1-16
 */
@Component("flowReasonAction")
@Scope("prototype")
public class FlowReasonAction extends BaseController{
	private FlowReason flowReason;
	private FlowReasonManageImpl flowReasonManageImpl;


	public FlowReason getFlowReason() {
		return flowReason;
	}

	public void setFlowReason(FlowReason flowReason) {
		this.flowReason = flowReason;
	}


	public FlowReasonManageImpl getFlowReasonManageImpl() {
		return flowReasonManageImpl;
	}
	@Resource
	public void setFlowReasonManageImpl(FlowReasonManageImpl flowReasonManageImpl) {
		this.flowReasonManageImpl = flowReasonManageImpl;
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		try{
			HttpServletRequest request = this.getRequest();
			Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
			Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
			String name = request.getParameter("name");
			SecurityUserHolder securityUserHolder=new SecurityUserHolder();
			try {
				Page<FlowReason> page=null;
				if(null!=name&&name.trim().length()>0){
					page = flowReasonManageImpl.pagedQuerySql(pageNo, pageSize,FlowReason.class, "select * from agent_FlowReason where   name like '%"+name+"%' order by orderNum ", new Object[]{});
				}else{
					page = flowReasonManageImpl.pagedQuerySql(pageNo, pageSize,FlowReason.class, "select * from agent_FlowReason  order by orderNum ", new Object[]{});
				}
				request.setAttribute("page", page);
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		return "edit";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			FlowReason flowReason = flowReasonManageImpl.get(dbid);
			request.setAttribute("flowReason", flowReason);
		}
		return "edit";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		try{
			Integer dbid = flowReason.getDbid();
			if(dbid==null||dbid<=0){
				flowReason.setCreateDate(new Date());
				flowReason.setModifyDate(new Date());
				
			}else{
				flowReason.setModifyDate(new Date());
			}
			flowReasonManageImpl.save(flowReason);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/flowReason/queryList", "保存数据成功！");
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
					//删除数据时判断是否有会员在使用
					flowReasonManageImpl.deleteById(dbid);
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
		renderMsg("/flowReason/queryList"+query, "删除数据成功！");
		return;
	}
}
