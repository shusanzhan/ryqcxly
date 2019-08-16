<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单审批</title>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<!-- Mobile Devices Support @end -->
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>

</head>
<body>
	<h1>客户中心</h1>
	<ul>
		<li><a href="${ctx }/qywxCustomer/add">添加客户</a></li>
		<li><a href="${ctx }/qywxCustomer/index">客户中心</a></li>
	</ul>
	<h1>销售管理</h1>
	<ul>
		<li><a href="${ctx }/qywxCustomerTrack/index">展厅管理</a></li>
		<li><a href="${ctx }/qywxCustomerOutFlow/outFlow">流失客户审批</a></li>
	</ul>
	<h1>总经理统计</h1>
	<ul>
		<li><a href="${ctx }/qywxStat/index">领导统计</a></li>
	</ul>
	<h1>微信权限</h1>
	<ul>
		<li><a href="${ctx }/enterpriseAssistant/oAuth2?resultUrl=http://www.xwqr.net/qywxOrderContract/generalManageApprovalOrder">获取权限</a></li>
	</ul>
</body>
</html>