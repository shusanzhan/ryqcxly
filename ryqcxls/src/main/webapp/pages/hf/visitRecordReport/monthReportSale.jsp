<%@page import="com.ystech.core.util.DateUtil"%>
<%@page import="com.xwqr.hf.model.QuestAnswerItem"%>
<%@page import="com.xwqr.hf.model.VisitRecordAnswer"%>
<%@page import="com.xwqr.hf.service.VisitRecordAnswerManageImpl"%>
<%@page import="com.ystech.xwqr.model.Customer"%>
<%@page import="com.xwqr.hf.model.VisitRecord"%>
<%@page import="com.xwqr.hf.service.QuestManageImpl"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.xwqr.hf.model.Quest"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>回访月报</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/visitRecordReport/queryList'">回访月报管理</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/visitRecordReport/index'">月报查询</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(visitRecordReport) }">添加回访月报</c:if>
	<c:if test="${!empty(visitRecordReport) }">编辑回访月报</c:if>
</a>
</div>
<div class="line"></div>
<div class="listOperate" id="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="createMonthReport()">生成月报表</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
<div class="frmContent" id="frmContent" style="display:none;">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" value="${monthDate }" name="monthDate" id="monthDate">
		<input type="hidden" value="${brand.dbid }" name="brandId" id="brandId">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="visitRecordReport.title" id="title"
					value="${monthDate }${brand.name }月考核报表" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="visitRecordReport.dis" id="dis">${visitRecordReport.dis }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/visitRecordReport/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="cancel()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<div id="detail_nav">
	<div class="detail_nav_inner">
	      <ul class="clearfix padding10">
	        <li onclick="window.location.href='${ctx }/visitRecordReport/monthReport?brandId=${brandId}&monthDate=${monthDate }'" id="imgs_tap" class="detail_tap5 detail_tap pull_left ">满意度销售顾问</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/monthReportDep?brandId=${brandId}&monthDate=${monthDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/monthReportUser?brandId=${brandId}&monthDate=${monthDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门负责人</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/monthReportSale?brandId=${brandId}&monthDate=${monthDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left select">自有店</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/monthReportDepDetail?brandId=${brandId}&monthDate=${monthDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">核心流程</li>
	   	</ul>
	 </div>
 </div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${monthDate }月${brand.name }回访报表部门(自有店)</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">序号</td>
			<td class="span2">销售顾问</td>
			<td class="span3">部门</td>
			<td class="span2">客户</td>
			<td class="span2">客户电话</td>
			<td class="span2">车系</td>
			<td class="span2">VIM码</td>
			<td class="span2">销售日期</td>
			<%
				WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
				QuestManageImpl questManageImpl=(QuestManageImpl)webApplicationContext.getBean("questManageImpl");
				VisitRecordAnswerManageImpl visitRecordAnswerManageImpl=(VisitRecordAnswerManageImpl)webApplicationContext.getBean("visitRecordAnswerManageImpl");
				Integer brandId=(Integer)request.getAttribute("brandId");
				List<Quest> quests = questManageImpl.find("from Quest where isAssessment=? and brand.dbid=? order by orderNum", new Object[]{Quest.ASSESSMENTYES,brandId});
				//List<Quest> quests = questManageImpl.findBy("isAssessment",Quest.ASSESSMENTYES );
				for (Quest quest : quests) {
					out.print("<td class=\"span2\">"+quest.getNo()+"</td>");
				}
			%>
			<td class="span2">核心流程</td>
			<td class="span2">核心流程否</td>
			<td class="span2">延保产品</td>
			<td class="span2">考核金额</td>
		</tr>
	</thead>
	<%
		List<VisitRecord> visitRecords=(List<VisitRecord>)request.getAttribute("visitRecords");
	    int j=0;
		for (VisitRecord visitRecord: visitRecords){
			Customer customer=visitRecord.getCustomer();
			j++;
			out.print("<tr height=\"32\" align=\"center\">");
			out.print("<td>"+j+"</td>");
			out.print("<td>"+customer.getBussiStaff()+"</td>");
			out.print("<td>"+customer.getDepartment().getName()+"</td>");
			out.print("<td>"+customer.getName()+"</td>");
			out.print("<td>"+customer.getMobilePhone()+"</td>");
			out.print("<td>"+customer.getCustomerPidBookingRecord().getCarSeriy().getName()+"</td>");
			out.print("<td>"+customer.getCustomerPidBookingRecord().getVinCode()+"</td>");
			out.print("<td>"+DateUtil.format(customer.getCustomerPidBookingRecord().getModifyTime()) +"</td>");
			List<VisitRecordAnswer> visitRecordAnswers = visitRecordAnswerManageImpl.find("from VisitRecordAnswer where quest.isAssessment=? and visitRecordId=? order by quest.orderNum",Quest.ASSESSMENTYES,visitRecord.getDbid());
			//核心流程考核量
			int coreNum=0;
			//自有店考核
			int coreSelfNum=0;
			//核心流程考核金额
			int coreNumMoney=0;
			//自有店考核金额
			int coreSelfNumMoney=0;
			
			for (VisitRecordAnswer visitRecordAnswer: visitRecordAnswers){
				QuestAnswerItem questAnswerItem2 = visitRecordAnswer.getQuestAnswerItem();
				if(null!=questAnswerItem2){
					Integer assessmentState = questAnswerItem2.getAssessmentState();
					if(null!=assessmentState){
						if(questAnswerItem2.getQuest().getContent().contains("延保产品")){
							if(assessmentState==2){
								coreSelfNum=coreSelfNum+1;
							}
							coreSelfNumMoney=coreSelfNumMoney+questAnswerItem2.getAssessmentMoney();
						}else{
							if(assessmentState==2){
								coreNum=coreNum+1;
							}
							coreNumMoney=coreNumMoney+questAnswerItem2.getAssessmentMoney();
						}
						if(assessmentState==1){
							out.print("<td>√</td>");
						}
						if(assessmentState==2){
							out.print("<td style='color:red;'>×</td>");
						}
					}else{
						out.print("<td style='color:red;'> </td>");
					}
				}else{
					out.print("<td style='color:red;'> </td>");
				}
			}
			out.print("<td>"+visitRecord.getCoreScore()+"</td>");
			out.print("<td>"+coreNum+"</td>");
			out.print("<td>"+coreSelfNum+"</td>");
			out.print("<td style='color:red;'>"+(coreSelfNumMoney+coreNumMoney)+"</td>");
			out.print("</tr>");
		}
	%>
</table>
<br>
<br>
<br>
<script type="text/javascript">
	function createMonthReport(){
		$("#listOperate").hide();
		$("#frmContent").show();
	}
	function cancel(){
		$("#frmContent").hide();
		$("#listOperate").show();
	}
</script>
</body>
</html>