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
<title>Banner设置</title>
</head>
<body class="bodycolor">
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="bussiBanner.dbid" id="dbid" value="${bussiBanner.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">图片:&nbsp;</td>
				<td>
					<input type="hidden" name="bussiBanner.picture" id="picture" readonly="readonly"	value="${bussiBanner.picture }">
					<img alt="" id="pictureImg" src="${bussiBanner.picture}" width="150" height="90">
					<a href="javascript:void(-1)" onclick="uploadFile('picture','pictureImg')">banner</a>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td>
					<input type="text" name="bussiBanner.title" id="title"	value="${bussiBanner.title }" class="largeX text" title="标题"	checkType="string,1,50" tip="标题不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">链接:&nbsp;</td>
				<td ><input type="text" id="url" name="bussiBanner.url" class="largeX text" title="链接" value="${bussiBanner.url }"	checkType="url" canEmpty="Y" tip="链接不能为空"></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/bussiBanner/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>