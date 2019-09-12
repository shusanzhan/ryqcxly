<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/fullcalendar.css" />	
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
.table-bordered td{
	height: 18px;
    padding-bottom: 3px;
}
.comments a{
color: #FFFFFF;
}
</style>
<title>系统管理员客户</title>
</head>
<body>
	<h3>欢迎${user.realName },登陆系统</h3>
</body>
<script src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.peity.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<!-- <script type="text/javascript">
window.onresize=function(){
	 $("#contentUrl").width(window.document.documentElement.clientWidth-145+"px");
}
</script> -->
<script type="text/javascript">
</script> 
</html>
