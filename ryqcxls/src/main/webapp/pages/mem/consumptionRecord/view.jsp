<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link rel="stylesheet" href="${ctx}/css/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/select2.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.grey.css"	class="skin-color" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #F9F9F9;
    border: 1px solid #ccc;
    box-shadow: 0 0px 0px rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 10px;
}
.table th, .table td {
    border-top: 0;
    border-bottom: 1px solid #ddd;
    line-height: 20px;
    padding: 2px 5px;
    text-align: left;
    vertical-align: top;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 24px;
    line-height: 20px;
    margin-bottom: 0;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    box-shadow: 0 0 0 rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 0;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 0;
    padding:2px 0 2px 2px;
    vertical-align: middle;
}
</style>
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a>
		<a href="javascript:void(-1)" class="tip-bottom" onclick="window.location.href='${ctx}/consumptionRecord/add'">
			会员消费
		</a>
</div>
<div class="container-fluid">
	<div style="width: 100%;">
		<div style="float: left;margin-top: 10px;">
			<p>
				<a class="btn btn-danger" href="javascript:void(-1)" onclick="window.history.go(-1)">
					<i class="icon-arrow-left icon-white"></i>返回
				</a>
			</p>
		</div>
	</div>
</div>

<div class="container-fluid" style="margin-top: 0;">
		<div class="row-fluid" style="margin-top: 0;">
					<div class="span8">
						<div class="widget-box">
							<div id='te' class="widget-content nopadding" style="padding-bottom: 20px;">
								<table id="shopNumber" class="table table-bordered" >
									<thead>
										<tr>
											<th style="width: 30px;text-align: center;">序号</th>
											<th style="width: 200px;text-align: center;">商品名称</th>
											<th style="width: 80px;text-align: center;">单位</th>
											<th style="width: 100px;text-align: center;">类型</th>
											<th style="width: 80px;text-align: center;">成本价格</th>
											<th style="width: 60px;text-align: center;">销售价格</th>
											<th style="width: 60px;text-align: center;">数量</th>
										</tr>
									</thead>
									<tbody >
										<c:forEach var="consumptionProduct" items="${consumptionProducts }" varStatus="i">
											<tr >
												<td style="text-align: center;">
													${i.index+1 }
												</td>
												<td >
													${consumptionProduct.nProduct.name }
												</td>
												<td id="unit" style="text-align: center;">
													<span>${consumptionProduct.nProduct.unit }</span>
												</td>
												<td id="productType" style="text-align: center;">
													${consumptionProduct.nProduct.nProductType.name }
												</td>
												<td id="cbj" style="text-align: center;">
													${consumptionProduct.nProduct.costPrice}
												</td>
												<td style="text-align: center;">
													${consumptionProduct.price }
												</td>
												<td>
													${consumptionProduct.quality }
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="container-fluid" style="margin-top: 0;">
	<table style="width: 100%">
			<tr>
				<td width="120" align="">优惠金额</td>
				<td>
					<input type="hidden" id="totalPrice" name="consumptionRecord.totalPrice" value="">
					<input type="hidden" id="totalNum" name="consumptionRecord.totalNum" value="">
					${consumptionRecord.discountAmount }
				</td>
			</tr>
			<tr>
				<td>实收金额</td>
				<td>
					${consumptionRecord.payInAmount }
				</td>
			</tr>
			<tr>
				<td>折扣率</td>
				<td>
					${consumptionRecord.rateDiscount }%
				</td>
			</tr>
			<tr>
				<td>备注</td>
				<td colspan="5">
					${consumptionRecord.note }
				</td>
			</tr>
	</table>
</div>
					</div>
					<div class="span4" style="margin-left: 18px;">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-file"></i>
								</span>
								<h5>会员信息</h5>
							</div>
							<div id="memberInfo" class="widget-content nopadding">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td>姓名:${member.name }</td>
											<td>电话:${member.mobilePhone }</td>
										</tr>
										<tr>
											<td>余额:<ystech:urlEncrypt enCode="${member.balance }"/> </td>
											<td>积分:${member.overagePiont }</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-file"></i>
								</span>
								<h5>消费历史记录</h5>
							</div>
							<div id="consumption" class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th style="width: 100px;text-align: center;">消费时间</th>
											<th style="width: 80px;text-align: center;">消费金额</th>
											<th style="width: 80px;text-align: center;">商品数量</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${consumptionRecords }" var="consumptionRecord2">
									<tr>
											<td>
												<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/consumptionRecord/view?dbid=${consumptionRecord.dbid}'">
													<fmt:formatDate value="${consumptionRecord2.createTime }" pattern="yyyy-MM-dd HH:mm"/>
												</a>
											</td>
											<td style="text-align: center;">
												<span>${consumptionRecord2.payInAmount}</span>
											</td>
											<td style="text-align: center;">${consumptionRecord2.totalNum}</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
	</div>

</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
</html>
