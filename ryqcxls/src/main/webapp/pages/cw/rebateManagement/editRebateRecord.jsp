<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
</style>
<title>编辑返利记录</title>
</head>
<body class="bodycolor">
	<div class="location">
		<img src="${ctx}/images/homeIcon.png" /> &nbsp; <a
			href="javascript:void(-1);"
			onclick="window.parent.location.href='${ctx}/main/index'">首页</a>- <a
			href="javascript:void(-1);"
			onclick="window.location.href='${ctx}/rebateManagement/queryRebateRecordList'">返利记录</a>-
		<a href="javascript:void(-1);">编辑返利</a>
	</div>
	<div class="line"></div>
	<div class="frmContent">
		<form action="" name="frmId" id="frmId" target="_self">
			<input type="hidden" name="rebatePD" id="rebatePD" value="1">
			<table border="0" align="center" cellpadding="0" cellspacing="0"
				style="width: 92%;">
				<tr height="42">
					<td class="formTableTdLeft">${rebate.name}比例:&nbsp;</td>
					<td id="carModelLabel"><input type="hidden" name="rebate.dbid"
						value="${rebate.dbid }"> <input type="text"
						name="rebateRatio" class="largeX text" id="rebateRatio"
						checkType="float,0" canEmpty="Y" onblur="judge(this)"
						value="${rebate.rebateRatio }"
						${rebate.rebateState eq 3?'readOnly':''}>%</td>
					<td class="formTableTdLeft">${rebate.name}金额:&nbsp;</td>
					<td id="carModelLabel"><input type="text" name="rebateMoney"
						class="largeX text" checkType="float,0" canEmpty="Y"
						id="rebateMoney" value="${rebate.rebateMoney }"
						${rebate.rebateState eq 3?'readOnly':''}>元<span style="color:green">(工厂指导价【￥${rebate.factoryOrder.factoryPrice}】*返利比例%)</span></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">付款期限:&nbsp;</td>
					<td id="carModelLabel" colspan="3"><input type="text"
						name="rebateTerm" class="largeX text" checkType="integer,0"
						canEmpty="Y" id="rebateTerm" value="${rebate.rebateTerm }"
						${rebate.rebateState eq 3?'readOnly':''}>天</td>
				</tr>
			</table>
		</form>
		<div class="formButton">
			<a href="javascript:void(-1)"
				onclick="$.utile.submitFrm('frmId','${ctx}/rebateManagement/saveRebateRecord?rebateId=${rebate.dbid }')"
				class="but butSave">保&nbsp;&nbsp;存</a> <a href="javascript:void(-1)"
				onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
	</div>
</body>
<script type="text/javascript">
	function judge(s) {
		var va = $(s).val();
		if (va != null && va != '') {
			if (va > 100 || va <= 0) {
				$("#rebatePD").val(2);
				alert("比例不正确，请调整！");
			}else{
				$("#rebatePD").val(1);
			}
		}
	}
	$.utile.submitFrm = function(frmId, url) {
		var validata = validateForm(frmId);
		var rebatePD = $("#rebatePD").val();
		if (validata == true) {
			if (rebatePD == 2) {
				alert("比例不正确，请调整！");
				return;
			}
		}
		$.utile.submitForm(frmId, url);
	}
</script>
</html>