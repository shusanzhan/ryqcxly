<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>${carSeriy.name }库存查询</title>
<style type="text/css">
body {
    font-family: "Microsoft Yahei",tahoma,verdana,arial,sans-serif;
    font-size: 14px;
    line-height: 1.231;
}
#badgeSelf{
		float: none;
		color: #FFF;
		background-color:  #ed145b;
	}
	
.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${carSeriy.name }库存查询</span>
    <a class="go_home" href="${ctx }/qywxWlbFacotoryOrder/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<ul class="list-group">
<c:if test="${fn:length(carSerCounts)>0 }" var="status">
	<c:forEach var="carSerCount" items="${carSerCounts }">
	  <li class="list-group-item" onclick="window.location.href='${ctx}/qywxWlbFacotoryOrder/factoryOrderList?carModelId=${carSerCount.serid }'">
	  		<span style="font-size: 24px;font-family: '宋体';float: right;">
	  			<img alt="" src="${ctx }/images/weixin/arrowLeft.png">
	  		</span>
	    		${carSerCount.serName }  <span style="color: #ed145b">(￥${carSerCount.salePrice })</span>
	    	<span class="badge "  id="badgeSelf">
		    	<c:if test="${!empty(carSerCount.countNum)}">
		    		${carSerCount.countNum }
		    	</c:if>
		    	<c:if test="${empty(carSerCount.countNum)}">
		    		0
		    	</c:if>
	    	</span>
	  </li>
	 </c:forEach>
 </c:if>
 <c:if test="${status==false }">
 	 <li class="list-group-item">
 	 	${carSeriy.name } 车系无库存
	 </li>
 </c:if>
</ul>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
</html>