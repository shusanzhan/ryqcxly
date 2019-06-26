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
<title>客户流失审批</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${customerLastBussi.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="lastResult" id="lastResult" value="">
		<input type="hidden" name="type" id="type" value="${param.type }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" style="text-align: right;">结案情形:&nbsp;</td>
				<td colspan="3">
					<c:if test="${customer.lastResult==1 }">
						成交——购车
					</c:if>
					<c:if test="${customer.lastResult==2 }">
						流失——购买其它品牌产品等
					</c:if>
					<c:if test="${customer.lastResult==3 }">
						购车计划取消
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="text-align: right;">流失原因:&nbsp;</td>
				<td colspan="3">
					${customerLastBussi.customerFlowReason.name }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="text-align: right;">备注:&nbsp;</td>
				<td colspan="3">
					${customerLastBussi.note }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">驳回原因:&nbsp;</td>
				<td colspan="1">
					<textarea  name="notReason" id="notReason"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.notReason }</textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#lastResult').val(1);$.utile.submitAjaxForm('frmId','${ctx}/customerLastBussi/saveApproval')"	class="but butSave">同&nbsp;&nbsp;意</a> 
		<a id="approvalButton"  href="javascript:void(-1)"	onclick="$('#lastResult').val(2);$.utile.submitAjaxForm('frmId','${ctx}/customerLastBussi/saveApproval')"	class="but butSave">驳&nbsp;&nbsp;回</a> 
	</div>
</div>
</body>
</html>