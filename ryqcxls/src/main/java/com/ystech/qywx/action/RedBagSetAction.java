package com.ystech.qywx.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.service.sys.EnterpriseManageImpl;

@Component("redBagSetAction")
@Scope("prototype")
public class RedBagSetAction extends BaseController{
	private EnterpriseManageImpl enterpriseManageImpl;
	@Resource
	public void setEnterpriseManageImpl(EnterpriseManageImpl enterpriseManageImpl) {
		this.enterpriseManageImpl = enterpriseManageImpl;
	}
	/**
	 * 功能描述：设置页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Enterprise enterprise = SecurityUserHolder.getEnterprise();
		try {
			Enterprise enterprise2 = enterpriseManageImpl.get(enterprise.getDbid());
			request.setAttribute("enterprise", enterprise2);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
		HttpServletRequest request = this.getRequest();
		Integer payStatus = ParamUtil.getIntParam(request, "payStatus", -1);
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		try {
			Enterprise enterprise = enterpriseManageImpl.get(enterpriseId);
			if(payStatus<0){
				payStatus=Enterprise.PAYCOMM;
			}
			enterprise.setPayStatus(payStatus);
			enterpriseManageImpl.save(enterprise);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/redBagSet/edit", "设置发送红包状态成功！");
		return;
	}
	
}
