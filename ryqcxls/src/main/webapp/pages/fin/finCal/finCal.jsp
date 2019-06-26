<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>金融计算器</title>
<style type="text/css">
	select {
		width: 280px;
}
.formTableTdLeft{
	width: 140px;
}
.tabled tr {
    height: 40px;
}
</style>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/finCal/finCal'">金融计算器</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(finYear) }">金融计算器</c:if>
	<c:if test="${!empty(finYear) }">金融计算器</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 46%;float: left;">
			<tr height="42">
				<td class="formTableTdLeft">品牌:&nbsp;</td>
				<td >
					<select id="brandId" name="brandId" class="largeX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${finProduct.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车系:&nbsp;</td>
				<td id="carModelLabel">
					<select id="carSeriyId" name="carSeriyId" class="largeX text" onchange="ajaxFinProduct(this.value)" >
						<option value="">请先选择品牌...</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">贷款产品:&nbsp;</td>
				<td id="finProductTr">
					<select id="finProductId" name="finProductId" class="largeX text" onchange="ajaxFinProductItem(this.value)">
						<option value="">请先选择车系...</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">年限:&nbsp;</td>
				<td id="finProductItemTr">
					<select id="finProductItemId" name="finProductItemId" class="largeX text" onchange="jisuan()">
						<option value="">请先选择贷款产品...</option>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">贷款金额(元):&nbsp;</td>
				<td ><input type="text" name="loanMoney" id="loanMoney"	value="" class="largeX text" title="名称"></td>
			</tr>
		</table>
		<table class="tabled" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 46%;float: left;margin-left: 12px;">
			<tr height="32" id="year" style="display: none;">
				<td>按年（元）:&nbsp;</td>
				<td id="yearSupPirce">
					0.00
				</td>
			</tr>
			<tr height="32" id="monty">
				<td class="formTableTdLeft">月供（元）:&nbsp;</td>
				<td id="monthSupPrice">
					0.00
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">实际利息（元）:&nbsp;</td>
				<td id="actureDis">
					0.00
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">年利率%:&nbsp;</td>
				<td id="annualInterest">
					0.00
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">贷款期数（月）:&nbsp;</td>
				<td id="monthLong">
					0
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">公司承担利息（元）:&nbsp;</td>
				<td id="shopDis">
					0.00
				</td>
			</tr>
		</table>
		<div style="clear: both;"></div>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="sbmit()"	class="but butSave">计算</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelLabel").text("");
	$.post("${ctx}/finCal/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
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
	$.post("${ctx}/finCal/ajaxFinProductItem?finProductId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductItemTr").append(data);
		}
	});
}
function jisuan(){
	var loanMoney=$("#loanMoney").val();
	if(null!=loanMoney&&loanMoney!=''){
		sbmit();
	}
}
function sbmit(){
	var params = $("#frmId").serialize();
	$.post("${ctx}/finCal/ajaxJs",params,function (data){
		if(data!="error"){
			if(data.repayType=="1"){
				$("#year").hide();
				$("#month").show();
			}
			if(data.repayType=="2"){
				$("#year").show();
				$("#month").hide();
			}
			$("#annualInterest").text(data.annualInterest);
			$("#yearSupPirce").text(data.yearSupPirce);
			$("#monthSupPrice").text(data.monthSupPrice);
			$("#actureDis").text(data.actureDis);
			$("#shopDis").text(data.shopDis);
			$("#monthLong").text(data.monthLong);
			$("#repayType").text(data.repayType);
		}
	});
}
</script>
</html>