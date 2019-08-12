<%@page import="java.util.List"%>
<%@page import="sun.print.resources.serviceui"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
#trTd{
	vertical-align: middle;
}
</style>
<title>待交车车源情况</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span>待交车车源情况</span>
    <a class="go_home" href="${ctx }/qywxSaleReport/index?role=${param.role}">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
         	<c:if test="${param.type==1 }" var="status">
	           <li class="detail_tap detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/order?type=1&role=${param.role }'">当日新增订单</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap detail_tap pull_left" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/order?type=1&role=${param.role }'">当日新增订单</li>
         	</c:if>
         	<c:if test="${param.type==2 }" var="status">
	           <li class="detail_tap detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/waitingCar?type=2&role=${param.role }'">留存订单</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap detail_tap pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/waitingCar?type=2&role=${param.role }'">留存订单</li>
         	</c:if>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;">
	<h3>
	当前待交车:${waitingCar } 人
	</h3>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		车源情况统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">物流未处理</td>
				<td align="center">物流已经处理</td>
			</tr>
			<tr>
				<td align="center">${wlNoDeal }</td>
				<td align="center">${wlDealEd }</td>
			</tr>
		</tbody>
	</table>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">无车</td>
				<td align="center">在途</td>
				<td align="center">现车</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${noCar }</td>
				<td align="center">${driverCar }</td>
				<td align="center">${hasCar }</td>
				<td align="center">${wlDealEd }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container1" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		购车方式统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">现款</td>
				<td align="center">分期</td>
				<td align="center">未确定</td>
			</tr>
			<tr>
				<td align="center">${xiankuan }</td>
				<td align="center">${feiqi }</td>
				<td align="center">${waitingCar-xiankuan-feiqi}</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container2" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		订单车型分布
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">序号</td>
				<td align="center" width="40">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="count" items="${carSeriyCounts }" varStatus="i">
				<tr>
					<td align="center" width="40">${i.index+1 }</td>
					<td align="center" width="80">${count.name }</td>
					<td align="center" width="60">${count.num }</td>
				</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="3" style="text-align: right;">合计：${waitingCar }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container3" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		各车型明细
	</h5>
</div>
<div class="row-fluid">
	${carSeriByDetail }
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		分公司总数据
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">序号</td>
				<td align="center" width="40">公司</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="count" items="${countEnterprises }" varStatus="i">
				<tr>
					<td align="center" width="40">${i.index+1 }</td>
					<td align="center" width="80">${count.name }</td>
					<td align="center" width="60">${count.num }</td>
				</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="3" style="text-align: right;">合计：${waitingCar }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container4" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		各分公司订单明细
	</h5>
</div>
<div class="row-fluid">
	${depDetails }
</div>

<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		各公司销售顾问订单明细
	</h5>
</div>
<div class="row-fluid">
	${userDetails }
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function () {
    $('#container2').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45
            }
        },
        title: {
            text: '购车方式统计'
        },
        subtitle: {
            text: ''
        },
        plotOptions: {
            pie: {
                innerSize: 100,
                depth: 45
            }
        },
        series: [{
            name: '购车方式',
            data: [
                ['现款', ${xiankuan}],
                ['分期', ${feiqi}],
                ['未确定', ${waitingCar-xiankuan-feiqi}]
            ]
        }]
    });
});
$('#container3').highcharts({
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false
    },
    title: {
        text: '车系比例'
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
        name: '车系',
        data: ${carSeriyPie}
    }]
});			
$(function () {
    $('#container1').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '待交车车源情况'
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
            name: '车源状态',
            data: [
				{
				    name: '无车',
				    y: ${noCar},
				    sliced: true,
				    selected: true
				},
				['在途', ${driverCar}],
                ['现车',  ${hasCar}]
            ]
        }]
    });
    $('#container4').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '分公司订单比例'
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
            name: '公司',
            data: ${pie}
        }]
    });
});
</script>
</html>