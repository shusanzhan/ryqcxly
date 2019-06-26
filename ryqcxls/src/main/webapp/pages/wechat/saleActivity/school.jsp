<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="${ctx }/css/weixin/skdslider.css" type="text/css" />
<link href="${ctx }/css/saleActivity/index.css" type="text/css" rel="stylesheet"/>
<title>新瑞虎5 为爱前行 公益活动</title>
</head>
<body>
<div class="header">
	<img src="${saleActivity.frontImage }" alt="${ saleActivity.frontImage}" >
</div>
<div class="detail">
	<div class="proj">
		<div class="tt">
			<div class="bb">${school.title }</div>
			<div class="arr fr">
			</div>
		</div>
		<div class="desc" >
			${school.content }
		</div>
	</div>
</div> 
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var urlWeb="http://www.xwky.xwqr.net";
window.shareData = {
	"imgUrl": urlWeb+"/images/img.jpg",
	"link": urlWeb+"/saleActivityWechat/index?code=957655ab3fcde4f5d8a7a2d54f85a115",
	"title": "新瑞虎5 为爱前行 公益活动",
	"intro": "新瑞虎5 为爱前行 公益活动"
}; 
wx.hideOptionMenu();
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
/*
 * 注意：
 * 1. 所有的JS接口只能在公众号绑定的域名下调用，公众号开发者需要先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。
 * 2. 如果发现在 Android 不能分享自定义内容，请到官网下载最新的包覆盖安装，Android 自定义分享接口需升级至 6.0.2.58 版本及以上。
 * 3. 完整 JS-SDK 文档地址：http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html
 */
wx.ready(function () {
  // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
  	wx.hideOptionMenu();
    wx.checkJsApi({
      jsApiList: [
        'getNetworkType',
        'previewImage'
      ],
      success: function (res) {
    	  //alert(res);
      }
    });

  // 2. 分享接口
  // 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
    wx.onMenuShareAppMessage({
      title: window.shareData.title,
      desc: window.shareData.intro,
      link: window.shareData.link,
      imgUrl: window.shareData.imgUrl,
      trigger: function (res) {
        // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
       // alert('用户点击发送给朋友');
      },
      success: function (res) {
       	 alert('感谢您的参与分享，您已成功为山区孩子捐赠1元免费午餐');
      },
      cancel: function (res) {
    	  alert('很遗憾，您取消了分享，孩子们需要你的帮助');
      },
      fail: function (res) {
        alert(JSON.stringify(res));
      }
    });

  // 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口/images/xwqr/logo.jpg
    wx.onMenuShareTimeline({
   	 	title:  window.shareData.title,
        link: window.shareData.link,
        imgUrl: window.shareData.imgUrl,
      trigger: function (res) {
        // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
        //alert('用户点击分享到朋友圈');
      },
      success: function (res) {
        //alert('已分享');
    	  alert('感谢您的参与分享，您已成功为山区孩子捐赠1元免费午餐');
      },
      cancel: function (res) {
    	  alert('很遗憾，您取消了分享，孩子们需要你的帮助');
        //alert('已取消');
      },
      fail: function (res) {
        //alert(JSON.stringify(res));
      }
    });

  // 2.3 监听“分享到QQ”按钮点击、自定义分享内容及分享结果接口
    wx.onMenuShareQQ({
    	 title:  window.shareData.title,
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
    	  alert('感谢您的参与分享，您已成功为山区孩子捐赠1元免费午餐');
      },
      cancel: function (res) {
    	  alert('很遗憾，您取消了分享，孩子们需要你的帮助');
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
 	//alert(res.errMsg);
});
</script>
</html>