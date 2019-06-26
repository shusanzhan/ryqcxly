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
<title>经销商负责人</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/distributorChargePerson/queryList'">经销商负责人管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(distributorChargePerson) }">添加经销商负责人</c:if>
	<c:if test="${!empty(distributorChargePerson) }">编辑经销商负责人</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<div style="width: 750px;height: 60px;text-align: center;margin: 0 auto;margin-top: 12px;">
		<div class="programActive">
			1、基本信息
		</div>
		<div class="programActive">
			2、项目负责人
		</div>
		<div class="program">
			3、销售员
		</div>
		<div class="program">
			4、经营其他品牌
		</div>
		<div class="program">
			5、三级网点
		</div>
		<div class="clear"></div>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="distributorChargePerson.dbid" id="dbid" value="${distributorChargePerson.dbid }">
		<c:if test="${ !empty(distributorChargePerson)}">
			<input type="hidden" name="distributorChargePerson.distributorId" id="distributorId" value="${distributorChargePerson.distributorId }">
		</c:if>
		<c:if test="${ empty(distributorChargePerson)}">
			<input type="hidden" name="distributorChargePerson.distributorId" id="distributorId" value="${param.distributorId }">
		</c:if>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">姓名:&nbsp;</td>
				<td ><input type="text" name="distributorChargePerson.name" id="name"
					value="${distributorChargePerson.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">手机号码:&nbsp;</td>
				<td ><input type="text" name="distributorChargePerson.mobilePhone" id="mobilePhone"
					value="${distributorChargePerson.mobilePhone }" class="largeX text" title="手机号码"	checkType="mobilePhone" tip="手机号码不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">身份证号:&nbsp;</td>
				<td ><input type="text" name="distributorChargePerson.icard" id="icard"
					value="${distributorChargePerson.icard }" class="largeX text" title="身份证号" 	checkType="IDCard" tip="身份证号不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">座机:&nbsp;</td>
				<td ><input type="text" name="distributorChargePerson.phone" id="phone"
					value="${distributorChargePerson.phone }" class="largeX text" title="座机"	checkType="phone" canEmpty="Y" tip="座机可为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td ><input type="text" name="distributorChargePerson.address" id="address"
					value="${distributorChargePerson.address }" class="largeX text" title="地址"	checkType="string,1,50" tip="地址不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">出生年月:&nbsp;</td>
				<td ><input type="text" readonly="readonly" name="distributorChargePerson.birthDay" id="birthday"
					value="${distributorChargePerson.birthDay }" class="largeX text" title=""	></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="distributorChargePerson.note" id="note">${distributorChargePerson.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="if(getBirthdatByIdNo()){$.utile.submitForm('frmId','${ctx}/distributorChargePerson/save')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
//验证身份证号并获取出生日期
function getBirthdatByIdNo() {
	var tmpStr = "";
	var idDate = "";
	var tmpInt = 0;
	var strReturn = "";
	var iIdNo=$("#icard").val();
	if ((iIdNo.length != 15) && (iIdNo.length != 18)) {
		alert("输入的身份证号位数错误")
		return false;
	}
	
	if (iIdNo.length == 15) {
		tmpStr = iIdNo.substring(6, 12);
		tmpStr = "19" + tmpStr;
		tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6);
		$("#birthday").val(tmpStr);
		return true;
	}
	else {
		tmpStr = iIdNo.substring(6, 14);
		tmpStr = tmpStr.substring(0, 4) + "-" + tmpStr.substring(4, 6) + "-" + tmpStr.substring(6);
		$("#birthday").val(tmpStr);
		return true;
	}
}
</script>
</html>