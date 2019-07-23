package com.ystech.qywx.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.FileNameUtil;
import com.ystech.core.util.MessageUtile;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.util.PathUtil;
import com.ystech.core.web.BaseController;
import com.ystech.cust.model.Customer;
import com.ystech.cust.model.CustomerBussi;
import com.ystech.cust.model.CustomerImage;
import com.ystech.cust.model.CustomerImageApproval;
import com.ystech.cust.model.CustomerLastBussi;
import com.ystech.cust.model.CustomerPhase;
import com.ystech.cust.model.CustomerPidBookingRecord;
import com.ystech.cust.model.CustomerShoppingRecord;
import com.ystech.cust.model.CustomerTrack;
import com.ystech.cust.model.OrderContract;
import com.ystech.cust.service.CustomerImageApprovalManageImpl;
import com.ystech.cust.service.CustomerImageManageImpl;
import com.ystech.cust.service.CustomerMangeImpl;
import com.ystech.cust.service.CustomerPhaseManageImpl;
import com.ystech.cust.service.CustomerTrackManageImpl;
import com.ystech.qywx.core.QywxUtil;
import com.ystech.qywx.model.AccessToken;
import com.ystech.qywx.model.QywxAccount;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.weixin.core.util.WeixinCommon;
import com.ystech.weixin.core.util.WeixinSignUtil;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.set.model.Brand;
import com.ystech.xwqr.set.model.CarModel;
import com.ystech.xwqr.set.model.CarSeriy;
import com.ystech.xwqr.set.service.BrandManageImpl;
import com.ystech.xwqr.set.service.CarModelManageImpl;
import com.ystech.xwqr.set.service.CarSeriyManageImpl;

@Component("qywxCustomerImageAction")
@Scope("prototype")
public class QywxCustomerImageAction extends BaseController{
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private CustomerImageManageImpl customerImageManageImpl;
	private CustomerMangeImpl customerMangeImpl;
	private CustomerPhaseManageImpl customerPhaseManageImpl;
	private BrandManageImpl brandManageImpl;
	private CarSeriyManageImpl carSeriyManageImpl;
	private CarModelManageImpl carModelManageImpl;
	private CustomerImageApprovalManageImpl customerImageApprovalManageImpl;
	private CustomerTrackManageImpl customerTrackManageImpl;
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}

	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}

	@Resource
	public void setCustomerImageManageImpl(
			CustomerImageManageImpl customerImageManageImpl) {
		this.customerImageManageImpl = customerImageManageImpl;
	}

	@Resource
	public void setCustomerMangeImpl(CustomerMangeImpl customerMangeImpl) {
		this.customerMangeImpl = customerMangeImpl;
	}

	@Resource
	public void setCustomerPhaseManageImpl(
			CustomerPhaseManageImpl customerPhaseManageImpl) {
		this.customerPhaseManageImpl = customerPhaseManageImpl;
	}

	@Resource
	public void setBrandManageImpl(BrandManageImpl brandManageImpl) {
		this.brandManageImpl = brandManageImpl;
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
	public void setCustomerImageApprovalManageImpl(
			CustomerImageApprovalManageImpl customerImageApprovalManageImpl) {
		this.customerImageApprovalManageImpl = customerImageApprovalManageImpl;
	}
	@Resource
	public void setCustomerTrackManageImpl(
			CustomerTrackManageImpl customerTrackManageImpl) {
		this.customerTrackManageImpl = customerTrackManageImpl;
	}

	/**
	 * 功能描述：查询成交客户
	 * 参数描述：部门ID，车系Id
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String uploadImageWaitingCustomer() throws Exception {
		HttpServletRequest request = this.getRequest();
		User user = getSessionUser();
		Integer carSeriyId = ParamUtil.getIntParam(request, "carSeriyId", -1);
		Integer carModelId = ParamUtil.getIntParam(request, "carModelId", -1);
		Integer brandId = ParamUtil.getIntParam(request, "brandId", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String name = request.getParameter("name");
		String vinCode = request.getParameter("vinCode");
		try {
			//意向级别
			List<CustomerPhase> customerPhases = customerPhaseManageImpl.getAll();
			request.setAttribute("customerPhases", customerPhases);
			List<Brand> brands = brandManageImpl.getAll();
			request.setAttribute("brands", brands);
			String hql="from CarModel where 1=1 ";
			if(brandId>0){
				//车系
				List<CarSeriy> carSeriys = carSeriyManageImpl.findBy("brand.dbid", brandId);
				hql=hql+" and brand.dbid="+brandId;
				request.setAttribute("carSeriys", carSeriys);
			}else{
				//车系
				List<CarSeriy> carSeriys = carSeriyManageImpl.getAll();
				request.setAttribute("carSeriys", carSeriys);
			}
			
			if(carSeriyId>0){
				//车型
				hql=hql+" and carseries.dbid="+carSeriyId;
			}
			List<CarModel> carModels = carModelManageImpl.find(hql, null);
			request.setAttribute("carModels", carModels);
			String sql="select * from cust_Customer as cu,cust_CustomerPidBookingRecord as cpid,cust_customerImageApproval cim where cim.customerId=cu.dbid and cpid.customerId=cu.dbid and cpid.pidStatus=? and cu.bussiStaffId=? and cim.status<? ";
			List params=new ArrayList();
			params.add(CustomerPidBookingRecord.FINISHED);
			params.add(user.getDbid());
			params.add(CustomerImageApproval.STATUSUPLOADED);
			
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and cu.mobilePhone like ? ";
				params.add("%"+mobilePhone+"%");
			}
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cu.name like ? ";
				params.add("%"+name+"%");
			}
			if(null!=vinCode&&vinCode.trim().length()>0){
				sql=sql+" and cpid.vinCode like ? ";
				params.add("%"+vinCode+"%");
			}
			if(carSeriyId>0){
				sql=sql+" and cpid.carSeriyId=? ";
				params.add(carSeriyId);
			}
			if(brandId>0){
				sql=sql+" and cpid.brandId=? ";
				params.add(brandId);
			}
			if(carModelId>0){
				sql=sql+" and cpid.carModelId=? ";
				params.add(carModelId);
			}
			sql=sql+" and cpid.modifyTime>='2015-10-01' order by cim.status,cpid.modifyTime DESC";
			List<Customer> customers = customerMangeImpl.executeSql(sql,params.toArray());
			request.setAttribute("customers", customers);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "uploadImageWaitingCustomer";
	}
	
	/**
	 * 功能描述：客户上传照片页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String uploadImage() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerid", -1);
		try {
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
			
			//客户跟踪记录
			List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customer2.getDbid(),CustomerTrack.TASKFINISHTYPECOMM});
			request.setAttribute("customertracks", customerTracks);
			
			
			//最终结果信息
			CustomerLastBussi customerLastBussi = customer2.getCustomerLastBussi();
			request.setAttribute("customerLastBussi", customerLastBussi);
			
			//客户订单信息
			OrderContract orderContract = customer2.getOrderContract();
			request.setAttribute("orderContract", orderContract);
			
			//客户交车记录
			CustomerPidBookingRecord customerPidBookingRecord = customer2.getCustomerPidBookingRecord();
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
			
			//上传照片审批记录
			CustomerImageApproval customerImageApproval = customer2.getCustomerImageApproval();
			request.setAttribute("customerImageApproval", customerImageApproval);
			
			List<CustomerImage> customerImages = customerImageManageImpl.find("from CustomerImage where customerId=? and type=? ", new Object[]{customer2.getDbid(),CustomerImage.TYPEHANDCAR});
			if(null!=customerImages&&customerImages.size()>0){
				request.setAttribute("customerImage", customerImages.get(0));
			}
			
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			QywxAccount qywxAccount=null;
			//微信分享代码
			String path = request.getContextPath();
			String path2 = request.getRequestURI();
			System.out.println("===="+path2);
			int serverPort = request.getServerPort();
			String url="";
			if(serverPort==80){
				String queryString = request.getQueryString();
				if(null==queryString){
					url = request.getScheme()+"://"+request.getServerName()+path+"/qywxCustomerImage/uploadImage";
				}else{
					url = request.getScheme()+"://"+request.getServerName()+path+"/qywxCustomerImage/uploadImage?"+queryString.split("#")[0];
				}
			}else{
				String queryString = request.getQueryString();
				System.out.println(queryString);
				 url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/qywxCustomerImage/uploadImage?"+request.getQueryString().split("#")[0];
			}
			System.out.println("==========:"+url);
			if(null!=qywxAccounts&&qywxAccounts.size()>0){
				qywxAccount = qywxAccounts.get(0);
				AccessToken accessToken = QywxUtil.getTicketAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(),qywxAccount.getSecurity());
				if(null!=accessToken){
					WeixinCommon weixinCommon = WeixinSignUtil.getWeixinQywx(qywxAccount.getGroupId(),accessToken.getJsapiTicket(), url);
					request.setAttribute("weixin", weixinCommon);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "uploadImage";
	}
	/**
	 * 功能描述：上传 行驶证照片
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String uploadImageDriving() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer customerId = ParamUtil.getIntParam(request, "customerid", -1);
		try {
			Customer customer2 = customerMangeImpl.get(customerId);
			request.setAttribute("customer", customer2);
			//客户业务信息
			CustomerBussi customerBussi2 = customer2.getCustomerBussi();
			request.setAttribute("customerBussi", customerBussi2);
			
			CustomerShoppingRecord customerShoppingRecord2 = customer2.getCustomerShoppingRecord();
			request.setAttribute("customerShoppingRecord", customerShoppingRecord2);
			
			//客户跟踪记录
			List<CustomerTrack> customerTracks = customerTrackManageImpl.find("from CustomerTrack where customer.dbid=? AND taskDealStatus>? order by createTime ", new Object[]{customer2.getDbid(),CustomerTrack.TASKFINISHTYPECOMM});
			request.setAttribute("customertracks", customerTracks);
			
			
			//最终结果信息
			CustomerLastBussi customerLastBussi = customer2.getCustomerLastBussi();
			request.setAttribute("customerLastBussi", customerLastBussi);
			
			//客户订单信息
			OrderContract orderContract = customer2.getOrderContract();
			request.setAttribute("orderContract", orderContract);
			
			//客户交车记录
			CustomerPidBookingRecord customerPidBookingRecord = customer2.getCustomerPidBookingRecord();
			request.setAttribute("customerPidBookingRecord", customerPidBookingRecord);
			//上传照片审批记录
			CustomerImageApproval customerImageApproval = customer2.getCustomerImageApproval();
			request.setAttribute("customerImageApproval", customerImageApproval);
			List<CustomerImage> customerImages = customerImageManageImpl.find("from CustomerImage where customerId=? and type=? ", new Object[]{customer2.getDbid(),CustomerImage.TYPEDRINGFRONT});
			if(null!=customerImages&&customerImages.size()>0){
				request.setAttribute("customerImage", customerImages.get(0));
			}
			
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			QywxAccount qywxAccount=null;
			//微信分享代码
			String path = request.getContextPath();
			String path2 = request.getRequestURI();
			System.out.println("===="+path2);
			int serverPort = request.getServerPort();
			String url="";
			if(serverPort==80){
				String queryString = request.getQueryString();
				if(null==queryString){
					url = request.getScheme()+"://"+request.getServerName()+path+"/qywxCustomerImage/uploadImageDriving";
				}else{
					url = request.getScheme()+"://"+request.getServerName()+path+"/qywxCustomerImage/uploadImageDriving?"+queryString.split("#")[0];
				}
			}else{
				String queryString = request.getQueryString();
				System.out.println(queryString);
				 url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/qywxCustomerImage/uploadImage?"+request.getQueryString().split("#")[0];
			}
			System.out.println("==========:"+url);
			if(null!=qywxAccounts&&qywxAccounts.size()>0){
				qywxAccount = qywxAccounts.get(0);
				AccessToken accessToken = QywxUtil.getTicketAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(),qywxAccount.getSecurity());
				if(null!=accessToken){
					WeixinCommon weixinCommon = WeixinSignUtil.getWeixinQywx(qywxAccount.getGroupId(),accessToken.getJsapiTicket(), url);
					request.setAttribute("weixin", weixinCommon);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}

		return "uploadImageDriving";
	}
	/**
	 * 功能描述：上传交车影像
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveImage() throws Exception {
		HttpServletRequest request = this.getRequest();
		String mediaId = request.getParameter("mediaId");
		Integer num = ParamUtil.getIntParam(request, "num", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			if(null==mediaId||mediaId.trim().length()<=0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			if(null==qywxAccounts||qywxAccounts.size()<=0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			if(customerId<0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			//获取用户信息
			Customer customer = customerMangeImpl.get(customerId);
			if(null==customer){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			//获取token
			QywxAccount qywxAccount= qywxAccounts.get(0);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(),qywxAccount.getSecurity());
			String imagePath = getImagePath(num, customer);
			String filePaht = QywxUtil.downloadMedia(accessToken.getAccessToken(), mediaId, imagePath);
			//获取图片保存路径
			if(null!=filePaht){
				String pathPro = PathUtil.getWebRootPath();
				if(null!=pathPro){
					filePaht = filePaht.replace(pathPro, "");
				}
			}
			CustomerImageApproval customerImageApproval = customer.getCustomerImageApproval();
			
			String imageTitle = getImageTitle(num, customer);
			CustomerImage customerImage=new CustomerImage();
			customerImage.setUrl(filePaht);
			customerImage.setDis(imageTitle);
			customerImage.setCreateDate(new Date());
			customerImage.setCustomer(customer);
			customerImage.setMediaId(mediaId);
			customerImage.setTitle(imageTitle);
			customerImage.setType(num);
			customerImage.setCustomerImageApproval(customerImageApproval);
			customerImageManageImpl.save(customerImage);
			
			
			customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSUPLOADED);
			if(null!=customerImageApproval){
				if(customerImageApproval.getHandCarStatus()==(int)CustomerImageApproval.UPLOADSTATSCOMM){
					//交车照片上传完成
					customerImageApproval.setHandCarStatus(CustomerImageApproval.UPLOADSTATSUPLOADED);
					//交车照片上传完成
					customerImageApproval.setStatus(CustomerImageApproval.STATUSUPLOADING);
					customerImageApprovalManageImpl.save(customerImageApproval);
					//发送通知信息
					MessageUtile messageUtile=new MessageUtile();
					messageUtile.sendMessage("交车影像上传通知", "销售顾问【"+customer.getBussiStaff()+"】上传了交车照片，请及时查看审核!", "/customerImage/viewImage?customerId="+customerId);
				}else{
					//交车照片上传完成
					customerImageApproval.setHandCarStatus(CustomerImageApproval.UPLOADSTATSUPLOADED);
					customerImageApprovalManageImpl.save(customerImageApproval);
					//发送通知信息
					MessageUtile messageUtile=new MessageUtile();
					messageUtile.sendMessage("交车影像更新通知", "销售顾问【"+customer.getBussiStaff()+"】上传了交车照片，请及时查看审核!", "/customerImage/viewImage?customerId="+customerId);
				}
			}
			//renderMsg("/qywxCustomerImage/uploadImageDriving?customerid="+customerId, "上传图片成功!");
			renderMsg("/qywxCustomerImage/uploadImageWaitingCustomer", "上传图片成功!");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "上传图片失败！");
			return ;
		}
		return;
	}
	/**
	 * 功能描述：上传行驶证照片
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void saveImageDriving() throws Exception {
		HttpServletRequest request = this.getRequest();
		String mediaId = request.getParameter("mediaId");
		Integer num = ParamUtil.getIntParam(request, "num", -1);
		Integer customerId = ParamUtil.getIntParam(request, "customerId", -1);
		try {
			if(null==mediaId||mediaId.trim().length()<=0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			List<QywxAccount> qywxAccounts = qywxAccountManageImpl.getAll();
			if(null==qywxAccounts||qywxAccounts.size()<=0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			if(customerId<0){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			//获取用户信息
			Customer customer = customerMangeImpl.get(customerId);
			if(null==customer){
				renderErrorMsg(new Throwable("上传图片失败！"), "");
				return ;
			}
			//获取token
			QywxAccount qywxAccount= qywxAccounts.get(0);
			AccessToken accessToken = QywxUtil.getAccessToken(accessTokenManageImpl, qywxAccount.getGroupId(),qywxAccount.getSecurity());
			String imagePath = getImagePath(num, customer);
			String filePaht = QywxUtil.downloadMedia(accessToken.getAccessToken(), mediaId, imagePath);
			//获取图片保存路径
			if(null!=filePaht){
				String pathPro = PathUtil.getWebRootPath();
				if(null!=pathPro){
					filePaht = filePaht.replace(pathPro, "");
				}
			}
			CustomerImageApproval customerImageApproval = customer.getCustomerImageApproval();
			
			String imageTitle = getImageTitle(num, customer);
			CustomerImage customerImage=new CustomerImage();
			customerImage.setUrl(filePaht);
			customerImage.setDis(imageTitle);
			customerImage.setCreateDate(new Date());
			customerImage.setCustomer(customer);
			customerImage.setMediaId(mediaId);
			customerImage.setTitle(imageTitle);
			customerImage.setType(num);
			customerImage.setCustomerImageApproval(customerImageApproval);
			customerImageManageImpl.save(customerImage);
			
			
			if(null!=customerImageApproval){
				if(customerImageApproval.getDrivingStatus()==(int)CustomerImageApproval.UPLOADSTATSCOMM){
					//交车照片上传完成
					customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSUPLOADED);
					customerImageApprovalManageImpl.save(customerImageApproval);
					//发送通知信息
					MessageUtile messageUtile=new MessageUtile();
					messageUtile.sendMessage("行驶证影像上传通知", "销售顾问【"+customer.getBussiStaff()+"】上传了交车照片，请及时查看审核!", "/customerImage/viewImage?customerId="+customerId);
				}else{
					//交车照片上传完成
					customerImageApproval.setDrivingStatus(CustomerImageApproval.UPLOADSTATSUPLOADED);
					customerImageApprovalManageImpl.save(customerImageApproval);
					//发送通知信息
					MessageUtile messageUtile=new MessageUtile();
					messageUtile.sendMessage("行驶证影像更新通知", "销售顾问【"+customer.getBussiStaff()+"】上传了交车照片，请及时查看审核!", "/customerImage/viewImage?customerId="+customerId);
				}
			}
			renderMsg("/qywxCustomerImage/uploadImageWaitingCustomer", "上传图片成功!");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "上传图片失败！");
			return ;
		}
		return;
	}
	
	/**
	 * 构造上传图保存路径
	 * @param num
	 * @param customer
	 */
	private String getImagePath(Integer num, Customer customer) {
		 String path="";
		try {
			String imageFilePath = FileNameUtil.getImageFilePath(customer);
			String imageTitle = getImageTitle(num, customer);
			path=imageFilePath+ imageTitle;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return path;
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
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			CustomerImage customerImage = customerImageManageImpl.get(dbid);
			if(null!=customerImage){
				String pathPro = PathUtil.getWebRootPath();
				String url = customerImage.getUrl();
				if(null!=url){
					String filePath=pathPro+url;
					File file=new File(filePath);
					if(file.exists()){
						file.delete();
					}
				}
			}
			customerImageManageImpl.deleteById(dbid);
			renderMsg("", "删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e, "");
		}
		return;
	}
	/**
	 * 构造上传图片名称
	 * @param num
	 * @param customer
	 */
	private String getImageTitle(Integer num, Customer customer) {
		String title="";
		try {
			String vinCode="";
			CustomerPidBookingRecord customerPidBookingRecord = customer.getCustomerPidBookingRecord();
			if(null!=customerPidBookingRecord){
				String vinCode2 = customerPidBookingRecord.getVinCode();
				if(null==vinCode2||vinCode2.trim().length()<=0){
					vinCode="11111111";
				}else{
					vinCode=vinCode2.substring(vinCode2.length()-8, vinCode2.length());
				}
			}else{
				vinCode="11111111";
			}
			title=customer.getUser().getUserId()+"_"+customer.getSn()+"_"+vinCode;
			if(num==2){
				title=title+"_xingshizheng";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return title;
	}
	

}
