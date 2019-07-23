/**
 * 
 */
package com.ystech.cust.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Profession;
import com.ystech.cust.service.ProfessionManageImpl;


/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("professionAction")
@Scope("prototype")
public class ProfessionAction extends BaseController{
	private Profession profession;
	private ProfessionManageImpl professionManageImpl;
	public Profession getProfession() {
		return profession;
	}
	public void setProfession(Profession profession) {
		this.profession = profession;
	}
	public ProfessionManageImpl getProfessionManageImpl() {
		return professionManageImpl;
	}
	@Resource
	public void setProfessionManageImpl(ProfessionManageImpl professionManageImpl) {
		this.professionManageImpl = professionManageImpl;
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
		String username = request.getParameter("name");
		Page<Profession> page=null;
		if(null!=username&&username.trim().length()>0){
			page = professionManageImpl.pagedQuerySql(pageNo, pageSize,Profession.class, "select * from cust_Profession where  name like '%"+username+"%'", new Object[]{});
		}else{
			page = professionManageImpl.pagedQuerySql(pageNo, pageSize,Profession.class, "select * from cust_Profession   ", new Object[]{});
		}
		request.setAttribute("page", page);
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
			Profession profession2 = professionManageImpl.get(dbid);
			request.setAttribute("profession", profession2);
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
		//slide.setBussiId(currentBussi);
		try{
			
				professionManageImpl.save(profession);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/profession/queryList", "保存数据成功！");
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
					professionManageImpl.deleteById(dbid);
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
		renderMsg("/profession/queryList"+query, "删除数据成功！");
		return;
	}

}
