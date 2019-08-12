/**
 * 
 */
package com.ystech.mem.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.EmergencyHelp;
import com.ystech.mem.service.EmergencyHelpManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-3-18
 */
@Component("emergencyHelpAction")
@Scope("prototype")
public class EmergencyHelpAction extends BaseController{
	private EmergencyHelp emergencyHelp;
	private EmergencyHelpManageImpl emergencyHelpManageImpl;
	public EmergencyHelp getEmergencyHelp() {
		return emergencyHelp;
	}
	public void setEmergencyHelp(EmergencyHelp emergencyHelp) {
		this.emergencyHelp = emergencyHelp;
	}
	@Resource
	public void setEmergencyHelpManageImpl(
			EmergencyHelpManageImpl emergencyHelpManageImpl) {
		this.emergencyHelpManageImpl = emergencyHelpManageImpl;
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
		String status = request.getParameter("status");
		Boolean boolean1=false;
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try{
			User currentUser = SecurityUserHolder.getCurrentUser();
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String hql="select * from mem_EmergencyHelp where 1=1 ";
			if(currentUser.getQueryOtherDataStatus()==(int)User.QUERYYES){
				hql=hql+" and enterpriseId in("+currentUser.getCompnayIds()+")";
			}else{
				hql=hql+" and enterpriseId="+enterprise.getDbid();
			}
			if(null!=status&&status.trim().length()>0){
				if(status.equals("true")){
					boolean1=true;
					hql=hql+"and status="+true;
				}else{
					hql=hql+"and status="+false;
				}
			}
			hql=hql+" order By status,createTime DESC";
			Page<EmergencyHelp> page =emergencyHelpManageImpl.pagedQuerySql(pageNo, pageSize,EmergencyHelp.class, hql, new Object[]{});
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			EmergencyHelp emergencyHelp2 = emergencyHelpManageImpl.get(dbid);
			request.setAttribute("emergencyHelp", emergencyHelp2);
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
	public void update() throws Exception {
		HttpServletRequest request = getRequest();
		try{
			Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
			User currentUser = SecurityUserHolder.getCurrentUser();
			String note = request.getParameter("note");
			if(dbid!=null||dbid>=0){
				EmergencyHelp emergencyHelp2 = emergencyHelpManageImpl.get(dbid);
				emergencyHelp2.setModifyTime(new Date());
				emergencyHelp2.setOperator(currentUser.getRealName());
				emergencyHelp2.setStatus(true);
				emergencyHelp2.setNote(note);
				emergencyHelpManageImpl.save(emergencyHelp2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/emergencyHelp/queryList", "保存数据成功！");
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
					emergencyHelpManageImpl.deleteById(dbid);
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
		renderMsg("/emergencyHelp/queryList"+query, "删除数据成功！");
		return;
	}

}
