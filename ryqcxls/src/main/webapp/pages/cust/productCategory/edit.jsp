<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑商品类型</title>
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
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/productCategory/queryList'">商品类型</a>
</div>
<div class="frmContent">
<form  method="post" action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${productCategory.dbid }" id="dbid" name="productCategory.dbid">
	<input type="hidden" value="${productCategory.createTime }" id="createTime" name="productCategory.createTime">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<tr height="42">
		<td class="formTableTdLeft" >名称：</td>
		<td>
			<input type="text" class="largeX text" name="productCategory.name"	id="name" value="${productCategory.name }" checkType="string,1,20"  tip="请输入商品类型名称！"  />
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >上级分类：</td>
		<td>
			<select id="parentId" name="parentId" class="large text">
				<option value="0" >顶级分类</option>
				${productCateGorySelect }
			</select>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >排序：</td>
		<td>
			<input type="text" class="largeX text" name="productCategory.orderNum" id="orderNum"  value="${productCategory.orderNum }" checkType="integer" canEmpty="Y" tip="请输入排序号！"/>
		</td>
	</tr>
	</table>
</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/productCategory/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>
