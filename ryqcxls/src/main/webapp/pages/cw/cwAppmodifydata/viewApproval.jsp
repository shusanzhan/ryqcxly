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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
	padding-left: 5px;
	font-size: 14px;
	height: 32px;
}
.frmContent form table tr td {
    padding-left: 5px;
    font-size: 14px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
</style>
<title>审批记录</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<c:if test="${!empty(cwCustomer) }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<c:set value="${cwCustomer.factoryOrder }" var="factoryOrder"></c:set>
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td colspan="1">
					${cwCustomer.custName }
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td colspan="1">
					${cwCustomer.customer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td colspan="1">
					${factoryOrder.brand.name }
					${factoryOrder.carSeriy.name }
					${factoryOrder.carModel.name }
				</td>
				<td class="formTableTdLeft">车架号:&nbsp;</td>
				<td colspan="1">
					${factoryOrder.vinCode }
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${param.type==1}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td colspan="1">
					${finCustomer.name }
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td colspan="1">
					${finCustomer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td colspan="1">
					${finCustomer.carSeriyName }
				</td>
				<td class="formTableTdLeft">手续费:&nbsp;</td>
				<td colspan="1">
					${finCustomer.finCustomerLoan.loanPrice }
				</td>
			</tr>
		</table>
	</c:if>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 8px">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td width="4%" style="text-align: center;">序号</td>
				<td width="8%" style="text-align: center;">申请人</td>
				<td width="12%" style="text-align: center;">发起时间</td>
				<td width="16%" style="text-align: center;">理由</td>
				<td  width="6%" style="text-align: center;">审批人</td>
				<td width="8%" style="text-align: center;">审批时间</td>
				<td  width="8%" style="text-align: center;">备注</td>
				<td width="16%" style="text-align: center;">审批记录</td>
			</tr>
			<c:forEach var="cwAppmodifydata" items="${cwAppmodifydatas }" varStatus="i">
				<tr height="42">
				<td align="center">${i.index+1 }</td>
				<td style="padding: 5px;">
					${cwAppmodifydata.appUserName }
				</td>
				<td align="center">
					<fmt:formatDate value="${cwAppmodifydata.appDateTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td align="center">
					${cwAppmodifydata.modifyReason }
				</td>
				<td align="center">
					${cwAppmodifydata.approvalPerson }
				</td>
				<td align="center">
					<fmt:formatDate value="${cwAppmodifydata.approvalDateTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td align="center">
					${cwAppmodifydata.approvalNote }
				</td>
				<td align="center">
					<c:if test="${cwAppmodifydata.status==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${cwAppmodifydata.status==2 }">
						<span style="color: red">审批驳回</span>
					</c:if>
					<c:if test="${cwAppmodifydata.status==3 }">
						<span style="color: green;">通过</span>
					</c:if>
				</td>
			</c:forEach>
		</table>
	<div class="formButton" style="width: 100%;">
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关闭</a>
	</div>
	</div>
</body>
</html>