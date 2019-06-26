<%@page import="java.sql.ResultSet"%>
<%@page import="com.ystech.cust.model.CarSerCount"%>
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
<title>留存订单报表</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span>留存订单报表</span>
    <a class="go_home" href="${ctx }/qywxRoomManageSaleReport/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
           <li class="detail_tap3 detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/qywxRoomManageSaleReport/customerOrder'">当日新增订单</li>
           <li class="detail_tap3 detail_tap pull_left " style="border:1px solid #ed145b;" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxOrder/queryOrderList'">当月订单</li>
           <li class="detail_tap3 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxRoomManageSaleReport/waitingCustomerCar'">留存订单</li>
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		当前留存订单:${waitingCar }人
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">待交车</td>
				<td align="center">待审批</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${commonWatingCount }</td>
				<td align="center">${approvalingWatingCount }</td>
				<td align="center">${waitingCar }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		车源情况统计
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">物流未处理</td>
				<td align="center">物流已经处理</td>
			</tr>
			<tr>
				<td align="center">${wlNoDeal }</td>
				<td align="center">${wlDealEd }</td>
			</tr>
		</tbody>
	</table>
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">无车</td>
				<td align="center">在途</td>
				<td align="center">现车</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${noCar }</td>
				<td align="center">${driverCar }</td>
				<td align="center">${hasCar }</td>
				<td align="center">${wlDealEd }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		购车方式
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">现款</td>
				<td align="center">分期</td>
				<td align="center">未确定</td>
			</tr>
			<tr>
				<td align="center">${xiankuan }</td>
				<td align="center">${feiqi }</td>
				<td align="center">${waitingCar-xiankuan-feiqi}</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		留存订单车辆构成
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="40">车系</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="100">车型</td>
				<td align="center" width="40">数量</td>
			</tr>
<%
	DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
	Connection jdbcConnection2 = databaseUnitHelper.getJdbcConnection();
	Statement createStatement2 = jdbcConnection2.createStatement();
	List<CarSerCount> carSerCounts= (List<CarSerCount>)request.getAttribute("carSerCounts");
	if(null!=carSerCounts&&carSerCounts.size()>0){
		for(int i=0;i<carSerCounts.size();i++){
			CarSerCount carSerCount=carSerCounts.get(i);
			String sql="SELECT " +
					"cm.dbid ,cm.`name`, COUNT(cm.dbid) AS carSTotal "+ 
					"FROM set_carmodel cm,cust_customer AS cuts,cust_customerpidbookingrecord AS cpr "+ 
					"WHERE  cm.dbid=cpr.carModelid AND cuts.dbid=cpr.customerId AND cpr.pidStatus!=2 AND cpr.pidStatus!=-1 AND cm.carSeriesId="+carSerCount.getSerid()+
					" GROUP BY cm.dbid ORDER BY carSTotal DESC";
			ResultSet resultSet = createStatement2.executeQuery(sql);
			resultSet.last();
	       	Integer rowCount = resultSet.getRow();
			resultSet.beforeFirst();
			int j=0;
			while (resultSet.next()) {
				StringBuffer buffer=new StringBuffer();
				if(j==0){
					buffer.append("<tr>");
					buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;' rowspan='"+rowCount+"'>"+carSerCount.getSerName()+"</td>");
					buffer.append("<td id='trTd' align='center' valign='middle' style=''vertical-align: middle;' rowspan='"+rowCount+"'>"+carSerCount.getCountNum()+"</td>");
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
					buffer.append("<td align='center'><a href=\"/qywxStaticManage/customerList?carModelId="+resultSet.getString("dbid")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
					buffer.append("</tr>");
					out.print(buffer.toString());
				}else{
					buffer.append("<tr>");
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
					buffer.append("<td align='center'><a href=\"/qywxStaticManage/customerList?carModelId="+resultSet.getString("dbid")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
					buffer.append("</tr>");
					out.print(buffer.toString());
				}
				j++;
			}
		}
		createStatement2.close();
		jdbcConnection2.close();
	}
	
%>
</tbody>
</table>
</div>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
</script>
</html>