package com.ystech.qywx.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.service.BrandManageImpl;

@Component("qywxHfIndexAction")
@Scope("prototype")
public class QywxHfIndexAction extends BaseController{
	private BrandManageImpl brandManageImpl;

	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
	}
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
			List<Brand> brands = brandManageImpl.getAll();
			request.setAttribute("brands", brands);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "index";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String brandIndex() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		try {
			Brand brand = brandManageImpl.get(brandId);
			request.setAttribute("brand", brand);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "brandIndex";
	}
}
