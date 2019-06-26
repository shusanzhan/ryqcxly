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
<title>回访超时统计</title>
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
    <span id="page_title">回访超时统计</span>
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
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${enterprise.name } 回访明细
	</h5>
</div>
<div class="row-fluid" id="anEnter">
	<c:if test="${empty(customerTrackCounts)||customerTrackCounts==null }" var="status">
		<div class="alert alert-info" style="margin-top: 20px;">
			<strong>提示!</strong> 当前未添加数据.
		</div>
	</c:if>
	<c:if test="${status==false }">
	<table border="0" class="table table-bordered table-striped" cellpadding="0" cellspacing="0">
		<thead>
				<tr>
				<td style="width: 40px;">序号</td>
				<td style="width:120px;">销售顾问</td>
				<td style="width:80px;">回访总量</td>
				<td style="width:80px;">已回访量</td>
				<td style="width:80px;">未回访量</td>
				<td style="width:80px;">关闭访量</td>
				<td style="width:80px;">超时总量</td>
				<td style="width: 100px;">超时已回访量</td>
				<td style="width: 100px;">超时未回访量</td>
				<td style="width: 100px;">超时关闭未回访量</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${customerTrackCounts }" var="customerTrackCount" varStatus="i">
			<tr>
				<td >
					${i.index+1 }
				</td>
				<td>
					${customerTrackCount.companyName }
				</td>
				<td>
					${customerTrackCount.total }
				</td>
				<td>
					${customerTrackCount.trackedNum }
				</td>
				<td>
					${customerTrackCount.notTrackNum }
				</td>
				<td>
					${customerTrackCount.closeTrackNum }
				</td>
				<td>
					<span style="color: red">${customerTrackCount.overTimeTrackNum }</span>
				</td>
				<td>
					<span style="color: red">${customerTrackCount.overTimeTrackedNum }</span>
				</td>
				<td>
					<span style="color: red">${customerTrackCount.overTimeNotTrackNum }</span>
				</td>
				<td>
					<span style="color: red">${customerTrackCount.overTimeCloseNum }</span>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<p style="color: red;"><span style="color: red;font-weight: bold;">回访总量</span>指在到期回访日周期内需要回访任务总数（已回访量+未回访量+关闭回访量）</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">已回访量</span>=指在到期回访日周期内已经回访任务总数</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">未回访量</span>=指在到期回访日周期内未回访任务总数</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">关闭回访量</span>=指在到期回访日周期内，客户流失销售经理审批同意、客户提报订单系统主动关闭回访任务量</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">超时总量</span>=指在到期回访日周期内超时任务总数(超时已回访量+超时未回访量+超时未回关闭回访量)</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">超时已回访量</span>=指在到期回访日周期内虽然任务已经超时，但是销售顾问后期处理了超时任务的数量</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">超时未回访量</span>=指到期回访日周期内已经超时，同时也未作处理的回访任务总数</p>
	<p style="color: red;"><span style="color: red;font-weight: bold;">超时未回关闭回访量</span>=指到期回访日周期内已经超时，由于提报订单、客户流失销售经理审批同意系统主动关闭回访任务量</p>
	</c:if>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxComprehensiveStatic/queryCustomerTrackCountList" name="frmId" id="frmId" method="post">
      	 <table>
      	 <c:if test="${fn:length(enterprises)>1 }">
	  			<tr>
		  				<td><label>分公司：</label></td>
		  				<td colspan="" >
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
  				<td><label for="exampleInputName2">销售顾问</label></td>
      	 		<td >
      	 			<input type="text" class="form-control" id="userName" name="userName" value="${param.userName }">
			    </td>
			</tr>
			<tr>
  				 <td><label>到期回访时间：</label></td>
  				<td>
  					<input class="form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${beginDate }" >
				</td>
			</tr>
			<tr>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="form-control" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${endDate }">
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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
</script>
</html>