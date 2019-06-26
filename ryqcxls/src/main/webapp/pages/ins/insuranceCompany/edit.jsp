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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>保险公司添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/insuranceCompany/queryList'">保险公司</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(insuranceCompany) }">添加保险公司</c:if>
	<c:if test="${!empty(insuranceCompany) }">编辑保险公司</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="insuranceCompany.dbid" id="dbid" value="${insuranceCompany.dbid }">
		<input type="hidden" name="insuranceCompany.createDate" id="createDate" value="${insuranceCompany.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td colspan="3"><input type="text" name="insuranceCompany.name" id="name"
					value="${insuranceCompany.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">初保强制险返利比例:&nbsp;</td>
				<td ><input type="text" name="insuranceCompany.strongRiskPer" id="strongRiskPer"
					value="${insuranceCompany.strongRiskPer }" class="largex text" title="初保强制险返利比例"	checkType="float,1" tip="初保强制险返利比例不能为空">%<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">初保商业险返利比例:&nbsp;</td>
				<td ><input type="text" name="insuranceCompany.busiRiskPer" id="busiRiskPer"
					value="${insuranceCompany.busiRiskPer }" class="largex text" title="初保商业险返利比例"	checkType="float,1" tip="初保商业险返利比例不能为空">%<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">续保强制险返利比例:&nbsp;</td>
				<td ><input type="text" name="insuranceCompany.gonnaStrongRiskPer" id="gonnaStrongRiskPer"
					value="${insuranceCompany.gonnaStrongRiskPer }" class="largex text" title="续保强制险返利比例"	checkType="float,1" tip="续保强制险返利比例不能为空">%<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">续保商业险返利比例:&nbsp;</td>
				<td ><input type="text" name="insuranceCompany.gonnaBusiRiskPer" id="gonnaBusiRiskPer"
					value="${insuranceCompany.gonnaBusiRiskPer }" class="largex text" title="续保商业险返利比例"	checkType="float,1" tip="续保商业险返利比例不能为空">%<span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="insuranceCompany.dis" id="content" title="内容简介"  >${insuranceCompany.dis }</textarea>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">排序:&nbsp;</td>
				<td colspan="3"><input type="text" name="insuranceCompany.orderNum" id="orderNum"
					value="${insuranceCompany.orderNum }" class="largex text" title="名称"	checkType="integer,1" canEmpty="Y" tip="名称不能为空"></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/insuranceCompany/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
var editor=CKEDITOR.replace("content");
</script>
</html>