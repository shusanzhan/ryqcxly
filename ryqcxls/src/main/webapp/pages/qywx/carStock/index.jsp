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
<title>库存查询</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
    <span id="page_title">库存综合查询</span>
</div>
<br>
<br>
<br>
<div class="mycenterMian" style="">
  	 <article>
              <div class="mycenter">
                  <ul>
                  	<c:forEach var="brand" items="${brands }">
                       <li>
                           <a href="${ctx }/qywxFacotoryOrder/carSeriyList?brandId=${brand.dbid}">
                               <img src="${brand.logo }">
                               <p>${brand.name }</p>
                           </a>
                       </li>
                      </c:forEach>
                  </ul>
              </div>
          </article>
</div>
<ul class="list-group">
<c:if test="${fn:length(carSerCounts)>0 }" var="status">
	<c:forEach var="carSerCount" items="${carSerCounts }">
	 <li class="list-group-item" onclick="window.location.href='${ctx }/qywxFacotoryOrder/carSeriyList?brandId=${carSerCount.serid}'">
	    <span class="badge" id="badgeSelf">
    		<c:if test="${!empty(carSerCount.countNum)}">
	    		${carSerCount.countNum }
	    	</c:if>
	    	<c:if test="${empty(carSerCount.countNum)}">
	    		0
	    	</c:if>
	    </span>
	    ${carSerCount.serName }
	  </li>
	 </c:forEach>
 </c:if>
 <c:if test="${status==false }">
 	 <li class="list-group-item">
 	 	${carSeriy.name } 车系无库存
	 </li>
 </c:if>
</ul>
<!-- <div id="container" style="margin: 0 auto;width: 92%;height: 240px;">
</div> -->
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