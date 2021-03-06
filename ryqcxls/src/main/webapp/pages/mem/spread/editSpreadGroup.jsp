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
<title>分组管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/memSpread/spreadGroupList'">分组管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(spreadGroup) }">添加分组</c:if>
	<c:if test="${!empty(spreadGroup) }">编辑分组</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="type" id="type" value="1">
		<input type="hidden" name="spreadGroup.dbid" id="dbid" value="${spreadGroup.dbid }">
		<input type="hidden" name="spreadId" id="spreadId" value="${spread.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spreadGroup.name" id="name"
					value="${spreadGroup.name }" class="largex text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有分组重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="spreadGroup.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadGroup.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<c:if test="${empty(spreadGroup) }">
			<a href="javascript:void(-1)"	onclick="$('#type').val(1);$.utile.submitForm('frmId','${ctx}/memSpread/saveSpreadGroup')"	class="but butSave">保存返回</a> 
			<a href="javascript:void(-1)"	onclick="$('#type').val(2);$.utile.submitForm('frmId','${ctx}/memSpread/saveSpreadGroup')"	class="but butSave">保存继续</a> 
		</c:if>
		<c:if test="${!empty(spreadGroup) }">
			<a href="javascript:void(-1)"	onclick="$('#type').val(1);$.utile.submitForm('frmId','${ctx}/memSpread/saveSpreadGroup')"	class="but butSave">保存</a> 
		</c:if>
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>