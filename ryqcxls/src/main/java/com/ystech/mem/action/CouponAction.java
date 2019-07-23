package com.ystech.mem.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.Coupon;
import com.ystech.mem.model.CouponCode;
import com.ystech.mem.service.CouponCodeManageImpl;
import com.ystech.mem.service.CouponManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.xwqr.model.sys.Enterprise;
	
@Component("couponAction")
@Scope("prototype")
public class CouponAction extends BaseController{
	
	private Coupon coupon;
	private CouponManageImpl couponManageImpl;
	private CouponCodeManageImpl couponCodeManageImpl;
	private MemberManageImpl memberManageImpl;
	HttpServletRequest request = this.getRequest();
	public Coupon getCoupon() {
		return coupon;
	}
	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}
	@Resource
	public void setCouponManageImpl(CouponManageImpl couponManageImpl) {
		this.couponManageImpl = couponManageImpl;
	}
	
	@Resource
	public void setCouponCodeManageImpl(CouponCodeManageImpl couponCodeManageImpl) {
		this.couponCodeManageImpl = couponCodeManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	/**
	 * 功能描述： 
	 * 参数描述： 
	 * 逻辑描述：
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String name = request.getParameter("name");
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from cou_Coupon where enterpriseId="+enterprise.getDbid();
			if(null!=name&&name.trim().length()>0){
				sql=sql+" AND name like '%"+name+"%' ";
			}
			Page<Coupon> page = couponManageImpl.pagedQuerySql(pageNo, pageSize,Coupon.class, sql, new Object[]{});
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
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
			Coupon coupon2 = couponManageImpl.get(dbid);
			request.setAttribute("coupon", coupon2);
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
	public String editDirectionalCoupon() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		if(dbid>0){
			Coupon coupon2 = couponManageImpl.get(dbid);
			request.setAttribute("coupon", coupon2);
		}
		return "editDirectionalCoupon";
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
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 4);
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(null!=coupon.getDbid()&&coupon.getDbid()>0){
				Coupon coupon2 = couponManageImpl.get(coupon.getDbid());
				coupon2.setName(coupon.getName());
				coupon2.setType(coupon.getType());
				coupon2.setImage(coupon.getImage());
				coupon2.setConditions(coupon.getConditions());
				coupon2.setMoneyOrRabatt(coupon.getMoneyOrRabatt());
				coupon2.setAusgabeCount(coupon.getAusgabeCount());
				coupon2.setUserReceiveNum(coupon.getUserReceiveNum());
				coupon2.setEnabled(coupon.isEnabled());
				coupon2.setIsExchange(coupon.isIsExchange());
				coupon2.setExchangeNum(coupon.getExchangeNum());
				coupon2.setStartTime(coupon.getStartTime());
				coupon2.setStopTime(coupon.getStopTime());
				coupon2.setDescription(coupon.getDescription());
				coupon2.setReason(coupon.getReason());
				coupon2.setShowHiden(coupon.getShowHiden());
				coupon2.setModifyTime(new Date());
				coupon.setEnterpriseId(enterprise.getDbid());
				couponManageImpl.save(coupon2);
			}else{
				coupon.setEnterpriseId(enterprise.getDbid());
				coupon.setCreateTime(new Date());
				coupon.setModifyTime(new Date());
				coupon.setReceivedNum(0);
				couponManageImpl.save(coupon);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/coupon/queryList?parentMenu="+parentMenu, "保存数据成功！");
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
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 4);
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					couponManageImpl.deleteById(dbid);
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
		renderMsg("/coupon/queryList"+query+"&parentMenu="+parentMenu, "删除数据成功！");
		return;
	}
	
	/**
	 * 功能描述：优惠券列表
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryCouponCode() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		String code = request.getParameter("code");
		String mobilePhone = request.getParameter("mobilePhone");
		try{
			Page<CouponCode> page = couponCodeManageImpl.queryCouponCode(pageNo, pageSize,dbid,code,mobilePhone);
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(e, "");
		}
		return "couponCode";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void deleteCouponeCode() throws Exception {
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		Integer couponDbid=0;
		Coupon coupon=null;
		try{
			if(null!=dbids&&dbids.length>0){
				try {
					int i=0;
					for (Integer dbid : dbids) {
						CouponCode couponCode = couponCodeManageImpl.get(dbid);
						couponDbid = couponCode.getCoupon().getDbid();
						coupon = couponCode.getCoupon();
						couponCodeManageImpl.deleteById(dbid);
						i++;
					}
					if(null!=coupon){
						Integer receivedNum = coupon.getReceivedNum();
						receivedNum=receivedNum-i;
						coupon.setReceivedNum(receivedNum);
						couponManageImpl.save(coupon);
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
			renderMsg("/coupon/queryList"+query+"&dbid="+couponDbid, "删除数据成功！");
		}catch (Exception e) {
		}
		return ;
	}
}
