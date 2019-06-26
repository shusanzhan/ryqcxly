<%@page import="com.ystech.xwqr.model.sys.Enterprise"%>
<%@page import="com.ystech.cust.model.CarSerCount"%>
<%@page import="java.util.List"%>
<%@page import="sun.print.resources.serviceui"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
<%@page import="java.sql.ResultSet"%>
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
<title>库存统计分析</title>
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
    <span id="page_title">库存统计分析</span>
    <a class="go_home" href="${ctx }/qywxWlReport/index?role=${param.role}">
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
		${enterprise.name }库龄分析
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" >库龄等级</td>
				<td align="center">数量</td>
			</tr>
			<c:forEach var="carSerCount" items="${carSerCounts }" varStatus="i">
					<tr>
						<td >${carSerCount.serName }</td>
						<td align="center"><a href="${ctx }/qywxFacotoryOrder/factoryOrderLevel?storeAgeLevelId=${carSerCount.serid}&enterpriseId=${enterprise.dbid}">${carSerCount.countNum }</a></td>
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
		库龄车型统计
	</h3>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">库龄</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
<%
	DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
	Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
	Statement createStatement = jdbcConnection.createStatement();
	List<CarSerCount> carSerCounts= (List<CarSerCount>)request.getAttribute("carSerCounts");
	Enterprise enterprise=(Enterprise)request.getAttribute("enterprise");
	for(int i=0;i<carSerCounts.size();i++){
		CarSerCount carSerCount=carSerCounts.get(i);
		String sql="SELECT cs.dbid,cs.`name`,COUNT(cs.dbid) AS carSTotal "+
				"FROM "+
				"set_carseriy cs,s_factoryorder sf "+ 
				"WHERE cs.dbid=sf.carSeriyId AND sf.carStatus<=3 AND sf.storeAgeLevelId="+carSerCount.getSerid()+" and sf.sourcecompanyid="+enterprise.getDbid()+
				" GROUP BY cs.dbid,sf.storeAgeLevelId";
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
				buffer.append("<td align='center'><a href=\"/qywxFacotoryOrder/factoryOrderLevel?storeAgeLevelId="+carSerCount.getSerid()+"&carSeriyId="+resultSet.getString("dbid")+"&enterpriseId="+enterprise.getDbid()+"\">"+resultSet.getString("carSTotal")+"</a></td>");
				buffer.append("</tr>");
				out.print(buffer.toString());
			}else{
				buffer.append("<tr>");
				buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
				buffer.append("<td align='center'><a href=\"/qywxFacotoryOrder/factoryOrderLevel?storeAgeLevelId="+carSerCount.getSerid()+"&carSeriyId="+resultSet.getString("dbid")+"&enterpriseId="+enterprise.getDbid()+"\">"+resultSet.getString("carSTotal")+"</a></td>");
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
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxStaticManage/stockStatic" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">分公司</label></td>
      	 		<td width="240">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
	      	 			<select id="enterpriseId" name="enterpriseId" class="form-control">
	      	 				<option value="-1">请选择...</option>
	      	 				<c:forEach var="enterprise1"  items="${enterprises }">
	      	 					<option value="${enterprise1.dbid }" ${enterprise1.dbid==enterprise.dbid?'selected="selected"':'' } >${enterprise1.name }</option>
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
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script
>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function () {
	 var data=eval("${jsonCarData}");
	 $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '库龄等级分析'
        },
      
        xAxis: {
            type: 'category',
            labels: {
                rotation: -45,
                align: 'right',
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif'
                }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: ''
            }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            pointFormat: ': <b>{point.y:.1f} 人</b>',
        },
        series: [{
            name: 'Population',
            data: data,
            dataLabels: {
                enabled: true,
                rotation: -90,
                color: '#FFFFFF',
                align: 'right',
                x: 4,
                y: 10,
                style: {
                    fontSize: '13px',
                    fontFamily: 'Verdana, sans-serif',
                    textShadow: '0 0 3px black'
                }
            }
        }]
    });
	
});
</script>
</html>