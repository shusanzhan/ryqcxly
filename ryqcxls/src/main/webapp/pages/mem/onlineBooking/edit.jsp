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
<title>在线预约</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/onlineBooking/queryList'">在线预约管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(onlineBooking) }">添加在线预约</c:if>
	<c:if test="${!empty(onlineBooking) }">编辑在线预约</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="onlineBooking.dbid" id="dbid" value="${onlineBooking.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">微信号:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.microId" id="microId"
					value="${onlineBooking.microId }" class="largeX text" title="微信号"	checkType="string,1,50" tip="微信号不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.name" id="name"
					value="${onlineBooking.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">常用手机号:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.mobilePhone" id="mobilePhone"
					value="${onlineBooking.mobilePhone }" class="largeX text" title="常用手机号"	checkType="mobilePhone" tip="常用手机号不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">家庭电话:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.phone" id="phone"
					value="${onlineBooking.phone }" class="largeX text" title="家庭电话"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">预约车型:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.bookingDate" id="bookingDate"
					value="${onlineBooking.bookingDate }" onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'});" class="largeX text" title="预约车型"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">预约车型:&nbsp;</td>
				<td ><input type="text" name="onlineBooking.carModel" id="carModel"
					value="${onlineBooking.carModel }" class="largeX text" title="预约车型"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">预约类型:&nbsp;</td>
				<td >
					<select class="midea text" id="bookingType" name="onlineBooking.bookingType" >
						<option value="1">试乘试驾</option>
						<option value="2">保养维修</option>
						<option value="3">续保年审</option>
						<option value="4">旧车置换</option>
					</select>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="onlineBooking.note" id="note">${onlineBooking.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/onlineBooking/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>