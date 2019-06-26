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
<title>会员卡领取</title>
</head>
<body>
 <%--  <div class="head">
    <div  class="title">瑞一奇瑞会员卡领取</div>
    <div  class="titlePhone"><a href="tel:02887462277"><img src="${ctx }/images/weixin/phoneIcon.png"></a></div>
    <div class="clear"></div>
  </div> --%>
  <div style="margin: ">
  		<img alt="" src="${ctx }/images/weixin/memberCar.png" width="100%" >
  </div>
  <div style="margin:12px 23px;">
  		<div style="padding: 8px 20px;background-color:#eb6100;color: #FFF;text-align: center;float: right;border-radius:5px;" onclick="window.location.href='${ctx}/memberWeixin/applyMemberCard?wechat_id=${wechat_id }'">
  			<a >点击领取</a>
  		</div>
  		<div class="clear"></div>
  </div>
  <div class="formContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;margin-bottom: 35px;">
  		<div style="margin-top:-14px;border-bottom: 1px solid #cdcdcd;background: -moz-linear-gradient(top, #f2f2f2, #d9d9d9);background:-webkit-gradient(linear, 0 0,0 90, from(#f1f1f1), to(#d9d9d9));height: 45px;border-top-left-radius:5px;border-top-right-radius:5px;line-height: 45px;">
  			<h3 style="padding-left: 12px;font-size: 14px;font-weight: bold;">会员卡申请说明</h3>
  		</div>
  		<div style="text-indent: 12px;margin: 20px 0px;">
  			<p>1、会员可以查看积分记录</p>
  			<p>2、会员可以积分兑换商品</p>
  			<p>3、会员可以查看预约记录</p>
  			<p>4、会员可以享受绿色通道</p>
  		</div>
  		<div style="text-indent: 12px;margin-top: 20px;margin-bottom:  30px;">
  			<p>电话号码：<a href="tel:400-8222662">&nbsp;&nbsp;028-87464321</a></p>
  			<p>公司地址：<a href="javascript:void(-1)" onclick="window.location.href='http://api.map.baidu.com/marker?location=30.723734,103.998875&title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&content=四川省成都市金牛区兴科中路&output=html'">
	  				成都市金牛区兴科中路36号
	  			</a>
  			</p>
	  		<p style="padding-left: 80px;">(点击地址进入GPS导航)</p>
  		</div>
  </div>
</body>
</html>
