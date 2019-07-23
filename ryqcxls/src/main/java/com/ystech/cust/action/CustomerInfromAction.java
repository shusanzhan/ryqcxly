package com.ystech.cust.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.service.CustomerInfromManageImpl;

@Component("customerInfromAction")
@Scope("prototype")
public class CustomerInfromAction extends BaseController{
	private CustomerInfrom customerInfrom;
	private CustomerInfromManageImpl customerInfromManageImpl;
	public CustomerInfrom getCustomerInfrom() {
		return customerInfrom;
	}
	public void setCustomerInfrom(CustomerInfrom customerInfrom) {
		this.customerInfrom = customerInfrom;
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
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			List<CustomerInfrom> customerInfroms = customerInfromManageImpl.executeSql("select * from cust_CustomerInfrom where parentId IS NULL order by num", new Object[]{});
			request.setAttribute("customerInfroms", customerInfroms);
		}catch (Exception e) {
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
	public String add() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			String cusString = customerInfromManageImpl.getCustomerInfrom(null);
			request.setAttribute("customerInfromSelect", cusString);
		}catch (Exception e) {
			log.error(e);
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(dbid);
				String cusString = customerInfromManageImpl.getCustomerInfrom(customerInfrom2);
				request.setAttribute("customerInfromSelect", cusString);
				request.setAttribute("customerInfrom", customerInfrom2);
			}else{
				String cusString = customerInfromManageImpl.getCustomerInfrom(null);
				request.setAttribute("customerInfromSelect", cusString);
			}
			
		}catch (Exception e) {
			log.error(e);
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
	public void save() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer parendId = ParamUtil.getIntParam(request, "parentId", -1);
		if(parendId>-1){
			try{
				CustomerInfrom parent=null;
				if(parendId>0){
					parent = customerInfromManageImpl.get(parendId);
					customerInfrom.setParent(parent);
					customerInfrom.setLevelNum(2);
				}else{
					customerInfrom.setLevelNum(1);
				}
				//第一添加数据 保存
				if(null==customerInfrom.getDbid()||customerInfrom.getDbid()<=0)
				{
					customerInfrom.setModifyDate(new Date());
					customerInfrom.setCreateDate(new Date());
					customerInfromManageImpl.save(customerInfrom);
				}else{
					//修改时保存数据
					CustomerInfrom customerInfrom2 = customerInfromManageImpl.get(customerInfrom.getDbid());
					customerInfrom2.setModifyDate(new Date());
					customerInfrom2.setName(customerInfrom.getName());
					customerInfrom2.setNum(customerInfrom.getNum());
					customerInfrom2.setLevelNum(customerInfrom.getLevelNum());
					customerInfrom2.setParent(customerInfrom.getParent());
					customerInfrom2.setNote(customerInfrom.getNote());
					customerInfromManageImpl.save(customerInfrom2);
				}
			}catch (Exception e) {
				log.error(e);
				e.printStackTrace();
				renderErrorMsg(e, "");
				return ;
			}
		}else{
			renderErrorMsg(new Throwable("系统异常！"), "");
			return;
		}
		renderMsg("/customerInfrom/queryList", "保存数据成功！");
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
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(null!=dbid&&dbid>0){
			try {
					List<CustomerInfrom> childs = customerInfromManageImpl.findBy("parent.dbid", dbid);
					if(null!=childs&&childs.size()>0){
						renderErrorMsg(new Throwable("该数据有子级分类，请先删除子级分类在删除数据！"), "");
						return ;
					}else{
						customerInfromManageImpl.deleteById(dbid);
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
		renderMsg("/customerInfrom/queryList"+query, "删除数据成功！");
		return;
	}
}
