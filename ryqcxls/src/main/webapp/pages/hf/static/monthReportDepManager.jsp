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
<br>
<br>
<br>
<table width="98%"  cellpadding="0" cellspacing="0" class="mainTable" border="0" style="margin: 0 auto;">
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
				<ystech:visitRecordReportTag depId="${visitRecordReportItem.departmentId }" type="1" monthDate="${startDate}|${endDate }" brandId="${brandId }"/>
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
</body>
</html>