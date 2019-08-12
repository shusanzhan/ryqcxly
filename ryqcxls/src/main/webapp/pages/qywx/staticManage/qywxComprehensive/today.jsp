<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
<title>回访统计</title>
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
#anEnter{
	font-size: 10px;
}
#anEnter td{
	padding: 5px 2px;
}
#mcover {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.7);
    height: 100%;
    display:none;
    left: 0;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 20000;
}
#mcover img {
    height: 32px;
    position: fixed;
    right: 50%;
    top: 50%;
    width: 32px;
    z-index: 20001;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">回访统计</span>
    <a class="go_home" href="${ctx }/qywxSaleReport/index?role=${param.role}">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
    <c:if test="${param.type==1||param.type>=3 }">
	     <a id="search_action" class="go_search" onclick="showSearch()">
	    	<img src="${ctx }/images/jm/search_list.png" class="search">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>
<c:forEach items="${enterprisess }" var="enterprises" varStatus="i">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${enterprises.name } 回访明细
	</h5>
</div>
	<div class="row-fluid" id="anEnter">
		<table class="table table-bordered table-striped">
			<tbody>
				<tr id="anEnterAfter">
					<td align="center" width="80">销售顾问</td>
					<td align="center" width="40">待回访</td>
					<td align="center" width="40">已回访</td>
					<td align="center" width="40">未回访</td>
				</tr>
				<c:set value="0" var="trackTotalNumt"></c:set>
				<c:set value="0" var="trackedTotalNumt"></c:set>
				<c:set value="0" var="trackNotNumt"></c:set>
				<c:forEach items="${map}" var="entry"> 
					<c:if test="${entry.key==enterprises.dbid }">
						<c:forEach var="usercount" items="${entry.value}"> 
						<tr>
							<td><a href="${ctx }/qywxCustomerTrack/needTrackCustomer?salerId=${usercount.salerId}&type=${param.type}">${usercount.salerName }</a></td>	
							<td>${usercount.trackTotalNum}</td>
							<td>${usercount.trackedTotalNum}</td>
							<td>${usercount.trackNotNum}</td>
							<c:set value="${usercount.trackTotalNum+trackTotalNumt }" var="trackTotalNumt"></c:set>
							<c:set value="${usercount.trackedTotalNum+trackedTotalNumt }" var="trackedTotalNumt"></c:set>
							<c:set value="${usercount.trackNotNum+trackNotNumt }" var="trackNotNumt"></c:set>
						</tr>
						</c:forEach>
					</c:if>
				</c:forEach>  
				<tr id="anEnterAfter">
					<td align="center" width="80">合计</td>
					<td align="center" width="40">${trackTotalNumt }</td>
					<td align="center" width="40">${trackedTotalNumt }</td>
					<td align="center" width="40">${trackNotNumt}</td>
				</tr>
			</tbody>
		</table>
	</div>
</c:forEach>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxComprehensiveStatic/today" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
	      	 			<c:if test="${!empty(param.startTime) }">
	      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.startTime) }">
	      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
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
<div id="mcover">
	<img alt="" src="${ctx }/images/loading.gif">
</div>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
</script>
</html>