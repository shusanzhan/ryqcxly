<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑返利项目</title>
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
      	<a href="javascript:void(-1);" onclick="window.history.go(-1)">返利项目列表</a>-
      	<c:if test="${empty childrenRebateType}">
      		<a href="#">添加返利项目</a>
      	</c:if>
      	<c:if test="${!empty childrenRebateType}">
      		<a href="#">编辑返利项目</a>
      	</c:if>
</div>
<div class="frmContent">
<form  method="post"  action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${childrenRebateType.dbid }" id="dbid" name="childrenRebateType.dbid">
	<input type="hidden" value="${childrenRebateType.createTime }" id="createTime" name="childrenRebateType.createTime">
	<input type="hidden" value="${childrenRebateType.useStatus }" id="useStatus" name="childrenRebateType.useStatus">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<tr height="42">
		<td class="formTableTdLeft" >返利类型：</td>
		<td>
			<select id="rebateTypeId" name="rebateTypeId" class="text largeX" checkType="integer,1">
				<option value="-1">请选择...</option>
				<c:forEach items="${rebateTypes }" var="rebateType">
					<option value="${rebateType.dbid }" ${childrenRebateType.rebateType.dbid==rebateType.dbid?'selected="selected"':'' }>${rebateType.name }</option>
				</c:forEach>
			</select>
			<span style="color:red">*</span>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >名称：</td>
		<td>
			<input type="text" class="largeX text" name="childrenRebateType.name"	id="name" value="${childrenRebateType.name }"  checkType="string,1,20"  tip="请输入子返利类型名称！"  />
			<span style="color:red">*</span>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >排序：</td>
		<td>
			<input type="text" class="largeX text" name="childrenRebateType.orderNum" id="orderNum"  value="${childrenRebateType.orderNum }" checkType="integer"  canEmpty="Y" tip="请输入排序号！"/>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >备注：</td>
		<td>
			<input type="text" class="largeX text" name="childrenRebateType.note"	id="note"  value="${childrenRebateType.note }"  />
		</td>
	</tr>
	</table>
</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/childrenRebateType/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>
