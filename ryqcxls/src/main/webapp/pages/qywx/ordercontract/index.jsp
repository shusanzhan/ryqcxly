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
	<h1>订单审批</h1>
	<ul>
		<li> <a href="${ctx }/qywxProcessRun/queryWaitingTaskList">待我审批</a></li>
		<li><a href="${ctx }/qywxProcessRun/queryHistoryTaskList">经我审批</a></li>
	</ul>
	<h1>库存查询</h1>
	<ul>
		<li><a href="${ctx }/qywxFacotoryOrder/index">库存查询</a></li>
	</ul>
	<h1>物流应用</h1>
	<ul>
		<li><a href="${ctx }/qywxWlbFacotoryOrder/index">库存查询</a></li>
		<%-- <li><a href="${ctx }/qywxVisitRecord/list">回访记录</a></li> --%>
	</ul>
	<h1>客户中心</h1>
	<ul>
		<li><a href="${ctx }/qywxCustomer/add">添加客户</a></li>
		<li><a href="${ctx }/qywxCustomer/index">客户中心</a></li>
	</ul>
	<h1>前台线索</h1>
	<ul>
		<li><a href="${ctx }/qywxCustomerRecord/index">线索中心</a></li>
	</ul>
	<h1>客户审批</h1>
	<ul>
		<li><a href="${ctx }/qywxCustomerTrack/index">回访审批</a></li>
		<li><a href="${ctx }/qywxCustomerOutFlow/outFlow">流失客户审批</a></li>
	</ul>
	<h1>企业红包</h1>
	<ul>
		<li><a href="${ctx }/qywxRedBag/myRedBag">我的红包</a></li>
		<li><a href="${ctx }/qywxRedBag/redBagSort">红包排名</a></li>
	</ul>
	<h1>发红包</h1>
	<ul>
		<li><a href="${ctx }/qywxRedBag/sendBag">发红包</a></li>
		<li><a href="${ctx }/qywxRedBag/mySendBag">发放记录</a></li>
	</ul>
	<h1>个人统计</h1>
	<ul>
		<li><a href="${ctx }/qywxStatic/index">个人统计</a></li>
	</ul>
	<h1>计算器</h1>
	<ul>
		<li><a href="${ctx }/qywxFinCal/finCal">计算器</a></li>
	</ul>
	<h1>展厅经理统计</h1>
	<ul>
		<li><a href="${ ctx}/qywxRoomManageSaleReport/index">展厅经理统计</a></li>
	</ul>
	<h1>销售经理经理</h1>
	<ul>
		<li><a href="${ctx }/qywxStaticManage/index?role=sm">领导统计</a></li>
	</ul>
	<h1>总经理统计</h1>
	<ul>
		<li><a href="${ctx }/qywxStaticManage/index?role=gm">领导统计</a></li>
	</ul>
	<h1>区域经理统计</h1>
	<ul>
		<li><a href="${ctx }/qywxStaticManage/index?role=am">区域经理统计</a></li>
	</ul>
	<h1>微信权限</h1>
	<ul>
		<li><a href="${ctx }/enterpriseAssistant/oAuth2?resultUrl=http://www.xwqr.net/qywxOrderContract/generalManageApprovalOrder">获取权限</a></li>
	</ul>
</body>
</html>