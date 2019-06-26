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
<title>库龄奖励</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/act/queryList'">库龄奖励管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(act) }">添加库龄奖励</c:if>
	<c:if test="${!empty(act) }">编辑库龄奖励</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="rewardStoreLevel.dbid" id="dbid" value="${rewardStoreLevel.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">库龄等级:&nbsp;</td>
				<td >
				<select class="largeX text" id="storeAgeLevelId" name="storeAgeLevelId" checkType="integer,1" tip="红包类型">
					<option value="-1">请选择...</option>
					<c:forEach var="storeAgeLevel" items="${storeAgeLevels }">
						<option value="${storeAgeLevel.dbid }" ${storeAgeLevel.dbid==rewardStoreLevel.storeAgeLevel.dbid?'selected="selected"':'' } >${storeAgeLevel.name }</option>
					</c:forEach>
				</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">奖励金额:&nbsp;</td>
				<td ><input type="text" name="rewardStoreLevel.rewardMoney" id="rewardMoney"
					value="${rewardStoreLevel.rewardMoney }" class="largeX text" title="奖励金额"	checkType="integer,0" tip="奖励金额不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="rewardStoreLevel.note" id="note">${rewardStoreLevel.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/rewardStoreLevel/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>