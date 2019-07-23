package com.ystech.stat.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.dao.Page;
import com.ystech.core.util.DateUtil;
import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.stat.model.StaAssessmentIndex;
import com.ystech.stat.model.StaAssessmentIndexLevel;
import com.ystech.stat.service.StaAssessmentIndexLevelManageImpl;
import com.ystech.stat.service.StaAssessmentIndexManageImpl;

@Component("staAssessmentIndexAction")
@Scope("prototype")
public class StaAssessmentIndexAction extends BaseController{
	private StaAssessmentIndex staAssessmentIndex;
	private StaAssessmentIndexManageImpl staAssessmentIndexManageImpl;
	private StaAssessmentIndexLevelManageImpl staAssessmentIndexLevelManageImpl;
	
	public StaAssessmentIndex getStaAssessmentIndex() {
		return staAssessmentIndex;
	}
	public void setStaAssessmentIndex(StaAssessmentIndex staAssessmentIndex) {
		this.staAssessmentIndex = staAssessmentIndex;
	}
	@Resource
	public void setStaAssessmentIndexManageImpl(
			StaAssessmentIndexManageImpl staAssessmentIndexManageImpl) {
		this.staAssessmentIndexManageImpl = staAssessmentIndexManageImpl;
	}
	@Resource
	public void setStaAssessmentIndexLevelManageImpl(
			StaAssessmentIndexLevelManageImpl staAssessmentIndexLevelManageImpl) {
		this.staAssessmentIndexLevelManageImpl = staAssessmentIndexLevelManageImpl;
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String queryList(){
		HttpServletRequest request = this.getRequest();
		Integer pageSize = ParamUtil.getIntParam(request, "pageSize", 10);
		Integer pageNo = ParamUtil.getIntParam(request, "currentPage", 1);
		Integer type = ParamUtil.getIntParam(request, "type", -1);
		String name = request.getParameter("name");
		try {
			String sql="select * from sta_assessmentindex where 1=1 ";
			List params=new ArrayList();
			if(name!=null&&name.trim().length()>0){
				sql=sql+" and name like ? ";
				params.add("%"+name+"%");
			}
			sql=sql+" order by createTime desc ";
			Page<StaAssessmentIndex> page = staAssessmentIndexManageImpl.pagedQuerySql(pageNo, pageSize, StaAssessmentIndex.class, sql, params.toArray());
			request.setAttribute("page", page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public String edit() {
		HttpServletRequest request = getRequest();
		Integer dbid = ParamUtil.getIntParam(request, "dbid", -1);
		try {
			StaAssessmentIndex staAssessmentIndex2 = staAssessmentIndexManageImpl.get(dbid);
			request.setAttribute("staAssessmentIndex", staAssessmentIndex2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "edit";
	}
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void save(){
		try {
			Integer dbid = staAssessmentIndex.getDbid();
			if(dbid==null){
				staAssessmentIndex.setCreateTime(new Date());
				staAssessmentIndex.setModifyTime(new Date());
				staAssessmentIndex.setType(1);
				staAssessmentIndexManageImpl.save(staAssessmentIndex);
				String createHtml = createHtml(staAssessmentIndex,1);
				renderMsg(createHtml, "创建指标成功！");
			}else{
				StaAssessmentIndex staAssessmentIndex2 = staAssessmentIndexManageImpl.get(dbid);
				staAssessmentIndex2.setModifyTime(new Date());
				staAssessmentIndex2.setName(staAssessmentIndex.getName());
				staAssessmentIndex2.setIndexNum(staAssessmentIndex.getIndexNum());
				staAssessmentIndex2.setNote(staAssessmentIndex.getNote());
				staAssessmentIndexManageImpl.save(staAssessmentIndex2);
				String createHtml = createHtml(staAssessmentIndex2,2);
				renderMsg(createHtml, "编辑指标成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("保存数据失败，发生未知错误"), "");
			return;
		}
		return;
	}
	
	/**
	 * 功能描述：
	 * 参数描述：
	 * 逻辑描述：
	 * @return
	 * @throws Exception
	 */
	public void delete(){
		HttpServletRequest request = getRequest();
		Integer[] dbids = ParamUtil.getIntArraryByDbids(request,"dbids");
		try {
			if(null==dbids||dbids.length<=0){
				renderErrorMsg(new Throwable("删除数据失败，请先选择操作数据"), "");
				return ;
			}
			for (Integer dbid : dbids) {
				List<StaAssessmentIndexLevel> staAssessmentIndexLevels = staAssessmentIndexLevelManageImpl.findBy("staAssessmentIndex.dbid", dbid);
				if(null!=staAssessmentIndexLevels&&!staAssessmentIndexLevels.isEmpty()){
					renderErrorMsg(new Throwable("删除数据失败，请先删除指标等级信息"), "");
					return ;
				}
				staAssessmentIndexManageImpl.deleteById(dbid);
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("删除数据失败，发生未知错误！"), "");
			return ;
		}
		String queryUrl = ParamUtil.getQueryUrl(request);
		renderMsg("/staAssessmentIndex/queryList"+queryUrl, "删除数据成功");
		return;
	}
	private String createHtml(StaAssessmentIndex staAssessmentIndex,int type){
		StringBuffer buffer=new StringBuffer();
		if(type==1){
			buffer.append("<div class=\"rule-group\" id=\"rule-group"+staAssessmentIndex.getDbid()+"\">");
		}
			buffer.append("<div class=\"rule-meta\">");
			buffer.append("<h3>");
		    buffer.append("<em class=\"rule-id\"></em>");
		    buffer.append("    <span class=\"rule-name\" id=\"rule-name\">"+staAssessmentIndex.getName()+"</span>");
		    buffer.append("    <div class=\"rule-opts\">");
		    buffer.append("			<div id=\"operatorIn${spreadDetail.dbid }\">");
		    buffer.append("                <a href=\"javascript:;\" class=\"js-edit-rule\" onclick=\"edit('${ctx}/staAssessmentIndex/edit?dbid="+staAssessmentIndex.getDbid()+"','编辑指标',"+staAssessmentIndex.getDbid()+")\">编辑</a>");
		    if(staAssessmentIndex.getType()==2){
		    	buffer.append("                <span>-</span>");
		    	buffer.append("                <a href=\"javascript:;\" class=\"js-disable-rule\" id=\"js-disable-rule${spreadDetail.dbid}\" onclick=\"deleteSta("+staAssessmentIndex.getDbid()+")\">删除</a>");
		    }
		    buffer.append("             </div>");
		    buffer.append("     </div>");
		    buffer.append("</h3>");
		    buffer.append("</div>");
		    buffer.append("<div class=\"rule-body\" id=\"rule-body"+staAssessmentIndex.getDbid()+"\" >");
		    buffer.append(" <div class=\"long-dashed\"></div>");
		    buffer.append("<div class=\"rule-keywords\">");
		    buffer.append("    <div class=\"rule-inner\">");
		    buffer.append("        <h4>指标信息：</h4>");
		    buffer.append("         <h5 class=\"ta-c\" >&nbsp;&nbsp;</h5>");
		    buffer.append("          <h5 class=\"ta-c\" >名称："+staAssessmentIndex.getName()+"</h5>");
		    buffer.append("          <h5 class=\"ta-c\" >类型："+(staAssessmentIndex.getType()==1?"系统":"自助添加")+"</h5>");
		    buffer.append("        <h5 class=\"ta-c\" >行业参考："+staAssessmentIndex.getIndexNum()+"</h5>");
		    		buffer.append("        <h5 class=\"ta-c\" >创建时间："+DateUtil.format(staAssessmentIndex.getCreateTime())+"</h5>");
		    		buffer.append("         <h5 class=\"ta-c\" >修改时间："+DateUtil.format(staAssessmentIndex.getModifyTime())+"</h5>");
		    buffer.append("                  <hr class=\"dashed\">");
		    buffer.append("        <div class=\"keyword-container\">");
		    
		    buffer.append("	     	<div class=\"info\">");
		    if(staAssessmentIndex.getNote()==null||staAssessmentIndex.getNote().trim().length()<=0){
		    	buffer.append("	     		无备注信息");
		    }else{
		    	buffer.append(staAssessmentIndex.getNote());
		    }
		  	buffer.append("	     	</div>");
		  	buffer.append("    	</div>");
		    buffer.append("      </div>");
		    buffer.append("  </div>");
		    buffer.append(" <div class=\"rule-replies\" style=\"width: 70%\">");
		    buffer.append("    <div class=\"rule-inner\">");
		    buffer.append("         <h4>指标等级：");
		    buffer.append("         </h4>");
		    buffer.append("         <div class=\"reply-container\" id=\"reply-container"+staAssessmentIndex.getDbid()+"\" style=\"display: block;\">");
		    Set<StaAssessmentIndexLevel> staAssessmentIndexLevels = staAssessmentIndex.getStaAssessmentIndexLevels();
		    if(null!=staAssessmentIndexLevels&&!staAssessmentIndexLevels.isEmpty()){
		    	buffer.append("	<ol class=\"reply-list\" id=\"reply-list"+staAssessmentIndex.getDbid()+"\">");
		    		for (StaAssessmentIndexLevel staAssessmentIndexLevel : staAssessmentIndexLevels) {
		    			buffer.append("			<li id=\"reply-list"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"\">");
		    			buffer.append("    				<div class=\"reply-cont\">");
		    			buffer.append("    				<div class=\"reply-summary\">");
		    			buffer.append("	    				<h5 class=\"ta-c\" >名称："+staAssessmentIndexLevel.getName()+"   区间值："+staAssessmentIndexLevel.getBeginNum()+"-"+staAssessmentIndexLevel.getEndnum()+"  指标分："+staAssessmentIndexLevel.getScoreNum()+"</h5>");
		    			buffer.append("	    				<div class=\"info\">");
		    			buffer.append("	    				公司建议：    			"+staAssessmentIndexLevel.getEntSugg()+"<br>");
		    			buffer.append("	    		部门建议："+staAssessmentIndexLevel.getDepSugg()+"<br>");
		    			buffer.append("	    		销售顾问建议:"+staAssessmentIndexLevel.getSalSugg()+"<br>");
		    			buffer.append("	    		</div>");
		    			buffer.append("	    		</div>");
		    			buffer.append("    		</div>");
		    			buffer.append("<div class=\"reply-opts\">");
							buffer.append("	<a class=\"js-edit-it\" href=\"javascript:;\" id=\"js-add-reply"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"\" onclick=\"editStaLevel("+staAssessmentIndex.getDbid()+","+staAssessmentIndexLevel.getDbid()+",'编辑')\">编辑</a> -"); 
							buffer.append("	<a class=\"js-delete-it\" href=\"javascript:;\"  id='js-delete-reply"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"' onclick=\"deleteStaLevel("+staAssessmentIndex.getDbid()+","+staAssessmentIndexLevel.getDbid()+")\">删除</a>");
						buffer.append("	</div>");
				}
		    	buffer.append(" 		</ol>");
		    }else{
		    	  buffer.append("	<div class=\"info\" id=\"levelInfo"+staAssessmentIndex.getDbid()+"\" >未添加指标等级！</div>");
		    }
		           
		    buffer.append("        </div>");
		    buffer.append("         <hr class=\"dashed\">");
		    buffer.append("        <div class=\"opt\">");
		    if(null!=staAssessmentIndexLevels&&staAssessmentIndexLevels.size()>=3){
		    	buffer.append("<span class=\"disable-opt \">最多三个等级</span>");
		    	buffer.append("<a class=\"js-add-reply add-reply-menu hide\" id=\"js-add-reply${weixinKeyWordRole.dbid }\" href=\"javascript:;\" onclick=\"editStaLevel("+staAssessmentIndex.getDbid()+")\">添加指标等级</a>");
		    }else{
		    	buffer.append("<span class=\"disable-opt hide\">最多三个等级</span>");
		    	buffer.append("<a class=\"js-add-reply add-reply-menu\" id=\"js-add-reply${weixinKeyWordRole.dbid }\" href=\"javascript:;\" onclick=\"editStaLevel("+staAssessmentIndex.getDbid()+")\">添加指标等级</a>");
		    }
		    buffer.append("</div>");
		    buffer.append("     </div>");
			buffer.append("  </div>");
			buffer.append("</div>");
			if(type==1){
				buffer.append("</div>");
			}
			return buffer.toString();
	}
}
