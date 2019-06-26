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
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<title>附带权益</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/incidentalInterest/queryList'">附带权益</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(incidentalInterest) }">添加附带权益</c:if>
	<c:if test="${!empty(incidentalInterest) }">编辑附带权益</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="incidentalInterest.dbid" id="dbid" value="${incidentalInterest.dbid }">
		<input type="hidden" name="incidentalInterest.createDate" id="createDate" value="${incidentalInterest.createDate }">
		<input type="hidden" name="incidentalInterest.pym" id="pym" value="${incidentalInterest.pym }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="incidentalInterest.name" id="name" value="${incidentalInterest.name }" class="large text" title="名称" onchange="pym.value = getCharsCode(this.value);"  checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td >
					<select class="large text" id="type" name="incidentalInterest.type" checkType="integer,1" tip="请选择类型">
						<option>请选择...</option>
						<option value="1" ${incidentalInterest.type==1?'selected="selected"':'' }>优惠现金</option>
						<option value="2" ${incidentalInterest.type==2?'selected="selected"':'' }>优惠券</option>
						<option value="3" ${incidentalInterest.type==3?'selected="selected"':'' }>维修项目</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">排序:&nbsp;</td>
				<td ><input type="text" name="incidentalInterest.orderNum" id="orderNum"
					value="${incidentalInterest.orderNum }" class="large text" title="排序"	checkType="integer,1" canEmpty="Y" tip="名称不能为空"></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">说明:&nbsp;</td>
				<td colspan="3">
					<textarea name="incidentalInterest.note" id="content" title="说明"  style="margin:5px 0;;height: 100px;width: 540px;">${incidentalInterest.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/incidentalInterest/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>