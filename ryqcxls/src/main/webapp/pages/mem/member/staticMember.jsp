<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../../commons/taglib.jsp" %>
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
<title>会员概况</title>
</head>
<body class="bodycolor">

<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">会员概况</a>
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
					                    <h5>${couponNum }</h5>
					                    <h6>领过优惠</h6>
					                </li>
					                <li>
					                    <h5>${gzUserEventedCount-gzUserEventCancelCount }</h5>
					                    <h6>昨日微信粉丝</h6>
					                </li>
					                <li>
					                    <h5>${yesterdayOrderCount }</h5>
					                    <h6>昨日订单客户</h6>
					                </li>
					                <li>
					                    <h5>
					                    <c:if test="${empty(pointNum) }">
					                    	0
					                    </c:if>
					                    <c:if test="${!empty(pointNum) }">
					                    	 ${pointNum}
					                    </c:if>
					                   </h5>
					                    <h6>昨日赠送积分</h6>
					                </li>
					            </ul>
					        </div>
					
					
					       <div class="clearfix ">
					       		<div id="js-wx-attr" class="widget widget-attr" style="width:56%;float: left;">
					                <div class="widget-inner">
					                    <div class="ui-block-head">
					                        <h3>客户属性</h3>
					                        <div class="ui-block-head-help">
					                            <a href="javascript:void(0);" class="js-help-notes"></a>
					                            <div class="js-notes-cont hide">
					                            </div>
					                        </div>
					                    </div>
					                    <div class="ui-block-content ui-block-border clearfix">
					                        <div class="widget-body with-border" style="min-height: 150px;">
					                            <div class="js-body hide widget-body__inner clearfix" style="display: block;">
					                            	<div id="container1" style="width: 50%;float: left;height: 240px;"></div>
					                            	<div id="container2" style="width: 50%;float: left;height: 240px;"></div>
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <!--  -->
					            <div id="js-level" class="widget widget-level" style="width:40%;float: right;">
					                <div class="widget-inner">
					                    <div class="ui-block-head">
					                        <h3>会员卡</h3>
					                        <nav>
					                            <span>
					                                <a href="//koudaitong.com/v2/fans/cards" target="_blank">
					                                    管理
					                                </a>
					                            </span>
					                        </nav>
					                        <div class="ui-block-head-help">
					                            <a href="javascript:void(0);" class="js-help-notes"></a>
					                            <div class="js-notes-cont hide">
					                                <!-- <p><strong>会员等级：</strong>已创建的所有会员等级规则；</p>
					                                <p><strong>人数：</strong>达到该会员等级的粉丝人数；</p>
					                                <p><strong>占比：</strong>该等级的粉丝人数占所有粉丝人数的比例。</p> -->
					                            </div>
					                        </div>
					                    </div>
					                    <div class="ui-block-content ui-block-border">
					                        <div class="widget-body with-border" style="min-height: 150px;">
					                            <div id="container3" class="js-body hide widget-body__inner" style="display: block; cursor: default;height: 240px;">
					                            	
					                            </div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					            <div style="clear: both;"></div>
					       </div>
							<br>
							<div id="js-wx-area" class="widget widget-list widget-wx-area">
					            <div class="widget-inner">
					                <div class="ui-block-head">
					                    <h3>客户分布</h3>
					                    <div class="ui-block-head-help">
					                        <a href="javascript:void(0);" class="js-help-notes"></a>
					                        <div class="js-notes-cont hide">
					                           <!--  <p><strong>客户分布：</strong>现有微信粉丝个人信息设置的地域分布信息。</p> -->
					                        </div>
					                    </div>
					                </div>
					                <div class="ui-block-content ui-block-border clearfix">
					                    <div class="widget-body with-border" style="min-height: 150px;">
					                        <div class="js-body hide widget-body__inner clearfix" style="display: block;">
					                            <div id="container" class="js-body-chart chart-body" style="cursor: pointer;width: 760px;height: 500px">
					                            	
					                            </div>
					                            <div class="js-body-desc chart-desc">
					             	<table class="table">
									    <thead>
									        <tr>
									            <th>
									                <div class="td-cont">
									                    排名
									                </div>
									            </th>
									            <th>
									                <div class="td-cont">
									                    地区
									                </div>
									            </th>
									            <th>
									                <div class="td-cont">
									                    粉丝数
									                </div>
									            </th>
									        </tr>
										    </thead>
												    <tbody class="js-list-tbody">
												    <c:forEach items="${gzUserProvinces }" var="gzUserProvince" varStatus="i">
												    	<tr>
														    <td>
														        <div class="td-cont">
														            ${i.index+1 }
														        </div>
														    </td>
														    <td>
														        <div class="td-cont">
														            ${gzUserProvince.province }
														        </div>
														    </td>
														    <td>
														        <div class="td-cont">
														           ${gzUserProvince.count }
														        </div>
														    </td>
														</tr>
												    </c:forEach>
												    </tbody>
												</table>
											</div>
					                        </div>
					                    </div>
					                </div>
					            </div>
					        </div>
				    	</div>
					</div>
				</div>
			</div>
   		</div>
   </div>
</div>
<div id="fanye">
	<%@ include file="../../../../commons/commonPagination.jsp" %>
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
	 $('#container1').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        title: {
	            text: ''
	        },
	        tooltip: {
	            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
	        },
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: false
	                },
	                showInLegend: true
	            }
	        },
	        series: [{
	            type: 'pie',
	            name: '客户属性',
	            data: [
	                ['男',  ${maleCount}],
	                ['女',   ${fmaleCount}],
	                {
	                    name: '未知',
	                    y: ${nomaleCount},
	                    sliced: true,
	                    selected: true
	                }
	            ]
	        }]
	    });
    $('#container2').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: '客户属性',
            data: [
                ['购买粉丝',   ${buyCount}],
                {
                    name: '未购买粉丝',
                    y: ${notbuyCount},
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
    $('#container3').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: '客户属性',
            data: [
               ${memberShips}
            ]
        }]
    });
    
});
 $(function () {
	    var data = [
	        ${data}
	    ];

	    $('#container').highcharts('Map', {
	        title : {
	            text : '客户区域分布统计'
	        },
	        subtitle : {
	            text : '地区分布'
	        },
	        mapNavigation: {
	            enabled: true,
	            buttonOptions: {
	                verticalAlign: 'bottom'
	            }
	        },
	        colorAxis: {
	            min: 0
	        },
	        series : [{
	            data : data,
	            mapData: Highcharts.maps['countries/china'],
	            joinBy: 'hc-key',
	            name: '客户分布',
	            states: {
	                hover: {
	                    color: '#BADA55'
	                }
	            },
	            dataLabels: {
	                enabled: true,
	                format: '{point.name}'
	            }
	        }]
	    });
	});
</script>
</body>
</html>