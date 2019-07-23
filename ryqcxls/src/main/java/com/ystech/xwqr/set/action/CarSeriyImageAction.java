package com.ystech.xwqr.set.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.model.CarSeriyImage;
import com.ystech.xwqr.set.service.CarSeriyImageManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("carSeriyImageAction")
@Scope("prototype")
public class CarSeriyImageAction extends BaseController{
	private CarSeriyImageManageImpl carSeriyImageManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	@Resource
	public void setCarSeriyImageManageImpl(
			CarSeriyImageManageImpl carSeriyImageManageImpl) {
		this.carSeriyImageManageImpl = carSeriyImageManageImpl;
	}
	@Resource
	public void setCarSeriyManageImpl(CarSeriyManageImpl carSeriyManageImpl) {
		this.carSeriyManageImpl = carSeriyManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String carSeriyImages() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		try {
			List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("status",CarModel.STATUSCOMM);
			request.setAttribute("carSeriys", carSeriys);
			List<CarSeriyImage> carSeriyImages = carSeriyImageManageImpl.findBy("carSeriyId", carSeriyId);
			request.setAttribute("carSeriyImages", carSeriyImages);
			
			CarSeriy carSeriy = carSeriyManageImpl.get(carSeriyId);
			request.setAttribute("carSeriy", carSeriy);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "carSeriyImage";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveCarModelImage() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		String url = request.getParameter("url");
		try {
			CarSeriyImage carSeriyImage=new CarSeriyImage();
			carSeriyImage.setCarSeriyId(carSeriyId);
			carSeriyImage.setUrl(url);
			carSeriyImageManageImpl.save(carSeriyImage);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/carSeriyImage/carSeriyImages?carSeriyId="+carSeriyId, "上传成功");
		return;
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
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			carSeriyImageManageImpl.deleteById(dbid);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/carSeriyImage/carSeriyImages?carSeriyId="+carSeriyId,"删除图片成功");
		return;
	}
	
}
