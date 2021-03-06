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
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<title>收费项目管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/chargeItem/queryList'">收费项目管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(chargeItem) }">添加收费项目</c:if>
	<c:if test="${!empty(chargeItem) }">编辑收费项目</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="chargeItem.dbid" id="dbid" value="${chargeItem.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >
					<input type="text" name="chargeItem.name" id="name"
					value="${chargeItem.name }" class="largex text" title="名称"  onchange="jym.value = getCharsCode(this.value);"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span>
					<input type="hidden" name="chargeItem.jym" id="jym" value="${chargeItem.jym }">
				</td>
			</tr>
				<tr height="42">
				<td class="formTableTdLeft">所属类别:&nbsp;</td>
				<td >
					<select id="type" name="chargeItem.netTowType" class="text midea">
						<option value="">请选择</option>
						<option value="1" ${chargeItem.netTowType==1?'selected="selected"':'' }>自有店</option>
						<option value="2" ${chargeItem.netTowType==2?'selected="selected"':'' }>二网</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">默认金额:&nbsp;</td>
				<td ><input type="text" name="chargeItem.defaultPrice" id="defaultPrice"
					value="${chargeItem.defaultPrice }" class="largex text" title="默认金额"	checkType="string,1,50" tip="默认金额不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">排序号:&nbsp;</td>
				<td ><input type="text" name="chargeItem.orderNum" id="orderNum"
					value="${chargeItem.orderNum }" class="largex text" title="排序号"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="chargeItem.note" id="note">${chargeItem.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/chargeItem/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>