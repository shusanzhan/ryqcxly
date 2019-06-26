<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑支付方式</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
      	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
      	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/openBillingType/queryList'">开票类型列表</a>-
	<c:if test="${empty openBillingType }">
		<a href="#">添加开票类型</a>
	</c:if>
	<c:if test="${!empty openBillingType}">
		<a href="#">编辑开票类型</a>
	</c:if>
</div>
<div class="frmContent">
<form  method="post"  action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${openBillingType.dbid }" id="dbid" name="openBillingType.dbid">
	<input type="hidden" value="${openBillingType.createTime }" id="createTime" name="openBillingType.createTime">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<tr height="42">
		<td class="formTableTdLeft" >名称：</td>
		<td>
			<c:choose>
				<c:when test="${openBillingType.addDataState eq 1}">
					<input type="text" class="largeX text" name="openBillingType.name"	id="name" readonly="readonly" value="${openBillingType.name }"  checkType="string,1,20"  tip="请输入开票类型名称！"  />
				</c:when>
				<c:otherwise>
					<input type="text" class="largeX text" name="openBillingType.name"	id="name" value="${openBillingType.name }"  checkType="string,1,20"  tip="请输入开票类型名称！"  />
				</c:otherwise>
			</c:choose>
			<span style="color: red">*</span>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >税率：</td>
		<td>
			<input type="text" class="largeX text" name="openBillingType.taxRate"	id="taxRate" value="${openBillingType.taxRate }"  checkType="float,0"  tip="请输入税率！"  />
			<span style="color:green">%</span>
			注：用于计算成本使用
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >排序：</td>
		<td>
			<input type="text" class="largeX text" name="openBillingType.orderNum" id="orderNum"  value="${openBillingType.orderNum }" checkType="integer"  canEmpty="Y" tip="请输入排序号！"/>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >备注：</td>
		<td>
			<input type="text" class="largeX text" name="openBillingType.note"	 id="note"  value="${openBillingType.note }" />
 		</td>
	</tr>
	</table>
</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitFrm('frmId','${ctx}/openBillingType/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript">
$.utile.submitFrm = function(frmId,url) {
    var validata = validateForm(frmId);
	var taxRate = $("#taxRate").val();
	if (validata == true) {
		if(taxRate<0||taxRate>100){
			alert("税率有误，请调整！");
			return;
		}
	}
	$.utile.submitForm('frmId','${ctx}/openBillingType/save'); 
}
</script>
</html>
