<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>打印交款确认单</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css">
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 16px;
    line-height: 28px;
    width: 100px;
}
</style>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
</head>
<body>
<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>
 <div class="testDriverContent" style="width: 98%;">
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;">
				<img src="${ctx }/images/xwqr/logo.jpg" width="80" height="40"></img>
			</td>
			<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;">成都瑞一汽车客户交款确认单</td>
			<td style="border: 0px solid #000000;" align="right">SN:${customer.sn }</td>
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
		<td colspan="3">${customer.department.name }</td>	
		<td colspan="" align="center">销售顾问</td>
		<td colspan="4">
		${customer.bussiStaff }
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">客户姓名</td>
		<td colspan="3">${customer.name }</td>	
		<td colspan="" align="center">时&#12288;&#12288;间</td>
		<td colspan="4">
			<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日 HH:mm"/>
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
		<td colspan="2" align="center">${customer.customerPidBookingRecord.vinCode }</td>
		<td colspan="2" align="center">
			${customer.customerPidBookingRecord.brand.name }
			${customer.customerPidBookingRecord.carSeriy.name }
			${customer.customerPidBookingRecord.carModel.name }
		</td>	
		<td align="center">${customer.customerPidBookingRecord.carColor.name }</td>
		<td colspan="3" align="center">
			${paymentConfirmation.carPlateNo }
		</td>
		<td align="center" style="width:40px;">
			<c:if test="${orderContract.buyCarType==1 }">
				√				
			</c:if>
		</td>
		<td align="center" style="width:40px;">
			<c:if test="${orderContract.buyCarType==2 }">
				√				
			</c:if>
		</td>
	</tr>
 	<tr>
		<td colspan="3" align="center">收入明细（单位：元）</td>
		<td colspan="7" align="center">备注栏</td>
	</tr>
	  <tr>
		<td align="center" style="width:30px;">1</td>
		<td align="center" style="width: 80px;">合同定金</td>
		<td style="width: 160px;">${orderContract.orderMoney }</td>
		<td style="width: 30px;" rowspan="8" colspan="7" valign="top">
			${orderContract.note }
		</td>
	</tr> 
	
	<tr>
		<td align="center" style="width:30px;">2</td>
		<td align="center" style="width: 80px;">经销商报价</td>
		<td style="width: 160px;">${orderContract.salePrice }</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">3</td>
		<td align="center" style="width: 80px;">车款优惠</td>
		<td style="width: 160px;">${orderContract.preferentialTogether }</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">4</td>
		<td align="center" style="width: 80px;">装饰款</td>
		<td style="width: 160px;">
			${orderContract.decoreMoney }
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">5</td>
		<td align="center" style="width: 80px;">咨询服务费</td>
		<td style="width: 160px;">
			${orderContract.ajsxf }
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;" colspan="3">按揭选填项</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">6</td>
		<td align="center" style="width: 80px;">首付款</td>
		<td style="width: 160px;">
			${orderContract.sfk }
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">7</td>
		<td align="center" style="width: 80px;">贷款</td>
		<td style="width: 160px;">
			${orderContract.daikuan }
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">实收合计</td>
		<td style="width: 160px;" colspan="9">
			${orderContract.totalPrice-orderContract.orderMoney }
		(合同总额-合同定金)
		</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;">注：</td>
		<td align="left" style="width: 80px;" colspan="9">实收合计=经销商报价-车款优惠-合同定金+装饰款+咨询服务费</td>
	</tr>
	<tr>
		<td align="center" style="width:30px;" rowspan="2">付款方式</td>
		<td align="center" style="width: 80px;">现款</td>
		<td align="center" colspan="3">
			<c:if test="${orderContract.payWay==1 }">
				√				
			</c:if>
		</td>
		<td colspan="" align="center" rowspan="2">客户确认</td>
		<td colspan="4" rowspan="2">
			${customer.name }
		</td>
	</tr>
	<tr>
		<td colspan="1" align="center"  style="width: 80px;">转账</td>
		<td colspan="3">
			<c:if test="${orderContract.payWay==2 }">
				√				
			</c:if>
		</td>	
	</tr>
	
	<tr>
		<td colspan="2" align="center">展厅经理确认</td>
		<td colspan="3">
			${orderContract.showRoomManager }
		</td>	
		<td colspan="" align="center">总经理审批</td>
		<td colspan="4">
			${paymentConfirmation.gmManger }
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">销售经理审批</td>
		<td colspan="3">
			${paymentConfirmation.salesManger }
		</td>	
		<td colspan="" align="center">收款确认</td>
		<td colspan="4">
		${paymentConfirmation.paymentConfirmation }
		</td>
	</tr> 
</table>
</div>
</body>

</html>