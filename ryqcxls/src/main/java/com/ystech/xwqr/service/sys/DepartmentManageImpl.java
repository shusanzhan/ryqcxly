/**
 * 
 */
package com.ystech.xwqr.service.sys;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.HibernateEntityDao;
import com.ystech.xwqr.model.sys.Department;
import com.ystech.xwqr.model.sys.Enterprise;

/**
 * @author shusanzhan
 * @date 2013-5-23
 */
@Component("departmentManageImpl")
public class DepartmentManageImpl extends HibernateEntityDao<Department>{

	/**
	 * @return
	 */
	public String getDepartmentSelect(Department depart,Integer enterpriseId) {
		if(enterpriseId==null){
			//root=get(Department.ROOT);
		}
		String select="";
		//String lest = getListDep(root,"|-",depart);
		//select=select+lest;
		return select;
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
	/**
	 *功能描述： 将传入的对象转化为JSON数据格式
	 * 部门树：根节点，具有子结构节点，子节点
	 * @throws JSONException
	 */
	public JSONObject makeJSONSuperObject(Enterprise enterprise){
		JSONObject jObject = new JSONObject();
		jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/1_open.png");// 根节点
		jObject.put("root", "root");
		if(enterprise!=null&&enterprise.getDbid()>0){
			jObject.put("id", enterprise.getDbid());
			jObject.put("name", enterprise.getName());
		}else{
			jObject.put("id", 0);
			jObject.put("name","根节点");
		}
		jObject.put("open", true);
		List<Department> departments = queryByEnterpriseId(enterprise);
		jObject.put("children",makeJSONObject(departments, 0));
		return jObject;
	}
	/**
	 *功能描述： 将传入的对象转化为JSON数据格式
	 * 部门树：根节点，具有子结构节点，子节点
	 * @throws JSONException
	 */
	private JSONArray makeJSONObject(List<Department> departments,int rootId){
		JSONArray array=new JSONArray();
		for (Department department : departments) {
			if(department.getParentId()==rootId){
				JSONObject jObject = new JSONObject();
				jObject.put("icon","/widgets/ztree/css/zTreeStyle/img/diy/2.png");// 菜单阶段
				jObject.put("id", department.getDbid());
				jObject.put("name", department.getName());
				jObject.put("open", true);
				jObject.put("children", makeJSONObject(departments, department.getDbid()));
				array.put(jObject);
			}else{
				continue;
			}
		}
		return array;
	}
	private List<Department> queryByEnterpriseId(Enterprise enterprise){
		String sql="select * from  sys_Department where 1=1 ";
		if(enterprise!=null&&enterprise.getDbid()>0){
			sql=sql+"  AND enterpriseId="+enterprise.getDbid();
		}
		sql=sql+" order by suqNo ";
		List<Department> departments = executeSql(sql, null);
		return departments;
	}
	
}
