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
<title>订单客户（月）统计</title>
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
    <span id="page_title">订单客户（月）统计</span>
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
           <li class="detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxOrder/queryOrderList'">月统计</li>
           <li class="detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrder/queryOrderYearList'">年统计</li>
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
			<c:if test="${fn:length(orders)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${totalOrder.selfOrderNum }
					</td>
					<td>
						${totalOrder.netOrderNum }
					</td>
					<td>
						${totalOrder.orderNum }
					</td>
				</tr>
			</c:if>
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
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${totalOrder.selfOrderNum }
					</td>
					<td>
						${totalOrder.netOrderNum }
					</td>
					<td>
						${totalOrder.orderNum }
					</td>
				</tr>
			</c:if>
		</table>
		<br>
		<div class="hightChat">
			<div id="selfOrderDayByDay" ></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="netOrderDayByDay" ></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="orderDayByDay" ></div>
			<div style="clear: both;"></div>
		</div>
		<br>
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
			<td style="width: 80px;">日期</td>
			<td style="width: 40px;">订单客户</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td style="width: 30px;">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		</thead>
		<c:if test="${lengthStatus==true }">
			<tr class="totalTr">
				<td colspan="2">
							合计
						</td>
						<td>
							${totalOrder.orderNum }
						</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
			<tr class="totalTr">
				<td colspan="2">占比</td>
				<td>
				</td>
				<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
					<td>
						<c:if test="${totalOrder.orderNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/totalOrder.orderNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${totalOrder.orderNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:if>
		<c:set value="0" var="sTotalNum"></c:set>
		<c:set value="0" var="sEffTotalNum"></c:set>
		<c:forEach items="${mapCarseriys }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>${i.index+1 }</td>
				<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
				<td>
					${key.orderNum }
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
			</tr>
		</c:forEach>
		<c:if test="${lengthStatus==false }">
			<tr class="totalTr">
				<td colspan="2">
							合计
						</td>
						<td>
							${totalOrder.orderNum }
						</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
			<tr class="totalTr">
				<td colspan="2">占比</td>
				<td>
				</td>
				<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
					<td>
						<c:if test="${totalOrder.orderNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/totalOrder.orderNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${totalOrder.orderNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:if>
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		订单客户同比环比数据
	</h5>
</div>
	<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>类型</td>
			<td>${staYearByYearChain.nowDate }</td>
			<td>${staYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${staYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
		<tr>
			<td>1</td>
			<td>订单客户</td>
			<td>${staYearByYearChain.nowNum }</td>
			<td>${staYearByYearChain.preNum}</td>
			<td>
				<c:if test="${staYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${staYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${staYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${staYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${staYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${staYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${staYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${staYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${staYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${staYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${staYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>自有店订单</td>
			<td>${staSelfYearByYearChain.nowNum }</td>
			<td>${staSelfYearByYearChain.preNum}</td>
			<td>
				<c:if test="${staSelfYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${staSelfYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${staSelfYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${staSelfYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${staSelfYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${staSelfYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${staSelfYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${staSelfYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${staSelfYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${staSelfYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${staSelfYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td>二网订单</td>
			<td>${staNetYearByYearChain.nowNum }</td>
			<td>${staNetYearByYearChain.preNum}</td>
			<td>
				<c:if test="${staNetYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${staNetYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${staNetYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${staNetYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${staNetYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${staNetYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${staNetYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${staNetYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${staNetYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${staNetYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${staNetYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
</table>

<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxOrder/queryOrderList" name="searchPageForm" id="searchPageForm" method="post">
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
  					<select class="form-control" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<c:forEach var="customerType" items="${customerTypes }">
	  						<option value="${customerType.dbid }" ${customerType.dbid==param.type?'selected="selected"':'' }>${customerType.name }</option>
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
  			<tr>
  				<td><label>~</label></td>
  				<td>
  					<input class="form-control" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${endDate }">
  				</td>
  			</tr>
  			<tr>
  				<td style="" colspan="2">
  					<a href="javascript:;" onclick="setSerachDate(1)">今天</a>|<a href="javascript:;" onclick="setSerachDate(2)">昨天</a>|<a href="javascript:;" onclick="setSerachDate(3)">最近7天</a>|<a href="javascript:;" onclick="setSerachDate(4)">本周</a>|<a href="javascript:;" onclick="setSerachDate(5)">本月</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="2">
   					<p id="searchTip" style="c">查询时间不能超过31天</p>
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
	$('#selfOrderDayByDay').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '自有店日订单趋势'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDayNumAll}]
		},
		yAxis: {
			title: {
				text: '批次'
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					// 开启数据标签
					enabled: true          
				},
				// 关闭鼠标跟踪，对应的提示框、点击事件会失效
				enableMouseTracking: true
			}
		},
		series:${selfOrderDayByDay}
	});
	$('#netOrderDayByDay').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '二网日订单趋势'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDayNumAll}]
		},
		yAxis: {
			title: {
				text: '批次'
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					// 开启数据标签
					enabled: true          
				},
				// 关闭鼠标跟踪，对应的提示框、点击事件会失效
				enableMouseTracking: true
			}
		},
		series:${netOrderDayByDay}
	});
	$('#orderDayByDay').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '总订单趋势'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDayNumAll}]
		},
		yAxis: {
			title: {
				text: '批次'
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					// 开启数据标签
					enabled: true          
				},
				// 关闭鼠标跟踪，对应的提示框、点击事件会失效
				enableMouseTracking: true
			}
		},
		series:${orderDayByDay}
	});
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
			name: '车型',
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
			name: '客户类型',
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
function validateSearch(){
	var startTime=$("#startTime").val();
	var endTime=$("#endTime").val();
	var endDate=convertDateFromString(endTime);
	var startDate=convertDateFromString(startTime);
	endDate.add("d",-31);
	var status=dateCompare(startDate,endDate,">");
	if(status){
		return true;
		$("#searchTip").css("color","balck");
	}else{
		$("#searchTip").css("color","red");
		return false;
	}
}
</script>
</html>