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
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
	<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<input type="text" class="midea text" name="customerName" id="name"  value="${customer.name }" checkType="string,1,20" placeholder="请输入客户姓名"  tip="客户姓名不能为空！请输入客户姓名！"/>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					<input type="text" class="midea text" name="mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					<span style="color: red;">*</span>
				</td>
		</tr>
		<tr>
					<td class="formTableTdLeft">证件信息：</td>
					<td>
						<c:if test="${customer.orderContract.status>=1}" var="status">
								<input type="hidden" id="paperworkId" name="paperworkId" value="${customer.paperwork.dbid }">						
								<input type="" class="largeX text" id="" name="" value="${customer.paperwork.name }" readonly="readonly">		
						</c:if>
						<c:if test="${status==false }">
								<select id="paperworkId" name="paperworkId" class="midea text" checkType="integer,1" tip="请选择证件信息">
								<option value="">请选择...</option>
								<c:forEach var="paperwork" items="${paperworks }">
									<option value="${paperwork.dbid }" ${customer.paperwork.dbid==paperwork.dbid?'selected="selected"':'' } >${paperwork.name }</option>
								</c:forEach>
							</select>				
							<span style="color: red">*</span>
						</c:if>
					</td>
					<td class="formTableTdLeft">证件号码：</td>
					<td>
						<c:if test="${customer.orderContract.status>=1}" var="status">
								<input type="text"  readonly="readonly" class="midea text" name="icard" id="icard"  value="${customer.icard }" />	
						</c:if>
						<c:if test="${status==false }">
								<input type="text"  class="mideaX text" name="icard" id="icard"  value="${customer.icard }" checkType="string,6" tip="请填写正确的身份证号码" />	
								<span style="color: red">*</span>
						</c:if>
					</td>
				</tr>
				<c:if test="${customer.orderContract.status>=1}" var="status">
					<tr>
						<td class="formTableTdLeft">地域：</td>
							<td id="areaLabel">
								<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
								<input type="text" class="midea text" readonly="readonly" value="${customer.area.fullName }" >
							</td>
							<td class="formTableTdLeft">身份证地址：</td>
							<td>
								<input readonly="readonly"  name="address" class="midea text" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>
							</td>
					</tr>
				</c:if>
					<c:if test="${status==false }">
					<tr>
						<td class="formTableTdLeft">地域：</td>
						<td id="areaLabel" colspan="3">
							<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
							<c:if test="${empty(areaSelect) }">
								<select id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)">
									<option>请选择...</option>
									<c:forEach items="${areas }" var="area">
										<option  value="${area.dbid }">${area.name }</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${!empty(areaSelect) }">
								${areaSelect }
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >地址：</td>
						<td colspan="3">
							<input  name="address" class="largeX text" id=address title="" value="${customer.address }" placeholder="请填写街道地址" checkType="string,1" tip="请填写街道地址"></input>
							<span style="color: red">*</span>
						</td>
					</tr>
					</c:if>
			</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="if(validate1()){$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveUpdateCustomerIdCard')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function validate1(){
	var areaId=$("#areaId").val();
	if(null==areaId||areaId==''||areaId==undefined){
		alert("请选择区域");
		return false;
	}
	return true;
}
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#areaLabel").append(data);
		}
	});
}
</script>
</html>