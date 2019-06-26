<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>全民经纪人</title>
</head>
<body>
	<h1>惠购车</h1>
	<ul>
		<li><a href="${ctx }/carModelWechat/carModelList">车型展示</a></li>
		<li><a href="${ctx }/agentWechat/jionIn?code=36c32f92fe5458abe53ce7b908031073&openId=oVrJCuOcJcSUtqFKabDqwzZIVUWc">瑞一经纪人</a></li>
	</ul>
	<h1>汇便捷</h1>
	<ul>
		<li><a href="${ctx }/onlineBookingWechat/onlineBookingEaxmined?code=83a3e919bcb0b83fc264d78ed92bb521">年审预约</a></li>
		<li><a href="${ctx }${ctx}/onlineBookingWechat/onlineBookingSM?serviceType=1&code=83a3e919bcb0b83fc264d78ed92bb521">保养维修</a></li>
		<li><a href="${ctx }/onlineBookingWechat/onlineBookingOCC?code=83a3e919bcb0b83fc264d78ed92bb521">旧车置换</a></li>
		<li><a href="${ctx }/onlineBookingWechat/onlineBooking?code=83a3e919bcb0b83fc264d78ed92bb521">试乘试驾</a></li>
		<li><a href="${ctx }/emergencyHelpWechat/emergencyHelp?code=83a3e919bcb0b83fc264d78ed92bb521">紧急救援</a></li>
	</ul>
	<h1>会生活</h1>
	<ul>
		<li><a href="${ctx}/memberWechat/memberCenter?code=36c32f92fe5458abe53ce7b908031073&state=no&openId=oVrJCuOcJcSUtqFKabDqwzZIVUWc">会员中心</a></li>
		<li><a href="${ctx}/bussiCardWechat/bussiCard?code=36c32f92fe5458abe53ce7b908031073&cardCode=97e6dd49a81b4260f235b17972b3fa76">个人名片</a></li>
		<li><a href="${ctx}/corporateCultureWechat/corporateCulture?code=36c32f92fe5458abe53ce7b908031073">企业形象</a></li>
	</ul>
</body>
</html>