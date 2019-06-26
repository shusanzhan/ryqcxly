<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
    width: 20px;
    border-top: 1px solid #DDDDDD;
    line-height: 20px;
    text-align: left;
    text-align: center;
    padding: 2px;
    vertical-align:center;
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
		 var data=eval("[ ['O',${levelCO}], ['A',${levelCA}], ['B',${levelCB}], ['C',${levelCC}]]");
		 $('#container').highcharts({
	         chart: {
	             type: 'column'
	         },
	         title: {
	             text: '月度各级客户量'
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
	                 text: '客户量（人）'
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
    
    $('#container1').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '月度各级客户占比'
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
            name: '月度各级客户占比',
            data:data
        }]
    });
    
    var xSer=eval("${xSer}");
    var levelOV=eval("${levelOV}");
    var levelAV=eval("${levelAV}");
    var levelBV=eval("${levelBV}");
    var levelCV=eval("${levelCV}");


    $('#container2').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '月度各级客户趋势'
        },
        subtitle: {
        },
        xAxis: {
            categories: xSer
        },
        yAxis: {
            title: {
                text: '月度各级客人数'
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: 'O',
            data:levelOV 
            },
            {
             name: 'A',
             data:levelAV 
             },
             {
                 name: 'B',
                 data:levelBV  
               },
             {
                name: 'C',
                data:levelCV 
              }]
    });
    
  
});


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>每日进店来店量趋势分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statisticsSaler/index'">统计分析</a>
</div>
<div class="row-fluid" >
	  	<div class="seracrhOperate" style="float: left;">
	  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statisticsSaler/levelStatistics" method="post" >
			<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
	   		</form>
	   	</div>
	   		<div style="clear: both;"></div>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成都瑞一奇瑞
		<c:if test="${empty(department) }">
			4S店
		</c:if>
		<c:if test="${!empty(department) }">
			${department.name }
		</c:if>
	</h3>
	<h3>
		（<fmt:formatDate value="${now }" pattern="MM月"/>
		)来电进店分析
		</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td>时间</td>
				<c:forEach items="${levelOs }" var="levelO">
					<td>${levelO.day }</td>
				</c:forEach>
				<td>总计</td>
			</tr>
			 <tr>
				<td>O</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${levelOs }" var="levelO">
					<td>${levelO.countNum}</td>
					<c:set value="${ total+levelO.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>A</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${levelAs }" var="levelA">
					<td>${levelA.countNum}</td>
					<c:set value="${ total+levelA.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>B</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${levelBs }" var="levelB">
					<td>${levelB.countNum}</td>
					<c:set value="${ total+levelB.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>C</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${levelCs }" var="levelC">
					<td>${levelC.countNum}</td>
					<c:set value="${ total+levelC.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
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
	<div class="span6">
		<div class="widget-box">
			<div id="container1" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<div class="row-fluid">
<div class="widget-box">
	<div id="container2" style="min-width: 310px; height: 300px; max-width: 1280px; margin: 0 auto"></div>
</div>
</div>
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
