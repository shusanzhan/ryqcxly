package com.ystech.qywx.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.qywx.service.AccessTokenManageImpl;
import com.ystech.qywx.service.AddressUtil;
import com.ystech.qywx.service.DepartmentWexinUtil;
import com.ystech.qywx.service.QywxAccountManageImpl;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.DepartmentManageImpl;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("addressAction")
@Scope("prototype")
public class AddressAction extends BaseController{
	private DepartmentManageImpl departmentManageImpl;
	private QywxAccountManageImpl qywxAccountManageImpl;
	private AccessTokenManageImpl accessTokenManageImpl;
	private AddressUtil addressUtil;
	private DepartmentWexinUtil departmentWexinUtil;
	private UserManageImpl userManageImpl;
	@Resource
	public void setDepartmentManageImpl(DepartmentManageImpl departmentManageImpl) {
		this.departmentManageImpl = departmentManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	@Resource
	public void setQywxAccountManageImpl(QywxAccountManageImpl qywxAccountManageImpl) {
		this.qywxAccountManageImpl = qywxAccountManageImpl;
	}
	@Resource
	public void setAccessTokenManageImpl(AccessTokenManageImpl accessTokenManageImpl) {
		this.accessTokenManageImpl = accessTokenManageImpl;
	}
	@Resource
	public void setAddressUtil(AddressUtil addressUtil) {
		this.addressUtil = addressUtil;
	}
	@Resource
	public void setDepartmentWexinUtil(DepartmentWexinUtil departmentWexinUtil) {
		this.departmentWexinUtil = departmentWexinUtil;
	}
	/**
	 * 功能描述：部门树页面
	 * @return
	 * @throws Exception
	 */
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer departmentId = ParamUtil.getIntParam(request, "departmentId", -1);
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		Integer sysWeixinStatus = ParamUtil.getIntParam(request, "sysWeixinStatus", -1);
		Integer attentionStatus = ParamUtil.getIntParam(request, "attentionStatus", -1);
		try {
			Page<User> page=null;
			String hql="select * from sys_user where 1=1 ";
			List params=new ArrayList();
			hql=hql+" and userState=? ";
			params.add(1);
			if(null!=userId&&userId.trim().length()>0){
				hql=hql+" and userId like ? ";
				params.add("%"+userId+"%");
			}
			if(null!=userName&&userName.trim().length()>0){
				hql=hql+" and realName like ?";
				params.add("%"+userName+"%");
			}
			if(sysWeixinStatus>0){
				hql=hql+" and sysWeixinStatus=? ";
				params.add(sysWeixinStatus);
			}
			if(attentionStatus>0){
				hql=hql+" and attentionStatus=? ";
				params.add(attentionStatus);
			}
			
			if(departmentId>0){
				String departmentIds = departmentManageImpl.getDepartmentIdsByDbid(departmentId);
				hql=hql+" and departmentId in ("+departmentIds+")";
				request.setAttribute("departmentId", departmentId);
			}
			page = userManageImpl.pagedQuerySql(pageNo, pageSize,User.class,hql,params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
		}
		return "list";
	}
	/**
	 * 功能描述：同步单个用户
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synSingleUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			User user = userManageImpl.get(dbid);
			boolean status=false;
			if(user.getSysWeixinStatus()==(int)User.SYNCOMM){
				status = addressUtil.createUser(user);
			}
			if(user.getSysWeixinStatus()==(int)User.SYNYYES){
				status = addressUtil.updateUser(user);
			}
			if(status==true){
				String queryUrl = ParamUtil.getQueryUrl(request);
				renderMsg("/address/queryList"+queryUrl,"同步用户数据成功！");
				return ;
			}else{
				renderErrorMsg(new Throwable("同步用户数据成功！"),"");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(e,"");
			return ;
		}
	}
	/**
	 * 功能描述：查看用户关注状态
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synSingleAtt() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			User user = userManageImpl.get(dbid);
			user = addressUtil.getUser(user);
			String queryUrl = ParamUtil.getQueryUrl(request);
			renderMsg("/address/queryList"+queryUrl,"更新状态成功！");
			return ;
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("更新状态失败！"),"");
		}
		renderErrorMsg(new Throwable("更新状态失败！"),"");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synUser() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			boolean status = addressUtil.synUser();
			if(status==false){
				renderErrorMsg(new Throwable("同步用户失败，请确认"),"");
				return ;
			}
			if(status==true){
				renderMsg("", "同步用户数据成功");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("同步用户失败，请确认"),"");
			return ;
		}
		return;
	}
	/**
	 * 功能描述：同步部门数据数据
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synDataDepartment() throws Exception {
		HttpServletRequest request = this.getRequest();
		try {
			boolean status = departmentWexinUtil.synDepartment();
			if(status==false){
				renderErrorMsg(new Throwable("同步部门失败，请确认"),"");
				return ;
			}
			if(status==true){
				renderMsg("", "同步部门数据成功");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
			renderErrorMsg(new Throwable("同步部门失败，请确认"),"");
			return ;
		}
		renderErrorMsg(new Throwable("同步部门失败，请确认"),"");
		return ;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void synDataUserAttention() throws Exception {
		try {
			boolean status = addressUtil.synDataUserAttention();
			if(status==false){
				renderErrorMsg(new Throwable("同同步用户关注状态失败，请确认"),"");
				return ;
			}
			if(status==true){
				renderMsg("", "同步用户关注状态成功");
				return ;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e);
		}
		return;
	}
}