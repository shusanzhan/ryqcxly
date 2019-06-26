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
    	.slide{
    		height: 100%;
    	}
    	.slide .slide-desc{
    		padding: 0px;
    	}
    	.icon_lists{
    	}
    	.slide .dot .cur {
    		background-color: #FFF;
    		border: 1px solid #FFF;
    	}
	     .icon_lists li{
	        float:right;
	        width: 24px;
	        height:24px;
	        text-align: center;
	        list-style-type:none;
	        position:relative;
	        border-radius:12px;
	        border: 1px solid #FFF;
	        margin-right:15px;
	        margin-top: 10px;
	    }
	    .icon_lists li a{
	    	margin-top: -20px;display: block;font-size: 12px;color: #FFF;
	    }
	    #music{
	    	border: 1px solid #18b4ed;
	    }
	    #music span{
	    	color: #18b4ed
	    }
	    .icon_lists .icon{
	        font-size: 12px;
	        line-height:24px;
	        color:#FFF;
	        display: block;
	    }
	    .icon_lists .icon:hover{
	        font-size:12px;
	    }
	    .weui-grids{
	    	margin-top:12px;
	    	width: 100%; 
	    	margin: 0 auto;
	    }
	    .weui-grid{
	    	width: 50%;
	    }
	    .weui-grid 	.icon{
	        font-size: 24px;
	        line-height:40px;
	        display: block;
	    }
	    .boss1 {
	    	position: absolute;
			left: 50%;
			width: 3.7rem;
			height: 3.7rem;
			border-radius: 50%;
			-webkit-transform: translate(-50%, -80%);
			-moz-transform: translate(-50%, -80%);
			-ms-transform: translate(-50%, -90%);
			-o-transform: translate(-50%, -80%);
			transform: translate(-50%, -80%);
			z-index: 990;
		}
		.boss-img {
		    width: 100%;
		    height: 100%;
		    z-index: 10000;
		    border-radius: 50%;
		}
		.weui-grids{
			border-bottom: none;
			border-top: none;
		}
		.weui-grids::after {
		    border-left: none;
		}
		.weui-grids::before {
		    border-top: none;
		}
		.grid{
			color: #FFF;
			border-bottom: none;
		}
		.grid:before {
		    border-right:none;
		}
		
		.grid:after {
		    border-bottom:none;
		}
		.weui-grid__icon{
			width: 50px;
			height: 50px;
			background-color: #fb6969;
			border-radius: 50%;
			text-align: center;line-height: 50px;
		}
		.weui-grid__label{
			color: #8e8e93;
			font-size: 12px;
		}
		.conte{
			padding-left: 12px;
			padding-right: 12px;
			border-top: 1px solid #d1d5da;
		}
   	</style>
<title>个人名片</title>
</head>
<body>
<div style="position: relative;">
	<div class="slide" id="slide1">
		<c:set value="${fn:length(bussiBanners) }" var="num"></c:set>
	      <ul>
	      	<c:forEach var="bussiBanner" items="${bussiBanners }" varStatus="">
	           <li onclick="window.open('${bussiBanner.url}')'">
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
	<div class="boss1">
		<img class="boss-img" src="${bussiCard.centerPicture }?" alt="">
	</div>
</div>
<br>
<%-- <div class="slide" id="slide1">
       <ul>
           <li>
               <a href="javascript:;">
                   <img src='${bussiCard.picture }' alt="" id="headerPicture">
               </a>
               <div class="slide-desc" style="height: 60px;border-top-right-radius:20px;border-top-left-radius:20px;">
               		<div class="weui-flex">
					    <div class="weui-flex__item" style="text-align: left;padding-left: 10px;">
					    	<div style="padding:5px;">
					    		<h3 style="font-weight:normal;">${enterprise.name }</h3>
					    		<h5 style="font-weight:normal;font-size: 12px;">${bussiCard.name } ${bussiCard.position }</h5>
					    	</div>
					    </div>
					    <div class="weui-flex__item" style="text-align: left;padding-right: 10px;">
					    	<ul class="icon_lists clear" style="position: relative;line-height: 60px;">
					    		<li style="margin-right: 5px;" id="music" class="play">
					    			<span class="icon icon-107" ></span>
					    			<a style="margin-top: -20px;display: block;font-size: 12px;">音乐</a>
					    		</li>
					    		<li onclick="window.location.href='${ctx}/bussiCardWechat/leaveMessage?cardCode=${bussiCard.code }&code=${param.code }'">
					    			<span class="icon icon-80"></span>
					    			<a style="">留言</a>
					    		</li>
					    	</ul>
					    </div>
					</div>
               </div>
           </li>
       </ul>
   </div>
   <br> --%>
<div class="conte">
	<div class="weui-grids grids-small">
	   <a href="tel:${bussiCard.mobilePhone }" class="grid" onclick="clickRecord('${ctx}/bussiCardWechat/clickRecord?cardCode=${bussiCard.code}&type=1')">
	       <div class="weui-grid__icon">
	           <span class="icon icon-104"></span>
	       </div>
	       <p class="weui-grid__label">
	           一键拨号
	       </p>
	   </a>
	   <a href="javascript:void(-1);" id="sd4"  class="grid" onclick="clickRecord('${ctx}/bussiCardWechat/clickRecord?cardCode=${bussiCard.code}&type=2')">
	       <div class="weui-grid__icon">
	           <span class="icon icon-36"></span>
	       </div>
	       <p class="weui-grid__label">
	           一键加我
	       </p>
	   </a>
	   <a href="${ctx}/bussiCardWechat/leaveMessage?cardCode=${bussiCard.code }&code=${param.code }"  class="grid" onclick="">
	       <div class="weui-grid__icon">
	          <span class="icon icon-110"></span>
	       </div>
	       <p class="weui-grid__label">
	           给我留言
	       </p>
	   </a>
	   <a href="javascript:;" class="grid" onclick="urlEddncode('${enterprise.point }','${enterprise.name }','${enterprise.address }');clickRecord('${ctx}/bussiCardWechat/clickRecord?cardCode=${bussiCard.code}&type=4')">
	        <div class="weui-grid__icon">
	            <span class="icon icon-69"></span>
	        </div>
	        <p class="weui-grid__label">
	            一键导航
	        </p>
	    </a>
	</div>
</div>
<br>
<ul class="weui-mark">
    <li onclick="window.location.href='https://dealer.m.autohome.com.cn/2030686/'">
        <div class="weui-mark-img">
            <img src="${ctx }/images/bussiCard/car.png">
        </div>
        <div class="weui-mark-meta">
            <div class="weui-mark-title"><a href="javascript:;"></a></div>
        </div>
    </li>
    <li onclick="window.location.href='${ctx }/bussiCardWechat/onlineBooking?code=${param.code}'">
        <div class="weui-mark-img">
            <img src="${ctx }/images/bussiCard/noline.png">
        </div>
        <div class="weui-mark-meta">
            <div class="weui-mark-title"><a href="javascript:;"></a></div>
        </div>
    </li>
    <li onclick="window.location.href='${ctx }/recommendCustomerWechat/recommendCustomer?code=${param.code}'">
        <div class="weui-mark-img">
            <img src="${ctx }/images/bussiCard/recommend.png">
        </div>
        <div class="weui-mark-meta">
            <div class="weui-mark-title"><a href="javascript:;"></a></div>
        </div>
    </li>
     <li onclick="window.location.href='${ctx }/agentWechat/jionIn?code=${param.code}'">
       <div class="weui-mark-img">
           <img src="${ctx }/images/bussiCard/agent.png">
       </div>
       <div class="weui-mark-meta">
           <div class="weui-mark-title"><a href="javascript:;"></a></div>
       </div>
   </li>
    <c:forEach var="corporateCulture" items="${corporateCultures }">
	   <li onclick="window.location.href='${ctx}/corporateCultureWechat/read?corporateCultureId=${corporateCulture.dbid}&code=${param.code}'">
	        <div class="weui-mark-img">
	            <img src="${corporateCulture.picture }">
	        </div>
	       <%-- <span class="weui-mark-rt bg-blue"> ${corporateCulture.corporateCultureType.name }</span> --%>
	        <c:if test="${corporateCulture.topStatus==2 }">
	         <div class="weui-mark-vip"><span class="weui-mark-lt bg-red">new</span></div>
	        </c:if>
	        <div class="weui-mark-meta">
	            <div class="weui-mark-title"><a href="javascript:;">${corporateCulture.title }</a></div>
	        </div>
	    </li>
	</c:forEach>
</ul>
<br>
<div class="weui-footer">
    <p class="weui-footer__text">Copyright © 易成至达网络科技</p>
</div>
<audio controls="controls" id="audio" autoplay style="display: none">
	<source src="${bussiCard.backGroundMusic.url}" />
</audio>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.js?"></script>
 
 <script type="text/javascript">
 var message='<div class="modal-content" style="text-align: center;">'+
			'<img alt="" src="${bussiCard.wechatQrCode}" style="margin: 0 auto;width: 90%;" id="imgAddme1">'+
			'<img alt="" src="${ctx }/images/bussiCard/qrcodefor.jpg" style="margin: 0 auto;width: 90%;display:none;" id="imgAddme2">'+
			'<p>长按识别二维码</p><br>'+
			 '<a href="javascript:;" class="weui-btn  b-blue" style="width: 80%;" onclick="addMe(1)" id="aAddme1">个人微信</a>'+
			 '<a href="javascript:;" class="weui-btn bg-blue" style="width: 80%;"  onclick="addMe(2)" id="aAddme2">瑞一公众号</a>'+
		'</div>';
 var vccard='<div class="modal-content" style="text-align: center;">'+
			'<img alt="" src="${bussiCard.bussiCardQrCode}" style="margin: 0 auto;width: 90%;" >'+
			'<p>识别二维码，保存到本机通讯录</p><br>'+
		'</div>';
//音频播放
var audio = document.getElementById("audio");
if('1' == 1) {
	var fly = false;
	//微信自动加载完  audio 自动播放
	document.addEventListener('DOMContentLoaded', function() {
		function audioAutoPlay() {
			var audio = document.getElementById('audio');
			audio.play();
			document.addEventListener("WeixinJSBridgeReady", function() {
				audio.play();
			}, false);
		}
		audioAutoPlay();
	});
} else {
	var fly = true;
}

$('.play').on('touchstart', function() {
	if(fly) {
		$(this).attr('id', 'music');
		audio.play();
		fly = false;
	} else {
		$(this).attr('id', '');
		audio.pause();
		fly = true;
	}
});
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
     $(document).on("click", "#sd4", function() {
         $.modal({
             title: "",
             text: message,
             buttons: [
                 { text: "关闭", className: "default", onClick: function(){ console.log(3)} },
             ]
         });
     });
     $(document).on("click", "#sd5", function() {
         $.modal({
             title: "长按识别二维码",
             text:  vccard,
             buttons: [
                 { text: "关闭", className: "default", onClick: function(){ console.log(3)} },
             ]
         });
     });
 })
function addMe(value){
	$("#imgAddme"+value).show();
	$("#aAddme"+value).removeClass("bg-blue").addClass("b-blue");
	if(value==1){
		$("#imgAddme2").hide();	 
		$("#aAddme2").addClass("bg-blue").removeClass("b-blue");
	}
	if(value==2){
		$("#aAddme1").addClass("bg-blue").removeClass("b-blue");
		$("#imgAddme1").hide();	 
	}
}
 function urlEddncode(point,name,content){
	    var url="http://api.map.baidu.com/marker?location="+point+"&title="+name+"&content="+content+"&output=html";
		url=encodeURI(url);
		window.location.href=url;
}
function clickRecord(url){
	$.post(url,{date:new Date()},function(data){
		
	})
}
</script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var url = document.URL;
var imgUrl="http://"+document.domain+"${bussiCard.picture}";
window.shareData = {
	"imgUrl": imgUrl,
	"link": url,
	"title": "${enterprise.name } ${bussiCard.name} 个人名片",
	"intro": "买奇瑞一定到来瑞一看看 ${bussiCard.name} 个人名片"
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
	$.post("${ctx}/bussiCardWechat/shareRecord?cardCode=${bussiCard.code}",{date:new Date()},function(data){
		
	})
}
</script>
</html>