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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>影像资料审批</title>
</head>
<body class="bodycolor">
	<!-- <div class="alert alert-error ">
		<strong>提示!</strong>成交客户系统将会把客户级别更改为O级，流失客户系统将会把客户级别更改为L级
	</div> -->
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
		<input type="hidden" id="status" name="status" value="">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="1">
					<textarea  name="dis" id="dis"	style="height: 120px;width: 420px;" class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧,最少为两个字符"></textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#status').val(4);$.utile.submitAjaxForm('frmId','${ctx}/customerImage/dealResult')"	class="but butSave">审批通过</a> 
		<a id="approvalButton" href="javascript:void(-1)"	onclick="$('#status').val(3);$.utile.submitAjaxForm('frmId','${ctx}/customerImage/dealResult')"	class="but butSave">重新上传</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>