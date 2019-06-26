<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../commons/taglib.jsp" %>
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
<title>${brand.name }易被考核问题</title>
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
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${brand.name }易被考核问题</span>
    <a class="go_home" href="${ctx }/qywxHfIndex/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
          <ul class="clearfix padding10">
           <li class="detail_tap2 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxHfQuest/month?brandId=${brandId}'">月</li>
           <li class="detail_tap2 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxHfQuest/year?brandId=${brandId}'">年</li>
      	</ul>
     </div>
 </div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${startTime }月自有店回访问题<span style="font-size: 14px;"></span>
	</h5>
</div>
<div class="row-fluid">
	<c:if test="${empty(hfQuests) }">
		<div class="alert alert-danger" role="alert">提示：回访无不合格数据</div>
	</c:if>
	<c:if test="${!empty(hfQuests) }">
		<table class="table table-bordered table-striped">
			<tbody>
				<tr>
					<td align="center" width="60">序号</td>
					<td align="center" width="200">内容</td>
					<td align="center" width="40">共计</td>
				</tr>
				<c:forEach var="hfQuest" items="${ hfQuests}">
					<tr>
						<td id='trTd' align='center'  valign='middle'>
							${hfQuest.no }
						</td>
						<td id='trTd' align="left"  valign='middle'>
							${hfQuest.content }
						</td>
						<td id='trTd' align='center'  valign='middle'>
							${hfQuest.total }
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
	</c:if>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${startTime }月经销商回访问题<span style="font-size: 14px;"></span>
	</h5>
</div>
<div class="row-fluid">
	<c:if test="${empty(netHfQuests) }">
		<div class="alert alert-danger" role="alert">提示：回访无不合格数据</div>
	</c:if>
	<c:if test="${!empty(netHfQuests) }">
		<table class="table table-bordered table-striped">
			<tbody>
				<tr>
					<td align="center" width="60">序号</td>
					<td align="center" width="200">内容</td>
					<td align="center" width="40">共计</td>
				</tr>
				<c:forEach var="hfQuest" items="${ netHfQuests}">
					<tr>
						<td id='trTd' align='center'  valign='middle'>
							${hfQuest.no }
						</td>
						<td id='trTd' align="left" valign='middle'>
							${hfQuest.content }
						</td>
						<td id='trTd' align='center'  valign='middle'>
							${hfQuest.total }
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
	</c:if>
</div>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxHfQuest/year" name="frmId" id="frmId" method="post">
      		<input type="hidden" name="brandId" value="${brandId }" id="brandId">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<select id="startTime" name="startTime" class="form-control">
      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
      	 					<option value="${i }" ${param.startTime==i?'selected="selected"':'' } >${i }年</option>
      	 				</c:forEach>
      	 			</select>
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
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
Highcharts.setOptions({  
    lang: {  
           decimalPoint : ",",  
           months: ['一月', '二月','三月', '四月', '五月', '六月',  
                         '七月', '八月','九月', '十月', '十一月', '十二月'], 
          shortMonths: ['1月', '2月', '3月', '4月', '5月', '6月',  
                        '7月', '8月', '9月', '10月', '11月', '12月'],
           weekdays: ['月日', '月二','Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']  
    }  
});  
$(function () {
    $('#container').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '集客月报'
        },
        xAxis: {
            categories: ${buffButtomTitles}
        },
        yAxis: {
            title: {
                text: '集客量 (人)'
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'°C';
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
            name: 'Tokyo',
            data: ${buffValues}
        }]
    });
    $('#container2').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '车系关注度趋势图'
        },
        xAxis: {
            categories: ${buffButtomTitles}
        },
        yAxis: {
            title: {
                text: '关注人'
            }
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br>'+this.x +': '+ this.y +'°C';
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
        series:${buffCarseryValues}
    });
    $('#container3').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '部门集客趋势图'
        },
        xAxis: {
            categories: ${buffButtomTitles}
        },
        yAxis: {
            title: {
                text: '集客人'
            }
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br>'+this.x +': '+ this.y +'°C';
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
        series:${buffDepartmentValues}
    });
    
});				
</script>
</html>