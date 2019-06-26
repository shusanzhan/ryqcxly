<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>存销比统计</title>
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
		border: 0px;margin: 0 auto;font-family: '微软雅黑';font-size: 11px;
	}
	.staltalbe td{
		border-bottom: 1px solid #999;border-right: 1px solid #999;text-align: center;line-height: 24px;
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
	<a href="javascript:void(-1);" onclick="">存销比统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a href="javascript:void(-1)"  onclick="exportExcel('searchPageForm')" style="color: #2b7dbc;">导出excel</a>  
		|
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a>  
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/wlbOrderFactRef/queryWlbOrderFactRef" method="post" >
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  				<c:if test="${fn:length(enterprises)>1 }">
	  				<tr>
		  				<td ><label>分公司：</label></td>
		  				<td colspan="4">
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
 				<td><label>车型：</label></td>
  					<td >
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<c:forEach var="carSeriy" items="${carSeriys }">
	  						<option value="${carSeriy.dbid }" ${carSeriy.dbid==param.carSeriyId?'selected="selected"':'' }>${carSeriy.name }</option>
  						</c:forEach>
					</select>
  				</td>
				<td><label>登记时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,dateFmt:'yyyy-MM'})" value="${beginDate }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,dateFmt:'yyyy-MM'})" value="${endDate }">
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
<h3>车型存销比明细</h3>
<p style="color: red;"><span style="color: red;font-weight: bold;">说明：查询最近【${intervalMonth}】月的存销比</span></p>
<c:set value="${fn:length(titleCarColors)*175+430 }" var="width"></c:set>
<table class="staltalbe" style="width: ${width}px; " cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 320px;" colspan="6"></td>
			<c:forEach var="refCarColor" items="${titleCarColors }">
				<td style="width: 200px" colspan="5">${refCarColor.carColorName }</td>
			</c:forEach>
		</tr>
		<tr>
			<td style="width: 50px;">系列</td>
			<td style="width: 180px;">车型</td>
			<td style="width: 50px;">销汇总</td>
			<td style="width: 50px;">销占比</td>
			<td style="width: 50px;">库汇总</td>
			<td style="width: 50px;">库占比</td>
			<c:forEach var="refCarColor" items="${titleCarColors }">
				<td style="width: 35px">销</td>
				<td style="width: 35px">月均</td>
				<td style="width: 35px">留</td>
				<td style="width: 35px">存比</td>
				<td style="width: 35px">汇总</td>
			</c:forEach>
		</tr>
	</thead>
	<c:forEach items="${mapRefCarColors }" var="mapRefCarColor" varStatus="i">
		<c:set var="refCarSeriy" value="${mapRefCarColor.key }"></c:set>
		<c:set var="mapRefCarModels" value="${mapRefCarColor.value }"></c:set>
		<c:forEach items="${mapRefCarModels }" var="mapRefCarModel" varStatus="mapRefCarModelIndex">
			<tr>
				<c:set value="${mapRefCarModel.key }" var="refCarModel"></c:set>
				<c:set value="${mapRefCarModel.value }" var="refCarColors"></c:set>
				<c:if test="${mapRefCarModelIndex.index==0 }">
					<td rowspan="${fn:length(mapRefCarModels) }">
						${refCarSeriy.name }
					</td>
				</c:if>
				<td style="font-size: 8px;">${refCarModel.name }</td>
				<td>${refCarModel.saleNum }</td>
				<td style="color: red;">
					<c:if test="${refCarSeriy.saleNum>0 }" var="status">
						<fmt:formatNumber value="${refCarModel.saleNum/refCarSeriy.saleNum*100 }" pattern="#0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.0
					</c:if>
				</td>
				<td>${refCarModel.stormNum }</td>
				<td style="color: red;">
					<c:if test="${refCarSeriy.stormNum>0 }" var="status">
						<fmt:formatNumber value="${refCarModel.stormNum/refCarSeriy.stormNum*100 }" pattern="#0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.0
					</c:if>
				</td>
				<c:forEach var="refCarColor" items="${refCarColors }">
					<td>
						${refCarColor.saleNum }
					</td>
					<td>
						<fmt:formatNumber value="${refCarColor.saleNumPer }" pattern="0.00"></fmt:formatNumber> 
					</td>
					<td>
						${refCarColor.stormNum }
					</td>
					<td>
						<fmt:formatNumber value="${refCarColor.stormNumPer }" pattern="0.00"></fmt:formatNumber> 
					</td>
					<td>
						${refCarColor.totalNum }
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr style="color: red;font-weight:bold;">
			<td colspan="2">汇总</td>
			<td>${refCarSeriy.saleNum }</td>
			<td>
				${refCarSeriy.stormNum }
			</td>
			<td>${refCarSeriy.stormNum }</td>
			<td>${refCarSeriy.stormNum }</td>
			<c:forEach var="mapRefCarSeriyCarColor" items="${mapRefCarSeriyCarColors }">
				<c:set value="${mapRefCarSeriyCarColor.key }" var="refCarSeriyCarColor"></c:set>
				<c:if test="${refCarSeriy.dbid==refCarSeriyCarColor.dbid }">
					<c:set value="${mapRefCarSeriyCarColor.value }" var="refCarColors"></c:set>
					<c:forEach var="refCarColor" items="${refCarColors }">
						<td>
							${refCarColor.saleNum }
						</td>
						<td>
							<fmt:formatNumber value="${refCarColor.saleNumPer }" pattern="0.00"></fmt:formatNumber> 
						</td>
						<td>
							${refCarColor.stormNum }
						</td>
						<td>
							<fmt:formatNumber value="${refCarColor.stormNumPer }" pattern="0.00"></fmt:formatNumber> 
						</td>
						<td>
							${refCarColor.totalNum }
						</td>
					</c:forEach>
				</c:if>
			</c:forEach>
		</tr>
	</c:forEach>
</table>
<h3>车系存销比</h3>
<table class="staltalbe" style="width:px; " cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 50px;">系列</td>
			<td style="width: 50px;">销汇总</td>
			<td style="width: 50px;">销占比</td>
			<td style="width: 50px;">月均</td>
			<td style="width: 50px;">库汇总</td>
			<td style="width: 50px;">库占比</td>
			<td style="width: 50px;">存比</td>
		</tr>
	</thead>
	<c:forEach var="refCarSeriyAll" items="${refCarSeriyAlls }">
		<tr>
			<td>
				${refCarSeriyAll.name }
			</td>
			<td>
				${refCarSeriyAll.saleNum }
			</td>
			<td style="color: red;">
				<c:if test="${refCarSeriyAllTotal.saleNum>0 }" var="status">
					<fmt:formatNumber value="${refCarSeriyAll.saleNum/refCarSeriyAllTotal.saleNum*100 }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
				<c:if test="${status==false }">
					0.0
				</c:if>
			</td>
			<td>
				<fmt:formatNumber value="${refCarSeriyAll.saleNumPer }" pattern="0.00"></fmt:formatNumber> 
			</td>
			<td>
				${refCarSeriyAll.stormNum }
			</td>
			<td style="color: red;">
				<c:if test="${refCarSeriyAllTotal.stormNum>0 }" var="status">
					<fmt:formatNumber value="${refCarSeriyAll.stormNum/refCarSeriyAllTotal.stormNum*100 }" pattern="#0.00"></fmt:formatNumber>
				</c:if>
				<c:if test="${status==false }">
					0.0
				</c:if>
			</td>
			<td>
				<fmt:formatNumber value="${refCarSeriyAll.stormNumPer }" pattern="0.00"></fmt:formatNumber> 
			</td>
		</tr>
	</c:forEach>
	<tr style="color: red;font-weight: bold;">
			<td>
				合计
			</td>
			<td>
				${refCarSeriyAllTotal.saleNum }
			</td>
			<td>
				100%
			</td>
			<td>
				<fmt:formatNumber value="${refCarSeriyAllTotal.saleNumPer }" pattern="0.00"></fmt:formatNumber> 
			</td>
			<td>
				${refCarSeriyAllTotal.stormNum }
			</td>
			<td>
				100%
			</td>
			<td>
				<fmt:formatNumber value="${refCarSeriyAllTotal.stormNumPer }" pattern="0.00"></fmt:formatNumber> 
			</td>
	</tr>
</table>
<br>
<div id="container" style="width: 100%;height: 300px;">
	
</div>
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
$(function () {
	$('#container').highcharts({
		chart: {
			type: 'column'
		},
		title: {
			text: '${beginDate }至${endDate}存销比统计'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${carseriyTitle}]
		},
		yAxis: {
			title: {
				text: ' 台数'
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
		series:[${data}]
	});
})
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/wlbOrderFactRef/exportExcel?'+params;
}
</script>
</body>

</html>
