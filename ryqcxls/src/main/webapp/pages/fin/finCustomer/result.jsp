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
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">申请结果:&nbsp;</td>
				<td colspan="1">
					<select id="applyStatus" name="applyStatus" class="largeX text" onchange="showHiden()" checkType="integer,1">
						<option value="0">请选择...</option>
						<option value="2" ${customer.applyStatus==2?'selected="selected"':'' }>成功</option>
						<option value="3" ${customer.applyStatus==3?'selected="selected"':'' }>失败 </option>
					</select>
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr  height="42">
				<td class="formTableTdLeft">审批日期:&nbsp;</td>
				<td id="carColorLable" colspan="3">
					<input  type="text" name="applyDate" id="applyDate"	 class="large text" onfocus="WdatePicker()" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>' checkType="string,1" tip="请选择审批日期,不能为空">
					<span style="color: red">*</span>
				</td>
			</tr>
			<tbody id="contentTr" style="display: none;">
				<tr  height="42">
					<td class="formTableTdLeft">失败原因:&nbsp;</td>
					<td id="carColorLable">
						<select id="applyFailReasonId" name="applyFailReasonId" class="largeX text" >
							<option value="0">请选择...</option>
							<c:forEach var="applyFailReason" items="${applyFailReasons }">
								<option value="${applyFailReason.dbid }" >${applyFailReason.name }</option>
							</c:forEach>
						</select>
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="1">
					<textarea  name="note" id="note"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧">${finCustomer.note }</textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="if(validate1()){$.utile.submitAjaxForm('frmId','${ctx}/finCustomer/saveResult')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function validate1(){
		var applyStatus=$("#applyStatus").val();
		var applyFailReasonId=$("#applyFailReasonId").val();
		if(null!=applyStatus&&applyStatus==3){
			if(applyFailReasonId==null||applyFailReasonId=='0'){
				alert("请选择失败原因！");
				$("#applyFailReasonId").focus();
				return false;
			}
		}
		return true;
	}
	function showHiden(){
		var options=$("#applyStatus option:selected");
		var value=options[0].value;
		if(value==3){
			$("#contentTr").show();
		}else{
			$("#contentTr").hide();
		}
	}
	
</script>
</html>