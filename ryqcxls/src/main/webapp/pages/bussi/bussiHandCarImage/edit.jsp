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
<title>交车照片</title>
</head>
<body class="bodycolor">
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="bussiHandCarImage.dbid" id="dbid" value="${bussiHandCarImage.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">图片:&nbsp;</td>
				<td>
					<input type="hidden" name="bussiHandCarImage.picture" id="picture" readonly="readonly"	value="${bussiHandCarImage.picture }">
					<img alt="" id="pictureImg" src="${bussiHandCarImage.picture}" width="150" height="90">
					<a href="javascript:void(-1)" onclick="uploadFile('picture','pictureImg')">照片</a>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td>
					<input type="text" name="bussiHandCarImage.name" id="name"	value="${bussiHandCarImage.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="5" cols="40" name="bussiHandCarImage.note" id="note">${bussiHandCarImage.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/bussiHandCarImage/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>