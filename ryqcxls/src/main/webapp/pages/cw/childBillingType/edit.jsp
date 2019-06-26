<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑支付方式</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
      	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
      	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/childBillingType/queryList'">票据类型列表</a>-
	<c:if test="${empty childBillingType }">
		<a href="#">添加票据类型</a>
	</c:if>
	<c:if test="${!empty childBillingType }">
		<a href="#">编辑票据类型</a>
	</c:if>
</div>
<div class="frmContent">
<form  method="post"  action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${childBillingType.dbid }" id="dbid" name="childBillingType.dbid">
	<input type="hidden" value="${childBillingType.createTime }" id="createTime" name="childBillingType.createTime">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<tr height="42">
		<td class="formTableTdLeft" >名称：</td>
		<td>
			<input type="text" class="largeX text" name="childBillingType.name"	id="name" value="${childBillingType.name }"  checkType="string,1,20"  tip="请输入发票名称！"  />
			<span style="color: red">*</span>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >排序：</td>
		<td>
			<input type="text" class="largeX text" name="childBillingType.orderNum" id="orderNum"  value="${childBillingType.orderNum }" checkType="integer"  canEmpty="Y" tip="请输入排序号！"/>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >备注：</td>
		<td>
			<input type="text" class="largeX text" name="childBillingType.note"	id="note"  value="${childBillingType.note }"  />
		</td>
	</tr>
	</table>
</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/childBillingType/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>
