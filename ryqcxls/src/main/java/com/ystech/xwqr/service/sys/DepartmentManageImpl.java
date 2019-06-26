/**
 * 
 */
package com.ystech.xwqr.service.sys;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.model.sys.Department;

/**
 * @author shusanzhan
 * @date 2013-5-23
 */
@Component("departmentManageImpl")
public class DepartmentManageImpl extends HibernateEntityDao<Department>{

	/**
	 * @return
	 */
	public String getDepartmentSelect(Department depart,Department root) {
		if(root==null){
			root=get(Department.ROOT);
		}
		String select="";
		String lest = getListDep(root,"|-",depart);
		select=select+lest;
		return select;
	}
	/**
	 * @return
	 */
	public String getDepartmentComSelect(Department depart,Department parent) {
		List<Department> departments =executeSql("select * from sys_department where  parentId=? order by suqNo",new Object[] {parent.getDbid()});
		String select="";
		if(null!=depart){
			if((int)depart.getDbid()==(int)parent.getDbid()){
				select=select+"<option value='"+parent.getDbid()+"dp' selected=\"selected\">"+parent.getName()+"</option>";
			}else{
				select=select+"<option value='"+parent.getDbid()+"dp'>"+parent.getName()+"</option>";
			}
		}else{
			select=select+"<option value='"+parent.getDbid()+"dp'>"+parent.getName()+"</option>";
		}
		if (null!=departments&&departments.size()>0) {
			for (Department department : departments) {
				String lest = getListDepSelect(department, "-",depart);
				select=select+lest;
			}
		}
		return select;
	}
	public String getListDepSelect(Department department,String indent,Department choceDep){
		try{
			StringBuilder sb = new StringBuilder();
			if (null!=department) {
				List<Department> children = find("from Department where parent.dbid=? order by suqNo",department.getDbid());
				if (null!=children&&children.size()>0) {
					if(null!=choceDep){
						if((int)choceDep.getDbid()==(int)department.getDbid()){
							sb.append("<option value='"+department.getDbid()+"dp' selected=\"selected\">"+indent+department.getName()+"</option>");
						}else{
							sb.append("<option value='"+department.getDbid()+"dp'>"+indent+department.getName()+"</option>");
						}
					}else{
						sb.append("<option value='"+department.getDbid()+"dp'>"+indent+department.getName()+"</option>");
					}
					for (Department department2 : children) {
						sb.append(getListDepSelect(department2, indent+"-",choceDep));
					}
				}else{
					if(null!=choceDep){
						if((int)choceDep.getDbid()==(int)department.getDbid()){
							sb.append("<option value='"+department.getDbid()+"dp' selected=\"selected\">"+indent+department.getName()+"</option>");
						}else{
							sb.append("<option value='"+department.getDbid()+"dp'>"+indent+department.getName()+"</option>");
						}
					}else{
						sb.append("<option value='"+department.getDbid()+"dp'>"+indent+department.getName()+"</option>");
					}
				}
			}
			return sb.toString();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
	public String getListDep(Department department,String indent,Department choceDep){
		try{
			StringBuilder sb = new StringBuilder();
			if (null!=department) {
				if(null!=choceDep){
					if((int)choceDep.getDbid()==(int)department.getDbid()){
						sb.append("<option value='"+department.getDbid()+"' selected=\"selected\">"+indent+department.getName()+"</option>");
					}else{
						sb.append("<option value='"+department.getDbid()+"'>"+indent+department.getName()+"</option>");
					}
				}else{
					sb.append("<option value='"+department.getDbid()+"'>"+indent+department.getName()+"</option>");
				}
				List<Department> children = find("from Department where parent.dbid=? order by suqNo",department.getDbid());
				if (null!=children&&children.size()>0) {
					for (Department department2 : children) {
						sb.append(getListDep(department2, indent+"-",choceDep));
					}
				}
			}
			return sb.toString();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
	}
	public String getDepartmentIds(Department department) {
		StringBuilder dbids = new StringBuilder("");
		if(null!=department){
			dbids=dbids.append(department.getDbid()+",");
			List<Department> children =findBy("parent.dbid",department.getDbid());
			if(null!=children&&children.size()>0){
				for (Department department2 : children) {
					dbids=dbids.append(department2.getDbid()+",");
					List<Department> findBy = findBy("parent.dbid",department2.getDbid());
					if (null!=findBy&&findBy.size()>0) {
						dbids.append(getDepartmentIds(department2)+",");
					}
				}
			}else{
				
			}
			String string = dbids.toString();
			string=string.substring(0, string.length()-1);
			return string;
		}else{
			return null;
		}
	}
	/**
	 * 通过
	 * @param dbid
	 * @return
	 */
	public String getDepartmentIdsByDbid(Integer dbid) {
		if(dbid>0){
			Department department = get(dbid);
			String departmentIds = getDepartmentIds(department);
			return departmentIds;
		}else{
			return null;
		}
	}
	public void save() {
	}
	
}
