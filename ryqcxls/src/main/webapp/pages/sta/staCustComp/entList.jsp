<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>潜客综合统计</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	a:VISITED{
		text-decoration: none;
		border: none;
		
	}
	.layui-btn {
	    display: inline-block;
	    height: 38px;
	    line-height: 38px;
	    padding: 0 18px;
	    background-color: #009688;
	    color: #fff;
	    white-space: nowrap;
	    text-align: center;
	    font-size: 14px;
	    border: none;
	    border-radius: 2px;
	    cursor: pointer;
	}
	.layui-btn:VISITED {
	    background-color: #009688;
	    color: #fff;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>->
	<a href="javascript:void(-1);" class="aedit" onclick="queryArea('searchPageForm')">潜客综合统计</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate" >
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
   <div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx }/staCustComp/queryEntList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="type" name="type" value='1'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				 <td><label>登记日期：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${beginDate }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${endDate }">
  				</td>
  				<td><div  onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div style="margin: 5px;">
	<a class="layui-btn" href="#miao">集客统计</a>
	<a class="layui-btn" href="#comeShop">到店统计</a>
	<a class="layui-btn" href="#twoComeShop">二次到店统计</a>
	<a class="layui-btn" href="#tryCar">试乘试驾统计</a>
	<a class="layui-btn" href="#successCustomer">客户成交统计</a>
	<a class="layui-btn" href="#customerFlow">客户流失统计</a>
	<a class="layui-btn" href="#customerTrack">客户回访统计</a>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')" >潜客综合统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
		<tr>
			<td>序号</td>
			<td>分公司</td>
			<td>潜客总数</td>
			<td>流失客户</td>
			<td>流失率%</td>
			<td>成交客户</td>
			<td>成交率%</td>
			<td>试驾数</td>
			<td>试驾率%</td>
			<td>试驾成交数</td>
			<td>试驾成交率%</td>
			<td>到店客户</td>
			<td>到店率</td>
			<td>到店成交客户</td>
			<td>到店成交率</td>
			<td>二次到店</td>
			<td>二次到店率%</td>
			<td>二次到店成交数</td>
			<td>二次到店成交率%</td>
			<td>回访总数</td>
			<td>回访频次</td>
			<td>超时次数</td>
			<td>超时率%</td>
		</tr>
	<c:set value="0" var="recordNumTotal"></c:set>
	<c:set value="0" var="flowNumTotal"></c:set>
	<c:set value="0" var="successNumTotal"></c:set>
	<c:set value="0" var="tryCarNumTotal"></c:set>
	<c:set value="0" var="tryCarSuccessNumTotal"></c:set>
	
	<c:set value="0" var="twoTimesShopNumTotal"></c:set>
	<c:set value="0" var="twoTimesShopSucessNumTotal"></c:set>
	<c:set value="0" var="comeShopNumTotal"></c:set>
	<c:set value="0" var="comeShopSucessNumTotal"></c:set>
	<c:set value="0" var="trackNumTotal"></c:set>
	<c:set value="0" var="trackOverTimeNumTotal"></c:set>
	<tbody>
	<c:forEach items="${staCustComps }" var="staCustComp" varStatus="i">
		<tr>
			<td >
				${i.index+1 }
			</td>
			<td>
				<a href="javascript:void(-1)" onclick="queryEnt('searchPageForm',${staCustComp.entId})">${staCustComp.entName }</a>
			</td>
			<td>
				<span style="color: red">${staCustComp.recordNum }</span>
				<c:set value="${recordNumTotal+staCustComp.recordNum }" var="recordNumTotal"></c:set>
			</td>
			<td>
				${staCustComp.flowNum }
				<c:set value="${flowNumTotal+staCustComp.flowNum }" var="flowNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.flowPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				<span style="color: red">${staCustComp.customerSuccessNum }</span>
				<c:set value="${successNumTotal+staCustComp.customerSuccessNum }" var="successNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.customerSuccessNum*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.tryCarNum }
				<c:set value="${tryCarNumTotal+staCustComp.tryCarNum }" var="tryCarNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.tryCarPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.tryCarSuccessNum }
				<c:set value="${tryCarSuccessNumTotal+staCustComp.tryCarSuccessNum }" var="tryCarSuccessNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.tryCarSucessPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.comeShopNum }
				<c:set value="${comeShopNumTotal+staCustComp.comeShopNum }" var="comeShopNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.comeShopPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.comeShopSucessNum }
				<c:set value="${comeShopSucessNumTotal+staCustComp.comeShopSucessNum }" var="comeShopSucessNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.comeShopSucessPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.twoTimesComeShopNum }
				<c:set value="${twoTimesShopNumTotal+staCustComp.twoTimesComeShopNum }" var="twoTimesShopNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.twoTimesComeShopPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.twoTimesComeShopSucessNum }
				<c:set value="${twoTimesShopSucessNumTotal+staCustComp.twoTimesComeShopSucessNum }" var="twoTimesShopSucessNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.twoTimesComeShopSucessPer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.trackNum }
				<c:set value="${trackNumTotal+staCustComp.trackNum }" var="trackNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.trackAva }" pattern="#0.00"></fmt:formatNumber>
			</td>
			<td>
				${staCustComp.trackOverTimeNum }
				<c:set value="${trackOverTimeNumTotal+staCustComp.trackOverTimeNum }" var="trackOverTimeNumTotal"></c:set>
			</td>
			<td>
				<fmt:formatNumber value="${staCustComp.trackOverTimePer*100 }" pattern="#0.00"></fmt:formatNumber>
			</td>
		</tr>
		</c:forEach> 
		 <tr>
			<td colspan="2">合计</td>
			<td>
				<span style="color: red">${recordNumTotal }</span>
			</td>
			<td>
				${flowNumTotal }
			</td>
			<td>
				<c:if test="${flowNumTotal==0 }">
					-
				</c:if>
				<c:if test="${flowNumTotal>0 }">
					<c:set value="${((flowNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${successNumTotal }</span>
			</td>
			<td>
				<c:if test="${successNumTotal==0 }">
					-
				</c:if>
				<c:if test="${successNumTotal>0 }">
					<c:set value="${((successNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<span style="color: red"><fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber></span>
				</c:if>
			</td>
			<td>
				${tryCarNumTotal }
			</td>
			<td>
				<c:if test="${tryCarNumTotal==0 }">
					-
				</c:if>
				<c:if test="${tryCarNumTotal>0 }">
					<c:set value="${((tryCarNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				${tryCarSuccessNumTotal }</span>
			</td>
			<td>
				<c:if test="${tryCarSuccessNumTotal==0 }">
					-
				</c:if>
				<c:if test="${tryCarSuccessNumTotal>0 }">
					<c:set value="${((tryCarSuccessNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${comeShopNumTotal }</span>
			</td>
			<td>
				<c:if test="${comeShopNumTotal==0 }">
					-
				</c:if>
				<c:if test="${comeShopNumTotal>0 }">
					<c:set value="${((comeShopNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${comeShopSucessNumTotal }</span>
			</td>
			<td>
				<c:if test="${comeShopSucessNumTotal==0 }">
					-
				</c:if>
				<c:if test="${comeShopSucessNumTotal>0 }">
					<c:set value="${((comeShopSucessNumTotal)/comeShopNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${twoTimesShopNumTotal }</span>
			</td>
			<td>
				<c:if test="${twoTimesShopNumTotal==0 }">
					-
				</c:if>
				<c:if test="${twoTimesShopNumTotal>0 }">
					<c:set value="${((twoTimesShopNumTotal)/recordNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${twoTimesShopSucessNumTotal }</span>
			</td>
			<td>
				<c:if test="${twoTimesShopNumTotal==0 }">
					-
				</c:if>
				<c:if test="${twoTimesShopNumTotal>0 }">
					<c:set value="${((twoTimesShopSucessNumTotal)/twoTimesShopNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${trackNumTotal }</span>
			</td>
			<td>
				<c:if test="${recordNumTotal==0 }">
					-
				</c:if>
				<c:if test="${recordNumTotal>0 }">
					<c:set value="${((trackNumTotal)/recordNumTotal) }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
			<td>
				<span style="color: red">${trackOverTimeNumTotal }</span>
			</td>
			<td>
				<c:if test="${trackNumTotal==0 }">
					-
				</c:if>
				<c:if test="${trackNumTotal>0 }">
					<c:set value="${((trackOverTimeNumTotal)/trackNumTotal)*100 }" var="hbPer"></c:set>
					<fmt:formatNumber value="${hbPer }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
			</td>
		</tr>
	</tbody>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="miao">集客统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="key" items="${keySet }">
			<td>${key+1 }月</td>
		</c:forEach>
	</tr>
	${customerStr}
</table>
<div id="container" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<br>
<!-- 客户到店统计开始   -->
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="comeShop">客户到店统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${comeShopCustomerStr }
</table>
<div id="comeShopData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="comeShopPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<!-- 客户到店统计结束   -->


<br>
<div class="frmTitle" onclick="showOrHiden('contactTable')">客户到店成交统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${comeShopSuccessCustomerStr }
</table>
<div id="comeShopSuccessData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="comeShopSuccessPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<br>

<!-- 客户二次到店统计开始   -->
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="twoComeShop">客户二次到店统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${twoComeShopCustomerStr }
</table>
<div id="twoComeShopData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="twoComeShopPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<!-- 客户二次到店统计结束   -->

<!-- 客户二次到店成交统计开始   -->
<div class="frmTitle" onclick="showOrHiden('contactTable')">客户二次到店成交统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${twoComeShopSuccessCustomerStr }
</table>
<div id="twoComeSuccessShopData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="twoComeSuccessShopPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<!-- 客户二次到店成交统计结束   -->

<!-- 试乘试驾 统计 开始   -->
<br>
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="tryCar">试乘试驾统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${tryCarCustomerStr }
</table>
<div id="tryCarCustomerData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="tryCarCustomerPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<!-- 试乘试驾 统计 结束   -->

<!-- 试乘试驾成交 统计 开始   -->
<br>
<div class="frmTitle" onclick="showOrHiden('contactTable')">试乘试驾统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${tryCarSuccessCustomerStr }
</table>
<div id="tryCarSuccessCustomerData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="tryCarSuccessCustomerPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<!-- 试乘试驾成交 统计 结束   -->

<div class="frmTitle" onclick="showOrHiden('contactTable')" id="successCustomer">客户成交统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${customerSuccessStr }
</table>
<div id="customerSuccessMonthData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="customerSuccessMonthPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<br>
<br>
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="customerFlow">客户流失统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${customerFlowStr }
</table>
<div id="customerFlowMonthData" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="customerFlowMonthPer" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<br>
<br>
<br>
<div class="frmTitle" onclick="showOrHiden('contactTable')" id="customerTrack">回访信息统计</div>
<table width="100%" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
	<tr>
		<td>项目</td>
		<c:forEach var="i"  begin="1" end="12">
			<td>${i}月</td>
		</c:forEach>
	</tr>
	${trackCustomerStr }
</table>
<div id="container7" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<div id="container8" style="min-width: 400px;min-height: 320px; margin-top: 12px;text-align: left;"></div>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
function queryEnt(searchFrm,entId){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx }/staCustComp/queryDepList?entId='+entId+'&'+params;
}
$(function () {
	  $('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '集客统计分析'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
		series: ${customerMonthData}
	});
	 $('#customerFlowMonthData').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '月度流失客户分析'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
		series: ${customerFlowMonthData}
	}); 
	$('#customerFlowMonthPer').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '月度流失率分析'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
		},
		yAxis: {
			title: {
				text: '百分比'
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
		series: ${customerFlowMonthPer}
	}); 
	 $('#customerSuccessMonthData').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '月成交客户分析'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
		series: ${customerSuccessMonthData}
	}); 
	$('#customerSuccessMonthPer').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '月度成交率分析'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
		},
		yAxis: {
			title: {
				text: '百分比'
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
		series: ${customerSuccessMonthPer}
	}); 
	   $('#comeShopData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '月到店客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${comeShopData}
		});
	  $('#comeShopPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '到店率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${comeShopPer}
		});
	   $('#comeShopSuccessData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '月度到店客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${comeShopSuccessData}
		});
	  $('#comeShopSuccessPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '到店客户成交率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${comeShopSuccessPer}
		});

	   $('#twoComeShopData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '月二次到店客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${twoComeShopData}
		});
	  $('#twoComeShopPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '二次到店率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${twoComeShopPer}
		});
	   $('#twoComeSuccessShopData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '月二次到店客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${twoComeShopSuccessData}
		});
	  $('#twoComeSuccessShopPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '二次到店率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${twoComeShopSuccessPer}
		});
	   $('#tryCarCustomerData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '试驾客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${tryCarCustomerData}
		});
	  $('#tryCarCustomerPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '试驾率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${tryCarCustomerPer}
		});
	   $('#tryCarSuccessCustomerData').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '试驾成交客户趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${tryCarSuccessCustomerData}
		});
	  $('#tryCarSuccessCustomerPer').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '试驾成交率月度趋势分析'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${tryCarSuccessCustomerPer}
		});
		
	  $('#container7').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '回访数据统计'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
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
			series: ${trackCustomerData}
		});
	  $('#container8').highcharts({
			chart: {
				type: 'line'
			},
			title: {
				text: '超时回访率'
			},
			subtitle: {
				text: ''
			},
			xAxis: {
				categories: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']
			},
			yAxis: {
				title: {
					text: '百分比'
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
			series: ${trackSuccessPer}
		}); 
});
</script>
</html>
