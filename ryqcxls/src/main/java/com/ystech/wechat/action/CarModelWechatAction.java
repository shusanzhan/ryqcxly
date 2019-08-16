package com.ystech.wechat.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.weixin.service.WeixinGzuserinfoManageImpl;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.model.CarSeriyImage;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyImageManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("carModelWechatAction")
@Scope("prototype")
public class CarModelWechatAction extends BaseController{
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CarSeriyImageManageImpl carModelImageManageImpl;
	private WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl;
	@Resource
	public void setWeixinGzuserinfoManageImpl(
			WeixinGzuserinfoManageImpl weixinGzuserinfoManageImpl) {
		this.weixinGzuserinfoManageImpl = weixinGzuserinfoManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	@Resource
	public void setCarModelManageImpl(CarModelManageImpl carModelManageImpl) {
		this.carModelManageImpl = carModelManageImpl;
	}
	@Resource
	public void setCarModelImageManageImpl(
			CarSeriyImageManageImpl carModelImageManageImpl) {
		this.carModelImageManageImpl = carModelImageManageImpl;
	}
	/**
	 * 功能描述：介绍
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String carModelList() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
				List<CarSeriy> carModels = carSeriyManageImpl.find("from CarSeriy where brandId=? AND status=? order by orderNum", new Object[]{5,CarSeriy.STATUSCOMM});
				request.setAttribute("carModels", carModels);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "carModelList";
	}
	/**
	 * 功能描述：优惠
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String policy() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			List<CarSeriy> carModels = carSeriyManageImpl.find("from CarSeriy where brandId=? AND status=? order by orderNum", new Object[]{5,CarSeriy.STATUSCOMM});
			request.setAttribute("carModels", carModels);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "policy";
	}
	/**
	 * 功能描述：车型
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String carModel() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request,"dbid", -1);
		try {
			CarSeriy carModel= carSeriyManageImpl.get(dbid);
			request.setAttribute("carModel", carModel);
			
			List<CarSeriyImage> carModelImages = carModelImageManageImpl.findBy("carSeriyId", dbid);
			request.setAttribute("carModelImages", carModelImages);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "carModel";
	}
	
}
