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
<div class="frmTitle" onclick="showOrHiden('contactTable')">合同备注</div>
	<div>
		${orderContract.note }
	</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')" style="margin-top: 2px;">&nbsp;</div>
<form action="" id="frmId" name="frmId" target="_self">
<input type="hidden" id="editType" name="editType" value="${param.editType}">
<input type="hidden" id="modifyType" name="modifyType" value="${param.modifyType}">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid }">
<input type="hidden" id="orderContractExpenseId" name="orderContractExpenseId" value="${orderContractExpense.dbid }">
<input type="hidden" id="smtType" name="smtType" value="1">
<input type="hidden" id="wlbCheck" name="wlbCheck" value="1">
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
			<th style="width: 40px;text-align: center;">操作</th>
		</tr>
	</thead>
	<tbody style="overflow: scroll;">
	<!-- 添加时展示页面 -->
		<c:if test="${empty(orderContractDecore) }">
			<c:forEach var="i" begin="0" step="1" end="7">
				<tr id="tr${i+1 }">
					<td style="text-align: center;">
						${i+1 }
					</td>
					<td >
						<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)" class="smallX text" style="width: 92%;">
						<input type="hidden" name="productDbid" id="productDbid${i+1}" value="">
						<input type="hidden" name="costPrice" id="costPrice${i+1}" value="">
						<input type="hidden" name="salerCostPrice" id="salerCostPrice${i+1}" value="">
					</td>
					<td id="sn${i+1 }" style="text-align: center;">
						<select id="type1" name="type1" class="smallX text" style="width: 92%;" class="select" onchange="decorePrice()">
							<option value="1">销售项目</option>
							<option value="2">赠送项目</option>
						</select>
					</td>
					<td id="sno${i+1 }" style="text-align: center;"></td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="price" id="price${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td>
						<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;" onfocus="decorePrice()" onchange="decorePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<!-- 添加时展示页面 结束 -->
		<!-- 编辑时展示页面 结束 -->
		<c:if test="${!empty(orderContractDecore) }">
			<c:set value="${fn:length(orderContractDecore.orderContractDecoreItem)}" var="itemLength"></c:set>
			<c:forEach var="orderContractDecoreItem" items="${orderContractDecore.orderContractDecoreItem }" varStatus="i">
				<tr id="tr${i.index+1 }">
					<td style="text-align: center;">
						${i.index+1 }
					</td>
					<td >
						<input type="text" name="productName" id="productName${i.index+1 }" value="${orderContractDecoreItem.product.name }" onFocus="autoProductByName('productName${i.index+1 }');create(this)"  class="smallX text" style="width: 92%;">
						<input type="hidden" name="productDbid" id="productDbid${i.index+1}" value="${orderContractDecoreItem.product.dbid }" >
						<input type="hidden" name="costPrice" id="costPrice${i.index+1}" value="${orderContractDecoreItem.product.costPrice }" >
						<input type="hidden" name="salerCostPrice" id="salerCostPrice${i.index+1}" value="${orderContractDecoreItem.product.salerCostPrice }" >
					</td>
					<td id="sn${i.index+1 }" style="text-align: center;">
						<select id="type1" name="type1"  onchange="decorePrice()" class="smallX text" style="width: 92%;">
							<option value="1" ${orderContractDecoreItem.type==1?'selected="selected"':'' } >销售项目</option>
							<option value="2"  ${orderContractDecoreItem.type==2?'selected="selected"':'' }>赠送项目</option>
						</select>
					</td>
					 <td id="sno${i.index+1 }" style="text-align: center;">
						<a href='javascript:;' onclick="$.utile.openDialog('${ctx}/product/viewProduct?productId=${orderContractDecoreItem.product.dbid }','商品明细',760,320)">${orderContractDecoreItem.product.sn }</a>
					</td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="price" id="price${i.index+1 }" value="${orderContractDecoreItem.price }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td>
						<input type="text" name="num" id="num${i.index+1 }" style="width: 92%;" onfocus="decorePrice()" onchange="decorePrice()" value="${orderContractDecoreItem.quality }" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字" class="smallX text" style="width: 92%;">
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
			</c:forEach>
			<c:forEach var="i" begin="${itemLength }" step="1" end="7">
				<tr id="tr${i+1 }">
					<td style="text-align: center;">
						${i+1 }
					</td>
					<td >
						<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)"  class="smallX text" style="width: 92%;">
						<input type="hidden" name="productDbid" id="productDbid${i+1}" value="">
						<input type="hidden" name="costPrice" id="costPrice${i+1}" value="">
						<input type="hidden" name="salerCostPrice" id="salerCostPrice${i+1}" value="">
					</td>
					<td id="sn${i+1 }" style="text-align: center;">
						<select id="type1" name="type1" class="smallX text"  onchange="decorePrice()" style="width: 92%;">
							<option value="1">销售项目</option>
							<option value="2">赠送项目</option>
						</select>
					</td>
					<td id="sno${i+1 }" style="text-align: center;"></td>
					<td style="text-align: center;">
						<input type="text" readonly="readonly"  name="price" id="price${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
					</td>
					<td>
						<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;" onfocus="decorePrice()" onchange="decorePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
					</td>
					<td style="text-align: center;padding-top: 8px;">
						<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
							<i class="icon-remove icon-black" > </i>
						</a>
					</td>
				</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
<div class="container-fluid" style="margin-top: 0;">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px;" >
		<tr>
			<td class="formTableTdLeft">装饰款</td>
			<td  colspan="">
				<input type="text" readonly="readonly" name="orderContractDecore.acturePrice" id="acturePrice" value="${orderContractExpense.decoreMoney}" class="largeX text">
			</td>
			<td class="formTableTdLeft">销售装饰合计</td>
			<td colspan="">
				<input readonly="readonly" type="text" name="orderContractDecore.decoreSaleTotalPrce" id="decoreSaleTotalPrce" value="${orderContractDecore.decoreSaleTotalPrce }" class="largeX text">
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">赠送装饰合计</td>
			<td  colspan="">
				<input readonly="readonly" type="text" name="orderContractDecore.giveTotalPrice" id="giveTotalPrice" value="${orderContractDecore.giveTotalPrice }" class="largeX text">
			</td>
			 <td class="formTableTdLeft">折扣率</td>
			<td>
				<input type="text" readonly="readonly" name="orderContractDecore.zkl" id="zkl" value="${orderContractDecore.zkl }" class="largeX text"> 
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">销售顾问结算</td>
			<td  colspan="">
				<input type="text" readonly="readonly" name="orderContractDecore.salerTotalPrice" id="salerTotalPrice" value="${orderContractDecore.salerTotalPrice}" class="largeX text">
			</td>
			<td class="formTableTdLeft">结算利润</td>
			<td  colspan="">
				<input type="text" readonly="readonly" name="orderContractDecore.salerGrofitPrice" id="salerGrofitPrice" value="${orderContractDecore.salerGrofitPrice}" class="largeX text">
			</td>
		<tr>
			 <td class="formTableTdLeft">装饰成本</td>
			<td>
				<input type="text" readonly="readonly" name="orderContractDecore.costPrice" id="costPrice" value="${orderContractDecore.costPrice }" class="largeX text"> 
			</td>
			<td class="formTableTdLeft">装饰利润</td>
			<td>
				<input type="text" readonly="readonly" name="orderContractDecore.costGrofitPrice" id="costGrofitPrice" value="${orderContractDecore.costGrofitPrice }" class="largeX text"> 
			</td>
		</tr>
		
	</table>
</div>
<div class="formButton">
	
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="if(valida()){smtFrm(1)}">
		保存并继续</a>
	<a class="but butCancle" onclick="window.location.href='${ctx}/outboundOrder/orderContractExpenses?customerId=${customer.dbid }'"><i class="icon-arrow-left icon-white"></i> 查看上一页</a>
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
function valida(){
	var acturePrice=$("#acturePrice").val();
	var decoreSaleTotalPrce=$("#decoreSaleTotalPrce").val();
	if(acturePrice<=0){
		if(decoreSaleTotalPrce>0){
			alert("出库单中未含装饰款项，如有销售装饰项目请返回上一页添加【装饰款】项目！");
			return false;
		}
	}
	return true;
}
//商品表格编辑部分
function create(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#shopNumber tr").last().attr("id")){
		crateTr();
		$("#te").scrollTop($("#shopNumber")[0].scrollHeight);
	}
}
function deleteTr(tr) {
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#shopNumber").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		decorePrice();
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="productName" id="productName'+size+'" value="" class="smallX text" style="width: 92%;" onFocus=\'autoProductByName("productName'+size+'");create(this)\'/>'
			+ '<input type="hidden" name="productDbid" id="productDbid'+size+'" value="">'
			+ '<input type="hidden" name="costPrice" id="costPrice'+size+'" value="">'
			+ '<input type="hidden" name="salerCostPrice" id="salerCostPrice'+size+'" value="">'
			+ '</td>'
			+'<td id="sn'+size+'" style="text-align: center;">'
			+	'<select id="type1" name="type1" style="width: 100%;"  onchange="decorePrice()" class="smallX text" style="width: 92%;">'
			+		'<option value="1">销售项目</option>'
			+		'<option value="2">赠送项目</option>'
			+	'</select>'
			+'</td>'
			+ '<td id="sno'+size+'" style="text-align: center;">'
			+ '</td>' 
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly"  name="price" id="price'+size+'"  onfocus="count()" class="smallX text" style="width: 92%;">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" class="smallX text" style="width: 92%;" onfocus="decorePrice()" onchange="decorePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

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
		var sn=id.substring(11,id.length);
		$("#productName"+sn).val(data.name);
		$("#productDbid"+sn).val(data.dbid);
		$("#brand"+sn).text("");
		$("#brand"+sn).text(data.brand);
		 $("#sno"+sn).text("");
		var on="<a href='javascript:;' onclick=\"$.utile.openDialog('${ctx}/product/viewProduct?productId="+data.dbid+"','商品明细',760,320)\">"+data.sn+"</a>";
		$("#sno"+sn).append(on);
		$("#price"+sn).val(data.price);
		$("#costPrice"+sn).val(data.costPrice);
		$("#salerCostPrice"+sn).val(data.salerCostPrice);
		$("#num"+sn).val(1);
		decorePrice();
		
	}
function decorePrice(){
	var types=$("select[name=type1]");
	var prices=$("input[name=price]");
	var costPrices=$("input[name=costPrice]");
	var salerCostPrices=$("input[name=salerCostPrice]");
	var nums=$("input[name=num]");
	var totalA=0,totalB=0,salerTotalPrice=0,costPrice=0;
	for(var i=0;i<types.length;i++){
		var num=$(nums[i]).val();
		if(null!=num&&undefined!=num&&num!=''){
			var type=$(types[i]).val();
			var price=$(prices[i]).val();
			var costPri=$(costPrices[i]).val();
			var salerCostPri=$(salerCostPrices[i]).val();
			if(type==1){
				totalA=totalA+parseInt(price)*parseInt(num);
			}
			if(type==2){
				totalB=totalB+parseInt(price)*parseInt(num);
			}
			costPrice=costPrice+parseInt(costPri)*parseInt(num);
			salerTotalPrice=salerTotalPrice+parseInt(salerCostPri)*parseInt(num);
		}
	}
	$("#costPrice").val(costPrice);
	$("#salerTotalPrice").val(salerTotalPrice);
	$("#decoreSaleTotalPrce").val(totalA);
	$("#giveTotalPrice").val(totalB);
	$("#costGrofitPrice").val(totalB);
	var decoreTotal=parseInt($("#acturePrice").val());
	var src=parseFloat(decoreTotal/totalA)*100;
	var zklFLoat=parseFloat(src);
	if (isNaN(zklFLoat)||zklFLoat=='Infinity'){
		zklFLoat=0;
	} 
	$("#zkl").val(formatFloat(zklFLoat)+"%");
	
	var costGrofitPrice=0,salerGrofitPrice=0;
	var acturePrice=$("#acturePrice").val();
	//实际利润 :总销售额-成本
	costGrofitPrice=acturePrice-costPrice;
	salerGrofitPrice=acturePrice-salerTotalPrice;
	$("#costGrofitPrice").val(costGrofitPrice);
	$("#salerGrofitPrice").val(salerGrofitPrice);
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
function smtFrm(value){
	$("#custPidSmtType").val(value);
	var decoreSaleTotalPrce= $("#decoreSaleTotalPrce").val();
	var decoreTotal=parseInt($("#acturePrice").val());
	if(decoreTotal>0){
		if(decoreSaleTotalPrce==0||decoreSaleTotalPrce=='0.0'){
			if(confirm("收费明细中存在【装饰款项目】,请确认装饰通知单是否以当前状态保存！")){
				$.utile.submitAjaxForm('frmId','${ctx}/orderContractDecore/saveOrderContractDecore');
				return ;
			}else{
				return ;
			}
		}
	}
	$.utile.submitAjaxForm('frmId','${ctx}/orderContractDecore/saveOrderContractDecore');
}
</script>
</html>
