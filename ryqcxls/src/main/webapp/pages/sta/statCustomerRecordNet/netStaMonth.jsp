<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>网销流量统计-按月统计</title>
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
	<a href="javascript:void(-1);" onclick="">网销流量统计</a>-
	<a href="javascript:void(-1);" onclick="">月统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/statCustomerRecordNet/queryNetStaYear'" style="color: #2b7dbc;">网销线索年统计</a> <span style="color:#3eb94e ">|</span>
		<a href="javascript:void(-1)"  onclick='$.utile.openDialog("${ctx}/customerInfromStaSet/edit","网销统计设置",640,360);' style="color: #2b7dbc;">网销线索统计设置</a>
		<span style="color:#3eb94e ">|</span>
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a>
		
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statCustomerRecordNet/queryNetStaMonth" method="post" >
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
  <legend>网线线索统计</legend>
</fieldset>
<ul class="nav nav-tabs" role="tablist">
  <li class="active">
  	<a href="#baseInfo" role="tab" data-toggle="tab">网销线索统计</a>
  </li>
  <li>
  	<a href="#baseInfo2" role="tab" data-toggle="tab">网销有效线索统计</a>
  </li>
</ul>
<div class="tab-content" >
	<c:if test="${fn:length(mapCustomerInfromStaSets)>15 }" var="lengthStatus"></c:if>
	<div class="tab-pane active" id="baseInfo" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">日期</td>
					<c:forEach items="${customerInfromStaSets }" var="customerInfromStaSet">
						<td style="width: 120px;">${customerInfromStaSet.alias}</td>
					</c:forEach>
					<td style="width: 60px;"> 合计 </td>
				</tr>
			</thead>
				<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${customerInfromStaSetTotals }" var="customerInfromStaSet">
						<td>
							<c:set value="${customerInfromStaSet.totalNum+setTotal}" var="setTotal"></c:set>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${setTotal }
					</td>
				</tr>
			</c:if>
			<c:forEach items="${mapCustomerInfromStaSets }" var="map" varStatus="i">
				<c:set value="${map.key }" var="staCustomerRecordDateNum"></c:set>
				<c:set value="${map.value }" var="customerInfromStaSetValues"></c:set>
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${staCustomerRecordDateNum.createDate}" pattern="yyyy-MM-dd"/> 
					</td>
					<c:forEach items="${customerInfromStaSetValues }" var="customerInfromStaSet">
						<td>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${staCustomerRecordDateNum.totalNum }
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${customerInfromStaSetTotals }" var="customerInfromStaSet">
						<td>
							<c:set value="${customerInfromStaSet.totalNum+setTotal}" var="setTotal"></c:set>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${setTotal }
					</td>
				</tr>
			</c:if>
		</table>
		<br>
		<div class="hightChat">
			<div id="container" style="width: 98%"></div>
			<div style="clear: both;"></div>
		</div>
	</div>
	<div class="tab-pane" id="baseInfo2" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 80px">日期</td>
					<c:forEach items="${customerInfromStaSets }" var="customerInfromStaSet">
						<td style="width: 120px;">${customerInfromStaSet.alias}</td>
					</c:forEach>
					<td style="width: 60px;"> 合计 </td>
				</tr>
			</thead>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${effCustomerInfromStaSetTotals }" var="customerInfromStaSet">
						<td>
							<c:set value="${customerInfromStaSet.totalNum+setTotal}" var="setTotal"></c:set>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${setTotal }
					</td>
				</tr>
			</c:if>
			<c:forEach items="${mapEffCustomerInfromStaSets }" var="map" varStatus="i">
				<c:set value="${map.key }" var="staCustomerRecordDateNum"></c:set>
				<c:set value="${map.value }" var="customerInfromStaSetValues"></c:set>
				<tr>
					<td>
						${i.index+1 }
					</td>
					<td>
						<fmt:formatDate value="${staCustomerRecordDateNum.createDate}" pattern="yyyy-MM-dd"/> 
					</td>
					<c:forEach items="${customerInfromStaSetValues }" var="customerInfromStaSet">
						<td>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${staCustomerRecordDateNum.totalNum }
					</td>
				</tr>
			</c:forEach>
			<c:if test="${lengthStatus==false }">
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${effCustomerInfromStaSetTotals }" var="customerInfromStaSet">
						<td>
							<c:set value="${customerInfromStaSet.totalNum+setTotal}" var="setTotal"></c:set>
							${customerInfromStaSet.totalNum }
						</td>
					</c:forEach>
					<td>
						${setTotal }
					</td>
				</tr>
			</c:if>
		</table>
		<br>
		<div class="hightChat">
			<div id="container1" style="width: 98%"></div>
			<div style="clear: both;"></div>
		</div>
	</div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>线索汇总</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>平台</td>
			<td>总线索</td>
			<td>有效线索</td>
			<td>有效率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:set value="0" var="sTotalNum"></c:set>
	<c:set value="0" var="sEffTotalNum"></c:set>
	<c:forEach items="${mapCustomerInfromCars }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td>${key.alias } </td>
			<td>
				${key.totalNum }
				<c:set value="${sTotalNum+key.totalNum }" var="sTotalNum"></c:set>
			</td>
			<td>
				${key.effTotalNum } 
				<c:set value="${sEffTotalNum+key.effTotalNum }" var="sEffTotalNum"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${key.effPer }" pattern="#0.00"></fmt:formatNumber>%
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.effTotalNum } </td>
		</tr>
	</c:forEach>
	<tr class="totalTr">
		<td colspan="2">合计</td>
		<td>
			${sTotalNum }
		</td>
		<td>
			${sEffTotalNum }
		</td>
		<td>
			<c:if test="${sTotalNum!=0 }">
				<fmt:formatNumber value="${sEffTotalNum/sTotalNum*100 }" pattern="#0.00"></fmt:formatNumber>%
			</c:if>
		</td>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${sEffTotalNum}</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		</td>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>
				<c:if test="${countNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/countNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${countNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${countNum>0 }">
			100%
		</c:if>
		<c:if test="${countNum<=0 }">
			0.0
		</c:if>
		</td>	
	</tr>
</table>
<br>
<br>
<div class="hightChat">
	<div id="container2" style="width: 100%;"></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>网销关注车型统计</legend>
</fieldset>
网销平台：
<select id="customerInfromSetDbid" name=customerInfromSetDbid class="text large" onchange="ajaxCarCount()">
	<option value="-1">请选择...</option>
	<c:forEach var="customerInfromStaSet" items="${customerInfromStaSets }">
		<option value="${customerInfromStaSet.dbid }">${customerInfromStaSet.alias }</option>
	</c:forEach>
</select>
<div id="carCountId">
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:forEach items="${mapCarSerCount }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.totalNum}</td>	
		</tr>
	</c:forEach>
	<tr class="totalTr">
		<td colspan="2">合计</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${countNum}</td>	
	</tr>
	<tr class="totalTr">
		<td colspan="2">占比</td>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>
				<c:if test="${countNum>0 }">
					<fmt:formatNumber value="${carSerCountTotal.countNum/countNum*100}" pattern="#0.00"></fmt:formatNumber>%
				</c:if>
				<c:if test="${countNum<=0 }">
					0.0
				</c:if>
			</td>
		</c:forEach>
		<td>
		<c:if test="${countNum>0 }">
			100%
		</c:if>
		<c:if test="${countNum<=0 }">
			0.0
		</c:if>
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
  <legend>网销销售顾问线索车型统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>业务员</td>
			<td>总线索</td>
			<td>有效客户</td>
			<td>有效率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td>${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:forEach items="${mapUsers }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td>
				${key.realName }
			</td>
			<td>
				${key.totalNum }
			</td>
			<td>
				${key.creatorFolderNum }
			</td>
			<td>
				<c:if test="${empty(key.creatorFolderPer) }">
					0.0
				</c:if>
				<c:if test="${!empty(key.creatorFolderPer) }">
					<fmt:formatNumber value="${key.creatorFolderPer }" pattern="#0.00"></fmt:formatNumber>% 
				</c:if>
			</td>
			<c:forEach var="carSerCount" items="${value }">
				<td>${carSerCount.countNum }  </td>
			</c:forEach>
			<td>${key.creatorFolderNum}</td>	
		</tr>
	</c:forEach>
	<tr>
		<td colspan="2">合计</td>
			<td>
				${customerRecordUserTotal.totalNum }
			</td>
			<td>
				${customerRecordUserTotal.creatorFolderNum }
			</td>
			<td>
				<c:if test="${!empty(customerRecordUserTotal.creatorFolderNum)&&!empty(customerRecordUserTotal.totalNum)&&customerRecordUserTotal.totalNum>0}" var="status">
					<fmt:formatNumber value="${customerRecordUserTotal.creatorFolderNum/customerRecordUserTotal.totalNum*100 }" pattern="#0.00"></fmt:formatNumber>% 
				</c:if>
				<c:if test="${status==false }">
					0.00
				</c:if>
			</td>
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${countNum}</td>	
	</tr>
</table>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>网销线索同比/环比统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerRecordInfromYearByYearChain.nowDate }</td>
			<td>${fristCustomerRecordInfromYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerRecordInfromYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${customerRecordInfromYearByYearChainTotals}" varStatus="i">
		<tr>
			<td>${i.index+1 }</td>
			<td>${customerRecordInfromYearByYear.alias }</td>
			<td>${customerRecordInfromYearByYear.nowNum }</td>
			<td>${customerRecordInfromYearByYear.preNum}</td>
			<td>
				<c:if test="${customerRecordInfromYearByYear.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${customerRecordInfromYearByYear.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${customerRecordInfromYearByYear.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${customerRecordInfromYearByYear.yearByYearNum }</td>
			<td>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${customerRecordInfromYearByYear.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${customerRecordInfromYearByYear.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>网销有效线索同比/环比统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerRecordInfromYearByYearChain.nowDate }</td>
			<td>${fristCustomerRecordInfromYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerRecordInfromYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${customerRecordInfromYearByYearChains}" varStatus="i">
		<tr>
			<td>${i.index+1 }</td>
			<td>${customerRecordInfromYearByYear.alias }</td>
			<td>${customerRecordInfromYearByYear.nowNum }</td>
			<td>${customerRecordInfromYearByYear.preNum}</td>
			<td>
				<c:if test="${customerRecordInfromYearByYear.chainPer>0 }">
					<span style="color: red"><fmt:formatNumber value="${customerRecordInfromYearByYear.chainPer}" pattern="#0.00"></fmt:formatNumber>% ↑</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.chainPer<0 }">
					<span style="color: green"><fmt:formatNumber value="${customerRecordInfromYearByYear.chainPer }" pattern="#0.00"></fmt:formatNumber>%↓</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.chainPer==0 }">
					0.0
				</c:if>
			</td>
			<td>${customerRecordInfromYearByYear.yearByYearNum }</td>
			<td>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer>0 }">
					<span style="color: red">
					<fmt:formatNumber value="${customerRecordInfromYearByYear.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>%	↑</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer<0 }">
					<span style="color: green">
						<fmt:formatNumber value="${customerRecordInfromYearByYear.yreaByYearPer }" pattern="#0.0"></fmt:formatNumber>% ↓
					</span>
				</c:if>
				<c:if test="${customerRecordInfromYearByYear.yreaByYearPer==0 }">
						0.0
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>网销线索有效率同比/环比统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerRecordInfromYearByYearChain.nowDate }</td>
			<td>${fristCustomerRecordInfromYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerRecordInfromYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${sustomerRecordInfromYearByYearEffChains}" varStatus="i">
		<tr>
			<td>${i.index+1 }</td>
			<td>${customerRecordInfromYearByYear.alias }</td>
			<td>${customerRecordInfromYearByYear.nowEffPer }%</td>
			<td>${customerRecordInfromYearByYear.preEffPer}%</td>
			<td>
				<c:set value="${customerRecordInfromYearByYear.nowEffPer-customerRecordInfromYearByYear.preEffPer }" var="pre"></c:set>
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
			<td>${customerRecordInfromYearByYear.yearByYearEffPer }%</td>
			<td>
				<c:set value="${customerRecordInfromYearByYear.nowEffPer-customerRecordInfromYearByYear.yearByYearEffPer }" var="year"></c:set>
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
	</c:forEach>
</table>
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
	$('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日网线线索趋势图'
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
	$('#container1').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日网线线索趋势图'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${dayByDayEff}]
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
		series:${dayByDayNumEff}
	});
	ajaxCarCount()
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
function ajaxCarCount(){
	var params=$("#searchPageForm").serialize();
	var customerInfromSetDbid=$("#customerInfromSetDbid").val();
	$.post("${ctx}/statCustomerRecordNet/ajaxCarCount?customerInfromSetDbid="+customerInfromSetDbid+"&dateType=1",params,function(data){
		if(data=="error"){
			alert("查询出错！");
		}else{
			var obj=data.split("|");
			$("#carCountId").text("");
			$("#carCountId").append(obj[0]);
			chart3(obj[1],obj[2]);
		}
	})
}
function chart3(title,data){
	var categories=title.split(",");
	data=eval("("+data+")");
	chartB=new Highcharts.Chart({
		chart: {
			renderTo: 'container3',
			type: 'column',
		},
		title: {
			text: '网销关注车型'
		},
		credits:{
        	enabled:false
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories:categories
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
		series:data
	});
}
</script>
</body>

</html>
