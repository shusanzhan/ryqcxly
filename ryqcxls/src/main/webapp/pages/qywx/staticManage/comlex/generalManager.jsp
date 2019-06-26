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
<title>集客报表</title>
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
    <span id="page_title">集客报表</span>
    <a class="go_home" href="${ctx }/qywxStat/index">
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
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
         	<c:if test="${param.type==1 }" var="status">
	           <li class="detail_tap5 detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=1&role=${param.role}'">日</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap5 detail_tap pull_left" id="imgs_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=1&role=${param.role}'">日</li>
         	</c:if>
         	<c:if test="${param.type==2 }" var="status">
	           <li class="detail_tap5 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=2&role=${param.role}'">周报</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap5 detail_tap pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=2&role=${param.role}'">周报</li>
         	</c:if>
         	<c:if test="${param.type==3 }" var="status">
	            <li class="detail_tap5 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=3&role=${param.role}'">月报</li>
         	</c:if>
         	<c:if test="${status==false }">
	            <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=3&role=${param.role}'">月报</li>
         	</c:if>
         	<c:if test="${param.type==4 }" var="status">
	           <li class="detail_tap5 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=4&role=${param.role}'">季报</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=4&role=${param.role}'">季报</li>
         	</c:if>
         	<c:if test="${param.type==5 }" var="status">
	           <li class="detail_tap5 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=5&role=${param.role}'">年报</li>
         	</c:if>
         	<c:if test="${status==false }">
	           <li class="detail_tap5 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/qywxComplex/generalManager?type=5&role=${param.role}'">年报</li>
         	</c:if>
           
      	</ul>
     </div>
 </div>
<div class="row-fluid" style="text-align: center;">
	<h4>${title }</h4>
</div>
<c:if test="${param.type==1 }">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		新登记客户:${newsCount }人
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center">H</td>
				<td align="center">A</td>
				<td align="center">B</td>
				<td align="center">C</td>
				<td align="center">O</td>
				<td align="center">总计</td>
			</tr>
			<tr>
				<td align="center">${levelCH }</td>
				<td align="center">${levelCA }</td>
				<td align="center">${levelCB }</td>
				<td align="center">${levelCC }</td>
				<td align="center">${levelCO }</td>
				<td align="center">${newsCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container1" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<br>
</c:if>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		集客意向车型
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">序号</td>
				<td align="center" width="40">车系</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="count" items="${carSeriyCounts }" varStatus="i">
				<tr>
					<td align="center" width="40">${i.index+1 }</td>
					<td align="center" width="80">${count.name }</td>
					<td align="center" width="60">${count.num }</td>
				</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="3" style="text-align: right;">合计：${newsCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container2" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<c:if test="${param.type!=1 }">
	<div class="row-fluid">
			<div class="span6">
			<div class="widget-box">
				<div id="container5" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
			</div>
		</div>
	</div>
</c:if>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		分公司总数据
	</h5>
</div>
<div class="row-fluid">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr>
				<td align="center" width="60">序号</td>
				<td align="center" width="40">公司</td>
				<td align="center" width="40">数量</td>
			</tr>
			<c:forEach var="count" items="${countEnterprises }" varStatus="i">
				<tr>
					<td align="center" width="40">${i.index+1 }</td>
					<td align="center" width="80">${count.name }</td>
					<td align="center" width="60">${count.num }</td>
				</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="3" style="text-align: right;">合计：${newsCount }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container3" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
<c:if test="${param.type!=1 }">
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container4" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
</c:if>
<br>
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		分公司集客明细
	</h5>
</div>
<div class="row-fluid">
	${depDetails }
</div>
<c:if test="${param.type==4 }">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		同比分析
		<select  id="enterPriseId" name="enterPriseId" onchange="ajaxEnterprise(this.value)">
			<option>请选择...</option>
			<c:forEach var="enterprise" items="${enterprises }">
				<option value="${enterprise.dbid }">${enterprise.name }</option>
			</c:forEach>
		</select>
	</h5>
</div>
<div class="row-fluid" id="anEnter">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr id="anEnterAfter">
				<td align="center" width="80">年份</td>
				<td align="center" width="40">1季度</td>
				<td align="center" width="40">2季度</td>
				<td align="center" width="40">3季度</td>
				<td align="center" width="40">4季度</td>
			</tr>
			${culumAnPrise }
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container6" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
</c:if>
<c:if test="${param.type==5 }">
<div class="row-fluid" style="text-align: center;border-bottom: 1px solid #ed145b;margin-bottom: 12px;color:#ed145b;">
	<h5 style="text-align: left;font-size: 16px">
		同比分析
		<select  id="enterPriseId" name="enterPriseId" onchange="ajaxEnterprise(this.value)">
			<option>请选择...</option>
			<c:forEach var="enterprise" items="${enterprises }">
				<option value="${enterprise.dbid }">${enterprise.name }</option>
			</c:forEach>
		</select>
	</h5>
</div>
<div class="row-fluid" id="anEnter">
	<table class="table table-bordered table-striped">
		<tbody>
			<tr id="anEnterAfter">
				<td align="center" width="80">年份</td>
				<td align="center" width="40">1月</td>
				<td align="center" width="40">2月</td>
				<td align="center" width="40">3月</td>
				<td align="center" width="40">4月</td>
				<td align="center" width="40">5月</td>
				<td align="center" width="40">6月</td>
				<td align="center" width="40">7月</td>
				<td align="center" width="40">8月</td>
				<td align="center" width="40">9月</td>
				<td align="center" width="40">10月</td>
				<td align="center" width="40">11月</td>
				<td align="center" width="40">12月</td>
			</tr>
			${culumAnPrise }
		</tbody>
	</table>
</div>
<div class="row-fluid">
		<div class="span6">
		<div class="widget-box">
			<div id="container6" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
		</div>
	</div>
</div>
</c:if>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxComplex/generalManager" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
      	 			<c:if test="${param.type==1 }">
	      	 			<c:if test="${!empty(param.startTime) }">
	      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.startTime) }">
	      	 				<input type="date" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==3 }">
	      	 			<c:if test="${!empty(param.startTime) }">
	      	 				<input type="month" class="form-control" id="startTime" name="startTime" value="${param.startTime }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.startTime) }">
	      	 				<input type="month" class="form-control" id="startTime" name="startTime" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==4 }">
	      	 			<select id="startTime" name="startTime" class="form-control">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.startTime==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
      	 			</c:if>
      	 			<c:if test="${param.type==5 }">
	      	 			<select id="startTime" name="startTime" class="form-control">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.startTime==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
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
$(function () {
	 var data=eval("[ ['H',${levelCH}],['A',${levelCA}], ['B',${levelCB}], ['C',${levelCC}], ['O',${levelCO}]]");
	 $('#container1').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '各级客户'
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
	 $('#container2').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        title: {
	            text: '车系比例'
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
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '车系',
	            data: ${carSeriyPie}
	        }]
	    }); 
	 $('#container3').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        title: {
	            text: '集客比例'
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
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '公司',
	            data: ${pie}
	        }]
	    });
});
	 
</script>
<c:if test="${param.type!=1}">
<script type="text/javascript">
$(function () {
	 $('#container4').highcharts({
	        chart: {
	            type: 'line'
	        },
	        title: {
	            text: '集客趋势'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: ${linexAxis}
	        },
	        yAxis: {
	            title: {
	                text: '登记人次'
	            }
	        },
	        plotOptions: {
	            line: {
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: false
	            }
	        },
	        series:${lineEnterprise}
	    });
	 $('#container5').highcharts({
	        chart: {
	            type: 'line'
	        },
	        title: {
	            text: '车型趋势'
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	            categories: ${linexAxis}
	        },
	        yAxis: {
	            title: {
	                text: '登记人次'
	            }
	        },
	        plotOptions: {
	            line: {
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: false
	            }
	        },
	        series:${lineCarSeriy}
	    });
});
</script>
</c:if>
<c:if test="${param.type>=4}">
<script type="text/javascript">
$(function () {
	 $('#container6').highcharts({
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: '集客同比图'
	        },
	        subtitle: {
	            text: '集客同比趋势图'
	        },
	        xAxis: {
	        	categories: ${linexAxis},
	            crosshair: true
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '集客 (人)'
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}${param.type==4?'季度':'月'}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	            '<td style="padding:0"><b>{point.y:.1f} 人</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: ${culumEnterPrise}
	    });
});
function ajaxEnterprise(val){
	$.ajax({	
		url : '/qywxComplex/ajaxEnterpriseYear?type=${param.type}&role=${param.role}&enterPriseId='+val, 
		data : {}, 
		async : false, 
		timeout : 20000, 
		dataType : "json",
		type:"post",
		success : function(data, textStatus, jqXHR){
			$("#mcover").hide();
			$("#anEnterAfter").nextAll().remove();
			$("#anEnterAfter").after(data.culumAnPrise);
			showHi(data.culumEnterPrise);
		},
		complete : function(jqXHR, textStatus){
			$("#mcover").hide();
		},
		beforeSend : function(jqXHR, configs){
			$("#mcover").show();
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("系统请求超时");
		}
	})
}
function showHi(culumAnPrise){
	 $('#container6').highcharts({
	        chart: {
	            type: 'column'
	        },
	        title: {
	            text: '集客同比图'
	        },
	        subtitle: {
	            text: '集客同比趋势图'
	        },
	        xAxis: {
	        	categories: ${linexAxis},
	            crosshair: true
	        },
	        yAxis: {
	            min: 0,
	            title: {
	                text: '集客 (人)'
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:10px">{point.key}${param.type==4?'季度':'月'}</span><table>',
	            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
	            '<td style="padding:0"><b>{point.y:.1f} 人</b></td></tr>',
	            footerFormat: '</table>',
	            shared: true,
	            useHTML: true
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.2,
	                borderWidth: 0
	            }
	        },
	        series: culumAnPrise
	    });
}
</script>
</c:if>
</html>