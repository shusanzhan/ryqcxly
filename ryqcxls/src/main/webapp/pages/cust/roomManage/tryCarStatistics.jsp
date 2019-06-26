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
<script type="text/javascript">
$(function () {
	 var data=eval("[['未试驾',${queryTryCar[0]/totalCount}],['试驾',${queryTryCar[1]/totalCount}]]");
    $('#container1').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '试乘试驾占比'
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
            name: '试乘试驾',
            data: data
        }]
    });
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>试乘试驾统计分析</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/roomManage/index'">统计分析</a>
</div>
<div class="row-fluid" >
	  	<div class="seracrhOperate" style="float: left;">
	  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/roomManage/tryCarStatistics" method="post" >
			<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
	  			<tr>
	  				<td>销售员：</td>
	  				<td>
	  					<select class="midea text" id="userId" name="userId"  onchange="$('#searchPageForm')[0].submit()" style="margin-bottom: 0;height: 28px;">
							<option value="0" >请选择...</option>
							<c:forEach var="user" items="${users }">
								<option value="${user.dbid }" ${param.userId==user.dbid?'selected="selected"':'' } >${user.realName }</option>
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
		成都远大
		试乘试驾率分析
	</h3>
	<h3>
		(时间:
			<fmt:formatDate value="${start }" pattern="MM月dd日"/>—
			<fmt:formatDate value="${end }" pattern="MM月dd日"/>
		)</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td>是否试驾</td>
				<td>试驾</td>
				<td>未试驾</td>
				<td>总计</td>
			</tr>
			 <tr>
				<td>合计</td>	
				<td>${queryTryCar[1] }</td>
				<td>${queryTryCar[0] }</td>
				<td>${totalCount }</td>
			</tr>
			<tr>
				<td>占比</td>
				<td>
					<fmt:formatNumber value="${queryTryCar[1]/totalCount*100 }" pattern="0.00#"></fmt:formatNumber>%
				</td>
				<td>
					<fmt:formatNumber value="${queryTryCar[0]/totalCount*100 }" pattern="0.00#"></fmt:formatNumber>%
				</td>
				<td>100.0%</td>
			</tr> 
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="widget-box">
			<div id="container1" style="min-width: 720px; height: 300px; max-width: 1200px; margin: 0 auto"></div>
		</div>
</div>
	
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
