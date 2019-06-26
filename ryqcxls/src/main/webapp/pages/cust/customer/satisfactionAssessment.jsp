<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 试乘试驾评估表    </title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<style type="text/css" media="print">
.bar {
	display: none;
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
<div class="testDriverContent" style="width: 92%;margin-bottom: 40px;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;width: 20%">
			<img src="${ctx }/images/xwqr/logo.png" width="175"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 20%">试乘试驾评估表</td>
		<td style="border: 0px solid #000000;width: 20%"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr >
		<c:if test="${empty(customer.sn) }">
			<td colspan="6" style="text-align: right;padding-right: 200px;">编号：${customer.sn }</td>
		</c:if>
		<c:if test="${!empty(customer.sn) }">
			<td colspan="6" style="text-align: right;padding-right: 100px;">编号：${customer.sn }</td>
		</c:if>
	</tr>
	<tr>
		<td class="labelTitle" style="font-weight: bold;font-size: 14px;" colspan="2">客户姓名</td>
		<td style="width: 300px;" >${customer.name }</td>
		<td class="labelTitle" style="font-weight: bold;font-size: 14px;" colspan="2">联系方式</td>
		<td style="width: 300px;" >${customer.mobilePhone }</td>
	</tr>
	<tr>
		<td class="labelTitle" style="font-weight: bold;font-size: 14px;" colspan="2">试乘/试驾车型</td>
		<td >${customer.profession.name }</td>
		<td class="labelTitle" style="font-weight: bold;font-size: 14px;" colspan="2">试乘/试驾日期</td>
		<td ><fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/></td>
	</tr>
	<tr>
	</tr>
	<tr>
		<td class="labelTitle" style="font-weight: bold;font-size: 14px;border-bottom: 0px;" rowspan="3" colspan="2">请您写下本次动态体验给您留下的三个印象</td>
		<td colspan="4" style="border-bottom: 0px;height: 40px;"></td>
	</tr>
	<tr>
		<td colspan="4" style="border-bottom: 0px;height: 40px;"></td>
	</tr>
	<tr>
		<td colspan="4" style="border-bottom: 0px;height: 40px;"></td>
	</tr>
	</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr height="30">
		<td colspan="3"  rowspan="2" style="text-align: center;width: 50%;font-weight: bold;font-size: 14px;background-color:#C0C0C0 ">
			意见反馈项目
		</td>
		<td colspan="3" style="text-align: center;font-weight: bold;font-size: 14px;background-color:#C0C0C0">
			评价结果（请根据您的满意度意愿在空白处打“√”）
		</td>
	</tr>
	<tr height="30">	
		<td style="text-align: center;font-weight: bold;font-size: 14px;background-color:#C0C0C0">不满意</td>
		<td style="text-align: center;font-weight: bold;font-size: 14px;background-color:#C0C0C0">基本满意</td>
		<td style="text-align: center;font-weight: bold;font-size: 14px;background-color:#C0C0C0">很满意</td>
	</tr>
	<tr height="60">
		<td rowspan="5" style="width: 80px;" align="center">车型</td>
		<td colspan="2" style="width: 160px;">您对试乘试驾车的动力表现是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾车的操控性能是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾车的制动性能是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾车的舒适性能是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾车的内部乘坐空间感受是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td style="width: 80px;" align="center">服务</td>
		<td colspan="2" style="width: 160px;">您对销售顾问的试乘试驾服务是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="4" style="width: 80px;" align="center">流程</td>
		<td colspan="2" style="width: 160px;">您对试乘试驾车的车况和清洁程度是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾路线的长度是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾路线设置的测试项目是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="2" style="width: 160px;">您对试乘试驾车的综合评价是否满意</td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr height="60">
		<td colspan="3" >
			您认为试乘试驾对您购车是否有作用
		</td>
		<td colspan="3" >
				<input type="checkbox" style="margin-right: 20px;">是</input>
				<input type="checkbox" style="margin-right: 20px;">否</input>
		</td>
	</tr>
	<tr height="60">
		<td colspan="6" style="font-size: 14px;">
			请在这里写下您对本次试乘试驾的任何感受、意见和建议：
			<br>
			<br>
		</td>
	</tr>
	<tr height="60">
		<td colspan="6" style="font-size: 14px;">
			感谢您的支持和配合，请在此处签署您的姓名：
		</td>
	</tr>
</table>
</div>
</body>
</html>