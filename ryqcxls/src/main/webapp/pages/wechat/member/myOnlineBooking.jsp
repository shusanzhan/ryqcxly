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

<title>我的预约记录</title>
</head>
<body>
<div class="order_title"> 预约记录 </div>
<c:if test="${empty(onlineBookings) }">
	<div id="message" class="alert alert-success" style="margin:14px;">
		<strong>提示：</strong>您当前无预约记录！
  	</div>
</c:if>
<c:if test="${!empty(onlineBookings) }">
<c:forEach var="onlineBooking" items="${ onlineBookings}">
<div class="order_box">
    <div class="order_box_head">
    <c:if test="${onlineBooking.bookingType=='1' }">
		试乘试驾
	</c:if>
	<c:if test="${onlineBooking.bookingType=='2' }">
		保养维修
	</c:if>
	<c:if test="${onlineBooking.bookingType=='3' }">
		续保年审
	</c:if>
	<c:if test="${onlineBooking.bookingType=='4' }">
		旧车置换
	</c:if>
    </div>
    <div class="order_box_main">
      <p>预约时间：<fmt:formatDate value="${onlineBooking.bookingDate }" pattern="yyyy年MM月dd"/> </p>
      <p>联系人&#12288;： ${onlineBooking.name }</p>
      <p>联系电话： ${onlineBooking.mobilePhone }</p>
      <p>车&#12288;&#12288;型：${onlineBooking.carModel }</p>
      <p>车牌号&#12288;： ${onlineBooking.carPlate }</p>
      <p>服务方式：<c:if test="${onlineBooking.serviceType==1}">
					<span style="color: green">
						到店
					</span>
				</c:if>
				<c:if test="${onlineBooking.serviceType==2}">
					<span style="color: red">
						上门取车
					</span>
				</c:if>
			</p>
       <c:if test="${onlineBooking.serviceType==2}">
	       <p>
				<span >
					取车时间： ${onlineBooking.startTime }~${onlineBooking.endTime }
				</span>
			</p>
		</c:if>
      <p style="color:#d1d2d2;border-bottom: 1px dashed #4B4C4D;margin: 0 12px;"></p>
      <c:if test="${onlineBooking.status==1 }">
      	<p><span>预约等待受理！</span></p>
      </c:if>
      <c:if test="${onlineBooking.status==2 }">
      	<p><span>${onlineBooking.operator }已经受理您的预约 <fmt:formatDate value="${onlineBooking.modifyTime }" pattern="yyyy年MM月dd HH:mm"/></span></p>
      </c:if>
    </div>
</div>	
</c:forEach>  
</c:if>
<!-- <div class="order_box">
    <div class="order_box_head">预约保养</div>
    <div class="order_box_main">
      <p>预约2014年3月20日 瑞虎试乘试驾</p>
      <p style="color:#d1d2d2;border-bottom: 1px dashed #4B4C4D;margin: 0 12px;"></p>
      <p><span>管理员已经受理您的预约 2014年3月21日 20:50</span></p>
    </div>
</div>	  
<div class="order_box">
    <div class="order_box_head">旧车置换</div>
    <div class="order_box_main">
      <p>预约2014年3月20日 瑞虎试乘试驾</p>
      <p style="color:#d1d2d2;border-bottom: 1px dashed #4B4C4D;margin: 0 12px;"></p>
      <p><span>管理员已经受理您的预约 2014年3月21日 20:50</span></p>
    </div>
</div>	 -->  
</body>
</html>
