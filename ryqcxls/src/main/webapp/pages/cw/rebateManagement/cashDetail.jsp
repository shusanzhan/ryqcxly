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
<link rel="stylesheet"
	href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript"
	src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"
	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript"
	src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
table {
	border-top: 1px solid #cccccc;
	border-left: 1px solid #cccccc;
}

table th, table td {
	border-bottom: 1px solid #cccccc;
	border-right: 1px solid #cccccc;
}

.frmContent form table tr td {
	padding-left: 5px;
}

#noLine {
	border-top: 0;
	border-left: 0;
}

#noLine td {
	border: 0;
}

[class^="icon-"], [class*=" icon-"] {
	background-image: url("../images/bootstrap/glyphicons-halflings.png");
	background-position: 14px 14px;
	background-repeat: no-repeat;
	display: inline-block;
	height: 14px;
	line-height: 14px;
	margin-top: 1px;
	vertical-align: text-top;
	width: 14px;
}

[class^="icon-"], [class*=" icon-"] {
	background-image: url("../images/bootstrap/glyphicons-halflings.png");
	background-position: 14px 14px;
	background-repeat: no-repeat;
	display: inline-block;
	height: 14px;
	line-height: 14px;
	margin-top: 1px;
	vertical-align: text-top;
	width: 14px;
}

.icon-remove {
	background-position: -312px 0;
}

.ac_results {
	width: 460px;
}

.dis {
	color: #DCDCDC;
}

.cust {
	padding: 5px 8px;
	border: 1px solid #01AAED;
	color: #01AAED;
	border-radius: 14px;
	margin-right: 5px;
	margin-bottom: 5px;
	margin-top: 5px;
	display: inline-block;
}
</style>
<title>工厂返利收银明细</title>
</head>
<body class="bodycolor">
	<div class="location">
		<img src="${ctx}/images/homeIcon.png" /> &nbsp; <a
			href="javascript:void(-1);"
			onclick="window.parent.location.href='${ctx}/main/index'">首页</a>- <a
			href="javascript:void(-1);"
			onclick="window.location.href='${ctx}/rebateManagement/queryCashierList'">工厂车辆返利明细</a>-
		<a href="#">明细</a>
	</div>
	<div class="line"></div>
	<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0"
			style="width: 98%;">
			<tr height="40"
				style="background-color: #eeeeee; border-color: #eeeeee; font-size: 16px; font-weight: bold;">
				<td width="100%" colspan="4" style="">车辆信息</td>
			</tr>
			<tr height="40">
				<td class="formTableTdLeft" style="width: 20%">VIN码:&nbsp;</td>
				<td style="width: 30%">
					<!-- <input type="text" name="bill.custName" id="custName" onfocus="autoInfo('custName')" placeholder="请输入车辆的VIN码" class="large text" title="vin码" checkType="string,1,30" tip="VIN码不能为空"/><span style="color:red;">*</span> -->
					${factoryOrder.vinCode }
				</td>
				<td class="formTableTdLeft" style="width: 20%">车辆名称:&nbsp;</td>
				<td style="width: 30%">
					<!-- <input type="text" name="carName" id="carName" class="large text" title="车辆名称" checkType="string,1,30" tip="车辆名称" readonly="readonly"> -->
					${factoryOrder.carSeriy.name}${factoryOrder.carModel.name }${factoryOrder.carColor.name }
				</td>
			</tr>
			<tr height="40"
				style="background-color: #eeeeee; border-color: #eeeeee; font-size: 16px; font-weight: bold;">
				<td width="100%" colspan="4" style="">工厂返利信息</td>
			</tr>
			<c:forEach var="rebate" items="${factoryOrder.rebate}">
				<tr height="40">
					<td class="formTableTdLeft">${rebate.name }金额：&nbsp;</td>
					<td>${rebate.rebateMoney }</td>
					<td class="formTableTdLeft">${rebate.name }实收金额：&nbsp;</td>
					<td><c:if test="${empty rebate.realRebateMoney }">
						0.0
					</c:if> <c:if test="${!empty rebate.realRebateMoney }">
						${rebate.realRebateMoney }
					</c:if></td>
				</tr>
			</c:forEach>
			<c:forEach var="rebateCashier" items="${rebateCashiers }">
				<tr height="40"
					style="background-color: #eeeeee; border-color: #eeeeee; font-size: 16px; font-weight: bold;">
					<td width="100%" colspan="4" style="">收费信息</td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft" style="width: 20%">收据号:&nbsp;</td>
					<td style="width: 30%">${rebateCashier.receiptNumber}</td>
					<td class="formTableTdLeft" style="width: 20%">订单号:&nbsp;</td>
					<td style="width: 30%">${rebateCashier.orderNo}</td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft" style="width: 20%">收款金额:&nbsp;</td>
					<td style="width: 30%"><span style="color: red;"> <c:if
								test="${empty rebateCashier.amountCollected}">
							0.0
						</c:if> <c:if test="${!empty rebateCashier.amountCollected}">
							${rebateCashier.amountCollected}
						</c:if>
					</span></td>
					<td class="formTableTdLeft">开票金额:&nbsp;</td>
					<td><span style="color: red;"> <c:if
								test="${empty rebateCashier.openBillingMoney}">
							0.0
						</c:if> <c:if test="${!empty rebateCashier.openBillingMoney}">
							${rebateCashier.openBillingMoney}
						</c:if>
					</span></td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft" style="width: 20%">开票类型:&nbsp;</td>
					<td style="width: 30%"><c:if
							test="${empty(rebateCashier.openBillingType) }">
						无
					</c:if> ${rebateCashier.openBillingType.name }</td>
					<td class="formTableTdLeft" style="width: 20%">发票类型:&nbsp;</td>
					<td style="width: 30%">${rebateCashier.childBillingType.name }
					</td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft">收银时间:&nbsp;</td>
					<td><fmt:formatDate value="${rebateCashier.cashierTime}" /></td>
					<td class="formTableTdLeft">收款人:&nbsp;</td>
					<td>${rebateCashier.payee}</td>
				</tr>
				<%-- <tr height="40">
					<td class="formTableTdLeft">创建时间:&nbsp;</td>
					<td><fmt:formatDate value="${rebateCashier.createTime}"
							pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate></td>
					<td class="formTableTdLeft">修改时间:&nbsp;</td>
					<td><fmt:formatDate value="${rebateCashier.modifyTime}"
							pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate></td>
				</tr> --%>
				<tr height="40">
					<td class="formTableTdLeft">支付方式:&nbsp;</td>
					<td colspan="3"><ystech:cashierPay
							orderNo="${rebateCashier.orderNo }" /></td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft">收银车辆返利:&nbsp;</td>
					<td colspan="3">${rebateCashier.factoryOrderNames }</td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft">摘要:&nbsp;</td>
					<td colspan="3"><c:if test="${empty rebateCashier.abstract_}">
						无
					</c:if> <c:if test="${!empty rebateCashier.abstract_}">
						${rebateCashier.abstract_ }
					</c:if></td>
				</tr>
				<tr height="40">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3"><c:if test="${empty rebateCashier.cashRemark}">
						无
					</c:if> <c:if test="${!empty rebateCashier.cashRemark}">
						${rebateCashier.cashRemark }
					</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="formButton">
		<a href="javascript:void(-1)" onclick="window.history.go(-1)"
			class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
</body>
<script type="text/javascript">
	
</script>
</html>