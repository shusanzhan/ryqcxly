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
<title>附加车系年报表</title>
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
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">附加车系年报表</span>
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
           <li class="detail_tap4 detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/qywxFjCarSeriy/day'">日</li>
           <li class="detail_tap4 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjCarSeriy/week'">周</li>
           <li class="detail_tap4 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjCarSeriy/month'">月</li>
           <li class="detail_tap4 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxFjCarSeriy/year'">年</li>
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
				<td align="center" width="50">渗透率</td>
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
					<fmt:formatNumber value="${perLoan}" pattern="0.##"></fmt:formatNumber> 
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
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">车系</td>
				<td align="center" width="50">加装台次</td>
				<td align="center" width="40">产值</td>
				<td align="center" width="40">实收</td>
				<td align="center" width="40">平均</td>
				<td align="center" width="50">折扣率</td>
				<td align="center" width="40">赠送</td>
			</tr>
			<c:if test="${empty(fjDecoreCarSeriys)||fn:length(fjDecoreCarSeriys)<=0 }" var="status">
				<tr>
					<td colspan="8">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="fjDecoreCarSeriy" items="${fjDecoreCarSeriys }" varStatus="i">
					<tr>
						<td  align="center" width="20">${i.index+1 }</td>
						<td align="center" width="60">${fjDecoreCarSeriy.name }</td>
						<td align="center" width="50">${fjDecoreCarSeriy.successNum }</td>
						<td align="center" width="40">
							<c:if test="${empty(fjDecoreCarSeriy.decoreSaleTotalPrce) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.decoreSaleTotalPrce) }">
								${fjDecoreCarSeriy.decoreSaleTotalPrce }
							</c:if>
						</td>
						<td align="center" width="40">${fjDecoreCarSeriy.acturePrice }</td>
						<td align="center" width="40">
							<fmt:formatNumber value="${fjDecoreCarSeriy.avg }" pattern="0.##"></fmt:formatNumber>
						</td>
						<td align="center" width="50">
							<c:if test="${empty(fjDecoreCarSeriy.zkl) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.zkl) }">
								<fmt:formatNumber value="${fjDecoreCarSeriy.zkl }" pattern="0.##"></fmt:formatNumber>	
							</c:if>
						</td>
						<td align="center" width="40">
							<c:if test="${empty(fjDecoreCarSeriy.giveTotalPrice) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.giveTotalPrice) }">
								${fjDecoreCarSeriy.giveTotalPrice }
							</c:if>
						</td>
					</tr>
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
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">姓名</td>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">渗透率</td>
				<td align="center" width="40">总计</td>
				<td align="center" width="40">平均</td>
			</tr>
			<c:if test="${empty(fjLoanCarSeriys)||fn:length(fjLoanCarSeriys)<=0 }" var="status">
				<tr>
					<td colspan="7">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
			<c:forEach var="fjLoanCarSeriy" items="${fjLoanCarSeriys }" varStatus="i">
				<tr>
					<td  align="center" width="20">${i.index+1 }</td>
					<td align="center" width="60">${fjLoanCarSeriy.name }</td>
					<td align="center" width="50">${fjLoanCarSeriy.successNum }</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.loanNum) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.loanNum) }">
							${fjLoanCarSeriy.loanNum }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.stl) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.stl) }">
							<fmt:formatNumber value="${fjLoanCarSeriy.stl }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.loanPrice) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.loanPrice) }">
							${fjLoanCarSeriy.loanPrice }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.avg) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.avg) }">
							<fmt:formatNumber value="${fjLoanCarSeriy.avg }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
				</tr>
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
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">装饰</td>
				<td align="center" width="40">按揭台次</td>
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
					<fmt:formatNumber value="${netPerLoan }"></fmt:formatNumber> 
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
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">车系</td>
				<td align="center" width="50">加装台次</td>
				<td align="center" width="40">产值</td>
				<td align="center" width="40">实收</td>
				<td align="center" width="40">平均</td>
				<td align="center" width="50">折扣率</td>
				<td align="center" width="40">赠送</td>
			</tr>
			<c:if test="${empty(netFjDecoreCarSeriys)||fn:length(netFjDecoreCarSeriys)<=0 }" var="status">
				<tr>
					<td colspan="8">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<c:forEach var="fjDecoreCarSeriy" items="${netFjDecoreCarSeriys }" varStatus="i">
					<tr>
						<td  align="center" width="20">${i.index+1 }</td>
						<td align="center" width="60">${fjDecoreCarSeriy.name }</td>
						<td align="center" width="50">${fjDecoreCarSeriy.successNum }</td>
						<td align="center" width="40">
							<c:if test="${empty(fjDecoreCarSeriy.decoreSaleTotalPrce) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.decoreSaleTotalPrce) }">
								${fjDecoreCarSeriy.decoreSaleTotalPrce }
							</c:if>
						</td>
						<td align="center" width="40">${fjDecoreCarSeriy.acturePrice }</td>
						<td align="center" width="40">
							<fmt:formatNumber value="${fjDecoreCarSeriy.avg }" pattern="0.##"></fmt:formatNumber>
						</td>
						<td align="center" width="50">
							<c:if test="${empty(fjDecoreCarSeriy.zkl) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.zkl) }">
								<fmt:formatNumber value="${fjDecoreCarSeriy.zkl }" pattern="0.##"></fmt:formatNumber>	
							</c:if>
						</td>
						<td align="center" width="40">
							<c:if test="${empty(fjDecoreCarSeriy.giveTotalPrice) }">
								0
							</c:if>
							<c:if test="${!empty(fjDecoreCarSeriy.giveTotalPrice) }">
								${fjDecoreCarSeriy.giveTotalPrice }
							</c:if>
						</td>
					</tr>
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
				<td  align="center" width="20">序号</td>
				<td align="center" width="60">姓名</td>
				<td align="center" width="50">成交台次</td>
				<td align="center" width="40">按揭台次</td>
				<td align="center" width="40">渗透率</td>
				<td align="center" width="40">总计</td>
				<td align="center" width="40">平均</td>
			</tr>
			<c:if test="${empty(netFjLoanCarSeriys)||fn:length(netFjLoanCarSeriys)<=0 }" var="status">
				<tr>
					<td colspan="7">无数据</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
			<c:forEach var="fjLoanCarSeriy" items="${netFjLoanCarSeriys }" varStatus="i">
				<tr>
					<td  align="center" width="20">${i.index+1 }</td>
					<td align="center" width="60">${fjLoanCarSeriy.name }</td>
					<td align="center" width="50">${fjLoanCarSeriy.successNum }</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.loanNum) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.loanNum) }">
							${fjLoanCarSeriy.loanNum }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.stl) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.stl) }">
							<fmt:formatNumber value="${fjLoanCarSeriy.stl }" pattern="0.##"></fmt:formatNumber>
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.loanPrice) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.loanPrice) }">
							${fjLoanCarSeriy.loanPrice }
						</c:if>
					</td>
					<td align="center" width="40">
						<c:if test="${empty(fjLoanCarSeriy.avg) }">
							0
						</c:if>
						<c:if test="${!empty(fjLoanCarSeriy.avg) }">
							<fmt:formatNumber value="${fjLoanCarSeriy.avg }" pattern="0.##"></fmt:formatNumber>
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
      	<form class="form-inline" action="${ctx }/qywxFjCarSeriy/year" name="frmId" id="frmId" method="post">
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