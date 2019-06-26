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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>保险险种添加</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="customerOutFlowRecord.dbid" id="dbid" value="${customerOutFlowRecord.dbid }">
		<input type="hidden" name="insCustomerId" id="insCustomerId" value="${insCustomer.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >${insCustomer.name}</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td>
					${insCustomer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					${insCustomer.brand.name }
					${insCustomer.carseriy.name }
					${insCustomer.carModel.name }
				</td>
				<td class="formTableTdLeft">vin码:&nbsp;</td>
				<td >
					${insCustomer.vinCode}
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">流失原因:&nbsp;</td>
				<td colspan="3">
					${customerOutFlowRecord.customerOutFlowReason.name }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					${customerOutFlowRecord.note }
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="art.dialog.close(-1)" class="but butCancle">关&nbsp;&nbsp;闭</a>
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>