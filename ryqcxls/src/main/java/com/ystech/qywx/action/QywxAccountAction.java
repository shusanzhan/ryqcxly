package com.ystech.qywx.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.QywxAccountManageImpl;

@Component("qywxAccountAction")
@Scope("prototype")
public class QywxAccountAction extends BaseController{
	private QywxAccountManageImpl qywxAccountManageImpl;
	private QywxAccount qywxAccount;
	public QywxAccount getQywxAccount() {
		return qywxAccount;
	}
	public void setQywxAccount(QywxAccount qywxAccount) {
		this.qywxAccount = qywxAccount;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	/**
	 * 功能描述：管理页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			if(null!=qywxAccounts&&qywxAccounts.size()>0){
				QywxAccount qywxAccount2 = qywxAccounts.get(0);
				request.setAttribute("qywxAccount",qywxAccount2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "list";
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
		try {
			//Enterprise enterprise = SecurityUserHolder.getEnterprise();
			//qywxAccount.setEnterpriseId(enterprise.getDbid());
			qywxAccountManageImpl.save(qywxAccount);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		renderMsg("/account/queryList","保存成功！");
		return;
	}
}
