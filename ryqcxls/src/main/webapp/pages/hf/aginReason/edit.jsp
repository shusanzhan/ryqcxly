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
<title>再访原因</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/aginReason/queryList'">再访原因</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(aginReason) }">添加再访原因</c:if>
	<c:if test="${!empty(aginReason) }">编辑再访原因</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="aginReason.dbid" id="dbid" value="${aginReason.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="aginReason.name" id="name"
					value="${aginReason.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">排序:&nbsp;</td>
				<td ><input type="text" name="aginReason.orderNum" id="orderNum"
					value="${aginReason.orderNum }" class="largex text" title="排序"	checkType="string,1,50" tip="排序不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">显示初访结果:&nbsp;</td>
				<td >
				<c:if test="${empty(aginReason) }">
					<label><input type="radio" name="aginReason.isShow" id="isShow" value="1">是</label>&nbsp;&nbsp;
					<label><input type="radio" name="aginReason.isShow" id="isShow" value="2" checked="checked">否</label>&nbsp;&nbsp;
				</c:if>
				<c:if test="${!empty(aginReason) }">
					<label><input type="radio" name="aginReason.isShow" id="isShow" value="1" ${aginReason.isShow==1?'checked="checked"':'' } >是</label>&nbsp;&nbsp;
					<label><input type="radio" name="aginReason.isShow" id="isShow" value="2"  ${aginReason.isShow==2?'checked="checked"':'' }>否</label>&nbsp;&nbsp;
				</c:if>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">微信提示信息:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="aginReason.dis" id="dis">${aginReason.dis }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/aginReason/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>