<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>同城交叉客户</title>
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
	<a href="javascript:void(-1);" onclick="">基盘客户统计分析</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a>  
   </div>
   
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/cityCross/queryCityCrossCount" method="post" >
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
   				<td colspan="5" style="text-align: center;"><div  onclick="$('#searchPageForm')[0].submit()"  class="buttonSerach">查询</div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		客户级别-车型统计明细
	</h5>
</div>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead style="">
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 40px;">级别</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 80px">${carSeriy.name }</td>
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
</div>
</div>
<div class="hightChat">
	<div id="pieCustPhaseData" style="width: 48%;float: left;padding-right: 12px;"></div>
	<div id="pieCustCarData" style="width: 48%;float: left"></div>
	<div style="clear: both;"></div>
</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问-车型统计明细
	</h5>
</div>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead style="">
				<tr>
					<td style="width: 40px;">序号</td>
					<td style="width: 40px;">销售顾问</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 80px">${carSeriy.name }</td>
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
</div>
</div>
<div class="hightChat">
	<div id="pieCustUserData" style="float: left;padding-right: 12px;"></div>
	<div style="clear: both;"></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		销售顾问-客户级别-车型统计明细
	</h5>
</div>
<div class="tab-content" >
	<div class="tab-pane active" id="baseInfo" >
		<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
			<thead style="">
				<tr>
					<td style="width: 40px;">级别</td>
					<td style="width: 40px;">数量</td>
					<c:forEach items="${carSeriys }" var="carSeriy">
						<td style="width: 80px">${carSeriy.name }</td>
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
						<td>${custPhase.name }</td>
						<td>${custPhase.totalNum }</td>
						<c:forEach var="carCount" items="${map.value }">
							<td>${carCount.countNum }</td>
						</c:forEach>
					</tr>
				</c:forEach>
				<tr style="font-weight: bold;" class="totalTr">
					<td colspan="" >
						合计：
					</td>
					<td colspan="" >
						${custUser.totalNum }
					</td>
					<c:forEach items="${mapUserCarSerCounts }" var="mapUserCarSerCount">
						<c:if test="${custUser.bussiStaffId==mapUserCarSerCount.key.bussiStaffId }">
							<c:forEach var="carCount" items="${mapUserCarSerCount.value }">
								<td>${carCount.countNum }</td>
							</c:forEach>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
		<br>
</div>
</div>
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
</script>
</body>

</html>
