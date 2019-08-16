<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>红包活动</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/act/queryList'">红包活动管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(act) }">添加红包活动</c:if>
	<c:if test="${!empty(act) }">编辑红包活动</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="actEnterprise.dbid" id="dbid" value="${actEnterprise.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">红包类型:&nbsp;</td>
				<td >
				<select class="largeX text" id="actId" name="actId" checkType="integer,1" tip="红包类型">
					<option value="-1">请选择...</option>
					<c:forEach var="act" items="${acts }">
						<option value="${act.dbid }" ${act.dbid==actEnterprise.dbid?'selected="selected"':'' } >${act.name }</option>
					</c:forEach>
				</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">领导发放状态:&nbsp;</td>
				<td >
				<select class="largeX text" id="levelStatus" name="actEnterprise.levelStatus" checkType="integer,1" tip="红包类型">
					<option value="-1">请选择...</option>
					<option value="1" ${actEnterprise.levelStatus==1?'selected="selected"':'' }>发放</option>
					<option value="2" ${actEnterprise.levelStatus==2?'selected="selected"':'' } >停发</option>
				</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="actEnterprise.name" id="name"
					value="${actEnterprise.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">红包祝福语:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="actEnterprise.wishing" id="wishing" checkType="string,2" tip="红包祝福语不能为空">${actEnterprise.wishing }</textarea>
					<span style="color: red;">*</span> 例如：交车多多，红包多多
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">红包备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="actEnterprise.remark" id="note" checkType="string,2" tip="红包备注不能为空">${actEnterprise.remark }</textarea>
					<span style="color: red;">*</span> 例如：再接再厉
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="actEnterprise.note" id="note">${actEnterprise.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/actEnterprise/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>