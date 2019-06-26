<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 爱车无痕服务申请表 </title>
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
	line-height: 200%;font-size: 20px;
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
	<p style="font-size: 24px;line-height: 200%;color: #000">爱车无痕服务申请表</p>
</div>
<div class="testDriverContent" style="width: 92%;margin-bottom: 40px;line-height: 150%;font-size: 20px;text-indent: 5px;">
<table id="table" cellpadding="0" cellspacing="0" border="0" style="width: 100%;font-size: 20px;">
	<c:set value="${customer.customerBussi }" var="customerBussi"></c:set>
	<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
	<c:set value="${customer.customerLastBussi }" var="customerLastBussi"></c:set>
	<tr>
		<td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;" >客户姓名</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >${customer.name }</td>
		<td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">联系方式</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >${customer.mobilePhone }</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">身份证号码</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" colspan="3">${customer.icard }</td>
	</tr>
	<tr>
		<td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">所购车型</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >
			${customerBussi.carSeriy.name }
			${customerBussi.carModel.name}
			${customer.carModelStr }
		</td>
		<td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">车牌号</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" >
			${customerLastBussi.carPlateNo }
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">车架号</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" colspan="3">
			<c:if test="${!empty(customerPidBookingRecord) }">
				${customerPidBookingRecord.vinCode }
			</c:if>
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">服务费</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" colspan="3">
			<label style="width: 200px;display: block;float: left;">
			<input type="checkbox" style="height: 24px;width: 24px;">450元</label>
			<label><input type="checkbox" style="height: 24px;width: 24px;">550元</label>
		</td>
	</tr>
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">服务内容</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" colspan="3">
			<p>两个漆面划痕修复</p>
			<p>注：如有效期内，仅使用一个漆面修复，则未使用资源可</p>
			<label style="width: 200px;display: block;float: left;">
			<input type="checkbox" style="height: 24px;width: 24px;">225元</label>
			<label><input type="checkbox" style="height: 24px;width: 24px;">275元</label>
			<p>做为续保或延保基金使用</p>
		</td>
	</tr>
	
	<tr><td class="labelTitle" style="width: 120px;font-size: 20px;height: 50px;">保障有效期</td>
		<td style="width: 300px;font-size: 20px;height: 50px;" colspan="3">
			自&#12288;&#12288;&#12288;年&#12288;&#12288;月&#12288;&#12288;日
			至&#12288; &#12288; &#12288;  年&#12288; &#12288; 月&#12288; &#12288;  日
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<p style="font-size: 20px;color: #000">1	本服务限本车使用，转借无效</p>
			<p style="font-size: 20px;color: #000">2	有效期自购买之日起一年内有效，有效期满请另行续购</p>
			<p style="font-size: 20px;color: #000">3	如有效期满，修复项目未使用，则可选择</p>
			<p style="font-size: 20px;color: #000;text-indent: 40px;" >A、延期一年</p>		
			<p style="font-size: 20px;color: #000;text-indent: 40px;">B、抵扣相应额度的续保费用</p>		
			<p style="font-size: 20px;color: #000;text-indent: 40px;">C、抵扣相应额度的延保费用		</p>		
			<p style="font-size: 20px;color: #000;text-indent: 40px;">D、未使用部分不得退还现金</p>		
			<p style="font-size: 20px;color: #000">4	使用范围：限本车车身漆面划痕修复专用，划痕修复部位含前后保险杠、翼子板、车门、顶棚（不含天窗）等部位被人为划伤或因刮擦导致车身油漆面有划痕，但无需钣金修复且不在保险公司理赔范围内的修复</p>
			<p style="font-size: 20px;color: #000">5	不可使用范围：碰撞导致的车身损坏需钣金修复的 ，属保险公司理赔范围的，均不在本服务范围内。</p>
			<p style="font-size: 20px;color: #000">6	本公司拥有服务最终解释权</p>
			<p style="font-size: 20px;color: #000">7    签字盖章有效</p>
		</td>
	</tr>
		<tr style="height: 220px;">
			<td  style="width: 120px;font-size: 20px;height: 220px;vertical-align: top;" colspan="2">客户确认：</td>
			<td style="width: 120px;font-size: 20px;height: 220px;vertical-align: top;" colspan="2">经办人签字：</td>
		</tr>
</table>

<br>
</div>
</body>
</html>