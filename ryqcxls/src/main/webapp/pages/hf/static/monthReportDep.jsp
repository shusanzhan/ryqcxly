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
<a href="javascript:void(-1);">
	<c:if test="${empty(visitRecordReport) }">添加回访月报</c:if>
	<c:if test="${!empty(visitRecordReport) }">编辑回访月报</c:if>
</a>
</div>
<div class="line"></div>
<div class="listOperate" id="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel()">导出EXCEL</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
<br>
<div id="detail_nav">
	<div class="detail_nav_inner">
	      <ul class="clearfix padding10">
	        <li onclick="window.location.href='${ctx }/staticHf/monthReport?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="imgs_tap" class="detail_tap5 detail_tap pull_left ">满意度销售顾问</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportDep?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left select">满意度部门</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportUser?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门负责人</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportSale?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">自有店</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportDepDetail?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">核心流程</li>
	   	</ul>
	 </div>
 </div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${monthDate }月回访报表部门(自有店)</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">序号</td>
			<td class="span3">部门</td>
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
	<c:forEach var="visitRecordReportItem" items="${visitRecordReportDepartments}" varStatus="i">
		<tr height="32" align="center">
			<td>${i.index+1 }</td>
			<td>${visitRecordReportItem.departmentname }</td>
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
				<ystech:visitRecordReportStaticTag startDate="${startDate }" depId="${visitRecordReportItem.departmentId }" type="1" endDate="${endDate }" brandId="${brandId }"/>
			</td>
		</tr>
	</c:forEach>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${monthDate }月回访报表经销商</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">序号</td>
			<td class="span3">经销商名称</td>
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
	<c:forEach var="visitRecordReportItem" items="${visitRecordReportDepartmentNets}" varStatus="i">
		<tr height="32" align="center">
			<td>${i.index+1 }</td>
			<td>${visitRecordReportItem.departmentname }</td>
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
				<ystech:visitRecordReportStaticTag startDate="${startDate }" depId="${visitRecordReportItem.departmentId }" type="2" endDate="${endDate }" brandId="${brandId }"/>
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
</script>
<script type="text/javascript">
function exportExcel(){
 	window.location.href='${ctx}/staticHf/exportExcel?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }';
 }
</script>
</body>
</html>