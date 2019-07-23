/**
 * 
 */
package com.ystech.cust.action;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.SmsTemplate;
import com.ystech.cust.service.SmsTemplateManageImpl;

/**
 * @author shusanzhan
 * @date 2014-7-26
 */
@Component("smsTemplateAction")
@Scope("prototype")
public class SmsTemplateAction extends BaseController {
	
	private SmsTemplateManageImpl smsTemplateManageImpl;
	private SmsTemplate smsTemplate;
	@Resource
	public void setSmsTemplateManageImpl(SmsTemplateManageImpl smsTemplateManageImpl) {
		this.smsTemplateManageImpl = smsTemplateManageImpl;
	}
	
	public SmsTemplate getSmsTemplate() {
		return smsTemplate;
	}

	public void setSmsTemplate(SmsTemplate smsTemplate) {
		this.smsTemplate = smsTemplate;
	}

	public SmsTemplateManageImpl getSmsTemplateManageImpl() {
		return smsTemplateManageImpl;
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
		try{
			Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
			Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
			Integer type = ParamUtil.getIntParam(request, "type", -1);
			String sql="select * from cust_SmsTemplate where 1=1 ";
			if(type>0){
				sql=sql+" and type="+type;
					
			}
			Page<SmsTemplate> 	page = smsTemplateManageImpl.pagedQuerySql(pageNo, pageSize,SmsTemplate.class, sql, new Object[]{});
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
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
	@SuppressWarnings("unchecked")
	public String smsTemplateSelect() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			Integer type = ParamUtil.getIntParam(request, "type", -1);
			String sql="select * from cust_SmsTemplate where 1=1 ";
			if(type>0){
				sql=sql+" and type="+type;
				
			}
			List<SmsTemplate> smsTemplates = smsTemplateManageImpl.find(sql, new Object[]{});
			request.setAttribute("smsTemplates", smsTemplates);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "smsTemplateSelect";
	}

	/**
	 * 功能描述： 参数描述： 逻辑描述：
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
			SmsTemplate smstTemplate2 = smsTemplateManageImpl.get(dbid);
			request.setAttribute("smsTemplate", smstTemplate2);
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
		try{
			Integer dbid = smsTemplate.getDbid();
			if(dbid==null||dbid<=0){
				smsTemplate.setCreateTime(new Date());
				smsTemplate.setModifyTime(new Date());
				smsTemplateManageImpl.save(smsTemplate);
			}else{
				SmsTemplate smsTemplate2 = smsTemplateManageImpl.get(smsTemplate.getDbid());
				smsTemplate2.setContent(smsTemplate.getContent());
				smsTemplate2.setType(smsTemplate.getType());
				smsTemplate2.setName(smsTemplate.getName());
				smsTemplate2.setModifyTime(new Date());
				smsTemplateManageImpl.save(smsTemplate2);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/smsTemplate/queryList", "保存数据成功！");
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
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					smsTemplateManageImpl.deleteById(dbid);
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
		renderMsg("/smsTemplate/queryList"+query, "删除数据成功！");
		return;
	}
}
