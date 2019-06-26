<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
</style>
<title>预收明细</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/advancePayment/queryCashierList'">预收明细</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">明细</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId" id="frmId" >
		<input type="hidden" name="bill.billProjectId" id="insuranceDbid">
		<input type="hidden" name="dbid" id="dbid">
		<input type="hidden" name="bill.custId" id="custId">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">预收信息</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >客户姓名:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.custName}
				</td>
				<td class="formTableTdLeft" style="width:20%" >客户电话:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.custTel}
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" style="width:20%">创建来源:&nbsp;</td>
				<td>
					<c:if test ="${advancePayment.createSource==1}">
						订单创建
					</c:if>
					<c:if test = "${advancePayment.createSource==2}">
					   收款创建
					</c:if>
				</td>
				<td class="formTableTdLeft" style="width:20%" >客户类型:&nbsp;</td>
				<td>
					<c:if test ="${advancePayment.custType==1}">
						展厅（网销客户）
					</c:if>
					<c:if test = "${advancePayment.custType==2}">
					  二网客户
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" style="width:20%" >收款类别:&nbsp;</td>
				<td>
					${advancePayment.childReceivablesType.name}
				</td>
				<td class="formTableTdLeft" style="width:20%">收款项目:&nbsp;</td>
				<td>
					${advancePayment.itemName }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">本笔总额:&nbsp;</td>
				<td style="width:30%" >
					<span style="color: red;">
						<c:if test="${empty advancePayment.totalMoney}">
							0.0
						</c:if>
						<c:if test="${!empty advancePayment.totalMoney}">
							${advancePayment.totalMoney}
						</c:if>
					</span>
				</td>
				<td class="formTableTdLeft" style="width:20%" >销售人员:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.salesManName }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >创建人:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.creator }
				</td>
				<td class="formTableTdLeft" style="width:20%">创建日期:&nbsp;</td>
				<td style="width:30%">
					<fmt:formatDate value="${advancePayment.createTime }"/>
				</td>	
			</tr>
		<tr height = "42">
			<td class="formTableTdLeft">备注:&nbsp;</td>
			<td colspan="3">
				${advancePayment.remarks }
			</td>
	</tr>
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">收费信息</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
				<td style="width:30%">
					${cashier.receiptNumber}
				</td>
				<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
				<td style="width:30%">
					${cashier.orderNo}
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
				<td style="width:30%">
					<span style="color: red;">
						<c:if test="${empty cashier.amountCollected}">
							0.0
						</c:if>
						<c:if test="${!empty cashier.amountCollected}">
							${cashier.amountCollected}
						</c:if>
					</span>
				</td>
				<td class="formTableTdLeft">开票金额:&nbsp;</td>
				<td>
					<span style="color: red;">
						<c:if test="${empty cashier.openBillingMoney}">
							0.0
						</c:if>
						<c:if test="${!empty cashier.openBillingMoney}">
							${cashier.openBillingMoney}
						</c:if>
					</span>
				</td>
			</tr>	
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
				<td style="width:30%">
					<c:if test="${empty(cashier.openBillingType) }">
						无
					</c:if>
					${cashier.openBillingType.name }
				</td>
				<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
				<td style="width:30%">
					${cashier.childBillingType.name }
				</td>
			</tr>
			<tr height = "42">
				<td class="formTableTdLeft">收银时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${cashier.cashierTime}"/> 
				</td>
				<td class="formTableTdLeft">收款人:&nbsp;</td>
				<td>
					${cashier.payee}
				</td>
			</tr>
			<tr height = "42">
				<td class="formTableTdLeft">创建时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${cashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
				</td>
				<td class="formTableTdLeft">修改时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${cashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
				</td>
			</tr>
		<tr>
			<td class="formTableTdLeft">支付方式:&nbsp;</td>
				<td colspan="3">
					<c:forEach var="paymentTypeAndMoney" items="${paymentTypeAndMoneys }">
						${paymentTypeAndMoney.childPayTypeName }:<span style="color: red">${paymentTypeAndMoney.receiveMoney }</span>&#12288;
					</c:forEach>
				</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">摘要:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty cashier.abstract_}">
						无
					</c:if>
					<c:if test="${!empty cashier.abstract_}">
						${cashier.abstract_ }
					</c:if>
				</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty cashier.cashRemark}">
						无
					</c:if>
					<c:if test="${!empty cashier.cashRemark}">
						${cashier.cashRemark }
					</c:if>
				</td>
		</tr>
	</table>
		<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
</script>
</html>