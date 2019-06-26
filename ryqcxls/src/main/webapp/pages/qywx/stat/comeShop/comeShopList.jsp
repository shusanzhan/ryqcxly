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
<title>客户到店（月）统计</title>
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
    <span id="page_title">客户到店（月）统计</span>
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
           <li class="detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxComeShop/queryComeShopList'">月统计</li>
           <li class="detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComeShop/queryComeShopYearList'">年统计</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		首次到店（日）明细
	</h5>
</div>
<p style="color: red;"><span style="color: red;font-weight: bold;">首次到店转订单率</span>=首次到店客户/首次到店转订单*100</p>
<p style="color: red;"><span style="color: red;font-weight: bold;">到店转定单率</span>=到店总订单/到店总客户*100</p>
<p style="color: red;"><span style="color: red;font-weight: bold;">到店总订单：含首次到店订单客户、二次到店订单客户</span></p>
<p style="color: red;"><span style="color: red;font-weight: bold;">到店总客户：含首次到店客户、二次到店客户</span></p>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">日期</td>
				<td style="width: 80px">建档客户</td>
				<td style="width: 80px">首次到店客户</td>
				<td style="width: 80px">首次到店转订单</td>
				<td style="width: 80px">首次到店转订单率%</td>
				<td style="width: 80px">到店总客户</td>
				<td style="width: 80px">到店转订单</td>
				<td style="width: 80px">到店转订单率</td>
			</tr>
			<c:if test="${fn:length(comeShops)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${comeShopTotal.createFolderNum }
					</td>
					<td>
						${comeShopTotal.comeShopNum }
					</td>
					<td>
						${comeShopTotal.comeShopOrderNum }
					</td>
					<td >
						<fmt:formatNumber value="${comeShopTotal.comeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
					<td>
						${comeShopTotal.totalComeShopNum }
					</td>
					<td>
						${comeShopTotal.comeShopTotalOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${comeShopTotal.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
				</tr>
			</c:if>
			<c:forEach items="${comeShops }" var="comeShop" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${comeShop.createDate}" pattern="yyyy-MM-dd"/> 
					</td>
					<td>
						${comeShop.createFolderNum }
					</td>
					<td>
						${comeShop.comeShopNum }
					</td>
					<td>
						${comeShop.comeShopOrderNum }
					</td>
					<td class="per">
						<fmt:formatNumber value="${comeShop.comeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
					<td>
						${comeShop.totalComeShopNum }
					</td>
					<td>
						${comeShop.comeShopTotalOrderNum }
					</td>
					<td class="per">
						<fmt:formatNumber value="${comeShop.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<td>
						${comeShopTotal.createFolderNum }
					</td>
					<td>
						${comeShopTotal.comeShopNum }
					</td>
					<td>
						${comeShopTotal.comeShopOrderNum }
					</td>
					<td>
					<fmt:formatNumber value="${comeShopTotal.comeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
					<td>
						${comeShopTotal.totalComeShopNum }
					</td>
					<td>
						${comeShopTotal.comeShopTotalOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${comeShopTotal.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="createFolderDayByDay" style=""></div>
	</div>
	<div class="hightChat">
		<div id="comeShopDayByDay" style=""></div>
	</div>
	<div class="hightChat">
		<div id="comeShopOrderDayByDay" style=""></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		各类型潜客线索到店率
	</h5>
</div>
<p style="color: red;"><span style="color: red;font-weight: bold;">留存潜客</span>=上月留存潜客，按月进行留存登记</p>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td>序号</td>
				<td>线索类型</td>
				<td>留存潜客</td>
				<td>新增潜客</td>
				<td>总潜客</td>
				<td>首次到店客户</td>
				<td>首次到店率</td>
				<td>二次到店客户</td>
				<td>总到店客户</td>
				<td>客户到店率</td>
			</tr>
			<c:forEach items="${comeShopTypes }" var="comeShopType" varStatus="i">
				<tr>
					<td>${i.index+1 }</td>
					<td>${comeShopType.name }</td>
					<td>${comeShopType.retainNum }</td>
					<td>${comeShopType.createFolderNum }</td>
					<td>${comeShopType.totalNum }</td>
					<td>${comeShopType.comeShopNum }</td>
					<td class="per">
						<fmt:formatNumber value="${comeShopType.comeShopPer}" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>${comeShopType.twoComeShopNum }</td>
					<td>${comeShopType.totalComeShopNum }</td>
					<td class="per">
						<fmt:formatNumber value="${comeShopType.comeShopTotalPer}" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<tr id="totalTr">
				<td colspan="2">合计</td>
				<td>${comeShopTypeTotal.retainNum }</td>
				<td>${comeShopTypeTotal.createFolderNum }</td>
				<td>${comeShopTypeTotal.totalNum }</td>
				<td>${comeShopTypeTotal.comeShopNum }</td>
				<td>
					<fmt:formatNumber value="${comeShopTypeTotal.comeShopPer}" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>${comeShopTypeTotal.twoComeShopNum }</td>
				<td>${comeShopTypeTotal.totalComeShopNum }</td>
				<td>
					<fmt:formatNumber value="${comeShopTypeTotal.comeShopTotalPer}" pattern="#0.00"></fmt:formatNumber> 
				</td>
			</tr>
	</tbody>
	</table>
</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		建档客户车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
					<td>序号</td>
					<td>车型</td>
					<td>总数</td>
					<td>占比</td>
				</tr>
				<c:forEach var="carSerCountTotal" items="${createFolderCarSeriys }" varStatus="i">
					<tr>
						<td>${i.index+1 }</td>
						<td>${carSerCountTotal.name }</td>
						<td>${carSerCountTotal.countNum }</td>
						<td>
							<c:if test="${comeShopTotal.createFolderNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.createFolderNum*100}" pattern="#0.00"></fmt:formatNumber>%
							</c:if>
							<c:if test="${comeShopTotal.createFolderNum<=0 }">
								0.0
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="2">合计</td>	
					<td>${comeShopTotal.createFolderNum }</td>	
					<td>100%</td>	
				</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="createFolderPieCarSerData"></div>
	</div>
	<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
		<h5 style="text-align: left;font-size: 16px">
			到店客户车型明细
		</h5>
	</div>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
					<td>序号</td>
					<td>车型</td>
					<td>总数</td>
					<td>占比</td>
				</tr>
				<c:forEach var="carSerCountTotal" items="${comeShopCarSeriys }" varStatus="i">
					<tr>
						<td>${i.index+1 }</td>
						<td>${carSerCountTotal.name }</td>
						<td>${carSerCountTotal.countNum }</td>
						<td>
							<c:if test="${comeShopTotal.comeShopNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
							</c:if>
							<c:if test="${comeShopTotal.comeShopNum<=0 }">
								0.0
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="2">合计</td>	
					<td>${comeShopTotal.comeShopNum }</td>	
					<td>100%</td>	
				</tr>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="comeShopPieCarSerData" ></div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		订单客户车型明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
					<td>序号</td>
					<td>车型</td>
					<td>总数</td>
					<td>占比</td>
				</tr>
				<c:forEach var="carSerCountTotal" items="${comeShopOrderCarSeriyAllList }" varStatus="i">
					<tr>
						<td>${i.index+1 }</td>
						<td>${carSerCountTotal.name }</td>
						<td>${carSerCountTotal.countNum }</td>
						<td>
							<c:if test="${comeShopTotal.comeShopTotalOrderNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopTotalOrderNum*100}" pattern="#0.00"></fmt:formatNumber>%
							</c:if>
							<c:if test="${comeShopTotal.comeShopTotalOrderNum<=0 }">
								0.0
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="2">合计</td>	
					<td>${comeShopTotal.comeShopTotalOrderNum }</td>	
					<td>100%</td>	
				</tr>
		</tbody>
	</table>
	<br>
	<div class="hightChat">
		<div id="comeShopOrderPieCarSerData" ></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问潜客（当月创建）到店率统计
	</h5>
</div>
<p style="color: red;">
	<span style="color: red;">
		说明：系统查询字段使用的邀约销售顾问ID作为基数（更重要的显示销售顾问邀约到店客户）
	</span>
</p>
<p style="color: red;">
	<span style="color: red;">
		首次到店率，对展厅销售顾问指标结果比较高，对网销销售顾问指标相对降低
	</span>
</p>
<p style="color: red;">
	<span style="color: red;">
		到店总客户:含首次到店客户，二次到店以及二次到店以上客户
	</span>
</p>
<div class="row-fluid">                
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">建档客户</td>
				<td style="width: 80px">首次到店</td>
				<td style="width: 80px">首次到店率</td>
				<td style="width: 80px">到店总客户</td>
				<td style="width: 80px">总到店率</td>
			</tr>
			<c:forEach items="${mapComeShopUserCarSeriys }" var="map" varStatus="i">
				<c:set var="key" value="${map.key }"></c:set>
				<c:set var="value" value="${map.value }"></c:set>
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						${key.realName }
					</td>
					<td>
						${key.createFolderNum }
					</td>
					<td>
						${key.comeShopNum }
					</td>
					<td class="per">
						<fmt:formatNumber value="${key.comeShopPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${key.totalComeShopNum }
					</td>
					<td class="per">
						<fmt:formatNumber value="${key.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<tr style="font-weight: bold;" id="totalTr">
				<td colspan="2">
					合计
				</td>
					<td>
						${comeShopUserTotal.createFolderNum }
					</td>
					<td>
						${comeShopUserTotal.comeShopNum }
					</td>
					<td>
						<fmt:formatNumber value="${comeShopUserTotal.comeShopPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${comeShopUserTotal.totalComeShopNum }
					</td>
					<td>
						<fmt:formatNumber value="${comeShopUserTotal.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问潜客（当月创建）到店车型统计
	</h5>
</div>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 50px">销售顾问</td>
				<td style="width: 40px">总客户</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td style="width: 40px;">${carSeriy.name }</td>
				</c:forEach>
			</tr>
		<c:forEach items="${mapComeShopUserCarSeriys }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.totalComeShopNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${comeShopUserTotal.totalComeShopNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCounts }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
		</tr>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="3">
				占比
			</td>
				<c:forEach var="carSerCountTotal" items="${carSerCounts }">
					<td>
						<c:if test="${comeShopUserTotal.totalComeShopNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopUserTotal.totalComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${comeShopUserTotal.totalComeShopNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
		</tr>
	</tbody>
</table>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问潜客（总）邀约店率统计（含历史数据)
	</h5>
</div>
<p style="color: red;"><span>说明：该统计反应客户邀约（强调邀约）情况，不能反应接待客户谈判情况</span></p>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 60px">销售顾问</td>
				<td style="width: 60px">留存</td>
				<td style="width: 60px">新增</td>
				<td style="width: 60px">总潜客</td>
				<td style="width: 60px">首次</td>
				<td style="width: 60px">首次率</td>
				<td style="width: 60px">总客户</td>
				<td style="width: 60px">总到店率</td>
			</tr>
		<c:forEach items="${mapComeShopUserCarSeriyAlls }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.keepNum }
				</td>
				<td>
					${key.createFolderNum }
				</td>
				<td>
					${key.totalNum }
				</td>
				<td>
					${key.comeShopNum }
				</td>
				<td class="per">
					<fmt:formatNumber value="${key.comeShopPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${key.totalComeShopNum }
				</td>
				<td class="per">
					<fmt:formatNumber value="${key.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${comeShopUserTotalAll.keepNum }
				</td>
				<td>
					${comeShopUserTotalAll.createFolderNum }
				</td>
				<td>
					${comeShopUserTotalAll.totalNum }
				</td>
				<td>
					${comeShopUserTotalAll.comeShopNum }
				</td>
				<td>
					<fmt:formatNumber value="${comeShopUserTotalAll.comeShopPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${comeShopUserTotalAll.totalComeShopNum }
				</td>
				<td>
					<fmt:formatNumber value="${comeShopUserTotalAll.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
		</tr>
	</tbody>
</table>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问潜客（总）邀约店车型统计（含历史数据)
	</h5>
</div>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 50px">销售顾问</td>
				<td style="width: 40px">总客户</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td style="width: 40px">${carSeriy.name }</td>
				</c:forEach>
			</tr>
		<c:forEach items="${mapComeShopUserCarSeriyAlls }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.totalComeShopNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${comeShopUserTotalAll.totalComeShopNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCountAlls }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
		</tr>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="3">
				占比
			</td>
			<c:forEach var="carSerCountTotal" items="${carSerCountAlls }">
				<td>
					<c:if test="${comeShopUserTotalAll.totalComeShopNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopUserTotalAll.totalComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${comeShopUserTotalAll.totalComeShopNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
		</tr>
	</tbody>
</table>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问到店客户转订单率统计
	</h5>
</div>
<p style="color: red;"><span>说明：对展厅销售顾问到店客户（含有网销邀约）</span></p>
<p style="color: red;"><span>说明：对网销销售顾问（未谈判人员）到店客户（邀约到店，客户未成交未转出）</span></p>
<p><span>无法明确：网销销售顾问-真实邀约客户批次</span></p>
<p><span>无法明确：展厅谈判销售顾问-真实谈判网销邀约客户批次</span></p>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">首次</td>
				<td style="width: 80px">首转订单</td>
				<td style="width: 80px">首订单率</td>
				<td style="width: 80px">到总量</td>
				<td style="width: 80px">总转订单</td>
				<td style="width: 80px">总转单率</td>
			</tr>
		<c:forEach items="${mapComeShopOrderUserCarSeriy }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.comeShopNum }
				</td>
				<td>
					${key.comeShopOrderNum }
				</td>
				<td class="per">
					<fmt:formatNumber value="${key.comeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${key.totalComeShopNum }
				</td>
				<td>
					${key.comeShopTotalOrderNum }
				</td>
				<td class="per">
					<fmt:formatNumber value="${key.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${comeShopOrderUserAll.comeShopNum }
				</td>
				<td>
					${comeShopOrderUserAll.comeShopOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${comeShopOrderUserAll.comeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${comeShopOrderUserAll.totalComeShopNum }
				</td>
				<td>
					${comeShopOrderUserAll.comeShopTotalOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${comeShopOrderUserAll.comeShopTotalPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
		</tr>
	</tbody>
</table>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问到店客户转订单车型统计
	</h5>
</div>
<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px;">序号</td>
				<td style="width: 50px">销售顾问</td>
				<td style="width: 50px">总转订单</td>
					<c:forEach var="carSeriy" items="${carSeriys }">
					<td style="width: 40px;">${carSeriy.name }</td>
				</c:forEach>
			</tr>
		<c:forEach items="${mapComeShopOrderUserCarSeriy }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.comeShopTotalOrderNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="2">
				合计
			</td>
				<td>
					${comeShopOrderUserAll.comeShopTotalOrderNum }
				</td>
					<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${comeShopOrderUserCarSeriyAll }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
		</tr>
		<tr style="font-weight: bold;" id="totalTr">
			<td colspan="3">
				占比
			</td>
				<c:forEach var="carSerCountTotal" items="${comeShopOrderUserCarSeriyAll }">
					<td>
						<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopOrderUserAll.comeShopTotalOrderNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
		</tr>
	</tbody>
</table>
<div class="hightChat">
	<div id="comeShopPieUserData"></div>
</div>

<div class="hightChat">
	<div id="comeShopOrderPieUserData" ></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		到店客户/到店转订单客户同比环比数据
	</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>类型</td>
			<td>${createFolderStaYearByYearChain.nowDate }</td>
			<td>${createFolderStaYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${createFolderStaYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
		<tr>
			<td>1</td>
			<td>建档客户</td>
			<td>${createFolderStaYearByYearChain.nowNum }</td>
			<td>${createFolderStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${createFolderStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${createFolderStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${createFolderStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${createFolderStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${createFolderStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${createFolderStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${createFolderStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${createFolderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${createFolderStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${createFolderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${createFolderStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>2</td>
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
			<td>3</td>
			<td>首次到店转订单客户</td>
			<td>${comeShopOrderStaYearByYearChain.nowNum }</td>
			<td>${comeShopOrderStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${comeShopOrderStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${comeShopOrderStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${comeShopOrderStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${comeShopOrderStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${comeShopOrderStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${comeShopOrderStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${comeShopOrderStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${comeShopOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${comeShopOrderStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${comeShopOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${comeShopOrderStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>4</td>
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
			<td>5</td>
			<td>二次到店转订单</td>
			<td>${twoComeShopOrderStaYearByYearChain.nowNum }</td>
			<td>${twoComeShopOrderStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${twoComeShopOrderStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${twoComeShopOrderStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${twoComeShopOrderStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${twoComeShopOrderStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${twoComeShopOrderStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${twoComeShopOrderStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${twoComeShopOrderStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${twoComeShopOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${twoComeShopOrderStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${twoComeShopOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${twoComeShopOrderStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
		<tr>
			<td>6</td>
			<td>到店转订单</td>
			<td>${comeShopTotalOrderStaYearByYearChain.nowNum }</td>
			<td>${comeShopTotalOrderStaYearByYearChain.preNum}</td>
			<td>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${comeShopTotalOrderStaYearByYearChain.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${comeShopTotalOrderStaYearByYearChain.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${comeShopTotalOrderStaYearByYearChain.yearByYearNum }</td>
			<td>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${comeShopTotalOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${comeShopTotalOrderStaYearByYearChain.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${comeShopTotalOrderStaYearByYearChain.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
</table>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		客户到店率/客户到店转订单率同比环比
	</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>项目</td>
			<td>${comeShopStaYearByYearChain.nowDate }</td>
			<td>${comeShopStaYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${comeShopStaYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
		<tr>
			<td>1</td>
			<td>首次到店率</td>
			<td><fmt:formatNumber value="${createFolderToComeShopYearByYearChainPer.nowTryCarPer }" pattern="#0.0"></fmt:formatNumber>%</td>
			<td>
				<fmt:formatNumber value="${createFolderToComeShopYearByYearChainPer.preTryCarPer }" pattern="#0.0"></fmt:formatNumber>%
			</td>
			<td>
				<c:set value="${createFolderToComeShopYearByYearChainPer.nowTryCarPer-createFolderToComeShopYearByYearChainPer.preTryCarPer }" var="pre"></c:set>
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
				<fmt:formatNumber value="${createFolderToComeShopYearByYearChainPer.yearByYearTryCarPer }" pattern="#0.0"></fmt:formatNumber>%
			</td>
			<td>
				<c:set value="${createFolderToComeShopYearByYearChainPer.nowTryCarPer-createFolderToComeShopYearByYearChainPer.yearByYearTryCarPer }" var="year"></c:set>
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
			<td>客户到店率</td>
			<td>
				<fmt:formatNumber value="${ComeShopYearByYearChainPer.nowTryCarPer }" pattern="#0.00"></fmt:formatNumber>%
			</td>
			<td>
				<fmt:formatNumber value="${ComeShopYearByYearChainPer.preTryCarPer }" pattern="#0.00"></fmt:formatNumber>%
			</td>
			<td>
				<c:set value="${ComeShopYearByYearChainPer.nowTryCarPer-ComeShopYearByYearChainPer.preTryCarPer }" var="pre"></c:set>
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
				<fmt:formatNumber value="${ComeShopYearByYearChainPer.yearByYearTryCarPer }" pattern="#0.00"></fmt:formatNumber>%
			</td>
			<td>
				<c:set value="${ComeShopYearByYearChainPer.nowTryCarPer-ComeShopYearByYearChainPer.yearByYearTryCarPer }" var="year"></c:set>
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
			<td>3</td>
			<td>到店转订单率</td>
			<td>${comeShopOrderearByYearChainPer.nowTryCarPer }%</td>
			<td>${comeShopOrderearByYearChainPer.preTryCarPer}%</td>
			<td>
				<c:set value="${comeShopOrderearByYearChainPer.nowTryCarPer-comeShopOrderearByYearChainPer.preTryCarPer }" var="pre"></c:set>
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
			<td>${comeShopOrderearByYearChainPer.yearByYearTryCarPer }%</td>
			<td>
				<c:set value="${comeShopOrderearByYearChainPer.nowTryCarPer-comeShopOrderearByYearChainPer.yearByYearTryCarPer }" var="year"></c:set>
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
</body>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxComeShop/queryComeShopList" name="searchPageForm" id="searchPageForm" method="post">
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
  				<td><label>客户类型：</label></td>
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
	$('#createFolderDayByDay').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日建档客户趋势图'
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
		series:${createFolderDayByDay}
	});
	$('#comeShopDayByDay').highcharts({
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
		series:${comeShopDayByDay}
	});
	$('#comeShopOrderDayByDay').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日订单趋势图'
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
		series:${comeShopOrderDayByDay}
	});
	$('#createFolderPieCarSerData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '建档客户车型占比'
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
			data: ${createFolderPieCarSerData}
		}]
	});
	$('#comeShopPieCarSerData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '到店总客户车型占比'
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
			data: ${comeShopPieCarSerData}
		}]
	});
	$('#comeShopOrderPieCarSerData').highcharts({
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
			name: '客户占比',
			colorByPoint: true,
			data: ${comeShopOrderPieCarSerData}
		}]
	});
	$('#comeShopPieUserData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '销售顾问接待客户占比'
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
			name: '客户占比',
			colorByPoint: true,
			data: ${comeShopPieUserData}
		}]
	});
	$('#comeShopOrderPieUserData').highcharts({
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
			data: ${comeShopOrderPieUserData}
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