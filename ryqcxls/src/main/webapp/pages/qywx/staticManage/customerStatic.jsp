<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
<title>客户构成报表</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">客户构成报表</span>
    <a class="go_home" href="${ctx }/qywxStatic/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div class="row-fluid" style="text-align: center;">
	<h3>
		新登记客户:${newsCountDateCount } 人
	</h3>
	<h5>
		(时间:
			<fmt:formatDate value="${start }" pattern="MM月dd日"/>—
			<fmt:formatDate value="${end }" pattern="MM月dd日"/>
		)</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">A</td>
				<td align="center">B</td>
				<td align="center">C</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${levelCA }</td>
				<td align="center">${levelCB }</td>
				<td align="center">${levelCC }</td>
				<td align="center">${newsCountDateCount }</td>
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
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxStaticManage/customerStatic" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">开始</label></td>
      	 		<td width="240">
      	 			<c:if test="${!empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
      	 		    </c:if>
      	 		    <c:if test="${empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.getNowMonthFirstDay() %>">
      	 		    </c:if>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">结束</label></td>
      	 		<td width="240">
      	 				<c:if test="${!empty(param.endTime) }">
	  						<input type="date"  class="form-control" id="endTime" name="endTime"  value="${param.endTime }">
	  					</c:if>
	  					<c:if test="${empty(param.endTime) }">
	  						<input type="date"  class="form-control" id="endTime" name="endTime" value="<%=DateUtil.format(new Date())%>">
	  					</c:if>
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		客户总体构成
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">新登记</td>
				<td align="center">流失</td>
				<td align="center">订单</td>
				<td align="center">待交车</td>
				<td align="center">成交</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${newsCount }</td>
				<td align="center">${canncelCount }</td>
				<td align="center">${orderCount }</td>
				<td align="center">${waitingCar }</td>
				<td align="center">${customerSuccess }</td>
				<td align="center">${total }</td>
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
            text: '客户占比'
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
            name: '客户占比',
            data: [
				{
				    name: '新登记',
				    y: ${newsCount},
				    sliced: true,
				    selected: true
				},
                ['流失',  ${canncelCount}],
                ['订单', ${orderCount}],
                ['待交车',${waitingCar}],
                ['成交',   ${customerSuccess}]
            ]
        }]
    });
    var data=eval("[ ['A',${levelCA}], ['B',${levelCB}], ['C',${levelCC}]]");
	 $('#container2').highcharts({
       chart: {
           type: 'column'
       },
       title: {
           text: '各级客户量'
       },
     
       xAxis: {
           type: 'category',
           labels: {
               rotation: -45,
               align: 'right',
               style: {
                   fontSize: '13px',
                   fontFamily: 'Verdana, sans-serif'
               }
           }
       },
       yAxis: {
           min: 0,
           title: {
               text: ''
           }
       },
       legend: {
           enabled: false
       },
       tooltip: {
           pointFormat: ': <b>{point.y:.1f} 人</b>',
       },
       series: [{
           name: 'Population',
           data: data,
           dataLabels: {
               enabled: true,
               rotation: -90,
               color: '#FFFFFF',
               align: 'right',
               x: 4,
               y: 10,
               style: {
                   fontSize: '13px',
                   fontFamily: 'Verdana, sans-serif',
                   textShadow: '0 0 3px black'
               }
           }
       }]
   });
});
</script>
</html>