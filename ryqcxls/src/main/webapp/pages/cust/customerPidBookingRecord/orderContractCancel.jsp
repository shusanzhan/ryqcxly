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
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>合同流失申请</title>
</head>
<body>
<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${customerPidBookingRecord.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerPidBookingRecord.dbid" id="dbid" value="${customerPidBookingRecord.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 640px">
			<tr height="42">
				<td class="formTableTdLeft" width="120">客户姓名:&nbsp;</td>
				<td width="450">
					${customer.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${customer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td id="carModelLabel">
					 ${customerLastBussi.brand.name} ${customerLastBussi.carSeriy.name}${customerLastBussi.carModel.name}
				</td>
			</tr>
			 <tr height="42">
				<td class="formTableTdLeft">流失原因:&nbsp;</td>
				<td colspan="3">
					<select id="customerpidFlowReasonId" name="customerpidFlowReasonId" class="text largeX" checkType="integer,1">
						<option>请选择...</option>
						<c:forEach var="customerpidFlowReason" items="${customerpidFlowReasons }">
							<option value="${customerpidFlowReason.dbid }">${customerpidFlowReason.name }</option>	
						</c:forEach>
					</select>
					<span style="color: red">*</span>
				</td>
			</tr>
			 <tr height="42">
				<td class="formTableTdLeft">流失原因:&nbsp;</td>
				<td colspan="3">
					<textarea   name="cancelNote" id="cancelNote" checkType="string,1" tip="请输入合同流失原因！"	 class="textarea largeXX text" title="流失原因"></textarea>
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/saveOrderContractCancel')"	class="but butSave">提交审批</a>
		<a href="javascript:void(-1)"	onclick="art.dialog.close(-1)"	class="but butCancle">取消</a>
	</div>
</div>
</body>
</html>