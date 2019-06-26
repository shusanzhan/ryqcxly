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
   	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashReceipt/queryCashierList'">车款明细</a>-
   	<a href="javascript:void(-1)" class="current">明细</a>
</div>
<div class="line"></div>
<div class="frmContent">
<form action="" id="frmId" name="frmId" method="post">
<c:set value="${orderContractExpenses.customer}" var="customer"></c:set>
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">合同基础信息</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">车型：&nbsp;</td>
		<td style="width:30%;color:red;" >
				${customer.customerPidBookingRecord.brand.name}
				${customer.customerPidBookingRecord.carSeriy.name}
				${customer.customerPidBookingRecord.carModel.name}
				${customer.customerPidBookingRecord.vinCode}</td>
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td style="width:30%;color:red;font-size: 20px" id="totalcontractAmount">${orderContractExpenses.totalPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">客户姓名：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.name }</td>
		<td style="width:20%" >电话号码：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.mobilePhone }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%"  id="orderMoney">${orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >销售代表：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.user.realName }</td>
	</tr>
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">车辆费用信息</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">经销商报价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.salePrice }</td>
		<td style="width:20%" >裸车销售顾问结算价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">颜色溢价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.colorPrice}</td>
		<td style="width:20%" >裸车销售价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
	</tr>
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td width="100%" colspan="4" style="">优惠明细</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">裸车现金优惠：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.cashBenefit}</td>
		<td style="width:20%" >未这让权限：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.noWllowancePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">特殊权限：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.specialPermPrice}</td>
		<td style="width:20%" >特殊权限说明：&nbsp;</td>
		<td style="width:30%">		
			<c:if test="${empty orderContractExpenses.specialPermNote}">
				无
			</c:if>
			<c:if test="${!empty orderContractExpenses.specialPermNote}">
				${orderContractExpenses.specialPermNote}
			</c:if>
		</td>
	</tr>
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
		<td style="width:30%">${orderContractExpenses.buyCarType==1?'现款':'分付' }</td>
		<td style="width:20%" >付款方式：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.payWay==1?'现金':'转账' }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">手续费：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.ajsxf }</td>
		<td style="width:20%" >首付款：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.sfk }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">贷款金额：&nbsp;</td>
		<td colspan="3" id="daikuan">${orderContractExpenses.daikuan }</td>
	</tr>
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<td width="100%" colspan="4" style="">定金装饰</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%" id="orderMoney">${orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >装饰款：&nbsp;</td>
		<td style="width:30%" id="decoreMoneyText"></td>
	</tr>
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<td width="100%" colspan="4" style="">总费用明细</td>
		</tr>
	<tr height = "42">
		<td style="width:20%">预收款总额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.advanceTotalPrice}</td>
		<td style="width:20%" >其他收费总额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.otherFeePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">裸车销售价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
		<td style="width:20%">开票金额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td colspan="3">${orderContractExpenses.totalPrice }</td>
	</tr>
	<c:forEach var="cashier" items="${cashiers }">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">${cashier.orderNo} 收费信息</td>
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
					<ystech:cashierPay orderNo="${cashier.orderNo }"/>
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
		</c:forEach>
		<c:if test="${orderContractExpenses.isCorrect eq 2}">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">修正记录</td>
			</tr>
			<tr height = "42">
				<td class="formTableTdLeft">修正金额:&nbsp;</td>
				<td>
					<span style="color:red">${orderContractExpenses.totalReceivables-orderContractExpenses.totalCollection }</span>
				</td>
				<td class="formTableTdLeft">修正备注:&nbsp;</td>
				<td>
					${orderContractExpenses.correctRemark }
				</td>
			</tr>
		</c:if>
	</table>
	<div class="formButton" >
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
</html>
