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
						<div class="left peity_bar_good"><span>2</span>${orderCount }</div>
						<div class="right">
							<strong>${newsCount }</strong>
							新登记
						</div>
					</li>
					<li>
						<div class="left peity_bar_neutral"><span>20</span>${orderCount }</div>
						<div class="right">
							<strong>${canncelCount }</strong>
							流失客户
						</div>
					</li>
					<li>
						<div class="left peity_bar_bad"><span>3</span>${orderCount }</div>
						<div class="right">
							<strong>${orderCount }</strong>
							订单客户
						</div>
					</li>
					<li>
						<div class="left peity_line_good"><span>12</span>${waitingCar }</div>
						<div class="right">
							<strong>${waitingCar }</strong>
							待交车客户
						</div>
					</li>
					<li>
						<div class="left peity_line_good"><span>12</span>${customerSuccess }</div>
						<div class="right">
							<strong>${customerSuccess }</strong>
							成交客户
						</div>
					</li>
				</ul>
			</div>	
		</div>
		<div class="row-fluid">
			<div class="span12 center" style="text-align: center;">					
				<ul class="quick-actions">
					<li>
						<a href="${ctx }/statisticsSaler/dataStatistics">
							<i class="icon-database"></i>
							数据分析
						</a>
					</li>
					<li>
						<a href="${ ctx}/statisticsSaler/levelStatistics">
							<i class="icon-book"></i>
							级别分析
						</a>
					</li>
				</ul>
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
