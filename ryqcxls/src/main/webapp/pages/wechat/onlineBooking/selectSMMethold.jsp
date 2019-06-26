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
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <style type="text/css">
    </style>
<title>预约方式</title>
</head>
<body>
	<form action="" id="frmId" name="frmId" method="post" target="_self">
	<div class="container" id="container">
	<div class="panel">
		<div class="bd">
			<div class="weui_panel_bd">
		          <a href="javascript:void(0);" class="weui_media_box weui_media_appmsg" onclick="window.location.href='${ctx}/onlineBookingWechat/onlineBookingSM?serviceType=1'">
		              <div class="weui_media_hd">
		                  <img class="weui_media_appmsg_thumb" src="${ctx }/img/weixin/daodian.png" alt="">
		              </div>
		              <div class="weui_media_bd">
		                  <h4 class="weui_media_title">到店</h4>
		                  <p class="weui_media_desc">自己开车到店</p>
		              </div>
		          </a>
		          <a href="javascript:void(0);" class="weui_media_box weui_media_appmsg" onclick="window.location.href='${ctx}/onlineBookingWechat/agreenment?serviceType=2'">
		              <div class="weui_media_hd">
		                  <img class="weui_media_appmsg_thumb" src="${ctx }/img/weixin/shangmen.png" alt="">
		              </div>
		              <div class="weui_media_bd">
		                  <h4 class="weui_media_title">上门接车</h4>
		                  <p class="weui_media_desc">服务人员上门取车</p>
		              </div>
		          </a>
		      </div>
	      </div>
    </div>
    </div>
    </form>
</body>
</html>