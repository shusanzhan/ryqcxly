package com.ystech.mem.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.excel.CouponMemberToExcel;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.mem.model.CouponMember;
import com.ystech.mem.model.CouponMemberTemplate;
import com.ystech.mem.model.Member;
import com.ystech.mem.service.CouponMemberManageImpl;
import com.ystech.mem.service.CouponMemberTemplateManageImpl;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
	
@Component("couponMemberAction")
@Scope("prototype")
public class CouponMemberAction extends BaseController{
	
	private CouponMember couponMember;
	private CouponMemberManageImpl couponMemberManageImpl;
	private MemberManageImpl memberManageImpl;
	private CouponMemberTemplateManageImpl couponMemberTemplateManageImpl;
	private CouponMemberToExcel couponMemberToExcel;
	private DepartmentManageImpl departmentManageImpl;
	HttpServletRequest request = this.getRequest();
	
	public CouponMember getCouponMember() {
		return couponMember;
	}
	public void setCouponMember(CouponMember couponMember) {
		this.couponMember = couponMember;
	}
	@Resource
	public void setCouponMemberManageImpl(
			CouponMemberManageImpl couponMemberManageImpl) {
		this.couponMemberManageImpl = couponMemberManageImpl;
	}
	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}
	@Resource
	public void setCouponMemberTemplateManageImpl(
			CouponMemberTemplateManageImpl couponMemberTemplateManageImpl) {
		this.couponMemberTemplateManageImpl = couponMemberTemplateManageImpl;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Resource
	public void setCouponMemberToExcel(CouponMemberToExcel couponMemberToExcel) {
		this.couponMemberToExcel = couponMemberToExcel;
	}
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
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
		Integer type = ParamUtil.getIntParam(request,"type", -1);
		Integer isUse = ParamUtil.getIntParam(request,"isUse", -1);
		String mobilePhone = request.getParameter("mobilePhone");
		String memberName = request.getParameter("memberName");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		try {
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from cou_CouponMember as cm,mem_Member as me where cm.memberId=me.dbid and cm.enterpriseId="+enterprise.getDbid();
			List param=new ArrayList();
			if(null!=name&&name.trim().length()>0){
				sql=sql+" and cm.name like ? ";
				param.add("%"+name+"%");
			}
			if(null!=mobilePhone&&mobilePhone.trim().length()>0){
				sql=sql+" and me.mobilePhone like ? ";
				param.add("%"+mobilePhone+"%");
			}
			if(null!=memberName&&memberName.trim().length()>0){
				sql=sql+" and me.name like ? ";
				param.add("%"+memberName+"%");
			}
			if(null!=type&&type>0){
				sql=sql+" and cm.type = ? ";
				param.add(type);
			}
			if(null!=isUse&&isUse>-1){
				sql=sql+" and cm.isUsed = ? ";
				param.add(isUse);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(usedDate,'%Y-%m-%d')>='"+startTime+"' ";
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" AND DATE_FORMAT(usedDate,'%Y-%m-%d')<='"+endTime+"' ";
			}
			Page<CouponMember> page = couponMemberManageImpl.pagedQuerySql( pageNo, pageSize,CouponMember.class,sql, param.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "list";
	}
	
	/**
	 * 功能描述：会员优惠券信息
	 * 参数描述：会员ID
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String memberCoupon() throws Exception {
		Integer memberId = ParamUtil.getIntParam(request, "memberId", -1);
		try{
			if(memberId>0){
				List<CouponMember> couponMembers = couponMemberManageImpl.findBy("member.dbid", memberId);
				request.setAttribute("couponMembers", couponMembers);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "memberCoupon";
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
		try {
			List<CouponMemberTemplate> couponMemberTemplates = couponMemberTemplateManageImpl.findBy("enabled", true);
			request.setAttribute("couponMemberTemplates", couponMemberTemplates);
			
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			
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
		if(dbid>0){
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<CouponMemberTemplate> couponMemberTemplates = couponMemberTemplateManageImpl.findBy("enabled", true);
			request.setAttribute("couponMemberTemplates", couponMemberTemplates);
			CouponMember couponMember2 = couponMemberManageImpl.get(dbid);
			request.setAttribute("couponMember", couponMember2);
			
			Department sendDep = couponMember2.getSendDep();
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
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", 4);
		Integer couponMemberTemplateId = ParamUtil.getIntParam(request, "couponMemberTemplateId", -1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		User currentUser = SecurityUserHolder.getCurrentUser();
		try{
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			if(couponMemberTemplateId<0){
				renderErrorMsg(new Throwable("请选择优惠券类型"), "");
				return ;
			}
			if(departmentId<0){
				renderErrorMsg(new Throwable("请选部门信息"), "");
				return ;
			}
			CouponMemberTemplate couponMemberTemplate = couponMemberTemplateManageImpl.get(couponMemberTemplateId);
			if(null==couponMemberTemplate){
				renderErrorMsg(new Throwable("请选择优惠券类型"), "");
				return ;
			}
			Department department = departmentManageImpl.get(departmentId);
			couponMember.setCouponMemberTemplate(couponMemberTemplate);
			couponMember.setImage(couponMemberTemplate.getImage());
			couponMember.setType(couponMemberTemplate.getType());
			couponMember.setDescription(couponMemberTemplate.getDescription());
			couponMember.setEnabled(true);
			couponMember.setShowHiden(couponMemberTemplate.getShowHiden());
			if(null!=couponMember.getDbid()&&couponMember.getDbid()>0){
				CouponMember couponMember2 = couponMemberManageImpl.get(couponMember.getDbid());
				couponMember2.setName(couponMember.getName());
				couponMember2.setType(couponMember.getType());
				couponMember2.setImage(couponMember.getImage());
				couponMember2.setMoneyOrRabatt(couponMember.getMoneyOrRabatt());
				couponMember2.setEnabled(couponMember.isEnabled());
				couponMember2.setStartTime(couponMember.getStartTime());
				couponMember2.setStopTime(couponMember.getStopTime());
				couponMember2.setDescription(couponMember.getDescription());
				couponMember2.setReason(couponMember.getReason());
				couponMember2.setModifyTime(new Date());
				couponMember2.setShowHiden(couponMember.getShowHiden());
				couponMember2.setEnterpriseId(enterprise.getDbid());
				couponMember2.setSendDep(department);
				couponMember2.setSendDepName(department.getName());
				couponMember2.setCouponMemberTemplate(couponMemberTemplate);
				couponMember2.setBussiType(couponMember.getBussiType());
				couponMemberManageImpl.save(couponMember2);
			}else{
				couponMember.setSendDep(department);
				couponMember.setSendDepName(department.getName());
				couponMember.setEnterpriseId(enterprise.getDbid());
				couponMember.setCreateTime(new Date());
				couponMember.setModifyTime(new Date());
				couponMember.setCreatorId(currentUser.getDbid());
				couponMember.setIsUsed(false);
				couponMember.setBigType(CouponMember.DIRECTCOUPON);
				couponMember.setCreatorName(currentUser.getRealName());
				List<Member> members=new ArrayList<Member>();
				Integer[] memberIds = ParamUtil.getIntArraryByDbids(request, "memberIds");
				//当优惠券为定向发送时
				for (Integer dbid : memberIds) {
					Member member = memberManageImpl.get(dbid);
					members.add(member);
				}
				if(null!=members&&members.size()>0){
					Member member = members.get(0);
					couponMember.setMember(member);
				}
				String identityCode = DateUtil.generatedName(new Date());
				couponMember.setCode(identityCode);
				couponMemberManageImpl.save(couponMember);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/couponMember/queryList?parentMenu="+parentMenu, "保存数据成功！");
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
					couponMemberManageImpl.deleteById(dbid);
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
		renderMsg("/couponMember/queryList"+query+"&parentMenu="+parentMenu, "删除数据成功！");
		return;
	}
	
	/**
	 * 功能描述：使用优惠券
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public  void useCouponeCode() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbids", -1);
		Integer parentMenu = ParamUtil.getIntParam(request, "parentMenu", -1);
		User user = SecurityUserHolder.getCurrentUser();
		try{
			if(dbid>0){
				CouponMember couponMember2 = couponMemberManageImpl.get(dbid);
				couponMember2.setUsedPersonId(user.getDbid());
				couponMember2.setUsedPersonName(user.getRealName());
				couponMember2.setIsUsed(true);
				couponMember2.setUsedDate(new Date());
				couponMember2.setModifyTime(new Date());
				couponMemberManageImpl.save(couponMember2);
			}else{
				renderErrorMsg(new Throwable("使用sn码错误,未选择数据！"), "");
				return ;
			}
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("使用sn码错误,未选择数据！"), "");
			return ;
		}
		String query = ParamUtil.getQueryUrl(request);
		renderMsg("/couponMember/queryList"+query+"&parentMenu="+parentMenu, "使用优惠券成功！");
		return;
	}
	/**
	 * 功能描述：打印优惠码
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String printCode() throws Exception {
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try{
			CouponMember couponMember2 = couponMemberManageImpl.get(dbid);
			request.setAttribute("couponMember", couponMember2);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "printCode";
	}
	/**
	 * 功能描述：导出数据跳转页面
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String export() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			List<CouponMemberTemplate> couponMemberTemplates = couponMemberTemplateManageImpl.findBy("enabled", true);
			request.setAttribute("couponMemberTemplates", couponMemberTemplates);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return "export";
	}
	/**
	 * 功能描述：导出数据
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void exportExcel() throws Exception {
		HttpServletRequest request = this.getRequest();
		HttpServletResponse response = this.getResponse();
		Integer couponMemberTemplateId = ParamUtil.getIntParam(request, "couponMemberTemplateId", -1);
		Integer isUse = ParamUtil.getIntParam(request, "isUse", -1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String useStartTime = request.getParameter("useStartTime");
		String useEndTime = request.getParameter("useEndTime");
		
		try {
			String fileName=""+DateUtil.format(new Date());
			Enterprise enterprise = SecurityUserHolder.getEnterprise();
			String sql="select * from cou_CouponMember as cm,mem_Member as me where cm.memberId=me.dbid and cm.enterpriseId="+enterprise.getDbid();
			List param=new ArrayList();
			if(null!=type&&type>0){
				sql=sql+" and type = ? ";
				param.add(type);
			}
			if(null!=couponMemberTemplateId&&couponMemberTemplateId>0){
				sql=sql+" and couponMemberTemplateid = ? ";
				param.add(couponMemberTemplateId);
			}
			if(null!=startTime&&startTime.trim().length()>0){
				sql=sql+" and createTime>=? ";
				param.add(startTime);
			}
			if(null!=endTime&&endTime.trim().length()>0){
				sql=sql+" and createTime<? ";
				param.add(endTime);
			}
			if(null!=useStartTime&&useStartTime.trim().length()>0){
				sql=sql+" and usedDate>=? ";
				param.add(useStartTime);
			}
			if(null!=useEndTime&&useEndTime.trim().length()>0){
				sql=sql+" and usedDate<? ";
				param.add(useEndTime);
			}
			if(null!=isUse&&isUse>-1){
				sql=sql+" and isUsed = ? ";
				param.add(isUse);
			}
			List<CouponMember> couponMembers = couponMemberManageImpl.executeSql(sql, param.toArray());
			String filePath = couponMemberToExcel.writeExcel(fileName, couponMembers);
			downFile(request, response, filePath);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
}
