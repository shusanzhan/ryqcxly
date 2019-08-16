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
<title>待审批合同（总经理）</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
    <span id="page_title">合同流失审批</span>
</div>
<br>
<br>
<br>
<c:if test="${empty(customers)||fn:length(customers)<=0 }" var="status">
	无待办事项
</c:if>

<c:if test="${status==false }">
	<c:forEach items="${customers }" var="customer">
		<c:set value="${customer.orderContract }" var="orderContract"></c:set>
		<div class="orderContrac" onclick="window.location.href='${ctx}/qywxCustomerPidRecord/approvalGeneralManager?dbid=${customer.dbid }'">
			<div class="title" align="left">
	  			客户：${customer.name }<br/>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;">
				<div style="color:#8a8a8a;padding-left: 5px; ">
					车型：${customer.customerBussi.brand.name}&#12288;
					<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
					<c:if test="${fn:length(carModel)>16 }" var="status">
						${fn:substring(carModel,0,16) }...
					</c:if>
					<c:if test="${ status==false}">
						${carModel }${customer.carModelStr}
					</c:if>
					<br>
					顾问：${customer.bussiStaff}（${customer.department.name}）
				</div>
			</div>
			<div class="line"></div>
			<div style="margin: 5px;line-height: 20px;min-height: 30px;">
				<div class="status">待审批</div>
  				<div class="des">
  					总价：<span class="price"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
  				</div>
  				<div style="clear: both;"></div>
			</div>
		</div>
	</c:forEach>
</c:if>
<br>
<br>
<br>
<br>
<div class="oneMenu">
	<ul>
         <li>
             <a href="${ctx}/qywxCustomerPidRecord/generalManagerList">
             	待我审批
             </a>
             <div class="carTip" id="carNum">
             	<c:if test="${!empty(count)}">
			      	${count}
			     </c:if>
	      	</div>
         </li>
      </ul>
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
</html>