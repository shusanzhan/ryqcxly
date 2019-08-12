package com.ystech.qywx.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.Act;
import com.ystech.qywx.model.ActEnterprise;
import com.ystech.qywx.service.ActEnterpriseManageImpl;
import com.ystech.qywx.service.ActManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("actEnterpriseAction")
@Scope("prototype")
public class ActEnterpriseAction extends BaseController{
	private ActManageImpl actManageImpl;
	private ActEnterprise actEnterprise;
	private ActEnterpriseManageImpl actEnterpriseManageImpl;
	
	public ActManageImpl getActManageImpl() {
		return actManageImpl;
	}
	@Resource
	public void setActManageImpl(ActManageImpl actManageImpl) {
		this.actManageImpl = actManageImpl;
	}
	
	public ActEnterprise getActEnterprise() {
		return actEnterprise;
	}
	public void setActEnterprise(ActEnterprise actEnterprise) {
		this.actEnterprise = actEnterprise;
	}
	@Resource
	public void setActEnterpriseManageImpl(
			ActEnterpriseManageImpl actEnterpriseManageImpl) {
		this.actEnterpriseManageImpl = actEnterpriseManageImpl;
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
		String username = request.getParameter("title");
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Page<ActEnterprise> page=null;
			if(null!=username&&username.trim().length()>0){
				page = actEnterpriseManageImpl.pagedQuerySql(pageNo, pageSize,ActEnterprise.class, "select * from qywx_ActEnterprise where enterpriseId=? and name like '%"+username+"%'", new Object[]{enterprise.getDbid()});
			}else{
				page = actEnterpriseManageImpl.pagedQuerySql(pageNo, pageSize,ActEnterprise.class, "select * from qywx_ActEnterprise where enterpriseId=? ", new Object[]{enterprise.getDbid()});
			}
			request.setAttribute("page", page);
		} catch (Exception e) {
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
		HttpServletRequest request = this.getRequest();
		try {
			List<Act> acts = actManageImpl.getAll();
			request.setAttribute("acts", acts);
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			List<Act> acts = actManageImpl.getAll();
			request.setAttribute("acts", acts);
			if(dbid>0){
				ActEnterprise actEnterprise2 = actEnterpriseManageImpl.get(dbid);
				request.setAttribute("actEnterprise", actEnterprise2);
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
		HttpServletRequest request = getRequest();
		Integer actId = ParamUtil.getIntParam(request, "actId", -1);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Integer dbid = actEnterprise.getDbid();
			if(actId>0){
				Act act = actManageImpl.get(actId);
				actEnterprise.setAct(act);
			}
			if(null==dbid||dbid<=0){
				List<ActEnterprise> actEnterprises = actEnterpriseManageImpl.find("from ActEnterprise where act.dbid=? and enterpriseId=?",new Object[]{actId,enterprise.getDbid()});
				if(null!=actEnterprises&&actEnterprises.size()>0){
					renderErrorMsg(new Throwable("红包类型已经存在，请勿重复添加"), "");
					return ;
				}
				actEnterprise.setEnterpriseId(enterprise.getDbid());
				actEnterprise.setModifyDate(new Date());
				actEnterprise.setCreateDate(new Date());
				actEnterprise.setSsStatus(ActEnterprise.COMM);
				actEnterpriseManageImpl.save(actEnterprise);
			}else{
				ActEnterprise actEnterprise2 = actEnterpriseManageImpl.get(dbid);
				List<ActEnterprise> actEnterprises = actEnterpriseManageImpl.find("from ActEnterprise where act.dbid=? and enterpriseId=?",new Object[]{actId,enterprise.getDbid()});
				if(null!=actEnterprises&&actEnterprises.size()>0){
					ActEnterprise actEnterprise3 = actEnterprises.get(0);
					if(actEnterprise2.getDbid()!=(int)actEnterprise3.getDbid()){
						renderErrorMsg(new Throwable("红包类型已经存在，请勿重复添加"), "");
						return ;
					}
						
				}
				actEnterprise2.setAct(actEnterprise.getAct());
				actEnterprise2.setModifyDate(new Date());
				actEnterprise2.setName(actEnterprise.getName());
				actEnterprise2.setNote(actEnterprise.getNote());
				actEnterprise2.setWishing(actEnterprise.getWishing());
				actEnterprise2.setRemark(actEnterprise.getRemark());
				actEnterprise2.setLevelStatus(actEnterprise.getLevelStatus());
				actEnterpriseManageImpl.save(actEnterprise2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/actEnterprise/queryList", "保存数据成功！");
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
					actEnterpriseManageImpl.deleteById(dbid);
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
		renderMsg("/actEnterprise/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void stopOrStart() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			ActEnterprise actEnterprise2 = actEnterpriseManageImpl.get(dbid);
			if(null!=actEnterprise2){
				Integer ssStatus = actEnterprise2.getSsStatus();
				if(ssStatus==(int)actEnterprise.COMM){
					actEnterprise2.setSsStatus(ActEnterprise.STOP);
				}
				if(ssStatus==(int)actEnterprise.STOP){
					actEnterprise2.setSsStatus(ActEnterprise.COMM);
				}
				actEnterpriseManageImpl.save(actEnterprise2);
			}else{
				renderErrorMsg(new Throwable("请选择操作数据"), "");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/actEnterprise/queryList", "设置成功！");
		return;
	}
}
