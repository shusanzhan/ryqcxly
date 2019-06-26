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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
</style>
<title>工厂返利</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/rebateManagement/queryCarRebateRecordList'">车辆返利记录</a>-
<a href="javascript:void(-1);">编辑返利</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="rebateAndFinance.vinCode" id="vinCode" value="${param.vinCode }">
		<input type="hidden" name="rebateAndFinance.dbid" id="dbid" value="${rebateAndFinance.dbid }">
		<input type="hidden" name="factoryOrderId" id="factoryOrderDbid" value="${factoryOrder.dbid }">
		<input type="hidden" name="types" id="types" value="3">
		<input type="hidden" name="rebatePD" id="rebatePD" value="1">
		<c:if test="${empty(rebates) }">
			<input type="hidden" name="judge" id="judge" value='1'>
		</c:if>
		<c:if test="${!empty(rebates) }">
			<input type="hidden" name="judge" id="judge" value="2">
		</c:if>
		<c:if test="${empty rebateTypes||rebateTypes==null }" var="status">
			<div class="alert alert-info">
				<strong>提示!</strong> 无工厂返利类型.
			</div>
		</c:if>
		<c:if test="${!empty rebateTypes }">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<c:forEach var="rebateType" items="${rebateTypes }">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" >${rebateType.name}</td>
				</tr>
					<c:forEach var="childrenRebateType" items="${rebateType.childrenRebateType }">
					<c:set value="0" var="total"></c:set>
					<c:forEach var="rebate" items="${rebates}">
							<c:if test="${rebate.childrenRebateType eq childrenRebateType}">
								<c:set value="1" var="total"></c:set>
								<tr height="42">
									<td class="formTableTdLeft">${childrenRebateType.name}比例:&nbsp;</td>
									<td id="carModelLabel">
										<input type="hidden" name="id" value="${childrenRebateType.dbid }">
										<input type="hidden" name="name" value="${childrenRebateType.name }">
										<input type="text" name="rebateRatio" class="largeX text" id="rebateRatio"  checkType="float,0" canEmpty="Y" onblur="judge1(this)"  value="${rebate.rebateRatio }"  ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>%
									</td>
									<td class="formTableTdLeft">${childrenRebateType.name}返利金额:&nbsp;</td>
									<td id="carModelLabel">
										<input type="text" name="rebateMoney" class="largeX text" checkType="float,0"  canEmpty="Y"  id="rebateMoney"  value="${rebate.rebateMoney }" ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>元
									</td>
								</tr>
								<tr height="42">
									<td class="formTableTdLeft">付款期限:&nbsp;</td>
									<td id="carModelLabel"  colspan="3">
										<input type="text" name="rebateTerm" class="largeX text" checkType="integer,0" canEmpty="Y" id="rebateTerm"  value="${rebate.rebateTerm }" ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>天
									</td>
								</tr>
							</c:if>
					</c:forEach>
					<c:if test="${total eq 0 }">
						<tr height="42">
							<td class="formTableTdLeft">${childrenRebateType.name}比例:&nbsp;</td>
							<td id="carModelLabel">
								<input type="hidden" name="id" value="${childrenRebateType.dbid }">
								<input type="hidden" name="name" value="${childrenRebateType.name }">
								<input type="text" name="rebateRatio" class="largeX text"  checkType="float,0" canEmpty="Y"   id="rebateRatio" onblur="judge1(this)"  ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>%
							</td>
							<td class="formTableTdLeft">${childrenRebateType.name}返利金额:&nbsp;</td>
							<td id="carModelLabel">
								<input type="text" name="rebateMoney" class="largeX text" checkType="float,0" canEmpty="Y"  id="rebateMoney"  ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>元
							</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft">付款期限:&nbsp;</td>
							<td id="carModelLabel"  colspan="3">
								<input type="text" name="rebateTerm" class="largeX text"  checkType="integer,0" canEmpty="Y" id="rebateTerm"  ${factoryOrder.factoryRebateState eq 3?'readOnly':''}>天
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:forEach>
			</table>
		</c:if>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitFrm('frmId','${ctx}/rebateManagement/saveRebate')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function judge1(s){
	var va= $(s).val();
	if(va!=null && va!=''){
		if(va>100 || va<=0){
			$("#rebatePD").val(2);
			alert("比例不正确，请调整！");
		}else{
			$("#rebatePD").val(1);
		}
	}
}
//表单提交时验证和弹出确认对话框
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	var rebatePD = $("#rebatePD").val();
	if (validata == true) {
		if (rebatePD == 2) {
			alert("比例不正确，请调整！");
			return;
		}
	}
	$.utile.submitForm(frmId, url); 
}
</script>
</html>