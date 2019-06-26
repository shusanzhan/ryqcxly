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
		<input type="hidden" name="cwAppmodifydataId" id="cwAppmodifydataId" value="${cwAppmodifydata.dbid }">
		<c:if test="${!empty(cwCustomer) }">
			<input type="hidden" name="cwCustomerId" id="cwCustomerId" value="${cwCustomer.dbid }">
		</c:if>
		<c:if test="${!empty(finCustomer) }">
			<input type="hidden" name="finCustomerId" id="finCustomerId" value="${finCustomer.dbid }">
		</c:if>
		<input type="hidden" name="status" id="status" value="3">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<!--                保有客户审批展示数据                  -->
			<c:if test="${!empty(cwCustomer) }">
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
			</c:if>
			<!--                多品牌客户审批展示数据                  -->
			<c:if test="${!empty(finCustomer) }">
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
					<td class="formTableTdLeft">申请人:&nbsp;</td>
					<td colspan="1">
						${cwAppmodifydata.appUserName }
					</td>
				</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">申请时间:&nbsp;</td>
				<td colspan="1">
					${cwAppmodifydata.appDateTime }
				</td>
				<td class="formTableTdLeft">修改原因:&nbsp;</td>
				<td colspan="1">
					${cwAppmodifydata.modifyReason }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea  name="approvalNote" id="approvalNote"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧"></textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#status').val(3);$.utile.submitAjaxForm('frmId','${ctx}/cwAppmodifydata/saveFinApproval')"	class="but butSave">同意</a> 
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#status').val(2);$.utile.submitAjaxForm('frmId','${ctx}/cwAppmodifydata/saveFinApproval')"	class="but butSave">驳回</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	
</script>
</html>