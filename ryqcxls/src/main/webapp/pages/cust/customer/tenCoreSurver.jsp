<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 奇瑞汽车“十项核心流程”面访调查问卷 </title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<style type="text/css">
	table td, table th{
	font-size: 20px;
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
<br>
<div class="testDriverContent" style="width: 92%;margin-bottom: 40px;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;width: 20%">
			<img src="${ctx }/images/xwqr/logo.png" width="175"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 32px;font-weight: bold;border: 0px solid #000000;width: 60%">奇瑞汽车“十项核心流程”面访调查问卷</td>
		<td style="border: 0px solid #000000;width: 20%"></td>
	</tr>
</table>
<br>
<br>
<table cellpadding="0" cellspacing="0" border="0" style="width: 900px;">
	<tr >
			<td colspan="6" style="text-align: left;padding:20px 62px;border: 0px ;">
				尊敬的客户：<br>您好！我们正在进行一项问卷调查，希望借这次调查，以了解我公司是否提供给您全面、周到的服务。后期我公司将按照您提出的宝贵意见，改进我们的服务（下述项目如达到要求请打“√”，否则打“×”）。
			</td>
	</tr>
	</table>
<table cellpadding="0" cellspacing="0" border="0" style="width: 900px;">
	<tr height="30">
		<td  style="text-align: center;width: 30px;">
			序号
		</td>
		<td style="text-align: center;width: 120px">调查项目</td>
		<td style="text-align: center;width: 650px;">调查话术</td>
		<td style="text-align: center;width: 50px">执行<br>结果</td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">1</td>
		<td colspan="1" style="padding: 5px;text-align: center;">展厅氛围</td>
		<td style="padding: 5px;">请问整个展厅氛围温馨舒适程度是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">2</td>
		<td colspan="1" style="padding: 5px;text-align: center;">主动接待</td>
		<td style="padding: 5px;">请问每次进店，销售人员的主动接待是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">3</td>
		<td colspan="1" style="padding: 5px;text-align: center;">产品介绍</td>
		<td style="padding: 5px;">请问您对销售顾问的专业知识水平是否满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">4</td>
		<td colspan="1" style="padding: 5px;text-align: center;">邀约试驾</td>
		<td style="padding: 5px;">请问在购车过程中，销售人员主动邀约试乘试驾是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">5</td>
		<td colspan="1" style="padding: 5px;text-align: center;">购车文件</td>
		<td style="padding: 5px;">请问销售顾问对于购车相关文件（如购车合同内容、条款）的讲解是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">6</td>
		<td colspan="1" style="padding: 5px;text-align: center;">交车仪式</td>
		<td style="padding: 5px;">请问在交车过程中工作人员举办的交车仪式、合影留念是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">7</td>
		<td colspan="1" style="padding: 5px;text-align: center;">功能讲解</td>
		<td style="padding: 5px;">请问在交车当天，销售人员对车辆基本操作功能及三包服务介绍的详细程度是否让您满意?</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">8</td>
		<td colspan="1" style="padding: 5px;text-align: center;">致电关怀</td>
		<td style="padding: 5px;">在当天交车后，工作人员主动通过电话、短信、微信等方式对您进行的回访关怀是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">9</td>
		<td colspan="1" style="padding: 5px;text-align: center;">礼仪态度</td>
		<td style="padding: 5px;">请问在整个购车过程及交车环节中，销售人员的热情态度是否让您满意？</td>
		<td></td>
	</tr>
	<tr height="60">
		<td rowspan="" style="padding: 5px;text-align: center;" align="center">10</td>
		<td colspan="1" style="padding: 5px;text-align: center;">承诺兑现</td>
		<td style="padding: 5px;">请问在整个购车过程及交车环节中，销售人员的承诺兑现是否让您满意？</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="4" style="padding: 5px;">
			对我店的意见或建议：
			<br>
			<br>
			<br>
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="width: 900px;height: 120px;margin-top: 20px;">
	<tr >
			<td colspan="3" style="text-align: left;border: 0px ;">
				客户签字：<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
			</td>
			<td colspan="3" style="text-align: left;border: 0px ;">
				手机号：<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
			</td>
	</tr>
	<tr >
			<td colspan="3" style="text-align: left;border: 0px ;">
				销售顾问：<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
			</td>
			<td colspan="3" style="text-align: left;border: 0px ;">
				面访日期：&#12288;&#12288;&#12288;&#12288;年 &#12288;&#12288;月&#12288;&#12288; 日
			</td>
	</tr>
	</table>
</div>
</body>
</html>