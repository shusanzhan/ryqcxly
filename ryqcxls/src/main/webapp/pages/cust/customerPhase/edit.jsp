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
<title>意向级别</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/customerPhase/queryList'">意向级别</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(customerPhase) }">添加意向级别</c:if>
	<c:if test="${!empty(customerPhase) }">编辑意向级别</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="customerPhase.dbid" id="dbid" value="${customerPhase.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="customerPhase.name" id="name"
					value="${customerPhase.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">回访周期:&nbsp;</td>
				<td ><input type="text" name="customerPhase.trackDay" id="trackDay"
					value="${customerPhase.trackDay }" class="largex text" title="名称"	checkType="integer,0,150" tip="回访周期不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td >
					<c:if test="${empty(customerPhase) }">
						<label><input type="radio" id="type" name="customerPhase.type" value="1"  checked="checked">下拉</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="type2" name="customerPhase.type" value="2" >自动</label>
					</c:if>
					<c:if test="${!empty(customerPhase) }">
						<label><input type="radio" id="type" name="customerPhase.type" value="1" ${customerPhase.type==1?'checked="checked"':'' }>下拉</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="type2" name="customerPhase.type" value="2" ${customerPhase.type==2?'checked="checked"':'' }>自动</label>
					</c:if>
					<span style="color: red;">说明：“类型”是指是否显示给销售选择。</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">回访提示:&nbsp;</td>
				<td >
				<c:if test="${empty(customerPhase) }">
					<label><input type="radio" id="warmStatus2" name="customerPhase.warmStatus" value="2" >提示</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<label><input type="radio" id="warmStatus" name="customerPhase.warmStatus" value="1"  checked="checked">不提示</label>
				</c:if>
				<c:if test="${!empty(customerPhase) }">
					<label><input type="radio" id="warmStatus2" name="customerPhase.warmStatus" value="2" ${customerPhase.warmStatus==2?'checked="checked"':'' }>提示</label>&nbsp;&nbsp;&nbsp;&nbsp;
					<label><input type="radio" id="warmStatus" name="customerPhase.warmStatus" value="1" ${customerPhase.warmStatus==1?'checked="checked"':'' }>不提示</label>
				</c:if>
				<span style="color: red;">说明：“提示”是指系统客户处理该级别下，会提示回访。</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="customerPhase.note" id="note">${customerPhase.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/customerPhase/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>