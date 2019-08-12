<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../commons/taglib.jsp" %>
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
<title>附加部门年报表</title>
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
.table-bordered > thead > tr > th, .table-bordered > tbody > tr > th, .table-bordered > tfoot > tr > th, .table-bordered > thead > tr > td, .table-bordered > tbody > tr > td, .table-bordered > tfoot > tr > td
{
	padding: 5px 2px;
	vertical-align: middle;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">附加部门年报表</span>
    <a class="go_home" href="${ctx }/qywxFj/index">
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
           <li class="detail_tap4 detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/qywxFjDep/day'">日</li>
           <li class="detail_tap4 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjDep/week'">周</li>
           <li class="detail_tap4 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjDep/month'">月</li>
           <li class="detail_tap4 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjDep/year'">年</li>
      	</ul>
     </div>
 </div>

<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		自有店附加（${monthDay }）
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">装饰</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">服务费</td>
				<td align="center" width="40">渗透率</td>
			</tr>
			<tr>
				<td align="center">
					<c:if test="${empty(success) }">
						0
					</c:if>
					<c:if test="${!empty(success) }">
						${success }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(countDecore) }">
						0.0
					</c:if>
					<c:if test="${!empty(countDecore) }">
						${countDecore }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(countLoan.loanNum) }">
						0.0
					</c:if>
					<c:if test="${!empty(countLoan.loanNum) }">
						${countLoan.loanNum }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(countLoan.loanPrice) }">
						0.0
					</c:if>
					<c:if test="${!empty(countLoan.loanPrice) }">
						${countLoan.loanPrice }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(perLoan) }">
						0.00
					</c:if>
					<c:if test="${!empty(perLoan) }">
						<fmt:formatNumber value="${perLoan}" pattern="0.##"></fmt:formatNumber> 
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
	
	<h5 style="text-align: left;font-size: 16px;color:#ed145b;">
		<span style="font-size: 14px;">1、加装装饰</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">公司</td>
				<td align="center" width="60">单位</td>
				<td align="center" width="50">加装台次</td>
				<td align="center" width="40">产值</td>
				<td align="center" width="40">实收</td>
				<td align="center" width="40">平均</td>
				<td align="center" width="50">折扣率</td>
				<td align="center" width="40">赠送</td>
			</tr>
			<c:if test="${empty(decoreMaps)||fn:length(decoreMaps)<=0 }" var="status">
				<tr>
					<td colspan="5">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="decoreMap" items="${decoreMaps }" >
					<c:set value="${decoreMap.value }" var="fjDeps"></c:set>
					<c:set value="${fn:length(fjDeps) }" var="len"></c:set>
					<c:if test="${len<=0 }">
						<tr>
							<td align="center" width="80">${decoreMap.key }</td>
							<td align="center" width="60">无</td>
							<td align="center" width="60">0</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
						</tr>
					</c:if>
					<c:if test="${len>0 }">
						<c:forEach  var="decoreFjSaler" items="${fjDeps }" varStatus="i">
							<c:if test="${i.index==0 }">
								<tr>
									<td align="center" width="80" rowspan="${len }" style="" valign="middle">${decoreMap.key }</td>
									<td align="center" width="60">${decoreFjSaler.name }</td>
									<td align="center" width="50">${decoreFjSaler.successNum }</td>
									<td align="center" width="40">${decoreFjSaler.decoreSaleTotalPrce }</td>
									<td align="center" width="40">${decoreFjSaler.acturePrice }</td>
									<td align="center" width="40">
										<fmt:formatNumber value="${decoreFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
									</td>
									<td align="center" width="50">
										<c:if test="${empty(decoreFjSaler.zkl) }">
											0
										</c:if>
										<c:if test="${!empty(decoreFjSaler.zkl) }">
											<fmt:formatNumber value="${decoreFjSaler.zkl }" pattern="0.##"></fmt:formatNumber>	
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(decoreFjSaler.giveTotalPrice) }">
											0
										</c:if>
										<c:if test="${!empty(decoreFjSaler.giveTotalPrice) }">
											${decoreFjSaler.giveTotalPrice }
										</c:if>
									</td>
								</tr>
							</c:if>
							<c:if test="${i.index>0 }">
								<tr>
									<td align="center" width="60">${decoreFjSaler.name }</td>
									<td align="center" width="50">${decoreFjSaler.successNum }</td>
									<td align="center" width="40">${decoreFjSaler.decoreSaleTotalPrce }</td>
									<td align="center" width="40">${decoreFjSaler.acturePrice }</td>
									<td align="center" width="40">
										<fmt:formatNumber value="${decoreFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
									</td>
									<td align="center" width="50">
										<c:if test="${empty(decoreFjSaler.zkl) }">
											0
										</c:if>
										<c:if test="${!empty(decoreFjSaler.zkl) }">
											<fmt:formatNumber value="${decoreFjSaler.zkl }" pattern="0.##"></fmt:formatNumber>	
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(decoreFjSaler.giveTotalPrice) }">
											0
										</c:if>
										<c:if test="${!empty(decoreFjSaler.giveTotalPrice) }">
											${decoreFjSaler.giveTotalPrice }
										</c:if>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<h5 style="text-align: left;font-size: 16px;color:#ed145b;">
		<span style="font-size: 14px;">2、服务费</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td  align="center" width="40">公司</td>
				<td align="center" width="60">单位</td>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">渗透率</td>
				<td align="center" width="40">总计</td>
				<td align="center" width="40">平均</td>
			</tr>
			<c:if test="${empty(loanMaps)||fn:length(loanMaps)<=0 }" var="status">
				<tr>
					<td colspan="5">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="loanMap" items="${loanMaps }" >
					<c:set value="${loanMap.value }" var="fjDeps"></c:set>
					<c:set value="${fn:length(fjDeps) }" var="len"></c:set>
					<c:if test="${len<=0 }">
						<tr>
							<td align="center" width="80">${loanMap.key }</td>
							<td align="center" width="60">无</td>
							<td align="center" width="60">0</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
							<td align="center" width="40">
								0
							</td>
						</tr>
					</c:if>
					<c:if test="${len>0 }">
						<c:forEach  var="loanFjSaler" items="${fjDeps }" varStatus="i">
							<c:if test="${i.index==0 }">
								<tr>
									<td align="center" width="80" rowspan="${len }" style="" valign="middle">${loanMap.key }</td>
									<td align="center" width="60">${loanFjSaler.name }</td>
									<td align="center" width="50">${loanFjSaler.successNum }</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.loanNum) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.loanNum) }">
											${loanFjSaler.loanNum }
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.stl) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.stl) }">
											<fmt:formatNumber value="${loanFjSaler.stl }" pattern="0.##"></fmt:formatNumber>
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.loanPrice) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.loanPrice) }">
											${loanFjSaler.loanPrice }
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.avg) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.avg) }">
											<fmt:formatNumber value="${loanFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
										</c:if>
									</td>
								</tr>
							</c:if>
							<c:if test="${i.index>0 }">
								<tr>
									<td align="center" width="60">${loanFjSaler.name }</td>
									<td align="center" width="50">${loanFjSaler.successNum }</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.loanNum) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.loanNum) }">
											${loanFjSaler.loanNum }
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.stl) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.stl) }">
											<fmt:formatNumber value="${loanFjSaler.stl }" pattern="0.##"></fmt:formatNumber>
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.loanPrice) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.loanPrice) }">
											${loanFjSaler.loanPrice }
										</c:if>
									</td>
									<td align="center" width="40">
										<c:if test="${empty(loanFjSaler.avg) }">
											0
										</c:if>
										<c:if test="${!empty(loanFjSaler.avg) }">
											<fmt:formatNumber value="${loanFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
										</c:if>
									</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		二网附加 （${monthDay }）
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="80">成交量</td>
				<td align="center" width="40">装饰</td>
				<td align="center" width="40">贷款人</td>
				<td align="center" width="40">服务费</td>
				<td align="center" width="60">渗透率</td>
			</tr>
			<tr>
				<td align="center">
					<c:if test="${empty(netSuccess) }">
						0
					</c:if>
					<c:if test="${!empty(netSuccess) }">
						${netSuccess }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(netCountDecore) }">
						0.0
					</c:if>
					<c:if test="${!empty(netCountDecore) }">
						${netCountDecore }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(netCountLoan.loanNum) }">
						0.0
					</c:if>
					<c:if test="${!empty(netCountLoan.loanNum) }">
						${netCountLoan.loanNum }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(netCountLoan.loanPrice) }">
						0.0
					</c:if>
					<c:if test="${!empty(netCountLoan.loanPrice) }">
						${netCountLoan.loanPrice }
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty(netPerLoan) }">
						0.00
					</c:if>
					<c:if test="${!empty(netPerLoan) }">
						<fmt:formatNumber value="${netPerLoan}" pattern="0.##"></fmt:formatNumber> 
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
	<h5 style="text-align: left;font-size: 16px;color:#ed145b;">
		<span style="font-size: 14px;">1、加装装饰</span>
	</h5>
	<h5 style="text-align: left;font-size: 12px;color:#ed145b;">
		<span style="font-size: 12px;">一、区域专员</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">区域专员</td>
				<td align="center" width="50">加装台次</td>
				<td align="center" width="40">产值</td>
				<td align="center" width="40">实收</td>
				<td align="center" width="40">平均</td>
				<td align="center" width="50">折扣率</td>
				<td align="center" width="40">赠送</td>
			</tr>
			<c:if test="${empty(netDecoreManagers)||fn:length(netDecoreManagers)<=0 }" var="status">
				<tr>
					<td colspan="8">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="decoreFjSaler" items="${netDecoreManagers }" varStatus="i">
					<tr>
						<td  align="center" width="20">${i.index+1 }</td>
						<td align="center" width="60">${decoreFjSaler.realName }</td>
						<td align="center" width="50">${decoreFjSaler.successNum }</td>
						<td align="center" width="40">${decoreFjSaler.decoreSaleTotalPrce }</td>
						<td align="center" width="40">${decoreFjSaler.acturePrice }</td>
						<td align="center" width="40">
							<fmt:formatNumber value="${decoreFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
						</td>
						<td align="center" width="50">
							<c:if test="${empty(decoreFjSaler.zkl) }">
								0
							</c:if>
							<c:if test="${!empty(decoreFjSaler.zkl) }">
								<fmt:formatNumber value="${decoreFjSaler.zkl }" pattern="0.##"></fmt:formatNumber>	
							</c:if>
						</td>
						<td align="center" width="40">
							<c:if test="${empty(decoreFjSaler.giveTotalPrice) }">
								0
							</c:if>
							<c:if test="${!empty(decoreFjSaler.giveTotalPrice) }">
								${decoreFjSaler.giveTotalPrice }
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<h5 style="text-align: left;font-size: 12px;color:#ed145b;">
		<span style="font-size: 12px;">二、区域</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">区域</td>
				<td align="center" width="50">加装台次</td>
				<td align="center" width="40">产值</td>
				<td align="center" width="40">实收</td>
				<td align="center" width="40">平均</td>
				<td align="center" width="50">折扣率</td>
				<td align="center" width="40">赠送</td>
			</tr>
			<c:if test="${empty(netDecoreDists)||fn:length(netDecoreDists)<=0 }" var="status">
				<tr>
					<td colspan="8">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="decoreFjSaler" items="${netDecoreDists }" varStatus="i">
					<tr>
						<td  align="center" width="20">${i.index+1 }</td>
						<td align="center" width="60">${decoreFjSaler.name }</td>
						<td align="center" width="50">${decoreFjSaler.successNum }</td>
						<td align="center" width="40">${decoreFjSaler.decoreSaleTotalPrce }</td>
						<td align="center" width="40">${decoreFjSaler.acturePrice }</td>
						<td align="center" width="40">
							<fmt:formatNumber value="${decoreFjSaler.avg }" pattern="0.##"></fmt:formatNumber>
						</td>
						<td align="center" width="50">
							<c:if test="${empty(decoreFjSaler.zkl) }">
								0
							</c:if>
							<c:if test="${!empty(decoreFjSaler.zkl) }">
								<fmt:formatNumber value="${decoreFjSaler.zkl }" pattern="0.##"></fmt:formatNumber>	
							</c:if>
						</td>
						<td align="center" width="40">
							<c:if test="${empty(decoreFjSaler.giveTotalPrice) }">
								0
							</c:if>
							<c:if test="${!empty(decoreFjSaler.giveTotalPrice) }">
								${decoreFjSaler.giveTotalPrice }
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<!-- 贷款 数据列表 -->
<div class="row-fluid">
	<h5 style="text-align: left;font-size: 16px;color:#ed145b;">
		<span style="font-size: 14px;">2、服务费</span>
	</h5>
	<h5 style="text-align: left;font-size: 12px;color:#ed145b;">
		<span style="font-size: 12px;">一、区域专员</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">区域专员</td>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">渗透率</td>
				<td align="center" width="40">总计</td>
				<td align="center" width="40">平均</td>
			</tr>
			<c:if test="${empty(netLoanManagers)||fn:length(netLoanManagers)<=0 }" var="status">
				<tr>
					<td colspan="7">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
			<c:forEach var="netLoanManager" items="${netLoanManagers }" varStatus="i">
				<tr>
					<td  align="center" width="20">${i.index+1 }</td>
					<td align="center" width="60">${netLoanManager.realName }</td>
					<td align="center" width="50">${netLoanManager.successNum }</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.loanNum) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.loanNum) }">
							${netLoanManager.loanNum }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.stl) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.stl) }">
							<fmt:formatNumber value="${netLoanManager.stl }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.loanPrice) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.loanPrice) }">
							${netLoanManager.loanPrice }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.avg) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.avg) }">
							<fmt:formatNumber value="${netLoanManager.avg }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	<h5 style="text-align: left;font-size: 12px;color:#ed145b;">
		<span style="font-size: 12px;">二、区域</span>
	</h5>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">区域</td>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">渗透率</td>
				<td align="center" width="40">总计</td>
				<td align="center" width="40">平均</td>
			</tr>
			<c:if test="${empty(netLoanDists)||fn:length(netLoanDists)<=0 }" var="status">
				<tr>
					<td colspan="7">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
			<c:forEach var="netLoanManager" items="${netLoanDists }" varStatus="i">
				<tr>
					<td  align="center" width="20">${i.index+1 }</td>
					<td align="center" width="60">${netLoanManager.name }</td>
					<td align="center" width="50">${netLoanManager.successNum }</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.loanNum) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.loanNum) }">
							${netLoanManager.loanNum }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.stl) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.stl) }">
							<fmt:formatNumber value="${netLoanManager.stl }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.loanPrice) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.loanPrice) }">
							${netLoanManager.loanPrice }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(netLoanManager.avg) }">
							0
						</c:if>
						<c:if test="${!empty(netLoanManager.avg) }">
							<fmt:formatNumber value="${netLoanManager.avg }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxFjDep/year" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<select id="startTime" name="startTime" class="form-control">
      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
      	 					<option value="${i }" ${param.startTime==i?'selected="selected"':'' } >${i }年</option>
      	 				</c:forEach>
      	 			</select>
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/aui-artDialog/css/ui-dialog.css" />
<script src="${ctx }/widgets/aui-artDialog/dist/dialog-plus.js"></script>
</html>