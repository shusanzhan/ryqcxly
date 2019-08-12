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
<title>试乘试驾（年）统计</title>
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
    <span id="page_title">试乘试驾（年）统计</span>
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
           <li class="detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/qywxStaTryCar/queryTryCarList'">月统计</li>
           <li class="detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxStaTryCar/queryTryCarYearList'">年统计</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		到店客户试乘试驾率/试乘试驾转订单率统计
	</h5>
</div>
<p style="color: red;"><span style="color: red;font-weight: bold;">到店合计</span>=首次+二次（客户）</p>
<p style="color: red;"><span style="color: red;font-weight: bold;">试乘试驾率</span>=试乘试驾/到店合计*100</p>
<p style="color: red;"><span style="color: red;font-weight: bold;">试乘试驾转订单率</span>=试乘试驾转订单客户/试乘试驾客户*100</p>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
					<td style="width: 30px;">序号</td>
					<td style="width: 80px">日期</td>
					<td style="width: 40px">首次</td>
					<td style="width: 40px">二次</td>
					<td style="width: 50px">到店合计</td>
					<td style="width: 50px">试乘试驾</td>
					<td style="width: 60px">试乘试驾率%</td>
					<td style="width: 60px">试乘试驾订单</td>
					<td style="width: 60px">试乘试驾订单率%</td>
				</tr>
			<c:if test="${fn:length(staTryCars)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${queryStaTryCarTotal.comeShopNum }
					</td>
					<td>
						${queryStaTryCarTotal.twoComeShopNum }
					</td>
					<td>
						${queryStaTryCarTotal.totalNum }
					</td>
					<td>
						${queryStaTryCarTotal.tryCarNum }
					</td>
					<td>
					<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
					<td>
						${queryStaTryCarTotal.tryCarOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
				</tr>
			</c:if>
			<c:forEach items="${staTryCars }" var="staTryCar" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${staTryCar.createDate}" pattern="yyyy-MM"/> 
					</td>
					<td>
						${staTryCar.comeShopNum }
					</td>
					<td>
						${staTryCar.twoComeShopNum }
					</td>
					<td>
						${staTryCar.totalNum }
					</td>
					<td>
						${staTryCar.tryCarNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${staTryCar.tryCarOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${queryStaTryCarTotal.comeShopNum }
					</td>
					<td>
						${queryStaTryCarTotal.twoComeShopNum }
					</td>
					<td>
						${queryStaTryCarTotal.totalNum }
					</td>
					<td>
						${queryStaTryCarTotal.tryCarNum }
					</td>
					<td>
					<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
					<td>
						${queryStaTryCarTotal.tryCarOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
				</tr>
			</c:if>
	</table>
	<div class="hightChat">
		<div id="container" style=""></div>
	</div>
	<div class="hightChat">
		<div id="pieComeShop" style=""></div>
	</div>
	<div class="hightChat">
		<div id="pieTryCar" style=""></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		客户试驾车型明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
			<td width="30">序号</td>
			<td width="80">日期</td>
			<td width="50">来店客户</td>
			<td width="50">试乘试驾</td>
			<td width="50">试乘试驾率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td width="40">${carSeriy.name }</td>
			</c:forEach>
		</tr>
			<c:if test="${lengthStatus==true }">
				<tr id="totalTr">
					<td colspan="2">
								合计
							</td>
							<td>
								${queryStaTryCarTotal.totalNum }
							</td>
							<td>
								${queryStaTryCarTotal.tryCarNum }
							</td>
							<td>
							<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
							</td>
					<c:set value="0" var="countNum"></c:set>
					<c:forEach var="carSerCountTotal" items="${carSerCounts }">
						<td>${carSerCountTotal.countNum }</td>
						<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
					</c:forEach>
				</tr>
				<tr id="totalTr">
					<td colspan="5">占比</td>
					<c:forEach var="carSerCountTotal" items="${carSerCounts }">
						<td>
							<c:if test="${queryStaTryCarTotal.tryCarNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/queryStaTryCarTotal.tryCarNum*100}" pattern="#0.00"></fmt:formatNumber>
							</c:if>
							<c:if test="${queryStaTryCarTotal.tryCarNum<=0 }">
								0.0
							</c:if>
						</td>
					</c:forEach>
				</tr>
			</c:if>
			<c:set value="0" var="sTotalNum"></c:set>
			<c:set value="0" var="sEffTotalNum"></c:set>
			<c:forEach items="${maps }" var="map" varStatus="i">
				<c:set var="key" value="${map.key }"></c:set>
				<c:set var="value" value="${map.value }"></c:set>
				<tr>
					<td>${i.index+1 }</td>
					<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM"/> </td>
					<td>
						${key.totalNum }
					</td>
					<td>
						${key.tryCarNum } 
					</td>
					<td>
						<fmt:formatNumber value="${key.tryCarPer }" pattern="#0.00"></fmt:formatNumber>
					</td>
					<c:forEach var="carSerCount" items="${value }">
						<td>${carSerCount.countNum }  </td>
					</c:forEach>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr id="totalTr">
					<td colspan="2">
								合计
							</td>
							<td>
								${queryStaTryCarTotal.totalNum }
							</td>
							<td>
								${queryStaTryCarTotal.tryCarNum }
							</td>
							<td>
							<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
							</td>
					<c:set value="0" var="countNum"></c:set>
					<c:forEach var="carSerCountTotal" items="${carSerCounts }">
						<td>${carSerCountTotal.countNum }</td>
						<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
					</c:forEach>
				</tr>
				<tr id="totalTr">
					<td colspan="5">占比</td>
					<c:forEach var="carSerCountTotal" items="${carSerCounts }">
						<td>
							<c:if test="${queryStaTryCarTotal.tryCarNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/queryStaTryCarTotal.tryCarNum*100}" pattern="#0.00"></fmt:formatNumber>
							</c:if>
							<c:if test="${queryStaTryCarTotal.tryCarNum<=0 }">
								0.0
							</c:if>
						</td>
					</c:forEach>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="pieCustomerTryCar" ></div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		试驾试驾客户订单车型明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
			<td width="30">序号</td>
			<td width="80">日期</td>
			<td width="40">试乘试驾</td>
			<td width="40">试乘试驾订单</td>
			<td width="40">试乘试驾订单率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td width="40">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		<c:if test="${lengthStatus==true }">
			<tr id="totalTr">
				<td colspan="2">合计</td>
				<td>
					${queryStaTryCarTotal.tryCarNum }
				</td>
				<td>
					${queryStaTryCarTotal.tryCarOrderNum }
				</td>
				<td>
				<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber>
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${listTryCarOrders }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
			<tr id="totalTr">
				<td colspan="5">占比</td>
				<c:forEach var="carSerCountTotal" items="${listTryCarOrders }">
					<td>
						<c:if test="${queryStaTryCarTotal.tryCarNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/queryStaTryCarTotal.tryCarNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${queryStaTryCarTotal.tryCarNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:if>
		<c:set value="0" var="sTotalNum"></c:set>
		<c:set value="0" var="sEffTotalNum"></c:set>
		<c:forEach items="${mapTryCarOrders }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>${i.index+1 }</td>
				<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM"/> </td>
				<td>
					${key.tryCarNum }
				</td>
				<td>
					${key.tryCarOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${key.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
			</tr>
		</c:forEach>
		<c:if test="${lengthStatus==false }">
			<tr id="totalTr">
				<td colspan="2">合计</td>
				<td>
					${queryStaTryCarTotal.tryCarNum }
				</td>
				<td>
					${queryStaTryCarTotal.tryCarOrderNum }
				</td>
				<td>
				<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber>
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${listTryCarOrders }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
			<tr id="totalTr">
				<td colspan="5">占比</td>
				<c:forEach var="carSerCountTotal" items="${listTryCarOrders }">
					<td>
						<c:if test="${queryStaTryCarTotal.tryCarNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/queryStaTryCarTotal.tryCarNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${queryStaTryCarTotal.tryCarNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:if>
		</tbody>
	</table>
	<br>
	<div class="hightChat">
		<div id="pieCustomerTryCarOrder" ></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		车型试乘试驾率/试乘试驾转订单率统计
	</h5>
</div>
<div class="row-fluid">                
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 50px">车型</td>
				<td style="width: 50px">到店客户</td>
				<td style="width: 50px">试乘试驾</td>
				<td style="width: 60px">试乘试驾率</td>
				<td style="width: 60px">试乘试驾订单</td>
				<td style="width: 60px">试乘试驾订单率</td>
			</tr>
			<c:forEach items="${staCarSeriyTryCars }" var="staTryCar" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						${staTryCar.name }
					</td>
					<td>
						${staTryCar.comeShopNum }
					</td>
					<td>
						${staTryCar.tryCarNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${staTryCar.tryCarOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<tr style="font-weight: bold;">
				<td colspan="2">
					合计
				</td>
				<td>
					${queryStaTryCarTotal.comeShopNum }
				</td>
				<td>
					${queryStaTryCarTotal.tryCarNum }
				</td>
				<td>
				<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
				<td>
					${queryStaTryCarTotal.tryCarOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问试乘试率/试乘试驾转订单率统计
	</h5>
</div>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 40px">销售顾问</td>
				<td style="width: 40px">到店客户</td>
				<td style="width: 40px">试乘试驾</td>
				<td style="width: 40px">试乘试驾率%</td>
				<td style="width: 40px">试乘试驾订单</td>
				<td style="width: 50px">试乘试驾订单率%</td>
			</tr>
			<c:forEach items="${staUserTryCars }" var="staTryCar" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						${staTryCar.userName }
					</td>
					<td>
						${staTryCar.comeShopNum }
					</td>
					<td>
						${staTryCar.tryCarNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${staTryCar.tryCarOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${staTryCar.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<tr style="font-weight: bold;">
				<td colspan="2">
					合计
				</td>
				<td>
					${queryStaTryCarTotal.comeShopNum }
				</td>
				<td>
					${queryStaTryCarTotal.tryCarNum }
				</td>
				<td>
				<fmt:formatNumber value="${queryStaTryCarTotal.tryCarPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
				<td>
					${queryStaTryCarTotal.tryCarOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${queryStaTryCarTotal.tryCarOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
			</tr>
	</tbody>
</table>
	<br>
	<div class="hightChat">
		<div id="pieUserTryCarData" ></div>
	</div>
		<br>
	<div class="hightChat">
		<div id="pieUserTryCarOderData" ></div>
	</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		试乘试驾客户/试乘试驾转订单客户同比环比数据
	</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>类型</td>
			<td>${comeShopStaYearByYearChain.nowDate }</td>
			<td>${comeShopStaYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${comeShopStaYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
		<tr>
			<td>1</td>
			<td>首次到店客户</td>
			<td>${comeShopStaYearByYearChain.nowNum }</td>
			<td>${comeShopStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${comeShopStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${comeShopStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${comeShopStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${comeShopStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${comeShopStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${comeShopStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${comeShopStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${comeShopStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${comeShopStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${comeShopStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${comeShopStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>二次到店客户</td>
			<td>${twoComeShopStaYearByYearChain.nowNum }</td>
			<td>${twoComeShopStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${twoComeShopStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${twoComeShopStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${twoComeShopStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${twoComeShopStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${twoComeShopStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${twoComeShopStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${twoComeShopStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${twoComeShopStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${twoComeShopStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${twoComeShopStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${twoComeShopStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td>试乘试驾客户</td>
			<td>${tryCarStaYearByYearChain.nowNum }</td>
			<td>${tryCarStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${tryCarStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${tryCarStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${tryCarStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${tryCarStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${tryCarStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${tryCarStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${tryCarStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${tryCarStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${tryCarStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${tryCarStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${tryCarStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>4</td>
			<td>试乘试驾转订单客户</td>
			<td>${tryCarOrderStaYearByYearChain.nowNum }</td>
			<td>${tryCarOrderStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${tryCarOrderStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${tryCarOrderStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${tryCarOrderStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${tryCarOrderStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${tryCarOrderStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${tryCarOrderStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${tryCarOrderStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${tryCarOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${tryCarOrderStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${tryCarOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${tryCarOrderStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
</table>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		试乘试驾率/试乘试驾转订单率同比环比
	</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销车型</td>
			<td>${comeShopStaYearByYearChain.nowDate }</td>
			<td>${comeShopStaYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${comeShopStaYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
		<tr>
			<td>1</td>
			<td>${staTryCarYearByYearChainPer.itemName }</td>
			<td>
				<fmt:formatNumber value="${staTryCarYearByYearChainPer.nowTryCarPer }" pattern="#0.0"></fmt:formatNumber>%</td>
			<td><fmt:formatNumber value="${staTryCarYearByYearChainPer.preTryCarPer }" pattern="#0.0"></fmt:formatNumber>%</td>
			<td>
				<c:set value="${staTryCarYearByYearChainPer.nowTryCarPer-staTryCarYearByYearChainPer.preTryCarPer }" var="pre"></c:set>
				<c:if test="${pre>0 }">
					<span style="color: red"><fmt:formatNumber value="${pre}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${pre<0 }">
					<span style="color: green"><fmt:formatNumber value="${pre }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${pre==0 }">
					0.0
				</c:if>
			</td>
			<td>${staTryCarYearByYearChainPer.yearByYearTryCarPer }%</td>
			<td>
				<c:set value="${staTryCarYearByYearChainPer.nowTryCarPer-staTryCarYearByYearChainPer.yearByYearTryCarPer }" var="year"></c:set>
				<c:if test="${year>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${year }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${year<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${year }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${year==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>${tryCarOrderStaTryCarYearByYearChainPer.itemName }</td>
			<td>
				<fmt:formatNumber value="${tryCarOrderStaTryCarYearByYearChainPer.nowTryCarPer }" pattern="#0.0"></fmt:formatNumber>%</td>
			<td><fmt:formatNumber value="${tryCarOrderStaTryCarYearByYearChainPer.preTryCarPer }" pattern="#0.0"></fmt:formatNumber>%</td>
			<td>
				<c:set value="${tryCarOrderStaTryCarYearByYearChainPer.nowTryCarPer-tryCarOrderStaTryCarYearByYearChainPer.preTryCarPer }" var="pre"></c:set>
				<c:if test="${pre>0 }">
					<span style="color: red"><fmt:formatNumber value="${pre}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${pre<0 }">
					<span style="color: green"><fmt:formatNumber value="${pre }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${pre==0 }">
					0.0
				</c:if>
			</td>
			<td>
				<fmt:formatNumber value="${tryCarOrderStaTryCarYearByYearChainPer.yearByYearTryCarPer }" pattern="#0.0"></fmt:formatNumber>%
			</td>
			<td>
				<c:set value="${tryCarOrderStaTryCarYearByYearChainPer.nowTryCarPer-tryCarOrderStaTryCarYearByYearChainPer.yearByYearTryCarPer }" var="year"></c:set>
				<c:if test="${year>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${year }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${year<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${year }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${year==0 }">
						0.0
				</c:if>
			</td>
		</tr>
</table>
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx}/qywxStaTryCar/queryTryCarYearList" name="searchPageForm" id="searchPageForm" method="post">
      	 <table>
  			<c:if test="${fn:length(enterprises)>1 }">
	  			<tr>
		  				<td><label>分公司：</label></td>
		  				<td colspan="4" >
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
  				<td><label>客户类型：</label></td>
  				<td colspan="" >
  					<select class="form-control" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<c:forEach var="customerType" items="${customerTypes }">
	  						<option value="${customerType.dbid }" ${customerType.dbid==param.type?'selected="selected"':'' }>${customerType.name }</option>
  						</c:forEach>
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
  				<td colspan="2">
  					<a href="javascript:;" onclick="setSerachDate(1)">最近3个月</a>|<a href="javascript:;" onclick="setSerachDate(2)">今年</a>|<a href="javascript:;" onclick="setSerachDate(3)">去年</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="2">
   					<p id="searchTip" style="c">查询时间不能超过12个月</p>
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
<br>
<br>
</body>
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
	$('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日到店客户趋势图'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDayAll}]
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
		series:${dayByDayNumAll}
	});
	$('#pieComeShop').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '首次到店/二次到店客户占比'
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
			data: ${pieComeShop}
		}]
	});
	$('#pieTryCar').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '试乘试驾客户占比'
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
			data: ${pieTryCar}
		}]
	});
	$('#pieCustomerTryCar').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '试乘试驾车型占比'
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
			name: '客户',
			colorByPoint: true,
			data: ${pieCustomerTryCar}
		}]
	});
	$('#pieCustomerTryCarOrder').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '试乘试驾客户转订单车型占比'
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
			name: '订单客户',
			colorByPoint: true,
			data: ${pieCustomerTryCarOrder}
		}]
	});
	$('#pieUserTryCarData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '试乘试驾客户销售顾问占比'
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
			name: '试驾客户',
			colorByPoint: true,
			data: ${pieUserTryCarData}
		}]
	});
	$('#pieUserTryCarOderData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '试乘试驾客户转订单销售顾问占比'
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
			name: '订单客户',
			colorByPoint: true,
			data: ${pieUserTryCarOderData}
		}]
	});
	
});
function setSerachDate(type){
	var today=new Date();
	if(type==1){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year,month-2,1)
		var tempDate2=temp.format("yyyy-MM");
		$("#startTime").val(tempDate2);
		today=today.format("yyyy-MM");
		$("#endTime").val(today);
	}
	if(type==2){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year,0,1)
	    temp=temp.format("yyyy-MM");
		$("#startTime").val(temp);
		today=today.format("yyyy-MM");
		$("#endTime").val(today);
	}
	if(type==3){
		var year=today.getFullYear();
	    var month=today.getMonth();
	    var temp=new Date(year-1,0,1)
	    temp=temp.format("yyyy-MM");
		$("#startTime").val(temp);
		var tempEnd=new Date(year-1,11,1)
		tempEnd=tempEnd.format("yyyy-MM");
		$("#endTime").val(tempEnd);
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
	var startYear=startDate.getFullYear();
    var startMonth=startDate.getMonth();
	var endYear=endDate.getFullYear();
    var endMonth=endDate.getMonth();
    var totalMonh=0;
    if(endYear>startYear){
    	var month=(endYear-startYear)*11
    	totalMonh=month+(11-startMonth+endMonth);
    }
    else if(endYear==startYear){
    	totalMonh=endMonth-startMonth;
    }
    if(totalMonh>12){
		$("#searchTip").css("color","red");
		return false;
	}else{
		$("#searchTip").css("color","balck");
		return true;
	}
}
function ajaxCarCount(){
	var params=$("#searchPageForm").serialize();
	var customerInfromSetDbid=$("#customerInfromSetDbid").val();
	$.post("${ctx}/qywxStatCustomerInvitation/ajaxCarCount?customerInfromSetDbid="+customerInfromSetDbid+"&dateType=2",params,function(data){
		if(data=="error"){
			alert("查询出错！");
		}else{
			var obj=data.split("|");
			$("#carCountId").text("");
			$("#carCountId").append(obj[0]);
			chart3(obj[1]);
		}
	}) 
}
</script>
</html>