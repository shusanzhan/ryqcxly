<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>回访统计</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span>回访统计</span>
    <a class="go_home" href="${ctx }/qywxStatic/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">回访中</td>
				<td align="center">成功回访</td>
			</tr>
			<tr>
				<td align="center">${waitingCount }</td>
				<td align="center">${successCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成功回访客户
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">不计考核</td>
				<td align="center">考核客户</td>
				<td align="center">成功回访</td>
			</tr>
			<tr>
				<td align="center">${notSuccessAgesCount }</td>
				<td align="center">${successAgesCount }</td>
				<td align="center">${successCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		考核统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">核心流程调查</td>
				<td align="center">是否介绍延保服务</td>
				<td align="center">满意率</td>
			</tr>
			<tr>
				<td align="center">${notCuont }</td>
				<td align="center">${ybCount }</td>
				<td align="center">${manyiCount/manyiTotalCount*100 }%</td>
			</tr>
		</tbody>
	</table>
</div>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '回访统计'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: '回访状态',
            data: [
				{
				    name: '回访中',
				    y: ${waitingCount},
				    sliced: true,
				    selected: true
				},
				['在途', ${successCount}],
            ]
        }]
    });
});
</script>
</html>