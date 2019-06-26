<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.cookie.js"></script>
<style type="text/css">
	.body {
    display: block;
    font-size: 12px;
    margin: auto;
    max-width: 640px;
    min-height: 100%;
    min-width: 320px;
    position: relative;
}
#mcover {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.7);
    height: 100%;
    display:none;
    left: 0;
    position: fixed;
	bottom:0;    
    width: 100%;
    z-index: 20000;
}
#mcover img {
    height: 180px;
    position: fixed;
    right: 28px;
    bottom: 38px;
    width: 260px;
    z-index: 20001;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	var showNum=$.cookie("showNum");
	if(null==showNum||showNum==undefined){
		document.getElementById('mcover').style.display='block';
		$.cookie("showNum",1,{expires:1});
	}
})
</script>
<title>瑞一奇瑞会员卡中心</title>
</head>
<body  style="background-image: url('');">
<div>
<div id="mcover" onclick="document.getElementById('mcover').style.display='';"><img src="${ctx }/images/weixin/guideMember.png"></div>
  <div style="margin: ">
  		<img alt="" src="${ctx }/images/weixin/memberCar.png" width="100%" >
  </div>
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='http://ystech.co/app.php/module/3g/mobile/view/10035/1925/'">
  		<div style="float: left;"><h3>瑞一奇瑞会员章程</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/weixinIndex/index?bussiId=2&wechat_id=${param.wechat_id}&menu=1'">
  		<div style="float: left;"><h3 >积分换礼</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/coupon?wechat_id=${param.wechat_id}&bussiId=2'">
  		<div style="float: left;"><h3>领优惠券</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div> 
  </div> 
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/memberInfo?wechat_id=${param.wechat_id}'">
  		<div style="float: left;"><h3>完善会员资料</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div>

  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" >
  		<div style="float: left;"><h3>电话号码：<a href="tel:02887464321" style="font-family: '微软雅黑'">&nbsp;&nbsp;028-87464321</a></h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div>
   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;margin-bottom: 43px;">
  		<div style="float: left;">
  		<h3 style="overflow: hidden;">公司地址：
  				<a href="javascript:void(-1)" style="font-size: 12px;" onclick="window.location.href='http://api.map.baidu.com/marker?location=30.723734,103.998875&title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&content=四川省成都市金牛区兴科中路&output=html'">
					成都市金牛区兴科中路36号
				</a>
		</div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div>
<!--   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;margin-bottom: 43px;"
	  <div >
			<p>电话号码：<a href="tel:028-87464321">&nbsp;&nbsp;028-87464321</a></p>
			<p>公司地址：<a href="javascript:void(-1)" onclick="window.location.href='http://api.map.baidu.com/marker?location=30.723734,103.998875&title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&content=四川省成都市金牛区兴科中路&output=html'">
					成都市金牛区兴科中路36号
				</a>
			</p>
			<p style="padding-left: 80px;">(点击地址进入GPS导航)</p>
	 </div>
 </div> -->
   
 </div>
</body>
</html>
