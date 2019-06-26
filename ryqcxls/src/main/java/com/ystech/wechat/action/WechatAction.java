package com.ystech.wechat.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;

@Component("wechatAction")
@Scope("prototype")
public class WechatAction extends BaseController{
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String index() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {

		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}

}
