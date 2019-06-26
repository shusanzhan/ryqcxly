<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yz.css?date=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/weixin/yzbase.css" type="text/css" rel="stylesheet"/>
<script src="${ctx }/widgets/artDialogMaster/lib/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<link rel="stylesheet" href="${ctx }/widgets/artDialogMaster/css/ui-dialog.css">
<script src="${ctx }/widgets/artDialogMaster/dist/dialog-min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx }/pages/pllm/spread/spread.js"></script>
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
<title>扫描统计</title>
</head>
<script type="text/javascript">
Date.prototype.format = function(format){ 
	var o = { 
	"M+" : this.getMonth()+1, //month 
	"d+" : this.getDate(), //day 
	"h+" : this.getHours(), //hour 
	"m+" : this.getMinutes(), //minute 
	"s+" : this.getSeconds(), //second 
	"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
	"S" : this.getMilliseconds() //millisecond 
	} 

	if(/(y+)/.test(format)) { 
	format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	} 

	for(var k in o) { 
	if(new RegExp("("+ k +")").test(format)) { 
	format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
	} 
	} 
	return format; 
} 
function addDate(days){ 
    var d=new Date(); 
    d.setDate(d.getDate()-days); 
    var m=d.getMonth()+1; 
    return d.getFullYear()+'-'+m+'-'+d.getDate(); 
  } 
 function quickDay(type){
	 $('#quickday').val(type);
	 var nowDay=new Date();
	 $('#end').val(nowDay.format("yyyy-MM-dd"));
	 var end=addDate(type);
	 $('#begin').val(end);
 }
</script>
<body class="bodycolor">

<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">扫描统计</a>
</div>
<div class="app">
	<div class="app-inner clearfix">
		<div class="app-init-container">
			<div class="js-app-inner app-inner-wrap" style="display: block;">
				<div id="js-filter" class="filter-wrap has-bar" style="margin: 5px;padding-top: 12px;">
				<form name="searchPageForm" id="searchPageForm" class="form-horizontal" action="${ctx}/spread/staticQrCode" method="post">
					<input type="hidden" id="quickday" name="quickday" value="${param.quickday }">
				 <table style="margin-top: 12px;">
					    <tbody>
					        <tr>
					            <th>筛选日期：</th>
					            <td>
					                <div class="filter-time">
					                    <input type="text" class="js-start-time input-medium hasDatepicker" onFocus="WdatePicker({isShowClear:true})" id="begin" name="begin" value="${param.begin }" placeholder="开始日期" readonly="" >
					                    至
					                    <input type="text" class="js-end-time input-medium hasDatepicker" onFocus="WdatePicker({isShowClear:true})" id="end" name="end" value="${param.end }" placeholder="结束日期" readonly="" >
					                    <span class="quickday">
					                        <em>快速查看：</em>
					                        <ul class="js-filter-quickday items-ul">
						                        <li data-tag="sevendays" ${param.quickday==7?'class="active"':'' }  onclick="quickDay(7);">
												    <span>最近7天</span>
												</li>
												<li data-tag="thirtydays" ${param.quickday==30?'class="active"':'' }  onclick="quickDay(30);">
												    <span>最近30天</span>
												</li>
											</ul>
					                    </span>
					                </div>
					            </td>
					        </tr>
					    </tbody>
					</table>
					</form>
					<div class="btn-actions">
					    <button type="button" class="js-filter-btn btn btn-primary" data-loading-text="请稍候..." onclick="$('#searchPageForm')[0].submit();">筛选</button>
					</div>
				</div>
					<div id="js-overview" class="dash-bar dash-hello">
				        <div class="js-cont dash-todo long">
					        <div class="ui-overview ui-overview-with-head">
						    <div class="ui-overview-head">
						        <h5>基础数据</h5>
						    </div>
						    <ul>
						        <li>
						            <h5>${scanCount }</h5>
						            <h6>扫码次数</h6>
						        </li>
						        <li>
						            <h5>${scanGzUserCount }</h5>
						            <h6>扫码人数</h6>
						        </li>
						        <li>
						            <h5>${scanNewGzUserCount }</h5>
						            <h6>扫码新增粉丝</h6>
						        </li>
						        <li>
						            <h5>0</h5>
						            <h6>浏览UV</h6>
						        </li>
						        <li>
						            <h5>0</h5>
						            <h6>浏览PV</h6>
						        </li>
						        <li class="gray">
						            <h5>暂无</h5>
						            <h6>扫码打标签</h6>
						        </li>
						    </ul>
						</div>
						<div class="ui-overview ui-overview-with-head">
						    <div class="ui-overview-head">
						        <h5>转化数据</h5>
						    </div>
						    <ul>
						        <li>
						            <h5>
						                <a href="">
						                    ${orderCount}
						                </a>
						            </h5>
						            <h6>下单笔数</h6>
						        </li>
						        <li>
						            <h5>
						            <c:if test="${empty(orderGzUserCount) }">
						            	0
						            </c:if>
						            <c:if test="${!empty(orderGzUserCount) }">
						            	 ${orderGzUserCount }
						            </c:if>
						           </h5>
						            <h6>下单人数</h6>
						        </li>
						        <li>
						            <h5>
						                <a href="">
						                    ${orderPayedCount }
						                </a>
						            </h5>
						            <h6>付款订单</h6>
						        </li>
						        <li>
						            <h5>
						             <c:if test="${empty(orderPayedGzUserCount) }">
						            	0
						            </c:if>
						            <c:if test="${!empty(orderPayedGzUserCount) }">
						            	 ${orderPayedGzUserCount }
						            </c:if>
						            </h5>
						            <h6>付款人数</h6>
						        </li>
						        <li>
						            <h5 class="rmb">
						            <c:if test="${empty(orderPayedMoneyCount) }">
						            	￥0.00
						            </c:if>
						            <c:if test="${!empty(orderPayedMoneyCount) }">
						            	￥${orderPayedMoneyCount }
						            </c:if>
						            </h5>
						            <h6>付款金额</h6>
						        </li>
						        <li>
						            <h5>
						            	 <c:if test="${empty(orderPayedProductCount) }">
							            	0
							            </c:if>
							            <c:if test="${!empty(orderPayedProductCount) }">
							            	${orderPayedProductCount }
							            </c:if>
									</h5>
						            <h6>付款商品件数</h6>
						        </li>
						    </ul>
						</div>
					</div>
		        </div>
		        <!--  -->
		        <div class="clearfix">
		            <div id="js-qr-fans" class="widget widget-left widget-qr-fans">
		                <div class="widget-inner">
		                    <div class="ui-block-head">
		                        <h3>扫码粉丝</h3>
		                        <div class="ui-block-head-help">
		                            <a href="javascript:void(0);" class="js-help-notes"></a>
		                            <div class="js-notes-cont hide">
		                            </div>
		                        </div>
		                    </div>
		                    <div class="widget-body">
		                        <div class="js-body hide widget-body__inner clearfix" id="container" style="display: block; cursor: pointer;height: 240px;">
		                        	
		                        </div>
		                    </div>
		                </div>
		            </div>
		
		            <div id="js-qr-type" class="widget widget-right widget-qr-type">
		                <div class="widget-inner">
		                    <div class="ui-block-head">
		                        <h3>二维码类型</h3>
		                        <div class="ui-block-head-help">
		                            <a href="javascript:void(0);" class="js-help-notes"></a>
		                        </div>
		                    </div>
		                    <div class="widget-body">
		                        <div id="container2" class="js-body hide widget-body__inner" style="display: block; cursor: default;height: 240px;">
		                        
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!--  -->
		        <div class="clearfix">
		            <div id="js-new-fans" class="widget widget-left widget-new-fans">
		                <div class="widget-inner">
		                    <div class="ui-block-head">
		                        <h3>扫码新增粉丝占比</h3>
		                        <div class="ui-block-head-help">
		                            <a href="javascript:void(0);" class="js-help-notes"></a>
		                        </div>
		                    </div>
		                    <div class="widget-body">
		                        <div id="container4"  class="js-body hide widget-body__inner clearfix" style="display: block; cursor: default;height: 240px;">
		                        
		                        </div>
		                    </div>
		                </div>
		            </div>
		
		            <div id="js-order" class="widget widget-right widget-order ui-block-no-data">
		                <div class="widget-inner">
		                    <div class="ui-block-head">
		                        <h3>扫码付款订单占比</h3>
		                        <div class="ui-block-head-help">
		                            <a href="javascript:void(0);" class="js-help-notes"></a>
		                        </div>
		                    </div>
		                     <div class="widget-body">
		                        <div id="container5"  class="js-body hide widget-body__inner clearfix" style="display: block; cursor: default;height: 240px;">
		                        
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!--  -->
		        <div id="js-custom-list" class="widget widget-custom-list">
		            <div class="widget-inner">
		                <div class="ui-block-head" style="margin:auto 0; margin-top: 5px;margin-bottom:5px;">
		                    <h3>带参数二维码数据</h3>
		                    <div style="display: inline-block; margin-left: 10px;"><!-- react-empty: 8 --><a href="javascript:void(0);" target="_blank" onclick="alert('完善中...')">导出明细</a></div>
		                    <div class="ui-block-head-help">
		                        <a href="javascript:void(0);" class="js-help-notes"></a>
		                        <div class="js-notes-cont hide">
		                        </div>
		                    </div>
		                </div>
		                <div class="js-widget-body widget-body" style="height: auto;">
		                    <div class="js-body hide widget-body__inner" style="display: block;">
			                    <table class="ui-table ui-table-thead-weight">
								    <thead>
								        <tr>
								            <th>渠道名称</th>
								            <th>扫码次数</th>
								            <th>引流人数</th>
								            <th>新粉丝</th>
								            <th>老粉丝</th>
								        </tr>
								    </thead>
								    <tbody class="js-list-tbody">
								    	<c:forEach var="spread" items="${spreads2 }">
										    <tr>
											    <td class="td-title" >
											        <a href="" class="new-window" target="_blank">${spread.name }</a>
											    </td>
											    <td >${spread.countNum }</td>
											    <td>${spread.spreadNum}</td>
											    <td>${spread.spreadNum }</td>
											    <td>${spread.countNum-spread.spreadNum }</td>
											</tr>
								    	</c:forEach>
								</tbody>
							</table>
							<div class="js-list-foot list-foot">
							    <div class="js-page-wrap pagenavi">
									<!-- <span class="total">共 3 条，每页 10 条</span> -->
								</div>
							</div>
						</div>
		                </div>
		            </div>
        		</div>
		        <div id="js-custom-list" class="widget widget-custom-list">
		            <div class="widget-inner">
		                <div class="ui-block-head" style="margin:auto 0; margin-top: 5px;margin-bottom:5px;">
		                    <h3>带参数二维码统计明细</h3>
		                    <div class="ui-block-head-help">
		                        <a href="javascript:void(0);" class="js-help-notes"></a>
		                        <div class="js-notes-cont hide">
		                        </div>
		                    </div>
		                </div>
		                <div class="js-widget-body widget-body" style="height: auto;">
		                    <div class="js-body hide widget-body__inner" style="display: block;">
			                    ${spreadDetailStatic }
							<div class="js-list-foot list-foot">
							    <div class="js-page-wrap pagenavi">
									<!-- <span class="total">共 3 条，每页 10 条</span> -->
								</div>
							</div>
						</div>
		                </div>
		            </div>
        		</div>
        		<!--  -->
		        <div id="js-custom-list" class="widget widget-custom-list">
		            <div class="widget-inner">
		                <div class="ui-block-head" style="margin-top: 5px;margin-bottom:5px;;width: 98%">
		                    <h3>商品二维码数据</h3>
		                    <div class="ui-block-head-help">
		                        <a href="javascript:void(0);" class="js-help-notes"></a>
		                        <div class="js-notes-cont hide">
		                        </div>
		                    </div>
		                </div>
		                <div class="js-widget-body widget-body" style="height: auto;">
		                    <div class="js-body hide widget-body__inner" style="display: block;">
		                    	<div class="js-block-content ui-block-no-data-content">暂无数据</div>
							</div>
		                </div>
		            </div>
        		</div>
        		<!--  -->
			</div>
   		</div>
   </div>
</div>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	bindClick();
})
$(function () {
    $('#container').highcharts({
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
            name: '粉丝占比',
            data: [
                ['老粉丝',   ${scanGzUserCount-scanNewGzUserCount}],
                {
                    name: '新粉丝',
                    y: ${scanNewGzUserCount},
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
    $('#container4').highcharts({
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
            name: '新增粉丝占比',
            data: [
                ['扫描新增粉丝',   ${scanNewGzUserCount}],
                {
                    name: '其他新增粉丝',
                    y:  ${gzUserEventedCount-scanNewGzUserCount},
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
    $('#container5').highcharts({
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
            name: '扫码付款订单占比',
            data: [
                ['扫描付款订单',   ${orderPayedCount}],
                {
                    name: '付款订单',
                    y: ${paySuccessCount-orderPayedCount},
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
            name: '粉丝占比',
            data: [
                ${data}
            ]
        }]
    });
});
</script>
</body>
</html>