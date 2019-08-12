<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
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
<title>${monthDay }月发放记录</title>
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
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${monthDay }月发放记录</span>
     <a id="search_action" class="go_search" onclick="showSearch()" style="right: 5px">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<div class="row-fluid" style="text-align: center;margin-bottom: 12px;color:#ed145b;line-height: 40px;width: 200px;margin: 0 auto;">
			<c:set value="0" var="total"></c:set>
			<c:forEach var="redBag" items="${redBags }" varStatus="i">
				<c:set value="${total+redBag.redBagMoney }" var="total"></c:set>
			</c:forEach>
			<table width="100">
				<tbody>
					<tr>
						<td style="text-align: right;" width="60">
							发放总额:
						</td>
						<td style="text-align: left;" width="60">
							<span style="font-size: 28px;padding-left: 12px;">${total }</span>
						</td>
					</tr>
				</tbody>
			</table>
	</div>
<br>
<br>
<div class="row-fluid">
	<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
		<h5 style="text-align: left;font-size: 16px">
			明细
		</h5>
	</div>
	<c:if test="${empty(redBags) }">
		<div class="alert">无发放记录</div>
	</c:if>
	<c:if test="${!empty(redBags) }">
		<table class="table table-bordered table-striped">
			<tbody>
				<tr>
					<td align="center" width="40">接收人</td>
					<td align="center" width="40">金额</td>
					<td align="center" width="40">日期</td>
				</tr>
				<c:forEach var="redBag" items="${redBags }">
					<tr>
						<td id='trTd' align='center'  valign='middle'>
							${redBag.recipientName }
						</td>
						<td id='trTd' align='center'  valign='middle'>
							<span style="color: red;">${redBag.redBagMoney }</span>
						</td>
						<td id='trTd' align='center'  valign='middle'>
							<fmt:formatDate value="${redBag.createDate }"/> 
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxRedBag/mySendBag" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<c:if test="${!empty(param.startTime) }">
      	 				<input type="month" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
      	 		    </c:if>
      	 		    <c:if test="${empty(param.startTime) }">
      	 				<input type="month" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
      	 		    </c:if>
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
</html>