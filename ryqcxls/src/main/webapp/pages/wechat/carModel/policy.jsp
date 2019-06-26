<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    </style>
<title>车型介绍</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>车型介绍</h3>
</div>
<br>
<br>
<div class="weui_panel weui_panel_access">
        <div class="weui_panel_bd">
        	<c:forEach var="carModel" items="${carModels }">
	            <a href="${ctx }/carModelWechat/carModel?dbid=${carModel.dbid}" class="weui_media_box weui_media_appmsg">
	                <div class="weui_media_hd">
	                    <img class="weui_media_appmsg_thumb" src="${carModel.picture }" alt="">
	                </div>
	                <div class="weui_media_bd">
	                    <h4 class="weui_media_title">${carModel.brand.name }${carModel.name }</h4>
	                    <p class="weui_media_desc">指导价：<span style="color: #E67816">${carModel.priceFrom }万元</span></p>
	                    <p class="weui_media_desc">优&#12288;惠：<span style="color: #E67816">${carModel.saleCSPrice }元</span></p>
	                </div>
	            </a>
            </c:forEach>
        </div>
</div>
<br>
</body>
</html>