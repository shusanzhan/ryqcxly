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
<title>展厅流量（月）统计</title>
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
    <span id="page_title">展厅流量（月）统计</span>
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
           <li class="detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxStatCustomerRecord/queryReceptionStat'">月统计</li>
           <li class="detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxStatCustomerRecord/queryReceptionStatYear'">年统计</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}时间段统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="80">时段</td>
				<td align="center" width="40">数量</td>
			</tr>
			<tr>
				<td>8:00-9:00</td>
				<td>${totalStatCustomerRecordTime.eightNum}</td>	
			</tr>
			<tr>
				<td>9:00-10:00</td>
				<td>${totalStatCustomerRecordTime.nineNum}</td>	
			</tr>
			<tr>
				<td>10:00-11:00</td>
				<td>${totalStatCustomerRecordTime.tenNum}</td>	
			</tr>
			<tr>
				<td>11:00-12:00</td>
				<td>${totalStatCustomerRecordTime.elevenNum}</td>	
			</tr>
			<tr>
				<td>12:00-13:00</td>
				<td>${totalStatCustomerRecordTime.twelveNum}</td>	
			</tr>
			<tr>
				<td>13:00-14:00</td>
				<td>${totalStatCustomerRecordTime.thirteenNum}</td>	
			</tr>
			<tr>
				<td>14:00-15:00</td>
				<td>${totalStatCustomerRecordTime.fourteenNum}</td>	
			</tr>
			<tr>
				<td>15:00-16:00</td>
				<td>${totalStatCustomerRecordTime.fifteenNum}</td>	
			</tr>
			<tr>
				<td>16:00-17:00</td>
				<td>${totalStatCustomerRecordTime.sixteenNum}</td>	
			</tr>
			<tr>
				<td>17:00-18:00</td>
				<td>${totalStatCustomerRecordTime.seventeenNum}</td>	
			</tr>
			<tr>
				<td>18:00<&nbsp; </td>
					<td>${totalStatCustomerRecordTime.eighteenNUm}</td>	
			</tr>
			<tr>
				<td></td>
				<td>${totalStatCustomerRecordTime.totalNum}</td>
			</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container1" style=""></div>
	</div>
</div>
<c:if test="${type==1 }">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}每日明细
	</h5>
</div>
 <p style="color: red;">到店总量：所有来店数据</p>
<p style="color: red;">展厅来店：展厅来店看车客户</p>
<p style="color: red;">网销来店：网销来店看车客户</p>
<p style="color: red;">二次来店：包含网销、展厅二次来店数据</p>
<p style="color: red;">看车总（量）：展厅来店+网销来店；含销售顾问自己录入线索</p>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px">序号</td>
				<td style="width: 80px">日期</td>
				<td style="width: 60px;">到店总量</td>
				<td style="width: 60px;">看车总</td>
				<td style="width: 60px;"> 展厅来店 </td>
				<td style="width: 60px;"> 网销来店 </td>
				<td style="width: 60px;"> 二次来店</td>
			</tr>
			<c:forEach items="${statCustomerRecordTimes }" var="statCustomerRecordTime" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${statCustomerRecordTime.createDate}" pattern="yyyy-MM-dd"/> 
					</td>
					<td>${statCustomerRecordTime.totalNum}</td>	
					<td>${statCustomerRecordTime.roomNum+statCustomerRecordTime.netNum}</td>	
					<td>${statCustomerRecordTime.roomNum}</td>	
					<td>${statCustomerRecordTime.netNum}</td>	
					<td>${statCustomerRecordTime.twoNum}</td>
				</tr>
			</c:forEach>
				<tr id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>${totalStatCustomerRecordTime.totalNum}</td>
					<td>${totalStatCustomerRecordTime.roomNum+totalStatCustomerRecordTime.netNum}</td>	
					<td>${totalStatCustomerRecordTime.roomNum}</td>	
					<td>${totalStatCustomerRecordTime.netNum}</td>	
					<td>${totalStatCustomerRecordTime.twoNum}</td>
				</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container" style=""></div>
	</div>
</div>
</c:if>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}目的统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px">序号</td>
				<td style="width: 80px">目的</td>
				<td style="width: 60px;">数量</td>
			</tr>
			<c:forEach var="customerRecordTargetSta" items="${customerRecordTargetAlls }" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>${customerRecordTargetSta.name }</td>
					<td>${customerRecordTargetSta.totalNum }</td>
				</tr>
			</c:forEach>
				<tr id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>${totalStatCustomerRecordTime.totalNum}</td>	
				</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container2" style=""></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}销售顾问接待客户
	</h5>
</div>
<p style="color: red;">总登记：前台（登记）+销售（登记）;</p>
<p style="color: red;">首次进店：总（登记）-转（到店）登记;</p>
<p style="color: red;">建档率：	建档（客户）/首次（进店）*100</p>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<td rowspan="2" width="20">序号</td>
			<td rowspan="2" width="25">业务员</td>
			<td colspan="3">登记线索</td>
			<td colspan="3">接待结果</td>
			<td colspan="3">建档率</td>
		</tr>
		<tr>
			<td width="20">前台</td>
			<td width="20">销售</td>
			<td width="15">总</td>
			<td width="25">未处理</td>
			<td width="25">转登记</td>
			<td width="20">无效</td>
			<td width="20">首次</td>
			<td width="20">建档</td>
			<td width="25">建档率% </td>
		</tr>
		<c:forEach items="${mapUsers }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<c:if test="${!empty(key.realName)}">
				<tr>
					<td>${i.index+1 }</td>
					<td>
						${key.realName }
					</td>
					<td>
						${key.receptionNum }
					</td>
					<td>
						${key.salerSelfNum }
					</td>
					<td style="color: red;">
						${key.totalNum }
					</td>
					<td>
						${key.notDealNum }
					</td>
					<td>
						${key.otherNum }
					</td>
					<td>
						${key.unableNum }
					</td>
					<td>
						${key.fristComeNum }
					</td>
					<td>
						${key.creatorFolderNum }
					</td>
					<td style="color: red;">
						<c:if test="${empty(key.creatorFolderPer) }">
							0.0
						</c:if>
						<c:if test="${!empty(key.creatorFolderPer) }">
							<fmt:formatNumber value="${key.creatorFolderPer }" pattern="#0.00"></fmt:formatNumber>
						</c:if>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		<tr id="totalTr">
				<td colspan="2">合计</td>
				<td>
					${customerRecordUserTotal.receptionNum }
				</td>
				<td>
					${customerRecordUserTotal.salerSelfNum }
				</td>
				<td style="color: red;">
					${customerRecordUserTotal.totalNum }
				</td>
				<td>
					${customerRecordUserTotal.notDealNum }
				</td>
				<td>
					${customerRecordUserTotal.otherNum }
				</td>
				<td>
					${customerRecordUserTotal.unableNum }
				</td>
				<td>
					${customerRecordUserTotal.fristComeNum }
				</td>
				<td>
					${customerRecordUserTotal.creatorFolderNum }
				</td>
				<td style="color: red;">
					<c:if test="${empty(customerRecordUserTotal.creatorFolderPer) }">
						0.0
					</c:if>
					<c:if test="${!empty(customerRecordUserTotal.creatorFolderPer) }">
						<fmt:formatNumber value="${customerRecordUserTotal.creatorFolderPer }" pattern="#0.00"></fmt:formatNumber>% 
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}销售顾问建档客户车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<td rowspan="1" width="20">序号</td>
			<td rowspan="1" width="25">业务员</td>
			<td width="20">建档</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td width="20">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		<c:forEach items="${mapUsers }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<c:if test="${!empty(key.realName)}">
				<tr>
					<td>${i.index+1 }</td>
					<td>
						${key.realName }
					</td>
					<td>
						${key.creatorFolderNum }
					</td>
					<c:forEach var="carSerCount" items="${value }">
						<td>${carSerCount.countNum }  </td>
					</c:forEach>
				</tr>
			</c:if>
		</c:forEach>
		<tr id="totalTr">
				<td colspan="2">合计</td>
				<td>
					${customerRecordUserTotal.creatorFolderNum }
				</td>
				<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${type==1?"来店":"来电"}建档车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px">序号</td>
				<td style="width: 80px">车型</td>
				<td style="width: 60px;">数量</td>
			</tr>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${carSerCountTotals }" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>${carSerCountTotal.name }</td>
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</tr>
			</c:forEach>
				<tr id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>${countNum}</td>	
				</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container3" style=""></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		线索同比/环比统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<thead>
			<tr>
				<td>序号</td>
				<td>项目</td>
				<td>${dateMonth }</td>
				<td>${preMonthStr }</td>
				<td>环比</td>
				<td>${preYearStr }</td>
				<td>同比</td>
			</tr>
		</thead>
		<tr>
			<td>1</td>
			<td>进店量</td>
			<td>${staCustomerRecordMonth.comeNum }</td>
			<td>${preMonth.comeNum }</td>
			<td>
				<c:if test="${preMonth.comeNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.comeNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeNum-preMonth.comeNum)/preMonth.comeNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.comeNum }</td>
			<td>
				<c:if test="${preYear.comeNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.comeNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeNum-preYear.comeNum)/preYear.comeNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>展厅来店量</td>
			<td>${staCustomerRecordMonth.comeShopNum }</td>
			<td>${preMonth.comeShopNum }</td>
			<td>
				<c:if test="${preMonth.comeShopNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.comeShopNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeShopNum-preMonth.comeShopNum)/preMonth.comeShopNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.comeShopNum }</td>
			<td>
				<c:if test="${preYear.comeShopNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.comeShopNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeShopNum-preYear.comeShopNum)/preYear.comeShopNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td>首次进店量</td>
			<td>${staCustomerRecordMonth.firstComeNum }</td>
			<td>${preMonth.firstComeNum }</td>
			<td>
				<c:if test="${preMonth.firstComeNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.firstComeNum!=0}">
					<c:set value="${(staCustomerRecordMonth.firstComeNum-preMonth.firstComeNum)/preMonth.firstComeNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.firstComeNum }</td>
			<td>
				<c:if test="${preYear.firstComeNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.firstComeNum!=0}">
					<c:set value="${(staCustomerRecordMonth.firstComeNum-preYear.firstComeNum)/preYear.firstComeNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>4</td>
			<td>网销来店量</td>
			<td>${staCustomerRecordMonth.netNum }</td>
			<td>${preMonth.netNum }</td>
			<td>
				<c:if test="${preMonth.netNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.netNum!=0}">
					<c:set value="${(staCustomerRecordMonth.netNum-preMonth.netNum)/preMonth.netNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.netNum }</td>
			<td>
				<c:if test="${preYear.comeShopNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.comeShopNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeShopNum-preYear.comeShopNum)/preYear.comeShopNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>5</td>
			<td>展厅来店留资量</td>
			<td>${staCustomerRecordMonth.comeShopCreateFolderNum }</td>
			<td>${preMonth.comeShopCreateFolderNum }</td>
			<td>
				<c:if test="${preMonth.comeShopCreateFolderNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.comeShopCreateFolderNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeShopCreateFolderNum-preMonth.comeShopCreateFolderNum)/preMonth.comeShopCreateFolderNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.comeShopCreateFolderNum }</td>
			<td>
				<c:if test="${preYear.comeShopCreateFolderNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.comeShopCreateFolderNum!=0}">
					<c:set value="${(staCustomerRecordMonth.comeShopCreateFolderNum-preYear.comeShopCreateFolderNum)/preYear.comeShopCreateFolderNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>6</td>
			<td>来电量</td>
			<td>${staCustomerRecordMonth.phoneNum }</td>
			<td>${preMonth.phoneNum }</td>
			<td>
				<c:if test="${preMonth.phoneNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.phoneNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneNum-preMonth.phoneNum)/preMonth.phoneNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.phoneNum }</td>
			<td>
				<c:if test="${preYear.phoneNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.phoneNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneNum-preYear.phoneNum)/preYear.phoneNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>7</td>
			<td>来电咨询购车量</td>
			<td>${staCustomerRecordMonth.phoneShopNum }</td>
			<td>${preMonth.phoneShopNum }</td>
			<td>
				<c:if test="${preMonth.phoneShopNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.phoneShopNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneShopNum-preMonth.phoneShopNum)/preMonth.phoneShopNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.phoneShopNum }</td>
			<td>
				<c:if test="${preYear.phoneShopNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.phoneShopNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneShopNum-preYear.phoneShopNum)/preYear.phoneShopNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>8</td>
			<td>来电留资量</td>
			<td>${staCustomerRecordMonth.phoneCreateFolderNum }</td>
			<td>${preMonth.phoneCreateFolderNum }</td>
			<td>
				<c:if test="${preMonth.phoneCreateFolderNum==0}">
					0.0
				</c:if>
				<c:if test="${preMonth.phoneCreateFolderNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneCreateFolderNum-preMonth.phoneCreateFolderNum)/preMonth.phoneCreateFolderNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
			<td>${preYear.phoneCreateFolderNum }</td>
			<td>
				<c:if test="${preYear.phoneCreateFolderNum==0}">
					0.0
				</c:if>
				<c:if test="${preYear.phoneCreateFolderNum!=0}">
					<c:set value="${(staCustomerRecordMonth.phoneCreateFolderNum-preYear.phoneCreateFolderNum)/preYear.phoneCreateFolderNum*100 }" var="perMonth"></c:set>
					<c:if test="${perMonth>0 }">
						<span style="color: red;">
							↑<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
					<c:if test="${perMonth<=0 }">
						<span style="color: green;">
							↓<fmt:formatNumber value="${perMonth }" pattern="#0.00"></fmt:formatNumber>%
						</span>
					</c:if>
				</c:if>
			</td>
		</tr>
	</table>
</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		留资率同比/环比统
	</h5>
</div>
<table class="table table-bordered table-striped" style="font-size: 10px;">
	<thead>
		<tr>
			<td>序号</td>
			<td>项目</td>
			<td>${dateMonth }</td>
			<td>${preMonthStr }</td>
			<td>环比</td>
			<td>${preYearStr }</td>
			<td>同比</td>
		</tr>
	</thead>
	<tr>
		<td>1</td>
		<td>来店留资率</td>
		<td>
			<c:set var="comeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${staCustomerRecordMonth.comeShopNum!=0 }">
				<c:set var="comeShopCreateFolderPer" value="${staCustomerRecordMonth.comeShopCreateFolderNum/(staCustomerRecordMonth.firstComeNum)*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${comeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
		</td>
		<td>
			<c:set var="preComeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${preMonth.comeShopNum!=0 }">
				<c:set var="preComeShopCreateFolderPer" value="${preMonth.comeShopCreateFolderNum/preMonth.firstComeNum*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
		</td>
		<td>
			<c:if test="${(comeShopCreateFolderPer-preComeShopCreateFolderPer)>0 }" var="status">
				<span style="color: red;">↑<fmt:formatNumber value="${comeShopCreateFolderPer-preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
			<c:if test="${status==false }">
				<span style="color: green;">↓<fmt:formatNumber value="${comeShopCreateFolderPer-preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
		</td>
		<td>
			<c:set var="perYearComeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${preYear.comeShopNum!=0 }">
				<c:set var="perYearComeShopCreateFolderPer" value="${preYear.comeShopCreateFolderNum/preYear.firstComeNum*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
			
		</td>
		<td>
			<c:if test="${(comeShopCreateFolderPer-perYearComeShopCreateFolderPer)>0 }" var="status">
				<span style="color: red;">↑<fmt:formatNumber value="${comeShopCreateFolderPer-perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
			<c:if test="${status==false }">
				<span style="color: green;">↓<fmt:formatNumber value="${comeShopCreateFolderPer-perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>2</td>
		<td>来电留资率</td>
		<td>
			<c:set var="comeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${staCustomerRecordMonth.phoneShopNum!=0 }">
				<c:set var="comeShopCreateFolderPer" value="${staCustomerRecordMonth.phoneCreateFolderNum/staCustomerRecordMonth.phoneShopNum*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${comeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
		</td>
		<td>
			<c:set var="preComeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${preMonth.phoneShopNum!=0 }">
				<c:set var="preComeShopCreateFolderPer" value="${preMonth.phoneCreateFolderNum/preMonth.phoneShopNum*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
		</td>
		<td>
			<c:if test="${(comeShopCreateFolderPer-preComeShopCreateFolderPer)>0 }" var="status">
				<span style="color: red;">↑<fmt:formatNumber value="${comeShopCreateFolderPer-preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
			<c:if test="${status==false }">
				<span style="color: green;">↓<fmt:formatNumber value="${comeShopCreateFolderPer-preComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
		</td>
		<td>
			<c:set var="perYearComeShopCreateFolderPer" value="0"></c:set>
			<c:if test="${preYear.phoneShopNum!=0 }">
				<c:set var="perYearComeShopCreateFolderPer" value="${preYear.phoneCreateFolderNum/preYear.phoneShopNum*100 }"></c:set>
			</c:if>
			<fmt:formatNumber value="${perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%
			
		</td>
		<td>
			<c:if test="${(comeShopCreateFolderPer-perYearComeShopCreateFolderPer)>0 }" var="status">
				<span style="color: red;">↑<fmt:formatNumber value="${comeShopCreateFolderPer-perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
			<c:if test="${status==false }">
				<span style="color: green;">↓<fmt:formatNumber value="${comeShopCreateFolderPer-perYearComeShopCreateFolderPer }" pattern="#0.00"></fmt:formatNumber>%</span>
			</c:if>
		</td>
	</tr>
</table>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxStatCustomerRecord/queryReceptionStat" name="searchPageForm" id="searchPageForm" method="post">
      	 <table>
      	 	<tr>
  				<td><label>来源类型：</label></td>
  				<td colspan="">
  					<select class="form-control" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
						<option value="1" ${param.type==1?'selected="selected"':'' } >来店</option>
						<option value="2" ${param.type==2?'selected="selected"':'' } >来电</option>
					</select>
  				</td>
  				<td><label>线索有效：</label></td>
  				<td colspan="">
  					<select class="form-control" id="status" name="status"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
						<option value="1" ${param.status==1?'selected="selected"':'' } >有效</option>
						<option value="2" ${param.status==2?'selected="selected"':'' } >无效</option>
					</select>
  				</td>
  			</tr>
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
$(function () {
	  $('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日${type==1?"来店":"来电"}趋势图'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDay}]
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
		series:${dayByDayNum}
	});
	  $('#container1').highcharts({
		chart: {
			type: 'column'
		},
		title: {
			text: '${type==1?"来店":"来电"}时间段统计'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${receptionTimeTitle}]
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
		series:${receptionTimeData}
	});
	  $('#container2').highcharts({
		chart: {
			type: 'column'
		},
		title: {
			text: '${type==1?"来店":"来电"}目的统计'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${receptionTargetTitle}]
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
		series:${receptionTargetData}
	});
	  $('#container3').highcharts({
		  chart: {
				plotBackgroundColor: null,
				plotBorderWidth: null,
				plotShadow: false,
				type: 'pie'
			},
			title: {
				text: '关注车型占比'
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
				data: ${receptionCarSerData}
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