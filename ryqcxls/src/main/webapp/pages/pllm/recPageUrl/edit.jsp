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
<title>访问链接</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/recPageUrl/queryList'">访问链接</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(recPageUrl) }">添加</c:if>
	<c:if test="${!empty(recPageUrl) }">编辑</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="recPageUrl.dbid" id="dbid" value="${recPageUrl.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="recPageUrl.name" id="name"	value="${recPageUrl.name }" class="largeX text" title="名称" placeholder="请输入标题"	checkType="string,1,50" tip="标题不能为空"><span style="color: red;">*</span></td>
			</tr>
			<c:if test="${empty(recPageUrl)}">
				<tr height="42">
					<td class="formTableTdLeft">链接:&nbsp;</td>
					<td ><input type="text" name="recPageUrl.url" id="url"	value="${url }" class="largeX text" title="链接" placeholder="请输入链接"	checkType="string,1,255" tip="链接不能为空"><span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<c:if test="${!empty(recPageUrl)}">
				<tr height="42">
					<td class="formTableTdLeft">链接:&nbsp;</td>
					<td ><input type="text" name="recPageUrl.url" id="url"	value="${recPageUrl.url }" class="largeX text" title="链接" placeholder="请输入链接"	checkType="string,1,255" tip="链接不能为空"><span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">简介:&nbsp;</td>
				<td >
					<textarea class="textarea text largeX" rows="" cols="" id="note" name="recPageUrl.note">${recPageUrl.note }</textarea>
				</td>
			</tr>
		</table>
		</form>
	</div> 
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/recPageUrl/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
</html>