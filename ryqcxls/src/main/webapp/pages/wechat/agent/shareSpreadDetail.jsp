<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>瑞一新零售奇瑞经纪人【${member.name }】专属二维码</title>
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
				请扫描【${member.name }】，加入瑞一新零售经纪人
			</div>
		</c:if>
	</div>
</div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx }/widgets/utile/shareWeixin.js"></script>
<script type="text/javascript">
var host = document.domain;
var urlWeb="http://"+host
window.shareData = {
	"imgUrl": urlWeb+"${share.shareImage}",
	"link": urlWeb+"/agentWechat/shareSpreadDetail?sceneStr=${spreadDetail.sceneStr}",
	"title": "${member.name }经纪人专属二维码",
	"intro": "瑞一新零售经纪人",
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