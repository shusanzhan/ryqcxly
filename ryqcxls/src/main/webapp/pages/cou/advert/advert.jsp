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
<script src="${ctx}/widgets/static/_tts_browser_center.js"	 type="text/javascript"></script>
<input id="r-wx-title" type="hidden" value="${share.title }">
	<input id="r-wx-img" type="hidden" value="${share.titleImage }">
	<input id="r-wx-con" type="hidden" value="${share.title }">
	<!--脚本加载 end-->
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
		 //var urlWeb="http://192.168.1.235:8090";
		 var urlWeb="http://www.xwqr.net";
		window.shareData = {
			"imgUrl": urlWeb+"${share.shareImage}",
			"link": urlWeb+"/shareWeixin/share?wechat_id=${param.wechat_id}",
			"title": "${share.title}",
			"intro": "${share.intro}"
		};
		wx.config({
		    debug: false,
		    appId: '${weixin.appId}',
		    timestamp: '${weixin.timestamp}',
		    nonceStr: '${weixin.nonceStr}',
		    signature: '${weixin.signature}',
		    jsApiList: [
		      'checkJsApi',
		      'onMenuShareTimeline',
		      'onMenuShareAppMessage',
		      'onMenuShareQQ',
		      'onMenuShareWeibo'
		    ]
		});
	   function ajaxUpdate(){
        	$.post('${ctx}/shareWeixin/updateShare',{'wechat_id':'${param.wechat_id}','dbid':'${share.dbid}'},function (data){
        		if(data=='success'){
					//分享成功        			
        		}else{
        			//分享失败
        		}
        	})
        }
        /*
         * 注意：
         * 1. 所有的JS接口只能在公众号绑定的域名下调用，公众号开发者需要先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。
         * 2. 如果发现在 Android 不能分享自定义内容，请到官网下载最新的包覆盖安装，Android 自定义分享接口需升级至 6.0.2.58 版本及以上。
         * 3. 完整 JS-SDK 文档地址：http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html
         *
         * 如有问题请通过以下渠道反馈：
         * 邮箱地址：weixin-open@qq.com
         * 邮件主题：【微信JS-SDK反馈】具体问题
         * 邮件内容说明：用简明的语言描述问题所在，并交代清楚遇到该问题的场景，可附上截屏图片，微信团队会尽快处理你的反馈。
         */
        wx.ready(function () {
          // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
            wx.checkJsApi({
              jsApiList: [
                'getNetworkType',
                'previewImage'
              ],
              success: function (res) {
                //alert(JSON.stringify(res));
              }
            });

          // 2. 分享接口
          // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareAppMessage({
              title: window.shareData.title,
              desc:  window.shareData.intro,
              link: window.shareData.link,
              imgUrl: window.shareData.imgUrl,
              trigger: function (res) {
                // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
               // alert('用户点击发送给朋友');
              },
              success: function (res) {
                //alert('已分享');
                ajaxUpdate();
              },
              cancel: function (res) {
                //alert('已取消');
              },
              fail: function (res) {
                alert(JSON.stringify(res));
              }
            });

          // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareTimeline({
           	 	title: window.shareData.title,
                link: window.shareData.link,
                imgUrl: window.shareData.imgUrl,
              trigger: function (res) {
                // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
                //alert('用户点击分享到朋友圈');
              },
              success: function (res) {
                //alert('已分享');
            	  ajaxUpdate();
              },
              cancel: function (res) {
                //alert('已取消');
              },
              fail: function (res) {
                alert(JSON.stringify(res));
              }
            });

          // 2.3 监听“分享到QQ”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareQQ({
            	 title: window.shareData.title,
                 desc:  window.shareData.intro,
                 link: window.shareData.link,
                 imgUrl: window.shareData.imgUrl,
              trigger: function (res) {
                //alert('用户点击分享到QQ');
              },
              complete: function (res) {
                //alert(JSON.stringify(res));
              },
              success: function (res) {
                //alert('已分享');
                ajaxUpdate();
              },
              cancel: function (res) {
                alert('已取消');
              },
              fail: function (res) {
               // alert(JSON.stringify(res));
              }
            });
          
          // 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
            wx.onMenuShareWeibo({
            	 title: window.shareData.title,
                 desc:  window.shareData.intro,
                 link: window.shareData.link,
                 imgUrl: window.shareData.imgUrl,
              trigger: function (res) {
                //alert('用户点击分享到微博');
              },
              complete: function (res) {
               // alert(JSON.stringify(res));
              },
              success: function (res) {
                //alert('已分享');
            	  ajaxUpdate();
              },
              cancel: function (res) {
                //alert('已取消');
              },
              fail: function (res) {
               // alert(JSON.stringify(res));
              }
            });

        });

        wx.error(function (res) {
          alert(res.errMsg);
        });
	</script>
</html>