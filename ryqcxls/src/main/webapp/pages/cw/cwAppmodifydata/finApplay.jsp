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
<title>申请结果</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="finCustomerId" id="finCustomerId" value="${finCustomer.dbid }">
		<input type="hidden" name="type" id="type" value="1">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td colspan="1">
					<input  type="text" readonly="readonly" name="custName" 	 class="large text" value='${finCustomer.name }' checkType="string,1" tip="客户姓名">
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr  height="42">
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td id="carColorLable" colspan="3">
					<input  type="text" readonly="readonly" name="mobilePHone" 	 class="large text" value='${finCustomer.mobilePhone }' checkType="string,1" tip="联系电话">
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">修改原因:&nbsp;</td>
				<td colspan="1">
					<textarea  name="modifyReason" id="modifyReason"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧"></textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/cwAppmodifydata/saveFinApply')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	
</script>
</html>