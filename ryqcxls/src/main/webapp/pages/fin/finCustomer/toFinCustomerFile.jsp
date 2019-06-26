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
<title>流失客户</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="finCustomerId" id="finCustomerId" value="${finCustomer.dbid }">
		<input type="hidden" name="type" id="type" value="${param.type }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr>
				<td class="formTableTdLeft" >姓名：</td>
				<td >
					${finCustomer.name }
					(
						<c:if test="${finCustomer.customerType==1 }">
							<span style="color: #56a845">保有</span>
						</c:if>
						<c:if test="${finCustomer.customerType==2 }">
							<span style="color: #ff6700">多品牌</span>
						</c:if>
					)
				</td>
				<td class="formTableTdLeft">联系电话：</td>
				<td  align="left">
					${finCustomer.mobilePhone }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >成交状态：</td>
				<td>
						<c:if test="${finCustomer.customerType==1 }">
							<c:if test="${finCustomer.fileStatus==1 }">
								<span style="color: red;">物流未归档</span>
							</c:if>
							<c:if test="${finCustomer.fileStatus==2 }">
								<span style="color: green;">成交</span>
							</c:if>
						</c:if>
						<c:if test="${finCustomer.customerType==2 }">
							<span style="color: green">多品牌客户</span>
						</c:if>
					
				</td>
				<td class="formTableTdLeft" >上户状态：</td>
				<td>
					<c:if test="${finCustomer.householdRegStatus==1 }">
						<span style="color: red;">待上户</span>
					</c:if>
					<c:if test="${finCustomer.householdRegStatus==2 }">
						<span style="color: green;">已上户</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >放款状态：</td>
				<td>
					<c:if test="${finCustomer.loanStatus==1 }">
						<span style="color: red;">待放款</span>
					</c:if>
					<c:if test="${finCustomer.loanStatus==2 }">
						<span style="color: green;">已放款</span>
					</c:if>
				</td>
				<td class="formTableTdLeft" >申请结果：</td>
				<td>
					<c:if test="${finCustomer.applyStatus==1 }">
						<span style="color: red;">审批中...</span>
					</c:if>
					<c:if test="${finCustomer.applyStatus==3 }">
						<span style="color: red;">失败</span>
					</c:if>
					<c:if test="${finCustomer.applyStatus==2 }">
						<span style="color: green;">通过</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >邮寄状态：</td>
				<td>
					<c:if test="${finCustomer.mailStatus==1 }">
						<span style="color: red;">待邮寄</span>
					</c:if>
					<c:if test="${finCustomer.mailStatus==2 }">
						<span style="color: green;">已邮寄</span>
					</c:if>
				</td>
			</tr>
			<tr  height="42">
				<td class="formTableTdLeft">归档日期:&nbsp;</td>
				<td id="carColorLable" colspan="3">
					<input  type="text" name="finCustomerFileDate" id="finCustomerFileDate"	 class="large text" onfocus="WdatePicker()" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>' checkType="string,1" tip="请选择归档日期,不能为空">
					<span style="color: red">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td  colspan="3">
					<textarea  name="note" id="note"	 class="textarea largeXXX text"  title="" checkType="string,2" tip="请填写一点备注吧">${finCustomer.note }</textarea>	
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="if(validateFrm()){$.utile.submitAjaxForm('frmId','${ctx}/finCustomer/saveToFinCustomerFile')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function validateFrm(){
		var fileStatus="${finCustomer.fileStatus}";
		var customerType="${finCustomer.customerType}";
		var householdRegStatus="${finCustomer.householdRegStatus}";
		var loanStatus="${finCustomer.loanStatus}";
		var applyStatus="${finCustomer.applyStatus}";
		var mailStatus="${finCustomer.mailStatus}";
		if(applyStatus==1){
			alert("申请还在审批中...,客户不能归档");
			return false;
		}
		if(applyStatus==3){
			alert("申请审批失败,客户不能归档");
			return false;
		}
		if(customerType==1){
			/* if(fileStatus==1){
				alert("物流未出库归档，请等待物流出库......");
				return true;
			} */
		}
		if(householdRegStatus==1){
			alert("客户未登记上户，客户不能归档");
			return false;
		}
		if(mailStatus==1){
			alert("客户未邮寄资料，客户不能归档");
			return false;
		}
		if(loanStatus==1){
			alert("放款未登记，客户不能归档");
			return false;
		}
		return true;
	}
</script>
</html>