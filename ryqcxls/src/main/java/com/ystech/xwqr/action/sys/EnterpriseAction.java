/**
 * 
 */
package com.ystech.xwqr.action.sys;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

/**
 * @author shusanzhan
 * @date 2013-6-2
 */
@Component("enterpriseAction")
@Scope("prototype")
public class EnterpriseAction extends BaseController{
	private DepartmentManageImpl departmentManageImpl;
	private Enterprise enterprise;
	
	public Enterprise getEnterprise() {
		return enterprise;
	}
	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}
	private EnterpriseManageImpl enterpriseManageImpl;

	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	/**
	 * 功能描述：查询分公司列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			String hql="select * from sys_Enterprise ";
			List params=new ArrayList();
			Page<Enterprise> page= enterpriseManageImpl.pagedQuerySql(pageNo, pageSize,Enterprise.class,hql,params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
	}
	/**
	 * 功能描述：编辑区域和经销商信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			
			Enterprise enterprise2 = enterpriseManageImpl.get(dbid);
			request.setAttribute("enterprise", enterprise2);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "edit";
	}
	/**
	 * 功能描述：分店自己管理自己的基础信息
	 * @return
	 * @throws Exception
	 */
	public String enterprise() throws Exception {
		HttpServletRequest request = getRequest();
		User currentUser = SecurityUserHolder.getCurrentUser();
		if(null!=currentUser){
			List<Enterprise> companies = enterpriseManageImpl.findBy("userId", currentUser.getDbid());
			if(null!=companies&&companies.size()>0){
				Enterprise enterprise2 = companies.get(0);
				request.setAttribute("enterprise", enterprise2);
			}
		}
		return "enterprise";
	}
	/**
	 * 功能描述：管理员管理分店基础信息
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			//更新基础分店基础数据
			Enterprise enterprise2 = enterpriseManageImpl.get(enterprise.getDbid());
			enterprise2.setAccount(enterprise.getAccount());
			enterprise2.setAddress(enterprise.getAddress());
			enterprise2.setBank(enterprise.getBank());
			enterprise2.setContent(enterprise.getContent());
			enterprise2.setEmail(enterprise.getEmail());
			enterprise2.setFax(enterprise.getFax());
			enterprise2.setName(enterprise.getName());
			enterprise2.setPhone(enterprise.getPhone());
			enterprise2.setWebAddress(enterprise.getWebAddress());
			enterprise2.setZipCode(enterprise.getZipCode());
			enterprise2.setAllName(enterprise.getAllName());
			enterprise2.setOldCarPhone(enterprise.getOldCarPhone());
			enterprise2.setMaintCarPhone(enterprise.getMaintCarPhone());
			enterprise2.setSalerPhone(enterprise.getSalerPhone());
			enterprise2.setEmergencyPhone(enterprise.getEmergencyPhone());
			enterprise2.setEaxminPhone(enterprise.getEaxminPhone());
			enterprise2.setTryCarPhone(enterprise.getTryCarPhone());
			enterprise2.setBussiType(enterprise.getBussiType());
			enterprise2.setPoint(enterprise.getPoint());
			enterpriseManageImpl.save(enterprise2);
			
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/enterprise/queryList", "保存数据成功！");
		return;
	}
	/**
	 * 功能描述：分店维基础信息保存
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveEnterprise() {
		try {
			User currentUser = SecurityUserHolder.getCurrentUser();
			//更新基础分店基础数据
			Enterprise enterprise2 = enterpriseManageImpl.get(enterprise.getDbid());
			enterprise2.setAccount(enterprise.getAccount());
			enterprise2.setAddress(enterprise.getAddress());
			enterprise2.setBank(enterprise.getBank());
			enterprise2.setContent(enterprise.getContent());
			enterprise2.setEmail(enterprise.getEmail());
			enterprise2.setFax(enterprise.getFax());
			enterprise2.setName(enterprise.getName());
			enterprise2.setPhone(enterprise.getPhone());
			enterprise2.setWebAddress(enterprise.getWebAddress());
			enterprise2.setZipCode(enterprise.getZipCode());
			enterprise2.setOldCarPhone(enterprise.getOldCarPhone());
			enterprise2.setMaintCarPhone(enterprise.getMaintCarPhone());
			enterprise2.setSalerPhone(enterprise.getSalerPhone());
			enterprise2.setEmergencyPhone(enterprise.getEmergencyPhone());
			enterprise2.setEaxminPhone(enterprise.getEaxminPhone());
			enterprise2.setTryCarPhone(enterprise.getTryCarPhone());
			enterprise.setUserId(currentUser.getDbid());
			enterpriseManageImpl.save(enterprise2);
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/enterprise/enterprise", "保存数据成功！");
	}
	/**
	 * 功能描述：删除分店新
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		String dbids = request.getParameter("dbids");
		int contNum=0;
		try {
			if(null!=dbids&&dbids.trim().length()>0){
				try {
					contNum = enterpriseManageImpl.deleteByIds(dbids);
				} catch (Exception e) {
					e.printStackTrace();
					renderErrorMsg(e, "");
					return ;
				}
			}else{
				renderErrorMsg(new Throwable("未选择操作数据！"), "");
				return ;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/enterprise/queryList"+query, "成功删除数据【"+contNum+"】！");

		return;
	}
}
