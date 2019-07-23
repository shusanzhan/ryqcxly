package com.ystech.qywx.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.model.MessageTemplateType;
import com.ystech.qywx.service.MessageTemplateTypeManageImpl;

@Component("messageTemplateTypeAction")
@Scope("prototype")
public class MessageTemplateTypeAction extends BaseController{
	private MessageTemplateTypeManageImpl messageTemplateTypeManageImpl;
	private MessageTemplateType messageTemplateType;
	public MessageTemplateType getMessageTemplateType() {
		return messageTemplateType;
	}
	public void setMessageTemplateType(MessageTemplateType messageTemplateType) {
		this.messageTemplateType = messageTemplateType;
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
		try{
			 Page<MessageTemplateType> page= messageTemplateTypeManageImpl.pagedQuerySql(pageNo, pageSize, MessageTemplateType.class, "select * from qywx_MessageTemplateType", new Object[]{});
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
			MessageTemplateType messageTemplateType = messageTemplateTypeManageImpl.get(dbid);
			request.setAttribute("messageTemplateType", messageTemplateType);
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
			Integer dbid = messageTemplateType.getDbid();
			if(null==dbid){
				messageTemplateType.setCreateDate(new Date());
				messageTemplateType.setModifyDate(new Date());
			}else{
				messageTemplateType.setModifyDate(new Date());
			}
			messageTemplateTypeManageImpl.save(messageTemplateType);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/messageTemplateType/queryList", "保存数据成功！");
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
					messageTemplateTypeManageImpl.deleteById(dbid);
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
		renderMsg("/messageTemplateType/queryList"+query, "删除数据成功！");
		return;
	}
}
