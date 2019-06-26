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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>添加优惠码</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="couponId" id="couponId" value="${coupon.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input readonly="readonly" type="text" name="coupon.name" id="name"
					value="${coupon.name }" class="largeX text" title="名称" placeholder="请输入优惠券名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">劵面价值:&nbsp;</td>
				<td >
					 <textarea rows="" cols="" name="money" id="money" class="textarea largeX" placeholder='请输入劵面价值以及备注' checkType="string,1,5000" tip="劵面价值不能为空"></textarea>
					 <span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">到期日期:&nbsp;</td>
				<td ><input readonly="readonly"  type="text" name="validDate" id="validDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" class="largeX text" tip="到期日期" checkType="string,1" ><span style="color: red;">*</span></td>
			</tr>
			<tr>
				<td class="formTableTdLeft">接受会员：&nbsp;</td>
				<td >
					<input type="hidden" class="largeX text" name="memberIds" id="memberIds" readonly="readonly"  />
					<input type="text" class="largeX text" name="memberNames" id="memberNames" readonly="readonly" checkType="string,1,200000" tip="接受会员不能为空！"/>
					<a href="javascript:void(-1)" class="aedit" onclick="memberSelect('memberIds','memberNames')">选择人员</a>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/coupon/saveCouponCode')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	</div>
	</div>
</body>
</html>