<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yz.css?date=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/dashboard.css" type="text/css" rel="stylesheet"/>
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
<style type="text/css">
	body{
		background: #000;
	}
	.clearfix{
		width: 99%;
	}
	.app-inner{
		margin: 0 0 0 1px;
	}
	.ui-block-head{
	}
</style>
<title>微信概况</title>
</head>
<body class="bodycolor">

<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">微信概况</a>
</div>
<div class="app">
	<div class="app-inner clearfix">
		<div class="app-init-container" style="background-color: #fff;">
			<div id="js-app-content" class="app__content js-app-main" style="width: 100% ">
				<div>
					<div class="promote-stat-page">
					    <div class="js-overview">
					    	<br>
					        <div class="ui-overview" style="margin-top: 12px;margin-bottom: 12px;">
					            <ul>
					               <li>
						                <h5>${gzUserEventedCount }</h5>
						                <h6>昨日新增粉丝</h6>
						            </li>
						            <li>
						                <h5>${gzUserEventCancelCount }</h5>
						                <h6>昨日跑路粉丝</h6>
						            </li>
						            <li>
						                <h5>
						                    <a href="${ctx }/weixinGzUserInfo/queryList">
						                        ${gzUserCount }                                </a>
						                </h5>
						                <h6>昨日总粉丝</h6>
						            </li>
					            </ul>
					        </div>
							<div class="ui-block-head">
					            <h3 class="block-title">微信粉丝增减趋势</h3>
					        </div>
					
					        <div class="js-promote-map promote-map">
					            <div class="js-body" style="min-height: 360px; cursor: default;" id="container">
					            </div>
					        </div>
							<div class="ui-block-head">
					            <h3 class="block-title">微信互动趋势</h3>
					        </div>
					
					        <div class="js-promote-map promote-map">
					            <div class="js-body" style="min-height: 360px; cursor: default;" id="container2">
					            </div>
					        </div>
				    	</div>
					</div>
				</div>
			</div>
   		</div>
   </div>
</div>
<script src="${ctx }/widgets/Highmaps/highcharts.js"></script>
<script src="${ctx }/widgets/Highmaps/modules/map.js"></script>
<!--<script src="http://code.highcharts.com/maps/highmaps.js"></script>-->
<script src="${ctx }/widgets/Highmaps/modules/data.js"></script>
<script src="${ctx }/widgets/Highmaps/china-data.js"></script>
<script src="${ctx }/widgets/Highmaps/modules/drilldown.js"></script>
<script type="text/javascript" src="http://sandbox.runjs.cn/uploads/rs/228/zroo4bdf/cn-china-by-peng8.js"></script>
<script type="text/javascript">
$(function () {
    $('#container').highcharts({
        title: {
            text: '7天微信粉丝增减趋势',
            x: -20 //center
        },
        subtitle: {
            text: '',
            x: -20
        },
        xAxis: {
            categories: ${linexAxis}
        },
        yAxis: {
            title: {
                text: '次数'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '次数'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [${line}]
    });
    $('#container2').highcharts({
        title: {
            text: '7天微信互动趋势',
            x: -20 //center
        },
        subtitle: {
            text: '',
            x: -20
        },
        xAxis: {
            categories: ${linexAxis}
        },
        yAxis: {
            title: {
                text: '次数'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '次数'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [${exchange}]
    });
});
</script>
</body>
</html>