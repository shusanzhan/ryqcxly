<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/fullcalendar.css" />	
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
.table-bordered td{
	height: 18px;
    padding-bottom: 3px;
}
.comments a{
color: #FFFFFF;
}
</style>
<title>无车订单分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statistics/index'">统计分析</a>
</div>
<div class="row-fluid">
	<div class="span12">
		<div class="widget-box">
			<div class="widget-title"><span class="icon"><i class="icon-comment"></i></span><h5>无车订单统计</h5><span class="label label-info tip-left" data-original-title="${countFinishedSqlNoCar } 未处理交车预约客户">${countFinishedSqlNoCar }</span></div>
			<div class="widget-content nopadding">
				<table class="table table-bordered">
				<c:if test="${empty(hasNoCarOrders) }">
					<thead>
						<tr>
							无无车订单信息
						</tr>
					</thead>
				</c:if>
				<c:if test="${!empty(hasNoCarOrders) }">
					<thead>
						<tr>
							<th style="width: 10px;">车系</th>
							<th style="width: 200px;">车型</th>
							<th style="width: 60px;">颜色</th>
							<th style="width: 60px;">数量</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="hasNoCarOrder" items="${hasNoCarOrders }" >
						<tr>
							
							<td  style="text-align: center;width: 60px;">
									${hasNoCarOrder.carSeriyName }
							</td>
							<td style="text-align: center;">
								${hasNoCarOrder.carModelName }
							</td>
							<td style="text-align: center;">${hasNoCarOrder.color }</td>
							<td style="text-align: center;">${hasNoCarOrder.countNum }</td>
						</tr>
					</c:forEach>
					</tbody>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
<script src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.peity.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
</html>