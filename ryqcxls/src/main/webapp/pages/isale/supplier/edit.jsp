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
<title>供货商添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/supplier/queryList'">供货商</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(supplier) }">添加供货商</c:if>
	<c:if test="${!empty(supplier) }">编辑供货商</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="supplier.dbid" id="dbid" value="${supplier.dbid }">
		<input type="hidden" name="supplier.status" id="status" value="${supplier.status }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="supplier.name" id="name"	value="${supplier.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">联系人:&nbsp;</td>
				<td ><input type="text" name="supplier.contactPerson" id="contactPerson" value="${supplier.contactPerson }" class="largeX text" title="联系人"	checkType="string,1,50" tip="联系人不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td ><input type="text" name="supplier.mobilePhone" id="mobilePhone" value="${supplier.mobilePhone }" class="largeX text" title="联系电话"	checkType="string,1,50" tip="联系电话不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">传真:&nbsp;</td>
				<td ><input type="text" name="supplier.fax" id="fax" value="${supplier.fax }" class="largeX text" title="传真"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">QQ号码:&nbsp;</td>
				<td ><input type="text" name="supplier.qqNum" id="qqNum" value="${supplier.qqNum }" class="largeX text" title="QQ号码"	></td>
				<td class="formTableTdLeft">电子邮箱:&nbsp;</td>
				<td ><input type="text" name="supplier.email" id="email" value="${supplier.email }" class="largeX text" title="电子邮箱"	checkType="email" canEmpty="Y" tip="请填写电子邮件，格式XXX@qq.com"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮编:&nbsp;</td>
				<td ><input type="text" name="supplier.zipCode" id="zipCode" value="${supplier.zipCode }" class="largeX text" title="邮编"	></td>
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td ><input type="text" name="supplier.address" id="address" value="${supplier.address }" class="largeX text" title="邮编"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">当前应付款:&nbsp;</td>
				<td ><input type="text" name="supplier.payMoney" id="payMoney"	value="${supplier.payMoney }" class="largeX text" title="当前应付款"	checkType="float,0" canEmpty="Y" tip="当前应付款"></td>
				<td class="formTableTdLeft">初始应付款:&nbsp;</td>
				<td ><input type="text" readonly="readonly" name="supplier.beginPayMoney" id="beginPayMoney" value="${supplier.beginPayMoney }" class="largeX text" ></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="supplier.note" id="note" title="内容简介"  class="largeXX text" style="height: 120px;width: 720px;">${supplier.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/supplier/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>