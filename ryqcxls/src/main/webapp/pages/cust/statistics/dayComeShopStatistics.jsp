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
	var xSerValue=eval("${xSerValue}");
    $('#container').highcharts({
        chart: {
            type: 'area'
        },
        title: {
            text: '每日进店客流量趋势'
        },
        subtitle: {
        },
        xAxis: {
            categories: xSer,
            tickmarkPlacement: 'on',
            title: {
                enabled: false
            }
        },
        yAxis: {
            title: {
                text: '进店人数（人）'
            },
            labels: {
                formatter: function() {
                    return this.value / 1 +'人';
                }
            }
        },
        tooltip: {
            pointFormat: '{series.name}  {point.x} 日 进店人数 <b>{point.y:,.0f}</b><br/> '
        },
        plotOptions: {
            area: {
                pointStart: 0,
                marker: {
                    enabled: false,
                    symbol: 'circle',
                    radius: 2,
                    states: {
                        hover: {
                            enabled: true
                        }
                    }
                }
            }
        },
        series: [{
            name: '<fmt:formatDate value="${now }" pattern="MM月"/>',
            data:xSerValue 
            }]
    });
});

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>每日进店量趋势分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statistics/index'">统计分析</a>
</div>
<div class="row-fluid" >
	  	<div class="seracrhOperate" style="float: left;">
	  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statistics/dayComeShopStatistics" method="post" >
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
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
	   			</tr>
	   		</table>
	   		</form>
	   	</div>
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
		)每日进店量趋势分析
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
				<td>合计</td>
				<c:set value="0" var="total"></c:set>	
				<c:forEach items="${dayComeShops }" var="dayComeShop">
					<td>${dayComeShop.countNum}</td>
					<c:set value="${ total+dayComeShop.countNum}"  var="total"></c:set>
				</c:forEach>
				<td>${total }</td>
			</tr>
			<tr>
				<td>占比</td>
				<c:forEach items="${dayComeShops }" var="dayComeShop">
					<td>${dayComeShop.per }</td>
				</c:forEach>
				<td>100.0%</td>
			</tr> 
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="widget-box">
			<div id="container" style="min-width:1024px; height: 300px; max-width: 1440px; margin: 0 auto"></div>
		</div>
</div>
	
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
