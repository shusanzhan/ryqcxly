<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
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
<title>成交客户报表</title>
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
    <span id="page_title">成交客户报表</span>
    <a class="go_home" href="${ctx }/qywxRoomManageSaleReport/index">
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
           <li class="detail_tap5 detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxRoomManageSuccessReport/customerSuccess'">日</li>
           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxRoomManageSuccessReport/customerSuccess7Day'">最近7日</li>
           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxRoomManageSuccessReport/customerSuccessWeek'">周</li>
           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxRoomManageSuccessReport/customerSuccessMonth'">月</li>
           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxRoomManageSuccessReport/customerSuccessYear'">年</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;">
	<h4>${title }</h4>
</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		成交客户车系
	</h5>
</div>
<div class="row-fluid">
	<h5 style="text-align: left;font-size: 16px">
		总成交<span style="color: #ed145b;font-size: 18px;">${selfShopTotal+netTotal }</span>台，
		其中<c:forEach var="brandTotal" items="${brandTotals }" varStatus="i">
			<c:if test="${(i.index+1)==fn:length(brandTotals) }" var="status">
				${brandTotal.serName }：<span style="color: #ed145b;font-size: 18px;">${brandTotal.countNum }</span>台
			</c:if>
			<c:if test="${status==false }">
				${brandTotal.serName }：<span style="color: #ed145b;font-size: 18px;">${brandTotal.countNum }</span>台，
			</c:if>
		</c:forEach>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="carSerCount" items="${carseriyTotals }">
					<tr>
				<td align="center" width="80">${carSerCount.serName }</td>
				<td align="center" width="40">${carSerCount.countNum }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxRoomManageSuccessReport/customerSuccess" name="frmId" id="frmId" method="post">
      	 <table>
      	 		<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<c:if test="${!empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
      	 		    </c:if>
      	 		    <c:if test="${empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
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
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/aui-artDialog/css/ui-dialog.css" />
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/aui-artDialog/dist/dialog-plus.js"></script>
<script type="text/javascript">
$(function () {
	var data=eval("${jsonCarData}");
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
            text: '车辆占比'
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
            name: '车辆占比',
            data: data
        }]
    });
});
</script>
</html>