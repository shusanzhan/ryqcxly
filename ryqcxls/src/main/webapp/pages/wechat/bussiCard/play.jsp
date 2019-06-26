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
      <link rel="stylesheet" href="${ctx }/weui-master/css/bussiCard.css"/>
     <link rel="stylesheet" href="${ctx }/weui-master/css/DPlayer.min.css">
    <style type="text/css">
    	.slide{
    		max-height: 100%;
    		min-height: 30%;
    	}
    	.slide .slide-desc {
    		text-align: left;
    	}
   	</style>
<title>${bussiVideo.title }</title>
</head>
<body>
 <div class="weui-content" style="padding:12px 12px">
    <div class="weui-c-inner" style="max-width: 1204px;">
        <div class="weui-c-content" >
            <h2 class="weui-c-title">${bussiVideo.title }</h2>
            <div class="weui-c-meta">
                <em class="weui-c-nickname"><fmt:formatDate value="${bussiVideo.createtime }"/> </em>
            </div>
			<div class="weui-c-article" style="width: 100%;margin-top: -20px;">
				<div id="dplayer" style="height:240px;width: 100%;"></div>
						<script src="${ctx }/weui-master/js/DPlayer.min.js"></script>
						<script type="text/javascript">
							const dp = new DPlayer({
							    container: document.getElementById('dplayer'),
							    screenshot: true,
							    autoplay:true,
							    video: {
							        url: '${bussiVideo.mideuUrl}',
							        pic: '${bussiVideo.pictrue}',
							        thumbnails: '${bussiVideo.pictrue}'
							    }
							});
						</script>
			    </div>
		</div>
        <div class="weui-c-tools" style="margin-top: -12px;">
            <div class="weui-c-readnum">播放量<span id="readnum">${bussiVideo.playNum}</span></div>
        </div>
    </div>

</div>
<div class="weui-tab" id="t3" style="height:34px;margin-top: -12px;">
    <div class="weui-navbar">
        <div class="tab-pink weui-navbar__item " style="text-align: left;padding-left: 12px;">
            精彩视频
        </div>
    </div>
</div>
<ul class="weui-mark" style="margin-top: 12px;padding-top: 12px;">
	<c:forEach var="bussiVideo" items="${bussiVideos }">
        <li onclick="window.location.href='${ctx}/bussiCardWechat/paly?bussiVideoId=${bussiVideo.dbid }'">
            <div class="weui-mark-img" style="border-radius:10px;">
                <img src="${bussiVideo.pictrue }">
                <img alt="" src="${ ctx}/images/bussiCard/playi.png">
            </div>
            <div class="weui-mark-meta">
                <div class="weui-mark-title"><a href="javascript:;">${bussiVideo.title }</a></div>
            </div>
            
        </li>
	</c:forEach>
</ul>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.js?"></script>
 <script src="${ctx }/weui-master/js/DPlayer.min.js"></script>
</html>