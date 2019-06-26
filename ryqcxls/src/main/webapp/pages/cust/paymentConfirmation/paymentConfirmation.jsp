<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>交款确认单</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
textarea:-moz-placeholder{color:red}
textarea:-ms-input-placeholder{color:red}
textarea::-webkit-input-placeholder{color:red;font-size: 14px;line-height: 200%;}
body {
    background: none repeat scroll 0 0 #F8F8F8;
    font-family: "微软雅黑",Helvetica,Arial,sans-serif;
    font-size: 14px;
    line-height: 20px;
    margin: 0;
    padding: 0;
}
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height: 30px;
    width: 100px;
}
input[disabled], select[disabled], textarea[disabled], input[readonly], select[readonly], textarea[readonly] {
    background-color: #F8F8F8;
    cursor: not-allowed;
}
</style>
<script type="text/javascript">
	function validateFo(){
		var carMoney=$("#carMoney").val();
		var totalPrice=$("#totalPrice").val();
		if(null==carMoney||carMoney==''){
			alert("请输入货款/车款");
			return false;
		}
		var preferentialTogether=$("#preferentialTogether").val();
		if(null==preferentialTogether||preferentialTogether==''){
			alert("请输入优惠合计");
			return false;
		}
		var isCash=$('input:radio[name="paymentConfirmation.isCash"]:checked').val();
		if(null==isCash||isCash==''){
			alert("请选择现款或分付！");
			return false;
		}
		var payNowMoney=$('input:radio[name="paymentConfirmation.payNowMoney"]:checked').val();
		if(null==payNowMoney||payNowMoney==''){
			alert("请选择现金或转账！");
			return false;
		}
		var actMoney=$("#actMoney").val();
		if(null!=actMoney&&actMoney!=""){
			var actMoneyInt= parseInt(actMoney);
			if(actMoneyInt<0){
				alert("实收合计不能为负数！");
				return false;
			}			
		}
		
		var order=$("#actMoney").val();//按揭管理费
		var actMoney=countActMoney();
		if(order!=actMoney){
			alert("实收合计与合同金额不等");
			return false;
		}
		return true;
	}
</script>
</head>
<body>

	<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " onclick="if(validateFo()){$.utile.submitAjaxForm('frmId','${ctx}/paymentConfirmation/savePaymentConfirmation')}"	 style="margin-left: 5px;">保存</a>
		<a href="javascript:;" id="print" class="btn btn-success " onclick="goBack()" style="margin-left: 5px;">返回</a>
	</div>
<form action="" name="frmId" id="frmId"  target="_self">
<input type="hidden" id="dbid" name="paymentConfirmation.dbid" value="${paymentConfirmation.dbid }">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice }">
 <div class="testDriverContent" style="width: 92%;margin-bottom: 50px;">
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 1px;margin-bottom: 20px">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;">
				<img src="${ctx }/images/xwqr/logo.png" width="80"></img>
			</td>
			<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;">成都瑞一汽车客户交款确认单</td>
			<td style="border: 0px solid #000000;" align="right">SN:${customer.sn }</td>
		</tr>
		<tr>
			<td class="noLine" colspan="3" style="border: 0px solid #000000;color: red;">
				合同总金额：${orderTotalPrice }.00&nbsp;&nbsp;&nbsp;&nbsp;应付金额：${totalPrice }.00&nbsp;&nbsp;&nbsp;&nbsp;合同定金：${orderContract.orderMoney }.00
			</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:100px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:40px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:40px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center">部门</td>
		<td colspan="3"><input type="text" readonly="readonly" value="${customer.department.name }" id="department" name="paymentConfirmation.department"></td>	
		<td colspan="" align="center">销售顾问</td>
		<td colspan="4"><input type="text" readonly="readonly" value="${customer.bussiStaff }" id="bussiStaff" name="paymentConfirmation.bussiStaff"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">客户姓名</td>
		<td colspan="3"><input type="text" readonly="readonly" value="${customer.name }" id="customerName" name="paymentConfirmation.customerName"></td>	
		<td colspan="" align="center">时&#12288;&#12288;间</td>
		<td colspan="4">
		<c:if test="${empty(paymentConfirmation) }">
			<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日 HH：mm"/>
		</c:if>
		<c:if test="${!empty(paymentConfirmation)  }">
			<fmt:formatDate value="${paymentConfirmation.createTime }" pattern="yyyy年MM月dd日 HH：mm"/>
			<input type="hidden" value="${paymentConfirmation.createTime  }" id="createTime" name="paymentConfirmation.createTime">
		</c:if>
		</td>
	</tr>
	 <tr>
		<td colspan="2" align="center">车架号</td>
		<td colspan="2" align="center">车型</td>	
		<td align="center">颜色</td>
		<td colspan="3" align="center">
			车牌号
		</td>
		<td align="center" style="width:40px;">
			现款
		</td>
		<td align="center" style="width:40px;">
			分付
		</td>
	</tr>
	 <tr>
		<td colspan="2" align="center">
			<input type="text"  readonly="readonly" value="${customerPidBookingRecord.vinCode }" id="vinCode" name="paymentConfirmation.vinCode" />&#12288;
		</td>
		<td colspan="2" align="center">
			<input type="text" readonly="readonly" value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" id="carModel" name="paymentConfirmation.carModel" style="width: 200px;"/>&#12288;
		</td>	
		<td align="center">&#12288;
			<input type="text" readonly="readonly" value="${ customerPidBookingRecord.carColor.name}" id="carColor" name="paymentConfirmation.carColor" />
		</td>
		<td colspan="3" align="center">&#12288;
				<input readonly="readonly" type="text" value="${customerLastBussi.carPlateNo }" id="carPlateNo" name="paymentConfirmation.carPlateNo" />&#12288;
		</td>
		<td align="center" style="width:40px;">&#12288;
			<input type="radio" value="true" name="paymentConfirmation.isCash" id="isCash"   ${paymentConfirmation.isCash==true?'checked="checked"':'' }>是
			<input type="radio" value="false" name="paymentConfirmation.isCash" id="isCash" ${paymentConfirmation.isCash==false?'checked="checked"':'' }>是
		</td>
		<td align="center" style="width:40px;">&#12288;
		</td>
	</tr>
 	<tr>
		<td colspan="3" align="center">收入明细（单位：元）</td>
		<td colspan="7" align="center">备注栏</td>
	</tr>
	  <tr>
		<td align="center" style="width:30px;">1</td>
		<td align="center" style="width: 80px;">合同定金</td>
		<td style="width: 160px;">
			<input type="text" readonly="readonly" value="${orderContract.orderMoney }" id="frontMoney" name="paymentConfirmation.frontMoney" /></td>
		<td style="width: 30px;" rowspan="8" colspan="7" align="center">
			<textarea rows="20" style="width: 98%;" id="note" name="paymentConfirmation.note" placeholder="所有需先交纳财务后再返还客户的费用在这里填写！您可以填写如旧车置换补贴、金融补贴、团购活动等特殊优惠信息">${paymentConfirmation.note }</textarea>			
		</td>
	</tr> 
	
	<tr>
		<td align="center" style="width:30px;">2</td>
		<td align="center" style="width: 80px;">经销商报价</td>
		<td style="width: 160px;">
			<c:if test="${empty(paymentConfirmation) }">
				<input type="text"  value="${customer.customerBussi.carModel.salePrice }" onchange="countActMoney()" id="carMoney" name="paymentConfirmation.carMoney" />
			</c:if>
			<c:if test="${!empty(paymentConfirmation) }">
				<input type="text"  value="${paymentConfirmation.carMoney }" onchange="countActMoney()" id="carMoney" name="paymentConfirmation.carMoney" />
			</c:if>
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">3</td>
		<td align="center" style="width: 80px;">车款优惠</td>
		<td style="width: 160px;">
			<input type="text"  value="${paymentConfirmation.preferentialTogether }"  onchange="countActMoney()"  id="preferentialTogether" name="paymentConfirmation.preferentialTogether" />
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">4</td>
		<td align="center" style="width: 80px;">装饰款</td>
		<td style="width: 160px;">
			<input type="text"  value="${paymentConfirmation.decoreMoney }"  onchange="countActMoney()"  id="decoreMoney" name="paymentConfirmation.decoreMoney" />
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">5</td>
		<td align="center" style="width: 80px;">咨询服务费</td>
		<td style="width: 160px;">
			<input type="text"  value="${paymentConfirmation.ajsxf }"  onchange="countActMoney()"  id="ajsxf" name="paymentConfirmation.ajsxf" />
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;" colspan="3">按揭选填项</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">6</td>
		<td align="center" style="width: 80px;">首付款</td>
		<td style="width: 160px;">
			<input type="text"  value="${paymentConfirmation.sfk }"  onchange="countActMoney()"  id="sfk" name="paymentConfirmation.sfk" />
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">7</td>
		<td align="center" style="width: 80px;">贷款</td>
		<td style="width: 160px;">
			<input type="text"  value="${paymentConfirmation.daikuan }"  onchange="countActMoney()"  id="daikuan" name="paymentConfirmation.daikuan" />
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">实收合计</td>
		<td style="width: 160px;" colspan="9">
		<c:if test="${empty(paymentConfirmation)}">
			<input type="text" readonly="readonly" value="${totalPrice }" id="actMoney" name="paymentConfirmation.actMoney" />
		</c:if>
		<c:if test="${!empty(paymentConfirmation)}">
			<input type="text" readonly="readonly" value="${paymentConfirmation.actMoney }" id="actMoney" name="paymentConfirmation.actMoney" />
		</c:if>
		(合同总额-合同定金)
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">注：</td>
		<td align="left" style="width: 80px;" colspan="9">实收合计=经销商报价-车款优惠-合同定金+装饰款+咨询服务费</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;" rowspan="2">付款方式</td>
		<td align="center" style="width: 80px;">现金</td>
		<td colspan="3">
			<input type="radio" value="1" name="paymentConfirmation.payNowMoney" id="payNowMoney"   ${paymentConfirmation.payNowMoney==1?'checked="checked"':'' }>
			<input type="radio" value="2" name="paymentConfirmation.payNowMoney" id="payNowMoney"   ${paymentConfirmation.payNowMoney==2?'checked="checked"':'' }>
		</td>
		<td colspan="" align="center" rowspan="2">客户确认</td>
		<td colspan="4" rowspan="2">
			<input type="text" readonly="readonly" value="${customer.name }"  />
		</td>
	</tr>
	<tr>
		<td colspan="1" align="center"  style="width: 80px;">转账</td>
		<td colspan="3">
			<input type="radio" value="2" name="paymentConfirmation.payNowMoney" id="payNowMoney"   ${paymentConfirmation.payNowMoney==2?'checked="checked"':'' }>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">展厅经理确认</td>
		<td colspan="3"><input type="text"  value="${paymentConfirmation.showRoomManager }" id="showRoomManager" name="paymentConfirmation.showRoomManager" /></td>	
		<td colspan="" align="center">总经理审批</td>
		<td colspan="4">
			<input type="text"  value="${paymentConfirmation.gmManger }" id="gmManger" name="paymentConfirmation.gmManger" />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">销售经理审批</td>
		<td colspan="3">
		<c:if test="${empty(paymentConfirmation)}">
			<input type="text"  value="${customer.showRoomManager }" id="salesManger" name="paymentConfirmation.salesManger" />
		</c:if>
		<c:if test="${!empty(paymentConfirmation)}">
			<input type="text"  value="${paymentConfirmation.salesManger }" id="salesManger" name="paymentConfirmation.salesManger" />
		</c:if>
		</td>	
		<td colspan="" align="center">收款确认</td>
		<td colspan="4"><input type="text"  value="${paymentConfirmation.paymentConfirmation }" id="paymentConfirmation" name="paymentConfirmation.paymentConfirmation" />
		</td>
	</tr> 
</table>
</div>
</form>
</body>
<script type="text/javascript">
function countActMoney(){
	//计算公式 实收合计=经销商报价-车款优惠-合同定金+装饰款+咨询服务费
	var actMoney=0;
	var frontMoney=$("#frontMoney").val();//定金
	if(null!=frontMoney&&frontMoney!=""){
		actMoney=actMoney-parseInt(frontMoney);
	}
	var preferentialTogether=$("#preferentialTogether").val();//优惠合计
	if(null!=preferentialTogether&&preferentialTogether!=""){
		actMoney=actMoney-parseInt(preferentialTogether);
	}
	
	var carMoney=$("#carMoney").val();//经销商报价
	if(null!=carMoney&&carMoney!=""){
		actMoney=actMoney+parseInt(carMoney);
	}
	var agsxf=$("#ajsxf").val();//经销商报价
	if(null!=agsxf&&agsxf!=""){
		actMoney=actMoney+parseInt(agsxf);
	}
	var decoreMoney=$("#decoreMoney").val();//经销商报价
	if(null!=decoreMoney&&decoreMoney!=""){
		actMoney=actMoney+parseInt(decoreMoney);
	}
	return actMoney;
	
}
	
</script>
</html>