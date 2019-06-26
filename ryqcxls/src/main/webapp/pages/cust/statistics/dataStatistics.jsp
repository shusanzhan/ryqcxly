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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function () {
	var jsonShoping=eval("${jsonShoping}");
	var jsonPhone=eval("${jsonPhone}");
	var jsonAct=eval("${jsonAct}");
	var jsonOther=eval("${jsonOther}");
	showPie('container','展厅到店量',jsonShoping)	
	showPie('container1','展厅来电量',jsonPhone)	
	showPie('container3','其他电话',jsonOther)	
	showPieBlue('container2','展厅活动量',jsonAct)	
});

function showPie(contId,title,data){
	$('#'+contId).highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: true
        },
        title: {
            text: title
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
            name: title,
            data:data
        }]
    });
}
function showPieBlue(contId,title,data){
	// Make monochrome colors and set them as default for all pies
	Highcharts.getOptions().plotOptions.pie.colors = (function () {
        var colors = [],
            base = Highcharts.getOptions().colors[0],
            i

        for (i = 0; i < 10; i++) {
            // Start out with a darkened base color (negative brighten), and end
            // up with a much brighter color
            colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
        }
        return colors;
	}());
	$('#'+contId).highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: true
        },
        title: {
            text: title
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
            name: title,
            data:data
        }]
    });
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>来电数据分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/statistics/index'">统计分析</a>
</div>
<div class="row-fluid" >
	  	<div class="seracrhOperate" style="float: left;">
	  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statistics/dataStatistics" method="post" >
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
	  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
		  			</c:if>
		  			<c:if test="${empty(param.startTime) }">
	  					<input class="midea text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="<%=DateUtil.getNowMonthFirstDay() %>" >
	  				</c:if>
					</td>
	  				<td>结束：</td>
	  				<td>
	  					<c:if test="${!empty(param.endTime) }">
	  						<input class="midea text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
	  					</c:if>
	  					<c:if test="${empty(param.endTime) }">
	  						<input class="midea text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="<%=DateUtil.format(new Date())%>">
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
		销售数据分析
	</h3>
	<h3>
		(时间:
			<fmt:formatDate value="${start }" pattern="MM月dd日"/>—
			<fmt:formatDate value="${end }" pattern="MM月dd日"/>
		)</h3>
</div>
<div class="row-fluid">
		<div class="widget-box">
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
				<tbody>
					<tr>
						<td>展厅到店量</td>
						<c:set value="0" var="count"></c:set>
						<c:forEach var="item" items="${shoping }">
							<td>
								 <c:set value="${count+ item.countNum}" var="count"></c:set> 
								${item.countNum }
							</td>
						</c:forEach>
						<td>${count }</td>
					</tr>
				</tbody>
			</table>
			<div id="container" style="min-width: 310px; height: 400px; max-width: 1200px;  margin: 0 auto"></div>
		</div>
		
		<div class="widget-box">
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
				<tbody>
					<tr>
						<td>展厅来电量</td>
						<c:set value="0" var="count"></c:set>
						<c:forEach var="item" items="${phone }">
							<td>
								 <c:set value="${count+ item.countNum}" var="count"></c:set> 
								${item.countNum }
							</td>
						</c:forEach>
						<td>${count }</td>
					</tr>
				</tbody>
			</table>
			<div id="container1" style="min-width: 310px; height: 400px; max-width: 1200px;  margin: 0 auto"></div>
		</div>
		
		<div class="widget-box">
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
				<tbody>
					<tr>
						<td>展厅活动量</td>
						<c:set value="0" var="count"></c:set>
						<c:forEach var="item" items="${act }">
							<td>
								 <c:set value="${count+ item.countNum}" var="count"></c:set> 
								${item.countNum }
							</td>
						</c:forEach>
						<td>${count }</td>
					</tr>
				</tbody>
			</table>
			<div id="container2" style="min-width: 310px; height: 400px; max-width: 1200px;  margin: 0 auto"></div>
		</div>
		<div class="widget-box">
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
				<tbody>
					<tr>
						<td>其他电话</td>
						<c:set value="0" var="count"></c:set>
						<c:forEach var="item" items="${other }">
							<td>
								 <c:set value="${count+ item.countNum}" var="count"></c:set> 
								${item.countNum }
							</td>
						</c:forEach>
						<td>${count }</td>
					</tr>
				</tbody>
			</table>
			<div id="container3" style="min-width: 310px; height: 400px; max-width: 1200px; margin: 0 auto"></div>
		</div>
</div>

	
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>