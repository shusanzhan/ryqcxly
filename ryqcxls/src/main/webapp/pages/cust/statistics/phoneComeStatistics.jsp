<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
.table th {
    border-bottom: 0 none;
    height: auto;
    padding: 5px 10px 2px;
    text-align: center;
}
.table td {
    height: 0;
    padding-bottom: 0 ;
    width: px;
    border-top: 1px solid #DDDDDD;
    line-height: 20px;
    padding: 8px;
    text-align: left;
    vertical-align: top;
    text-align: center;
}

.widget-box {
    background: none repeat scroll 0 0 #F9F9F9;
    border-left: 1px solid #CDCDCD;
    border-right: 1px solid #CDCDCD;
    border-top: 1px solid #CDCDCD;
    clear: both;
    margin-bottom: 16px;
    margin-top: 16px;
    padding:5px;
    position: relative;
}
</style>
<script type="text/javascript" src="${ctx }/widgets/highcharts/jquery.1.8.2.jquery.min.js"></script>
<script type="text/javascript">
$(function () {
	   $('#container').highcharts({
           title: {
               text: 'Monthly Average Temperature',
               x: -20 //center
           },
           subtitle: {
               text: 'Source: WorldClimate.com',
               x: -20
           },
           xAxis: {
               categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
           },
           yAxis: {
               title: {
                   text: 'Temperature (°C)'
               },
               plotLines: [{
                   value: 0,
                   width: 1,
                   color: '#808080'
               }]
           },
           tooltip: {
               valueSuffix: '°C'
           },
           legend: {
               layout: 'vertical',
               align: 'right',
               verticalAlign: 'middle',
               borderWidth: 0
           },
           series: [{
               name: 'Tokyo',
               data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
           }, {
               name: 'New York',
               data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
           }, {
               name: 'Berlin',
               data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
           }, {
               name: 'London',
               data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
           }]
       });
    $('#container1').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Browser market shares at a specific website, 2014'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Firefox',   45.0],
                ['IE',       26.8],
                {
                    name: 'Chrome',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Safari',    8.5],
                ['Opera',     6.2],
                ['Others',   0.7]
            ]
        }]
    });
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>来电进店数据分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statistics/index'">统计分析</a>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<thead>
			<tr>
				<th>项目</th>
				<th>主力车型</th>
				<th>发力车型</th>
				<th>清库车型</th>
				<th>其他</th>
				<th>合计</th>
			</tr>
		</thead>
				
	</table>
</div>
<div class="row-fluid">
	<div class="span6">
		<div class="widget-box">
			<div id="container" style="min-width: 310px; height: 300px; max-width: 600px; margin: 0 auto"></div>
		</div>
	</div>
	<div class="span6">
		<div class="widget-box">
			<div id="container1" style="min-width: 310px; height: 300px; max-width: 600px; margin: 0 auto"></div>
		</div>
	</div>
</div>
	
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
</html>