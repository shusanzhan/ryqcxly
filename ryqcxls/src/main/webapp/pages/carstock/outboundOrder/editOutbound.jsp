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

 table tr{
 	height: 30px;
 }
 #areaLabel select {
	width: 90px;
}
</style>
<script type="text/javascript">
function totalSum(){
	var  marketPrice= $("#marketPrice").val();
	var  cashDiscount= $("#cashDiscount").val();
	var  netTwoRebute= $("#netTwoRebute").val();
	var  huimin= $("#huimin").val();
	var  other= $("#other").val();
	var  actureTotal= $("#actureTotal").val();
	
	if(null!=marketPrice&&marketPrice!=''){
		if(!isNaN(parseFloat(marketPrice))){
			marketPrice=parseFloat(marketPrice);
		}else{
			marketPrice=0;
		}
	}else{
			marketPrice=0;
	}
	if(null!=other&&other!=''){
		if(!isNaN(parseFloat(other))){
			other=parseFloat(other);
		}else{
			other=0;
		}
	}else{
		other=0;
	}
	
	if(null!=cashDiscount&&cashDiscount!=''){
		if(!isNaN(parseFloat(cashDiscount))){
			cashDiscount=parseFloat(cashDiscount);
		}else{
			cashDiscount=0;
		}
	}else{
		cashDiscount=0;
	}
	if(null!=netTwoRebute&&netTwoRebute!=''){
		if(!isNaN(parseFloat(netTwoRebute))){
			netTwoRebute=parseFloat(netTwoRebute);
		}else{
			netTwoRebute=0;
		}
	}else{
		netTwoRebute=0;
	}
	if(null!=huimin&&huimin!=''){
		if(!isNaN(parseFloat(huimin))){
			huimin=parseFloat(huimin);
		}else{
			huimin=0;
		}
	}else{
		huimin=0;
	}
	actureTotal=marketPrice-cashDiscount-netTwoRebute+huimin+other;
	$("#actureTotal").val(actureTotal);
}
function vli(){
	var  areaId= $("#areaId").val();
	if(null==areaId||areaId==''||areaId=='请选择...'){
		alert("请选择上户区域！");
		return false;
	}
	return true;
}
</script>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆基本信息</div>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="92%">
		<tr height="32">
			<td class="formTableTdLeft">车型：&nbsp;</td>
				<td >
				 ${factoryOrder.brand.name }  
				 ${factoryOrder.carSeriy.introduction }
				  ${factoryOrder.carModel.name }${customer.carModelStr}
				  ${factoryOrder.carColor.name }
			</td>
			<td class="formTableTdLeft">VIN吗：&nbsp;</td>
			<td >
				<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1" class="" style="color: #46A0DE;">${factoryOrder.vinCode }</a>
				&nbsp;&nbsp;&nbsp;
				<span style="color: red;font-size: 16px;font-weight: bold;">${factoryOrder.huimin}</span>
			</td>
			<td class="formTableTdLeft">入库日期：&nbsp;</td>
				<td >
				  <fmt:formatDate value="${factoryOrder.carReceiving.stockInDate}" pattern="yyyy-MM-dd"/> 
			</td>
		</tr>
		<tr height="32">
			<td class="formTableTdLeft">执行价：&nbsp;</td>
			<td >
				${factoryOrder.marketPrice}
			</td>
			<td class="formTableTdLeft">管理公司：&nbsp;</td>
			<td >
				${factoryOrder.carReceiving.storeCompany.name}
			</td>
			<td class="formTableTdLeft">提车单位：&nbsp;</td>
			<td >
				${customer.user.department.name}
			</td>
		</tr>
		<tr height="32">
			<td class="formTableTdLeft">经销商类型：&nbsp;</td>
			<td >
				<c:if test="${empty(customer.distributor) }">
					自有店
				</c:if>
				<c:if test="${!empty(customer.distributor) }">
					${customer.distributor.name}
					(${customer.distributor.distributorType.name})
				</c:if>
			</td>
			<td class="formTableTdLeft">销售顾问：&nbsp;</td>
			<td >
				${customer.user.department.name} ${customer.bussiStaff}
			</td>
			<td class="formTableTdLeft">联系电话：&nbsp;</td>
			<td >
				${customer.user.mobilePhone}
			</td>
		</tr>
		<tr height="32">
			<td class="formTableTdLeft">客户姓名：&nbsp;</td>
			<td >
				${customer.name}&nbsp;&nbsp;${customer.sex}
			</td>
			<td class="formTableTdLeft">联系电话：&nbsp;</td>
			<td >
				${customer.mobilePhone}
			</td>
			<td class="formTableTdLeft">身份证地址：&nbsp;</td>
			<td >
				${customer.area.fullName} ${fn:substring(customer.address,0,12) }
			</td>
		</tr>
</table>
<div class="line"></div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
	<input type="hidden" id="modifyType" name="modifyType" value="${param.modifyType}">
	<input type="hidden" name="outboundOrder.dbid" id="dbid" value="${outboundOrder.dbid }">
	<input type="hidden" name="outboundOrder.customerId" id="customerId" value="${customer.dbid }">
	<input type="hidden" name="outboundOrder.createDate" id="createDate" value="${outboundOrder.createDate }">
	<input type="hidden" name="outboundOrder.no" id="no" value="${outboundOrder.no }">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr>
				<td class="formTableTdLeft">上户区域：</td>
				<td id="areaLabel">
					<c:if test="${!empty(outboundOrder.shanghuArea)&&outboundOrder.shanghuArea.dbid>0 }" var="status">
						<input type="hidden" name="areaId" value="${outboundOrder.shanghuArea.dbid }" id="areaId">
					</c:if>
					<c:if test="${status==false }">
						<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
					</c:if>
					${areaSelect }
					<c:if test="${empty(areaSelect) }">
						<select id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)">
							<option>请选择...</option>
							<c:forEach items="${areas }" var="area">
								<option  value="${area.dbid }">${area.name }</option>
							</c:forEach>
						</select>
					</c:if>
					<span style="color: red;">*</span>
				</td>
						
				<td class="formTableTdLeft">是否需备案：</td>
				<td>
					<select id="shifouBeian" name="outboundOrder.shifouBeian" class="text largeX" checkType="string,1" tip="请选择是否需要备案">
						<option value="">请选择</option>
						<option value="是" ${outboundOrder.shifouBeian=='是'?'selected="selected"':'' } >是</option>
						<option value="否" ${outboundOrder.shifouBeian=='否'?'selected="selected"':'' }>否</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">销售权限：</td>
				<td>
						<c:if test="${customer.customerType==1 }">
							<select id="saleSecurity" name="outboundOrder.saleSecurity" class="largeX text"  checkType="string,2" tip="请选择销售权限">
								<option value="">请选择...</option>
								<option value="销售顾问权限" ${outboundOrder.saleSecurity=='销售顾问权限'?'selected="selected"':'' } >销售顾问权限</option>
								<option value="展厅经理权限" ${outboundOrder.saleSecurity=='展厅经理权限'?'selected="selected"':'' } >展厅经理权限</option>
								<option value="销售副总权限" ${outboundOrder.saleSecurity=='销售副总权限'?'selected="selected"':'' } >销售副总权限</option>
								<option value="总经理权限" ${outboundOrder.saleSecurity=='总经理权限'?'selected="selected"':'' } >总经理权限</option>
							</select>
						</c:if>
						<c:if test="${customer.customerType==2 }">
							<select id="saleSecurity" name="outboundOrder.saleSecurity" class="largeX text" onchange="ajaxArea(this)">
								<option value="二网权限" ${outboundOrder.saleSecurity=='二网权限'?'selected="selected"':'' } >二网权限</option>
								<option value="网络经理权限" ${outboundOrder.saleSecurity=='网络经理权限'?'selected="selected"':'' } >网络经理权限</option>
							</select>
						</c:if>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">购车方式：</td>
				<td>
					 <c:if test="${ orderContractExpenses.buyCarType==1}">
						现款客户
					</c:if>
					<c:if test="${ orderContractExpenses.buyCarType==2}">
						按揭客户
					</c:if> 
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">发票类型：</td>
				<td >
						<select id="faPiaoType" name="outboundOrder.faPiaoType" class="largeX text" onchange="" checkType="string,2" tip="请选择发票类型">
							<option>请选择...</option>
							<option  value="增值税发票" ${outboundOrder.faPiaoType=='增值税发票'?'selected="selected"':'' }>增值税发票</option>
							<option  value="普通发票" ${outboundOrder.faPiaoType=='普通发票'?'selected="selected"':'' }>普通发票</option>
						</select>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">支付日期：</td>
				<td>
					<c:if test="${empty(outboundOrder) }">
						<input type="text" name="outboundOrder.invoiceDate" id="invoiceDate" class="largeX text" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>'  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" checkType="string,10" tip="请选择预约交车日期">
					</c:if>
					<c:if test="${!empty(outboundOrder) }">
						<input type="text" name="outboundOrder.invoiceDate" id="invoiceDate" class="largeX text" value='<fmt:formatDate value="${outboundOrder.invoiceDate}" pattern="yyyy-MM-dd"/>'  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" checkType="string,10" tip="请选择预约交车日期">
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">实收合计：</td>
				<td id="areaLabel">
					<input type="text" readonly="readonly" id="actureTotal" name="outboundOrder.actureTotal" value="${orderContractExpenses.totalPrice }" class="text largeX">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">开票价：</td>
				<td>
					<input type="text" id="invoicePrice" name="outboundOrder.invoicePrice" value="${outboundOrder.invoicePrice }" class="text largeX" checkType="string,1" tip="请填写开票价">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">发票号码：</td>
				<td>
					<input type="text" id="faPiaoHao" name="outboundOrder.faPiaoHao" value="${outboundOrder.faPiaoHao }" class="text largeX" checkType="string,8,8" tip="请填写发票号,发票号为8个字符" >
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">发票代码：</td>
				<c:if test="${empty(outboundOrder.faPiaoDaiMa) }" var="status">
					<td id="areaLabel">
						<input type="text"  id="faPiaoDaiMa" name="outboundOrder.faPiaoDaiMa" value="151001522001" class="text largeX" checkType="string,12,12" tip="请填写发票号,发票号为12个字符">
						<span style="color: red;">*</span>
					</td>
				</c:if>
				<c:if test="${!empty(outboundOrder.faPiaoDaiMa) }" >
					<td id="areaLabel">
						<input type="text"  id="faPiaoDaiMa" name="outboundOrder.faPiaoDaiMa" value="${outboundOrder.faPiaoDaiMa }" class="text largeX" checkType="string,12,12" tip="请填写发票号,发票号为12个字符">
						<span style="color: red;">*</span>
					</td>
				</c:if>
			</tr>
			<tr>
				<td class="formTableTdLeft">发票日期：</td>
				<td>
					<input type="text" readonly="readonly" id="kaiPiaoDate" name="outboundOrder.kaiPiaoDate" value="${outboundOrder.kaiPiaoDate }" class="text largeX" checkType="string,10,10" tip="请选择发票日期" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">支付渠道及明细：</td>
				<td colspan="">
					<textarea rows="" cols="" id="invoiceNote" name="outboundOrder.invoiceNote" class="text largeX" style="height: 60px; "  checkType="string,1" tip="请填写支付渠道及明细">${outboundOrder.invoiceNote }</textarea>
					<span style="color: red;">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="if(vli()){$.utile.submitAjaxForm('frmId','${ctx}/outboundOrder/saveOutboundOrder')}"	class="but butSave">保存</a>
		<a href="javascript:void(-1)"	onclick="window.location.href='${ctx}/outboundOrder/orderContractDecore?customerId=${customer.dbid }&editType=${param.editType}'" class="but butCancle">查看上一页</a> 
		<c:if test="${param.modifyType==1 }">
			<a href="javascript:void(-1)" onclick="window.location.href='${ctx }/customerPidBookingRecord/queryWlbWatingList'" class="but butSave"	 class="but butCancle">返回车辆调配列表</a> 
		</c:if>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
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