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
import com.ystech.cust.model.Educational;
import com.ystech.cust.service.EducationalManageImpl;

/**
 * @author shusanzhan
 * @date 2014-2-18
 */
@Component("educationalAction")
@Scope("prototype")
public class EducationalAction extends BaseController{
	private Educational educational;
	private EducationalManageImpl educationalManageImpl;
	public Educational getEducational() {
		return educational;
	}
	public void setEducational(Educational educational) {
		this.educational = educational;
	}
	@Resource
	public void setEducationalManageImpl(EducationalManageImpl educationalManageImpl) {
		this.educationalManageImpl = educationalManageImpl;
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
		Page<Educational> page=null;
		if(null!=username&&username.trim().length()>0){
			page = educationalManageImpl.pagedQuerySql(pageNo, pageSize,Educational.class, "select * from cust_Educational where name like '%"+username+"%'", new Object[]{});
		}else{
			page = educationalManageImpl.pagedQuerySql(pageNo, pageSize,Educational.class, "select * from cust_Educational ", new Object[]{});
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
			Educational educational2 = educationalManageImpl.get(dbid);
			request.setAttribute("educational", educational2);
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
				educationalManageImpl.save(educational);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/educational/queryList", "保存数据成功！");
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
					educationalManageImpl.deleteById(dbid);
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
		renderMsg("/educational/queryList"+query, "删除数据成功！");
		return;
	}

	
}
