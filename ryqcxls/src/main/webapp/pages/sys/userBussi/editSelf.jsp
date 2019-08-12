<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>个人设置-编辑个人信息</title>
</head>
<body class="bodycolor">
<div class="location">
    <img src="${ctx}/images/homeIcon.png"/> &nbsp;
    <a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" >修改个人信息</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_self">
		<s:token></s:token>
		<input type="hidden" name="user.dbid" id="dbid" value="${user.dbid }">
		<input type="hidden" name="staff.dbid" id="dbid" value="${staff.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" >用户ID:&nbsp;</td>
				<td ><input type="text" name="user.userId" id="userId"
					value="${user.userId }" class="large text" readonly="readonly" title="用户ID" ></td>
				<td class="formTableTdLeft" >姓名:&nbsp;</td>
				<td ><input type="text" name="user.realName" id="realName"
					value="${user.realName }" class="mideaX text" title="姓名"	checkType="string,1,10" tip="真实名称不能为空"><span style="color: red;">*</span>
					<input type="radio" id="sex1"  name="staff.sex" ${staff.sex=='男'?'checked="checked"':'' }  value="男"><label id="" for="sex1">男</label>
					<input type="radio" id="sex2"  name="staff.sex" ${staff.sex=='女'?'checked="checked"':'' } value="女"><label id="" for="sex2">女</label>	
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >微信号:&nbsp;</td>
				<td ><input type="text" name="user.wechatId" id="wechatId"	value="${user.wechatId }" class="large text" ></td>
				<td class="formTableTdLeft" >手机:&nbsp;</td>
				<td><input type="text" name="user.mobilePhone" id="mobilePhone"
					value="${user.mobilePhone }" class="large text"  checkType="mobilePhone" canEmpty="Y" tip="请输入正确的手机号"></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >座机:&nbsp;</td>
				<td><input type="text" name="user.phone" id="phone"
					value="${user.phone }" class="large text"  checkType="phone"  canEmpty="Y" tip="请输入正确的座机号"></td>
			    <td class="formTableTdLeft" >邮箱:&nbsp;</td>
				<td ><input type="text" name="user.email" id="email"
					value="${user.email }" class="large text" title="邮箱"	checkType="email" canEmpty="Y" tip="请输入正确的邮箱"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 120px;">QQ:&nbsp;</td>
				<td ><input type="text" name="user.qq" id="qq"
					value="${user.qq }" class="large text" title="QQ号"	checkType="string,3,20" canEmpty="Y" tip="请输入正确的QQ号"></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/userBussi/saveEditSelf')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	</div>
</div>
</body>
</html>