package com.ystech.agent.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;

@Component("agentAction")
@Scope("prototype")
public class AgentAction extends BaseController{
	/*private Agent agent;
	private AgentManageImpl agentManageImpl;
	private RecommendCustomerManageImpl recommendCustomerManageImpl;
	private AreaManageImpl areaManageImpl;
	private AgentToExcel agentToExcel;
	public Agent getAgent() {
		return agent;
	}
	public void setAgent(Agent agent) {
		this.agent = agent;
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
	@Resource
	public void setAgentToExcel(AgentToExcel agentToExcel) {
		this.agentToExcel = agentToExcel;
	}
	@Resource
	public void setAreaManageImpl(AreaManageImpl areaManageImpl) {
		this.areaManageImpl = areaManageImpl;
	}
	*//**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 *//*
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startDate");
		String endTime = request.getParameter("endDate");
		try {
			//省
			List<Area> provices = areaManageImpl.find("from Area where area.dbid IS NULL", new Object[]{});
			request.setAttribute("provices", provices);
			if(proviceId>0){
				List<Area> cityAreas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{proviceId});
				request.setAttribute("citys", cityAreas);
			}
			if(cityId>0){
				List<Area> areas = areaManageImpl.find("from Area where area.dbid=?", new Object[]{cityId});
				request.setAttribute("areas", areas);
			}
			String sql="select * from agent_agent ag where 1=1" ;
			List params=new ArrayList();
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and ag.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and ag.name like ? ";
				params.add("%"+name+"%");
			}
			if(proviceId>0){
				sql=sql+" and province=? ";
				Area area = areaManageImpl.get(proviceId);
				params.add(area.getName());
			}
			if(cityId>0){
				sql=sql+" and city=? ";
				Area area = areaManageImpl.get(cityId);
				params.add(area.getName());
			}
			if(areaId>0){
				sql=sql+" and areaStr=? ";
				Area area = areaManageImpl.get(areaId);
				params.add(area.getName());
			}
			 if (null!=startTime&&startTime.trim().length()>0) {
				sql=sql+"  and ag.createDate>='"+startTime+"'";
			}
			 if (null!=endTime&&endTime.trim().length()>0) {
				 sql=sql+" and ag.createDate<='"+endTime+"'";
			 }
			 sql=sql+" order by ag.createDate DESC";
			Page<Agent> page = agentManageImpl.pagedQuerySql(pageNo, pageSize, Agent.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	*//**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 *//*
	public void download() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = this.getResponse();
		String name = request.getParameter("name");
		String mobilePhone = request.getParameter("mobilePhone");
		String startTime = request.getParameter("startDate");
		String endTime = request.getParameter("endDate");
		Integer proviceId = ParamUtil.getIntParam(request, "proviceId", -1);
		Integer cityId = ParamUtil.getIntParam(request, "cityId", -1);
		Integer areaId = ParamUtil.getIntParam(request, "areaId", -1);
		String fileName="";
		try{
				if(null!=startTime&&startTime.trim().length()>0){
					fileName=fileName+""+startTime;
				}
				if(null!=endTime&&endTime.trim().length()>0){
					fileName=fileName+"至"+endTime;
				}else{
					fileName=fileName+"至"+DateUtil.format(new Date());
				}
				String sql="select * from agent_agent ag where 1=1" ;
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
					sql=sql+"  and ag.createDate>='"+startTime+"'";
				}
				 if(proviceId>0){
					sql=sql+" and province=? ";
					Area area = areaManageImpl.get(proviceId);
					params.add(area.getName());
				}
				if(cityId>0){
					sql=sql+" and city=? ";
					Area area = areaManageImpl.get(cityId);
					params.add(area.getName());
				}
				if(areaId>0){
					sql=sql+" and areaStr=? ";
					Area area = areaManageImpl.get(areaId);
					params.add(area.getName());
				}
			 if (null!=endTime&&endTime.trim().length()>0) {
				 sql=sql+" and ag.createDate<='"+endTime+"'";
			 }
			 sql=sql+" order by ag.createDate DESC";
			 List<Agent> agents = agentManageImpl.executeSql(sql, params.toArray());
			 String filePath = agentToExcel.writeExcel(fileName, agents,1);
			 downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
	*//**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 *//*
	public String agentFile() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			Agent agent2 = agentManageImpl.get(dbid);
			request.setAttribute("agent", agent2);
			List<RecommendCustomer> recommendCustomers = recommendCustomerManageImpl.findBy("agent.dbid", agent2.getDbid());
			request.setAttribute("recommendCustomers", recommendCustomers);
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
					agentManageImpl.deleteById(dbid);
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
		renderMsg("/agent/queryList"+query, "删除数据成功！");
		return ;
	}*/

}
