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
import com.ystech.cust.model.DistributorBuff;
import com.ystech.cust.service.DistributorBuffManageImpl;

/**
 * @author shusanzhan
 * @date 2014-8-16
 */
@Component("distributorBuffAction")
@Scope("prototype")
public class DistributorBuffAction extends BaseController{
	private DistributorBuffManageImpl distributorBuffManageImpl;
	private DistributorBuff distributorBuff;
	
	public DistributorBuffManageImpl getDistributorBuffManageImpl() {
		return distributorBuffManageImpl;
	}
	@Resource
	public void setDistributorBuffManageImpl(
			DistributorBuffManageImpl distributorBuffManageImpl) {
		this.distributorBuffManageImpl = distributorBuffManageImpl;
	}
	public DistributorBuff getDistributorBuff() {
		return distributorBuff;
	}
	
	public void setDistributorBuff(DistributorBuff distributorBuff) {
		this.distributorBuff = distributorBuff;
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
			List<DistributorBuff> distributorBuffs = distributorBuffManageImpl.findBy("distributorId", distributorId);
			if(null!=distributorBuffs){
				size = distributorBuffs.size();
				request.setAttribute("distributorBuffs", distributorBuffs);
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
			distributorBuffManageImpl.save(distributorBuff);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/distributorBuff/queryList?distributorId="+distributorBuff.getDistributorId(), "保存数据成功！");
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
				DistributorBuff distributorBuff2 = distributorBuffManageImpl.get(dbid);
				request.setAttribute("distributorBuff", distributorBuff2);
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
					DistributorBuff distributorBuff2 = distributorBuffManageImpl.get(dbid);
					distributorBuffManageImpl.deleteById(dbid);
					renderMsg("/distributorBuff/queryList?distributorId="+distributorBuff2.getDistributorId(), "删除数据成功！");
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
