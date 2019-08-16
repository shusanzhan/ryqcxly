<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
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
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
	table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
	 height: 40px;
}
.frmContent form table tr td {
    padding-left: 5px;
    height: 50px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
  height: 50px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
.icon-remove {
    background-position: -312px 0;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">订单-费用明细</span>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }&nbsp;&nbsp;${customer.sex }<br/>
	  		电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
			顾问：${customer.bussiStaff}（${customer.department.name}）<br>
		</div>
	</div>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<form  method="post" action="" 	name="frmId" id="frmId">
	<s:token></s:token>
		<c:if test="${empty(orderContractExpenses) }">
			<input type="hidden" name="editType" id="editType" value="${param.editType }" class="largeX text"></input>
			<input type="hidden" name="orderContractId" id="orderContractId" value="${orderContract.dbid }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.dbid" id="dbid" value="${orderContractExpenses.dbid }" class="largeX text"></input>
			<!-- 营收金额（出去预付款总额）车款+装饰+按揭+其他收费；合同总额-预售总额 -->
			<input type="hidden" name="orderContractExpenses.revenuePrice" id="revenuePrice" value="0.0" class="largeX text"></input>
			<!-- 车辆盈利预估(车辆实际销售价-销售顾问结算价） -->
			<input type="hidden" name="orderContractExpenses.carGrofitPrice" id="carGrofitPrice" value="0.0" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.decoreCostMoney" id="decoreCostMoney" value="0.0" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.decoreGrofitPrice" id="decoreGrofitPrice" value="0.0" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.otherCostFeePrice" id="otherCostFeePrice" value="0.0" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.totalGrofitPrice" id="totalGrofitPrice" value="0.0" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.ajsxfGrofit" id="ajsxfGrofit" value="0.0" class="largeX text"></input>
		</c:if>
		<c:if test="${!empty(orderContractExpenses) }">
			<input type="hidden" name="editType" id="editType" value="${param.editType }" class="largeX text"></input>
			<input type="hidden" name="orderContractId" id="orderContractId" value="${orderContract.dbid }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.dbid" id="dbid" value="${orderContractExpenses.dbid }" class="largeX text"></input>
			<!-- 营收金额（出去预付款总额）车款+装饰+按揭+其他收费；合同总额-预售总额 -->
			<input type="hidden" name="orderContractExpenses.revenuePrice" id="revenuePrice" value="${orderContractExpenses.revenuePrice }" class="largeX text"></input>
			<!-- 车辆盈利预估(车辆实际销售价-销售顾问结算价） -->
			<input type="hidden" name="orderContractExpenses.carGrofitPrice" id="carGrofitPrice" value="${orderContractExpenses.carGrofitPrice }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.decoreCostMoney" id="decoreCostMoney" value="${orderContractExpenses.decoreCostMoney }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.decoreGrofitPrice" id="decoreGrofitPrice" value="${orderContractExpenses.decoreGrofitPrice }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.otherCostFeePrice" id="otherCostFeePrice" value="${orderContractExpenses.otherCostFeePrice }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.totalGrofitPrice" id="totalGrofitPrice" value="${orderContractExpenses.totalGrofitPrice }" class="largeX text"></input>
			<input type="hidden" name="orderContractExpenses.ajsxfGrofit" id="ajsxfGrofit" value="${orderContractExpenses.ajsxfGrofit }" class="largeX text"></input>
		</c:if>
		<c:if test="${empty(orderContractExpenses) }">
				<div class="form-group">
					<label class="control-label" for="name">经销商报价：</label>
					<c:if test="${enterprise.bussiType==3 }">
						<input readonly="readonly" type="text" class="form-control" value="${customer.navPrice}" onkeyup="countActMoney()" id="salePrice" name="orderContractExpenses.salePrice"  />
					</c:if>
					<c:if test="${enterprise.bussiType!=3 }">
						<input readonly="readonly" type="text" class="form-control" value="${customer.customerLastBussi.carModel.salePrice }" onkeyup="countActMoney()" id="salePrice" name="orderContractExpenses.salePrice"  />
					</c:if>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">颜色溢价：</label>
						<input  class="form-control" type="number"  name="orderContractExpenses.colorPrice"  id="colorPrice" value="0.0" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" checkType="float,0,"></input>
				</div>
				<div class="form-group">
					<label class="control-label" for="name">裸车销售顾问结算价：</label>
					<c:if test="${customer.user.bussiType==1 }">
						<input type="text" readonly="readonly" value="${carModelSalePolicy.saleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="form-control" ></input>
					</c:if>
					<c:if test="${customer.user.bussiType==2 }">
						<input type="text" readonly="readonly" value="${carModelSalePolicy.netSaleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="form-control" ></input>
					</c:if>
				</div>
			</c:if>
			<c:if test="${!empty(orderContractExpenses) }">
				<div class="form-group">
					<label class="control-label" for="name">经销商报价：</label>
					<c:if test="${enterprise.bussiType==3 }">
						<input readonly="readonly" type="text" class="form-control" value="${customer.navPrice }" onkeyup="countActMoney()" id="salePrice" name="orderContractExpenses.salePrice"  />
					</c:if>
					<c:if test="${enterprise.bussiType!=3 }">
						<input readonly="readonly" type="text" class="form-control" value="${customer.customerLastBussi.carModel.salePrice }" onkeyup="countActMoney()" id="salePrice" name="orderContractExpenses.salePrice"  />
					</c:if>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">颜色溢价：</label>
						<input  class="form-control" type="number"  name="orderContractExpenses.colorPrice"  id="colorPrice" value="${orderContractExpenses.colorPrice }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" checkType="float,0,"></input>
				</div>
				<div class="form-group">
					<label class="control-label" for="name">裸车销售顾问结算价：</label>
					<c:if test="${empty(orderContractExpenses.carSalerPrice )||orderContractExpenses.carSalerPrice<=0 }" var="status">
						<c:if test="${customer.user.bussiType==1 }">
							<input type="text" readonly="readonly" value="${carModelSalePolicy.saleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="form-control" ></input>
						</c:if>
						<c:if test="${customer.user.bussiType==2 }">
							<input type="text" readonly="readonly" value="${carModelSalePolicy.netSaleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="form-control" ></input>
						</c:if>
					</c:if>
					<c:if test="${status==false }">
						<input readonly="readonly" type="text" class="form-control" value="${orderContractExpenses.carSalerPrice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice"/>
					</c:if>
				</div>
			</c:if>
		<div class="form-group">
				<label class="control-label" for="name">裸车现金优惠：</label>
				<input  class="form-control" type="number"  name="orderContractExpenses.cashBenefit"  id="cashBenefit" value="${orderContractExpenses.cashBenefit }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" checkType="float,0,"></input>
				<span style="color: red">*</span>说明：不包含大客户、自有车等特殊权限优惠
		</div>
		<div class="form-group">
				<label class="control-label" for="name">特殊权限优惠：</label>
				<c:if test="${empty(orderContractExpenses) }">
					<input  class="form-control" name="orderContractExpenses.specialPermPrice" id="specialPermPrice" value="0.0" checkType="float,0," onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" ></input>
				</c:if>
				<c:if test="${!empty(orderContractExpenses) }">
					<input  class="form-control" name="orderContractExpenses.specialPermPrice" id="specialPermPrice" value="${orderContractExpenses.specialPermPrice }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();"  checkType="float,0,"></input>
				</c:if>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">特殊权限优惠备注：</label>
				<input  class="form-control"  name="orderContractExpenses.specialPermNote" id="specialPermNote" value="${orderContractExpenses.specialPermNote }" placeholder="如：大客户、二手车置换等特殊优惠政策"></input>
		</div>
		<div class="form-group">
			<label class="control-label" for="name"><span style="color: red">*</span>预收保费：</label>
			<input  class="form-control" type="number"   name="orderContractExpenses.preInsMoney" id="preInsMoney" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.preInsMoney }" onfocus="orderContranctTotalPrice();loanPaymentPer();" onkeyup="orderContranctTotalPrice();loanPaymentPer();"  style="color: red;" checkType="float,0" canEmpty="Y" style="color: red;"></input>
		</div>
		<div class="form-group">
			<label class="control-label" for="name"><span style="color: red">*</span>续保押金：</label>
			<input  class="form-control" type="number"  name="orderContractExpenses.insaranceRenewalDepositPrice" id="insaranceRenewalDepositPrice" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.insaranceRenewalDepositPrice }" onfocus="orderContranctTotalPrice();loanPaymentPer();" onkeyup="orderContranctTotalPrice();loanPaymentPer();"></input>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">购车定金：</label>
				<input  class="form-control" type="number" name="orderContractExpenses.orderMoney" id="orderMoney" value="${orderContractExpenses.orderMoney }" onfocus="target32(this.value)" onkeyup="target32(this.value)"  checkType="float,0,"  ></input>
				<input type="hidden"  class="form-control" readonly="readonly" name="orderContractExpenses.bigOrderMoney" id="bigOrderMoney" value="${orderContractExpenses.bigOrderMoney }" ></input>
		</div>
		<div class="form-group">
				<label class="control-label" for="name">装饰款：</label>
				<input  class="form-control" type="number"  name="orderContractExpenses.masterDecoreMoney"  id="masterDecoreMoney" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.masterDecoreMoney }" onkeyup="decoreTotal();orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" ></input>
				<input  class="form-control" type="hidden"  name="orderContractExpenses.attachDecoreMoney"  id="attachDecoreMoney" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.attachDecoreMoney }" onkeyup="decoreTotal();orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" ></input>
				<input  class="form-control" type="hidden"  readonly="readonly" name="orderContractExpenses.decoreMoney"  id="decoreMoney" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.decoreMoney }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" ></input>
		</div>
		
		<c:if test="${empty(orderContractExpenses) }">
			<div class="form-group">
					<label class="control-label" for="name">付款方式：</label>
					<div>
						<label ><input type="radio" value="1" name="orderContractExpenses.payWay" id="payWay"   checked="checked">现金&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<label ><input type="radio" value="2" name="orderContractExpenses.payWay" id="payWay"  >转账</label>
					</div>
			</div>
			<div class="form-group">
					<label class="control-label" for="name">购车方式：</label>
					<div>
						<label ><input type="radio" value="1" name="orderContractExpenses.buyCarType" id="buyCarType" checked="checked" onclick="showOrHideBuyCarWay(this.value)">现款	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<label ><input type="radio" value="2" name="orderContractExpenses.buyCarType" id="buyCarType"  onclick="showOrHideBuyCarWay(this.value)">分付</label>
						<label style="clear: both;"></label>
					</div>
			</div>
		</c:if>
		<c:if test="${!empty(orderContractExpenses) }">
			<div class="form-group">
					<label class="control-label" for="name">付款方式：</label>
					<div>
						<label ><input type="radio" value="1" name="orderContractExpenses.payWay" id="payWay"   ${orderContractExpenses.payWay==1?'checked="checked"':'' }>现金&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<label ><input type="radio" value="2" name="orderContractExpenses.payWay" id="payWay"   ${orderContractExpenses.payWay==2?'checked="checked"':'' }>转账</label>
					</div>
			</div>
			<div class="form-group">
					<label class="control-label" for="name">购车方式：</label>
					<div>
						<label ><input type="radio" value="1" name="orderContractExpenses.buyCarType" id="buyCarType"   ${orderContractExpenses.buyCarType==1?'checked="checked"':'' } onclick="showOrHideBuyCarWay(this.value)">现款	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<label ><input type="radio" value="2" name="orderContractExpenses.buyCarType" id="buyCarType" ${orderContractExpenses.buyCarType==2?'checked="checked"':'' } onclick="showOrHideBuyCarWay(this.value)">分付</label>
						<label style="clear: both;"></label>
					</div>
			</div>
		</c:if>
		
		<c:if test="${orderContractExpenses.buyCarType==1||empty(orderContractExpenses.buyCarType) }">
			<div id="ajsxfDiv" style="display: none;">
				<div class="form-group">
						<label class="control-label" for="name">按揭手续费：</label>
						<input  class="form-control" type="number" id="ajsxf" name="orderContractExpenses.ajsxf" class="largeX text" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.ajsxf}" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" ></input>
				</div>
				<div class="form-group">
					<label class="control-label" for="name">首付比例：</label>
					<input type="text"   id="paymentPer" name="orderContractExpenses.paymentPer" class="form-control" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.paymentPer }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" checkType="float,0,10" canEmpty="Y" style="color: red;" tip="请输入首付比例"></input>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">首付款：</label>
						<input  class="form-control"  type="number" id="sfk" name="orderContractExpenses.sfk" class="largeX text" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.sfk}" onkeyup="orderContranctTotalPrice();loanSfk()" onfocus="orderContranctTotalPrice();;loanSfk()"></input>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">贷款金额：</label>
						<input  class="form-control" readonly="readonly" type="number" id="daikuan" name="orderContractExpenses.daikuan" class="largeX text" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.daikuan}" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();"></input>
				</div>
			</div>
		</c:if>
		<c:if test="${orderContractExpenses.buyCarType>=2 }">
			<div id="ajsxfDiv">
				<div class="form-group">
						<label class="control-label" for="name">按揭手续费：</label>
						<input  class="form-control" type="number" id="ajsxf" name="orderContractExpenses.ajsxf" class="largeX text" value="${orderContractExpenses.ajsxf }" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" ></input>
				</div>
				<div class="form-group">
					<label class="control-label" for="name">首付比例：</label>
					<input type="text"   id="paymentPer" name="orderContractExpenses.paymentPer" class="form-control" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.paymentPer }" onkeyup="orderContranctTotalPrice();loanPaymentPer();" onfocus="orderContranctTotalPrice();loanPaymentPer();" checkType="float,0,10" canEmpty="Y" style="color: red;" tip="请输入首付比例"></input>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">首付款：</label>
						<input  class="form-control"  type="number" id="sfk" name="orderContractExpenses.sfk" class="largeX text" value="${orderContractExpenses.sfk }" onkeyup="orderContranctTotalPrice();loanSfk()" onfocus="orderContranctTotalPrice();;loanSfk()"></input>
				</div>
				<div class="form-group">
						<label class="control-label" for="name">贷款金额：</label>
						<input  class="form-control" readonly="readonly" type="number" id="daikuan" name="orderContractExpenses.daikuan" class="largeX text" value="${orderContractExpenses.daikuan }" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();"></input>
				</div>
			</div>
		</c:if>
		<div class="form-group">
			<label class="control-label" for="name">备注：</label>
				<input type="text" class="form-control" id="note" name="orderContractExpenses.note"  class="largeX text" value="${orderContractExpenses.note }" />
		</div>
		<div class="frmTitle" onclick="showOrHiden('contactTable')"><label class="control-label" for="name">其他收费（<span style="color: red;font-size: 12px">如：高开票税费、服务费</span>）</label></div>
		<div id='chargeItemDiv' style="width: 100%">
			<table id="chargeItem" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
				<thead>
					<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 120px;text-align: center;">收费项目</th>
						<th style="width: 60px;text-align: center;">收费金额</th>
						<th style="width: 100px;text-align: center;">备注</th>
						<th style="width: 40px;text-align: center;">操作</th>
					</tr>
				</thead>
				<tbody style="overflow: scroll;">
				<!-- 添加时展示页面 -->
						<c:forEach var="orderContractExpensesChargeItem" items="${orderContractExpensesChargeItems }" varStatus="inde">
							<tr id="tr${inde.index+1 }">
									<td style="text-align: center;">
										${inde.index+1 }
									</td>
									<td >
										<input type="text"  name="chargeItemName" id="chargeItemName${inde.index+1 }" value="${orderContractExpensesChargeItem.chargeItemName }" onFocus="autoCharegeItemByName('chargeItemName${inde.index+1 }');createChargItem(this)"  class="form-control" style="width: 98%;">
										<input type="hidden" name="chargeItemDbid" id="chargeItemDbid${inde.index+1}" value="${orderContractExpensesChargeItem.chargeItemId }" onblur="create(this)" >
									</td>
									<td>
										<input type="number" name="chargeItemPrice" id="chargeItemPrice${inde.index+1 }" value="${orderContractExpensesChargeItem.price }" class="form-control" style="width: 98%;" onfocus="chargePrice()" onkeyup="chargePrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
									</td>
									<td style="text-align: center;">
										<input type="text"  name="chargeItemNote" id="chargeItemNote${inde.index+1 }" value="${orderContractExpensesChargeItem.note }" class="form-control" style="width: 98%;" >
									</td>
									<td style="text-align: center;padding-top: 8px;">
										<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)" >
											<i class="icon-remove icon-black" > </i>
										</a>
									</td>
								</tr>
						</c:forEach>
						<c:if test="${fn:length(orderContractExpensesChargeItems)<4 }">
							<c:forEach var="i" begin="${fn:length(orderContractExpensesChargeItems) }" step="1" end="3">
								<tr id="tr${i+1 }">
									<td style="text-align: center;">
										${i+1 }
									</td>
									<td >
										<input type="text"  name="chargeItemName" id="chargeItemName${i+1 }" onFocus="autoCharegeItemByName('chargeItemName${i+1 }');createChargItem(this)"  class="form-control" style="width: 98%;">
										<input type="hidden" name="chargeItemDbid" id="chargeItemDbid${i+1}" onblur="create(this)" >
									</td>
									<td>
										<input type="number" name="chargeItemPrice" id="chargeItemPrice${i+1 }" class="form-control" style="width: 98%;" onfocus="chargePrice()" onkeyup="chargePrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
									</td>
									<td style="text-align: center;">
										<input type="text"  name="chargeItemNote" id="chargeItemNote${i+1 }" class="form-control" style="width: 98%;" >
									</td>
									<td style="text-align: center;padding-top: 8px;">
										<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)" >
											<i class="icon-remove icon-black" > </i>
										</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
				</tbody>
			</table>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;border-top: 0px;" >
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;border-top: 0px;">
					<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;border-top: 0px;">其他收费总额:<span style="font-size: 20px;color: red;margin:0 5px;" id="otherFeePriceText">
					<c:if test="${empty(orderContractExpenses.otherFeePrice) }">
						0.0
					</c:if> 
					<c:if test="${!empty(orderContractExpenses.otherFeePrice) }">
						${ orderContractExpenses.otherFeePrice}
					</c:if> 
					</span>元</td>
				</tr>
			</table>
		</div>
		<div class="frmTitle" onclick="showOrHiden('contactTable')"><label class="control-label" for="name">预收款项（<span style="color: red;font-size: 12px">如：惠民、二手车置换、大客户</span>）</label></div>
		<div id='te' style="width: 100%">
				<table id="preferenceItem" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
					<thead>
						<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
							<th style="width: 30px;text-align: center;">序号</th>
							<th style="width: 100px;text-align: center;">优惠项目</th>
							<th style="width: 60px;text-align: center;">优惠金额</th>
							<th style="width: 120px;text-align: center;">备注</th>
							<th style="width: 40px;text-align: center;">操作</th>
						</tr>
					</thead>
					<tbody style="overflow: scroll;">
					<!-- 添加时展示页面 -->
							<c:forEach var="orderContractExpensesPreferenceItem" items="${orderContractExpensesPreferenceItems }" varStatus="inde">
							<tr id="tr${inde.index+1 }">
									<td style="text-align: center;">
										${inde.index+1 }
									</td>
									<td >
										<input type="text" name="preferenceItemName" id="preferenceItemName${inde.index+1 }" value="${orderContractExpensesPreferenceItem.preferenceItemName }" onFocus="autoPreferenceItemByName('preferenceItemName${inde.index+1 }');createPreferenceItem(this)" tip="输入优惠项目拼音码" class="form-control" style="width: 98%;">
										<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid${inde.index+1}" value="${orderContractExpensesPreferenceItem.preferenceItemId }"  style="width: 100%;">
									</td>
									<td>
										<input type="number" name="preferencePrice" id="preferencePrice${inde.index+1 }" value="${orderContractExpensesPreferenceItem.price }" class="form-control" style="width: 98%;"onfocus="preferenceItemPrice()" onkeyup="preferenceItemPrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
									</td>
									<td style="text-align: center;">
										<input type="text"   name="preferenceNote" id="preferenceNote${inde.index+1 }" value="${orderContractExpensesPreferenceItem.note }" class="form-control" style="width: 98%;" >
									</td>
									
									<td style="text-align: center;padding-top: 8px;">
										<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)" >
											<i class="icon-remove icon-black" > </i>
										</a>
									</td>
								</tr>
						</c:forEach>
						<c:if test="${fn:length(orderContractExpensesPreferenceItems)<4 }">
							<c:forEach var="i" begin="${fn:length(orderContractExpensesPreferenceItems) }" step="1" end="3">
								<tr id="tr${i+1 }">
									<td style="text-align: center;">
										${i+1 }
									</td>
									<td >
										<input type="text" name="preferenceItemName" id="preferenceItemName${i+1 }" onFocus="autoPreferenceItemByName('preferenceItemName${i+1 }');createPreferenceItem(this)" tip="输入优惠项目拼音码"  class="form-control" style="width: 98%;">
										<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid${i+1}"  style="width: 100%;">
									</td>
									<td>
										<input type="number" name="preferencePrice" id="preferencePrice${i+1 }" class="form-control" style="width: 98%;"onfocus="preferenceItemPrice()" onkeyup="preferenceItemPrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
									</td>
									<td style="text-align: center;">
										<input type="text"   name="preferenceNote" id="preferenceNote${i+1 }" class="form-control" style="width: 98%;" >
									</td>
									
									<td style="text-align: center;padding-top: 8px;">
										<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)" >
											<i class="icon-remove icon-black" > </i>
										</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<table  border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;border-top: 0px;" >
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;border-top: 0px;">
						<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;border-top: 0px;">预收款项总额:
							<span style="font-size: 20px;color: red;margin:0 5px;" id="advanceTotalPriceText">
							<c:if test="${empty(orderContractExpenses.advanceTotalPrice) }">
								0.0
							</c:if> 
							<c:if test="${!empty(orderContractExpenses.advanceTotalPrice) }">
								${orderContractExpenses.advanceTotalPrice }
							</c:if>
							</span>元
						</td>
					</tr>
				</table>
			</div>
		<div class="form-group">
				<label class="control-label" for="name">其它收费总额：</label>
					<input readonly="readonly" type="text" class="form-control" id="otherFeePrice" name="orderContractExpenses.otherFeePrice" class="largeX text enable" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.otherFeePrice }" />
					说明：其他收费合计
			</div>
			<div class="form-group">
				<label class="control-label" for="name">预收款总额：</label>
					<input readonly="readonly" type="text" class="form-control" id="advanceTotalPrice" name="orderContractExpenses.advanceTotalPrice" class="largeX text enable" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.advanceTotalPrice }" />
					说明：预收款项合计
			</div>

			<div class="form-group">
				<label class="control-label" for="name">未折让权限：</label>
					<input readonly="readonly" type="text" class="form-control" id="noWllowancePrice" name="orderContractExpenses.noWllowancePrice" class="largeX text enable" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.noWllowancePrice }" />
			</div>
			<div class="form-group">
				<label class="control-label" for="name">裸车销售价：</label>
					<input readonly="readonly" type="text" class="form-control" id="carActurePrice" name="orderContractExpenses.carActurePrice"  class="largeX text enable" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.carActurePrice }" />
					<input readonly="readonly" type="hidden" class="form-control" id="carTotalPrice" name="orderContractExpenses.carTotalPrice"   value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.carTotalPrice }"></input>
					裸车销售价=经销商报价+颜色溢价-裸车现金优惠-特殊政策优惠
			</div>
			<div class="form-group">
				<label class="control-label" for="name">贷款车价：</label>
					<input readonly="readonly" type="text" class="form-control" id="loanCarPrice" name="orderContractExpenses.loanCarPrice"  class="largeX text enable" value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.loanCarPrice }" />
					贷款车价=裸车销售价
			</div>
			<div class="form-group">
				<label class="control-label" for="name">合同总金额：</label>
				<input  class="form-control" readonly="readonly" type="number" name="orderContractExpenses.totalPrice" id="totalPrice" value="${orderContractExpenses.totalPrice }" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" checkType="float,1," ></input>
				合同总金额=车辆总价+其它收费总额+预收款总额+装饰款+按揭手续费+预收保费+续保押金
			</div>
			<div class="form-group">
				<label class="control-label" for="name">实收金额：</label>
				<input  class="form-control" readonly="readonly" type="number" id="actureCollectedPrice" name="orderContractExpenses.actureCollectedPrice"   value="${empty(orderContractExpenses)==true?'0.0':'' }${orderContractExpenses.actureCollectedPrice }"></input>
				实收金额=合同总金额-定金-贷款总额
			</div>
			
		</form>
	<div class="formButton">
	   		<input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxOrderContractExpenses/saveOrderContractDecore')">
	   		<br>
	</div>
</div>
<br>
<br>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
function submitFrm(frmId,url){
	try {
		if(validateForm(frmId)){
		if (undefined != frmId && frmId != "") {
			var params = $("#" + frmId).serialize();
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							showMo(data[0].message,false);
							$(".addbutton").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							showMo(data[0].message,true);
							setTimeout(
									function() {
										window.location.href = obj[0].url
									}, 1000);
						}
					},
					complete : function(jqXHR, textStatus){
						$(".addbutton").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".addbutton").attr("onclick");
						$(".addbutton").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
								showMo(data[0].message);
							$(".addbutton").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		}
	} catch (e) {
		showMo(e,false);
		return;
	}
}
////////////////////////////////优惠项目js模板////////////////////////////////////
//自动添加优惠项目
function autoPreferenceItemByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/preferenceItem/autoPreferenceItem",{
			extraParams:{customerType:"${customer.recordType}"},
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>名称："+row.name+"&nbsp;&nbsp;默认金额："+row.defaultPrice+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect);
	//计算总金额
}
//绑定数据
function onRecordSelect(event, data, formatted) {
	var id=$(event.currentTarget).attr("id");
	var sn=id.substring(18,id.length);
	//判断是否有重复的项目
	var names=$("#preferenceItem input[name=preferenceItemName]");
	var status=false;
	for(var i=0;i<names.length;i++){
		var name=$(names[i]).val();
		if(id!=$(names[i]).attr("id")){
			if(data.name==name){
				status=true;
				break;
			}	
		}
	}
	if(status==false){
		$("#preferenceItemName"+sn).val(data.name);
		$("#preferenceItemDbid"+sn).val(data.dbid);
		$("#preferencePrice"+sn).val(data.defaultPrice);
		preferenceItemPrice();
	}else{
		alert("已经添加该项目，不能重复添加！");
	}
}
//计算优惠金额
function preferenceItemPrice(){
	var prices=$("#preferenceItem input[name=preferencePrice]");
	var totalA=0.0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		if(null!=price&&price!=''){
			price=parseInt(price);
			if(!isNaN(price)){
				totalA=totalA+price;
			}else{
				totalA=totalA+0;
			}
		}
	}
	$("#advanceTotalPrice").val(formatFloat(totalA));
	$("#advanceTotalPriceText").text(formatFloat(totalA));
	orderContranctTotalPrice();loanPaymentPer();
}
//删除表格行
function deletePreferenceTr(tr) {
	// 删除规格值
	if ($("#preferenceItem").find("tr").size() <= 2) {
		alert("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#preferenceItem").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		preferenceItemPrice();
	}
}
//商品表格编辑部分
function createPreferenceItem(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#preferenceItem tr").last().attr("id")){
		createPreferenceItemTr();
		$("#preferenceItemDiv").scrollTop($("#preferenceItem")[0].scrollHeight);
	}
}
//添加表格行
function createPreferenceItemTr() {
	var size = $("#preferenceItem").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="preferenceItemName" id="preferenceItemName'+size+'" value=""  onFocus=\'autoPreferenceItemByName("preferenceItemName'+size+'");createPreferenceItem(this)\' class="form-control" style="width: 98%;"/>'
			+ '<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" name="preferencePrice" id="preferencePrice'+size+'" class="form-control" style="width: 98%;" onfocus="preferenceItemPrice()" onkeyup="preferenceItemPrice()"  checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="preferenceNote" id="preferenceNote'+size+'" class="form-control" style="width: 98%;" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#preferenceItem").append(str);
}
/////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////附件项目js模板////////////////////////////////////

//自动添加附件费用金额
function autoCharegeItemByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/chargeItem/autoChargeItem",{
			extraParams:{customerType:"${customer.recordType}"},
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>名称："+row.name+"&nbsp;&nbsp;默认收款："+row.defaultPrice+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onCharegeItemSelect);
	//计算总金额
}

function onCharegeItemSelect(event, data, formatted) {
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(14,id.length);
		//判断是否有重复的项目
		var names=$("#chargeItem input[name=chargeItemName]");
		var status=false;
		for(var i=0;i<names.length;i++){
			var name=$(names[i]).val();
			if(id!=$(names[i]).attr("id")){
				if(data.name==name){
					status=true;
					break;
				}	
			}
		}
		if(status==false){
			$("#chargeItemName"+sn).val(data.name);
			$("#chargeItemDbid"+sn).val(data.dbid);
			$("#chargeItemPrice"+sn).val(data.defaultPrice);
			chargePrice();
		}else{
			alert("已经添加该项目，不能重复添加！");
		}
		
}
//计算优惠金额
function chargePrice(){
	var prices=$("#chargeItem input[name=chargeItemPrice]");
	var names=$("#chargeItem input[name=chargeItemName]");
	var totalA=0.0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		var name=$(names[i]).val()
		if(null!=price&&price!=''){
			price=parseInt(price);
			if(!isNaN(price)){
				totalA=totalA+price;
			}else{
				totalA=totalA+0;
			}
		}
	}
	
	$("#otherFeePrice").val(formatFloat(totalA));
	$("#otherFeePriceText").text(formatFloat(totalA));
	orderContranctTotalPrice();loanPaymentPer();
}
function deleteChareTr(tr) {
	// 删除规格值
	if ($("#chargeItem").find("tr").size() <= 2) {
		alert("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		var chargeItemPrice=$(tr).parent().parent().find("input[name=chargeItemPrice]").val();
		var chargeItemName=$(tr).parent().parent().find("input[name=chargeItemName]").val();
		$(dd).remove();
		 $("#chargeItem").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		chargePrice();
	}
}
//商品表格编辑部分
function createChargItem(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#chargeItem tr").last().attr("id")){
		createChargItemTr();
		$("#chargeItemDiv").scrollTop($("#chargeItem")[0].scrollHeight);
	}
}
function createChargItemTr() {
	var size = $("#chargeItem").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="chargeItemName" id="chargeItemName'+size+'" value=""  onFocus=\'autoCharegeItemByName("chargeItemName'+size+'");createChargItem(this)\' class="form-control" style="width: 98%;"/>'
			+ '<input type="hidden" name="chargeItemDbid" id="chargeItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="chargeItemPrice" id="chargeItemPrice'+size+'" class="form-control" style="width: 98%;" onfocus="chargePrice()" onkeyup="chargePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text"  name="chargeItemNote" id="chargeItemNote'+size+'" class="form-control" style="width: 98%;" >'
			+ '</td>'
		
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#chargeItem").append(str);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function decoreTotal(){
	//主合同装饰
	   var masterDecoreMoney=$("#masterDecoreMoney").val();
	   if(null!=masterDecoreMoney&&masterDecoreMoney!=''){
		   masterDecoreMoney=parseFloat(masterDecoreMoney);
		   if(isNaN(masterDecoreMoney)){
			   masterDecoreMoney=0; 
		   }
	   }else{
		   masterDecoreMoney=0;
	   }
		//附加合同装饰
	   var attachDecoreMoney=$("#attachDecoreMoney").val();
	   if(null!=attachDecoreMoney&&attachDecoreMoney!=''){
		   attachDecoreMoney=parseFloat(attachDecoreMoney);
		   if(isNaN(attachDecoreMoney)){
			   attachDecoreMoney=0; 
		   }
	   }else{
		   attachDecoreMoney=0;
	   }
	   var decoreMoney=masterDecoreMoney+attachDecoreMoney;
	   $("#decoreMoneyText").text(decoreMoney);
	   $("#decoreMoney").val(decoreMoney);
}
//计算合同金额
//计算合同金额
function orderContranctTotalPrice(){
	   //按揭成数
	   var paymentPer=$("#paymentPer").val();
	   if(null!=paymentPer&&paymentPer!=''){
		   paymentPer=parseFloat(paymentPer);
		   if(isNaN(paymentPer)){
			   paymentPer=0; 
		   }
	   }else{
		   paymentPer=0;
	   }
	//经销商报价
	   var salePrice=$("#salePrice").val();
	   if(null!=salePrice&&salePrice!=''){
		   salePrice=parseFloat(salePrice);
		   if(isNaN(salePrice)){
			   salePrice=0; 
		   }
	   }else{
		   salePrice=0;
	   }
	   //挂车价
	   var trailerPrice=$("#trailerPrice").val();
	   if(null!=trailerPrice&&trailerPrice!=''){
		   trailerPrice=parseFloat(trailerPrice);
		   if(isNaN(trailerPrice)){
			   trailerPrice=0; 
		   }
	   }else{
		   trailerPrice=0;
	   }
	   //挂车结算价
	   var trailerSalerPrice=$("#trailerSalerPrice").val();
	   if(null!=trailerSalerPrice&&trailerSalerPrice!=''){
		   trailerSalerPrice=parseFloat(trailerSalerPrice);
		   if(isNaN(trailerSalerPrice)){
			   trailerSalerPrice=0; 
		   }
	   }else{
		   trailerSalerPrice=0;
	   }
		//现金优惠金额
	   var cashBenefit=$("#cashBenefit").val();
	   if(null!=cashBenefit&&cashBenefit!=''){
		   cashBenefit=parseFloat(cashBenefit);
		   if(isNaN(cashBenefit)){
			   cashBenefit=0; 
		   }
	   }else{
		   cashBenefit=0;
	   }
		//定金
	   var orderMoney=$("#orderMoney").val();
	   if(null!=orderMoney&&orderMoney!=''){
		   orderMoney=parseFloat(orderMoney);
		   if(isNaN(orderMoney)){
			   orderMoney=0; 
		   }
	   }else{
		   orderMoney=0;
	   }
		 //贷款额度
	   var daikuan=$("#daikuan").val();
	   if(null!=daikuan&&daikuan!=''){
		   daikuan=parseFloat(daikuan);
		   if(isNaN(daikuan)){
			   daikuan=0; 
		   }
	   }else{
		   daikuan=0;
	   }
		 //贷款额度
	   var loanPaymentPrice=$("#loanPaymentPrice").val();
	   if(null!=loanPaymentPrice&&loanPaymentPrice!=''){
		   loanPaymentPrice=parseFloat(loanPaymentPrice);
		   if(isNaN(loanPaymentPrice)){
			   loanPaymentPrice=0; 
		   }
	   }else{
		   loanPaymentPrice=0;
	   }
	   //颜色溢价
	   var colorPrice=$("#colorPrice").val();
	   if(null!=colorPrice&&colorPrice!=''){
		   colorPrice=parseFloat(colorPrice);
		   if(isNaN(colorPrice)){
			   colorPrice=0; 
		   }
	   }else{
		   colorPrice=0;
	   }
	   //装饰款
	   var decoreMoney=$("#decoreMoney").val();
	   if(null!=decoreMoney&&decoreMoney!=''){
		   decoreMoney=parseFloat(decoreMoney);
		   if(isNaN(decoreMoney)){
			   decoreMoney=0; 
		   }
	   }else{
		   decoreMoney=0;
	   }
	   //预收保费
	   var preInsMoney=$("#preInsMoney").val();
	   if(null!=preInsMoney&&preInsMoney!=''){
		   preInsMoney=parseFloat(preInsMoney);
		   if(isNaN(preInsMoney)){
			   preInsMoney=0; 
		   }
	   }else{
		   preInsMoney=0;
	   }
		//续保押金
	   var insaranceRenewalDepositPrice=$("#insaranceRenewalDepositPrice").val();
	   if(null!=insaranceRenewalDepositPrice&&insaranceRenewalDepositPrice!=''){
		   insaranceRenewalDepositPrice=parseFloat(insaranceRenewalDepositPrice);
		   if(isNaN(insaranceRenewalDepositPrice)){
			   insaranceRenewalDepositPrice=0; 
		   }
	   }else{
		   insaranceRenewalDepositPrice=0;
	   }
	   //特殊权限
	   var specialPermPrice=$("#specialPermPrice").val();
	   if(null!=specialPermPrice&&specialPermPrice!=''){
		   specialPermPrice=parseFloat(specialPermPrice);
		   if(isNaN(specialPermPrice)){
			   specialPermPrice=0; 
		   }
	   }else{
		   specialPermPrice=0;
	   }
	   //按揭手续费
	   var ajsxf=$("#ajsxf").val();
	   if(null!=ajsxf&&ajsxf!=''){
		   ajsxf=parseFloat(ajsxf);
		   if(isNaN(ajsxf)){
			   ajsxf=0; 
		   }
	   }else{
		   ajsxf=0;
	   }
	   //预收项目总金额
	   var advanceTotalPrice=$("#advanceTotalPrice").val();
	   if(null!=advanceTotalPrice&&advanceTotalPrice!=''){
		   advanceTotalPrice=parseFloat(advanceTotalPrice);
		   if(isNaN(advanceTotalPrice)){
			   advanceTotalPrice=0; 
		   }
	   }else{
		   advanceTotalPrice=0;
	   }
	   //其他收费项目总额
	   var otherFeePrice=$("#otherFeePrice").val();
	   if(null!=otherFeePrice&&otherFeePrice!=''){
		   otherFeePrice=parseFloat(otherFeePrice);
		   if(isNaN(otherFeePrice)){
			   otherFeePrice=0; 
		   }
	   }else{
		   otherFeePrice=0;
	   }
	   ///车辆销售顾问结算价
	   var carSalerPrice=$("#carSalerPrice").val();
	   if(null!=carSalerPrice&&carSalerPrice!=''){
		   carSalerPrice=parseFloat(carSalerPrice);
		   if(isNaN(carSalerPrice)){
			   carSalerPrice=0; 
		   }
	   }else{
		   carSalerPrice=0;
	   }
	   
	   //合同总金额
	   var totalPrice=0;
	   //车辆实际销售价格:carActurePrice,营收金额:revenuePrice,车辆盈利预估:carGrofitPrice
	   var carActurePrice=0,revenuePrice=0,carGrofitPrice=0,actureCollectedPrice=0,carTotalPrice=0;
	   //车辆实际销售价(指导价-现金优惠-特殊政策优惠）   
	   carActurePrice=salePrice-cashBenefit-specialPermPrice+colorPrice;
	   $("#carActurePrice").val(formatFloat(carActurePrice));
	   
	   //车辆总价=车辆实际销售价+挂车价
	   carTotalPrice=carActurePrice+trailerPrice
	   $("#carTotalPrice").val(carTotalPrice);
	   
	   //合同总金额 （车辆总价+其它收费总额+预收款总额+装饰款+按揭手续费+预收保费+续保押金）
	   totalPrice=carTotalPrice+otherFeePrice+advanceTotalPrice+ajsxf+decoreMoney+preInsMoney+insaranceRenewalDepositPrice;
	   $("#totalPrice").val(formatFloat(totalPrice));
	   
	   //实收金额=合同总金额-定金-贷款总额
	   actureCollectedPrice=totalPrice-orderMoney-daikuan;
	   $("#actureCollectedPrice").val(formatFloat(actureCollectedPrice));
	   
	   //车辆盈利预估(车款-销售顾问结算价）
	   carGrofitPrice=carActurePrice-carSalerPrice;
	   
	  
	   //营收金额=合同总额-预收总额-续保押金
	   revenuePrice=totalPrice-advanceTotalPrice-insaranceRenewalDepositPrice;
	   $("#revenuePrice").val(formatFloat(revenuePrice));
	   
	   //计算车辆贷款额
	   loanCarPriceFun();
	   
	   //计算贷款额度信息（以系数）
	   
	   
   var hiscarSalerPrice="${orderContractExpenses.carSalerPrice }";
   if(null!=hiscarSalerPrice&&hiscarSalerPrice!=''){
	   if(hiscarSalerPrice=="0.0"){
		   hiscarSalerPrice="${carModelSalePolicy.saleCsprice}";
	   }
   }
   var hisspecialPermPrice="${orderContractExpenses.specialPermPrice }";
   if(null!=hisspecialPermPrice&&hisspecialPermPrice!=''){
	   hisspecialPermPrice=parseFloat(hisspecialPermPrice);
	   if(isNaN(hisspecialPermPrice)){
		   hisspecialPermPrice=0; 
	   }
   }else{
	   hisspecialPermPrice=0;
   }
   if(specialPermPrice!=hisspecialPermPrice){
	   carSalerPrice=hiscarSalerPrice-specialPermPrice;
	   $("#carSalerPrice").val(formatFloat(carSalerPrice));
   }
   
   //未折让权限=裸车实际销售价-销售顾问结算价
   var noWllowancePrice=carActurePrice-carSalerPrice;
    $("#noWllowancePrice").val(noWllowancePrice);
    
   
}
function loanCarPriceFun(){
	var loanCarPrice=0;
	//计算贷款车价
   var buyCarType=$('input:radio[name="orderContractExpenses.buyCarType"]:checked').val();
    if(buyCarType>1){
    	  var carActurePrice=$("#carActurePrice").val();
	  	   if(null!=carActurePrice&&carActurePrice!=''){
	  		 carActurePrice=parseFloat(carActurePrice);
	  		   if(isNaN(carActurePrice)){
	  			 carActurePrice=0; 
	  		   }
	  	   }else{
	  		 carActurePrice=0;
	  	   }
    	 loanCarPrice=carActurePrice;
    }else{
    	loanCarPrice=0;
    }
    loanCarPrice=parseFloat(loanCarPrice);
	$("#loanCarPrice").val(loanCarPrice);
}

function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
        alert('function:changeTwoDecimal->parameter error');
        return 0;
    }
    var f_x = Math.round(x * 100) / 100;
    var s_x = f_x.toString();
    var pos_decimal = s_x.indexOf('.');
    if (pos_decimal < 0) {
        pos_decimal = s_x.length;
        s_x += '.';
    }
    while (s_x.length <= pos_decimal + 2) {
        s_x += '0';
    }
    return s_x;
}

//显示隐藏贷款信息
function showOrHideBuyCarWay(value){
	if(value==2){
		$("#ajsxfDiv").show();
	}
	if(value==1){
		$("#ajsxfDiv").hide();
		$("#ajsxf").val("0.0");
		$("#sfk").val("0.0");
		$("#daikuan").val("0.0");
		$("#paymentPer").val("0.0");
	}
	orderContranctTotalPrice();
}
function loanPaymentPer(){
	   var loanCarPrice=$("#loanCarPrice").val();
	   if(null!=loanCarPrice&&loanCarPrice!=''){
		   loanCarPrice=parseFloat(loanCarPrice);
		   if(isNaN(loanCarPrice)){
			   loanCarPrice=0; 
		   }
	   }else{
		   loanCarPrice=0;
	   }
	   var paymentPer=$("#paymentPer").val();
	   if(null!=paymentPer&&paymentPer!=''){
		   paymentPer=parseFloat(paymentPer);
		   if(isNaN(paymentPer)){
			   paymentPer=0; 
		   }
	   }else{
		   paymentPer=0;
	   }
		//计算按揭数据
	    var buyCarType=$('input:radio[name="orderContractExpenses.buyCarType"]:checked').val();
	    if(buyCarType>1){
	    	if(paymentPer>0&&paymentPer<10){
	    		var sfk=0;
	    		if(paymentPer==0){
		    		sfk=0;
	    		}else{
	    			sfk=loanCarPrice*paymentPer/10;
			    	daikuan=loanCarPrice-sfk;
	    		}
		    	sfk=parseFloat(sfk);
		    	 if(isNaN(sfk)){
		    		 sfk=0; 
			   }
		       $("#sfk").val(sfk);
		    	$("#daikuan").val(daikuan);
	    	}
	    }
	}
	function loanSfk(){
		var loanCarPrice=$("#loanCarPrice").val();
		   if(null!=loanCarPrice&&loanCarPrice!=''){
			   loanCarPrice=parseFloat(loanCarPrice);
			   if(isNaN(loanCarPrice)){
				   loanCarPrice=0; 
			   }
		   }else{
			   loanCarPrice=0;
		   }
		  var sfk=$("#sfk").val();
		  if(null!=sfk&&sfk!=''){
			  sfk=parseFloat(sfk);
			   if(isNaN(sfk)){
				   sfk=0; 
			   }
		   }else{
			   sfk=0;
		   }
		//计算按揭数据
	    var buyCarType=$('input:radio[name="orderContractExpenses.buyCarType"]:checked').val();
		var paymentPer=0;
	    if(buyCarType>1){
		   	daikuan=loanCarPrice-sfk;
		   	paymentPer=sfk/loanCarPrice*10;
	  		paymentPer=parseFloat(paymentPer);
	    	 if(isNaN(paymentPer)){
	    		 paymentPer=0; 
		   }
	       $("#paymentPer").val(paymentPer);
	    	$("#daikuan").val(daikuan);
	    }
	}
//金额转为大写
function atoc(numberValue){  
	var numberValue=new String(Math.round(numberValue*100)); // 数字金额  
	var chineseValue=""; // 转换后的汉字金额  
	var String1 = "零壹贰叁肆伍陆柒捌玖"; // 汉字数字  
	var String2 = "万仟佰拾亿仟佰拾万仟佰拾元角分"; // 对应单位  
	var len=numberValue.length; // numberValue 的字符串长度  
	var Ch1; // 数字的汉语读法  
	var Ch2; // 数字位的汉字读法  
	var nZero=0; // 用来计算连续的零值的个数  
	var String3; // 指定位置的数值  
	if(len>15){  
	alert("超出计算范围");  
	return "";  
	}  
	if (numberValue==0){  
	chineseValue = "零元整";  
	return chineseValue;  
	}  
	String2 = String2.substr(String2.length-len, len); // 取出对应位数的STRING2的值  
	for(var i=0; i<len; i++){  
	String3 = parseInt(numberValue.substr(i, 1),10); // 取出需转换的某一位的值  
	if ( i != (len - 3) && i != (len - 7) && i != (len - 11) && i !=(len - 15) ){  
	if ( String3 == 0 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else if ( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else{  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	}  
	else{ // 该位是万亿，亿，万，元位等关键位  
	if( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if ( String3 != 0 && nZero == 0 ){  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if( String3 == 0 && nZero >= 3 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else{  
	Ch1 = "";  
	Ch2 = String2.substr(i, 1);  
	nZero = nZero + 1;  
	}  
	if( i == (len - 11) || i == (len - 3)){ // 如果该位是亿位或元位，则必须写上  
	Ch2 = String2.substr(i, 1);  
	}  
	}  
	chineseValue = chineseValue + Ch1 + Ch2;  
	}  
	if ( String3 == 0 ){ // 最后一位（分）为0时，加上“整”  
	chineseValue = chineseValue + "整";  
	}  
	return chineseValue;  
	}  
	
function target32(num){
	var num=atoc(num);
	$("#bigOrderMoney").val(num);
}



function validateFrmBeforeSmb(){
	//优惠
	var	specialPermPrice=$("#specialPermPrice").val(); 
	specialPermPrice=parseFloat(specialPermPrice);
	var	preferentialTogether=$("#preferentialTogether").val(); 
	var	decoreMoney=$("#decoreMoney").val(); 
	var	orderMoney2=$("#orderMoney").val(); 
	var	totalPrice=$("#totalPrice").val(); 
	if(isNaN(specialPermPrice)){
		alert("特殊权限金额填写错误");
		return false;
	}else{
		var specialPermNote=$("#specialPermNote").val();
		if(specialPermPrice>0){
			if(null==specialPermNote||specialPermNote==''||specialPermNote.length<2){
				alert("请填写特殊权限备注信息");
				return false;
			}
		}
	}
	if(null==orderMoney2||orderMoney2==''){
		alert("请填写预付定金！");
		$("#orderMoney2").focus();
		return false;
	}
	var payNowMoney=$('input:radio[name="orderContractExpenses.buyCarType"]:checked').val();
	if(null==payNowMoney||payNowMoney==''){
		alert("请选择购车方式！");
		return false;
	}
	var isCash=$('input:radio[name="orderContractExpenses.payWay"]:checked').val();
	if(null==isCash||isCash==''){
		alert("请选择付款方式！");
		return false;
	}
	return true;
}
</script>
</body>
</html>
