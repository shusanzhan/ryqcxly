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
.dis{
	color:#DCDCDC;
}
</style>
<title>金融收银</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashFinance/queryCashierList'">金融明细</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">明细</a>
<%-- <a href="javascript:void(-1);">
	<c:if test="${empty(finCustomer) }">添加贷款客户</c:if>
	<c:if test="${!empty(finCustomer) }">编辑贷款客户</c:if>
</a> --%>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId1" id="frmId1" >
		<input type="hidden" name="dbid" value="${finCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">贷款人信息</td>
		</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">申请人:&nbsp;</td>
				<td style="width:30%">${finCustomer.name }</td>
				<td class="formTableTdLeft" style="width:20%">申请人电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.mobilePhone }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">身份证号:&nbsp;</td>
				<td style="width:30%">${finCustomer.icard }</td>
				<td class="formTableTdLeft" style="width:20%">地址:&nbsp;</td>
				<td style="width:30%">
					${finCustomer.address }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">共申人:&nbsp;</td>
				<td style="width:30%">${finCustomer.commName }</td>
				<td class="formTableTdLeft" style="width:20%">共申人电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.commMobilePhone }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">车型:&nbsp;</td>
				<td style="width:30%">
					${finCustomer.carSeriyName }
				</td>
				<td class="formTableTdLeft" style="width:20%">销售员:&nbsp;</td>
				<td style="width:30%">${finCustomer.saler }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">销售员电话:&nbsp;</td>
				<td style="width:30%">${finCustomer.salerPhone }</td>
				<td class="formTableTdLeft" style="width:20%">车辆销售商：</td>
				<td style="width:30%">
					${finCustomer.distributor.name }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:20%">贷款金额：</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.loanPrice }</td>
				<td class="formTableTdLeft" style="width:20%">贴息金额：</td>
				<td  style="width:30%">
					<ystech:discountMoney custId="${finCustomer.customer.dbid }"/>
				</td>
			</tr>
		<tr>
			<td class="formTableTdLeft" style="width:20%">实际利息:&nbsp;</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${finCustomer.finCustomerLoan.actDiscountPrice}</span>
			</td>
			<td class="formTableTdLeft" style="width:20%">公司贴息:&nbsp;</td>
			<td style="text-align:lcenter;">
				${finCustomer.finCustomerLoan.companyDiscountPrice}
			</td>
		</tr>
		<tr height="42">
			<td class="formTableTdLeft" style="width:20%">销售收取贴息：&nbsp;</td>
			<td 	colspan="3">
				${finCustomer.finCustomerLoan.salerDiscountPrice}
			</td>
		</tr>
			<c:forEach var="cashier" items="${cashiers }">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<c:if test="${cashier.typeId eq 5}">
					<td width="100%" colspan="4" style="">金融收费信息</td>
				</c:if>
				<c:if test="${cashier.typeId eq 7}">
					<td width="100%" colspan="4" style="">金融贴息收费信息</td>
				</c:if>
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
		
	</table>
	
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</form>
	</div>
</body>
<script type="text/javascript">
</script>
</html>