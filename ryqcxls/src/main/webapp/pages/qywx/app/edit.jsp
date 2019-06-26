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
<title>应用管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="${ctx }/app/queryList" >应用管理</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="app.dbid" id="dbid" value="${app.dbid }">
		<input type="hidden" name="app.square_logo_url" id="square_logo_url" value="${app.square_logo_url }">
		<input type="hidden" name="app.round_logo_url" id="round_logo_url" value="${app.round_logo_url }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="app.name" id="name" readonly="readonly"
					value="${app.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">应用ID:&nbsp;</td>
				<td ><input type="text" name="app.appId" id="appId" readonly="readonly"
					value="${app.appId }" class="largeX text" title="应用ID"	checkType="integer" tip="请填写应用ID"><span style="color: red;">*</span></td>
			</tr> 
			<tr height="42">
				<td class="formTableTdLeft">Token:&nbsp;</td>
				<td ><input type="text" name="app.token" id="token"
					value="${app.token }" class="largeX text" title="绑定微信号"	checkType="string,1,50" tip="请填写绑定微信号"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">安全随机码:&nbsp;</td>
				<td ><input type="text" name="app.encodingAeskey" id="encodingAeskey"
					value="${app.encodingAeskey }" class="largeXX text" title="安全随机码" style="width: 440px;"	checkType="string,1,50" tip="请填写安全随机码"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">描述:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="app.intro" id="intro" >${app.intro }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/app/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>