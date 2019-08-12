package com.ystech.qywx.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.App;
import com.ystech.qywx.model.MessageTemplate;
import com.ystech.qywx.model.MessageTemplateType;
import com.ystech.qywx.service.AppManageImpl;
import com.ystech.qywx.service.MessageTemplateManageImpl;
import com.ystech.qywx.service.MessageTemplateTypeManageImpl;

@Component("messageTemplateAction")
@Scope("prototype")
public class MessageTemplateAction extends BaseController{
	private MessageTemplateManageImpl messageTemplateManageImpl;
	private MessageTemplate messageTemplate;
	private AppManageImpl appManageImpl;
	private MessageTemplateTypeManageImpl messageTemplateTypeManageImpl;
	
	public MessageTemplate getMessageTemplate() {
		return messageTemplate;
	}
	public void setMessageTemplate(MessageTemplate messageTemplate) {
		this.messageTemplate = messageTemplate;
	}
	@Resource
	public void setMessageTemplateManageImpl(
			MessageTemplateManageImpl messageTemplateManageImpl) {
		this.messageTemplateManageImpl = messageTemplateManageImpl;
	}
	@Resource
	public void setAppManageImpl(AppManageImpl appManageImpl) {
		this.appManageImpl = appManageImpl;
	}
	@Resource
	public void setMessageTemplateTypeManageImpl(
			MessageTemplateTypeManageImpl messageTemplateTypeManageImpl) {
		this.messageTemplateTypeManageImpl = messageTemplateTypeManageImpl;
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
		Integer appId = ParamUtil.getIntParam(request, "appId", -1);
		Integer messageTemplateTypeId = ParamUtil.getIntParam(request, "messageTemplateTypeId", -1);
		try{
			List<App> apps = appManageImpl.getAll();
			request.setAttribute("apps", apps);
			
			List<MessageTemplateType> messageTemplateTypes = messageTemplateTypeManageImpl.getAll();
			request.setAttribute("messageTemplateTypes", messageTemplateTypes);
			String sql="select * from qywx_MessageTemplate where 1=1 ";
			if(appId>0){
				sql=sql+" and agentid="+appId;
			}
			sql=sql+" order by agentid ";
			 Page<MessageTemplate> page= messageTemplateManageImpl.pagedQuerySql(pageNo, pageSize,MessageTemplate.class,sql, new Object[]{});
			 request.setAttribute("page", page);
		}catch (Exception e) {
			// TODO: handle exception
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
		HttpServletRequest request = this.getRequest();
		try {
			List<App> apps = appManageImpl.getAll();
			request.setAttribute("apps", apps);
			
			
			List<MessageTemplateType> messageTemplateTypes = messageTemplateTypeManageImpl.getAll();
			request.setAttribute("messageTemplateTypes", messageTemplateTypes);
		} catch (Exception e) {
			// TODO: handle exception
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
	public String edit() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			List<App> apps = appManageImpl.getAll();
			request.setAttribute("apps", apps);
			
			List<MessageTemplateType> messageTemplateTypes = messageTemplateTypeManageImpl.getAll();
			request.setAttribute("messageTemplateTypes", messageTemplateTypes);
			if(dbid>0){
				MessageTemplate messageTemplate = messageTemplateManageImpl.get(dbid);
				request.setAttribute("messageTemplate", messageTemplate);
			}
		} catch (Exception e) {
			// TODO: handle exception
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
		Integer appId = ParamUtil.getIntParam(request, "appId", -1);
		Integer messageTemplateTypeId = ParamUtil.getIntParam(request, "messageTemplateTypeId", -1);
		try{
			if(appId>0){
				App app = appManageImpl.get(appId);
				messageTemplate.setApp(app);
			}
			if(messageTemplateTypeId>0){
				MessageTemplateType messageTemplateType = messageTemplateTypeManageImpl.get(messageTemplateTypeId);
				messageTemplate.setMessageTemplateType(messageTemplateType);
			}
			messageTemplateManageImpl.save(messageTemplate);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/messageTemplate/queryList", "保存数据成功！");
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
					messageTemplateManageImpl.deleteById(dbid);
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
		renderMsg("/messageTemplate/queryList"+query, "删除数据成功！");
		return;
	}

}
