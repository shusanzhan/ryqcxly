package com.ystech.qywx.stat.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.web.BaseController;

@Component("qywxStatAction")
@Scope("prototype")
public class QywxStatAction extends BaseController{
	public String index(){
		return "index";
	}
}
