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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    </style>
<title>我的经纪人</title>
</head>
<body>
<div class="container" id="container">
	<br>
	<c:if test="${empty(members)||fn:length(members)<=0 }">
		<div style="width: 100%;text-align: center;">
			<div class="bd spacing">
			    <i class="weui_icon_safe weui_icon_safe_warn"></i>
			</div>
			<p class="weui_msg_desc">您无注册经纪人</p>
		</div>
	</c:if>
	<div class="weui_panel_bd">
		<c:forEach var="mem" items="${members }">
			<c:set value="${mem.weixinGzuserinfo }" var="weixinGzuserinfo"></c:set>
		     <a href="javascript:void(0);" class="weui_media_box weui_media_appmsg">
		         <div class="weui_media_hd">
		             <img class="weui_media_appmsg_thumb" src="${weixinGzuserinfo.headimgurl }" alt="">
		         </div>
		         <div class="weui_media_bd">
		             <h4 class="weui_media_title">
		             	${mem.name }
		             </h4>
		             <c:if test="${mem.memAuthStatus==1 }">
		             	 <p class="weui_media_desc"><span style="color: red">未注册</span></p>
		             </c:if>
		             <c:if test="${mem.memAuthStatus==2 }">
			             <p class="weui_media_desc">注册时间：<fmt:formatDate value="${mem.memAuthDate }" pattern="yyyy-MM-dd"/> </p>
		             </c:if>
		             <c:if test="${member.memType==1 }">
			              <c:if test="${mem.carMasterStatus==1 }">
			             	 <p class="weui_media_desc"><span style="color: red">车主未认证 <span style="color: #586C94" onclick="window.location.href='${ctx}/memberWechat/carMasterAuth?memberId=${mem.dbid }'">点击认证</span></span>
			                </p>
			             </c:if>
			              <c:if test="${mem.carMasterStatus==2 }">
			             	 <p class="weui_media_desc"><span style="color: green">车主已认证</span></p>
			             </c:if>
		             </c:if>
		         </div>
		     </a>
		</c:forEach>
	 </div>
</div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx }/widgets/utile/shareWeixin.js"></script>
<script type="text/javascript">
</script>
</html>