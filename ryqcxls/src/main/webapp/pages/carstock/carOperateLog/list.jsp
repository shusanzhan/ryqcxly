<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>转单历史记录</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆操作日志</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   	</div>
</div>

<c:if test="${empty(carOperateLogs)||carOperateLogs==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 40px;">
				序号		
			</td>
			<td style="width: 120px;">操作类型</td>
			<td style="width: 80px;">操作时间</td>
			<td style="width: 80px;">操作人</td> 
			<td style="width: 120px;">备注</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${carOperateLogs}" var="carOperateLog" varStatus="i">
		<tr >
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td>
				${carOperateLog.type }
			</td>
			<td>
				<fmt:formatDate value="${carOperateLog.operateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	 
			</td>
			<td>
				${carOperateLog.operator}
			</td>
			<td style="text-align: left;">
				${carOperateLog.note}
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>
