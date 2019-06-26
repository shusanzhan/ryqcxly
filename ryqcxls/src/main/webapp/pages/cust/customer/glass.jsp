<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 玻璃无忧卡购买确认书    </title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<style type="text/css" media="print">
.bar {
	display: none;
}
body {
	color: #000;
	background-color: #ffffff;
}

.testDriverContent p{
	line-height: 300%;font-size: 20px;
}
#table td{
	color: #000000;
}
table td, table th {
	line-height: 36px;
	font-size: 14px;
	border: 1px solid #000000;
	color: #000000;
	width: 100px;
}
</style>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
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
<div style="margin: 0 auto;text-align: center;padding: 20px;color: #000">
	<p style="font-size: 40px;line-height: 200%;color: #000">${customer.enterprise.allName }</p>
	<p style="font-size: 24px;line-height: 200%;color: #000">玻璃无忧卡购买确认书</p>
</div>
<div class="testDriverContent" style="width: 760px;margin-bottom: 40px;text-indent: 28px;line-height: 200%;font-size: 20px;">
<p style="font-size: 20px;color: #000">成都瑞一汽车有限公司为您提供一年车辆玻璃质保服务，您只需要支付一笔较小的费用，就能避免在之后用车过程中因小意外引发的大笔费用支出，选着我们这款产品能让您无忧出行。</p>
<table id="table" cellpadding="0" cellspacing="0" border="0" style="width: 80%;font-size: 20px;">
	<c:set value="${customer.customerBussi }" var="customerBussi"></c:set>
	<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
	<tr>
		<td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;" >客户姓名</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >${customer.name }</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">身份证号码</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >${customer.icard }</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">联系方式</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >${customer.mobilePhone }</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">所购车型</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >
			${customerBussi.brand.name }
			${customerBussi.carSeriy.name }
			${customerBussi.carModel.name}
			${customer.carModelStr }
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">车牌号/车架号</td>
		<td style="width: 300px;font-size: 20px;height: 50px;">
			<c:if test="${!empty(customerPidBookingRecord) }">
				${customerPidBookingRecord.vinCode }
			</c:if>
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">玻璃无忧卡金额</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >
			<label style="width: 200px;display: block;float: left;"><input type="checkbox" style="height: 24px;width: 24px;">260元</label>
			<label><input type="checkbox" style="height: 24px;width: 24px;">300元</label>
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">保障有效期</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" ></td>
	</tr>
</table>
<p style="font-size: 20px;color: #000">保障说明：</p>
<p style="font-size: 20px;color: #000">指定维修：${customer.enterprise.allName }。</p>
<p style="font-size: 20px;color: #000">保障时间：自玻璃无忧卡购买之日起一年内均有效。</p>
<p style="font-size: 20px;color: #000">保障范围：限本车前挡玻璃、后档玻璃、左右侧门玻璃、玻璃胶条、玻璃胶以及相关维修工时费。</p>
<p style="font-size: 20px;color: #000">保障次数：在保障时间内3次无条件更换保障范围内的玻璃破碎更换维修。</p>
<p style="font-size: 20px;color: #000">非理赔内容：天窗玻璃、车灯玻璃、倒车镜玻璃等破损。</p>
<p style="font-size: 20px;color: #000">本公司对玻璃无忧卡享有最终解释权！</p>
<p style="font-size: 20px;color: #000">签字盖章有效</p>
<br>
<table id="table" cellpadding="0" cellspacing="0" border="0" style="font-size: 20px;border: 0;">
	<tr>
		<td  style="width: 120px;border: none;font-size: 20px;" >客户确认：</td>
		<td style="width: 120px;border: none;font-size: 20px;" >经办人签字：</td>
	</tr>
	<tr><td  style="width: 120px;border: none;font-size: 20px;">日期：</td>
		<td  style="width: 120px;border: none;font-size: 20px;"> 日期：</td>
	</tr>
</table>
</div>
</body>
</html>