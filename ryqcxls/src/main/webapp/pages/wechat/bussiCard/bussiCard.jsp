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
    <style type="text/css">
    	.slide .music{
			    position: absolute;
			    right: 10px;
			    top: 10px;
			    z-index: 5;
			    font-size: 0;
		}
   	</style>
<title>${enterprise.name } ${bussiCard.name }个人名片</title>
</head>
<body>
<div style="position: relative;">
	<div class="slide" id="slide1">
		<c:set value="${fn:length(bussiBanners) }" var="num"></c:set>
	      <ul>
	      	<c:forEach var="bussiBanner" items="${bussiBanners }" varStatus="">
	           <li onclick="">
	               <a href="javascript:;">
	                   <img src='${bussiBanner.picture }' alt="">
	               </a>
	           </li>
	      	</c:forEach>
	      </ul>
	      <div class="music">
	      	<span class="icon icon-52 play" style="color:#fb6969"></span>
	      </div>
	      <div class="dot">
	      	<c:forEach begin="1" end="${num }">
	           <span></span>
	      	</c:forEach>
	      </div>
	</div>
	<div class="boss1">
		<img class="boss-img" src="${bussiCard.picture }?" alt="">
	</div>
</div>
<div style="position: relative;height: 60px;padding-top: 20px;">
	 <div style="text-align: center;width: 100%;">
	 	<p style="color: #161617;font-size:20px;font-weight: bold; ">${bussiCard.name }</p>
	 	<p style="color: #bcc0c8;font-size: 18px;font-weight: bold;">${bussiCard.position }</p>
	 	<h6 style="color: #bcc0c8;margin-top: 1px;font-size: 10px;">${bussiCard.enPosition }</h6>
	 </div>
	  <div style="">
	 	 <a href="javascript:void(-1);" style="padding-right:8px;float: right;margin-top: -90px;text-align: center;">
	 	 	   <div class="weui-like">
		           <span class="icon icon-${empty(bussiCardLike)==true?'65':'38' }" style="color:#fb6969;font-size: 20px "></span>
		       </div>
		       <p class="weui-grid__label" style="margin-top: -2px;" id="likenum">
		           ${bussiCard.likeNum }
		       </p>
		   </a>
		   <div style="clear: both;"></div>
	 </div>
</div>
<div class="conte" style="margin-top: 30px;">
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
<div class="agent" onclick="window.location.href='${ctx }/agentWechat/jionIn?code=${param.code}'">
	<div class="title">
		<span class="icon icon-52"></span>经纪人招募令
	</div>
	<div class="title_detail">
		<div class="title_detail_word">查看详情</div>
	</div>
</div>
<div class="weui-tab" id="t3" style="height:44px;">
    <div class="weui-navbar">
        <div class="tab-pink weui-navbar__item " onclick="setCookie(0)">
            精彩视频
        </div>
        <div class="weui-navbar__item" onclick="setCookie(1)">
            买车推荐
        </div>
    </div>
</div>
<div id="tab0" class="bg_item" style="margin-bottom: 50px;">
		<br>
		<ul class="weui-mark">
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
	    <div style="clear: both;"></div>
	    <br>
</div>
<div id="tab1" class="bg_item" style="display: none;margin-bottom: 50px;">
	<br>
	<ul class="weui-mark weui-car" style="padding-left: 0em;">
		<c:forEach var="carSeriy" items="${carSeriys }">
	        <li style="">
	            <div class="weui-mark-img" style="border-radius:10px;" onclick="window.location.href='${ctx }/carModelWechat/carModel?dbid=${carSeriy.dbid}'">
	                <img src="${carSeriy.picture }">
	            </div>
	            <div class="weui-mark-meta" >
	                <div class="weui-mark-title" style="text-align: left;font-size: 14px;"><a href="javascript:;" style="font-size: 14px;">${carSeriy.name }</a></div>
	                <div class="weui-mark-desc" style="font-size: 12px;">官方指导价：${carSeriy.priceFrom }</div>
	            </div>
	            <div class="weui-mark-meta" >
	                <div class="weui-mark-title" style="text-align: left;">
	                	<a href="javascript:;" style="color: #fb6969;font-size: 12px;">
		                	<c:if test="${empty(carSeriy.discInfor) }">
		                		&nbsp;
		                	</c:if>
		                	${carSeriy.discInfor }
	                	</a>
	                </div>
	                <div class="weui-mark-desc" style="display:flex; ">
	                	<div style="width: 50%;">
	                		<a class="carDetial" href="${ctx }/carModelWechat/carModel?dbid=${carSeriy.dbid}">
	                			详细信息
	                		</a>
	                	</div>
	                	<div style="width: 50%;">
	                		<c:if test="${bussiCard.type==1 }">
	                		 <a href="tel:${bussiCard.mobilePhone }" class="xunjia" >点我询价</a>
	                		</c:if>
	                		<c:if test="${bussiCard.type==2 }">
	                		 	<a href="tel:${enterprise.salerPhone }" class="xunjia" >点我询价</a>
	                		</c:if>
	                	</div>
	                </div>
	            </div>
	            
	        </li>
	    </c:forEach>
	 </ul>
	  <div style="clear: both;"></div>
	    <br>
</div>
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
<audio controls="controls" id="audio" autoplay style="display: none">
	<source src="${bussiCard.backGroundMusic.url}" />
</audio>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.js?"></script>
 <script type="text/javascript">
 $(function(){
	 var index=getCookie();
	 $('.bg_item').hide();
	 $("#tab"+index).show();
	 $('#t3').tab({
	     defaultIndex:index,
	     activeClass: 'tab-pink'
	 })
	 $(".weui-navbar__item").on("click",function(){
		var index=$(this).index();
		var bt=$('.bg_item');
		$('.bg_item').hide();
		$("#tab"+index).show();
	})
	$(".weui-like .icon").click(function(){
         var likenum=parseInt($("#likenum").text());
         if($(this).hasClass('icon-65')) {
             $(this).removeClass('icon-65');
             $(this).addClass('icon-38');
             praise(1);
             likenum=likenum+1;
             $("#likenum").text(likenum);
         }else{
        	 $(this).removeClass('icon-38');
             $(this).addClass('icon-65');
             likenum=likenum-1;
             $("#likenum").text(likenum);
             praise(2);
         }
     })
 })
 var message='<div class="modal-content" style="text-align: center;">'+
			'<img alt="" src="${bussiCard.wechatQrCode}" style="margin: 0 auto;width: 90%;" id="imgAddme1">'+
			'<img alt="" src="${ctx }/images/bussiCard/qrcodefor.jpg" style="margin: 0 auto;width: 90%;display:none;" id="imgAddme2">'+
			'<p>长按识别二维码</p><br>'+
			 '<a href="javascript:;" class="weui-btn  b-pink" style="width: 80%;" onclick="addMe(1)" id="aAddme1">个人微信</a>'+
			 '<a href="javascript:;" class="weui-btn bg-pink" style="width: 80%;"  onclick="addMe(2)" id="aAddme2">瑞一公众号</a>'+
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
		$(this).removeClass("icon-53");
		$(this).addClass("icon-52");
		$(this).attr('id', 'music');
		audio.play();
		fly = false;
	} else {
		$(this).removeClass("icon-52");
		$(this).addClass("icon-53");
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
	$("#aAddme"+value).removeClass("bg-pink").addClass("b-pink");
	if(value==1){
		$("#imgAddme2").hide();	 
		$("#aAddme2").addClass("bg-pink").removeClass("b-pink");
	}
	if(value==2){
		$("#aAddme1").addClass("bg-pink").removeClass("b-pink");
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
function setCookie(value){
	document.cookie="choiceValue="+value;
}
function getCookie(){
	var value=0;
	if (document.cookie.length>0){
	  var c_start=document.cookie.indexOf("choiceValue=")
	  if (c_start!=-1){ 
	    c_start=c_start + "choiceValue".length+1 
	    var c_end=document.cookie.indexOf(";",c_start)
	    if (c_end==-1){
		     c_end=document.cookie.length
	    }
	     value=unescape(document.cookie.substring(c_start,c_end))
	    } 
	  }
	return value;
}
function praise(value){
	 $.post('${ctx}/bussiCardWechat/saveBussiCardLike?cardCode=${bussiCard.code}&type='+value+'&dateTime='+new Date(),{},function(data){
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