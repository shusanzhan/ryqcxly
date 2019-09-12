<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/fullcalendar.css" />	
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
.table-bordered td{
	height: 18px;
    padding-bottom: 3px;
}
.comments a{
color: #FFFFFF;
}
</style>
<title>后台表单页面</title>
</head>
<body>
<div class="container-fluid">
	<div class="row-fluid">
		<div style="text-align: center;" class="span12 center">					
			<ul class="stat-boxes">
				<c:forEach var="custPhase" items="${custPhases }">
					<li>
						<div class="right">
							<strong>${custPhase.totalNum }</strong>
							${custPhase.name }
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>	
	</div>
	<div class="row-fluid">
			<div class="span12">
			<div class="widget-box">
				<div id="pieCustPhaseData" style="min-width: 310px; height: 300px; max-width: 620px; margin: 0 auto"></div>
			</div>
		</div>
	</div>
	<div class="row-fluid">
			<div class="span6">
				<div class="widget-box">
					<div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>今日需跟踪客户</h5><span class="label label-info tip-left" data-original-title="${fn:length(todayCustomerTracks) } 客户">${fn:length(todayCustomerTracks) }</span></div>
				<div class="widget-content nopadding">
					<ul class="recent-comments">
					<c:if test="${empty(todayCustomerTracks) }">
						<li>
							次日无需跟踪客户
						</li>
					</c:if>
					<c:if test="${!empty(todayCustomerTracks) }">
						<c:forEach var="customerTrack" items="${todayCustomerTracks }" end="8">
							<c:set value="${customerTrack.customer }" var="customer"></c:set>
							<li>
								<div class="comments">
									<span class="user-info"> 
										客户:${customer.name }  
										手机：<span style="color: green;font-size: 14px;">${customer.mobilePhone }</span>
										创建时间:<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy年MM月dd日"/> 
										<c:if test="${customerTrack.customerPhaseType==1 }">
											<br>
											到期回访日：
											<span style="color: red;"><fmt:formatDate value="${customerTrack.nextReservationTime }" pattern="yyyy年MM月dd日"/></span>
											<br>
											超时状态：
												<c:if test="${customerTrack.taskOverTimeStatus==1 }">
													<span style="color:green;">未超时</span>
												</c:if>
												<c:if test="${customerTrack.taskOverTimeStatus==2 }">
													<span style="color:  red;">已超时</span>
												</c:if>
										</c:if>
								   </span>
									  
									<p>
									客户车型：
									<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
									${carModel} ${customer.carModelStr}  
									</p>
									<a class="btn btn-primary btn-mini" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }&typeRedirect=1','添加跟进记录',900,500)">添加跟进记录</a>
									|
									<a class="btn btn-danger btn-mini" href="${ctx}/customerLastBussi/customerFlow?customerId=${customer.dbid }&type=2" onclick="">客户流失申请</a> 
								</div>
							</li>
						</c:forEach>
						</c:if>
					</ul>
					<ul class="recent-posts" style="margin-top: 5px;">
						<li class="viewall">
							<a href="${ctx }/customerTrack/dayCustomerTrack" class="tip-top" data-original-title="点击查看更多"> 点击查看更多 </a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="span6">
			<div class="widget-box">
				<div class="widget-title"><span class="icon"><i class="icon-comment"></i></span><h5>未来3天需跟进客户</h5><span class="label label-info tip-left" data-original-title="${fn:length(threeCustomerTracks) } 需跟进客户">${fn:length(threeCustomerTracks) }</span></div>
				<div class="widget-content nopadding">
					<ul class="recent-comments">
					<c:if test="${empty(threeCustomerTracks) }">
					<li>
							<div class="comments">
								<p>
									无需跟进记录客户...
								</p>
							</div>
						</li>
					</c:if>
					  <c:forEach var="customerTrack"  items="${threeCustomerTracks }" >
					  <c:set value="${customerTrack.customer }" var="customer"></c:set>
						<li>
							<div class="comments">
								<span class="user-info"> 
									客户:${customer.name }  
									手机：<span style="color: green;font-size: 14px;">${customer.mobilePhone }</span>
									创建时间:<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy年MM月dd日"/> 
									<br>
									到期回访日：
									<span style="color: red;"><fmt:formatDate value="${customerTrack.nextReservationTime }" pattern="yyyy年MM月dd日"/></span>
							   </span>
								<p>
									客户车型：
									<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
									${carModel} ${customer.carModelStr}  
								</p>
								<a class="btn btn-primary btn-mini" href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }&typeRedirect=1','添加跟进记录',900,500)">添加跟进记录</a> 
							</div>
						</li>
					</c:forEach> 
					</ul>
				</div>
			</div>
		</div>
	</div> 
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
$(function () {
	$('#pieCustPhaseData').highcharts({
		chart: {
			plotBackgroundColor: null,
			plotBorderWidth: null,
			plotShadow: false,
			type: 'pie'
		},
		title: {
			text: '基盘客户等级占比统计分析'
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
			name: '客户级别',
			colorByPoint: true,
			data: ${pieCustPhaseData}
		}]
	});
})
	</script>
</html>
