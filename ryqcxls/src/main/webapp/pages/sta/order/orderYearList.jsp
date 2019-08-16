<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>到店客户年统计</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link href="${ctx }/css/common.css?" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.staltalbe thead td{
		border-top: 1px solid #999;
		font-weight: bold;
	}
	.staltalbe{
		width: 98%;line-height: 28px;border: 0px;margin: 0 auto;margin-top: 10px;font-family: '微软雅黑'
	}
	.staltalbe td{
		border-bottom: 1px solid #999;border-right: 1px solid #999;text-align: center;
	}
	.staltalbe td:FIRST-CHILD{ 
		border-left: 1px solid #999;
	}
	.staltalbe tr:last-child td{
	}
	.staltalbe .label{
		text-align: center;font-weight: bold;
	}
	.layui-elem-field {
	    margin-bottom: 10px;
	    padding: 0;
	    border-width: 1px;
	    border-style: solid;
	}
	.layui-field-title {
	    margin: 10px 0 20px;
	    border-width: 1px 0 0;
	}
	.layui-elem-field legend {
	    margin-left: 20px;
	    padding: 0 10px;
	    font-size: 20px;
	    font-weight: 300;
	 	width: auto;   
	 }
	  .buttonSerach{
	  	background-color: #3eb94e;height: 40px;line-height: 40px;padding: 0px 12px;color: white;text-align: center;cursor: pointer;width: 120px;margin: 0 a
	  }
	  .buttonSerach:HOVER {
	  	background-color: #3eb94e
		}
	   .searchTable a{
	   		color: #2b7dbc;
	   		padding: 0px 8px;
	   } 
	  .searchTable tr{
	  	height: 40px;
	  }   
}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">>到店客户统计</a>-
	<a href="javascript:void(-1);" onclick="">年统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/statOrder/queryOrderList'" style="color: #2b7dbc;">到店客户月统计</a>
		<span style="color:#2b7dbc ">|</span> 
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a> 
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statOrder/queryOrderYearList" method="post" >
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<c:if test="${fn:length(enterprises)>1 }">
	  				<tr>
		  				<td ><label>分公司：</label></td>
		  				<td colspan="5">
		  					<select class="text small" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
		  						<option value="-1">请选择...</option>
		  						<c:forEach var="enter" items="${enterprises }">
			  						<option value="${enter.dbid }" ${enter.dbid==enterprise.dbid?'selected="selected"':'' }>${enter.name }</option>
		  						</c:forEach>
							</select>
		  				</td>
		  			</tr>
  				</c:if>
  				<tr>
  					<td><label>客户型类：</label></td>
	  				<td >
	  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="customerType" items="${customerTypes }">
		  						<option value="${customerType.dbid }" ${customerType.dbid==param.type?'selected="selected"':'' }>${customerType.name }</option>
	  						</c:forEach>
						</select>
	  				</td>
	  				<td><label>试乘试驾：</label></td>
	  				<td>
	  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="">请选择...</option>
							<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
							<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
						</select>
	  				</td>
	  				<td><label>到店状态：</label></td>
	  				<td>
	  					<select class="small text" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
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
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${beginDate }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${endDate }">
  				</td>
  				<td colspan="2">
  					<a href="javascript:;" onclick="setSerachDate(1)">最近3个月</a>|<a href="javascript:;" onclick="setSerachDate(2)">今年</a>|<a href="javascript:;" onclick="setSerachDate(3)">去年</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="1">
   				</td>
   				<td colspan="5">
   					<p id="searchTip" style="c">查询时间不能超过12月</p>
   				</td>
   			</tr>
   			<tr>
   				<td colspan="5" style="text-align: center;"><div  onclick="if(validateSearch()){$('#searchPageForm')[0].submit()}"  class="buttonSerach">查询</div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">日期</td>
					<td style="width: 80px">自有店</td>
					<td style="width: 80px">二网</td>
					<td style="width: 80px">合计</td>
				</tr>
			</thead>
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
						<fmt:formatDate value="${order.createDate}" pattern="yyyy-MM"/> 
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
			<div id="selfOrderDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="netOrderDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="orderDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
</div>
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
</br>
<h3>客户类型订单统计</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">留存潜客</span>=上月留存潜客，按月进行留存登记</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>线索类型</td>
			<td>订单量</td>
		</tr>
	</thead>
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

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>订单客户车型明细</legend>
</fieldset>
<h3>订单客户车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<td>订单客户</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
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
			<td>${totalOrder.orderNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
				<td>
					<c:if test="${totalOrder.orderNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/totalOrder.orderNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${totalOrder.orderNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${totalOrder.orderNum>0 }">
				100%
			</c:if>
			<c:if test="${totalOrder.orderNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapCarseriys }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM"/> </td>
			<td>
				${key.orderNum }
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.orderNum } </td>
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
			<td>${totalOrder.orderNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${orderCarSeriyAll }">
				<td>
					<c:if test="${totalOrder.orderNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/totalOrder.orderNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${totalOrder.orderNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${totalOrder.orderNum>0 }">
				100%
			</c:if>
			<c:if test="${totalOrder.orderNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
</table>
<div class="hightChat">
	<div id="pieOrderCarSerData" style="width: 98%;"></div>
</div>
<br>
<h3>销售顾问订单车型统计</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">订单</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td>${carSeriy.name }</td>
				</c:forEach>
			</tr>
		</thead>
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
<br>
<h3>订单客户同比环比数据</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
<br>
<br>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
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
			text: '${beginDate }至${endDate }客户类型订单占比'
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
			text: '${beginDate }至${endDate }订单销售顾问占比'
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
			text: '${beginDate }至${endDate }订单车型占比'
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
</script>
</body>

</html>
