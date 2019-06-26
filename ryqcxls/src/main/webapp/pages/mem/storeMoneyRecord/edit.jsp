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
<title>客户储值 </title>
</head>
<body class="bodycolor">
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="storeMoneyRecord.dbid" id="dbid" value="${storeMoneyRecord.dbid }">
		<input type="hidden" name="memberId" id="memberId" value="${member.dbid }">
		<input type="hidden" name="directType" id="directType" value="${param.directType }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">会员姓名:&nbsp;</td>
				<td ><input type="text" readonly="readonly" name="" id="name"
					value="${member.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">付款方式:&nbsp;</td>
				<td >
					<label> <input type="radio" value="1" id="payWay1" name="storeMoneyRecord.payWay" checked="checked">现金储值</label>
					<label><input type="radio" value="2" id="payWay" name="storeMoneyRecord.payWay">刷卡储值</label>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">实际缴费:&nbsp;</td>
				<td ><input type="text" name="storeMoneyRecord.actMoney" id="actMoney"
					value="${storeMoneyRecord.actMoney }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">充值金额:&nbsp;</td>
				<td ><input type="text" name="storeMoneyRecord.rechargeMoney" id="rechargeMoney"
					value="${storeMoneyRecord.rechargeMoney }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="52">
				<td class="formTableTdLeft">充值说明:&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="5" cols="60" name="storeMoneyRecord.rechargeExplain" id="rechargeExplain" style="margin:5px; ">${storeMoneyRecord.rechargeExplain }</textarea>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="5" cols="60" name="storeMoneyRecord.note" id="note" style="margin:5px; ">${storeMoneyRecord.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/storeMoneyRecord/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>