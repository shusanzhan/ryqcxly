/**
 * 
 */
package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.ProductCategory;

/**
 * @author shusanzhan
 * @date 2014-2-20
 */
@Component("productCategoryManageImpl")
public class ProductCategoryManageImpl extends HibernateEntityDao<ProductCategory>{
	/**
	 * 功能描述：生成下来选择数据分类，以树状展示
	 * @param productCategory
	 * @param indent
	 * @return
	 */
	public String getListSelect(ProductCategory productCategory,String indent,ProductCategory curent,Integer enterpriseId){
		StringBuilder sb = new StringBuilder();
		if (null!=productCategory) {
			sb.append("<option value='"+productCategory.getDbid()+"'");
			if((null!=curent&&curent.getDbid()>0)&&productCategory.getDbid()==curent.getDbid()){
				sb.append("selected='selected'>"+productCategory.getName()+"</option>");
			}else{
				sb.append(">"+productCategory.getName()+"</option>");
			}
			List<ProductCategory> children = find("from ProductCategory where enterpriseId=? AND  parent.dbid=? order by orderNum",new Object[]{enterpriseId,productCategory.getDbid()});
			if (null!=children&&children.size()>0) {
				for (ProductCategory productCateGorup2 : children) {
					sb.append("<option value='"+productCateGorup2.getDbid()+"'");
					if((null!=curent&&curent.getDbid()>0)&&productCateGorup2.getDbid()==curent.getDbid()){
						sb.append("selected='selected'>"+indent+""+productCateGorup2.getName()+"</option>");
					}else{
						sb.append(">"+indent+""+productCateGorup2.getName()+"</option>");
					}
					List<ProductCategory> findBy = find("from ProductCategory where enterpriseId=? AND  parent.dbid=? order by orderNum",new Object[]{enterpriseId,productCategory.getDbid()});
					if (null!=findBy&&findBy.size()>0.) {
						sb.append(getListSelect(productCateGorup2, indent+"&nbsp;&nbsp;&nbsp;&nbsp;",curent,enterpriseId));
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
	public String getTableTr(ProductCategory productCategory,String indent){
		StringBuilder sb = new StringBuilder();
		if (null!=productCategory) {
			List<ProductCategory> children = find("from ProductCategory where  parent.dbid=? order by orderNum",productCategory.getDbid());
			if (null!=children&&children.size()>0) {
				for (ProductCategory productCateGorup2 : children) {
					sb.append("<tr>");
					sb.append("<td style=\"text-align: left;\">"+indent+""+productCateGorup2.getName() +"</td>");
					sb.append("<td>"+DateUtil.format3(productCateGorup2.getCreateTime())+"</td>");
					sb.append("<td>"+productCateGorup2.getOrderNum()+"</td>");
					sb.append("<td style=\"text-align: center;\">");
					sb.append("<a href='javascript:void(-1)'  class='aedit' onclick=\"window.location.href='${ctx}/productCategory/edit?dbid="+productCateGorup2.getDbid()+"&parentMenu=1'\">编辑</a> |"); 
					sb.append("<a href='javascript:void(-1)'  class='aedit' onclick=\"$.utile.deleteById('${ctx}/productCategory/delete?dbid="+productCateGorup2.getDbid()+"','searchPageForm')\" title='删除'>删除</a></td>");
					sb.append("</tr>");
					List<ProductCategory> findBy = find("from ProductCategory where  parent.dbid=? order by orderNum",productCateGorup2.getDbid());
					if (null!=findBy&&findBy.size()>0.) {
						sb.append(getTableTr(productCateGorup2, indent+"&nbsp;&nbsp;&nbsp;&nbsp;"));
					}
				}
			}
		}
		return sb.toString();
	}
	public String getProductCateGorySelect(Integer businessId,ProductCategory curent) {
		List<ProductCategory> productCategories=find("from ProductCategory where enterpriseId=? and parent.dbid IS NULL", new Object[]{businessId});
		String select="";
		if (null!=productCategories&&productCategories.size()>0) {
			for (ProductCategory productCategory : productCategories) {
				String lest = getListSelect(productCategory, "&nbsp;&nbsp;&nbsp;&nbsp;",curent,businessId);
				select=select+lest;
			}
		}
		return select;
	}
}
