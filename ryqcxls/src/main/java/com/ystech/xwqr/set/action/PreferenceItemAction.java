package com.ystech.xwqr.set.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.xwqr.set.model.PreferenceItem;
import com.ystech.xwqr.set.service.PreferenceItemManageImpl;

@Component("preferenceItemAction")
@Scope("prototype")
public class PreferenceItemAction extends BaseController{
	private PreferenceItem preferenceItem;
	private PreferenceItemManageImpl preferenceItemManageImpl;
	public PreferenceItem getPreferenceItem() {
		return preferenceItem;
	}

	public void setPreferenceItem(PreferenceItem preferenceItem) {
		this.preferenceItem = preferenceItem;
	}
	@Resource
	public void setPreferenceItemManageImpl(
			PreferenceItemManageImpl preferenceItemManageImpl) {
		this.preferenceItemManageImpl = preferenceItemManageImpl;
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
		String username = request.getParameter("title");
		try{
			 Page<PreferenceItem> page= preferenceItemManageImpl.pagedQuerySql(pageNo, pageSize,PreferenceItem.class, "select * from set_preferenceitem order by OrderNum", new Object[]{});
			 request.setAttribute("page", page);
		}catch (Exception e) {
		}
		return "list";
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
			PreferenceItem preferenceItem2 = preferenceItemManageImpl.get(dbid);
			request.setAttribute("preferenceItem", preferenceItem2);
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
		try{
			Integer dbid = preferenceItem.getDbid();
			if(dbid==null||dbid<=0){
				preferenceItem.setCreateDate(new Date());
				preferenceItem.setModifyDate(new Date());
				preferenceItemManageImpl.save(preferenceItem);
			}else{
				preferenceItemManageImpl.save(preferenceItem);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/preferenceItem/queryList", "保存数据成功！");
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
					preferenceItemManageImpl.deleteById(dbid);
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
		renderMsg("/preferenceItem/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoPreferenceItem() throws Exception {
		HttpServletRequest request = this.getRequest();
		try{
			String pingyin = request.getParameter("q");
			Integer customerType = ParamUtil.getIntParam(request, "customerType", -1);
			if(null==pingyin||pingyin.trim().length()<0){
				pingyin="";
			}else{
				pingyin=new String(pingyin.getBytes("iso8859-1"),"UTF-8");
			}
			pingyin = pingyin.toUpperCase();
			List<PreferenceItem> preferenceItems=new ArrayList<PreferenceItem>();
			String sql="select * from set_preferenceitem where  netTowType="+customerType+" and (name like ?  or jym like ?) ";
			preferenceItems= preferenceItemManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			if(null==preferenceItems||preferenceItems.size()<=0){
				preferenceItems = preferenceItemManageImpl.executeSql("select * from set_preferenceitem where  netTowType="+customerType, null);
			}
			JSONArray  array=new JSONArray();
			if(null!=preferenceItems&&preferenceItems.size()>0){
				for (PreferenceItem preferenceItem: preferenceItems) {
					JSONObject object=new JSONObject();
					object.put("dbid", preferenceItem.getDbid());
					object.put("name", preferenceItem.getName());
					object.put("defaultPrice", preferenceItem.getDefaultPrice());
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
