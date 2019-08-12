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
<title>基盘客户统计</title>
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
.fixD{
	position: fixed;
	top: 45px;
	width: 100%;
	background-color: #ed145b;
	color: white;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">基盘客户统计</span>
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

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		客户级别-车型统计明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 40px;">级别</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 40px">${carSeriy.name }</td>
					</c:forEach>
				</tr>
			</thead>
			<c:forEach items="${mapCustPhases }" var="mapCustPhase" varStatus="i">
				<c:set value="${mapCustPhase.key }" var="custPhase"></c:set>
				<tr >
					<td colspan="" >
						${i.index+1}
					</td>
					<td colspan="" >
						${custPhase.name }
					</td>
					<td colspan="" >
						${custPhase.totalNum }
					</td>
					<c:forEach var="carCount" items="${mapCustPhase.value }">
						<td>${carCount.countNum }</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2" >
						 合计
					</td>
					<td colspan="" >
						 ${userAll.totalNum }
					</td>
					<c:forEach var="carCount" items="${carSerCounts }">
						<td>${carCount.countNum }</td>
					</c:forEach>
				</tr>
		</table>
		<br>
		<div class="hightChat" >
			<div id="pieCustPhaseData" style="height: 240px;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="pieCustCarData" style="height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问-车型统计明细
	</h5>
</div>
<br>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 40px;">销售顾问</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 40px">${carSeriy.name }</td>
					</c:forEach>
				</tr>
			</thead>
			<c:forEach items="${mapUserCarSerCounts }" var="mapUserCarSerCount" varStatus="i">
				<c:set value="${mapUserCarSerCount.key }" var="custUser"></c:set>
				<tr >
					<td colspan="" >
						${i.index+1}
					</td>
					<td colspan="" >
						${custUser.bussiStaff }
					</td>
					<td colspan="" >
						${custUser.totalNum }
					</td>
					<c:forEach var="carCount" items="${mapUserCarSerCount.value }">
						<td>${carCount.countNum }</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2" >
						 合计
					</td>
					<td colspan="" >
						 ${userAll.totalNum }
					</td>
					<c:forEach var="carCount" items="${carSerCounts }">
						<td>${carCount.countNum }</td>
					</c:forEach>
				</tr>
		</table>
		<br>
		<div class="hightChat">
			<div id="pieCustUserData" style="height: 240px;"></div>
		</div>
		<br>
		<br>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问-客户级别-车型统计明细
	</h5>
</div>
<br>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<thead id="carSery" style="" class="">
				<tr>
					<td style="width: 40px;">级别</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 40px">${carSeriy.name }</td>
					</c:forEach>
				</tr>
			</thead>
			<c:forEach var="mapCarSerCounts" items="${mapCarSerCounts }">
				<c:set value="${mapCarSerCounts.key }" var="custUser"></c:set>
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="${fn:length(carSeriys)+2 }" style="text-align: left">
						${custUser.bussiStaff }
					</td>
				</tr>
				<c:forEach var="map" items="${mapCarSerCounts.value }">
					<c:set value="${map.key }" var="custPhase"></c:set>
					<tr >
						<td style="width: 40px;">${custPhase.name }</td>
						<td style="width: 40px;">${custPhase.totalNum }</td>
						<c:forEach var="carCount" items="${map.value }">
							<td style="width: 40px;">${carCount.countNum }</td>
						</c:forEach>
					</tr>
				</c:forEach>
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="" style="width: 40px;">
						合计：
					</td>
					<td colspan="" style="width: 40px;">
						${custUser.totalNum }
					</td>
					<c:forEach items="${mapUserCarSerCounts }" var="mapUserCarSerCount">
						<c:if test="${custUser.bussiStaffId==mapUserCarSerCount.key.bussiStaffId }">
							<c:forEach var="carCount" items="${mapUserCarSerCount.value }">
								<td style="width: 40px;">${carCount.countNum }</td>
							</c:forEach>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCust/queryList" name="searchPageForm" id="searchPageForm" method="post">
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
$(function () {
	$('#pieCustPhaseData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '基盘客户等级占比统计分析'
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
			name: '客户级别',
			colorByPoint: true,
			data: ${pieCustPhaseData}
		}]
	});
	$('#pieCustCarData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '基盘客户车型占比统计'
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
			name: '客户车型',
			colorByPoint: true,
			data: ${pieCustCarData}
		}]
	});
	$('#pieCustUserData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '基盘客销售顾问占比统计'
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
			data: ${pieCustUserData}
		}]
	});
})
 function htmlScroll() {
     var top = document.body.scrollTop || document.documentElement.scrollTop;
     if (elFix.data_top < top) {
    	 var cl=$(elFix).attr("class");
         if(cl.indexOf()<0){
             $(elFix).addClass("fixD")
         }
     }
     else {
    	 $(elFix).removeClass("fixD")
     }
 }

function htmlPosition(obj) {
    var o = obj;
    var t = o.offsetTop;//上方区域
    while (o = o.offsetParent) {
        t += o.offsetTop;
    }
    obj.data_top = t;
}

window.onscroll = htmlScroll;
var elFix = document.getElementById('carSery');
htmlPosition(elFix);
</script>
</html>