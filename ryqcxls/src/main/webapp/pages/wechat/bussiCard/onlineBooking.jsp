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
    <link rel="stylesheet" href="${ctx }/weui-master/css/bussiCard.css?date=${now}"/>
    <style type="text/css">
    	.slide{
    		max-height: 100%;
    		min-height: 30%;
    	}
    	.slide .slide-desc {
    		text-align: left;
    	}
    	.navshow{
    		margin-top: -3px;
    	}
    	.itemshow{
    		padding: 12px;position: relative;margin-bottom: 12px;
    	}
    	.itemhide{
    		padding: 12px;position: relative;display: none;margin-bottom: 12px;
    	}
    	.navhide{
    		margin-top: -3px;display: none;
    	}
   	</style>
<title>在线预约</title>
</head>
<body>
<div style="position: relative;">
	<div class="slide" id="slide1">
		<c:set value="${fn:length(bussiBanners) }" var="num"></c:set>
	      <ul>
	      	<c:forEach var="bussiBanner" items="${bussiBanners }" varStatus="">
	           <li>
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
</div>
<div style="position: relative;;padding: 8px;padding-bottom: 12px;margin-top: 12px;">
	 <div style="text-align: center;width: 100%;width: 200px;margin: 0 auto;">
	 	<img alt="" src="${ctx }/images/bussiCard/godCustomer.png" width="80%">
	 </div>
	<div style="text-align: right;width: 100%;position: absolute;top:12px;right: 12px;" onclick="window.location.href='${ctx }/emergencyHelpWechat/emergencyHelp?code=${param.code }'">
		<img alt="" src="${ctx }/images/bussiCard/emerging.png"  width="70">
	</div>
</div>
<!-- 功能菜单 -->
<div style="display: flex;">
	<div class="corItem" onclick="changeOnline(1)">
        <div class="cortype blue servicesoron" id="cortype1">
            <img src="${ctx }/images/bussiCard/nian.png" alt="" width="" style="width: 60px;height: 50px;">
        </div>
	    <div class="navshow" id="nav1">
		    <img alt="" src="${ctx }/images/bussiCard/serviceNav.png" style="margin-top: -5px;" width="30">
		</div>
	</div>
	<div class="corItem" onclick="changeOnline(2)">
        <div class="cortype blue" id="cortype2">
            <img src="${ctx }/images/bussiCard/maint.png" alt="" width="" style="width: 60px;height: 50px;">
        </div>
	    <div class="navhide" id="nav2">
		    <img alt="" src="${ctx }/images/bussiCard/serviceNav.png" style="margin-top: -5px;" width="30">
		</div>
	</div>
	<div class="corItem" onclick="changeOnline(3)">
        <div class="cortype blue" id="cortype3">
            <img src="${ctx }/images/bussiCard/old.png" alt="" width="" style="width: 60px;height: 50px;">
        </div>
	    <div class="navhide" id="nav3">
		    <img alt="" src="${ctx }/images/bussiCard/serviceNav.png" style="margin-top: -5px;" width="30">
		</div>
	</div>
	<div class="corItem" onclick="changeOnline(4)">
        <div class="cortype blue" id="cortype4">
            <img src="${ctx }/images/bussiCard/trycar.png" alt="" width="" style="width: 60px;height: 50px;">
        </div>
	    <div class="navhide" style="" id="nav4">
		    <img alt="" src="${ctx }/images/bussiCard/serviceNav.png" style="margin-top: -5px;" width="30">
		</div>
	</div>
</div>
<div>
	<div id="item1" class="itemshow">
		<div style="font-size: 18px;color: #000;">
			年审预约
		</div>
		<div>
			<p> 1、请留下您的姓名，电话，需要年审车型、以及上户日期我们会在2小时内，主动联系您</p>
			<p> 2、费用说明：2年一检，无费用，6年一审车管所代收120元。</p>
			<p>	3、直接拨打<a href="tel:>${enterprise.eaxminPhone }">${enterprise.eaxminPhone }</a>预约</p>
		</div>
		<div style="text-align: right;width: 100%;" onclick="window.location.href='${ctx }/onlineBookingWechat/onlineBookingEaxmined?code=${param.code}'">
			<img alt="" src="${ctx }/images/bussiCard/onceOnline.png"  width="70">
		</div>
	</div>
	<div id="item2" class="itemhide">
		<div style="font-size: 18px;color: #000;">
			保养维修
		</div>
		<div>
			<p> 1、请留下您的姓名，电话，需要保养维修的车型以及车牌我们会在2小时内，主动联系您。</p>
			<p> 2、微信公众号提前一天预约，保养维修工时费8折。</p>
			<p>	3、直接拨打<a href="tel:>${enterprise.maintCarPhone }">${enterprise.maintCarPhone }</a>预约</p>
		</div>
		<div style="text-align: right;width: 100%;" onclick="window.location.href='${ctx}/onlineBookingWechat/onlineBookingSM?serviceType=1&code=${param.code }'">
			<img alt="" src="${ctx }/images/bussiCard/onceOnline.png"  width="70">
		</div>
	</div>
	<div id="item3" class="itemhide">
		<div style="font-size: 18px;color: #000;">
			旧车置换
		</div>
		<div>
			<p>1、请留下您的姓名，电话，需要置换的车型、行驶公里数等信息我们会在2小时内，主动联系您!</p>
			<p>2、直接拨打<a href="tel:>${enterprise.oldCarPhone }">${enterprise.oldCarPhone }</a>预约</p>
		</div>
		<div style="text-align: right;width: 100%;" onclick="window.location.href='${ctx }/onlineBookingWechat/onlineBookingOCC?code==${param.code}'">
			<img alt="" src="${ctx }/images/bussiCard/onceOnline.png"  width="70">
		</div>
	</div>
	<div id="item4" class="itemhide">
		<div style="font-size: 18px;color: #000;">
			试乘试驾
		</div>
		<div>
			<p>1、请留下您的姓名，电话，需要试驾的车型我会在2小时内，主动联系您</p>
			<p>	2、直接拨打<a href="tel:>${enterprise.tryCarPhone }">${enterprise.tryCarPhone }</a>预约</p>
		</div>
		<div style="text-align: right;width: 100%;" onclick="window.location.href='${ctx }/onlineBookingWechat/onlineBooking?code=${param.code }'">
			<img alt="" src="${ctx }/images/bussiCard/onceOnline.png"  width="70">
		</div>
	</div>
</div>
<br>
<br>
<div class="bottomCenter" style="background-color: #45b5b9;border: 3px solid #45b5b9">
<c:if test="${!empty(param.cardCode) }">
		<img alt="" src="${ctx }/images/bussiCard/service.png" onclick="window.location.href='${ctx}/bussiCardWechat/bussiCard?code=${param.code}&cardCode=${param.cardCode}'">
	</c:if>
	<c:if test="${empty(param.cardCode) }">
		<img alt="" src="${ctx }/images/bussiCard/service.png">
	</c:if>
</div>
<div class="weui-tab tab-bottom " style="height:44px;margin-top: 52px;">
        <div class="weui-tabbar" style="background-color: #45b5b9">
            <a href="${ctx }/bussiCardWechat/onlineBooking?code=${param.code}&cardCode=${param.cardCode}" class="weui-tabbar__item weui-bar__item_on">
                    <span style="display: inline-block;position: relative;">
		                <i class="icon  weui-tabbar__icon"><img alt="" src="${ctx }/images/bussiCard/online.png"></i>
                    </span>
                <p class="weui-tabbar__label">在线预约</p>
            </a>
            <a href="${ctx }/recommendCustomerWechat/recommendCustomer?code=${param.code}&cardCode=${param.cardCode}" class="weui-tabbar__item">
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
 function changeOnline(type){
	 $(".servicesoron").removeClass("servicesoron");
	 $("#cortype"+type).addClass("servicesoron");
	 $(".navshow").removeClass("navshow").addClass("navhide");
	 $("#nav"+type).removeClass("navhide").addClass("navshow");
	 $(".itemshow").removeClass("itemshow").addClass("itemhide");
	 $("#item"+type).removeClass("itemhide").addClass("itemshow");
}
</script>
</html>