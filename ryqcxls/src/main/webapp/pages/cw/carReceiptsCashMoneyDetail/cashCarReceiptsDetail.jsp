<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车款收银</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
.dis{
	color:#DCDCDC;
}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">订单提报（费用明细）</a>
</div>
<div class="line"></div>
<div class="frmContent">
<form action="" id="frmId" name="frmId" method="post">
<input type="hidden" readonly="readonly"    id="totalReceivables" name="settlementReceipts.totalReceivables" class="largeX text enable"></input>
<input type="hidden" readonly="readonly"    value="${orderContractExpenses.totalPrice }" name="settlementReceipts.totalcontractAmount" class="largeX text enable"></input>
<input type="hidden" name="orderContractExpenses.masterDecoreMoney" id="masterDecoreMoney" readonly="readonly" value="${orderContractExpenses.masterDecoreMoney }"   class="small text" style="color: red;" ></input>
<input type="hidden" name="orderContractExpenses.attachDecoreMoney" id="attachDecoreMoney" readonly="readonly" value="${orderContractExpenses.attachDecoreMoney }"  onkeyup="decoreTotal();orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="small text"  style="color: red;"></input>
<input type="hidden" readonly="readonly"    id="customerId" name="customerId" class="largeX text enable" value="${orderContractExpenses.customer.dbid}"></input>
<input type="hidden" readonly="readonly"    id="customerId" name="settlementReceipts.customer.dbid" class="largeX text enable" value="${orderContractExpenses.customer.dbid}"></input>
<input type="hidden" readonly="readonly" id="totalCollection" name="totalCollection" value="${orderContractExpenses.totalCollection}"></input>
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">合同基础信息</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">车型：&nbsp;</td>
		<td style="width:30%;color:red;" >
				${settlementReceipt.orderContractExpenses.customer.customerPidBookingRecord.brand.name}
				${settlementReceipt.orderContractExpenses.customer.customerPidBookingRecord.carSeriy.name}
				${settlementReceipt.orderContractExpenses.customer.customerPidBookingRecord.carModel.name}
				${settlementReceipt.orderContractExpenses.customer.customerPidBookingRecord.vinCode}</td>
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td style="width:30%;color:red;font-size: 20px" id="totalcontractAmount">${settlementReceipt.orderContractExpenses.totalPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">客户姓名：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.customer.name }</td>
		<td style="width:20%" >电话号码：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.customer.mobilePhone }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%"  id="orderMoney">${settlementReceipt.orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >销售代表：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.customer.user.realName }</td>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">车辆费用信息</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">经销商报价：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.salePrice }</td>
		<td style="width:20%" >裸车销售顾问结算价：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.carSalerPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">颜色溢价：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.colorPrice}</td>
		<td style="width:20%" >裸车销售价：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.carSalerPrice }</td>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">优惠明细</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">裸车现金优惠卷：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.cashBenefit}</td>
		<td style="width:20%" >未这让权限：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.noWllowancePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">特殊权限：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.specialPermPrice}</td>
		<td style="width:20%" >特殊权限说明：&nbsp;</td>
		<td style="width:30%">		
			<c:if test="${empty settlementReceipt.orderContractExpenses.specialPermNote}">
				无
			</c:if>
			<c:if test="${!empty settlementReceipt.orderContractExpenses.specialPermNote}">
				${orderContractExpenses.specialPermNote}
			</c:if>
		</td>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">保险明细</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">预收保费：&nbsp;</td>
		<td style="width:30%">0.0</td>
		<td style="width:20%" >续保押金：&nbsp;</td>
		<td style="width:30%">0.0</td>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">金融明细</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车方式：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.buyCarType==1?'现款':'分付' }</td>
		<td style="width:20%" >付款方式：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.payWay==1?'现金':'转账' }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">手续费：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.ajsxf }</td>
		<td style="width:20%" >首付款：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.sfk }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">贷款金额：&nbsp;</td>
		<td colspan="3" id="daikuan">${settlementReceipt.orderContractExpenses.daikuan }</td>
		<%-- <td span="2">首付款：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.sfk }</td> --%>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">定金装饰</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%" id="orderMoney">${settlementReceipt.orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >装饰款：&nbsp;</td>
		<td style="width:30%" id="decoreMoneyText">${settlementReceipt.orderContractExpenses.decoreMoney }</td>
	</tr>
	</table>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">总费用明细</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">预收款总额：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.advanceTotalPrice}</td>
		<td style="width:20%" >其他收费总额：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.otherFeePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">裸车销售价：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.carSalerPrice }</td>
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td style="width:30%">${settlementReceipt.orderContractExpenses.totalPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">应收总额：&nbsp;</td>
		<td style="width:30%;color:red;font-size:20px" id="totalReceivables1"></td>
		<td  colspan="2"  id="describe">&nbsp;</td>
	</tr>
	</table>
	<c:forEach var="settlementReceipts1" items="${settlementReceipts }"> 	
		<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
		<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<td width="100%" colspan="4" style="">收银明细</td>
		</tr>
		<tr height = "42">
			<td style="width:20%">收款日期：&nbsp;</td>
			<td style="width:30%">
					${settlementReceipts1.settlementDate}
			</td>
			<td style="width:20%">收据号：&nbsp;</td>
			<td style="width:30%">				
					${settlementReceipts1.receiptNumber}
			</td>
		</tr>
		<tr>
			<td style="width:20%">实收总额：&nbsp;</td>
			<td style="width:30%">					
					${settlementReceipts1.totalMoney}
			</td>
			<td style="width:20%">发票类型：&nbsp;</td>
			<td style="width:30%">
					${settlementReceipts1.childBillingType.name}
			</td>
		</tr>
		<tr>
			<td style="width:20%">开票金额：&nbsp;</td>
			<td style="width:30%">
				${settlementReceipts1.invoiceValue}
			</td>
			<td style="width:20%">开票类型：&nbsp;</td>
			<td style="width:30%">			
				${settlementReceipts1.openBillingType.name}
			</td>
		</tr>
			<tr>
				<td style="width:20%">收款人：&nbsp;</td>
				<td style="width:30%">					
					${settlementReceipts1.payee}
			</td>
			<td style="width:20%">摘要：&nbsp;</td>
			<td style="width:30%">
				<c:if test="${empty settlementReceipts1.abstract_}">
					无
				</c:if>
				<c:if test="${!empty settlementReceipts1.abstract_}">
					${settlementReceipts1.abstract_}
				</c:if>			
			</td>
		</tr>
		<tr>			
			<td >备注：&nbsp;</td>
			<td colspan="3">				
					<c:if test="${empty settlementReceipts1.remarks}">
						无
					</c:if>
					<c:if test="${!empty settlementReceipts1.remarks}">
						${settlementReceipts1.remarks}
					</c:if>
			</td>
		</tr>
	</table>
	</c:forEach>
	
	<div class="formButton" >
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.packexp.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
</script>
</html>
