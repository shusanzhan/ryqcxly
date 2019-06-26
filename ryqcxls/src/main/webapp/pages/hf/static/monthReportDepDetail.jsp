<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>车辆性质</title>
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
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportDep?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportUser?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">满意度部门负责人</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportSale?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left ">自有店</li>
	        <li onclick="window.location.href='${ctx }/staticHf/monthReportDepDetail?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }'" id="pingjia_tap" class="detail_tap5 detail_tap pull_left select">核心流程</li>
	   	</ul>
	 </div>
 </div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">自有店</div>
${ departmentTable}
<div class="frmTitle" onclick="showOrHiden('contactTable')">二网</div>
${ distributorTypeTable}
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
function exportExcel(){
 	window.location.href='${ctx}/staticHf/exportExcel?brandId=${brandId}&startDate=${startDate }&endDate=${endDate }';
 }
</script>
</html>