<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html lang="en">
<head>
<title>统计分析</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/jquery.gritter.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body style="background: none repeat scroll 0 0 #EEEEEE;">
<div id="content" style="margin-left: 0">
	<div class="container-fluid">
		<div class="row-fluid">
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-signal"></i>
						</span>
						<h5>线索统计</h5>
					</div>
					<div class="widget-content">
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/statCustomerRecord/queryReceptionStat'">展厅流量统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/statCustomerRecordNet/queryNetStaMonth'">网销线索统计</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-signal"></i>
						</span>
						<h5>潜客分析</h5>
					</div>
					<div class="widget-content">
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/statCustomerInvitation/queryInvitationList'">网销邀约统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/comeShop/queryComeShopList'">客户到店统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/staTryCar/queryTryCarList'">试乘试驾统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/twoComeShop/queryTwoComeShopList'">二次到店统计</a>
						<a href="${ ctx}/statCust/queryList" class="label label-info" style="padding: 8px 12px;margin-right: 12px;">
							基盘客户统计
						</a>
						<a href="${ctx}/statFlow/queryFlowList" class="label label-info" style="padding: 8px 12px;margin-right: 12px;">
							流失客户统计
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-signal"></i>
						</span>
						<h5>订单分析</h5>
					</div>
					<div class="widget-content">
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/qywxOrderStatic/order?type=1&role=gm'">留存订单</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/statOrder/queryOrderList'">订单报表</a>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title">
						<span class="icon">
							<i class="icon-signal"></i>
						</span>
						<h5>回访统计</h5>
					</div>
					<div class="widget-content">
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/customerTrack/queryCustomerTrackCountList'">跟踪超时统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/customerTrackStatic/today?role=sm'">每日回访数据监控</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/statTrack/queryTrackList'">回访数据统计</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
            
<script src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx}/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.gritter.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/jquery.peity.min.js"></script>
<script src="${ctx}/widgets/bootstrap3/unicorn.js"></script>
<script src="${ctx}/widgets/bootstrap3/unicorn.interface.js"></script>
</body>
</html>
