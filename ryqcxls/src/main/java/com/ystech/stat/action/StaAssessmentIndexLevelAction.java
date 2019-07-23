package com.ystech.stat.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.ystech.core.util.ParamUtil;
import com.ystech.core.web.BaseController;
import com.ystech.stat.model.StaAssessmentIndex;
import com.ystech.stat.model.StaAssessmentIndexLevel;
import com.ystech.stat.service.StaAssessmentIndexLevelManageImpl;
import com.ystech.stat.service.StaAssessmentIndexManageImpl;

@Component("staAssessmentIndexLevelAction")
@Scope("prototype")
public class StaAssessmentIndexLevelAction extends BaseController{
	private StaAssessmentIndexLevel staAssessmentIndexLevel;
	private StaAssessmentIndexManageImpl staAssessmentIndexManageImpl;
	private StaAssessmentIndexLevelManageImpl staAssessmentIndexLevelManageImpl;
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
	
	public StaAssessmentIndexLevel getStaAssessmentIndexLevel() {
		return staAssessmentIndexLevel;
	}
	public void setStaAssessmentIndexLevel(
			StaAssessmentIndexLevel staAssessmentIndexLevel) {
		this.staAssessmentIndexLevel = staAssessmentIndexLevel;
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
			StaAssessmentIndexLevel staAssessmentIndexLevel = staAssessmentIndexLevelManageImpl.get(dbid);
			request.setAttribute("staAssessmentIndexLevel", staAssessmentIndexLevel);
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
		HttpServletRequest request = getRequest();
		Integer staAssessmentIndexId = ParamUtil.getIntParam(request, "staAssessmentIndexId", -1);
		try {
			if(staAssessmentIndexId<0){
				renderErrorMsg(new Throwable("保存数据失败，请先选择指标"), "");
				return;
			}
			Integer type = staAssessmentIndexLevel.getType();
			List<StaAssessmentIndexLevel> staAssessmentIndexLevels = staAssessmentIndexLevelManageImpl.find("from StaAssessmentIndexLevel where type=? and staAssessmentIndex.dbid=? AND dbid!=? ", new Object[]{type,staAssessmentIndexId,staAssessmentIndexLevel.getDbid()});
			if(null!=staAssessmentIndexLevels&&!staAssessmentIndexLevels.isEmpty()){
				renderErrorMsg(new Throwable("保存数据失败，不能重复保存数据"), "");
				return;
			}
			
			StaAssessmentIndex staAssessmentIndex = staAssessmentIndexManageImpl.get(staAssessmentIndexId);
			Integer dbid = staAssessmentIndexLevel.getDbid();
			staAssessmentIndexLevel.setName(StaAssessmentIndexLevel.StaType.getName(type));
			
			int scoreNum=0;
			switch (StaAssessmentIndexLevel.StaType.getByValue(type)) {
				case excellent:
					scoreNum=2;
					break;
				case reachs:
					scoreNum=1;
					break;
				default:
					break;
			}
			staAssessmentIndexLevel.setScoreNum(scoreNum);
			if(dbid==null){
				staAssessmentIndexLevel.setStaAssessmentIndex(staAssessmentIndex);
				staAssessmentIndexLevelManageImpl.save(staAssessmentIndexLevel);
				String createHtml = createHtml(staAssessmentIndex,staAssessmentIndexLevel,1);
				renderMsg(createHtml, "创建指标成功！");
			}else{
				StaAssessmentIndexLevel staAssessmentIndexLevel2 = staAssessmentIndexLevelManageImpl.get(dbid);
				staAssessmentIndexLevel2.setStaAssessmentIndex(staAssessmentIndex);
				staAssessmentIndexLevel2.setBeginNum(staAssessmentIndexLevel.getBeginNum());
				staAssessmentIndexLevel2.setDepSugg(staAssessmentIndexLevel.getDepSugg());
				staAssessmentIndexLevel2.setEndnum(staAssessmentIndexLevel.getEndnum());
				staAssessmentIndexLevel2.setEntSugg(staAssessmentIndexLevel.getEntSugg());
				staAssessmentIndexLevel2.setName(staAssessmentIndexLevel.getName());
				staAssessmentIndexLevel2.setSalSugg(staAssessmentIndexLevel.getSalSugg());
				staAssessmentIndexLevel2.setScoreNum(staAssessmentIndexLevel.getScoreNum());
				staAssessmentIndexLevel2.setStaAssessmentIndex(staAssessmentIndex);
				staAssessmentIndexLevel2.setType(staAssessmentIndexLevel.getType());
				staAssessmentIndexLevelManageImpl.save(staAssessmentIndexLevel2);
				String createHtml = createHtml(staAssessmentIndex,staAssessmentIndexLevel2,2);
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
				staAssessmentIndexLevelManageImpl.deleteById(dbid);
			}
		} catch (Exception e) {
			e.printStackTrace();
			renderErrorMsg(new Throwable("删除数据失败，发生未知错误！"), "");
			return ;
		}
		renderMsg("", "删除数据成功");
		return;
	}
	private String createHtml(StaAssessmentIndex staAssessmentIndex,StaAssessmentIndexLevel staAssessmentIndexLevel,int type){
		StringBuffer buffer=new StringBuffer();
		if(type==1){
			buffer.append("			<li id=\"reply-list"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"\">");
		}
			buffer.append("    			<div class=\"reply-cont\">");
			buffer.append("    				<div class=\"reply-summary\">");
			buffer.append("	    				<h5 class=\"ta-c\" >名称："+staAssessmentIndexLevel.getName()+"   区间值："+staAssessmentIndexLevel.getBeginNum()+"-"+staAssessmentIndexLevel.getEndnum()+"  指标分："+staAssessmentIndexLevel.getScoreNum()+"</h5>");
			buffer.append("	    				<div class=\"info\">");
				buffer.append("	    				公司建议：    			"+staAssessmentIndexLevel.getEntSugg()+"<br>");
				buffer.append("	    				部门建议："+staAssessmentIndexLevel.getDepSugg()+"<br>");
				buffer.append("	    				销售顾问建议:"+staAssessmentIndexLevel.getSalSugg()+"<br>");
				buffer.append("	    			</div>");
			buffer.append("	    			</div>");
			buffer.append("    		</div>");
			buffer.append("<div class=\"reply-opts\">");
				buffer.append("	<a class=\"js-edit-it\" href=\"javascript:;\" id=\"js-add-reply"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"\" onclick=\"editStaLevel("+staAssessmentIndex.getDbid()+","+staAssessmentIndexLevel.getDbid()+",'编辑')\">编辑</a> -"); 
				buffer.append("	<a class=\"js-delete-it\" href=\"javascript:;\"  id='js-delete-reply"+staAssessmentIndex.getDbid()+""+staAssessmentIndexLevel.getDbid()+"' onclick=\"deleteStaLevel("+staAssessmentIndex.getDbid()+","+staAssessmentIndexLevel.getDbid()+")\">删除</a>");
			buffer.append("	</div>");
		 if(type==1){
			 buffer.append("</li>");
		 }
			return buffer.toString();
	}
}
