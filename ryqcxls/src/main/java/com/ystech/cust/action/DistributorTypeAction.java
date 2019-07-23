/**
 * 
 */
package com.ystech.cust.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.DistributorType;
import com.ystech.cust.service.DistributorTypeManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2014-8-16
 */
@Component("distributorTypeAction")
@Scope("prototype")
public class DistributorTypeAction extends BaseController{
	private DistributorType distributorType;
	private DistributorTypeManageImpl distributorTypeManageImpl;
	public DistributorType getDistributorType() {
		return distributorType;
	}
	public void setDistributorType(DistributorType distributorType) {
		this.distributorType = distributorType;
	}
	@Resource
	public void setDistributorTypeManageImpl(
			DistributorTypeManageImpl distributorTypeManageImpl) {
		this.distributorTypeManageImpl = distributorTypeManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String username = request.getParameter("name");
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		Page<DistributorType> page=null;
		if(null!=username&&username.trim().length()>0){
			page = distributorTypeManageImpl.pagedQuerySql(pageNo, pageSize,DistributorType.class, "select * from cust_DistributorType where name like '%"+username+"%' and companyId=?", new Object[]{enterprise.getDbid()});
		}else{
			page = distributorTypeManageImpl.pagedQuerySql(pageNo, pageSize,DistributorType.class, "select * from cust_DistributorType where companyId=?", new Object[]{enterprise.getDbid()});
		}
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			 DistributorType distributorType = distributorTypeManageImpl.get(dbid);
			request.setAttribute("distributorType", distributorType);
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
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			distributorType.setCompanyId(enterprise.getDbid());
			distributorTypeManageImpl.save(distributorType);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributorType/queryList", "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
						distributorTypeManageImpl.deleteById(dbid);
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
		renderMsg("/distributorType/queryList"+query, "删除数据成功！");
		return;
	}
	
}
