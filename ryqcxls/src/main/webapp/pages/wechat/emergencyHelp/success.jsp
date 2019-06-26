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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css?${now}" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <style type="text/css">
    </style>
<title>成功提示</title>
</head>
<body>
<div class="container" id="container">
	<div class="msg">
		<div class="weui_msg">
		    <div class="weui_icon_area"><i class="weui_icon_success weui_icon_msg"></i></div>
		    <div class="weui_text_area">
		        <h2 class="weui_msg_title">申请发起成功</h2>
		        <p class="weui_msg_desc">我们已获悉您的请求,如需人工服务请拨打</p>
		        <p class="weui_msg_desc"><a href="tel:${enterprise.emergencyPhone }" style="color: #3cc51f;font-size: 14px;">${enterprise.emergencyPhone }</p>
		    </div>
		    <div class="weui_opr_area">
		        <p class="weui_btn_area">
		            <a href="JavaScript:void(-1)" class="weui_btn weui_btn_primary" onclick="window.history.go(-1)">返回</a>
		        </p>
		    </div>
		    <div class="weui_extra_area">
		        <a href="${ctx }/memberWechat/memberCenter?code=83a3e919bcb0b83fc264d78ed92bb521">会员中心</a>
		    </div>
		</div>
	</div>
</div>
</body>
</html>