/**
 * 
 */
package com.ystech.mem.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.CouponMemberTemplate;
import com.ystech.mem.service.CouponMemberTemplateManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2014-7-13
 */
@Component("couponMemberTemplateAction")
@Scope("prototype")
public class CouponMemberTemplateAction extends BaseController{
	private CouponMemberTemplate couponMemberTemplate;
	private CouponMemberTemplateManageImpl couponMemberTemplateManageImpl;
	public CouponMemberTemplate getCouponMemberTemplate() {
		return couponMemberTemplate;
	}
	public void setCouponMemberTemplate(CouponMemberTemplate couponMemberTemplate) {
		this.couponMemberTemplate = couponMemberTemplate;
	}
	@Resource
	public void setCouponMemberTemplateManageImpl(
			CouponMemberTemplateManageImpl couponMemberTemplateManageImpl) {
		this.couponMemberTemplateManageImpl = couponMemberTemplateManageImpl;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		Integer type = ParamUtil.getIntParam(request,"type", -1);
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from cou_couponMemberTemplate where 1=1 and enterpriseId="+enterprise.getDbid();
			List param=new ArrayList();
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=type&&type>0){
				sql=sql+" and type = ? ";
				param.add(type);
			}
			Page<CouponMemberTemplate> page = couponMemberTemplateManageImpl.pagedQuerySql(pageNo, pageSize,CouponMemberTemplate.class,sql, param.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
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
	public String add() throws Exception {
		return "edit";
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
			CouponMemberTemplate couponMemberTemplate2 = couponMemberTemplateManageImpl.get(dbid);
			request.setAttribute("couponMemberTemplate", couponMemberTemplate2);
		}
		return "edit";
	}

	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 4);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null!=couponMemberTemplate.getDbid()&&couponMemberTemplate.getDbid()>0){
				CouponMemberTemplate couponMemberTemplate2 = couponMemberTemplateManageImpl.get(couponMemberTemplate.getDbid());
				couponMemberTemplate2.setName(couponMemberTemplate.getName());
				couponMemberTemplate2.setType(couponMemberTemplate.getType());
				couponMemberTemplate2.setImage(couponMemberTemplate.getImage());
				couponMemberTemplate2.setEnabled(couponMemberTemplate.isEnabled());
				couponMemberTemplate2.setDescription(couponMemberTemplate.getDescription());
				couponMemberTemplate2.setShowHiden(couponMemberTemplate.getShowHiden());
				couponMemberTemplate2.setEnterpriseId(enterprise.getDbid());
				couponMemberTemplate2.setModifyTime(new Date());
				couponMemberTemplateManageImpl.save(couponMemberTemplate2);
			}else{
				couponMemberTemplate.setCreateTime(new Date());
				couponMemberTemplate.setModifyTime(new Date());
				couponMemberTemplate.setEnterpriseId(enterprise.getDbid());
				couponMemberTemplateManageImpl.save(couponMemberTemplate);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/couponMemberTemplate/queryList?parentMenu="+parentMenu, "保存数据成功！");
		return ;
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
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 4);
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					couponMemberTemplateManageImpl.deleteById(dbid);
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
		renderMsg("/couponMemberTemplate/queryList"+query+"&parentMenu="+parentMenu, "删除数据成功！");
		return;
	}
	/**
	 * 前台获取json
	 */
	public void queryByDbid() {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			if(dbid>0){
				CouponMemberTemplate couponMemberTemplate2 = couponMemberTemplateManageImpl.get(dbid);
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("name", couponMemberTemplate2.getName());
				jsonObject.put("type", couponMemberTemplate2.getType());
				renderJson(jsonObject.toString());
				return ;
			}else{
				renderJson("1");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			renderJson("1");
			return ;
		}
	}
}
