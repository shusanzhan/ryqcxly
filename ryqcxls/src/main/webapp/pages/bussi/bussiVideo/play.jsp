<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!doctype html>
<html  lang="en">
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
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
   	<link rel="stylesheet" href="${ctx }/weui-master/css/weui.css"/>
    <link rel="stylesheet" href="${ctx }/weui-master/css/weuix.css"/>
     <link rel="stylesheet" href="${ctx }/weui-master/css/DPlayer.min.css">
</head>
<body>
<div class="weui-content">
    <div class="weui-c-inner">
        <div class="weui-c-content">
            <h2 class="weui-c-title">${bussiVideo.title }</h2>
            <div class="weui-c-meta">
                <em class="weui-c-nickname"><fmt:formatDate value="${bussiVideo.createtime }"/> </em>
            </div>
            <div class="weui-c-article">
<div id="dplayer"></div>
<script src="${ctx }/weui-master/js/DPlayer.min.js"></script>
		<script type="text/javascript">
	const dp = new DPlayer({
	    container: document.getElementById('dplayer'),
	    screenshot: true,
	    autoplay:false,
	    video: {
	        url: '${bussiVideo.mideuUrl}',
	        pic: '${bussiVideo.pictrue}',
	        thumbnails: '${bussiVideo.pictrue}'
	    }
	});
		</script>
            </div>
        </div>
        <div class="weui-c-tools">
            <a href="javascript:;">阅读原文</a>
            <div class="weui-c-readnum">阅读<span id="readnum">10000+</span></div>
            <div class="weui-c-like">
                <i class="icon"></i>
                <span id="likenum">1000</span>
            </div>
        </div>
    </div>

</div>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.js?"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
