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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>物流处理情况</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${customerPidBookingRecord.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
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
					${customer.customerLastBussi.brand.name }${customer.customerLastBussi.carSeriy.name } ${customer.customerLastBussi.carModel.name }${customer.carModelStr} ${customerLastBussi.carColor.name}${customer.carColorStr}
				</td>
				<td class="formTableTdLeft">预约交车日期:&nbsp;</td>
				<td >
					<fmt:formatDate value="${customerPidBookingRecord.bookingDate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
			</tr>
			 <tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">${customerPidBookingRecord.note }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="">
					<c:if test="${customerPidBookingRecord.hasCarOrder==1 }">
						现车订单
					</c:if>
					<c:if test="${customerPidBookingRecord.hasCarOrder==2 }">
						在途订单
					</c:if>
					<c:if test="${customerPidBookingRecord.hasCarOrder==3 }">
						无车订单
					</c:if>
				</td>
				<td class="formTableTdLeft">完整车架号:&nbsp;</td>
				<td colspan="">${customerPidBookingRecord.vinCode }</td>
			</tr>
			<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
				<tr height="42">
					<td class="formTableTdLeft">所属公司:&nbsp;</td>
					<td colspan="">${carReceiving.storeCompany.name }</td>
					<td class="formTableTdLeft">车源情况:&nbsp;</td>
					<td colspan="">${carReceiving.storeArea.name }&nbsp;&nbsp;${carReceiving.storeRoom.name }&nbsp;&nbsp;${carReceiving.storage.name }</td>
				</tr>
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3">${customerPidBookingRecord.wlNote }</td>
			</tr> 
		</table>
	</form>
	<div class="formButton">
		 <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">关&nbsp;&nbsp;闭</a> 
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