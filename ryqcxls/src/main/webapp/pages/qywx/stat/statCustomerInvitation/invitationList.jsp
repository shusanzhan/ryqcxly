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
<title>网销邀约（月）统计</title>
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
    <span id="page_title">网销邀约（月）统计</span>
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
           <li class="detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxStatCustomerInvitation/queryInvitationList'">月统计</li>
           <li class="detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxStatCustomerInvitation/queryInvitationYearList'">年统计</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		网销有效线索（日）明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">日期</td>
				<c:forEach items="${customerInfromStaSets }" var="customerInfromStaSet">
					<td style="width: 60px;">${customerInfromStaSet.alias}</td>
				</c:forEach>
				<td style="width: 40px;"> 合计 </td>
			</tr>
			<c:if test="${fn:length(mapCustomerInfromStaSets)>15 }" var="lengthStatus"></c:if>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" id="totalTr">
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
				<tr style="font-weight: bold;" id="totalTr">
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
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container" style=""></div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		网销邀约到店（日）明细
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td style="width: 40px;">序号</td>
				<td style="width: 80px">日期</td>
				<c:forEach items="${customerInfromStaSets }" var="customerInfromStaSet">
					<td style="width: 60px;">${customerInfromStaSet.alias}</td>
				</c:forEach>
				<td style="width: 40px;"> 合计 </td>
			</tr>
			<c:if test="${lengthStatus==true }">
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${customerInfromStaSetCustomerInvitationTotals }" var="customerInfromStaSet">
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
			<c:forEach items="${mapCustomerInfromStaSetCustomerInvitations }" var="map" varStatus="i">
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
				<tr style="font-weight: bold;" id="totalTr">
					<td colspan="2">
						合计
					</td>
					<c:set value="0" var="setTotal"></c:set>
					<c:forEach items="${customerInfromStaSetCustomerInvitationTotals }" var="customerInfromStaSet">
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
		</tbody>
	</table>
	<div class="hightChat">
		<div id="container1" style=""></div>
	</div>
</div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		当月潜客各平台邀约到店率(当月创建线索)
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
					<td>序号</td>
					<td>平台</td>
					<td>当月潜客</td>
					<td>邀约到店客户</td>
					<td>邀约率</td>
				</tr>
			<c:set value="0" var="sTotalNum"></c:set>
			<c:set value="0" var="sEffTotalNum"></c:set>
			<c:forEach items="${mapCarSerCounts }" var="map" varStatus="i">
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
				</tr>
			</c:forEach>
			<tr>
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
			</tr>
		</tbody>
	</table>
	<div class="hightChat">
		<div id="pieCustomerInfromStaSet"></div>
	</div>
	<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
		<h5 style="text-align: left;font-size: 16px">
			当月潜客各平台邀约到店车型统计
		</h5>
	</div>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
					<td style="width: 30px;">序号</td>
					<td style="width: 60px;">平台</td>
					<td style="width: 30px;">到店量</td>
					<c:forEach var="carSeriy" items="${carSeriys }">
						<td style="width: 30px;">${carSeriy.name }</td>
					</c:forEach>
				</tr>
			<c:set value="0" var="sTotalNum"></c:set>
			<c:set value="0" var="sEffTotalNum"></c:set>
			<c:forEach items="${mapCarSerCounts }" var="map" varStatus="i">
				<c:set var="key" value="${map.key }"></c:set>
				<c:set var="value" value="${map.value }"></c:set>
				<tr>
					<td>${i.index+1 }</td>
					<td>${key.alias } </td>
					<td>
						${key.effTotalNum } 
						<c:set value="${sEffTotalNum+key.effTotalNum }" var="sEffTotalNum"></c:set>
					</td>
					<c:forEach var="carSerCount" items="${value }">
						<td>${carSerCount.countNum }  </td>
					</c:forEach>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="2">合计</td>
				<td>
					${sEffTotalNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
			</tr>
			<tr>
				<td colspan="3">占比</td>
				<c:forEach var="carSerCountTotal" items="${carSerCountTotals }">
					<td>
						<c:if test="${countNum>0 }">
							<fmt:formatNumber value="${carSerCountTotal.countNum/sEffTotalNum*100}" pattern="#0.00"></fmt:formatNumber>
						</c:if>
						<c:if test="${countNum<=0 }">
							0.0
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="pieCustomerInfromComeShopStaSet" ></div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		总潜客邀约到店率(含历史线索)
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
			<td style="width: 30px">序号</td>
			<td style="width: 60px">平台</td>
			<td style="width: 30px">留存</td>
			<td style="width: 30px">新增</td>
			<td style="width: 40px">总潜客</td>
			<td style="width: 50px">到店客户</td>
			<td style="width: 40px">邀约率</td>
		</tr>
		<c:set value="0" var="sKeepNum"></c:set>
		<c:set value="0" var="sAddNum"></c:set>
		<c:set value="0" var="sTotalNum"></c:set>
		<c:set value="0" var="sEffTotalNum"></c:set>
		<c:forEach items="${mapInvitationSummaryAll }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>${i.index+1 }</td>
				<td>${key.alias } </td>
				<td>
					${key.keepNum }
					<c:set value="${sKeepNum+key.keepNum }" var="sKeepNum"></c:set>
				</td>
				<td>
					${key.addNum }
					<c:set value="${sAddNum+key.addNum }" var="sAddNum"></c:set>
				</td>
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
			</tr>
		</c:forEach>
		<tr>
			<td colspan="2">合计</td>
			<td>
				${sKeepNum }
			</td>
			<td>
				${sAddNum }
			</td>
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
		</tr>
		</tbody>
	</table>
	<br>
	<div class="hightChat">
		<div id="pieCustomerInfromStaSetAll" ></div>
	</div>
	<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
		<h5 style="text-align: left;font-size: 16px">
			总潜客各平台邀约到店车型统计
		</h5>
	</div>
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
			<td style="width: 30px;">序号</td>
			<td style="width: 60px;">平台</td>
			<td style="width: 40px;">到店客户</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td style="width: 30px;">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		<c:set value="0" var="sKeepNum"></c:set>
		<c:set value="0" var="sAddNum"></c:set>
		<c:set value="0" var="sTotalNum"></c:set>
		<c:set value="0" var="sEffTotalNum"></c:set>
		<c:forEach items="${mapInvitationSummaryAll }" var="map" varStatus="i">
			<c:set var="key" value="${map.key }"></c:set>
			<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>${i.index+1 }</td>
				<td>${key.alias } </td>
				<td>
					${key.effTotalNum } 
					<c:set value="${sEffTotalNum+key.effTotalNum }" var="sEffTotalNum"></c:set>
				</td>
				<c:forEach var="carSerCount" items="${value }">
					<td>${carSerCount.countNum }  </td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="2">合计</td>
			<td>
				${sEffTotalNum }
			</td>
			<c:set value="0" var="countNum"></c:set>
			<c:forEach var="carSerCountTotal" items="${carSerCountInvitationSummaryAllTotals }">
				<td>${carSerCountTotal.countNum }</td>
				<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
			</c:forEach>
		</tr>
		<tr>
			<td colspan="3">占比</td>
			<c:forEach var="carSerCountTotal" items="${carSerCountInvitationSummaryAllTotals }">
				<td>
					<c:if test="${countNum>0 }">
						<fmt:formatNumber value="${carSerCountTotal.countNum/sEffTotalNum*100}" pattern="#0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${countNum<=0 }">
						0.0
					</c:if>
				</td>
			</c:forEach>
		</tr>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="pieCustomerInfromComeShopStaSetAll" ></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		网销邀约到店关注车型
	</h5>
</div>
平台选择：
<select id="customerInfromSetDbid" name=customerInfromSetDbid class="form-control" onchange="ajaxCarCount()">
	<option value="-1">请选择...</option>
	<c:forEach var="customerInfromStaSet" items="${customerInfromStaSets }">
		<option value="${customerInfromStaSet.dbid }">${customerInfromStaSet.alias }</option>
	</c:forEach>
</select>
<br>
<div id="carCountId" class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
			<tr>
				<td style="width: 30px">序号</td>
				<td style="width: 80px">车型</td>
				<td style="width: 60px;">数量</td>
				<td style="width: 60px;">占比%</td>
			</tr>
				<c:forEach var="carSerCountTotal" items="${carSerCountTotals }" varStatus="i">
					<tr>
						<td>
							${i.index+1 }
						</td>
						<td>${carSerCountTotal.name }</td>
						<td>${carSerCountTotal.countNum }</td>
						<td>
							<c:if test="${countNum>0 }">
								<fmt:formatNumber value="${carSerCountTotal.countNum/countNum*100}" pattern="#0.00"></fmt:formatNumber>
							</c:if>
							<c:if test="${countNum<=0 }">
								0.0
							</c:if>
						</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="container3" style="width: 100%;"></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		当月潜客各销售顾问邀约到店率统计（当月创建线索邀约到店）
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<td style="width: 30px">序号</td>
			<td style="width: 60px">业务员</td>
			<td style="width: 60px">创建潜客</td>
			<td style="width: 60px">到店</td>
			<td style="width: 60px">邀约率</td>
		</tr>
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
		</tr>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="pieUserMonth"></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		当月潜客邀约到店车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<tr>
			<td style="width: 30px">序号</td>
			<td style="width: 60px">业务员</td>
			<td  style="width: 40px">到店客户</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td  style="width: 40px">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		<c:forEach items="${mapUsers }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
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
	</c:forEach>
		<tr>
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
<div class="hightChat">
	<div id="pieUserMonthComeShop" ></div>
</div>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		总潜客邀约到店率统计（含历史线索邀约到店）
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<td style="width: 30px">序号</td>
			<td style="width: 30px">业务员</td>
			<td style="width: 30px">留存</td>
			<td style="width: 30px">新增</td>
			<td style="width: 30px">总潜客</td>
			<td style="width: 40px">到店客户</td>
			<td style="width: 30px">邀约率</td>
		</tr>
		<c:forEach items="${mapUsersAll }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
			<tr>
				<td>${i.index+1 }</td>
				<td>
					${key.realName }
				</td>
				<td>
					${key.keepNum }
					<c:set value="${sKeepNum+key.keepNum }" var="sKeepNum"></c:set>
				</td>
				<td>
					${key.addNum }
					<c:set value="${sAddNum+key.addNum }" var="sAddNum"></c:set>
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
			</tr>
		</c:forEach>
		<tr>
			<td colspan="2">合计</td>
				<td>
				${customerRecordUserTotalAll.keepNum }
			</td>
			<td>
				${customerRecordUserTotalAll.addNum }
			</td>
			<td>
				${customerRecordUserTotalAll.totalNum }
			</td>
			<td>
				${customerRecordUserTotalAll.creatorFolderNum }
			</td>
			<td>
				<c:if test="${!empty(customerRecordUserTotalAll.creatorFolderPer)}" var="status">
					<fmt:formatNumber value="${customerRecordUserTotalAll.creatorFolderPer }" pattern="#0.00"></fmt:formatNumber>% 
				</c:if>
				<c:if test="${status==false }">
					0.00
				</c:if>
			</td>
		</tr>
		</tbody>
	</table>
</div>
<br>
<div class="hightChat">
	<div id="pieUserMonthAll" ></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		总潜客邀约到店车型统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped" style="font-size: 10px;">
		<tbody>
		<tr>
			<tr>
			<td style="width: 30px">序号</td>
			<td style="width: 60px">业务员</td>
			<td  style="width: 40px">到店客户</td>
			<c:forEach var="carSeriy" items="${carSeriys }">
				<td  style="width: 40px">${carSeriy.name }</td>
			</c:forEach>
		</tr>
		<c:forEach items="${mapUsersAll }" var="map" varStatus="i">
		<c:set var="key" value="${map.key }"></c:set>
		<c:set var="value" value="${map.value }"></c:set>
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
	</c:forEach>
		<tr>
			<td colspan="2">合计</td>
				<td>
					${customerRecordUserTotalAll.creatorFolderNum }
				</td>
				<c:set value="0" var="countNum"></c:set>
				<c:forEach var="carSerCountTotal" items="${carSerCountInvitationSummaryAllTotals }">
					<td>${carSerCountTotal.countNum }</td>
					<c:set value="${countNum+carSerCountTotal.countNum  }" var="countNum"></c:set>
				</c:forEach>
		</tr>
		</tbody>
	</table>
</div>
<div class="hightChat">
	<div id="pieUserMonthAllComeShop"></div>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">当月潜客数据同比环比</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerShopYearByYearChain.nowDate }</td>
			<td>${fristCustomerShopYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerShopYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${customerShopInfromYearByYearChainTotals}" varStatus="i">
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">当月潜客邀约数据同比环比</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerShopYearByYearChain.nowDate }</td>
			<td>${fristCustomerShopYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerShopYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${customerShopInfromYearByYearMonthChains}" varStatus="i">
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">总潜客邀约数据同比环比</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerShopYearByYearChain.nowDate }</td>
			<td>${fristCustomerShopYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerShopYearByYearChain.yearByYearDate }</td>
			<td>同比</td>
		</tr>
	</thead>
	<c:forEach var="customerRecordInfromYearByYear" items="${customerShopeInfromYearByYearMonthAllChains}" varStatus="i">
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">当月潜客邀约率同比环比</h5>
</div>
<table class="table table-bordered table-striped" style="width: 100%;" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td>序号</td>
			<td>网销平台</td>
			<td>${fristCustomerShopYearByYearChain.nowDate }</td>
			<td>${fristCustomerShopYearByYearChain.preDate }</td>
			<td>环比</td>
			<td>${fristCustomerShopYearByYearChain.yearByYearDate }</td>
			<td >同比</td>
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
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxStatCustomerInvitation/queryInvitationList" name="searchPageForm" id="searchPageForm" method="post">
      	 <table>
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
</body>
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
	$('#container').highcharts({
		chart: {
			type: 'line'
		},
		title: {
			text: '日网销潜客趋势图'
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
			text: '日网销邀约到店趋势图'
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
	$('#pieCustomerInfromStaSet').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '当月潜客各平台占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieCustomerInfromStaSet}
		}]
	});
	$('#pieCustomerInfromComeShopStaSet').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '当月潜客各平台邀约占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieCustomerInfromComeShopStaSet}
		}]
	});
	$('#pieCustomerInfromStaSetAll').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '总潜客各平台占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieCustomerInfromStaSetAll}
		}]
	});
	$('#pieCustomerInfromComeShopStaSetAll').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '总潜客各平台邀约占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieCustomerInfromComeShopStaSetAll}
		}]
	});
	$('#pieUserMonth').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '当月潜客各销售顾问占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieUserMonth}
		}]
	});
	$('#pieUserMonthComeShop').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '当月潜客各销售顾问邀约占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieUserMonthComeShop}
		}]
	});
	$('#pieUserMonthAll').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '总潜客各销售顾问占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieUserMonthAll}
		}]
	});
	$('#pieUserMonthAllComeShop').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '总潜客各销售顾问邀约占比'
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
			name: '平台',
			colorByPoint: true,
			data: ${pieUserMonthAllComeShop}
		}]
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
	$.post("${ctx}/qywxStatCustomerInvitation/ajaxCarCount?customerInfromSetDbid="+customerInfromSetDbid+"&dateType=1",params,function(data){
		if(data=="error"){
			alert("查询出错！");
		}else{
			var obj=data.split("|");
			$("#carCountId").text("");
			$("#carCountId").append(obj[0]);
			chart3(obj[1]);
		}
	}) 
}
function chart3(data){
	data=eval("("+data+")");
	chartB=new Highcharts.Chart({
		chart: {
			renderTo: 'container3',
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '网销邀约到店关注车型'
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
			data: data
		}]
	});
}
</script>
</html>