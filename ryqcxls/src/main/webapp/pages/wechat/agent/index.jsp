<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
    <!-- apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css?1" type="text/css" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    	.weui_panel_bd a{
	    	border-bottom: 1px solid #ddd;
    	}
    	.weui_media_box {
    padding: 10px;
    position: relative;
}

.weui_media_box.weui_media_appmsg .weui_media_hd {
	height: 50px;
	line-height: 50px;
	width: 50px;
}
    </style>
<title>瑞一经纪人</title>
</head>
<body>
<!-- <div class="title">
    <a class="btn-back" onclick="goBack()" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>全民经纪人</h3>
</div>
<br>
<br> -->
<div class="content">
    <div class="banner"><img src="${ctx }/img/weixin/prowzx_top.jpg" width="100%"></div>
</div>
<div class="weui_panel_bd">
    <a  href="${ctx }/recommendCustomerWechat/recommendCustomer" class="weui_media_box weui_media_appmsg">
        <div class="weui_media_hd">
            <img class="weui_media_appmsg_thumb" src="${ctx }/img/weixin/product_item28.png" alt=""  >
        </div>
        <div class="weui_media_bd">
            <h4 class="weui_media_title">推荐客户</h4>
            <p class="weui_media_desc"></p>
        </div>
        <div class="leftPre"></div>
    </a>
    <a href="${ctx }/agentWechat/memberCenter" class="weui_media_box weui_media_appmsg">
        <div class="weui_media_hd">
            <img class="weui_media_appmsg_thumb" src=" ${ctx }/img/weixin/product_item34.png" alt="" >
        </div>
        <div class="weui_media_bd">
            <h4 class="weui_media_title">个人中心</h4>
            <p class="weui_media_desc"></p>
        </div>
        <div class="leftPre"></div>
    </a>
     <a href="${ctx }/carModelWechat/carModelList" class="weui_media_box weui_media_appmsg">
        <div class="weui_media_hd">
            <img class="weui_media_appmsg_thumb" src="${ctx }/img/weixin/product_item39.png" alt="" >
        </div>
        <div class="weui_media_bd">
            <h4 class="weui_media_title">车型介绍</h4>
            <p class="weui_media_desc"></p>
        </div>
         <div class="leftPre"></div>
    </a>
</div>
<br>
<br>
<br>
<%-- <div class="mycenterMian" style="">
	<article>
	       <div class="mycenter">
	           <ul>
	              <li>
		                <a href="${ctx }/recommendCustomerWechat/recommendCustomer">
		                <img src="${ctx }/img/weixin/tj.png">
		                <p>推荐客户</p>
		            </a>
		        </li>
		        <li>
		            <a href="${ctx }/carModelWechat/carModelList">
		                <img src="${ctx }/img/weixin/myPoint.png">
		                <p>车型介绍</p>
		            </a>
		        </li>
		        <li>
		            <a href="${ctx }/carModelWechat/policy?menu=5">
		                <img src="${ctx }/img/weixin/myOrder.png">
		                  <p>介绍优惠</p>
		              </a>
		          </li>
		        <li>
		            <a href="${ctx }/agentWechat/memberCenter">
		                <img src="${ctx }/img/weixin/myInfo.png">
		                  <p>个人中心</p>
		              </a>
		          </li>
	   		</ul>
	      </div>
	</article>
</div> --%>
<br>
<br>
<jsp:include page="tabbar.jsp"></jsp:include>
</body>
</html>