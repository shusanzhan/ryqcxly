<%@page import="org.apache.commons.lang.math.RandomUtils"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>展厅流量统计</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/utile/jsdateUtile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.staltalbe thead td{
		border-top: 1px solid #999;
		font-weight: bold;
		background-color: #cccccc;
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
	fieldset {
	    display: block;
	    margin-inline-start: 2px;
	    margin-inline-end: 2px;
	    padding-block-start: 0.35em;
	    padding-inline-start: 0.75em;
	    padding-inline-end: 0.75em;
	    padding-block-end: 0.625em;
	    min-inline-size: min-content;
	    border-width: 2px;
	    border-style: groove;
	    border-color: threedface;
	    border-image: initial;
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
	  .totalTr{
	  	font-weight: bold;background-color: #FF5722;color: white;
	  }   
}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">展厅流量统计</a>-
	<a href="javascript:void(-1);" onclick="">月统计</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate" style="color: #000;">
		<a href="javascript:void(-1)"  onclick="window.location.href='${ctx}/statCustomerRecord/queryReceptionStatYear'" style="color: #2b7dbc;">展厅流量年统计</a>
		|
		<a href="javascript:void(-1)"  onclick="window.history.go(-1)" style="color: #2b7dbc;">返回</a>
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/statCustomerRecord/queryReceptionStat" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>来源类型：</label></td>
  				<td colspan="">
  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
						<option value="1" ${type==1?'selected="selected"':'' } >来店</option>
						<option value="2" ${type==2?'selected="selected"':'' } >来电</option>
					</select>
  				</td>
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
  <legend>${type==1?"来店":"来电"}时间段统计</legend>
</fieldset>
<p style="color: red;">合计：所有来店数据</p>
<p style="color: red;">展厅来店：展厅来店看车客户</p>
<p style="color: red;">网销来店：网销来店看车客户</p>
<p style="color: red;">二次来店：包含网销、展厅二次来店数据</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td style="width: 80px">日期</td>
			<td>8:00-9:00</td>
			<td>9:00-10:00</td>
			<td>10:00-11:00</td>
			<td>11:00-12:00</td>
			<td>12:00-13:00</td>
			<td>13:00-14:00</td>
			<td>14:00-15:00</td>
			<td>15:00-16:00</td>
			<td>16:00-17:00</td>
			<td>17:00-18:00</td>
			<td>18:00<&nbsp; </td>
			<td style="width: 60px;"> 合计 </td>
			<c:if test="${type==1 }">
				<td style="width: 60px;"> 展厅来店 </td>
				<td style="width: 60px;"> 网销来店 </td>
				<td style="width: 60px;"> 二次来店</td>
			</c:if>
		</tr>
	</thead>
	<c:if test="${fn:length(statCustomerRecordTimes)>15}" var="lengthStatus"></c:if>
	<c:if test="${lengthStatus==true }">
		<tr style="font-weight: bold;background-color: #FF5722;color: white;">
			<td colspan="2">
				合计
			</td>
			<td>${totalStatCustomerRecordTime.eightNum}</td>	
			<td>${totalStatCustomerRecordTime.nineNum}</td>	
			<td>${totalStatCustomerRecordTime.tenNum}</td>	
			<td>${totalStatCustomerRecordTime.elevenNum}</td>	
			<td>${totalStatCustomerRecordTime.twelveNum}</td>	
			<td>${totalStatCustomerRecordTime.thirteenNum}</td>	
			<td>${totalStatCustomerRecordTime.fourteenNum}</td>	
			<td>${totalStatCustomerRecordTime.fifteenNum}</td>	
			<td>${totalStatCustomerRecordTime.sixteenNum}</td>	
			<td>${totalStatCustomerRecordTime.seventeenNum}</td>	
			<td>${totalStatCustomerRecordTime.eighteenNUm}</td>	
			<td>${totalStatCustomerRecordTime.totalNum}</td>
			<c:if test="${type==1 }">	
				<td>${totalStatCustomerRecordTime.roomNum}</td>	
				<td>${totalStatCustomerRecordTime.netNum}</td>	
				<td>${totalStatCustomerRecordTime.twoNum}</td>
			</c:if>	
		</tr>
	</c:if>
	<c:forEach items="${statCustomerRecordTimes }" var="statCustomerRecordTime" varStatus="i">
		<tr>
			<td>
				${i.index+1 }
			</td>
			<td>
				<fmt:formatDate value="${statCustomerRecordTime.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>${statCustomerRecordTime.eightNum}</td>	
			<td>${statCustomerRecordTime.nineNum}</td>	
			<td>${statCustomerRecordTime.tenNum}</td>	
			<td>${statCustomerRecordTime.elevenNum}</td>	
			<td>${statCustomerRecordTime.twelveNum}</td>	
			<td>${statCustomerRecordTime.thirteenNum}</td>	
			<td>${statCustomerRecordTime.fourteenNum}</td>	
			<td>${statCustomerRecordTime.fifteenNum}</td>	
			<td>${statCustomerRecordTime.sixteenNum}</td>	
			<td>${statCustomerRecordTime.seventeenNum}</td>	
			<td>${statCustomerRecordTime.eighteenNUm}</td>	
			<td>${statCustomerRecordTime.totalNum}</td>	
			<c:if test="${type==1 }">
				<td>${statCustomerRecordTime.roomNum}</td>	
				<td>${statCustomerRecordTime.netNum}</td>	
				<td>${statCustomerRecordTime.twoNum}</td>
			</c:if>	
		</tr>
	</c:forEach>
	<c:if test="${lengthStatus==false }">
		<tr style="font-weight: bold;background-color: #FF5722;color: white;">
			<td colspan="2">
				合计
			</td>
			<td>${totalStatCustomerRecordTime.eightNum}</td>	
			<td>${totalStatCustomerRecordTime.nineNum}</td>	
			<td>${totalStatCustomerRecordTime.tenNum}</td>	
			<td>${totalStatCustomerRecordTime.elevenNum}</td>	
			<td>${totalStatCustomerRecordTime.twelveNum}</td>	
			<td>${totalStatCustomerRecordTime.thirteenNum}</td>	
			<td>${totalStatCustomerRecordTime.fourteenNum}</td>	
			<td>${totalStatCustomerRecordTime.fifteenNum}</td>	
			<td>${totalStatCustomerRecordTime.sixteenNum}</td>	
			<td>${totalStatCustomerRecordTime.seventeenNum}</td>	
			<td>${totalStatCustomerRecordTime.eighteenNUm}</td>	
			<td>${totalStatCustomerRecordTime.totalNum}</td>
			<c:if test="${type==1 }">	
				<td>${totalStatCustomerRecordTime.roomNum}</td>	
				<td>${totalStatCustomerRecordTime.netNum}</td>	
				<td>${totalStatCustomerRecordTime.twoNum}</td>
			</c:if>	
		</tr>
	</c:if>
</table>
<br>
<div class="hightChat">
	<div id="container" style="width: 49%;float: left;"></div>
	<div id="container1" style="width: 49%;float: right;"></div>
	<div style="clear: both;"></div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>${type==1?"来店":"来电"}目的统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>日期</td>
			<c:forEach var="customerRecordTarget" items="${customerRecordTargets }">
				<td>${customerRecordTarget.name }</td>
			</c:forEach>
			<td style="width: 60px;"> 合计 </td>
		</tr>
	</thead>
	<c:if test="${lengthStatus==true }">
		<tr class="totalTr">
			<td colspan="2">合计</td>
			<c:forEach var="customerRecordTargetSta" items="${customerRecordTargetAlls }">
				<td>${customerRecordTargetSta.totalNum }</td>
			</c:forEach>
			<td>${totalStatCustomerRecordTime.totalNum}</td>	
		</tr>
	</c:if>
	<c:forEach items="${map }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
		<tr>
			<td>${i.index+1 }</td>
			<td><fmt:formatDate value="${key.createDate}" pattern="yyyy-MM-dd"/> </td>
			<c:forEach var="customerRecordTargetSta" items="${value }">
				<td>${customerRecordTargetSta.totalNum }</td>
			</c:forEach>
			<td>${key.totalNum}</td>	
		</tr>
	</c:forEach>
	<c:if test="${lengthStatus==false }">
		<tr>
			<td colspan="2">合计</td>
			<c:forEach var="customerRecordTargetSta" items="${customerRecordTargetAlls }">
				<td>${customerRecordTargetSta.totalNum }</td>
			</c:forEach>
			<td>${totalStatCustomerRecordTime.totalNum}</td>	
		</tr>
	</c:if>
</table>
<br>
<br>
<div class="hightChat">
	<div id="container2" style="width: 100%;"></div>
</div>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>${type==1?"来店":"来电"}看车车型统计</legend>
</fieldset>
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
	<c:if test="${lengthStatus==true }">
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
	</c:if>
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
	<c:if test="${lengthStatus==false }">
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
	</c:if>
</table>
<br>
<div class="hightChat">
	<div id="container3" style="width: 100%;"></div>
</div>
<br>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>${type==1?"来店":"来电"}销售顾问接待客户以及看车车型统计</legend>
</fieldset>
<p style="color: red;">	总登记：前台登记+销售登记;首次进店：总登记-转到店登记;建档率：	建档客户/首次进店*100</p>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td rowspan="2">序号</td>
			<td rowspan="2">业务员</td>
			<td colspan="3">登记线索</td>
			<td colspan="3">接待结果</td>
			<td colspan="3">建档率</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td rowspan="2">${carSeriy.name }</td>
			</c:forEach>
			<td style="width: 60px;" rowspan="2"> 合计 </td>
		</tr>
		<tr>
			<td>前台登记</td>
			<td>销售登记</td>
			<td>总登记</td>
			<td>未处理</td>
			<td>转到店登记</td>
			<td>无效线索</td>
			<td>首次进店</td>
			<td>建档客户</td>
			<td rowspan="2">建档率</td>
		</tr>
	</thead>
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
						<fmt:formatNumber value="${key.creatorFolderPer }" pattern="#0.00"></fmt:formatNumber>% 
					</c:if>
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
				<td>${key.creatorFolderNum}</td>	
			</tr>
		</c:if>
	</c:forEach>
	<tr class="totalTr">
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
		<c:set value="0" var="countNum"></c:set>
		<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
			<td>${carSerCountTotal.countNum }</td>
			<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
		</c:forEach>
		<td>${customerRecordUserTotal.creatorFolderNum}</td>	
	</tr>
</table>
<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>前台线索同比/环比统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
	<br>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  <legend>前台留资率同比/环比统计</legend>
</fieldset>
<table class="staltalbe" style="width: 100%;" cellpadding="0" cellspacing="0">
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
	<br>
	<br>
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
			type: 'column'
		},
		title: {
			text: '${type==1?"来店":"来电"}关注车型'
		},
		subtitle: {
			text: ''
		},
		xAxis: {
			categories: [${receptionCarSerTitle}]
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
		series:${receptionCarSerData}
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
