<%@page import="com.ystech.cust.model.CarSerCount"%>
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
<title>成交客户统计分析</title>
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
    <span id="page_title">成交客户统计分析</span>
    <a class="go_home" href="${ctx }/qywxStatic/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成交客户量（${cObject })
	</h3>
	<h5>
		(时间:
			<fmt:formatDate value="${start }" pattern="MM月dd日"/>—
			<fmt:formatDate value="${end }" pattern="MM月dd日"/>
		)</h5>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成交客户车系统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="carSerCount" items="${carSers }">
					<tr>
				<td align="center" width="80">${carSerCount.serName }</td>
				<td align="center" width="40">${carSerCount.countNum }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成交客户部门统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">部门</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
<%
	DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
	Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
	Statement createStatement = jdbcConnection.createStatement();
	List<CarSerCount> carSerCounts= (List<CarSerCount>)request.getAttribute("carSerCounts");
	for(int i=0;i<carSerCounts.size();i++){
		CarSerCount carSerCount=carSerCounts.get(i);
		String sql=(String)request.getAttribute("depatmentSql");
		sql=sql.replace("paramDep", carSerCount.getSerid()+"");
		ResultSet resultSet = createStatement.executeQuery(sql);
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
				buffer.append("<td align='center'><a href=\"/qywxCustomer/querySuccess?departmentId="+carSerCount.getSerid()+"&carSeriyId="+resultSet.getString("dbid")+"&start="+request.getAttribute("start")+"&end="+request.getAttribute("end")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
				buffer.append("</tr>");
				out.print(buffer.toString());
			}else{
				buffer.append("<tr>");
				buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
				buffer.append("<td align='center'><a href=\"/qywxCustomer/querySuccess?departmentId="+carSerCount.getSerid()+"&carSeriyId="+resultSet.getString("dbid")+"&start="+request.getAttribute("start")+"&end="+request.getAttribute("end")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
				buffer.append("</tr>");
				out.print(buffer.toString());
			}
			j++;
		}
	}
%>
		</tbody>
	</table>
</div>
<div class="row-fluid" style="text-align: center;">
	<h3>
		成交客户经销商统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">经销商</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
<%
	List<CarSerCount> disCarSerCounts= (List<CarSerCount>)request.getAttribute("disCarSerCounts");
	for(int i=0;i<disCarSerCounts.size();i++){
		CarSerCount carSerCount=disCarSerCounts.get(i);
		String distributortypeBySql=(String)request.getAttribute("distributortypeBySql");
		distributortypeBySql=distributortypeBySql.replace("paramDep", carSerCount.getSerid()+"");
		ResultSet resultSet = createStatement.executeQuery(distributortypeBySql);
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
				buffer.append("<td align='center'>"+resultSet.getString("carSTotal")+"</td>");
				buffer.append("</tr>");
				out.print(buffer.toString());
			}else{
				buffer.append("<tr>");
				buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
				buffer.append("<td align='center'>"+resultSet.getString("carSTotal")+"</td>");
				buffer.append("</tr>");
				out.print(buffer.toString());
			}
			j++;
		}
	}
	createStatement.close();
	jdbcConnection.close();
%>
		</tbody>
	</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxStaticManage/customerSuccess" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">开始</label></td>
      	 		<td width="240">
      	 			<c:if test="${!empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
      	 		    </c:if>
      	 		    <c:if test="${empty(param.startTime) }">
      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.getNowMonthFirstDay() %>">
      	 		    </c:if>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">结束</label></td>
      	 		<td width="240">
      	 				<c:if test="${!empty(param.endTime) }">
	  						<input type="date"  class="form-control" id="endTime" name="endTime"  value="${param.endTime }">
	  					</c:if>
	  					<c:if test="${empty(param.endTime) }">
	  						<input type="date"  class="form-control" id="endTime" name="endTime" value="<%=DateUtil.format(new Date())%>">
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
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function () {
	var data=eval("${jsonCarData}");
    $('#container').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '车辆占比'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: '车辆占比',
            data: data
        }]
    });
});
</script>
</html>