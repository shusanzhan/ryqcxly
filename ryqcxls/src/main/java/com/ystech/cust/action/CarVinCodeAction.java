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
import com.ystech.cust.model.CarVinCode;
import com.ystech.cust.service.CarVinCodeManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2014-7-2
 */
@Component("carVinCodeAction")
@Scope("prototype")
public class CarVinCodeAction extends BaseController{
	private CarVinCode carVinCode;
	private CarVinCodeManageImpl carVinCodeManageImpl;
	public CarVinCode getCarVinCode() {
		return carVinCode;
	}
	public void setCarVinCode(CarVinCode carVinCode) {
		this.carVinCode = carVinCode;
	}
	public CarVinCodeManageImpl getCarVinCodeManageImpl() {
		return carVinCodeManageImpl;
	}
	@Resource
	public void setCarVinCodeManageImpl(CarVinCodeManageImpl carVinCodeManageImpl) {
		this.carVinCodeManageImpl = carVinCodeManageImpl;
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
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			Page<CarVinCode> page= carVinCodeManageImpl.pagedQuerySql(pageNo, pageSize,CarVinCode.class, "select * from cust_CarVinCode where enterpriseId=? order by createTime DESC", new Object[]{enterprise.getDbid()});
			request.setAttribute("page", page);
		} catch (Exception e) {
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
			CarVinCode carVinCode2 = carVinCodeManageImpl.get(dbid);
			request.setAttribute("carVinCode", carVinCode2);
		}
		return "edit";
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
					carVinCodeManageImpl.deleteById(dbid);
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
		renderMsg("/carVinCode/queryList"+query, "删除数据成功！");
		return;
	}
	
}
