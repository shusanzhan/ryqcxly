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
<title>成交结果</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户跟踪信息</a>
</div>
 <!--location end-->
<div class="line"></div>
	<br>
	<div class="alert alert-error ">
		<strong>提示!</strong>流失客户系统将会把客户级别更改为L级
	</div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="customerId" value="${customer.dbid }" id="customerId"></input>
		<input type="hidden" name="lastResult" value="2" id="lastResult"></input>
		<input type="hidden" name="type" value="${param.type }" id="type"></input>
		<input type="hidden" name="customerLastBussi.dbid" id="dbid" value="${customerLastBussi.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tbody id="customerFlowReasonTr" >
				<tr  height="42">
					<td class="formTableTdLeft">流失原因:&nbsp;</td>
					<td >
						<select id="customerFlowReasonId" name="customerFlowReasonId" class="largeX text"  >
							<option value="0">请选择...</option>
							<c:forEach var="customerFlowReason" items="${customerFlowReasons }">
								<option value="${customerFlowReason.dbid }" >${customerFlowReason.name }</option>
							</c:forEach>
						</select>
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="1">
					<textarea  name="customerLastBussi.note" id="note"	 class="textarea largeXX text"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.note }</textarea>	
					<span style="color: red">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a id="approvalButton"  href="javascript:void(-1)"	onclick="if(validate2()){$.utile.submitAjaxForm('frmId','${ctx}/customerLastBussi/save')}"	class="but butSave">提交经理审核</a> 
		<a id="" href="javascript:void(-1)"	onclick="window.history.go(-1)"	class="but butCancle">返回</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function validate2(){
		var customerFlowReasonId=$("#customerFlowReasonId").val();
		if(null==customerFlowReasonId||customerFlowReasonId==""||customerFlowReasonId=="0"){
			alert("请选择流失原因！");
			return false;
		}
		var note=$("#note").val();
		$("#carColor").removeAttr("checkType");
		if(null==note||note==""){
			alert("请输入备注信息！");
			$("#note").focus();
			return false;
		}
		return true;
	}
</script>
</html>