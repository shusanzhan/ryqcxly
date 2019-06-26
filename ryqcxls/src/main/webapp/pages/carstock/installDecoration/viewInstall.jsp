<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>库房区域</title>
</head>
<body class="bodycolor">
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
	<tr height="30">
		<td class="formTableTdLeft">加装名称：</td>
		<td>
			${installDecoration.installName }
		</td>
	</tr>
	<tr height="30">
		<td class="formTableTdLeft">加装时间：</td>
		<td>
			${installDecoration.installDate }
		</td>
	</tr>
	<tr height="30">
		<td class="formTableTdLeft">加装内容：</td>
		<td>
			${installDecoration.installContent }
		</td>
	</tr>
	<tr height="30">
		<td class="formTableTdLeft">备注：</td>
		<td>
			${installDecoration.note }
		</td>
	</tr>
</table>
<table width="92%"  cellpadding="0" cellspacing="0" class="mainTable" border="0" style="margin: 0 auto;">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">序号</td>
			<td class="span2">项目名称</td>
			<td class="span4">套餐明细</td>
			<td class="span1">编码</td>
			<td class="span2">品牌</td>
			<td class="span1">销售价格</td>
			<td class="span1">数量</td>
		</tr>
	</thead>
	<c:forEach var="installItem" items="${installitems }" varStatus="i">
			<tr>
				<td id="">
					${i.index+1 }
			    </td>
				<td style="text-align: center;">
					<a href="javascript:;" class="" style="color: #46A0DE;">
						${installItem.itemName }
					</a>
				</td>
				<td style="text-align:left;">
					<c:if test="${empty(installItem.product.packageDetail) }">
						单个商品
					</c:if>
					<c:if test="${!empty(installItem.product.packageDetail) }">
						${installItem.product.packageDetail}
					</c:if>
				</td>
				<td style="text-align: center;">
					${installItem.serNo }
				</td>
				<td>
					${installItem.product.brand.name }
				</td>
			    <td style="text-align: center;">
					${installItem.price }
				</td>
			    <td style="text-align: center;">
					${installItem.quality }
				</td>
			</tr>
	</c:forEach>
</table>
<div class="formButton" style="text-align: center;margin-top: 50px;">
    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关&nbsp;&nbsp;闭</a>
</div>
</body>
</html>