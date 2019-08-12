<%@page import="com.ystech.carstock.model.StoreRoom"%>
<%@page import="com.ystech.cust.model.CarSerCount"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.ystech.core.util.DatabaseUnitHelper"%>
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
body {
    font-family: "Microsoft Yahei",tahoma,verdana,arial,sans-serif;
    font-size: 14px;
    line-height: 1.231;
}
#badgeSelf{
		color: #FFF;
		background-color:  #ed145b;
	}
	
.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.list-group-item:first-child{
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
}
.list-group-item:last-child{
   border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
}
</style>
<title>${storeRoom.name }库存车系统计</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	<a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${storeRoom.name }库存车系统计</span>
    <a class="go_home" href="${ctx }/qywxWlReport/index?role=${param.role}">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${storeRoom.name }库存车系统计
	</h5>
</div>
<ul class="list-group">
<c:if test="${fn:length(carSerCounts)>0 }" var="status">
	<c:set value="0" var="num"></c:set>
	<c:forEach var="carSerCount" items="${carSerCounts }">
	 <li class="list-group-item" onclick="window.location.href='${ctx}/qywxWlReport/carmodelFactoryOrder?carserId=${carSerCount.serid }&storeRoomId=${storeRoom.dbid }&enterpriseId=${param.enterpriseId }'">
	    <span class="badge" id="badgeSelf">
    		<c:if test="${!empty(carSerCount.countNum)}">
	    		${carSerCount.countNum }
	    	</c:if>
	    	<c:if test="${empty(carSerCount.countNum)}">
	    		0
	    	</c:if>
	    </span>
	    ${carSerCount.serName }
	    <c:set value="${num+carSerCount.countNum }" var="num"></c:set>
	  </li>
	 </c:forEach>
	  <li class="list-group-item" onclick="" style="text-align: right;">
	  	合计： <span class="badge" id="badgeSelf">${num }</span>
	  </li>
 </c:if>
 <c:if test="${status==false }">
 	 <li class="list-group-item">
 	 	 ${storeRoom.name }无车系
	 </li>
 </c:if>
</ul>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		${storeRoom.name }库龄统计 
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">库龄</td>
				<td align="center" width="80">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
<%
	DatabaseUnitHelper databaseUnitHelper = new DatabaseUnitHelper();
	Connection jdbcConnection = databaseUnitHelper.getJdbcConnection();
	Statement createStatement = jdbcConnection.createStatement();
	List<CarSerCount> carSerCounts= (List<CarSerCount>)request.getAttribute("storeAges");
	String enterpriseId= request.getParameter("enterpriseId");
	Integer id=Integer.parseInt(enterpriseId);
	StoreRoom storeRoom=(StoreRoom)request.getAttribute("storeRoom");
	for(int i=0;i<carSerCounts.size();i++){
		CarSerCount carSerCount=carSerCounts.get(i);
		String sql="SELECT cs.dbid,cs.`name`,COUNT(cs.dbid) AS carSTotal "+
				"FROM "+
				"set_carseriy cs,s_factoryorder sf "+ 
				"WHERE cs.dbid=sf.carSeriyId AND sf.carStatus<=3 AND sf.storeRoomId="+storeRoom.getDbid()+" and sf.sourcecompanyid="+id+" AND sf.storeAgeLevelId="+carSerCount.getSerid()+
				" GROUP BY cs.dbid,sf.storeAgeLevelId";
		ResultSet resultSet = createStatement.executeQuery(sql);
		resultSet.last();
       	Integer rowCount = resultSet.getRow();
		resultSet.beforeFirst();
		int j=0;
		int totolNum=0;
		while (resultSet.next()) {
			StringBuffer buffer=new StringBuffer();
			if(j==0){
				buffer.append("<tr>");
				buffer.append("<td id='trTd' align='center'  valign='middle' style=''vertical-align: middle;' rowspan='"+(rowCount+1)+"'>"+carSerCount.getSerName()+"</td>");
				if(null!=resultSet.getString("name")){
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
				}else{
					buffer.append("<td align='center'>无</td>");
				}
				buffer.append("<td align='center'><a href=\"/qywxFacotoryOrder/factoryOrderLevel?storeAgeLevelId="+carSerCount.getSerid()+"&storeRoomId="+storeRoom.getDbid()+"&carSeriyId="+resultSet.getString("dbid")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
				buffer.append("</tr>");
				totolNum=totolNum+resultSet.getInt("carSTotal");
				out.print(buffer.toString());
			}else{
				buffer.append("<tr>");
				if(null!=resultSet.getString("name")){
					buffer.append("<td align='center'>"+resultSet.getString("name")+"</td>");
				}else{
					buffer.append("<td align='center'>无</td>");
				}
				buffer.append("<td align='center'><a href=\"/qywxFacotoryOrder/factoryOrderLevel?storeAgeLevelId="+carSerCount.getSerid()+"&storeRoomId="+storeRoom.getDbid()+"&carSeriyId="+resultSet.getString("dbid")+"\">"+resultSet.getString("carSTotal")+"</a></td>");
				buffer.append("</tr>");
				totolNum=totolNum+resultSet.getInt("carSTotal");
				out.print(buffer.toString());
			}
			j++;
		}
		if(rowCount>0){
			out.print("<tr> <td align='right' colspan='2' style='padding-right:12px;'>合计："+totolNum+"</td></tr>");
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
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '库存品牌统计'
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
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: '品牌',
            data: ${brandJson}
        }]
    });
});
</script>
</html>