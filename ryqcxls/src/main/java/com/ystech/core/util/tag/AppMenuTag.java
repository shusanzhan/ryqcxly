package com.ystech.core.util.tag;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ystech.qywx.model.AppMenu;
import com.ystech.qywx.service.AppMenuManageImpl;


/**
 * @author 作者 舒三战
 * @version 创建时间：2013-5-7 上午9:52:38 类说明
 **/
public class AppMenuTag extends TagSupport {
	private Integer dbid;
	
	public Integer getDbid() {
		return dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public int doEndTag() throws JspException {
		try {
			JspWriter out = pageContext.getOut();
			if(null!=dbid) {
				HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
				//获取spring的环境信息
				WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				AppMenuManageImpl appMenuManageImpl  =(AppMenuManageImpl)webApplicationContext.getBean("appMenuManageImpl");
				AppMenu appMenu = appMenuManageImpl.get(dbid);
				String tableTr = appMenuManageImpl.getTableTr(appMenu, "&nbsp;&nbsp;&nbsp;&nbsp;");
				out.print(tableTr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return EVAL_PAGE; // 不包含主体内容
	}

	public int doStartTag() throws JspException {
		return EVAL_PAGE;
	}

}
