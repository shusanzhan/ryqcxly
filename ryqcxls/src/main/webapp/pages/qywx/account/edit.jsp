<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>企业号设置</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" >企业号设置</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="qywxAccount.dbid" id="dbid" value="${qywxAccount.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="qywxAccount.accountName" id="accountName"
					value="${qywxAccount.accountName }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">groupId:&nbsp;</td>
				<td ><input type="text" name="qywxAccount.groupId" id="groupId"
					value="${qywxAccount.groupId }" class="largeX text" title="groupId"	checkType="string,1,50" tip="请填写groupId"><span style="color: red;">*</span>例如：wx85614e**86d7b87f</td>
			</tr>
			<tr height="80">
				<td class="formTableTdLeft">通讯录security:&nbsp;</td>
				<td >
					<textarea class="text textare" name="qywxAccount.security" id="security" rows="8" cols="60"  title="security" style="height: 80px;"	checkType="string,1,120" tip="请填写security">${qywxAccount.security }</textarea>
					<br>
					<span style="color: red;">*</span>例如：KkQzTmIS1trnvqMkfjs1h1yxnZL92fwRy5Vm2whLawPGwNpyAo0gdxkBIyRfEUkd</td>
			</tr>
			<tr height="80">
				<td class="formTableTdLeft">通讯录APPID:&nbsp;</td>
				<td >
					<input class="largeX text" name="qywxAccount.appId" id="appId" value="${qywxAccount.appId }"  title="appId" 	checkType="string,1,120" tip="请填写appId"></input>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">绑定微信:&nbsp;</td>
				<td ><input type="text" name="qywxAccount.bandWeixin" id="bandWeixin"
					value="${qywxAccount.bandWeixin }" class="largeX text" title="绑定微信号"	checkType="string,1,50" tip="请填写绑定微信号"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">安全邮箱:&nbsp;</td>
				<td ><input type="text" name="qywxAccount.accountEmail" id="accountEmail"
					value="${qywxAccount.accountEmail }" class="largeX text" title="安全邮箱"	checkType="email" tip="请填写您注册邮箱"><span style="color: red;">*</span>例如：5293**221@qq.com</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">描述:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="qywxAccount.accountIntro" id="accountIntro" >${qywxAccount.accountIntro }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/account/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>