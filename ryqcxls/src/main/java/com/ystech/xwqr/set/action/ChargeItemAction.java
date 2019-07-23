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
import com.ystech.xwqr.set.model.ChargeItem;
import com.ystech.xwqr.set.service.ChargeItemManageImpl;

@Component("chargeItemAction")
@Scope("prototype")
public class ChargeItemAction extends BaseController{
	private ChargeItem chargeItem;
	private ChargeItemManageImpl chargeItemManageImpl;
	public void setChargeItem(ChargeItem chargeItem) {
		this.chargeItem = chargeItem;
	}
	
	public ChargeItem getChargeItem() {
		return chargeItem;
	}

	@Resource
	public void setChargeItemManageImpl(ChargeItemManageImpl chargeItemManageImpl) {
		this.chargeItemManageImpl = chargeItemManageImpl;
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
			 Page<ChargeItem> page= chargeItemManageImpl.pagedQuerySql(pageNo, pageSize, ChargeItem.class, "select * from set_ChargeItem order by orderNum ", new Object[]{});
			 request.setAttribute("page", page);
		}catch (Exception e) {
			// TODO: handle exception
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
			ChargeItem chargeItem2 = chargeItemManageImpl.get(dbid);
			request.setAttribute("chargeItem", chargeItem2);
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
		//slide.setBussiId(currentBussi);
		try{
			Integer dbid = chargeItem.getDbid();
			if(dbid==null||dbid<=0){
				chargeItem.setCreateDate(new Date());
				chargeItem.setModifyDate(new Date());
				chargeItemManageImpl.save(chargeItem);
			}else{
				chargeItemManageImpl.save(chargeItem);
			}
		}catch (Exception e) {
			log.error(e);
			e.printStackTrace();
			renderErrorMsg(e, "");
			return ;
		}
		renderMsg("/chargeItem/queryList", "保存数据成功！");
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
					chargeItemManageImpl.deleteById(dbid);
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
		renderMsg("/chargeItem/queryList"+query, "删除数据成功！");
		return;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void autoChargeItem() throws Exception {
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
			List<ChargeItem> chargeItems=new ArrayList<ChargeItem>();
			String sql="select * from set_ChargeItem where  netTowType="+customerType+" and (name like ?  or jym like ?) ";
			chargeItems= chargeItemManageImpl.executeSql(sql, new Object[]{"%"+pingyin+"%","%"+pingyin+"%"});
			if(null==chargeItems||chargeItems.size()<=0){
				chargeItems = chargeItemManageImpl.executeSql("select * from set_ChargeItem where  netTowType="+customerType, null);
			}
			JSONArray  array=new JSONArray();
			if(null!=chargeItems&&chargeItems.size()>0){
				for (ChargeItem chargeItem: chargeItems) {
					JSONObject object=new JSONObject();
					object.put("dbid", chargeItem.getDbid());
					object.put("name", chargeItem.getName());
					object.put("defaultPrice", 0);
					array.put(object);
				}
				renderJson(array.toString());
			}else{
				renderJson("1");
			}
			
			return ;
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
