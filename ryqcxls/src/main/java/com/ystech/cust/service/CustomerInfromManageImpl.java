package com.ystech.cust.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.core.util.DateUtil;
import com.ystech.cust.model.CustomerInfrom;
import com.ystech.cust.model.ProductCategory;

@Component("customerInfromManageImpl")
public class CustomerInfromManageImpl extends HibernateEntityDao<CustomerInfrom>{
	
	public String getCustomerInfrom(CustomerInfrom curent) {
		List<CustomerInfrom> customerInfroms=find("from CustomerInfrom where parent.dbid IS NULL order by num", new Object[]{});
		String select="";
		if (null!=customerInfroms&&customerInfroms.size()>0) {
			for (CustomerInfrom customerInfrom : customerInfroms) {
				String lest = getListSelect(customerInfrom, "&nbsp;&nbsp;&nbsp;&nbsp;",curent);
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
	public String getListSelect(CustomerInfrom customerInfrom,String indent,CustomerInfrom curent){
		StringBuilder sb = new StringBuilder();
		if (null!=customerInfrom) {
			sb.append("<option value='"+customerInfrom.getDbid()+"'");
			if((null!=curent&&curent.getDbid()>0)&&customerInfrom.getDbid()==curent.getDbid()){
				sb.append("selected='selected'>"+customerInfrom.getName()+"</option>");
			}else{
				sb.append(">"+customerInfrom.getName()+"</option>");
			}
			List<CustomerInfrom> children = find("from CustomerInfrom where  parent.dbid=? order by num",customerInfrom.getDbid());
			if (null!=children&&children.size()>0) {
				for (CustomerInfrom customerIn : children) {
					sb.append("<option value='"+customerIn.getDbid()+"'");
					if((null!=curent&&curent.getDbid()>0)&&customerIn.getDbid()==curent.getDbid()){
						sb.append("selected='selected'>"+indent+""+customerIn.getName()+"</option>");
					}else{
						sb.append(">"+indent+""+customerIn.getName()+"</option>");
					}
					List<CustomerInfrom> findBy = find("from CustomerInfrom where  parent.dbid=? order by num",customerIn.getDbid());
					if (null!=findBy&&findBy.size()>0.) {
						sb.append(getListSelect(customerIn, indent+"&nbsp;&nbsp;&nbsp;&nbsp;",curent));
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
	public String getTableTr(CustomerInfrom customerInfrom,String indent){
		StringBuilder sb = new StringBuilder();
		if (null!=customerInfrom) {
			List<CustomerInfrom> children = find("from CustomerInfrom where  parent.dbid=? order by num",customerInfrom.getDbid());
			if (null!=children&&children.size()>0) {
				for (CustomerInfrom customerInfrom2 : children) {
					sb.append("<tr>");
					sb.append("<td style=\"text-align: left;\">"+indent+""+customerInfrom2.getName() +"</td>");
					sb.append("<td style=\"text-align: left;\">"+customerInfrom2.getNote()+"</td>");
					sb.append("<td>"+DateUtil.format(customerInfrom2.getCreateDate())+"</td>");
					sb.append("<td>"+customerInfrom2.getNum()+"</td>");
					sb.append("<td style=\"text-align: center;\">");
					sb.append("<a href='javascript:void(-1)'  class='aedit' onclick=\"window.location.href='${ctx}/customerInfrom/edit?dbid="+customerInfrom2.getDbid()+"&parentMenu=1'\">编辑</a> |"); 
					sb.append("<a href='javascript:void(-1)'  class='aedit' onclick=\"$.utile.deleteById('${ctx}/customerInfrom/delete?dbid="+customerInfrom2.getDbid()+"','searchPageForm')\" title='删除'>删除</a></td>");
					sb.append("</tr>");
					List<ProductCategory> findBy = find("from CustomerInfrom where  parent.dbid=? order by num",customerInfrom2.getDbid());
					if (null!=findBy&&findBy.size()>0.) {
						sb.append(getTableTr(customerInfrom2, indent+"&nbsp;&nbsp;&nbsp;&nbsp;"));
					}
				}
			}
		}
		return sb.toString();
	}
	public String getCustomerInfromIds(Integer customerInfromId){
		StringBuffer buString=new StringBuffer();
		buString.append(customerInfromId+",");
		List<CustomerInfrom> customerInfroms = findBy("parent.dbid", customerInfromId);
		for (CustomerInfrom customerInfrom : customerInfroms) {
			buString.append(customerInfrom.getDbid()+",");
		}
		String string = buString.toString();
		if(null!=string&&string.trim().length()>0){
			string=string.substring(0,string.length()-1);
		}
		return string;
	}
}
