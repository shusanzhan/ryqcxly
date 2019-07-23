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
import com.ystech.cust.model.Paperwork;
import com.ystech.cust.service.PaperworkManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-22
 */
@Component("custPaperworkAction")
@Scope("prototype")
public class PaperworkAction extends BaseController{
	private Paperwork paperwork;
	private PaperworkManageImpl paperworkManageImpl;
	public Paperwork getPaperwork() {
		return paperwork;
	}

	public void setPaperwork(Paperwork paperwork) {
		this.paperwork = paperwork;
	}

	public PaperworkManageImpl getPaperworkManageImpl() {
		return paperworkManageImpl;
	}
	@Resource
	public void setPaperworkManageImpl(PaperworkManageImpl paperworkManageImpl) {
		this.paperworkManageImpl = paperworkManageImpl;
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
		Page<Paperwork> page=null;
		if(null!=username&&username.trim().length()>0){
			page = paperworkManageImpl.pagedQuerySql(pageNo, pageSize,Paperwork.class, "select * from cust_Paperwork where name like '%"+username+"%'", new Object[]{});
		}else{
			page = paperworkManageImpl.pagedQuerySql(pageNo, pageSize,Paperwork.class, "select * from cust_Paperwork  ", new Object[]{});
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
			Paperwork paperwork = paperworkManageImpl.get(dbid);
			request.setAttribute("paperwork", paperwork);
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
		try{
				paperworkManageImpl.save(paperwork);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/paperwork/queryList", "保存数据成功！");
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
						paperworkManageImpl.deleteById(dbid);
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
		renderMsg("/paperwork/queryList"+query, "删除数据成功！");
		return;
	}

}
