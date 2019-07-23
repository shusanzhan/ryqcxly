package com.ystech.agent.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.agent.model.WechatRecvier;
import com.ystech.agent.service.WechatRecvierManageImpl;
import com.ystech.core.security.SecurityUserHolder;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.model.sys.User;
import com.ystech.xwqr.service.sys.UserManageImpl;

@Component("wechatRecvierAction")
@Scope("prototype")
public class WechatRecvierAction extends BaseController{
	private WechatRecvier wechatRecvier;
	private WechatRecvierManageImpl wechatRecvierManageImpl;
	private UserManageImpl userManageImpl;
	public WechatRecvier getWechatRecvier() {
		return wechatRecvier;
	}
	public void setWechatRecvier(WechatRecvier wechatRecvier) {
		this.wechatRecvier = wechatRecvier;
	}
	@Resource
	public void setWechatRecvierManageImpl(
			WechatRecvierManageImpl wechatRecvierManageImpl) {
		this.wechatRecvierManageImpl = wechatRecvierManageImpl;
	}
	@Resource
	public void setUserManageImpl(UserManageImpl userManageImpl) {
		this.userManageImpl = userManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		try {
			String username = request.getParameter("title");
			User currentUser = SecurityUserHolder.getCurrentUser();
			//Enterprise enterprise = currentUser.getEnterprise();
			//String sql="select * from agent_WechatRecvier ";
			//Page<WechatRecvier> page=wechatRecvierManageImpl.pagedQuerySql(pageNo, pageSize, WechatRecvier.class, sql,null);
			//request.setAttribute("page", page);
		} catch (Exception e) {
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
		try {
			
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
	public void save() throws Exception {
		HttpServletRequest request = getRequest();
		Integer userDbid = ParamUtil.getIntParam(request, "userDbid", -1);
		try{
			/*Enterprise enterprise = SecurityUserHolder.getEnterprise();
			List<WechatRecvier> wechatRecviers = wechatRecvierManageImpl.find("from WechatRecvier where  user.dbid=?", new Object[]{userDbid});
			if(null!=wechatRecviers&&wechatRecviers.size()>0){
				renderErrorMsg(new Throwable("系统中已添加该用户"), "");
				return ;
			}
			User user = userManageImpl.get(userDbid);
			WeixinGzuserinfo weixinGzuserinfo = user.getWeixinGzuserinfo();
			if(null==weixinGzuserinfo){
				renderErrorMsg(new Throwable("用户微信未验证"), "");
				return ;
			}
			wechatRecvier.setOpenId(weixinGzuserinfo.getOpenid());
			wechatRecvier.setCompany(user.getCompany());
			wechatRecvier.setUser(user);*/
			wechatRecvierManageImpl.save(wechatRecvier);
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/agentRecvier/queryList", "保存数据成功！");
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
		if(null!=dbids&&dbids.length>0){
			try {
				for (Integer dbid : dbids) {
					wechatRecvierManageImpl.deleteById(dbid);
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
		renderMsg("/agentRecvier/queryList"+query, "删除数据成功！");
		return;
	}

}
