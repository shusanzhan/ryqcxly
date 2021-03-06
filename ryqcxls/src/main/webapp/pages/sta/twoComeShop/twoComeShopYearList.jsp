<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>来店客户二次到店统计</title>
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
	<a href="javascript:void(-1);" onclick="">二次到店统计</a>-
	<a href="javascript:void(-1);" onclick="">年统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/twoComeShop/queryTwoComeShopList'" style="color: #2b7dbc;">二次到店月统计</a>
		<span style="color:#2b7dbc ">|</span> 
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a> 
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/twoComeShop/queryTwoComeShopYearList" method="post" >
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<c:if test="${fn:length(enterprises)>1 }">
	  				<td><label>分公司：</label></td>
	  				<td colspan="4" >
	  					<select class="text small" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="enter" items="${enterprises }">
		  						<option value="${enter.dbid }" ${enter.dbid==enterprise.dbid?'selected="selected"':'' }>${enter.name }</option>
	  						</c:forEach>
						</select>
	  				</td>
  				</c:if>
  			</tr>
  			<tr>
  					<td><label>客户类型：</label></td>
	  				<td >
	  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
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
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${beginDate }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${endDate }">
  				</td>
  				<td>
  					<a href="javascript:;" onclick="setSerachDate(1)">最近3个月</a>|<a href="javascript:;" onclick="setSerachDate(2)">今年</a>|<a href="javascript:;" onclick="setSerachDate(3)">去年</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="1">
   				</td>
   				<td colspan="4">
   					<p id="searchTip" style="c">查询时间不能超过12个月</p>
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
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>二次到店率/二次到店转订单率统计</legend>
</fieldset>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<p style="color: red;"><span style="color: red;font-weight: bold;">到店客户合计</span>=首次到店客户+客户；</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">二次到店率</span>=二次到店客户/到店客户合计*100</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">二次到店转订单率</span>=二次到店转订单/二次到店客户*100</p>
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">月份</td>
					<td style="width: 80px">首次到店客户</td>
					<td style="width: 80px">二次到店客户</td>
					<td style="width: 80px">到店客户合计</td>
					<td style="width: 80px">二次到店率%</td>
					<td style="width: 80px">二次到店转单订单</td>
					<td style="width: 80px">二次到店转订单率%</td>
				</tr>
			</thead>
			<c:forEach items="${twoComeShops }" var="twoComeShop" varStatus="i">
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${twoComeShop.createDate}" pattern="yyyy-MM"/> 
					</td>
					<td>
						${twoComeShop.comeShopNum }
					</td>
					<td>
						${twoComeShop.twoComeShopNum }
					</td>
					<td>
						${twoComeShop.totalNum }
					</td>
					<td>
						<fmt:formatNumber value="${twoComeShop.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
					<td>
						${twoComeShop.twoComeShopOrderNum }
					</td>
					<td>
						<fmt:formatNumber value="${twoComeShop.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 
					</td>
				</tr>
			</c:forEach>
			<tr class="totalTr">
				<td colspan="2">
					合计
				</td>
				<td>
					${twoComeShopTotal.comeShopNum }
				</td>
				<td>
					${twoComeShopTotal.twoComeShopNum }
				</td>
				<td>
					${twoComeShopTotal.totalNum }
				</td>
				<td>
				<fmt:formatNumber value="${twoComeShopTotal.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
				<td>
					${twoComeShopTotal.twoComeShopOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${twoComeShopTotal.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
			</tr>
		</table>
		<br>
		<div class="hightChat">
			<div id="container" style="width: 98%"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="pieComeShop" style="width: 49%;float: left"></div>
			<div id="pieTryCar" style="width: 49%;float: left"></div>
		<div style="clear: both;"></div>
</div>
	</div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>二次到店率/二次到店客户订单率明细</legend>
</fieldset>
<h3>二次到店客户车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>月份</td>
			<td>来店客户</td>
			<td>二次到店客户</td>
			<td>二次到店率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
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
				${key.twoComeShopNum } 
			</td>
			<td>
				<fmt:formatNumber value="${key.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber>%
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.twoComeShopNum } </td>
		</tr>
	</c:forEach>
	<tr class="totalTr">
		<td colspan="2" >
					合计
				</td>
				<td>
					${twoComeShopTotal.totalNum }
				</td>
				<td>
					${twoComeShopTotal.twoComeShopNum }
				</td>
				<td>
					<fmt:formatNumber value="${twoComeShopTotal.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 	
				</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${carSerCounts }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${twoComeShopTotal.twoComeShopNum}</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<c:forEach var="carSerCountTotal" items="${carSerCounts }">
			<td>
				<c:if test="${twoComeShopTotal.twoComeShopNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/twoComeShopTotal.twoComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${twoComeShopTotal.twoComeShopNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${twoComeShopTotal.twoComeShopNum>0 }">
			100%
		</c:if>
		<c:if test="${twoComeShopTotal.twoComeShopNum<=0 }">
			0.0
		</c:if>
		</td>	
	</tr>
</table>
<br>
<div class="hightChat">
	<div id="pieCustomerTryCar" ></div>
	<div style="clear: both;"></div>
</div>
<br>
<h3>二次到店转订单车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>月份</td>
			<td>二次到店客户</td>
			<td>二次到店转订单</td>
			<td>二次到店客户订单率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapTwoComeShopOrders }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM"/> </td>
			<td>
				${key.twoComeShopNum }
			</td>
			<td>
				${key.twoComeShopOrderNum }
			</td>
			<td>
				<fmt:formatNumber value="${key.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.twoComeShopOrderNum } </td>
		</tr>
	</c:forEach>
	<tr class="totalTr">
		<td colspan="2">合计</td>
		<td>
			${twoComeShopTotal.twoComeShopNum }
		</td>
		<td>
			${twoComeShopTotal.twoComeShopOrderNum }
		</td>
		<td>
			<fmt:formatNumber value="${twoComeShopTotal.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber>% 	
		</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${listTwoComeShopOrders }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${twoComeShopTotal.twoComeShopOrderNum }</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<c:forEach var="carSerCountTotal" items="${listTwoComeShopOrders }">
			<td>
				<c:if test="${twoComeShopTotal.twoComeShopNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/twoComeShopTotal.twoComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${twoComeShopTotal.twoComeShopNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${twoComeShopTotal.twoComeShopNum>0 }">
			100%
		</c:if>
		<c:if test="${twoComeShopTotal.twoComeShopNum<=0 }">
			0.0
		</c:if>
		</td>	
	</tr>
</table>
<br>
<div class="hightChat">
	<div id="pieCustomerTryCarOrder" ></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>二次到店率/二次到店转订单率车型统计</legend>
</fieldset>
<div id="carCountId">
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">车型</td>
				<td style="width: 80px">到店客户</td>
				<td style="width: 80px">二次到店客户</td>
				<td style="width: 80px">二次到店率%</td>
				<td style="width: 80px">二次到店客户订单</td>
				<td style="width: 80px">二次到店客户订单率%</td>
			</tr>
		</thead>
		<c:forEach items="${twoComeShopCarSeriys }" var="staTryCar" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${staTryCar.name }
				</td>
				<td>
					${staTryCar.totalNum }
				</td>
				<td>
					${staTryCar.twoComeShopNum }
				</td>
				<td>
					<fmt:formatNumber value="${staTryCar.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${staTryCar.twoComeShopOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${staTryCar.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
			<td>
				${twoComeShopTotal.totalNum }
			</td>
			<td>
				${twoComeShopTotal.twoComeShopNum }
			</td>
			<td>
			<fmt:formatNumber value="${twoComeShopTotal.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
			<td>
				${twoComeShopTotal.twoComeShopOrderNum }
			</td>
			<td>
				<fmt:formatNumber value="${twoComeShopTotal.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
		</tr>
	</table>
</div>
<br>
<div class="hightChat">
	<div id="container3" style="width: 100%;"></div>
</div>
<br>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>销售顾问试乘试率/二次到店转订单率统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">到店客户</td>
				<td style="width: 80px">二次到店客户客户</td>
				<td style="width: 80px">二次到店率%</td>
				<td style="width: 80px">二次到店转订单</td>
				<td style="width: 80px">二次到店客户转单订单率%</td>
			</tr>
		</thead>
		<c:forEach items="${twoComeShopUsers }" var="staTryCar" varStatus="i">
			<tr>
				<td>
					${i.index+1 }
				</td>
				<td>
					${staTryCar.userName }
				</td>
				<td>
					${staTryCar.totalNum }
				</td>
				<td>
					${staTryCar.twoComeShopNum }
				</td>
				<td>
					<fmt:formatNumber value="${staTryCar.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
				<td>
					${staTryCar.twoComeShopOrderNum }
				</td>
				<td>
					<fmt:formatNumber value="${staTryCar.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="2">
				合计
			</td>
			<td>
				${twoComeShopTotal.totalNum }
			</td>
			<td>
				${twoComeShopTotal.twoComeShopNum }
			</td>
			<td>
			<fmt:formatNumber value="${twoComeShopTotal.twoComeShopPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
			<td>
				${twoComeShopTotal.twoComeShopOrderNum }
			</td>
			<td>
				<fmt:formatNumber value="${twoComeShopTotal.twoComeShopOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
		</tr>
	</table>
<br>
<div class="hightChat">
	<div id="pieUserMonth" style="width: 49%;float: left;"></div>
	<div id="pieUserMonthComeShop" style="width: 49%;float: left;"></div>
	<div style="clear: both;"></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>二次到店客户同比/环比统计</legend>
</fieldset>
<h3>二次到店客户/二次到店转订单同比环比数据</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
			<td>二次到店转订单</td>
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
<h3>二次到店率/二次到店转订单率同比环比</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
			<td>${staTryCarYearByYearChainPer.nowTryCarPer }%</td>
			<td>${staTryCarYearByYearChainPer.preTryCarPer}%</td>
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
			<td>${tryCarOrderStaTryCarYearByYearChainPer.nowTryCarPer }%</td>
			<td>${tryCarOrderStaTryCarYearByYearChainPer.preTryCarPer}%</td>
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
			<td>${tryCarOrderStaTryCarYearByYearChainPer.yearByYearTryCarPer }%</td>
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
	$('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '月到店客户趋势图'
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
			text: '${beginDate }至${endDate }到首次到店客户占比'
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
			text: '${beginDate }至${endDate }二次到店客户订单占比'
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
			text: '${beginDate }至${endDate }二次到店客户各车型占比'
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
			text: '${beginDate }至${endDate }二次到店转订单各车型占比'
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
			data: ${pieCustomerTryCarOrder}
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
