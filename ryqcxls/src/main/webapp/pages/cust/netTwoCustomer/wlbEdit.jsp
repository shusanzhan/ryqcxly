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
					<input type="text" readonly="readonly" name="" id=""	value='${customer.name }' class="mideaX text" >
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					<input type="text" name="" readonly="readonly" id=""	value='${customer.mobilePhone }' class="mideaX text" >
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">订单日期:&nbsp;</td>
				<td ><input  readonly="readonly"  type="text" name="customerPidBookingRecord.orderDate" id="orderDate" class="mideaX text" 	value="<fmt:formatDate value="${customerPidBookingRecord.createTime }" pattern="yyyy-MM-dd HH:mm" />" ></td>
				<td class="formTableTdLeft">预约交车日期:&nbsp;</td>
				<td ><input  readonly="readonly"  type="text" name="customerPidBookingRecord.bookingDate" id="bookingDate" class="mideaX text" 	value="<fmt:formatDate value="${customerPidBookingRecord.bookingDate }" pattern="yyyy-MM-dd HH:mm" />" ></td>
			</tr>
			<tr>
				<td>颜色:</td>
				<td ><input  readonly="readonly"  type="text" name="carColor" id="color" value="${customerPidBookingRecord.carColor.name }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">加装特殊要求:&nbsp;</td>
				<td >
					<input  readonly="readonly"  type="text" name="customerPidBookingRecord.spec"  id="customerPidBookingRecord"	value='${customerPidBookingRecord.spec }' class="largeXXX text" >
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						<%-- <select  readonly="readonly"  id="carSeriyId" name="carSeriyId" class="midea text" onchange="ajaxCarModel('carSeriyId')">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${customerLastBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select  readonly="readonly"  id="carModelId" name="carModelId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customerLastBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
							</c:forEach>
						</select> --%>
						<input   readonly="readonly"	value='${customerLastBussi.carSeriy.name} ${customerLastBussi.carModel.name }' class="largeXXX text" >
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">具体车型:&nbsp;</td>
				<td >
					<input  readonly="readonly"  type="text" name="customerPidBookingRecord.carModelContent"  id="customerPidBookingRecord"	value='${customerPidBookingRecord.carModelContent }' class="largeXXX text" >
				</td>
			</tr>
		
			
			<tr height="42">
				<td class="formTableTdLeft">订单设置:&nbsp;</td>
				<td colspan="3">
					<input   disabled="disabled"  type="checkbox"  id="incompleteData" name="customerPidBookingRecord.incompleteData" ${customerPidBookingRecord.incompleteData==true?'checked="checked"':'' }   value="true"> 按揭资料未交齐
					<input disabled="disabled"    type="checkbox"  id="approvaling" name="customerPidBookingRecord.approvaling"  ${customerPidBookingRecord.approvaling==true?'checked="checked"':'' }  value="true"> 按揭审核中
					<input  disabled="disabled"  type="checkbox" id="approvalNotOther" name="customerPidBookingRecord.approvalNotOther"  ${customerPidBookingRecord.approvalNotOther==true?'checked="checked"':'' } value="true"> 审核未通过转其他方式
					<input  disabled="disabled"  type="checkbox"  id="approvalNot" name="customerPidBookingRecord.approvalNot"  ${customerPidBookingRecord.approvalNot==true?'checked="checked"':'' }  value="true"> 审核通过未提车
				</td>
			</tr>
		
			<tr height="42">
				<td class="formTableTdLeft">销售备注:&nbsp;</td>
				<td colspan="3"><textarea  readonly="readonly"   name="customerPidBookingRecord.note" id="note"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.note }</textarea></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
					<select id="hasCarOrder" name="customerPidBookingRecord.hasCarOrder" class="media text" checkType="string,1" tip="请选择车源情况">
						<option value="" >请选择车源情况</option>
						<option value="1" ${customerPidBookingRecord.hasCarOrder==1?'selected="selected"':'' } >现车订单</option>
						<option value="2" ${customerPidBookingRecord.hasCarOrder==2?'selected="selected"':'' } >在途订单</option>
						<option value="3" ${customerPidBookingRecord.hasCarOrder==3?'selected="selected"':'' } >无车订单</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">完整车架号:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerPidBookingRecord.vinCode" id="vinCode"	value="${customerPidBookingRecord.vinCode }" class="largeXXX text" 	checkType="string,17,17" tip="请输入完整车架号，车架号为17位字符"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">网点:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerPidBookingRecord.webSite"id="webSite"
					value="${customerPidBookingRecord.webSite }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
				<input type="text" name="customerPidBookingRecord.carSource" id="carSource"
					value="${customerPidBookingRecord.carSource }" class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">是否自有车:&nbsp;</td>
				<td colspan="3">
				<select id="hasCarWl" name="customerPidBookingRecord.hasCarWl" class="media text" checkType="integer,1" tip="请选择是否自有车">
					<option value="" >请选择车源情况</option>
					<option value="1" ${customerPidBookingRecord.hasCarWl==1?'selected="selected"':'' } >新到车辆</option>
					<option value="2" ${customerPidBookingRecord.hasCarWl==2?'selected="selected"':'' } >预警一级</option>
					<option value="3" ${customerPidBookingRecord.hasCarWl==3?'selected="selected"':'' } >预警二级</option>
					<option value="4" ${customerPidBookingRecord.hasCarWl==4?'selected="selected"':'' } >自有一级</option>
					<option value="5" ${customerPidBookingRecord.hasCarWl==5?'selected="selected"':'' } >自有二级</option>
					<option value="6" ${customerPidBookingRecord.hasCarWl==6?'selected="selected"':'' } >自有三级</option>
					<option value="7" ${customerPidBookingRecord.hasCarWl==7?'selected="selected"':'' } >自有重点</option>
				</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3"><textarea   name="customerPidBookingRecord.wlNote" id="wlNote"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.wlNote }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/saveWlb')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
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