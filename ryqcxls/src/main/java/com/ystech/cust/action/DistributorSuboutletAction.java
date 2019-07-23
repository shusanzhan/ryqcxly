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
import com.ystech.cust.model.DistributorSuboutlet;
import com.ystech.cust.service.DistributorSuboutletManageImpl;

/**
 * @author shusanzhan
 * @date 2014-8-16
 */
@Component("distributorSuboutletAction")
@Scope("prototype")
public class DistributorSuboutletAction extends BaseController{
	private DistributorSuboutlet distributorSuboutlet;
	private DistributorSuboutletManageImpl distributorSuboutletManageImpl;
	
	public DistributorSuboutlet getDistributorSuboutlet() {
		return distributorSuboutlet;
	}
	public void setDistributorSuboutlet(DistributorSuboutlet distributorSuboutlet) {
		this.distributorSuboutlet = distributorSuboutlet;
	}
	public DistributorSuboutletManageImpl getDistributorSuboutletManageImpl() {
		return distributorSuboutletManageImpl;
	}
	@Resource
	public void setDistributorSuboutletManageImpl(
			DistributorSuboutletManageImpl distributorSuboutletManageImpl) {
		this.distributorSuboutletManageImpl = distributorSuboutletManageImpl;
	}
	private HttpServletRequest request=getRequest();
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
			List<DistributorSuboutlet> distributorSuboutlets = distributorSuboutletManageImpl.findBy("distributorId", distributorId);
			if(null!=distributorSuboutlets){
				size = distributorSuboutlets.size();
				request.setAttribute("distributorSuboutlets", distributorSuboutlets);
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
			distributorSuboutletManageImpl.save(distributorSuboutlet);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributorSuboutlet/queryList?distributorId="+distributorSuboutlet.getDistributorId(), "保存数据成功！");
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
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
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				DistributorSuboutlet distributorSuboutlet = distributorSuboutletManageImpl.get(dbid);
				request.setAttribute("distributorSuboutlet", distributorSuboutlet);
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
					DistributorSuboutlet distributorSuboutlet = distributorSuboutletManageImpl.get(dbid);
					distributorSuboutletManageImpl.deleteById(dbid);
					renderMsg("/distributorSuboutlet/queryList?distributorId="+distributorSuboutlet.getDistributorId(), "删除数据成功！");
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
