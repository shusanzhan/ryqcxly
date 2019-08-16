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
<title>日订单</title>
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
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">日订单</span>
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
	           <li class="detail_tap detail_tap3 pull_left" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrderStatic/queryOrderList?type=3&role=${param.role }'">当月订单</li>
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
 <div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		日订单明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">日期</td>
					<td style="width: 80px">自有店</td>
					<td style="width: 80px">二网</td>
					<td style="width: 80px">合计</td>
				</tr>
			<c:forEach items="${orders }" var="order" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd"/> 
					</td>
					<td>
						${order.selfOrderNum }
					</td>
					<td>
						${order.netOrderNum }
					</td>
					<td>
						<c:if test="${order.orderNum>=10 }">
							<span style="color: red;">${order.orderNum }</span>
						</c:if>
						<c:if test="${order.orderNum<10 }">
							${order.orderNum }
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		购车方式统计
	</h5>
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		客户类型订单统计
	</h5>
</div>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
			<td>序号</td>
			<td>线索类型</td>
			<td>订单量</td>
		</tr>
		<c:forEach items="${orderTypes }" var="orderType" varStatus="i">
			<tr>
				<td>${i.index+1 }</td>
				<td>${orderType.name }</td>
				<td>${orderType.orderNum }</td>
			</tr>
		</c:forEach>
		<tr>
			<td>${i.index+1 }</td>
			<td>二网</td>
			<td>
				${totalOrder.netOrderNum }
			</td>
		</tr>
		<tr class="totalTr">
			<td colspan="2">合计</td>
			<td>${orderTypeAll.orderNum+totalOrder.netOrderNum }</td>
		</tr>
</table>
<div class="hightChat">
	<div id="pieOrderType" style="width: 98%;"></div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		订单客户车型明细
	</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 30px;">序号</td>
			<td style="width: 80px;">车型</td>
			<td style="width: 40px;">订单客户</td>
		</tr>
		</thead>
		<c:forEach var="carSerCount" items="${orderCarSeriyAll }">
			<tr>
				<td>${i.index+1 }</td>
				<td>
					${carSerCount.name }
				</td>
				<td>${carSerCount.countNum }  </td>
			</tr>
		</c:forEach>
</table>
<div class="hightChat">
	<div id="pieOrderCarSerData" style="width: 98%;"></div>
</div>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问订单车型统计
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
		<c:forEach items="${mapUserOrderCars }" var="map" varStatus="i">
			<c:set value="${map.key }" var="orderUser"></c:set>
			<c:set value="${map.value }" var="value"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${orderUser.bussiStaff }
				</td>
				<td>
					${orderUser.orderNum }
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
				${orderUserAll.orderNum }
			</td>
			<c:forEach var="carSerCount" items="${carUserOrderCounts }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
		</tr>
	</table>
	<div class="hightChat">
		<div id="pieUserData" style="width: 98%;"></div>
	</div>
<br>
</div>

<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		部门订单统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 40px">部门</td>
				<td style="width: 40px">订单</td>
			</tr>
		<c:forEach items="${depCounts }" var="depCount" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${depCount.name }
				</td>
				<td>
					${depCount.num }
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
			<td>
				${orderUserAll.orderNum }
			</td>
		</tr>
	</table>
<br>
</div>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxOrderStatic/order" name="searchPageForm" id="searchPageForm" method="post">
      	<input type="hidden" id="type" name="type" value="${param.type }">
      	 <table>
  			<c:if test="${fn:length(enterprises)>1 }">
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
  			</c:if>
  			<tr>
  				<td><label>客户类型1：</label></td>
  				<td  >
  					<select class="form-control" id="custtype" name="custtype"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<c:forEach var="customerType" items="${customerTypes }">
	  						<option value="${customerType.dbid }" ${customerType.dbid==param.custtype?'selected="selected"':'' }>${customerType.name }</option>
  						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>客户类型2：</label></td>
  				<td >
  					<select class="form-control" id="customerType" name="customerType"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.customerType==1?'selected="selected"':'' } >自有店</option>
  						<option value="2" ${param.customerType==2?'selected="selected"':'' } >二网</option>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>试乘试驾：</label></td>
	  				<td>
	  					<select class="form-control" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="">请选择...</option>
							<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
							<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
						</select>
	  				</td>
	  		</tr>
	  		<tr>
	  				<td><label>到店状态：</label></td>
	  				<td>
	  					<select class="form-control" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="-1">请选择...</option>
							<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
							<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
							<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
						</select>
					</td>
  			</tr>
  			<tr>
				<td><label>登记时间：</label></td>
  				<td>
  					<input class="form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${beginDate }" >
  				</td>
  			</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#searchPageForm')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
var chartB;
$(function () {
	$('#pieOrderType').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '客户类型订单占比'
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
			name: '客户类型',
			colorByPoint: true,
			data: ${pieOrderType}
		}]
	});
	$('#pieOrderCarSerData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '订单车型占比'
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
			name: '车型',
			colorByPoint: true,
			data: ${pieOrderCarSerData}
		}]
	});
	$('#pieUserData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '订单销售顾问占比'
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
			name: '销售顾问',
			colorByPoint: true,
			data: ${pieUserData}
		}]
	});
});
function setSerachDate(type){
	var date=new Date();
	if(type==1){
		date=date.format("yyyy-MM-dd");
		$("#startTime").val(date);
		$("#endTime").val(date);
	}
	if(type==2){
		date.add('d',-1);
		date=date.format("yyyy-MM-dd");
		$("#startTime").val(date);
		$("#endTime").val(date);
	}
	if(type==3){
		date.add('d',-6);
		var startTime=date.format("yyyy-MM-dd");
		var endTime=new Date();
		endTime=endTime.format("yyyy-MM-dd");
		$("#startTime").val(startTime);
		$("#endTime").val(endTime);
	}
	if(type==4){
		var weekDay=date.getDay();
		if(weekDay==0){
			weekDay=6
		}else{
			weekDay=weekDay-1;
		}
		date.add('d',-weekDay);
		var startTime=date.format("yyyy-MM-dd");
		$("#startTime").val(startTime);
		var endTime=new Date();
		endTime=endTime.format("yyyy-MM-dd");
		$("#endTime").val(endTime);
	}
	if(type==5){
		var today=new Date();
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year,month,1)
		var startTime=temp.format("yyyy-MM-dd");
		$("#startTime").val(startTime);
	
		var endTime=date.format("yyyy-MM-dd");
		$("#endTime").val(endTime);
	}
}
function convertDateFromString(dateString) {
	if (dateString) { 
		var date = new Date(dateString.replace(/-/,"/")) 
		return date;
	}
}
</script>
</html>