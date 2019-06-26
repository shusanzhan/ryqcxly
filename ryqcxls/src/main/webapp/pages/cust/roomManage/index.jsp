<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html lang="en">
<head>
<title>Unicorn Admin</title>
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
			<div class="span12 center" style="text-align: center;">					
				<ul class="stat-boxes">
					<li>
						<div class="left peity_bar_good"><span>2,4,9,7,12,10,12</span></div>
						<div class="right">
							<strong>${newsCount}</strong>
							新增客户
						</div>
					</li>
					<li>
						<div class="left peity_bar_neutral"><span>20,15,18,14,10,9,9,9</span></div>
						<div class="right">
							<strong>${canncelCount }</strong>
							流失客户
						</div>
					</li>
					<li>
						<div class="left peity_bar_bad"><span>3,5,9,7,12,20,10</span></div>
						<div class="right">
							<strong>${orderCount }</strong>
							订单客户
						</div>
					</li>
					<li>
						<div class="left peity_line_good"><span>12,6,9,23,14,10,17</span></div>
						<div class="right">
							<strong>${waitingCar }</strong>
							待交车客户
						</div>
					</li>
					<li>
						<div class="left peity_bar_bad"><span>2,6,9,2,14,10,17</span></div>
						<div class="right">
							<strong>${customerSuccess }</strong>
							成交客户
						</div>
					</li>
				</ul>
			</div>	
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
						<a href="${ctx }/roomManage/cityCrossCustomer" class="label label-info" style="padding: 8px 12px;margin-right: 12px;">
							同城交叉客户
						</a>
						<a href="${ctx}/qywxRoomManageSaleReport/index" class="label label-info" style="padding: 8px 12px;margin-right: 12px;">
							销售报表
						</a>
						<a href="${ctx}/flow/queryFlowList" class="label label-info" style="padding: 8px 12px;margin-right: 12px;">
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
						<h5>回访统计</h5>
					</div>
					<div class="widget-content">
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/customerTrack/queryCustomerTrackCountList'">跟踪超时统计</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/customerTrackStatic/today?role=sm'">每日回访数据监控</a>
						<a href="javascript:void(-1)" class="label label-info" style="padding: 8px 12px;margin-right: 12px;" onclick="window.location.href='${ctx}/track/queryTrackList'">回访数据统计</a>
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
