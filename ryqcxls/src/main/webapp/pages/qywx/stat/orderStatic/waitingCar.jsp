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
#trTd{
	vertical-align: middle;
}
.table td{
	text-align: center;
   
}
#totalTr {
    font-weight: bold;
    background-color: #009688;
    color: white;
}
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td, .table>tbody>tr>td, .table>tfoot>tr>td {
    padding: 8px 0px;
    line-height: 1.42857143;
    vertical-align: center;
    border-top: 1px solid #ddd;
    font-size: 10px;
}
</style>
<title>留存订单分析</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span>留存订单分析</span>
    <a class="go_home" href="${ctx }/qywxStat/index">
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
         	<c:if test="${param.type==1 }" var="status">
	           <li class="detail_tap detail_tap3 pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/order?type=1&role=${param.role }'">当日新增订单</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap detail_tap3 pull_left" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/order?type=1&role=${param.role }'">当日新增订单</li>
         	</c:if>
         	<c:if test="${param.type==3 }" var="status">
	           <li class="detail_tap detail_tap3 pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/queryOrderList?type=3&role=${param.role }'">当月订单</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap detail_tap3 pull_left" style="border-left: 1px solid #ed145b;" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/queryOrderList?type=3&role=${param.role }'">当月订单</li>
         	</c:if>
         	<c:if test="${param.type==2 }" var="status">
	           <li class="detail_tap detail_tap3 pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/waitingCar?type=2&role=${param.role }'">留存订单</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap detail_tap3 pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/waitingCar?type=2&role=${param.role }'">留存订单</li>
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
		购车方式统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">部门</td>
				<td align="center">总数</td>
				<td align="center">现款</td>
				<td align="center">分期</td>
				<td align="center">渗透率</td>
			</tr>
			<c:if test="${empty(orderBuyTypes) }">
				<tr>
					<td colspan="5">无数据</td>
				</tr>
			</c:if>
			<c:if test="${!empty(orderBuyTypes) }">
				<c:forEach items="${orderBuyTypes}" var="orderBuyType">
					<tr>
						<td align="center">${orderBuyType.name }</td>
						<td align="center">${orderBuyType.orderNum }</td>
						<td align="center">${orderBuyType.cashNum }</td>
						<td align="center">${orderBuyType.finNum }</td>
						<td align="center">
							<fmt:formatNumber value="${orderBuyType.finPer }" pattern="0.00"></fmt:formatNumber>%
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
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
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		部门数据明细
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
			<c:set value="0" var="newsCount"></c:set>
			<c:forEach var="count" items="${depCounts }" varStatus="i">
				<tr>
					<td align="center" width="40">${i.index+1 }</td>
					<td align="center" width="80">${count.name }</td>
					<td align="center" width="60">${count.num }</td>
					<c:set value="${count.num+newsCount }" var="newsCount"></c:set>
				</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="3" style="text-align: right;">合计：${newsCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问留存订单车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 40px">销售顾问</td>
				<td style="width: 40px">订单</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td style="width: 40px;">${carSeriy.name }</td>
				</c:forEach>
			</tr>
		<c:forEach items="${userMaps }" var="map" varStatus="i">
			<c:set value="${map.key }" var="orderUser"></c:set>
			<c:set value="${map.value }" var="value"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${orderUser.name }
				</td>
				<td>
					${orderUser.num }
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
			<td>
				${newsCount }
			</td>
			<c:forEach var="carSerCount" items="${carUserOrderCounts }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
		</tr>
	</table>
	<br>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		留存订单时间车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 60px">月份</td>
				<td style="width: 40px">订单</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td style="width: 40px;">${carSeriy.name }</td>
				</c:forEach>
			</tr>
		<c:forEach items="${mapCountMonths }" var="map" varStatus="i">
			<c:set value="${map.key }" var="orderUser"></c:set>
			<c:set value="${map.value }" var="value"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${orderUser.name }
				</td>
				<td>
					${orderUser.num }
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
			<td>
				${newsCount }
			</td>
			<c:forEach var="carSerCount" items="${carUserOrderCounts }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
		</tr>
	</table>
	<br>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxOrderStatic//waitingCar" name="searchPageForm" id="searchPageForm" method="post">
      	<input type="hidden" id="type" name="type" value="${param.type }">
      	 <table>
	  			<tr>
		  				<td><label>分公司：</label></td>
		  				<td colspan="" >
		  					<select class="form-control" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
		  						<option value="-1">请选择...</option>
		  						<c:forEach var="enter" items="${enterprises }">
			  						<option value="${enter.dbid }" ${enter.dbid==enterprise.dbid?'selected="selected"':'' }>${enter.name }</option>
		  						</c:forEach>
							</select>
		  				</td>
	  			</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="if(validateSearch()){$('#searchPageForm')[0].submit()}">查询</button>
      </div>
    </div>
  </div>
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
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
});
</script>
</html>