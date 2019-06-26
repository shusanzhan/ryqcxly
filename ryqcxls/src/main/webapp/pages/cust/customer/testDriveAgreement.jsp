<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>试乘试驾协议书</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
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
<style type="text/css">
.body{
	font-size: 16px;
}
.contentTable{
}
.contentTable tr{
	height: 60px;
}
</style>
</head>
<body class="body">
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>
<div class="testDriverContent" style="margin-bottom: 50px;width: 97%;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;">
			<img src="${ctx }/images/xwqr/logo.png" width="175"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;">试乘试驾协议书</td>
		<td style="border: 0px solid #000000;"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" class="contentTable">
	<tr>
		<td>客户编号：${customer.sn }</td>
	</tr>
	<tr>
		<td>
		<p>尊敬的客户：</p>
		<p style="text-indent: 24px;">
			感谢您莅临奇瑞汽车<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>4S店参加试乘试驾活动！为更好地为您（
			<label><input type="checkbox" id="">试乘</label>&#12288;&#12288;<label><input type="checkbox" id="">试乘</label>）服务，请您确定相关事项。</p>
		</td>
	</tr>
	<tr>
		<td>
			<p style="text-indent: 24px;">致&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;公司：</p>
			<p style="text-indent: 24px;">
				兹本人&#12288;&#12288;${customer.name }&#12288;&#12288;&#12288;&#12288;于&#12288;&#12288;&#12288;&#12288;<fmt:formatDate value="${now }" pattern="yyyy  &#12288;年 &#12288;MM &#12288;月 &#12288;dd &#12288;日"/>，试驾贵公司奇瑞汽车&#12288;&#12288;&#12288;&#12288;车型（车牌号或车架号:&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;）
			</p>
			<p style="text-indent: 24px;"><p>,特做出如下承诺：</p>
			<p style="text-indent: 24px;">1.本人在试乘试驾过程中，将严格遵守行车驾驶的一切操作规范及交通法则和要求，做到安全文明驾驶，并服从</p>
			<p>贵公司提出的注意事项；</p>
			<p style="text-indent: 24px;">2.在试驾时不进行危险驾驶动作，对车辆操作若有不明，及时询问贵公司同乘工作人员，并服从工作人员的合理</p>
			<p>建议或意见；</p>
			<p style="text-indent: 24px;">3.本人在试乘试驾中由于操作不当或违规操作造成对贵公司及他人的一切损失，概由本人承担全部责任；</p>
			<p style="text-indent: 24px;">4.试乘试驾中造成的事故，4S店保留对因事故所造成的车辆损失的索赔权；</p>
			<p style="text-indent: 24px;">5.未尽事宜，遵循“合理”、“合法”原则、双方友好协商。</p>
		</td>
	</tr>
	<tr>
		<td>联系电话：${customer.mobilePhone }</td>
	</tr>
	<tr>
		<td>联系地址：${customer.area.fullName}${customer.address }</td>
	</tr>
	<tr>
		<td ><p >试驾人（签字）：</p></td>
	</tr>
	<tr>
		<td>
			<div class="testDriverContent" style="text-align: center;">
				<div class="cardConent" style="margin-top: 12px;margin-bottom: 12px;width: 70%;margin-left: 240px;">
					机动车驾驶证
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td style="border: 0px;">
			<p style="text-align: right;padding-right: 120px;"><fmt:formatDate value="${now }" pattern="yyyy  &#12288;年 &#12288;MM &#12288;月 &#12288;dd &#12288;日"/></p>
		</td>
	</tr>
</table>
</div>
</body>
</html>