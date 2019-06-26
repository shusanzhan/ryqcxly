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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
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
</style>
<title>装饰销售</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/purchaseStorage/queryList'">装饰销售</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(purchaseStorage) }">添加销售单</c:if>
	<c:if test="${!empty(purchaseStorage) }">编辑装饰单</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
				<thead>
					<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 200px;text-align: center;">项目名称</th>
						<th style="width: 120px;text-align: center;">编号</th>
						<th style="width: 80px;text-align: center;">品牌</th>
						<th style="width: 60px;text-align: center;">销售价格</th>
						<th style="width: 60px;text-align: center;">顾问结算价</th>
						<th style="width: 60px;text-align: center;">成本价</th>
						<th style="width: 60px;text-align: center;">数量</th>
						<th style="width: 60px;text-align: center;">备注</th>
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
								</td>
								<td id="sno${i+1 }" style="text-align: center;"></td>
								<td id="brand${i+1 }" style="text-align: center;"></td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="price" id="price${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="salerCostPrice" id="salerCostPrice${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
								</td>
								<td style="text-align: center;">
									<input type="hidden" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" class="small text"   checkType="float,1" canEmpty="Y" >
									<input type="text" readonly="readonly"  name="costPrice" id="costPrice${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
								</td>
								<td>
									<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;" onfocus="decorePrice(${i+1 })" onchange="decorePrice(${i+1 })" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="mideaX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
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
								 <td id="sno${i.index+1 }" style="text-align: center;">
									<a href='javascript:;' onclick="$.utile.openDialog('${ctx}/product/viewProduct?productId=${orderContractDecoreItem.product.dbid }','商品明细',760,320)">${orderContractDecoreItem.product.sn }</a>
								</td>
								<td id="brand${i.index+1 }" style="text-align: center;">
									${orderContractDecoreItem.product.brand.name }
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="price" id="price${i.index+1 }" value="${orderContractDecoreItem.price }" class="smallX text" style="width: 92%;" onfocus="count()">
								</td>
								<td>
									<input type="text" name="num" id="num${i.index+1 }" style="width: 92%;" onfocus="decorePrice(${i.index+1 })" onchange="decorePrice(${i.index+1 })" value="${orderContractDecoreItem.quality }" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字" class="smallX text" style="width: 92%;">
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
								<td>
									<input type="text" name="note" id="note${i.index+1 }" class="mideaX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
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
								<td id="sno${i+1 }" style="text-align: center;"></td>
								<td id="brand${i+1 }" style="text-align: center;"></td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="price" id="price${i+1 }" class="smallX text" style="width: 92%;" onfocus="count()">
								</td>
								<td>
									<input type="text" name="num" id="num${i+1 }" class="smallX text" style="width: 92%;" onfocus="decorePrice(${i+1 })" onchange="decorePrice(${i+1 })" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="mideaX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
								</td>
							</tr>
					</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td id="stockTip" width="50%" colspan="5" style="text-align: left;padding-right: 12px;border-right: 0">
				</td>
				<td width="50%" colspan="5" style="text-align: right;padding-right: 12px;border-left: 0">
					销售金额：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
						<c:if test="${empty(purchaseStorage.purchaseMoney) }">
							0
						</c:if>
						<c:if test="${!empty(purchaseStorage.purchaseMoney) }">
							${purchaseStorage.purchaseMoney }
						</c:if>
					</span>元
				</td>
			</tr>
		</table>
			<input type="hidden" name="decoreOut.decoreSaleTotalPrce" id="purchaseMoney" value="0" class="largeX text" >
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px">
			<tr height="42">
				<td class="formTableTdLeft">折扣率:&nbsp;</td>
				<td >
					<c:if test="${empty(decoreOut) }">
						<input type="text" name="decoreOut.zkl" id="zkl" onkeyup="disMoneyDis(this.value)" value="100" class="largeX text" title="折扣率" placeholder="100"	checkType="float,1" tip="折扣率不能为空">%<span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(decoreOut) }">
						<input type="text" name="decoreOut.zkl" id="zkl" onkeyup="disMoneyDis(this.value)" value="${decoreOut.zkl }" class="largeX text" title="折扣率" placeholder="100"	checkType="float,1" tip="折扣率不能为空">%<span style="color: red;">*</span>
					</c:if>
				</td>
				<td class="formTableTdLeft">折扣后金额:&nbsp;</td>
				<td>
					<c:if test="${empty(decoreOut) }">
						<input type="text" name="decoreOut.disMoney" id="disMoney" value="0" class="largeX text" title="折扣后金额" checkType="float,1" tip="折扣后金额不能为空"><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(decoreOut) }">
						<input type="text" name="decoreOut.disMoney" id="disMoney" value="${decoreOut.disMoney }" class="largeX text" title="折扣后金额" checkType="float,1" tip="折扣后金额不能为空"><span style="color: red;">*</span>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">成本总额:&nbsp;</td>
				<td colspan="">
					<input type="text" name="decoreOut.costTotalPrice" id="costTotalPrice" value="${decoreOut.costTotalPrice}"  placeholder="0.0" class="largeX text" title="成本总额"	checkType="float,1" tip="成本总额"><span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">顾问结算总额:&nbsp;</td>
				<td >
					<input type="text" name="decoreOut.salerTotalPrice" id="salerTotalPrice" value="${decoreOut.salerTotalPrice }" placeholder="0.0" class="largeX text" title="顾问结算总额"	checkType="float,1" tip="顾问结算总额"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">实收金额:&nbsp;</td>
				<td colspan="">
					<input type="text" name="decoreOut.acturePrice" id="acturePrice" value="${decoreOut.acturePrice }"  placeholder="0.0" class="largeX text" title="本次付款金额"	checkType="float,1" tip="本次付款金额">
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">销售人员:&nbsp;</td>
				<td colspan="">
					<input type="hidden" name="userId" id="userId" value="${decoreOut.user.dbid }" >
					<input type="text" name="decoreOut.saler" onfocus="autoUser('saler')" id="saler" value="${decoreOut.saler }"  placeholder="请输入销售人员的拼音" class="largeX text" title="销售人员"	checkType="string,1" tip="销售人员不能为空">
					<span style="color: red;">*</span>
				</td>
				
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td ><input type="text" name="decoreOut.customerName" id="customerName" value="${decoreOut.customerName }" class="largeX text" title="客户姓名"	checkType="string,1,7" canEmpty="Y" tip="客户姓名"></td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td ><input type="text" name="decoreOut.mobilePhone" id="mobilePhone" value="${decoreOut.mobilePhone }" class="largeX text" title="联系电话"	checkType="mobilePhone" canEmpty="Y" tip="联系电话可为空"></td>
			</tr>
			<tr>
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td colspan="3"><input type="text" name="decoreOut.carPlateNo" id="carPlateNo" value="${decoreOut.carPlateNo }" class="largeX text" title="车牌号"	checkType="string,7,7" canEmpty="Y" tip="车牌号可为空"></td>
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
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/saleDecoreOut/savePreDecoreOut')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
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
			+ '</td>'
			+ '<td id="sno'+size+'" style="text-align: center;">'
			+ '</td>' 
			+ '<td id="brand'+size+'" style="text-align: center;">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly"  name="price" id="price'+size+'"  onfocus="count()" class="smallX text" style="width: 92%;">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly"  name="salerCostPrice" id="salerCostPrice'+size+'"  onfocus="count()" class="smallX text" style="width: 92%;">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly"  name="costPrice" id="costPrice'+size+'"  onfocus="count()" class="smallX text" style="width: 92%;">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" class="smallX text" style="width: 92%;" onfocus="decorePrice('+size+')" onchange="decorePrice('+size+')" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '<input type="hidden" readonly="readonly"  name="totalMoney" id="totalMoney'+size+'" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			 '<td >'
			+ '	<input type="text" name="note" id="note${i+1 }" class="mieda text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}
function onRecordSelect1(event,data,formatted) {
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
	$("#totalMoney"+sn).val(data.price);
	$("#costPrice"+sn).val(data.costPrice);
	$("#salerCostPrice"+sn).val(data.salerCostPrice);
	$("#num"+sn).val(1);
	decorePrice(); 
	
}
function autoProductByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/product/autoProductByName",{
			extraParams:{},
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
	$(id1).result(onRecordSelect1);
}

function decorePrice(index){
	if(null!=index&&index!=undefined){
		var p=$("#price"+index).val();
		var num=$("#num"+index).val();
		var to=p*num;
		$("#totalMoney"+index).val(to);
	}
	var prices=$("input[name=totalMoney]");
	var costPrices=$("input[name=costPrice]");
	var salerPrices=$("input[name=salerCostPrice]");
	var totalA=0,salerTotalPrice=0,costTotalPrice=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		if(price==""||price==null){
			price=0;
		}else{
			price=parseInt(price);
		}
		totalA=totalA+price;
		
		var salerPrice=$(salerPrices[i]).val();
		if(salerPrice==""||salerPrice==null){
			salerPrice=0;
		}else{
			salerPrice=parseInt(salerPrice);
		}
		salerTotalPrice=salerTotalPrice+salerPrice;
		
		var costPrice=$(costPrices[i]).val();
		if(costPrice==""||costPrice==null){
			costPrice=0;
		}else{
			costPrice=parseInt(costPrice);
		}
		costTotalPrice=costTotalPrice+costPrice;
	}
	$("#purchaseMoney").val(totalA);
	$("#salerTotalPrice").val(salerTotalPrice);
	$("#costTotalPrice").val(costTotalPrice);
	
	$("#purchaseMoneyText").text(totalA);
	
	var dis=$("#zkl").val();
	if(null!=dis&&dis!=''){
		$("#disMoney").val(totalA*dis/100);
		$("#acturePrice").val(totalA*dis/100);
	}else{
		$("#disMoney").val(totalA);
		$("#acturePrice").val(totalA);
	}
}
function disMoneyDis(dis){
	var purchaseMoney= $("#purchaseMoney").val();
	if(null!=purchaseMoney&&purchaseMoney!=''&&purchaseMoney!=undefined){
		if(null!=dis&&dis!=''){
			$("#disMoney").val(purchaseMoney*dis/100);
			$("#acturePrice").val(purchaseMoney*dis/100);
		}else{
			$("#disMoney").val(purchaseMoney);
			$("#acturePrice").val(purchaseMoney);
		}
	}else{
		$("#disMoney").val(0);
	}
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
	$(id1).result(onRecordSelect);
	//计算总金额
}

function onRecordSelect(event, data, formatted) {
		$("#saler").val(data.name);
		$("#userId").val(data.dbid);
}
</script>
</html>