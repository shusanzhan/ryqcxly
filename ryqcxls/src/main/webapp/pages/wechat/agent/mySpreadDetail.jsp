<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>经纪人专属二维码</title>
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
<link rel="stylesheet" href="${ctx }/css/wechat/comm.css?${now}" type="text/css" />
<link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
<script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css">
.reciver .from .input{
		height: 32px;
		font-size: 16px;
		letter-spacing:2px;
		padding-left: 6px;
		padding: 5px 0;
	}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="order" style="">
	<div class="container reciver">
	  	<c:if test="${empty(spreadDetail)}" var="status">
		  	<div class="main">
				<div class="faceSmall"></div>
			</div> 
			<div style="padding: width: 100%;">
				<div class="alert alert-error" style="width: 80%;margin: 0 auto;margin-top: 12px;font-size: 14px;">
					亲~您还不是经纪人，不能为您生成经纪人专属二维码
					<br>
					立即认证成为经纪人
				</div>
			</div>
		</c:if>
		<c:if test="${!empty(spreadDetail)}" var="status">
			<div style="margin: 0 auto;text-align: center;margin-top: 20px;">
				<img src="${spreadDetail.qrcode }" width="80%" style="margin: 0 auto;"></img>
			</div>
			<div class="" style="width: 80%;margin: 0 auto;margin-top: 12px;font-size: 20px;text-align: center;color: red; ">
				邀请朋友扫描我的二维码
			</div>
			<div class="" style="width: 80%;margin: 0 auto;margin-top: 12px;font-size: 16px;text-align: center;">
				点击右上角按钮，分享至朋友圈
			</div>
			<div class="" style="width: 80%;margin: 0 auto;margin-top: 12px;font-size: 16px;text-align: center;">
				长按【二维码】，识别二维码
			</div>
		</c:if>
	</div>
	<div class="header" style="margin-bottom: 1px;">
	 	<h1 class="h1">专属二维码统计</h1>
	 	<hr class="hr" style="border-color: -moz-use-text-color -moz-use-text-color #eb6877;">
	 </div>
	<ul class="list-group">
		  <li  class="list-group-item" onclick="window.location.href='${ctx}/agentWechat/myAgent'">
			  	<span style="float: right;">
		  			<img src="${ctx}/css/wechat/img/arrowLeft.png" alt="">
		  		</span>
		    	我的经纪人
		    	<span id="badgeSelf" class="badge" style="color: #f00;">
			    	${spreadDetail.spreadNum }
		    	</span>
		  </li>
		  <li class="list-group-item">
		  		<%-- <span style="float: right;">
		  			<img src="${ctx}/css/wechat/img/arrowLeft.png" alt="">
		  		</span> --%>
		    		扫描次数
		    	<span id="badgeSelf" class="badge" style="color: #f00;">
			    	${spreadDetail.scanNum }
		    	</span>
		  </li>
	</ul>
</div>
<br>
<br>
<jsp:include page="tabbar.jsp"></jsp:include>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx }/widgets/utile/shareWeixin.js"></script>
<script type="text/javascript">
var host = document.domain;
var urlWeb="http://"+host
window.shareData = {
	"imgUrl":"${spreadDetail.qrcode }",
	"link": urlWeb+"/agentWechat/shareSpreadDetail?sceneStr=${spreadDetail.sceneStr}",
	"title": "我的专属二维码",
	"intro": "瑞一经纪人",
	"type":"1"
};
wx.config({
    debug: false,
    appId: '${weixinCommon.appId}',
    timestamp: '${weixinCommon.timestamp}',
    nonceStr: '${weixinCommon.nonceStr}',
    signature: '${weixinCommon.signature}',
    jsApiList: [
      'checkJsApi',
      'onMenuShareTimeline',
      'onMenuShareAppMessage',
      'onMenuShareQQ',
      'onMenuShareWeibo'
    ]
});
</script>
</html>