package com.ystech.stat.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.service.CustomerInfromManageImpl;
import com.ystech.stat.model.CustomerInfromStaSet;
import com.ystech.stat.service.CustomerInfromStaSetManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

@Component("customerInfromStaSetAction")
@Scope("prototype")
public class CustomerInfromStaSetAction extends BaseController{
	private CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl;
	private CustomerInfromManageImpl customerInfromManageImpl;
	
	@Resource
	public void setCustomerInfromStaSetManageImpl(
			CustomerInfromStaSetManageImpl customerInfromStaSetManageImpl) {
		this.customerInfromStaSetManageImpl = customerInfromStaSetManageImpl;
	}
	@Resource
	public void setCustomerInfromManageImpl(
			CustomerInfromManageImpl customerInfromManageImpl) {
		this.customerInfromManageImpl = customerInfromManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() {
		HttpServletRequest request = getRequest();
		Integer enterpriseId = ParamUtil.getIntParam(request, "enterpriseId", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(enterpriseId<0){
				enterpriseId = enterprise.getDbid();
			}
			List<CustomerInfromStaSet> customerInfromStaSets = customerInfromStaSetManageImpl.findBy("enterpriseId", enterpriseId);
			request.setAttribute("customerInfromStaSets", customerInfromStaSets);
		} catch (Exception e) {
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
	public void save()  {
		HttpServletRequest request = getRequest();
		Integer[] dbids = ParamUtil.getIntArray(request, "dbid");
		Integer[] codeNums = ParamUtil.getIntArray(request, "codeNum");
		Integer[] staStatuss = ParamUtil.getIntArray(request, "staStatus");
		String[] alias = ParamUtil.getStrArray(request, "alias");
		try {
			if(dbids.length<=0){
				renderErrorMsg(new Throwable("保存失败，无网销平台"), "");
				return ;
			}
			int i=0;
			for (int dbid : dbids) {
				CustomerInfromStaSet customerInfromStaSet = customerInfromStaSetManageImpl.get(dbid);
				customerInfromStaSet.setAlias(alias[i]);
				customerInfromStaSet.setCodeNum(codeNums[i]);
				customerInfromStaSet.setStaStatus(staStatuss[i]);
				customerInfromStaSetManageImpl.save(customerInfromStaSet);
				i++;
			}
		} catch (Exception e) {
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/statCustomerRecordNet/queryNetStaMonth", "网销平台统计设置成功");
		return;
	}
}
