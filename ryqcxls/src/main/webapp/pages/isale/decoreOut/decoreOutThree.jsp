<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
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
.small{
	width: 60px;
}
</style>
<title>装饰销售</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/decoreOut/queryList'">装饰销售</a>-
<a href="javascript:void(-1);">
	装饰出库
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td colspan="11" style="text-align: left;padding-right: 12px;">
						待出库商品
					</td>
				</tr>
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 40px;text-align: center;">序号</th>
						<th style="width: 120px;text-align: center;">品名规格</th>
						<th style="width: 60px;text-align: center;">货品类型</th>
						<th style="width: 60px;text-align: center;">销售单价</th>
						<th style="width: 60px;text-align: center;">顾问结算</th>
						<th style="width: 60px;text-align: center;">数量</th>
						<th style="width: 60px;text-align: center;">进货价</th>
						<th style="width: 180px;text-align: center;">备注</th>
				</tr>
				<c:set value="0" var="totalPrice"></c:set>
				<c:set value="0" var="totalSalerPrice"></c:set>
				<c:set value="0" var="totalPurchasePrice"></c:set>
				<!-- 添加时展示页面 -->
				<s:set value="0" var="lengthNum"></s:set>
					<c:forEach var="decoreOutProduct" items="${decoreOutProducts }" varStatus="i">
							<tr id="str${i.index+1}" onclick="">
								<td style="text-align: center;">
									${i.index+1}
								</td>
								<td id="productName${i.index+1}">
									<input type="hidden" name="decoreProductId" id="decoreProductId${i.index+1}" value="${decoreOutProduct.dbid }">
									<input type="hidden" name="productId" id="productId${i.index+1}" value="${decoreOutProduct.product.dbid }">
									<input type="hidden" name="type" id="type${i.index+1}" class="small text" value="${decoreOutProduct.type }">
									<input type="hidden" name="num" id="num${i.index+1}" class="small text" value="${decoreOutProduct.num }">
									<c:set value="${totalPrice+(decoreOutProduct.price*decoreOutProduct.num)}" var="totalPrice"></c:set>
									<c:set value="${totalSalerPrice+(decoreOutProduct.salerPrice*decoreOutProduct.num)}" var="totalSalerPrice"></c:set>
									<c:set value="${totalPurchasePrice+(decoreOutProduct.purchasePrice*decoreOutProduct.num)}" var="totalPurchasePrice"></c:set>
									${decoreOutProduct.productName }
								</td>
								<td style="text-align: center;" id="productcategory${i.index+1}">
									${decoreOutProduct.product.productcategory.name }
								</td>
								<td style="text-align: center;" id="price${i.index+1}">
									${decoreOutProduct.price}
								</td>
								<td style="text-align: center;" id="salerPrice${i.index+1}">
									${decoreOutProduct.salerPrice}
								</td>
								<td style="text-align: center;" id="saleNum${i.index+1}">
									${decoreOutProduct.num }
								</td>
								<td style="text-align: center;" id="purchasePrice${i.index+1}">
									${decoreOutProduct.purchasePrice }
								</td>
								<td>
									<input type="text" name="note" id="note${i.index+1}" class="mideaX text"  checkType="string,1" canEmpty="Y" value="${decoreOutProduct.note }" tip="请输入项目备注信息" >
									<a href="javascript:void(-1)" onclick="notDecoreOut(${i.index+1})" style="color: #2b7dbc">暂不出库</a>
								</td>
							</tr>
					</c:forEach>
					<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td  colspan="11" style="text-align: right;padding-right: 12px;">
							销售总金额：
							<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPriceText">
								${totalPrice }
							</span>元
							顾问结算总额：
							<span style="font-size: 20px;color: red;margin:0 5px;" id="totalSalerPriceText">
								${totalSalerPrice}
							</span>元
							总成本：
							<span style="font-size: 20px;color: red;margin:0 5px;" id="totalPurchasePriceText">
								${ totalPurchasePrice}
							</span>元
							实收金额：
							<span style="font-size: 20px;color: red;margin:0 5px;" id="acturePrice">
								<c:if test="${empty(decoreOut.acturePrice) }">
									0
								</c:if>
								<c:if test="${!empty(decoreOut.acturePrice) }">
									${decoreOut.acturePrice }
								</c:if>
							</span>元
						</td>
					</tr>
					<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td  colspan="11" style="text-align: left;padding-right: 12px;border-right: 0;font-size: 14px;font-weight: normal;" id="stockTip" >
							
						</td>
					</tr>
			</table>
		</div>
		<br>
		<table id="shopNumber2" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td colspan="11" style="text-align: left;padding-right: 12px;">
					暂不出库商品
				</td>
			</tr>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<th style="width: 40px;text-align: center;">序号</th>
					<th style="width: 120px;text-align: center;">品名规格</th>
					<th style="width: 60px;text-align: center;">货品类型</th>
					<th style="width: 60px;text-align: center;">销售单价</th>
					<th style="width: 60px;text-align: center;">顾问结算</th>
					<th style="width: 60px;text-align: center;">数量</th>
					<th style="width: 140px;text-align: center;">备注</th>
			</tr>
			<!-- 添加时展示页面 -->
			<c:set value="0" var="stotalPrice"></c:set>
			<c:set value="0" var="stotalSalerPrice"></c:set>
			<c:set value="0" var="stotalPurchasePrice"></c:set>
			<c:forEach var="decoreOutProduct" items="${noSaleDecoreOutProducts }" varStatus="i">
					<tr id="tr" onclick="" style="background-color: #F2DEDE;">
						<td style="text-align: center;">
							${i.index+1}
						</td>
						<td>
							<input type="hidden" name="ntype" id="type" class="small text" value="${decoreOutProduct.type }">
							<input type="hidden" name="nproductId" id="nproductId" value="${decoreOutProduct.product.dbid }">
							<input type="hidden" name="nnum" id="num" class="small text" value="${decoreOutProduct.num }">
							<c:set value="${stotalPrice+(decoreOutProduct.price*decoreOutProduct.num)}" var="stotalPrice"></c:set>
							<c:set value="${stotalSalerPrice+(decoreOutProduct.salerPrice*decoreOutProduct.num)}" var="stotalSalerPrice"></c:set>
							${decoreOutProduct.productName }
						</td>
						<td style="text-align: center;">
							${decoreOutProduct.product.productcategory.name }
						</td>
						<td style="text-align: center;">
							${decoreOutProduct.price}
						</td>
						<td style="text-align: center;">
							${decoreOutProduct.salerPrice}
						</td>
						<td style="text-align: center;">
							${decoreOutProduct.num }
						</td>
						<td>
							<input type="text" name="nnote" id="note${lengthNum}" class="mideaX text" style="background-color: #F2DEDE;border:1px solid  #cccccc" checkType="string,1" canEmpty="Y" value="${decoreOutProduct.note }" tip="请输入项目备注信息" >
						</td>
					</tr>
			</c:forEach>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td  colspan="11" style="text-align: right;padding-right: 12px;">
					销售总金额：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="nstotalPrice">
						${stotalPrice }
					</span>元
					顾问结算总额：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="nstotalSalerPrice">
						${stotalSalerPrice}
					</span>元
					总成本：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
						0
					</span>元
					实收金额：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
						0
					</span>元
				</td>
			</tr>
		</table>
			<input type="hidden" name="decoreOut.decoreSaleTotalPrce" id="decoreSaleTotalPrce" value="${totalPrice }" class="largeX text" >
			<input type="hidden" name="decoreOut.dbid" id="dbid" value="${decoreOut.dbid }" class="largeX text" >
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px">
			<tr height="42">
				<td class="formTableTdLeft">成本总额:&nbsp;</td>
				<td colspan="">
					<input type="text" name="decoreOut.costTotalPrice" id="costTotalPrice" value="${totalPurchasePrice}" readonly="readonly" placeholder="0.0" class="largeX text" title="成本总额"	checkType="float,0" tip="成本总额"><span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">顾问结算总额:&nbsp;</td>
				<td >
					<input type="text" readonly="readonly" name="decoreOut.salerTotalPrice" id="salerTotalPrice" value="${totalSalerPrice}" placeholder="0.0" class="largeX text" title="顾问结算总额"	checkType="float,0" tip="顾问结算总额"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">实收金额:&nbsp;</td>
				<td colspan="">
					<input type="text" readonly="readonly" name="decoreOut.acturePrice" id="acturePrice" value="${decoreOut.acturePrice }"  placeholder="0.0" class="largeX text" title="本次付款金额"	checkType="float,0" tip="本次付款金额">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td ><input type="text" name="decoreOut.carPlateNo" id="carPlateNo" value="${decoreOut.carPlateNo }" class="largeX text" title="车牌号"	checkType="string,7,7" canEmpty="Y" tip="车牌号可为空"></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="decoreOut.note" id="note" title="内容简介"  class="largeXX text" style="height: 40px;width: 720px;">${decoreOut.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="deleteNotDecoreOut();$.utile.submitForm('frmId','${ctx}/decoreOut/saveDeocreOutThree')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
	 <div id="lastResult" style="display: none;">
       <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
			<tr height="42">
				<td class="formTableTdLeft">不出库数量:&nbsp;</td>
					<td id="carColorId">
						<input type="text" id="notDecoreNum" name="notDecoreNum" class="text midea">
					</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
function formatInt(x) {
    var f_x = parseInt(x);
    if (isNaN(f_x)) {
        return 0;
    }
    return f_x;
}
function addDecorePrice(dbid){
	var totalPrice=formatInt($("#totalPriceText").text());
	var totalSalerPrice=formatInt($("#totalSalerPriceText").text());
	var totalPurchasePrice=formatInt($("#totalPurchasePriceText").text());
	//获取基础数据
	var price=formatInt($("#price"+dbid).text());
	var salerPrice=formatInt($("#salerPrice"+dbid).text());
	var saleNum=formatInt($("#saleNum"+dbid).text());
	var purchasePrice=formatInt($("#purchasePrice"+dbid).text());
	//计算数据并绑定值
	totalPrice=totalPrice-(price*saleNum);
	totalSalerPrice=totalSalerPrice-(salerPrice*saleNum);
	totalPurchasePrice=totalPurchasePrice-(purchasePrice*saleNum);
	$("#totalPriceText").text(formatInt(totalPrice)+".0");
	$("#totalSalerPriceText").text(formatInt(totalSalerPrice)+".0");
	$("#totalPurchasePriceText").text(formatInt(totalPurchasePrice)+".0");
	//绑定后台需要数据
	$("#costTotalPrice").val(formatInt(totalPurchasePrice)+".0");
	$("#decoreSaleTotalPrce").val(formatInt(totalPrice)+".0");
	$("#salerTotalPrice").val(formatInt(totalSalerPrice)+".0");
	
	//其他不出库商品
	var nstotalPrice=formatInt($("#nstotalPrice").text());
	var nstotalSalerPrice=formatInt($("#nstotalSalerPrice").text());
	
	var nnstotalPrice=nstotalPrice+(price*saleNum);
	var nnstotalSalerPrice=nstotalSalerPrice+(salerPrice*saleNum);
	$("#nstotalPrice").text(formatInt(nnstotalPrice)+".0");
	$("#nstotalSalerPrice").text(formatInt(nnstotalSalerPrice)+".0");
}
//减法
function reduceDecorePrice(dbid){
	var totalPrice=formatInt($("#totalPriceText").text());
	var totalSalerPrice=formatInt($("#totalSalerPriceText").text());
	var totalPurchasePrice=formatInt($("#totalPurchasePriceText").text());
	//获取基础数据
	var price=formatInt($("#price"+dbid).text());
	var salerPrice=formatInt($("#salerPrice"+dbid).text());
	var saleNum=formatInt($("#saleNum"+dbid).text());
	var purchasePrice=formatInt($("#purchasePrice"+dbid).text());
	//计算数据并绑定值
	totalPrice=totalPrice+(price*saleNum);
	totalSalerPrice=totalSalerPrice+(salerPrice*saleNum);
	totalPurchasePrice=totalPurchasePrice+(purchasePrice*saleNum);
	$("#totalPriceText").text(formatInt(totalPrice)+".0");
	$("#totalSalerPriceText").text(formatInt(totalSalerPrice+".0"));
	$("#totalPurchasePriceText").text(formatInt(totalPurchasePrice)+".0");
	//绑定后台需要数据
	$("#costTotalPrice").val(formatInt(totalPurchasePrice)+".0");
	$("#decoreSaleTotalPrce").val(formatInt(totalPrice)+".0");
	$("#salerTotalPrice").val(formatInt(totalSalerPrice)+".0");
	
	//其他不出库商品
	var nstotalPrice=formatInt($("#nstotalPrice").text());
	var nstotalSalerPrice=formatInt($("#nstotalSalerPrice").text());
	
	nstotalPrice=nstotalPrice-(price*saleNum);
	nstotalSalerPrice=nstotalSalerPrice-(salerPrice*saleNum);
	$("#nstotalPrice").text(formatInt(nstotalPrice)+".0");
	$("#nstotalSalerPrice").text(formatInt(nstotalSalerPrice)+".0");
}
function ajaxPurchaseProduct(purchaseProductId){
	$.post('${ctx}/product/ajaxPurchaseProduct?purchaseProductId='+purchaseProductId+'&date='+new Date(),{},function(data){
		if(data==1||data=="1"){
			$("#stockTip").text("");
			$("#stockTip").append("无商品进货数据");
		}else{
			$("#stockTip").text("");
			$("#stockTip").append(data);
		}
	})
}
function notDecoreOut(dbid){
	$("#str"+dbid).hide();
	var nnum=$("#num"+dbid).val();
	if(nnum>1){
		art.dialog({
			title:'请填写成交结果',
		    content: document.getElementById('lastResult'),
		    cancel:false,
		    id: 'EF893L',
		    width:'720px',
		    ok: function () {
		    	var notDecoreNum=$("#notDecoreNum").val();
		    	if(notDecoreNum>nnum){
			    	alert("数据错误，不出库数据大于总数据")
			    	return ;
			    }
		    	if(null==note||note==undefined||note.length<2){
		    		alert("请填写备注！");
		    		$("#note").focus();
		    		return false;
		    	}
		        return true;
		    },
		    cancel:function(){
			    return true;
		    },
			lock: true
		});
	}else{
		crateTr2(dbid);
		addDecorePrice(dbid);
	}
}
function decoreOut(dbid){
	$("#str"+dbid).show();
}
function crateTr2(dbid) {
	var ntype=$("#type"+dbid).val();
	var nnproductId=$("#productId"+dbid).val();
	var nnum=$("#num"+dbid).val();
	var size = $("#shopNumber2").find("tr").size();
	size = size-2;
	var str = ' <tr id="tr'+size+'" style="background-color: #F2DEDE;">'
			+'<td style="text-align: center;">'+size+'</td>'
				+'<input type="hidden" name="ntype" id="type'+size+'" value="'+ntype+'"  class="media text" >'
				+'<input type="hidden" name="nproductId" id="nproductId'+size+'" value="'+nnproductId+'">'
				+ '<input type="hidden"  name="nnum" id="nnum'+size+'" value="'+nnum+'" class="small text" >'
			+ '<td style="text-align: left;">'+$("#productName"+dbid).text()
			+ '</td>'
			+ '<td  style="text-align: center;">'+$("#productcategory"+dbid).text()
			+ '</td>'
			+ '<td  style="text-align: center;">'+$("#price"+dbid).text()
			+ '</td>'
			+ '<td  style="text-align: center;">'+$("#salerPrice"+dbid).text()
			+ '</td>'
			+ '<td style="text-align: center;">'+$("#saleNum"+dbid).text()
			+ '</td>'
			+ '<td >'
			+ '	<input type="text" name="nnote" id="note${i+1 }" value="'+$("#note"+dbid).val()+'" class="mieda text" style="background-color: #F2DEDE;border:1px solid  #cccccc" checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >'
			+' <a href="javascript:void(-1)" onclick="cancel(this,'+dbid+')" style="color: #2b7dbc">转出库</a>'
			+ '</td>'
			 + '</tr>';
	$("#shopNumber2 tr").last().before(str);
}
function cancel(text,dbid){
	var dd=$(text).parent().parent().remove();
	$("#str"+dbid).show();
	reduceDecorePrice(dbid);
}
function deleteNotDecoreOut(){
	$("#shopNumber tr:hidden").each(function (i){
		$(this).remove();
	})
}
function de11l(){
	
}
</script>
</html>