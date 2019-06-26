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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
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
<a href="javascript:void(-1);">
	<c:if test="${empty(visitRecordReport) }">添加回访月报</c:if>
	<c:if test="${!empty(visitRecordReport) }">编辑回访月报</c:if>
</a>
</div>
<div class="line"></div>
<div class="listOperate" id="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="createMonthReport()">编辑</a>
		<a class="but button" href="javascript:void();" onclick="exportExcel()">导出月报表</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
<div class="frmContent" id="frmContent" style="display:none;">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" value="${visitRecordReport.createDate }" name="visitRecordReport.createDate" id="createDate">
		<input type="hidden" value="${visitRecordReport.dbid }" name="visitRecordReport.dbid" id="dbid">
		<input type="hidden" value="${visitRecordReport.brand.dbid }" name="brandId" id="brandId">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="visitRecordReport.title" id="title"
					value="${dateMonth }月考核报表" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
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
	        <li onclick="window.location.href='${ctx }/visitRecordReport/viewMonthReport?visitRecordReportId=${visitRecordReport.dbid }'" id="imgs_tap" class="detail_tap5 detail_tap pull_left ">满意度销售顾问</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/viewMonthReportDep?visitRecordReportId=${visitRecordReport.dbid }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/viewMonthReportUser?visitRecordReportId=${visitRecordReport.dbid }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left select">满意度部门负责人</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/viewMonthReportSale?visitRecordReportId=${visitRecordReport.dbid }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">自有店</li>
	        <li onclick="window.location.href='${ctx }/visitRecordReport/viewMonthReportDepDetail?visitRecordReportId=${visitRecordReport.dbid }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">核心流程</li>
	   	</ul>
	 </div>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${monthDate }月${brand.name }回访报表部门(自有店)</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">序号</td>
			<td class="span3">部门负责人</td>
			<td class="span2">非常满意</td>
			<td class="span2">满意</td>
			<td class="span2">一般</td>
			<td class="span2">不满意</td>
			<td class="span2">回访失败</td>
			<td class="span2">总回访</td>
			<td class="span2">满意率</td>
			<td class="span2">非常满意率</td>
			<td class="span2">核心流程</td>
		</tr>
	</thead>
	<c:forEach var="visitRecordReportItem" items="${visitRecordReportUsers}" varStatus="i">
		<tr height="32" align="center">
			<td>${i.index+1 }</td>
			<td><a href="javascript:void(-1)" class="aedit" style="color: green" onclick="$.utile.openDialog('${ctx }/visitRecordReport/monthReportDepManager?managerId=${visitRecordReportItem.userId }&brandId=${brand.dbid}&monthDate=${monthDate }','${visitRecordReportItem.userName }负责部门',1020,420);">${visitRecordReportItem.userName }</a></td>
			<td>${visitRecordReportItem.verySatisfied }</td>
			<td>${visitRecordReportItem.statisfied }</td>
			<td>${visitRecordReportItem.normal }</td>
			<td>${visitRecordReportItem.notsta }</td>
			<td>${visitRecordReportItem.failure }</td>
			<td>${visitRecordReportItem.total }</td>
			<td>
				<fmt:formatNumber value="${visitRecordReportItem.overalStatisfaction}" pattern="###%"></fmt:formatNumber>
			</td>
			<td>
				<fmt:formatNumber value="${visitRecordReportItem.veryOveralStatisfaction }" pattern="###%"></fmt:formatNumber>
			</td>
			
			<td>
				<fmt:formatNumber value="${visitRecordReportItem.coreStatisfaction }" pattern="###%"></fmt:formatNumber>
			</td>
		</tr>
	</c:forEach>
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
	function exportExcel(){
	 	window.location.href='${ctx}/visitRecordReport/exportExcel?dbid=${visitRecordReport.dbid}';
	 }
</script>
</body>
</html>