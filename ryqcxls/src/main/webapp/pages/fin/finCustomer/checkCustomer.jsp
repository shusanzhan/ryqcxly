<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>贷款客户添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/finCustomer/queryList'">贷款客户</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(finCustomer) }">添加贷款客户</c:if>
	<c:if test="${!empty(finCustomer) }">编辑贷款客户</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="finCustomer.dbid" id="dbid" value="${finCustomer.dbid }">
		<c:if test="${empty(finCustomer) }">
			<input type="hidden" name="finCustomer.customerType" id="customerType" value="1">
		</c:if>
		<c:if test="${!empty(finCustomer) }">
			<input type="hidden" name="finCustomer.customerType" id="customerType" value="${finCustomer.customerType }">
		</c:if>
		<input type="hidden" name="type" id="type" value="${param.type}">
		<input type="hidden" name="customerId" id="customerId" value="${finCustomer.customer.dbid }">
		<input type="hidden" name="finCustomerLoan.dbid" id="finCustomerLoanId" value="${finCustomerLoan.dbid }">
		<input type="hidden" name="finCustomer.createDate" id="createDate" value="${finCustomer.createDate }">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">贷款人信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42">
				<td class="formTableTdLeft">客户编号:&nbsp;</td>
				<td colspan="3"><input type="text" readonly="readonly" name="finCustomer.custNo" id="custNo"	value="${finCustomer.custNo }" class="large text" title="客户编号" checkType="string,1,50" tip="客户编号不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">申请人:&nbsp;</td>
				<td ><input type="text" name="finCustomer.name" id="name" readonly="readonly"	value="${finCustomer.name }" class="large text" title="名称" onfocus="autoCustomer('name')"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">申请人电话:&nbsp;</td>
				<td ><input type="text" name="finCustomer.mobilePhone" id="mobilePhone" readonly="readonly"
					value="${finCustomer.mobilePhone }" class="large text" title="申请人电话"	checkType="mobilePhone" tip="申请人电话不能为空" onfocus="autoCustomer('mobilePhone')"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">身份证号:&nbsp;</td>
				<td ><input type="text"  name="finCustomer.icard" id="icard"	value="${finCustomer.icard }" class="large text" title="名称"	checkType="IDCard" tip="身份证号不能为空"></td>
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td >
					<input type="hidden" id="areaId" name="areaId" value="${finCustomer.area.dbid }">
					<input type="text" name="finCustomer.address" id="address"	value="${finCustomer.address }" class="large text" title="名称"	checkType="string,1"  tip="地址不能为空">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">共申人:&nbsp;</td>
				<td ><input type="text" name="finCustomer.commName" id="commName"
					value="${finCustomer.commName }" class="large text" title="共申人"	checkType="string,1"  tip="共申人不能为空"></td>
				<td class="formTableTdLeft">共申人电话:&nbsp;</td>
				<td ><input type="text" name="finCustomer.commMobilePhone" id="commMobilePhone"
					value="${finCustomer.commMobilePhone }" class="large text" title="共申人电话"	checkType="mobilePhone" tip="共申人电话不能为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					<input type="hidden" id="brandId" name="brandId" value="${finCustomer.brand.dbid }">
					<input type="hidden" id="carSeriyId" name="carSeriyId" value="${finCustomer.carSeriy.dbid }">
					<input type="text" name="finCustomer.carSeriyName" id="carSeriyName" value="${finCustomer.carSeriyName }" class="large text" title="车型"	checkType="string,1" tip="车型不能为空">
				</td>
				<td class="formTableTdLeft">销售员:&nbsp;</td>
				<td ><input type="text" name="finCustomer.saler" id="saler" onfocus="autoUser('saler')" value="${finCustomer.saler }" class="large text" title="销售员"	checkType="string,1"  tip="销售员不能为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">销售员电话:&nbsp;</td>
				<td ><input type="text" name="finCustomer.salerPhone" id="salerPhone" value="${finCustomer.salerPhone }" class="large text" title="销售员电话"	checkType="string,1"  tip="销售员电话不能为空"></td>
				<td class="formTableTdLeft">部门:&nbsp;</td>
				<td >
					<select class="large text" id="depId" name="depId"  checkType="integer,1" tip="请选择部门">
						<option value="0" >请选择...</option>
						${departmentSelect }
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">区域:&nbsp;</td>
				<td >
					<select id="storeAreaId" name="storeAreaId" class="large text" checkType="integer,1">
						<option value="-1">请选择...</option>
						<c:forEach items="${storeAreas }" var="storeArea">
							<option value="${storeArea.dbid }" ${finCustomer.storeArea.dbid==storeArea.dbid?'selected="selected"':'' } >${storeArea.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">销售公司:&nbsp;</td>
				<td >
					<select id="saleCompanyId" name="saleCompanyId" class="large text" checkType="integer,1">
						<option value="-1">请选择...</option>
						<c:forEach items="${saleCompanies }" var="saleCompany">
							<option value="${saleCompany.dbid }" ${finCustomer.saleCompany.dbid==saleCompany.dbid?'selected="selected"':'' } >${saleCompany.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车辆销售商：</td>
				<td  colspan="3">
					<input type="hidden" class="large text" name="distributorId" id="distributorId" value="${finCustomer.distributor.dbid }">
					<c:if test="${empty(finCustomer) }">
						<input type="text" class="large text" name="distributorName" id="distributorName" checkType="string,1,50" canEmpty="Y" tip="请输入经销商拼音码选择" onfocus="autoByDistributeName('distributorName')" value="${finCustomer.distributor.name }" ></input>
					</c:if>
					<c:if test="${!empty(finCustomer) }">
						<input type="text" class="large text"  name="distributorName" id="distributorName"  checkType="string,1,50" canEmpty="Y" tip="请输入经销商拼音码选择" onfocus="autoByDistributeName('distributorName')" value="${finCustomer.distributor.name }"></input>
					</c:if>
				</td>
			</tr>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">贷款费用</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42">
				<td class="formTableTdLeft">车价:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.carPrice" id="carPrice" onchange="jisuan()" onfocus="jisuan()" value="${finCustomerLoan.carPrice }" class="large text" title="名称" 	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">开票价:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.kaiPiaoPrice" id="kaiPiaoPrice"
					value="${finCustomerLoan.kaiPiaoPrice }" class="large text" title="月数"	checkType="float,0" tip="月数不能为空,且只能为数字"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">贷款金额:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.loanPrice" id="loanPrice" 	value="${finCustomerLoan.loanPrice }" class="large text" title="贷款金额" onfocus="jisuan()" onchange="jisuan()"	checkType="float,0" tip="贷款金额不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">手续费:&nbsp;</td>
				<td ><input type="text"  name="finCustomerLoan.countFee" id="countFee"
					value="${finCustomerLoan.countFee }" class="large text" title="手续费" onkeyup="profit()" 	checkType="float,0" tip="手续费不能为空,且只能为数字"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">贷款产品:&nbsp;</td>
				<td id="finProductIdTr">
					<select id="finProductId" name="finProductId" class="large text" onchange="ajaxFinProductItem(this.value)">
						<option value="">请先选择车系...</option>
						<c:forEach items="${finProducts }" var="finProduct">
							<option value="${finProduct.dbid }" ${finProduct.dbid==finCustomerLoan.finProduct.dbid?'selected="selected"':'' } >${finProduct.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">年限:&nbsp;</td>
				<td id="finProductItemTr">
					<select id="finProductItemId" name="finProductItemId" class="large text" onchange="jisuan();profit()">
						<option value="-1">请先选择贷款产品...</option>
						<c:forEach var="finProductItem" items="${finProductItems }">
							<option value="${finProductItem.dbid }" ${finProductItem.dbid==finCustomerLoan.finProductItem.dbid?'selected="selected"':'' } >${finProductItem.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" id="monthSupPriceLable">月供:&nbsp;</td>
				<td id="monthSupPriceTr">
					<input readonly="readonly" type="text" name="finCustomerLoan.monthSupPrice" id="monthSupPrice"	value="${finCustomerLoan.monthSupPrice }" class="large text" title="名称" >
				</td>
				<td class="formTableTdLeft" id="yearSupPriceLable" style="display: none;">按年还:&nbsp;</td>
				<td id="yearSupPriceTr" style="display: none;">
					<input readonly="readonly" type="text" name="finCustomerLoan.yearSupPrice" id="yearSupPrice"	value="${finCustomerLoan.yearSupPrice }" class="large text" title="名称" >
				</td>
				<td class="formTableTdLeft">利息:&nbsp;</td>
				<td>
					<input readonly="readonly" type="text" name="finCustomerLoan.annualInterest" id="annualInterest" value="${finCustomerLoan.annualInterest }" class="large text" title="月数">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">工厂税后毛利:&nbsp;</td>
				<td>
					<input type="text" name="finCustomerLoan.factoryProfitPrice" id="factoryProfitPrice" onkeyup="profit()" value="${finCustomerLoan.factoryProfitPrice }" class="large text" title="工厂税后毛利" 	checkType="float,0" tip="工厂税后毛利不能为空"><span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">贴息金额:&nbsp;</td>
				<td colspan="">
					<input type="text" name="finCustomerLoan.discountMony" id="discountMony"	value="${finCustomerLoan.discountMony }" class="large text" title="贴息金额" checkType="float,0"  tip="贴息金额"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">实际利息:&nbsp;</td>
				<td >
					<input type="text" name="finCustomerLoan.actDiscountPrice" id="actDiscountPrice"	value="${finCustomerLoan.actDiscountPrice }" class="large text" title="名称" 	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span>
					贷款额/10000*贴息系数
				</td>
				<td class="formTableTdLeft">公司贴息:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.companyDiscountPrice" id="companyDiscountPrice"
					value="${finCustomerLoan.companyDiscountPrice }" class="large text" title="公司贴息"	checkType="float" tip="公司贴息不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">盗抢险产值:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.dqxProfitPrice" id="dqxProfitPrice"
					value="${finCustomerLoan.dqxProfitPrice }" class="large text" title="盗抢险产值" onkeyup="profit()"	checkType="float,0" canEmpty="Y" tip="盗抢险产值可为空,只能为数字"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">续保佣金:&nbsp;</td>
				<td>
					<input type="text" name="finCustomerLoan.renewalCommissionPrice" id="renewalCommissionPrice" onkeyup="profit()" value="${finCustomerLoan.renewalCommissionPrice }" class="large text" title="续保佣金" checkType="float,0" canEmpty="Y" tip="续保佣金"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">其他收费:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPrice" id="otherPrice"	value="${finCustomerLoan.otherPrice }" class="large text" title="其他收费" onkeyup="profit()"	checkType="float" canEmpty="Y" tip="其他收费,可以为空"></td>
				<td class="formTableTdLeft">其他收费备注:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPriceNote" id="otherPriceNote" value="${finCustomerLoan.otherPriceNote }" class="large text" title="其他收费备注"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">其他收费1:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPrice1" id="otherPrice1"	value="${finCustomerLoan.otherPrice1 }" class="large text" title="其他收费1" onkeyup="profit()"	checkType="float" canEmpty="Y" tip="其他收费,可以为空"></td>
				<td class="formTableTdLeft">其他收费备注1:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPriceNote1" id="otherPriceNote1" value="${finCustomerLoan.otherPriceNote1 }" class="large text" title="其他收费备注1"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">其他收费2:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPrice2" id="otherPrice2"	value="${finCustomerLoan.otherPrice2 }" class="large text" title="其他收费2" onkeyup="profit()"	checkType="float" canEmpty="Y" tip="其他收费,可以为空"></td>
				<td class="formTableTdLeft">其他收费备注2:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.otherPriceNote2" id="otherPriceNote2" value="${finCustomerLoan.otherPriceNote2 }" class="large text" title="其他收费备注2"	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">利润:&nbsp;</td>
				<td>
					<input type="text" name="finCustomerLoan.profitPrice" id="profitPrice"	value="${finCustomerLoan.profitPrice }" class="midea text" title="名称" onfocus="autoCustomer('name')"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span>
					<br>手续费+盗抢险+其他收费总额-公司贴息+工厂返利+续保佣金
				</td>
				<td class="formTableTdLeft">核算台次:&nbsp;</td>
				<td colspan="">
					<input type="text" name="finCustomerLoan.checkNum" id="checkNum"	value="${finCustomerLoan.checkNum }" class="large text" title="核算台次" checkType="integer,0" canEmpty="Y" tip="核实台次">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">保有比例:&nbsp;</td>
				<td >
					<c:if test="${empty(finCustomerLoan.salerBasePricePer)}" var="status">
						<input type="text" readonly="readonly"  name="finCustomerLoan.salerBasePricePer" id="salerBasePricePer"	value="${finSet.salerBasePrice }" class="large text" title="销售顾问基价比例" onkeyup="profit()"	checkType="float,0,100" tip="销售顾问基价比例,只能为数字,0-100"><span style="color: red;">*</span>
					</c:if>
					<c:if test="${status==false }">
						<input type="text" readonly="readonly" name="finCustomerLoan.salerBasePricePer" id="salerBasePricePer"	value="${finCustomerLoan.salerBasePricePer }" class="large text" title="销售顾问基价比例" onkeyup="profit()"	checkType="float,0,100" tip="销售顾问基价比例,只能为数字,0-100"><span style="color: red;">*</span>
					</c:if>
					%
				</td>
				<td class="formTableTdLeft" id="salerProfitPriceTd">保有金额:&nbsp;</td>
				<td >
					<input type="text" readonly="readonly" name="finCustomerLoan.salerProfitPrice" id="salerProfitPrice"	value="${finCustomerLoan.salerProfitPrice }" class="large text">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" id="salerProfitPriceTd">提成基数:&nbsp;</td>
				<td >
					<input type="text" readonly="readonly"  name="finCustomerLoan.salerPrice" id="salerPrice"	value="${finCustomerLoan.salerPrice }" class="large text" title="销售顾问基价" onkeyup="profit()"	checkType="float" tip="销售顾问基价,只能为数字"><span style="color: red;">*</span>
					<br>
					<span id="saleTip" style="font-size: 8px;">（手续费-公司贴息+工厂税后毛利+盗抢险产值）*基价比例</span>
				</td>
				<td class="formTableTdLeft" id="salerPriceNoteTd">提成基数备注:&nbsp;</td>
				<td ><input type="text" name="finCustomerLoan.salerPriceNote" id="salerPriceNote"	value="${finCustomerLoan.salerPriceNote }" class="large text" title="销售顾问基价备注" checkType="string,1," canEmpty='Y' tip="销售顾问基价不能为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">贷款成数:&nbsp;</td>
				<td colspan=""><input type="text" readonly="readonly" name="finCustomerLoan.loanPer" id="loanPer"	value="${finCustomerLoan.loanPer }" class="large text" title="贷款成数" 	checkType="float" tip="贷款成数不能为空"></td>
				<td class="formTableTdLeft">销售收取贴息:&nbsp;</td>
				<td >
					<input type="text"  name="finCustomerLoan.salerDiscountPrice" id="salerDiscountPrice"	value="${finCustomerLoan.salerDiscountPrice }" class="large text" title="销售收取贴息" 	checkType="float" tip="销售收取贴息">
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="finCustomer.note" id="note" title="内容简介"  class="textarea large" style="width: 785px;">${finCustomer.note }</textarea>
				</td>
			</tr>
		</table>
		
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/finCustomer/saveCheck')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function profit(){
	//贴息
	var discountMony=$("#discountMony").val();
	if(null!=discountMony&&discountMony!=''){
		discountMony=parseFloat(discountMony);
	}else{
		discountMony=parseFloat(0);
	}
	//手续费
	var countFee=$("#countFee").val();
	if(null!=countFee&&countFee!=''){
		countFee=parseFloat(countFee);
	}else{
		countFee=parseFloat(0);
	}
	//其他收费
	var otherPrice=$("#otherPrice").val();
	if(null!=otherPrice&&otherPrice!=''){
		otherPrice=parseFloat(otherPrice);
	}else{
		otherPrice=parseFloat(0);
	}
	//其他收费1
	var otherPrice1=$("#otherPrice1").val();
	if(null!=otherPrice1&&otherPrice1!=''){
		otherPrice1=parseFloat(otherPrice1);
	}else{
		otherPrice1=parseFloat(0);
	}
	//其他收费2
	var otherPrice2=$("#otherPrice2").val();
	if(null!=otherPrice2&&otherPrice2!=''){
		otherPrice2=parseFloat(otherPrice2);
	}else{
		otherPrice2=parseFloat(0);
	}
	//盗强险
	var dqxProfitPrice=$("#dqxProfitPrice").val();
	if(null!=dqxProfitPrice&&dqxProfitPrice!=''){
		dqxProfitPrice=parseFloat(dqxProfitPrice);
	}else{
		dqxProfitPrice=parseFloat(0);
	}
	//工厂税后毛利
	var factoryProfitPrice=$("#factoryProfitPrice").val();
	if(null!=factoryProfitPrice&&factoryProfitPrice!=''){
		factoryProfitPrice=parseFloat(factoryProfitPrice);
	}else{
		factoryProfitPrice=parseFloat(0);
	}
	//续保佣金
	var renewalCommissionPrice=$("#renewalCommissionPrice").val();
	if(null!=renewalCommissionPrice&&renewalCommissionPrice!=''){
		renewalCommissionPrice=parseFloat(renewalCommissionPrice);
	}else{
		renewalCommissionPrice=parseFloat(0);
	}
	//公司贴息
	var companyDiscountPrice=$("#companyDiscountPrice").val();
	if(null!=companyDiscountPrice&&companyDiscountPrice!=''){
		companyDiscountPrice=parseFloat(companyDiscountPrice);
	}else{
		companyDiscountPrice=parseFloat(0);
	}
	////loanProfitPrice按揭纯利润(除开盗抢险、其他费用） 次模块数据用于核财务核单按揭利润
	var profitPrice=0,loanProfitPrice=0,otherProfitPrice=0;
	if(companyDiscountPrice>0){
		//按揭总利润 手续费+盗抢险+其他收费总额-公司贴息+工厂返利+续保佣金
		profitPrice=countFee+dqxProfitPrice+otherPrice+otherPrice1+otherPrice2-companyDiscountPrice+factoryProfitPrice+renewalCommissionPrice;
		//loanProfitPrice按揭纯利润 手续费-公司贴息
		loanProfitPrice=countFee-companyDiscountPrice;
		//其他利润总和 盗抢险+其他收费总额+工厂返利+续保佣金
		otherProfitPrice=dqxProfitPrice+otherPrice+otherPrice1+otherPrice2+factoryProfitPrice+renewalCommissionPrice;
	}else{
		////按揭总利润 手续费+盗抢险+其他收费总额+工厂返利+续保佣金
		profitPrice=countFee+dqxProfitPrice+otherPrice+otherPrice1+otherPrice2+factoryProfitPrice+renewalCommissionPrice;
		//loanProfitPrice按揭纯利润
		loanProfitPrice=countFee;
		//其他利润总和 盗抢险+其他收费总额+工厂返利+续保佣金
		otherProfitPrice=dqxProfitPrice+otherPrice+otherPrice1+otherPrice2+factoryProfitPrice+renewalCommissionPrice;
	}
	$("#profitPrice").val(parseFloat(profitPrice));
	$("#loanProfitPrice").val(parseFloat(loanProfitPrice));
	$("#otherProfitPrice").val(parseFloat(otherProfitPrice));
	
	//销售顾问基价 
	var salerBasePricePer=$("#salerBasePricePer").val();
	if(null!=salerBasePricePer&&salerBasePricePer!=''){
		salerBasePricePer=parseFloat(salerBasePricePer);
	}else{
		salerBasePricePer=parseFloat(0);
	}
	var salerPrice=0,salerProfitPrice=0;
	//（手续费-公司贴息+工厂返利+续保佣金+盗抢险）*基价比例
	salerPrice=(countFee-companyDiscountPrice+factoryProfitPrice+dqxProfitPrice+renewalCommissionPrice)*(100-salerBasePricePer)/100;
	salerPrice=formatFloat(salerPrice)
	$("#salerPrice").val(salerPrice);
	//保底费用
	salerProfitPrice=(countFee-companyDiscountPrice+factoryProfitPrice+dqxProfitPrice+renewalCommissionPrice)*(salerBasePricePer)/100;
	salerProfitPrice=formatFloat(salerProfitPrice);
	$("#salerProfitPrice").val(salerProfitPrice);
}
function autoCustomer(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/finCustomer/autoCustomer",{
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;联系电话： "+row.mobilePhone+"&nbsp;&nbsp;身份证："+row.icard+"&nbsp;&nbsp;车系："+row.carSeriyName+"&nbsp;&nbsp; </span>";   
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

function onRecordSelect(event, data, formatted) {
		$("#customerId").val(data.customerId);
		$("#depId").val(data.depId);
		$("#name").val(data.name);
		$("#mobilePhone").val(data.mobilePhone);
		$("#icard").val(data.icard);
		$("#address").val(data.address);
		$("#areaId").val(data.areaId);
		$("#saler").val(data.saler);
		$("#salerPhone").val(data.salerPhone);
		$("#netArea").val(data.netArea);
		//$("#dep").val(data.dep);
		$("#brandId").val(data.brandId);
		$("#carSeriyId").val(data.carSeriyId);
		$("#carPrice").val(data.carPrice);
		$("#kaiPiaoPrice").val(data.kaiPiaoPrice);
		$("#loanPrice").val(data.loanPrice);
		$("#countFee").val(data.countFee);
		$("#carSeriyName").val(data.carSeriyName);
		$("#distributorId").val(data.distributorId);
		$("#distributorName").val(data.distributorName);
		$("#salerBasePricePer").val(data.salerBasePricePer);
		var finProduct=data.finProduct;
		if(data!="error"){
			$("#finProductIdTr").text("");
			$("#finProductIdTr").append(finProduct);
		}
	}
function ajaxFinProduct(val){
	if(null==val||val==''){
		alert("请选择车系");
		return false;
	}
	$("#finProductTr").text("");
	$.post("${ctx}/finCal/ajaxFinProduct?carSeriyId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductTr").append(data);
		}
	});
}
function ajaxFinProductItem(val){
	if(null==val||val==''){
		alert("请选产品");
		return false;
	}
	$("#finProductItemTr").text("");
	$.post("${ctx}/finCustomer/ajaxFinProductItem?finProductId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductItemTr").append(data);
		}
	});
}
function jisuan(){
	var loanPrice=$("#loanPrice").val();
	var carPrice=$("#kaiPiaoPrice").val();
	if(null!=loanPrice&&loanPrice!=''){
		loanPrice=parseFloat(loanPrice);
	}
	if(null!=carPrice&&carPrice!=''){
		carPrice=parseFloat(carPrice);
	}
	var loanPer=(loanPrice/carPrice)*10;
	$("#loanPer").val(formatFloat(loanPer));
	//sbmit();
}
function sbmit(){
	var loanPrice=$("#loanPrice").val();
	var finProductItemId=$("#finProductItemId").val();
	var params = {'loanMoney':loanPrice,'finProductItemId':finProductItemId,'dateTime':new Date()};
	$.post("${ctx}/finCal/ajaxJs",params,function (data){
		if(data!="error"){
			if(data.repayType=="1"){
				$("#yearSupPriceLable").hide();
				$("#yearSupPriceTr").hide();
				$("#monthSupPriceLable").show();
				$("#monthSupPriceTr").show();
			}
			if(data.repayType=="2"){
				$("#yearSupPriceLable").show();
				$("#yearSupPriceTr").show();
				$("#monthSupPriceLable").hide();
				$("#monthSupPriceTr").hide();
			}
			$("#annualInterest").val(data.annualInterest);
			$("#yearSupPrice").val(data.yearSupPrice);
			$("#monthSupPrice").val(data.monthSupPrice);
			$("#actDiscountPrice").val(data.companyActureDis);
			var shopDis=data.shopDis;
			if(null!=shopDis&&shopDis!=undefined){
				shopDis=parseFloat(shopDis);
				if(shopDis>0){
					$("#companyDiscountPrice").val(shopDis);
				}else{
					$("#companyDiscountPrice").val(0);
				}
			}else{
				$("#companyDiscountPrice").val(0);
			}
			$("#discountMony").val(data.discountMony);
			$("#repayType").val(data.repayType);
			profit();
		}
	});
}

function formatFloat(x) {
    var f_x = parseFloat(x);
    if (isNaN(f_x)) {
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
function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
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
		       return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#saler").val(data.name);
		$("#salerPhone").val(data.mobilePhone);
}
function commissionType(){
	var commissionType=$("input[name='finCustomerLoan.commissionType']:checked").val();
	if(commissionType==1){
		$("#salerProfitPriceTd").text("销售顾问基价:");
		$("#salerPriceNoteTd").text("基价备注:");
		$("#salerBasePricePer").removeAttr("readonly");
		$("#saleTip").show();
		$("#salerPrice").attr("readonly","readonly");
		profit();
	}
	if(commissionType==2){
		$("#salerProfitPriceTd").text("销售顾问提成:");
		$("#salerPriceNoteTd").text("提成备注:");
		$("#salerBasePricePer").attr("readonly","readonly");
		$("#salerPrice").removeAttr("readonly");
		$("#saleTip").hide();
		$("#salerPrice").val(0);
		$("#salerProfitPrice").val(0);
		profit();
	}
}
function autoByDistributeName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/distributor/autoByFin",{
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect3);
	//计算总金额
}

function onRecordSelect3(event, data, formatted) {
		$("#distributorName").val(data.name);
		$("#distributorId").val(data.dbid);
		
	}
</script>
</html>