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
<title>交车预约</title>
</head>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">提交交车预约</a>
</div>
<div class="line"></div>
<c:if test="${!empty(customerPidBookingCancelRecord) }">
	<div class="alert alert-error">
			<strong>提示:您于【<fmt:formatDate value="${customerPidBookingCancelRecord.bookingDate }"/> 】创建过交车预约.</strong>
	</div>
</c:if>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="customerId" value="${customer.dbid }" id="customerId"></input>
		<input type="hidden" name="customerPidBookingRecord.createTime" id="createTime" value="${customerPidBookingRecord.createTime}">
		<input type="hidden" name="customerPidBookingRecord.dbid" id="dbid" value="${customerPidBookingRecord.dbid }">
		<s:token></s:token>
		
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td >
					${customer.name }
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${customer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
					<input type="hidden" id="brandId" name="brandId" value="${customer.customerLastBussi.brand.dbid }" />
					<input type="hidden" id="carModelId" name="carModelId" value="${customer.customerLastBussi.carModel.dbid }" />
					<input type="hidden" id="carSeriyId" name="carSeriyId" value="${customer.customerLastBussi.carSeriy.dbid }" />
					<input type="hidden" id="carColorId" name="carColorId" value="${customerLastBussi.carColor.dbid}" />
					${customer.customerLastBussi.brand.name }&nbsp;&nbsp;
					${customer.customerLastBussi.carSeriy.name }&nbsp;&nbsp;
					 ${customer.customerLastBussi.carModel.name }${customer.carModelStr}&nbsp;&nbsp;
				</td>
				<td>颜色:</td>
				<td >
					${customerLastBussi.carColor.name}${customer.carColorStr}
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">订单日期:&nbsp;</td>
				<td >
					<input type="hidden" readonly="readonly" name="customerPidBookingRecord.orderDate" id="orderDate" class="mideaX text"  value='<fmt:formatDate value="${customer.orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/>' >
					<fmt:formatDate value="${customer.orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td class="formTableTdLeft">预约交车日期:&nbsp;</td>
				<td >
					<input type="text" name="customerPidBookingRecord.bookingDate" id="bookingDate" class="mideaX text"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'orderDate\')}'});" checkType="string,10" tip="请选择预约交车日期">
					<span style="color: red;">*</span>
				</td>
			</tr>
			 <tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3"><textarea   name="customerPidBookingRecord.note" id="note"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.note }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/save')"	class="but butSave">保&nbsp;&nbsp;存</a>
		 <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a> 
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(document).ready(function (){
	$("#carModelId").css("width","200")
})
function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		$("#carModelId").remove();
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
	}
</script>
</html>