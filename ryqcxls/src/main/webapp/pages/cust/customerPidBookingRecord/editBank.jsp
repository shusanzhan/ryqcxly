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
	<c:if test="${customerPidBookingRecord.wlStatus==2 }">
		<div class="alert alert-danger">
			<strong>提示!</strong> 物流部已经处理了交车预约信息！
		</div>
	</c:if>
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
					<input type="text" readonly="readonly" name="" id=""	value='${customer.name }' class="large text" >
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					<input type="text" name="" readonly="readonly" id=""	value='${customer.mobilePhone }' class="large text" >
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
					<input type="hidden" id="brandId" name="brandId" value="${customer.customerLastBussi.brand.dbid }" />
					<input type="text" readonly="readonly" class="small text" name="brandName" id="brandName" value="${customer.customerLastBussi.brand.name }" />
					<input type="hidden" id="carSeriyId" name="carSeriyId" value="${customer.customerLastBussi.carSeriy.dbid }" />
					<input type="text" readonly="readonly" class="small text" name="carSeriyName" id="carSeriyName" value="${customer.customerLastBussi.carSeriy.name }" />
					<input type="hidden" id="carModelId" name="carModelId" value="${customer.customerLastBussi.carModel.dbid }" />
					<input type="text" readonly="readonly" class="largeXX text" name="carSeriyName" id="carSeriyName" value=" ${customer.customerLastBussi.carModel.name }${customer.carModelStr}" />
				</td>
				<td class="formTableTdLeft">具体车型:&nbsp;</td>
				<td >
					<input type="text" name="customerPidBookingRecord.carModelContent"  id="customerPidBookingRecord"	value='${customerPidBookingRecord.carModelContent }' class="large text" >
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">加装特殊要求:&nbsp;</td>
				<td >
					<input type="text" name="customerPidBookingRecord.spec"  id="customerPidBookingRecord"	value='${customerPidBookingRecord.spec }' class="large text" >
				</td>
				<td>颜色:</td>
				<td >
					<c:if test="${empty(customerPidBookingRecord.carColor) }">
						<select id="carColorId" name="carColorId" class="midea text"  checkType="integer,1">
							<option value="0">请选择...</option>
							<c:forEach var="carColor" items="${carColors }">
								<option value="${carColor.dbid }" ${customerLastBussi.carColor.dbid==carColor.dbid?' selected="selected"':'' }>${carColor.name }</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${!empty(customerPidBookingRecord.carColor)  }">
						<select id="carColorId" name="carColorId" class="midea text"  checkType="integer,1">
							<option value="0">请选择...</option>
							<c:forEach var="carColor" items="${carColors }">
								<option value="${carColor.dbid }" ${customerPidBookingRecord.carColor.dbid==carColor.dbid?' selected="selected"':'' }>${carColor.name }</option>
							</c:forEach>
						</select>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">订单日期:&nbsp;</td>
				<td >
					<c:if test="${empty(customerPidBookingRecord.orderDate) }">		
						<input type="text" readonly="readonly" name="customerPidBookingRecord.orderDate" id="orderDate" class="mideaX text"  value='<fmt:formatDate value="${customer.orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/>' >
					</c:if>
					<c:if test="${!empty(customerPidBookingRecord.orderDate) }">		
						<input type="text" readonly="readonly" name="customerPidBookingRecord.orderDate" id="orderDate" class="mideaX text" value='<fmt:formatDate value="${customerPidBookingRecord.orderDate }" pattern="yyyy-MM-dd HH:mm"/>'  >
					</c:if>
				</td>
				<td class="formTableTdLeft">预约交车日期:&nbsp;</td>
				<td >
					<input type="text" name="customerPidBookingRecord.bookingDate" id="bookingDate" class="mideaX text"  value='<fmt:formatDate value="${customerPidBookingRecord.bookingDate}" pattern="yyyy-MM-dd HH:mm"/>'	 onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'orderDate\')}'});" checkType="string,10" tip="请选择预约交车日期">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">订单设置:&nbsp;</td>
				<td colspan="3">
				<label>
					<input  type="checkbox"  id="incompleteData" name="customerPidBookingRecord.incompleteData" ${customerPidBookingRecord.incompleteData==true?'checked="checked"':'' }   value="true"> 按揭资料未交齐</label>
					<label><input  type="checkbox"  id="approvaling" name="customerPidBookingRecord.approvaling"  ${customerPidBookingRecord.approvaling==true?'checked="checked"':'' }  value="true"> 按揭审核中</label>
					<label ><input  type="checkbox" id="approvalNotOther" name="customerPidBookingRecord.approvalNotOther"  ${customerPidBookingRecord.approvalNotOther==true?'checked="checked"':'' } value="true"> 审核未通过转其他方式</label>
					<label><input  type="checkbox"  id="approvalNot" name="customerPidBookingRecord.approvalNot"  ${customerPidBookingRecord.approvalNot==true?'checked="checked"':'' }  value="true"> 审核通过未提车</label>
				</td>
			</tr>
			<c:if test="${customerPidBookingRecord.wlStatus==2 }">
			<tr height="42">
				<td class="formTableTdLeft" style="color: red;">物流部处理设置:&nbsp;</td>
				<td colspan="3">
				<label>
					<input  type="checkbox"  id="yetDeal" name="yetDeal"   value="1"> <span style="color:red ">提请物流部重新处理</span></label>
				</td>
			</tr>
			</c:if>
			 <tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3"><textarea   name="customerPidBookingRecord.note" id="note"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.note }</textarea></td>
			</tr>
			<c:if test="${customerPidBookingRecord.wlStatus==2 }">
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
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
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">完整车架号::&nbsp;</td>
				<td colspan="3"><input type="text" readonly="readonly" name="customerPidBookingRecord.vinCode"id="vinCode"	value="${customerPidBookingRecord.vinCode }" class="largeXXX text" 	checkType="string,17,17" tip="请输入完整车架号，车架号为17位字符"></td>
			</tr>
				<tr height="42">
					<td class="formTableTdLeft">网点:&nbsp;</td>
					<td colspan="3"><input type="text" name="customerPidBookingRecord.webSite" readonly="readonly" id="webSite"
						value="${customerPidBookingRecord.webSite }" class="largeXXX text" 	></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">车源情况:&nbsp;</td>
					<td colspan="3"><input type="text" name="customerPidBookingRecord.carSource" readonly="readonly" id="carSource"
						value="${customerPidBookingRecord.carSource }" class="largeXXX text" 	></td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">是否自有车:&nbsp;</td>
					<td colspan="3">
					<input type="hidden" name="customerPidBookingRecord.hasCarWl" readonly="readonly" id="hasCarWl"
						value="${customerPidBookingRecord.hasCarWl }" class="largeXXX text" 	>
						<c:if test="${customerPidBookingRecord.hasCarWl==1 }">
							<input type="text" readonly="readonly" 	value="新到车辆" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==2 }">
							<input type="text" readonly="readonly" 	value="预警一级" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==3 }">
							<input type="text" readonly="readonly" 	value="预警二级" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==4 }">
							<input type="text" readonly="readonly" 	value="自有一级" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==5 }">
							<input type="text" readonly="readonly" 	value="自有二级" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==6 }">
							<input type="text" readonly="readonly" 	value="自有三级" class="largeXXX text" 	>
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarWl==7 }">
							<input type="text" readonly="readonly" 	value="自有重点" class="largeXXX text" 	>
						</c:if>
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">物流备注:&nbsp;</td>
					<td colspan="3"><textarea  readonly="readonly" name="customerPidBookingRecord.wlNote" id="wlNote"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.wlNote }</textarea></td>
				</tr> 
			</c:if>
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
		$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
	}
</script>
</html>