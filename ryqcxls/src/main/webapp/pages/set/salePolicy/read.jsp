<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">

<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>销售政策阅读</title>
</head>
<body class="bodycolor">
	<table class="TableTop" width="100%" style="b">
		<tbody>
			<tr>
				<td class="left"></td>
				<td class="center" style="text-align: center;font-size: 14px;font-weight: bold;">${salePolicy.title }</td>
				<td class="right"></td>
			</tr>
		</tbody>
	</table>
	<div style="margin-top: 12px;text-align: center;padding-right: 12px;">
		${salePolicy.user.realName }&nbsp;&nbsp;&nbsp;&nbsp;发布于：<fmt:formatDate value="${salePolicy.createDate }" pattern="yyyy-MM-dd"/> &nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	<div style="margin:auto 0;margin-top: 12px;text-indent: 24px;margin-left: 12px">
		${salePolicy.content }
	</div>
	<div class="formButton" style="text-align: center;">
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关闭</a>
	</div>
</body>
</html>