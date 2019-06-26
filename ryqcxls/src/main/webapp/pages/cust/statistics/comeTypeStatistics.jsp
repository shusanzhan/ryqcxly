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
	var xSer=eval("${xSer}");
	var shopingV=eval("${shopingV}");
	var actV=eval("${actV}");
	var otherV=eval("${otherV}");
	var phoneV=eval("${phoneV}");
	
	
    $('#container').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '来店、进店、活动趋势'
        },
        subtitle: {
        },
        xAxis: {
            categories: xSer
        },
        yAxis: {
            title: {
                text: '来店人数'
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
            name: '来电',
            data:phoneV 
            },
            {
             name: '来店',
             data:shopingV
             },
             {
                 name: '活动',
                 data:actV 
               },
             {
                name: '其他',
                data:otherV 
              }]
    });
    
    $('#container1').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '来店、进店、活动趋势'
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
            name: '来店、进店、活动趋势',
            data: [
                ['来电',  ${phoneCount}],
                ['进店',  ${shopCount}],
                ['活动',    ${actCount}],
                ['其他',   ${otherCount}]
            ]
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
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statistics/index'">统计分析</a>
</div>
<div class="row-fluid" >
	  	<div class="seracrhOperate" style="float: left;">
	  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statistics/comeTypeStatistics" method="post" >
			<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
	  			<tr>
	  				<td>部门：</td>
	  				<td>
	  					<select class="midea text" id="departmentId" name="departmentId"  onchange="$('#searchPageForm')[0].submit()" style="margin-bottom: 0;height: 28px;">
							<option value="0" >请选择...</option>
							<c:forEach var="department" items="${departments }">
								<option value="${department.dbid }" ${param.departmentId==department.dbid?'selected="selected"':'' } >${department.name }</option>
							</c:forEach>
						</select>
	  				</td>
	  				<td>创建时间：</td>
		  			<td>
		  			<c:if test="${!empty(param.startTime) }">
	  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM'})" value="${param.startTime }" >
		  			</c:if>
		  			<c:if test="${empty(param.startTime) }">
	  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM'})" value="<%=DateUtil.getNowMonth() %>" >
	  				</c:if>
					</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
	   			</tr>
	   		</table>
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
				<c:forEach items="${dayComeShops }" var="dayComeShop">
					<td>${dayComeShop.day }</td>
				</c:forEach>
				<td>总计</td>
			</tr>
			 <tr>
				<td>来电</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${phones }" var="dayComeShop">
					<td>${dayComeShop.countNum}</td>
					<c:set value="${ total+dayComeShop.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>进店</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${dayComeShops }" var="dayComeShop">
					<td>${dayComeShop.countNum}</td>
					<c:set value="${ total+dayComeShop.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>活动</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${acts }" var="dayComeShop">
					<td>${dayComeShop.countNum}</td>
					<c:set value="${ total+dayComeShop.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			 <tr>
				<td>其他</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${others }" var="dayComeShop">
					<td>${dayComeShop.countNum}</td>
					<c:set value="${ total+dayComeShop.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span8">
		<div class="widget-box">
			<div id="container" style="min-width: 310px; height: 300px; max-width: 780px; margin: 0 auto"></div>
		</div>
	</div>
	<div class="span4">
		<div class="widget-box">
			<div id="container1" style="min-width: 310px; height: 300px; max-width: 480px; margin: 0 auto"></div>
		</div>
	</div>
</div>
	
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
