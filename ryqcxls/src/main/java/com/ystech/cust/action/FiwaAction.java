/**
 * 
 */
package com.ystech.cust.action;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Fiwa;
import com.ystech.cust.model.Fiwaresult;
import com.ystech.cust.service.FiwaManageImpl;
import com.ystech.cust.service.FiwaresultManageImpl;

/**
 * @author shusanzhan
 * @date 2014-7-10
 */
@Component("fiwaAction")
@Scope("prototype")
public class FiwaAction extends BaseController{
	private Fiwa fiwa;
	private Fiwaresult fiwaresult;
	private FiwaManageImpl fiwaManageImpl;
	private FiwaresultManageImpl fiwaresultManageImpl;
	private HttpServletRequest request=this.getRequest();
	public Fiwa getFiwa() {
		return fiwa;
	}
	public void setFiwa(Fiwa fiwa) {
		this.fiwa = fiwa;
	}
	public FiwaManageImpl getFiwaManageImpl() {
		return fiwaManageImpl;
	}
	@Resource
	public void setFiwaManageImpl(FiwaManageImpl fiwaManageImpl) {
		this.fiwaManageImpl = fiwaManageImpl;
	}
	
	public void setFiwaresult(Fiwaresult fiwaresult) {
		this.fiwaresult = fiwaresult;
	}
	
	public Fiwaresult getFiwaresult() {
		return fiwaresult;
	}
	@Resource
	public void setFiwaresultManageImpl(FiwaresultManageImpl fiwaresultManageImpl) {
		this.fiwaresultManageImpl = fiwaresultManageImpl;
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
		Page<Fiwa> page=null;
		if(null!=username&&username.trim().length()>0){
			page = fiwaManageImpl.pagedQuerySql(pageNo, pageSize,Fiwa.class, "select * from cust_Fiwa  ", new Object[]{});
		}else{
			page = fiwaManageImpl.pagedQuerySql(pageNo, pageSize,Fiwa.class, "select * from cust_Fiwa  ", new Object[]{});
		}
		Fiwaresult fiwaresult2 = fiwaresultManageImpl.get(1);
		request.setAttribute("fiwaresult", fiwaresult2);
		request.setAttribute("page", page);
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String editFiwaResult() throws Exception {
		try{
			Boolean over = isOver();
			if(over==false){
				request.setAttribute("status","error");
			}else{
				request.setAttribute("status","success");
				Fiwaresult fiwaresult2 = fiwaresultManageImpl.get(1);
				request.setAttribute("fiwaresult", fiwaresult2);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "editFiwaResult";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveFiwaResult() throws Exception {
		try{
			if(null!=fiwaresult.getDbid()&&fiwaresult.getDbid()>0){
				fiwaresult.setCreateTime(new Date());
			}
			fiwaresultManageImpl.save(fiwaresult);
			fiwaManageImpl.updateDate(fiwaresult);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/fiwa/queryList", "设置结果成功！");
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
					fiwaManageImpl.deleteById(dbid);
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
		renderMsg("/fiwa/queryList"+query, "删除数据成功！");
		return;
	}
	private Boolean isOver(){
		 Date statDay = new Date();
		 Calendar date = Calendar.getInstance();
		 date.set(2014, 6, 14, 3, 0);
		 Date time = date.getTime();
		 if(statDay.before(time)){
			 return false;
		 }else{
			 return true;
		 }
	}
}
