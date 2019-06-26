<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${share.title }</title>
<meta >
<meta charset="utf-8" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="pragram" content="no-cache" />
<link rel="stylesheet" type="text/css"	href="${ctx}/widgets/static/copyright.css">
<link rel="stylesheet" type="text/css"	href="${ctx}/widgets/static/main.css">
<link rel="stylesheet" type="text/css"	href="${ctx}/widgets/static/add2home.css">
<link rel="stylesheet" type="text/css"	href="${ctx}/widgets/static/danru.css">
<script type="text/javascript" src="${ctx}/widgets/static/offline.js"></script>
<script type="text/javascript">
		var phoneWidth = parseInt(window.screen.width);
		var phoneScale = phoneWidth/640;

		var ua = navigator.userAgent;
		if (/Android (\d+\.\d+)/.test(ua)){
			var version = parseFloat(RegExp.$1);
			// andriod 2.3
			if(version>2.3){
				document.write('<meta name="viewport" content="width=640, minimum-scale = '+phoneScale+', maximum-scale = '+phoneScale+', target-densitydpi=device-dpi">');
			// andriod 2.3以上
			}else{
				document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
			}
			// 其他系统
		} else {
			document.write('<meta name="viewport" content="width=640, user-scalable=no, target-densitydpi=device-dpi">');
		}
</script>
<style type="text/css">
	
.share {
    display: block;
    left: 0;
    position: absolute;
    text-align: center;
    top: 10%;
    width: 100%;
    z-index: 9999;
}

.share button {
    background: none repeat scroll 0 0 #F97206;
    border: medium none;
    border-radius: 5px;
    color: #fff;
    display: inline-block;
    font-size: 25px;
    padding: 25px;
    width: 40%;
    font-family: '微软雅黑';
}
</style>
</head>
<body>
</head>
<body class="s-bg-ddd pc perspective yes-3d">
<section class="u-alert">
		<img style='display:none;' src="${ctx }/widgets/static/loading_large.gif" />
	</section>
	<!--模版加载提示 end-->
	
			<!-- 声音控件 -->
	<section class='u-audio f-hide' data-src='${share.music }'>
		<p id='coffee_flow' class="btn_audio">
			<strong class='txt_audio z-hide'>关闭</strong>
			<span class='css_sprite01 audio_open'></span>
		</p>
	</section>
	<!-- 声音控件 end-->
																																					<!-- 箭头指示引导 -->
	<section class='u-arrow f-hide'><p class="css_sprite01"></p></section>
	<!-- 箭头指示引导 end-->

	<!-- page页面内容 -->
	<section class='p-ct'>
		<!-- 旋转正面 -->
		
		<!-- 旋转正面 end-->
		
		<!-- 旋转反面 -->
		<div class='translate-back f-hide'>
			<!-- 封页 1-->
			<!-- 擦一擦 -->
			<input id="ca-tips"   type="hidden" value="" />
			<!-- 蒙板背景图 -->
			<input id="r-cover"    type="hidden" value='${ctx}/widgets/static/i/6.jpg' />
			<c:forEach var="sharePictureUrl" items="${sharePictureUrls }" begin="0" end="0">
				<div class='m-page m-fengye f-hide' data-page-type='info_pic3' data-statics='info_pic3'>
					<div class="page-con lazy-img" data-src='${sharePictureUrl.url }'></div>
				</div>
			</c:forEach>
			<c:forEach var="sharePictureUrl" items="${sharePictureUrls }" begin="1"  varStatus="i">
				<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
					<div class="page-con j-txtWrap lazy-img" data-src='${sharePictureUrl.url }'>
						<%-- <c:if test="${i.index==5 }">
						<div class="texiao26">
							 <a href="${ctx }/shareWeixin/aplay?shareId=${share.dbid}">
							 	<img src="${ctx }/widgets/static/i/91.png">
							 	<!-- <div class="share">
		                            <button>点我参与</button>
		                        </div> -->
							 </a>
						  </div>
						</c:if> --%>
					</div>
				</div>
			</c:forEach>
			
			<%-- <div class='m-page m-fengye f-hide' data-page-type='info_pic3' data-statics='info_pic3'>
				<div class="page-con lazy-img" data-src='${ctx}/widgets/static/i/1.jpg'></div>
			</div>
			<!-- 封页 end-->                    
            
            <!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/2.jpg'></div>
			</div>
			<!-- 大图文 end-->
				
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/3.jpg'></div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/4.jpg'></div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/5.jpg'></div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
	            <div id="j-mengban" class='translate-front'>
					<div class='mengban-warn'></div>
				</div>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/7.jpg'></div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/8.jpg'></div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/9.jpg'>
                  <div class="texiao26">
					  <a href="http://www.jia360.com/zhuanti/201408291/"><!-- <img src="i/9_1.png"> --></a>
				  </div>
				</div>
			</div>
			<!-- 大图文 end-->
		
								<!-- 大图文 3-->
			<div class='m-page m-bigTxt f-hide' data-page-type='bigTxt' data-statics='info_list'>
				<div class="page-con j-txtWrap lazy-img" data-src='${ctx}/widgets/static/i/10.jpg'></div>
                <div class="texiao27">
				 <a href="http://www.ltab.cn/m"><img src='${ctx}/widgets/static/i/10_1.png"></a>
				</div>
			</div> --%>
			<!-- 大图文 end-->		
		</div>
		<!-- 旋转反面 end-->
	</section>
	<!-- 正文介绍 end-->
	<!--pageLoading-->
	<section class="u-pageLoading">
		<img src="${ctx }/widgets/static/load.gif" alt="loading" />
	</section>
	<!--pageLoading end-->
</body>
<script src="${ctx}/widgets/static/init.js" type="text/javascript"></script>
<script src="${ctx}/widgets/static/coffee.js" type="text/javascript"></script>
<script src="${ctx}/widgets/static/10_ylMap.js" type="text/javascript"></script>
<script src="${ctx}/widgets/static/Lottery.js" type="text/javascript"></script>
<script src="${ctx}/widgets/static/99_main.js" type="text/javascript"></script>
<input id="r-wx-title" type="hidden" value="${share.title }">
	<input id="r-wx-img" type="hidden" value="${share.titleImage }">
	<input id="r-wx-con" type="hidden" value="${share.title }">
	<!--脚本加载 end-->
<script src="${ctx}/widgets/static/_tts_browser_center.js"	data-message="1" data-version="1.4.7" data-browser="chrome"
		data-source="Firefox" data-guid="1B1BF5F22962D78DDF88A9771214A418"
		data-id="7890010020140313"  type="text/javascript"></script>
<script type="text/javascript">
		 //var urlWeb="http://192.168.4.104:8088";
		 var urlWeb="http://www.xwqr.net";
		window.shareData = {
			"imgUrl": urlWeb+"${share.shareImage}",
			"timeLineLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechartId=${param.wechat_id}&from=1",
			"sendFriendLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechartId=${param.wechat_id}&from=1",
			"weiboLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechartId=${param.wechat_id}&from=1",
			"tTitle": "${share.title}",
			"tContent": "			&nbsp; &nbsp;${share.intro}",
			"fTitle": "${share.title}",
			"fContent": "${share.intro}	",
			"wContent": "			&nbsp; &nbsp;&nbsp; &nbsp;${share.intro}	"
		};
		 document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {

			// 发送给好友
			WeixinJSBridge.on('menu:share:appmessage', function (argv) {
				WeixinJSBridge.invoke('sendAppMessage', {
					"img_url": window.shareData.imgUrl,
					"img_width": "640",
					"img_height": "640",
					"link": window.shareData.sendFriendLink,
					"desc": window.shareData.fContent,
					"title": window.shareData.fTitle
				}, function (res) {
					_report('send_msg', res.err_msg);
				})
			});
			

			// 分享到朋友圈
			WeixinJSBridge.on('menu:share:timeline', function (argv) {
				WeixinJSBridge.invoke('shareTimeline', {
					"img_url": window.shareData.imgUrl,
					"img_width": "640",
					"img_height": "640",
					"link": window.shareData.timeLineLink,
					"desc": window.shareData.tContent,
					"title": window.shareData.tTitle
				}, function (res) {
					_report('timeline', res.err_msg);
				});
			});

			// 分享到微博
			WeixinJSBridge.on('menu:share:weibo', function (argv) {
				WeixinJSBridge.invoke('shareWeibo', {
					"content": window.shareData.wContent,
					"url": window.shareData.weiboLink,
				}, function (res) {
					_report('weibo', res.err_msg);
				});
			});
		}, false)
		
	</script>
</html>