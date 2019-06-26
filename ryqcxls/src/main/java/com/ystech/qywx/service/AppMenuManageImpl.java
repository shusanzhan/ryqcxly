package com.ystech.qywx.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.qywx.model.AppMenu;

@Component("appMenuManageImpl")
public class AppMenuManageImpl extends HibernateEntityDao<AppMenu>{

	public String getProductCateGorySelect(Integer appId,AppMenu curent) {
		List<AppMenu> productCategories=find("from AppMenu where app.dbid=? and parent.dbid IS NULL", new Object[]{appId});
		String select="";
		if (null!=productCategories&&productCategories.size()>0) {
			for (AppMenu productCategory : productCategories) {
				String lest = getListSelect(productCategory, "&nbsp;&nbsp;&nbsp;&nbsp;",curent);
				select=select+lest;
			}
		}
		return select;
	}
	/**
	 * 功能描述：生成下来选择数据分类，以树状展示
	 * @param productCategory
	 * @param indent
	 * @return
	 */
	public String getListSelect(AppMenu productCategory,String indent,AppMenu curent){
		StringBuilder sb = new StringBuilder();
		if (null!=productCategory) {
			sb.append("<option value='"+productCategory.getDbid()+"'");
			if((null!=curent&&curent.getDbid()>0)&&productCategory.getDbid()==curent.getDbid()){
				sb.append("selected='selected'>"+productCategory.getName()+"</option>");
			}else{
				sb.append(">"+productCategory.getName()+"</option>");
			}
			List<AppMenu> children = find("from AppMenu where  parent.dbid=? order by orders",productCategory.getDbid());
			if (null!=children&&children.size()>0) {
				for (AppMenu productCateGorup2 : children) {
					sb.append("<option value='"+productCateGorup2.getDbid()+"'");
					if((null!=curent&&curent.getDbid()>0)&&productCateGorup2.getDbid()==curent.getDbid()){
						sb.append("selected='selected'>"+indent+""+productCateGorup2.getName()+"</option>");
					}else{
						sb.append(">"+indent+""+productCateGorup2.getName()+"</option>");
					}
					List<AppMenu> findBy = find("from AppMenu where  parent.dbid=? order by orders",productCateGorup2.getDbid());
					if (null!=findBy&&findBy.size()>0.) {
						sb.append(getListSelect(productCateGorup2, indent+"&nbsp;&nbsp;&nbsp;&nbsp;",curent));
					}
				}
			}
		}
		return sb.toString();
	}
	/**
	 * 功能描述：生成下来选择数据分类，以树状展示
	 * @param productCategory
	 * @param indent
	 * @return
	 */
	public String getTableTr(AppMenu productCategory,String indent){
		StringBuilder sb = new StringBuilder();
		if (null!=productCategory) {
			List<AppMenu> children = find("from AppMenu where  parent.dbid=? order by orders",productCategory.getDbid());
			if (null!=children&&children.size()>0) {
				for (AppMenu productCateGorup2 : children) {
					sb.append("<tr>");
					sb.append("<td  style=\"text-align: left;\">"+indent+""+productCateGorup2.getName() +"</td>");
					if(null!=productCateGorup2.getType()){
						if(productCateGorup2.getType().equals("click")){
							sb.append("<td>消息类触发</td>");
						}
						if(productCateGorup2.getType().equals("view")){
							sb.append("<td>网页链接类</td>");
						}
					}else{
						sb.append("<td>无</td>");
					}
					
					if(null!=productCateGorup2.getUrl()&&productCateGorup2.getUrl().length()>50){
						sb.append("<td>"+productCateGorup2.getUrl().substring(0,50)+"...</td>");
					}else{
						sb.append("<td>"+productCateGorup2.getUrl()+"</td>");
					}
					sb.append("<td>"+productCateGorup2.getOrders()+"</td>");
					sb.append("<td style=\"text-align: center;\">");
					sb.append("<a href='javascript:void(-1)' onclick=\"window.location.href='/appMenu/edit?dbid="+productCateGorup2.getDbid()+"&appDbid="+productCategory.getApp().getDbid()+"'\">编辑</a> |"); 
					sb.append("<a href='javascript:void(-1)' onclick=\"$.utile.deleteById('/appMenu/delete?dbid="+productCateGorup2.getDbid()+"','searchPageForm')\" title='删除'>删除</a></td>");
					sb.append("</tr>");
					List<AppMenu> findBy = find("from AppMenu where  parent.dbid=? order by orders",productCateGorup2.getDbid());
					if (null!=findBy&&findBy.size()>0) {
						sb.append(getTableTr(productCateGorup2, indent+"&nbsp;&nbsp;&nbsp;&nbsp;"));
					}
				}
			}
		}
		return sb.toString();
	}
}
