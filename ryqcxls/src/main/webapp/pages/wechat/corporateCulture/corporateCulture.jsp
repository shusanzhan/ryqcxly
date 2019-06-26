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
     <link rel="stylesheet" href="${ctx }/weui-master/css/bussiCard.css?"/>
    <style type="text/css">
    	a{
    		color: #FFF
    	}
    	.grid{
    		background-color: #fb6969;
    		color: #FFF;
    		border-left: 2px solid #FFF;
    	}
    	.grid:FIRST-CHILD{
    		border-left:none;
    	}
    	.weui-grid__icon{
    		width: 60px;
    		height: 50px;
    	}
    	.weui-media-box{
    		padding: 12px;
    		background-color: #f5f5f5;
    	}
    	.weui-media-box::before{
    		left: 0;
    	}
		.weui-media-box_appmsg .weui-media-box__hd{
			width: 90px;
			height: 60px;
		}
   	</style>
<title>企业中心</title>
</head>
<body>
<div style="position: relative;">
	<div class="slide" id="slide1">
 		<c:set value="corporateCultu" var="corporateCultu"></c:set>
 		<c:set value="${fn:length(bussiBanners) }" var="num"></c:set>
        <ul>
        	<c:forEach var="bussiBanner" items="${bussiBanners }" varStatus="">
        		<c:set value="${bussiBanner }" var="corporateCultu"></c:set>
	            <li>
	                <a href="javascript:;">
	                    <img src='${bussiBanner.picture }' alt="">
	                </a>
	            </li>
        	</c:forEach>
        </ul>
        <div class="dot">
        	<c:forEach begin="1" end="${num }">
	            <span></span>
        	</c:forEach>
        </div>
    </div>
</div>
<div style="text-align: right;width: 100%;margin-top: 12px;" onclick="window.location.href='https://dealer.m.autohome.com.cn/vr/2030686/dealerm/index.html#pvareaid=2594125'">
	<img alt="" src="${ctx }/images/bussiCard/360.png" style="padding-right: 12px;" width="80">
</div>
<div style="position: relative;;padding: 8px;padding-bottom: 12px;">
	 <div style="text-align: center;width: 100%;width: 280px;margin: 0 auto;">
	 	<img alt="" src="${ctx }/images/bussiCard/gogo.png" width="100%">
	 </div>
</div>
<c:set var="type" value="${empty(param.type)==true?6:param.type }"></c:set>
<div style="display: flex;">
	<c:forEach var="corporateCultureType" items="${corporateCultureTypes }" end="3" >
		<div class="corItem" onclick="window.location.href='${ctx}/corporateCultureWechat/corporateCulture?code=${param.code}&type=${corporateCultureType.dbid }&cardCode=${param.cardCode}'">
	        <div class="cortype${corporateCultureType.dbid==type?' soron':'' }" >
	            <img src="${corporateCultureType.picture }" alt="" width="" style="width: 60px;height: 50px;">
	        </div>
		    <c:if test="${corporateCultureType.dbid==type}">
			    <div style="margin-top: -3px;">
				    <img alt="" src="${ctx }/images/bussiCard/nav.png" style="margin-top: -5px;" width="30">
				</div>
		    </c:if>
		</div>
    </c:forEach>
</div>
<div class="weui-panel__bd">
	<c:forEach var="corporateCulture" items="${corporateCultures }" varStatus="" >
            <a href="${ctx}/corporateCultureWechat/read?corporateCultureId=${corporateCulture.dbid}&code=${param.code}&cardCode=${param.cardCode}" class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <img class="weui-media-box__thumb" src="${corporateCulture.picture }" alt="">
                </div>
                <div class="weui-media-box__bd">
                    <h4 class="weui-media-box__title" style="font-size: 14px;">${corporateCulture.title }</h4>
                    <p class="weui-media-box__desc" style="font-size: 12px;">${corporateCulture.description }</p>
                </div>
            </a>
	</c:forEach>          
</div>
<br>
<br>
<br>
<div class="bottomCenter">
	<c:if test="${!empty(param.cardCode) }">
		<img alt="" src="${ctx }/images/bussiCard/center1.png" onclick="window.location.href='${ctx}/bussiCardWechat/bussiCard?code=${param.code}&cardCode=${param.cardCode}'">
	</c:if>
	<c:if test="${empty(param.cardCode) }">
		<img alt="" src="${ctx }/images/bussiCard/center1.png" >
	</c:if>
</div>
<div class="weui-tab tab-bottom " style="height:44px;margin-top: 52px;">
        <div class="weui-tabbar">
            <a href="${ctx }/bussiCardWechat/onlineBooking?code=${param.code}&cardCode=${param.cardCode}" class="weui-tabbar__item weui-bar__item_on">
                    <span style="display: inline-block;position: relative;">
		                <i class="icon  weui-tabbar__icon"><img alt="" src="${ctx }/images/bussiCard/online.png"></i>
                    </span>
                <p class="weui-tabbar__label">在线预约</p>
            </a>
            <a href="${ctx }/recommendCustomerWechat/recommendCustomer?code=${param.code}" class="weui-tabbar__item">
                <i class="icon  weui-tabbar__icon"><img alt="" src="${ctx }/images/bussiCard/recomm.png"></i>
                <p class="weui-tabbar__label">推荐购车</p>
            </a>
            <a href="javascript:;" class="weui-tabbar__item">
            </a>
            <a href="${ctx }/corporateCultureWechat/corporateCultureType?corporateCultureTypeId=5&code=${param.code}&cardCode=${param.cardCode}" class="weui-tabbar__item">
                    <span style="display: inline-block;position: relative;">
                        <i class="icon  weui-tabbar__icon"><img alt="" src="${ctx }/images/bussiCard/handCar.png"></i>
                    </span>
                <p class="weui-tabbar__label">精彩交车</p>
            </a>
            <a href="${ctx }/corporateCultureWechat/corporateCulture?code=${param.code}&cardCode=${param.cardCode}" class="weui-tabbar__item">
                <i class="icon  weui-tabbar__icon"><img alt="" src="${ctx }/images/bussiCard/copCenter.png"></i>
                <p class="weui-tabbar__label ">企业中心</p>
            </a>
        </div>
    </div>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.js?"></script>
<script type="text/javascript">
$(function(){
    $('#slide1').swipeSlide({
        autoSwipe:true,//自动切换默认是
        speed:3000,//速度默认4000
        continuousScroll:true,//默认否
        transitionType:'cubic-bezier(0.22, 0.69, 0.72, 0.88)',//过渡动画linear/ease/ease-in/ease-out/ease-in-out/cubic-bezier
        lazyLoad:true,//懒加载默认否
        firstCallback : function(i,sum,me){
            me.find('.dot').children().first().addClass('cur');
        },
        callback : function(i,sum,me){
            me.find('.dot').children().eq(i).addClass('cur').siblings().removeClass('cur');
        }
    });
})
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var url = document.URL;
var imgUrl="http://"+document.domain+"${corporateCultu.picture}";
window.shareData = {
	"imgUrl": imgUrl,
	"link": url,
	"title": "${enterprise.name } 企业形象",
	"intro": "${enterprise.name } 企业形象"
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
});
function shareCallBack(){
}
</script>
</html>