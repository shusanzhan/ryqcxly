/**
 * 
 */
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
import com.ystech.mem.model.Member;
import com.ystech.mem.model.MemberTrack;
import com.ystech.mem.service.MemberManageImpl;
import com.ystech.mem.service.MemberTrackManageImpl;
import com.ystech.xwqr.model.sys.User;

/**
 * @author shusanzhan
 * @date 2014-2-24
 */
@Component("memberTrackAction")
@Scope("prototype")
public class MemberTrackAction extends BaseController{
	private MemberTrackManageImpl memberTrackManageImpl;
	private MemberTrack memberTrack;
	private Member member;
	private MemberManageImpl memberManageImpl;
	@Resource
	public void setMemberTrackManageImpl(MemberTrackManageImpl memberTrackManageImpl) {
		this.memberTrackManageImpl = memberTrackManageImpl;
	}
	public MemberTrack getMemberTrack() {
		return memberTrack;
	}

	public void setMemberTrack(MemberTrack memberTrack) {
		this.memberTrack = memberTrack;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Resource
	public void setMemberManageImpl(MemberManageImpl memberManageImpl) {
		this.memberManageImpl = memberManageImpl;
	}

	/**
	 * 功能描述：
	 * 参数描述： 
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "static-access" })
	public String queryList() throws Exception {
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		SecurityUserHolder holder=new SecurityUserHolder();
		User currentUser = holder.getCurrentUser();
		try{
			Integer customerPhaseId = ParamUtil.getIntParam(request, "customerPhaseId", -1);
			Page<MemberTrack>  page= memberTrackManageImpl.pageQuery(pageNo, pageSize, "from MemberTrack where  userId=? order by createTime DESC", new Object[]{currentUser.getDbid()});
			request.setAttribute("page", page);
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
		HttpServletRequest request = getRequest();
		try{
		}catch (Exception e) {
			e.printStackTrace();
			log.error(e);
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
			MemberTrack memberTrack2 = memberTrackManageImpl.get(dbid);
			request.setAttribute("memberTrack", memberTrack2);
			
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
		Member member2=null;
		Integer dbid=memberTrack.getDbid();
		try{
				if(dbid==null||dbid<0){
					memberTrack.setCreateTime(new Date());
					memberTrack.setModifyTime(new Date());
				}else{
					memberTrack.setModifyTime(new Date());
				}
				User user=SecurityUserHolder.getCurrentUser();
				Integer memberId = ParamUtil.getIntParam(request, "memberId", -1);
				if(memberId>0){
					member2 = memberManageImpl.get(memberId);
					//memberTrack.setMember(member2);
				}
				if(member2==null){
					renderErrorMsg(new Throwable("保存数据失败!"), "");
					return ;
				}
				memberTrack.setUserId(user.getDbid());
				//保存跟踪记录信息
				memberTrackManageImpl.save(memberTrack);
				
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		if(dbid==null||dbid<0){
			renderMsg("/member/queryList", "保存数据成功！");
		}else if(dbid>0){
			renderMsg("/memberTrack/queryList", "保存数据成功！");
		}
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
					memberTrackManageImpl.deleteById(dbid);
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
		renderMsg("/memberTrack/queryList"+query, "删除数据成功！");
		return;
	}
}
