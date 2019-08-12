<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>套餐查看</title>
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
</head>
<body >
<div class="orderContrac detail">
	<div class="title" align="left">
 			套餐名称：
 			${product.name }
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td colspan="2">车型：${product.carSeriy.name }</td>
				</tr>
				<tr >
					<td >类型：
						${product.productcategory.name }
					</td>
				</tr>
				<tr >
					<td class="formTableTdLeft">编码：
						${product.sn }
					</td>
				</tr>
				<tr>
					<td colspan="2">明细：${product.packageDetail }</td>
				</tr>
				<tr>
					<td colspan="2">
						备注：&#12288;
						${product.note }
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</body>

</html>
