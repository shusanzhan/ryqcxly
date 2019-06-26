<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>首次到店客户统计</title>
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
	  .per{
	  	color: red;
	  }
}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">首次到店统计</a>-
	<a href="javascript:void(-1);" onclick="">月统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/comeShop/queryComeShopYearList'" style="color: #2b7dbc;">首次到店客户年统计</a>
		<span style="color:#2b7dbc ">|</span> 
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a>  
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/comeShop/queryComeShopList" method="post" >
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
  				<td colspan="4" >
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
  					<a href="javascript:;" onclick="setSerachDate(1)">今天</a>|<a href="javascript:;" onclick="setSerachDate(2)">昨天</a>|<a href="javascript:;" onclick="setSerachDate(3)">最近7天</a>|<a href="javascript:;" onclick="setSerachDate(4)">本周</a>|<a href="javascript:;" onclick="setSerachDate(5)">本月</a>
  				</td>
   			</tr>
   			<tr>
   				<td colspan="1">
   				</td>
   				<td colspan="4">
   					<p id="searchTip" style="c">查询时间不能超过31天</p>
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
  <legend>首次到店统计</legend>
</fieldset>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<p style="color: red;"><span style="color: red;font-weight: bold;">首次到店转订单率</span>=首次到店客户/首次到店转订单*100</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">到店转定单率</span>=到店总订单/到店总客户*100</p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">到店总订单：含首次到店订单客户、二次到店订单客户</span></p>
		<p style="color: red;"><span style="color: red;font-weight: bold;">到店总客户：含首次到店客户、二次到店客户</span></p>
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
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
			</thead>
			<c:if test="${fn:length(comeShops)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" class="totalTr">
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
				<tr style="font-weight: bold;" class="totalTr">
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
		</table>
		<br>
		<div class="hightChat">
			<div id="createFolderDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="comeShopDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
		<div class="hightChat">
			<div id="comeShopOrderDayByDay" style="width: 98%;height: 240px;"></div>
			<div style="clear: both;"></div>
		</div>
		<br>
</div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>各类型潜客线索到店率</legend>
</fieldset>
<p style="color: red;"><span style="color: red;font-weight: bold;">留存潜客</span>=上月留存潜客，按月进行留存登记</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
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
	</thead>
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
	<tr class="totalTr">
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
</table>

<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>建档客户车型明细</legend>
</fieldset>
<h3>建档客户车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<td>建档客户</td>
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
						${comeShopTotal.createFolderNum }
					</td>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${createFolderCarSeriys }">
				<td>${carSerCountTotal.countNum }</td>
				<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
			</c:forEach>
			<td>${comeShopTotal.createFolderNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${createFolderCarSeriys }">
				<td>
					<c:if test="${comeShopTotal.createFolderNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.createFolderNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${comeShopTotal.createFolderNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${comeShopTotal.createFolderNum>0 }">
				100%
			</c:if>
			<c:if test="${comeShopTotal.createFolderNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapCreateFolderCarSeriy }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
			<td>
				${key.createFolderNum }
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.createFolderNum } </td>
		</tr>
	</c:forEach>
	<c:if test="${lengthStatus==false }">
		<tr class="totalTr">
			<td colspan="2">
						合计
					</td>
					<td>
						${comeShopTotal.createFolderNum }
					</td>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${createFolderCarSeriys }">
				<td>${carSerCountTotal.countNum }</td>
				<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
			</c:forEach>
			<td>${comeShopTotal.createFolderNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${createFolderCarSeriys }">
				<td>
					<c:if test="${comeShopTotal.createFolderNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.createFolderNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${comeShopTotal.createFolderNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${comeShopTotal.createFolderNum>0 }">
				100%
			</c:if>
			<c:if test="${comeShopTotal.createFolderNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
</table>
<div class="hightChat">
	<div id="createFolderPieCarSerData" style="width: 98%;"></div>
</div>

<br>
<h3>首次到店客户车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<td>首次客户</td>
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
						${comeShopTotal.comeShopNum }
					</td>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${comeShopCarSeriys }">
				<td>${carSerCountTotal.countNum }</td>
				<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
			</c:forEach>
			<td>${comeShopTotal.comeShopNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${comeShopCarSeriys }">
				<td>
					<c:if test="${comeShopTotal.comeShopNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${comeShopTotal.comeShopNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${comeShopTotal.comeShopNum>0 }">
				100%
			</c:if>
			<c:if test="${comeShopTotal.comeShopNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapComeShopCarSeriy }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
			<td>
				${key.comeShopNum }
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.comeShopNum }</td>
		</tr>
	</c:forEach>
	<c:if test="${lengthStatus==false }">
		<tr class="totalTr">
			<td colspan="2">
						合计
					</td>
					<td>
						${comeShopTotal.comeShopNum }
					</td>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${comeShopCarSeriys }">
				<td>${carSerCountTotal.countNum }</td>
				<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
			</c:forEach>
			<td>${comeShopTotal.comeShopNum }</td>	
		</tr>
		<tr class="totalTr">
			<td colspan="2">占比</td>
			<td>
			</td>
			<c:forEach var="carSerCountTotal" items="${comeShopCarSeriys }">
				<td>
					<c:if test="${comeShopTotal.comeShopNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${comeShopTotal.comeShopNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
			<td>
			<c:if test="${comeShopTotal.comeShopNum>0 }">
				100%
			</c:if>
			<c:if test="${comeShopTotal.comeShopNum<=0 }">
				0.0
			</c:if>
			</td>	
		</tr>
	</c:if>
</table>
<br>
<div class="hightChat">
	<div id="comeShopPieCarSerData" style="width: 98%;"></div>
</div>
<br>
<h3>到店客户转订单车型明细</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<td>到店总客户</td>
			<td>到店转订单</td>
			<td>到店转订单率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:if test="${lengthStatus==true }">
	<tr class="totalTr">
		<td colspan="2">合计</td>
			<td>
				${comeShopTotal.totalComeShopNum }
			</td>
			<td>
				${comeShopTotal.comeShopTotalOrderNum }
			</td>
			<td >
				<fmt:formatNumber value="${comeShopTotal.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${comeShopOrderCarSeriyAllList }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${comeShopTotal.comeShopTotalOrderNum }</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<c:forEach var="carSerCountTotal" items="${comeShopOrderCarSeriyAllList }">
			<td>
				<c:if test="${comeShopTotal.comeShopTotalOrderNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopTotalOrderNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${comeShopTotal.comeShopTotalOrderNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${comeShopTotal.comeShopTotalOrderNum>0 }">
			100%
		</c:if>
		<c:if test="${comeShopTotal.comeShopTotalOrderNum<=0 }">
			0.0
		</c:if>
		</td>	
	</tr>
	</c:if>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapComeShopOrderCarSeriy }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
			<td>
				${key.totalComeShopNum }
			</td>
			<td>
				${key.comeShopTotalOrderNum }
			</td>
			<td class="per">
				<fmt:formatNumber value="${key.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.comeShopTotalOrderNum }</td>
		</tr>
	</c:forEach>
	<c:if test="${lengthStatus==false }">
	<tr class="totalTr">
		<td colspan="2">合计</td>
			<td>
				${comeShopTotal.totalComeShopNum }
			</td>
			<td>
				${comeShopTotal.comeShopTotalOrderNum }
			</td>
			<td>
				<fmt:formatNumber value="${comeShopTotal.comeShopTotalOrderPer }" pattern="#0.00"></fmt:formatNumber> 	
			</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${comeShopOrderCarSeriyAllList }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${comeShopTotal.comeShopTotalOrderNum }</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<c:forEach var="carSerCountTotal" items="${comeShopOrderCarSeriyAllList }">
			<td>
				<c:if test="${comeShopTotal.comeShopTotalOrderNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopTotal.comeShopTotalOrderNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${comeShopTotal.comeShopTotalOrderNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${comeShopTotal.comeShopTotalOrderNum>0 }">
			100%
		</c:if>
		<c:if test="${comeShopTotal.comeShopTotalOrderNum<=0 }">
			0.0
		</c:if>
		</td>	
	</tr>
	</c:if>
</table>
<br>
<div class="hightChat">
	<div id="comeShopOrderPieCarSerData" style="width: 98%;"></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>销售顾问潜客到店/到店转订单统计</legend>
</fieldset>
<h3>潜客（当月创建）销售顾问到店率统计</h3>
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
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">建档客户</td>
				<td style="width: 80px">首次到店</td>
				<td style="width: 80px">首次到店率</td>
				<td style="width: 80px">到店总客户</td>
				<td style="width: 80px">总到店率</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td>${carSeriy.name }</td>
				</c:forEach>
				<td style="width: 60px;"> 合计 </td>
			</tr>
		</thead>
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${key.totalComeShopNum }
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCounts }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${comeShopUserTotal.totalComeShopNum }
				</td>
		</tr>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="7">
				占比
			</td>
				<c:forEach var="carSerCountTotal" items="${carSerCounts }">
					<td>
						<c:if test="${comeShopUserTotal.totalComeShopNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopUserTotal.totalComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
						</c:if>
						<c:if test="${comeShopUserTotal.totalComeShopNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
				<td>
					<c:if test="${comeShopUserTotal.totalComeShopNum>0 }">
						100%
					</c:if>
					<c:if test="${comeShopUserTotal.totalComeShopNum<=0 }">
						0.0
					</c:if>
				</td>
		</tr>
	</table>
<br>
<h3>销售顾问潜客（总）邀约店率统计（含历史数据)</h3>
<p style="color: red;"><span>说明：该统计反应客户邀约（强调邀约）情况，不能反应接待客户谈判情况</span></p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 60px">销售顾问</td>
				<td style="width: 60px">留存潜客</td>
				<td style="width: 60px">创建潜客</td>
				<td style="width: 60px">总潜客</td>
				<td style="width: 60px">首次到店</td>
				<td style="width: 60px">首次到店率</td>
				<td style="width: 60px">到店总客户</td>
				<td style="width: 60px">总到店率</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td>${carSeriy.name }</td>
				</c:forEach>
				<td style="width: 60px;"> 合计 </td>
			</tr>
		</thead>
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${key.totalComeShopNum }
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCountAlls }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${comeShopUserTotalAll.totalComeShopNum }
				</td>
		</tr>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="9">
				占比
			</td>
				<c:forEach var="carSerCountTotal" items="${carSerCountAlls }">
					<td>
						<c:if test="${comeShopUserTotalAll.totalComeShopNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopUserTotalAll.totalComeShopNum*100}" pattern="#0.00"></fmt:formatNumber>%
						</c:if>
						<c:if test="${comeShopUserTotalAll.totalComeShopNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
				<td>
					<c:if test="${comeShopUserTotalAll.totalComeShopNum>0 }">
						100%
					</c:if>
					<c:if test="${comeShopUserTotalAll.totalComeShopNum<=0 }">
						0.0
					</c:if>
				</td>
		</tr>
	</table>
<br>
<h3>当月销售顾问到店客户转订单率统计</h3>
<p style="color: red;"><span>说明：对展厅销售顾问到店客户（含有网销邀约）</span></p>
<p style="color: red;"><span>说明：对网销销售顾问（未谈判人员）到店客户（邀约到店，客户未成交未转出）</span></p>
<p><span>无法明确：网销销售顾问-真实邀约客户批次</span></p>
<p><span>无法明确：展厅谈判销售顾问-真实谈判网销邀约客户批次</span></p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
		<thead>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">销售顾问</td>
				<td style="width: 80px">首次到店</td>
				<td style="width: 80px">首转订单</td>
				<td style="width: 80px">首订单率</td>
				<td style="width: 80px">到店总量</td>
				<td style="width: 80px">总转订单</td>
				<td style="width: 80px">总转单率</td>
				<c:forEach var="carSeriy" items="${carSeriys }">
					<td>${carSeriy.name }</td>
				</c:forEach>
				<td style="width: 60px;"> 合计 </td>
			</tr>
		</thead>
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${value }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${key.comeShopTotalOrderNum }
				</td>
			</tr>
		</c:forEach>
		<tr style="font-weight: bold;" class="totalTr">
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
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${comeShopOrderUserCarSeriyAll }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
				<td>
					${comeShopOrderUserAll.comeShopTotalOrderNum }
				</td>
		</tr>
		<tr style="font-weight: bold;" class="totalTr">
			<td colspan="8">
				占比
			</td>
				<c:forEach var="carSerCountTotal" items="${comeShopOrderUserCarSeriyAll }">
					<td>
						<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/comeShopOrderUserAll.comeShopTotalOrderNum*100}" pattern="#0.00"></fmt:formatNumber>%
						</c:if>
						<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
				<td>
					<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum>0 }">
						100%
					</c:if>
					<c:if test="${comeShopOrderUserAll.comeShopTotalOrderNum<=0 }">
						0.0
					</c:if>
				</td>
		</tr>
	</table>
<br>
<div class="hightChat">
	<div id="comeShopPieUserData" style="width: 49%;float: left;"></div>
	<div id="comeShopOrderPieUserData" style="width: 49%;float: left;"></div>
	<div style="clear: both;"></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>到店客户同比/环比统计</legend>
</fieldset>
<h3>到店客户/到店转订单客户同比环比数据</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
<h3>客户到店率/客户到店转订单率同比环比</h3>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
			text: '${beginDate }至${endDate }建档客户车型占比'
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
			text: '${beginDate }至${endDate }到店总客户车型占比'
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
			text: '${beginDate }至${endDate }到店客户转订单销售顾问占比'
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
			text: '接待客户销售顾问型占比'
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
			text: '到店客户转订单销售顾问占比'
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
</body>

</html>
