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
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashFinance/queryList'">金收银融列表</a>-
		<a href="javascript:void(-1);" onclick="javascript:void(-1);">金收银融列表</a>
<%-- <a href="javascript:void(-1);">
	<c:if test="${empty(finCustomer) }">添加贷款客户</c:if>
	<c:if test="${!empty(finCustomer) }">编辑贷款客户</c:if>
</a> --%>
</div>
<div class="line"></div>
<div class="frmContent">
		<form action="" name="frmId1" id="frmId1" >
		<input type="hidden" name="dbid" value="${finCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
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
				<td  colspan="3">
					${finCustomer.distributor.name }
				</td>
				<%-- <td class="formTableTdLeft" style="width:20%">部门:&nbsp;</td>
				<td style="width:30%">
					${departmentSelect }
				</td> --%>
			</tr>
			<%-- <tr height="42">
				<td class="formTableTdLeft" style="width:20%">区域:&nbsp;</td>
				<td style="width:30%">
					${departmentSelect }
				</td>
				<td class="formTableTdLeft" style="width:20%">销售公司:&nbsp;</td>
				<td style="width:30%">
					${saleCompany.name }
				</td>
			</tr> --%>
			<!-- <tr height="42">
				
			</tr> -->
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
		<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">贷款费用</td>
		</tr>
		 <tr height="42">
				<td class="formTableTdLeft" style="width:20%">车价:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.carPrice}</td>
				<td class="formTableTdLeft" style="width:20%">开票价:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.kaiPiaoPrice }</td>
			</tr> 
		<tr height="42">
				<td class="formTableTdLeft" style="width:20%">贷款金额:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.loanPrice }</td>
				<td class="formTableTdLeft" style="width:20%">贷款产品:&nbsp;</td>
				<td style="width:30%">${finCustomer.finCustomerLoan.finProduct.name}</td>
		</tr> 
		</table>	
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:98%">
		<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">收银信息</td>
		</tr>
		<tr height = "42">
			<td class="formTableTdLeft">收款日期：&nbsp;</td>
			<td>	${finCustomer.cashDate}</td>
			<td class="formTableTdLeft">收据号：&nbsp;</td>
			<td>	${finCustomer.receiptNumber}</td>
	</tr>
		<tr>
			<td class="formTableTdLeft">实收总额：&nbsp;</td>
			<td>	${finCustomer.amountCollected}</td>
			<td class="formTableTdLeft">发票类型：&nbsp;</td>
			<td>	${finCustomer.childBillingType.name}</td>
		</tr>
	<tr>
		<td class="formTableTdLeft">开票金额：&nbsp;</td>
			<td>${finCustomer.invoiceValue}</td>
			<td class="formTableTdLeft">摘要：&nbsp;</td>
			<td>${finCustomer.abstract_ }</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">收款人：&nbsp;</td>
			<td>${finCustomer.payee }</td>
			<td >备注：&nbsp;</td>
			<td>${finCustomer.cashRemark}</td>
		</tr>
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