/**
 * 
 */
package com.ystech.cust.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.DistributorChargePerson;
import com.ystech.cust.service.DistributorChargePersonManageImpl;

/**
 * @author shusanzhan
 * @date 2014-8-16
 */
@Component("distributorChargePersonAction")
@Scope("prototype")
public class DistributorChargePersonAction extends BaseController{
	private DistributorChargePerson distributorChargePerson;
	private DistributorChargePersonManageImpl distributorChargePersonManageImpl;
	private HttpServletRequest request=getRequest();
	public DistributorChargePerson getDistributorChargePerson() {
		return distributorChargePerson;
	}
	public void setDistributorChargePerson(
			DistributorChargePerson distributorChargePerson) {
		this.distributorChargePerson = distributorChargePerson;
	}
	public DistributorChargePersonManageImpl getDistributorChargePersonManageImpl() {
		return distributorChargePersonManageImpl;
	}
	@Resource
	public void setDistributorChargePersonManageImpl(
			DistributorChargePersonManageImpl distributorChargePersonManageImpl) {
		this.distributorChargePersonManageImpl = distributorChargePersonManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		Integer distributorId = ParamUtil.getIntParam(request, "distributorId", -1);
		int size=0;
		try{
			List<DistributorChargePerson> distributorChargePersons = distributorChargePersonManageImpl.findBy("distributorId", distributorId);
			if(null!=distributorChargePersons){
				size = distributorChargePersons.size();
				request.setAttribute("distributorChargePersons", distributorChargePersons);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(size>=1){
			return "list";
		}else{
			return "edit";
		}
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		try{
			distributorChargePersonManageImpl.save(distributorChargePerson);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributorChargePerson/queryList?distributorId="+distributorChargePerson.getDistributorId(), "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				DistributorChargePerson distributorChargePerson2 = distributorChargePersonManageImpl.get(dbid);
				request.setAttribute("distributorChargePerson", distributorChargePerson2);
			}
		}catch (Exception e) {
			e.printStackTrace();
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
	public void delete() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request,"dbids",-1);
		try {
				if(dbid>0){
					DistributorChargePerson distributorChargePerson2 = distributorChargePersonManageImpl.get(dbid);
					distributorChargePersonManageImpl.deleteById(dbid);
					renderMsg("/distributorChargePerson/queryList?distributorId="+distributorChargePerson2.getDistributorId(), "删除数据成功！");
					return;
				}else{
					renderErrorMsg(new Throwable("未选中删除数据！"), "");
					return ;
				}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		
	}
}
