<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html lang="en">
<head>
<title>保险统计分析</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/jquery.gritter.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css" class="skin-color" />	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<style>
	.right{
		font-size: 14px;
		width: auto;
	}
	.stat-boxes .peity_bar_gree, .stat-boxes .peity_line_bad {
    	color: green;
	}
</style>
<body style="background: none repeat scroll 0 0 #EEEEEE;">
<div id="content" style="margin-left: 0">
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>客户统计</h5></div>
					<div class="widget-content nopadding" >
						<ul class="stat-boxes">
							<li>
								<div class="left peity_bar_good"><span>2,4,9,7,12,10,12</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${selfCustomerCount}</strong>
									保有客户
								</div>
							</li>
							<li>
								<div class="left peity_bar_neutral"><span>20,15,18,14,10,9,9,9</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${outCustomerCount }</strong>
									新增客户
								</div>
							</li>
							<li>
								<div class="left peity_bar_bad"><span>3,5,9,7,12,20,10</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${selfCustomerBuyedCount }</strong>
									保有客户（购买）
								</div>
							</li>
							<li>
								<div class="left peity_line_good"><span>12,6,9,3,1,10,7</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${selfCustomerOutFlowCount }</strong>
									保有客户（流失）
								</div>
							</li>
							<li>
								<div class="left peity_bar_good"><span>12,6,9,23,14,10,17</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 18px;">
										<fmt:formatNumber value="${selfCustomerBuyedCount/selfCustomerCount*100 }" pattern="##.0" var="per"></fmt:formatNumber>
										${per }%
									</strong>
									保险渗透率
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12">
				<div class="widget-box">
					<div class="widget-title"><span class="icon"><i class="icon-file"></i></span><h5>销售额统计</h5></div>
					<div class="widget-content nopadding" >
						<ul class="stat-boxes">
							<li>
								<div class="left peity_bar_good"><span>2,4,9,7,12,10,12</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${totalPrice}</strong>
									销售总额
								</div>
							</li>
							<li>
								<div class="left peity_bar_neutral"><span>20,15,18,14,10,9,9,9</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${countStrongRiskPrice }</strong>
									强制险总额
								</div>
							</li>
							<li>
								<div class="left peity_bar_bad"><span>3,5,9,7,12,20,10</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${busiRiskPricePrice }</strong>
									商业险总额
								</div>
							</li>
							<li>
								<div class="left peity_line_good"><span>12,6,9,23,14,10,17</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${rebateMoneyPrice }</strong>
									返利总额
								</div>
							</li>
							<li>
								<div class="left peity_line_good"><span>12,6,9,23,14,10,17</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${strongRiskRebateMoneyPrice }</strong>
									强制险返利总额
								</div>
							</li>
							<li>
								<div class="left peity_line_good"><span>12,6,9,23,14,10,17</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${busiRiskRebateMoneyPrice }</strong>
									商业险返利总额
								</div>
							</li>
							<li>
								<div class="left peity_bar_bad"><span>10,6,20,23,14,10</span></div>
								<div class="right" style="font-size: 12px;width: auto;">
									<strong style="font-size: 16px;">${incidentalInterestMoneyPrice }</strong>
									客户权益总额
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span12 center" style="text-align: center;">					
				<ul class="quick-actions">
					<li>
						<a href="${ctx }/insStatical/insurancecompanyStatical">
							<i class="icon-piechart"></i>
							出单公司分析
						</a>
					</li>
					<li>
						<a href="${ctx }/insStatical/insuranceInfromStatical">
							<i class="icon-graph"></i>
							出单渠道分析
						</a>
					</li>
					<li>
						<a href="${ctx }/insStatical/outFlowStatical">
							<i class="icon-people"></i>
							流失原因分析
						</a>
					</li>
				</ul>
				<%-- <ul class="quick-actions">
					<li>
						<a href="${ ctx}/roomManage/comeTypeStatistics">
							<i class="icon-lock"></i>
							来电进店分析
						</a>
					</li>
					<li>
						<a href="${ ctx}/qywxRoomManageSaleReport/index">
							<i class="icon-book"></i>
							销售报表
						</a>
					</li>
					<li>
						<a href="${ ctx}/roomManage/tryCarStatistics">
							<i class="icon-mail"></i>
							试乘试驾率统计
						</a>
					</li>
					<li>
						<a href="${ctx}/roomManage/overTimeCount">
							<i class="icon-survey"></i>
							跟踪超时统计
						</a>
					</li>
				</ul> --%>
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
