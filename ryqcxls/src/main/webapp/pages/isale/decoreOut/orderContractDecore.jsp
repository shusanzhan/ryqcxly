<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>订单填写-装饰明细</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
.seal{
	background-image: url("${ctx}/images/xwqr/seal150.png");
	height: 64px;
	width: 150px;
	position: absolute;left: 300px;top: 120px;
}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">订单提报（装饰明细）</a>
</div>
<div class="line"></div>
<div class="frmContent" >
<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆基本信息</div>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
		<tr height="32">
			<td class="formTableTdLeft">车型：&nbsp;</td>
				<td >
				 ${factoryOrder.brand.name }  
				 ${factoryOrder.carSeriy.introduction }
				  ${factoryOrder.carModel.name }${customer.carModelStr}
				  ${factoryOrder.carColor.name }
			</td>
			<td class="formTableTdLeft">VIN吗：&nbsp;</td>
			<td >
				<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1" class="" style="color: #46A0DE;">${factoryOrder.vinCode }</a>
				&nbsp;&nbsp;&nbsp;
				<span style="color: red;font-size: 16px;font-weight: bold;">${factoryOrder.huimin}</span>
			</td>
			<td class="formTableTdLeft">入库日期：&nbsp;</td>
				<td >
				  <fmt:formatDate value="${factoryOrder.carReceiving.stockInDate}" pattern="yyyy-MM-dd"/> 
			</td>
		</tr>
		<tr height="32">
			<td class="formTableTdLeft">经销商类型：&nbsp;</td>
			<td >
				<c:if test="${empty(customer.distributor) }">
					自有店
				</c:if>
				<c:if test="${!empty(customer.distributor) }">
					${customer.distributor.name}
					(${customer.distributor.distributorType.name})
				</c:if>
			</td>
			<td class="formTableTdLeft">销售顾问：&nbsp;</td>
			<td >
				${customer.user.department.name} ${customer.bussiStaff}
			</td>
			<td class="formTableTdLeft">联系电话：&nbsp;</td>
			<td >
				${customer.user.mobilePhone}
			</td>
		</tr>
		<tr height="32">
			<td class="formTableTdLeft">客户姓名：&nbsp;</td>
			<td >
				${customer.name}&nbsp;&nbsp;${customer.sex}
			</td>
			<td class="formTableTdLeft">联系电话：&nbsp;</td>
			<td >
				${customer.mobilePhone}
			</td>
			<td class="formTableTdLeft">身份证地址：&nbsp;</td>
			<td >
				${customer.area.fullName} ${fn:substring(customer.address,0,12) }
			</td>
		</tr>
</table>
<c:if test="${customerPidBookingRecord.outStockCheckStatus==2 }">
	<div class="seal" ></div>
</c:if>
<div class="frmTitle" onclick="showOrHiden('contactTable')" style="margin-top: 2px;">&nbsp;合同签订装饰</div>
<form action="" id="frmId" name="frmId" target="_self">
<input type="hidden" id="editType" name="editType" value="${param.editType}">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<input type="hidden" id="decoreOutId" name="decoreOutId" value="${param.decoreOutId }">
<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid }">
<input type="hidden" id="orderContractExpenseId" name="orderContractExpenseId" value="${orderContractExpense.dbid }">
<input type="hidden" id="smtType" name="smtType" value="1">
<input type="hidden" value="${orderContractDecore.dbid }" id="orderContractDecoreDbid" name="orderContractDecore.dbid">
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
	<thead>
		<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 200px;text-align: center;">项目名称</th>
			<th style="width: 80px;text-align: center;">类型</th>
			<th style="width: 120px;text-align: center;">编号</th>
			<th style="width: 60px;text-align: center;">销售价格</th>
			<th style="width: 60px;text-align: center;">数量</th>
		</tr>
	</thead>
	<tbody style="overflow: scroll;">
			<c:set value="${fn:length(orderContractDecore.orderContractDecoreItem)}" var="itemLength"></c:set>
			<c:forEach var="orderContractDecoreItem" items="${orderContractDecore.orderContractDecoreItem }" varStatus="i">
				<tr id="tr${i.index+1 }">
					<td style="text-align: center;">
						${i.index+1 }
					</td>
					<td >
						${orderContractDecoreItem.product.name }
					</td>
					<td id="sn${i.index+1 }" style="text-align: center;">
						<input type="hidden" name="type1" id="type1${i.index+1}" value="${orderContractDecoreItem.type }" >
						<c:if test="${orderContractDecoreItem.type==1 }">
							销售项目
						</c:if>
						<c:if test="${orderContractDecoreItem.type==2 }">
							赠送项目
						</c:if>
					</td>
					 <td id="sno${i.index+1 }" style="text-align: center;">
						<a href='javascript:;' onclick="$.utile.openDialog('${ctx}/product/viewProduct?productId=${orderContractDecoreItem.product.dbid }','商品明细',760,320)">${orderContractDecoreItem.product.sn }</a>
					</td>
					<td style="text-align: center;">
						${orderContractDecoreItem.price }
					</td>
					<td>
						${orderContractDecoreItem.quality }
					</td>
				</tr>
			</c:forEach>
	</tbody>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')" style="margin-top: 2px;">&nbsp;待修改装饰</div>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<th style="width: 40px;text-align: center;">序号</th>
			<th style="width: 120px;text-align: center;">商品序列</th>
			<th style="width: 120px;text-align: center;">品名规格</th>
			<th style="width: 60px;text-align: center;">单位</th>
			<th style="width: 60px;text-align: center;">货品类型</th>
			<th style="width: 60px;text-align: center;">销售单价</th>
			<th style="width: 60px;text-align: center;">顾问结算</th>
			<th style="width: 60px;text-align: center;">数量</th>
			<th style="width: 140px;text-align: center;">备注</th>
	</tr>
	<!-- 添加时展示页面 -->
	<c:set value="0" var="totalPrice"></c:set>
	<c:set value="0" var="totalSalerPrice"></c:set>
	<c:set value="0" var="totalPurchasePrice"></c:set>
	<c:forEach var="decoreOutProduct" items="${decoreOutProducts }" varStatus="i">
			<tr id="tr" onclick="" >
				<td style="text-align: center;">
					${i.index+1}
				</td>
				<td>
					<input type="text" name="productSn" id="productSn${i.index+1 }" onfocus="autoProductByName('productSn${i.index+1 }');" onkeyup="autoProductByName('productSn${i.index+1 }')"  class="media text" >
					<input type="hidden" name="decoreOutProductId" id="decoreOutProductId" class="small text" value="${decoreOutProduct.dbid }">
					<input type="hidden" name="productId" id="productId${i.index+1 }" value="${decoreOutProduct.product.dbid }">
					<c:set value="${totalPrice+(decoreOutProduct.price*decoreOutProduct.num)}" var="totalPrice"></c:set>
					<c:set value="${totalSalerPrice+(decoreOutProduct.salerPrice*decoreOutProduct.num)}" var="totalSalerPrice"></c:set>
					<input type="hidden" name="price" id="iprice${i.index+1 }" value="${decoreOutProduct.price}">
					<input type="hidden" name="salerPrice" id="isalerPrice${i.index+1 }" value="${decoreOutProduct.salerPrice}">
					<input type="hidden" name="num" id="inum${i.index+1 }" value="${decoreOutProduct.num}">
				</td>
				<td id="productName${i.index+1 }">
					${decoreOutProduct.productName }
				</td>
				<td style="text-align: center;" id="unit${i.index+1 }">
					${decoreOutProduct.product.unit }
				</td>
				<td style="text-align: center;" id="productcategoryName${i.index+1 }">
					${decoreOutProduct.product.productcategory.name }
				</td>
				<td style="text-align: center;" id="price${i.index+1 }">
					${decoreOutProduct.price}
				</td>
				<td style="text-align: center;" id="salerPrice${i.index+1 }">
					${decoreOutProduct.salerPrice}
				</td>
				<td style="text-align: center;">
					${decoreOutProduct.num }
				</td>
				<td>
					<input type="text" name="note" id="note${i.index+1 }" class="mideaX text" style=";border:1px solid  #cccccc" checkType="string,1" canEmpty="Y" value="${decoreOutProduct.note }" tip="请输入项目备注信息" >
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
			<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
				0
			</span>元
			实收金额：
			<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
				${decoreOut.acturePrice }
			</span>元
		</td>
	</tr>
</table>
<div class="container-fluid" style="margin-top: 0;">
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
				<td ><input type="text" readonly="readonly" name="decoreOut.carPlateNo" id="carPlateNo" value="${decoreOut.carPlateNo }" class="largeX text" title="车牌号"	checkType="string,7,7" canEmpty="Y" tip="车牌号可为空"></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="decoreOut.note" id="note" title="内容简介"  class="largeXX text" style="height: 40px;width: 720px;">${decoreOut.note }</textarea>
				</td>
			</tr>
		</table>
</div>
<div class="formButton">
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="$.utile.submitAjaxForm('frmId','${ctx}/decoreOut/saveEditDecoreOut');">
		保存</a>
	<a class="but butCancle" onclick="window.history.go(-1)"><i class="icon-arrow-left icon-white"></i> 返回</a>
</div>
</form>
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
<script type="text/javascript">
function autoProductByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/product/autoProduct",{
			extraParams:{brandId:"${customerLastBussi.carSeriy.brand.dbid}"},
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;序号： "+row.sn+"&nbsp;&nbsp;价格："+row.price+"&nbsp;&nbsp; 品牌："+row.brand+"&nbsp;&nbsp; </span>";   
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
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(9,id.length);
		$("#productName"+sn).text(data.name);
		$("#productSn"+sn).val(data.sn);
		$("#productId"+sn).val(data.dbid);
		$("#unit"+sn).text(data.unit);
		$("#productcategoryName"+sn).text("");
		$("#productcategoryName"+sn).text(data.productcategoryName);
		$("#price"+sn).text(data.price);
		$("#iprice"+sn).val(data.price);
		$("#isalerPrice"+sn).val(data.salerCostPrice);
		$("#salerPrice"+sn).text(data.salerCostPrice);
		decorePrice();
	}
function decorePrice(){
	var prices=$("input[name=price]");
	var nums=$("input[name=num]");
	var salerPrices=$("input[name=salerPrice]");
	var totalA=0,salerTotalPrice=0,costTotalPrice=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		var num=$(nums[i]).val();
		if(null==num||num==''){
			num=1;
		}else{
			num=parseInt(num);
		}
		if(price==""||price==null){
			price=0;
		}else{
			price=parseInt(price);
		}
		totalA=totalA+price*num;
		
		var salerPrice=$(salerPrices[i]).val();
		if(salerPrice==""||salerPrice==null){
			salerPrice=0;
		}else{
			salerPrice=parseInt(salerPrice);
		}
		salerTotalPrice=salerTotalPrice+salerPrice*num;
	}
	$("#totalPriceText").text(totalA);
	$("#decoreSaleTotalPrce").val(totalA);
	$("#salerTotalPrice").val(salerTotalPrice);
	$("#totalSalerPriceText").text(salerTotalPrice);
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
</script>
</html>
