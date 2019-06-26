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
    <style type="text/css">
    	.weui-c-nickname a{
    		color: #fb6969;
    	}
    </style>
<title>${corporateCulture.corporateCultureType.name}</title>
</head>
<body>
<div class="weui-content">
    <div class="weui-c-inner">
 <div class="weui-c-content">
      <h2 class="weui-c-title">${corporateCulture.title }</h2>
     <div class="weui-c-meta">
         <span class="weui-c-nickname"><a href="javascript:;">${corporateCulture.creator }</a></span>
         <em class="weui-c-nickname">
         	<fmt:formatDate value="${corporateCulture.realessTime }" pattern="yyyy-MM-dd HH:mm:ss"/> 
         </em>
     </div>
     <div class="weui-c-article">
     	${corporateCulture.content }
     </div>
 </div>
  <div class="weui-c-tools">
      <div class="weui-c-readnum">阅读<span id="readnum">${corporateCulture.pvNum}${corporateCulture.pvNum>10000?'+':'' }</span></div>
      <div class="weui-c-like" style="color: #fb6969">
	      <i class="icon ${empty(corporateCultureRecord)==true?'':'on' }" style="color: #fb6969"></i>
          <span id="likenum">${corporateCulture.praiseNum}</span>
      </div>
  </div>
 </div>
</div>

<br>
<div class="weui-footer">
    <p class="weui-footer__links">
        <a href="${ctx }/corporateCultureWechat/corporateCulture?code=${param.code}&cardCode=${param.cardCode}" class="weui-footer__link">企业中心</a>
    </p>
    <p class="weui-footer__text">Copyright © 易成至达网络科技</p>
</div>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.min.js"></script>
 <script type="text/javascript">
 $(function(){
     $(".weui-c-like .icon").click(function(){
         var likenum=parseInt($("#likenum").text());
         if($(this).hasClass('on')) {
             $(this).removeClass('on');
             praise(2);
             likenum=likenum-1;
             $("#likenum").text(likenum);
         }else{
             $(this).addClass('on');
             likenum=likenum+1;
             $("#likenum").text(likenum);
             praise(1);
         }
     })
 });
 function praise(value){
	 $.post('${ctx}/corporateCultureWechat/saveParseCorporateCultureRecord?corporateCultureId=${corporateCulture.dbid}&type='+value+'&dateTime='+new Date(),{},function(data){
	 })
}
 </script>
 <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var url = document.URL;
var imgUrl="http://"+document.domain+"${corporateCulture.picture}";
window.shareData = {
	"imgUrl": imgUrl,
	"link": url,
	"title": "${corporateCulture.title}",
	"intro": "${corporateCulture.description} "
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
/*
 * 注意：
 * 1. 所有的JS接口只能在公众号绑定的域名下调用，公众号开发者需要先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。
 * 2. 如果发现在 Android 不能分享自定义内容，请到官网下载最新的包覆盖安装，Android 自定义分享接口需升级至 6.0.2.58 版本及以上。
 * 3. 完整 JS-SDK 文档地址：http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html
 */
wx.ready(function () {
  // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
    wx.checkJsApi({
      jsApiList: [
        'getNetworkType',
        'previewImage'
      ],
      success: function (res) {
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
    	  shareCallBack();
      },
      cancel: function (res) {
        //alert('已取消');
      },
      fail: function (res) {
        alert(JSON.stringify(res));
      }
    });

  // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口/images/xwqr/logo.jpg
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
    	  shareCallBack();
      },
      cancel: function (res) {
        //alert('已取消');
      },
      fail: function (res) {
        //alert(JSON.stringify(res));
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
        alert(JSON.stringify(res));
      },
      success: function (res) {
    	  shareCallBack();
      },
      cancel: function (res) {
        alert('已取消');
      },
      fail: function (res) {
        alert(JSON.stringify(res));
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
        alert(JSON.stringify(res));
      },
      success: function (res) {
    	  shareCallBack();
      },
      cancel: function (res) {
        //alert('已取消');
      },
      fail: function (res) {
        alert(JSON.stringify(res));
      }
    });

});

wx.error(function (res) {
  alert(res.errMsg);
});
function shareCallBack(){
	$.post("${ctx}/corporateCultureWechat/shareRecord?corporateCultureId=${corporateCulture.dbid}",{date:new Date()},function(data){
		
	})
}
</script>
</html>