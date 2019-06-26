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
	width: 70px;
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
	查看销售单
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 60px;text-align: center;">序号</th>
						<th style="width: 120px;text-align: center;">品名规格</th>
						<th style="width: 120px;text-align: center;">数量</th>
						<th style="width: 60px;text-align: center;">进货单</th>
						<th style="width: 60px;text-align: center;">单位</th>
						<th style="width: 60px;text-align: center;">货品类型</th>
						<th style="width: 60px;text-align: center;">销售单价</th>
						<th style="width: 60px;text-align: center;">金额</th>
						<th style="width: 60px;text-align: center;">进货价</th>
						<th style="width: 140px;text-align: center;">备注</th>
				</tr>
					<!-- 添加时展示页面 结束 -->
					<!-- 编辑时展示页面 结束 -->
						<c:set value="${fn:length(decoreOutProducts)}" var="itemLength"></c:set>
						<c:forEach var="decoreOutProduct" items="${decoreOutProducts }" varStatus="i">
							<tr id="tr${i.index+1 }">
								<td style="text-align: center;width: 50px;">
									${i.index+1 }
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i.index+1 }" value="${decoreOutProduct.product.name }" class="media text" >
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i.index+1 }" value="${decoreOutProduct.num }" class="small text" >
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i.index+1 }" value="${decoreOutProduct.purchaseProductNo }" class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i.index+1 }" class="small text" value="${decoreOutProduct.product.unit }" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i.index+1 }" class="small text" value="${decoreOutProduct.product.productcategory.name }">
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly" name="price" id="price${i.index+1 }" class="small text" value="${decoreOutProduct.price}"  onkeyup="decorePrice(${i.index+1 })" checkType="float,1" canEmpty="Y" tip="请输入商品单据，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i.index+1 }" value="${decoreOutProduct.purchasePrice}" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i.index+1 }" value="${decoreOutProduct.salerPrice}" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td>
									<input type="text" readonly="readonly" name="note" id="note${i.index+1 }" class="large text" value="${decoreOutProduct.note}"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
								</td>
							</tr>
						</c:forEach>
						<c:forEach var="i" begin="${itemLength }" step="1" end="7">
							<tr id="tr${i+1 }">
								<td style="text-align: center;width: 50px;">
									${i+1 }
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i+1 }" value="${decoreOutProduct.productItem.no }" class="media text" >
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i+1 }" value="${decoreOutProduct.product.name }" class="small text" >
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i+1 }" value="${decoreOutProduct.product.name }" class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i+1 }" class="small text" value="${decoreOutProduct.product.unit }" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i+1 }" class="small text" value="${decoreOutProduct.product.productcategory.name }">
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly" name="price" id="price${i+1 }" class="small text" value="${decoreOutProduct.price}"  onkeyup="decorePrice(${i+1 })" checkType="float,1" canEmpty="Y" tip="请输入商品单据，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" value="${decoreOutProduct.purchasePrice}" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" value="${decoreOutProduct.salerPrice}" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td>
									<input type="text" readonly="readonly" name="note" id="note${i+1 }" class="large text" value="${decoreOutProduct.note}"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
								</td>
							</tr>
					</c:forEach>
			</table>
		</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td id="stockTip" width="50%" colspan="5" style="text-align: left;padding-right: 12px;border-right: 0">
				</td>
				<td width="50%" colspan="5" style="text-align: right;padding-right: 12px;border-left: 0">
					销售金额：
					<span style="font-size: 20px;color: red;margin:0 5px;" id="purchaseMoneyText">
						<c:if test="${empty(decoreOut.decoreSaleTotalPrce) }">
							0
						</c:if>
						<c:if test="${!empty(decoreOut.decoreSaleTotalPrce) }">
							${decoreOut.decoreSaleTotalPrce }
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
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td ><input type="text" name="decoreOut.carPlateNo" id="carPlateNo" value="${decoreOut.carPlateNo }" class="largeX text" title="车牌号"	checkType="string,7,7" canEmpty="Y" tip="车牌号可为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户姓名:&nbsp;</td>
				<td ><input type="text" name="decoreOut.customerName" id="customerName" value="${decoreOut.customerName }" class="largeX text" title="客户姓名"	checkType="string,1,7" canEmpty="Y" tip="客户姓名"></td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td ><input type="text" name="decoreOut.mobilePhone" id="mobilePhone" value="${decoreOut.mobilePhone }" class="largeX text" title="联系电话"	checkType="mobilePhone" canEmpty="Y" tip="联系电话可为空"></td>
			</tr>
			<tr>
				<td class="formTableTdLeft">销售人员:&nbsp;</td>
				<td colspan="3">
					<input type="text" name="decoreOut.saler" id="saler" value="${decoreOut.saler }"  placeholder="" class="largeX text" title="销售人员"	checkType="string,1" tip="销售人员不能为空">
					<span style="color: red;">*</span>
				</td>
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
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
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
function deleteTr(tr,decoreOutProductDbid) {
	var lent=$("#shopNumber").find("tr").size();
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		if(null!=decoreOutProductDbid&&decoreOutProductDbid!=''&&decoreOutProductDbid!=undefined){
			if(confirm("您确定要删除该商品吗？删除将修改该单据总价，商品库存量，并不可恢复。")){
				$.post("${ctx}/decoreOut/deletedecoreOutById?dbid="+decoreOutProductDbid+"&date="+new Date(),{},function(data){
					if(data=="error"){
						
					}else{
						var dd = $(tr).parent().parent();
						$(dd).remove();
						 $("#shopNumber").find("tr").each(function(i){
							 if(i>=1&&i<(lent-1)){
								$(this).find(':first').text('').text(i); 
						 	}
							 
						});
						//计算总金额、总数量
						decorePrice();
					}
				})
			}
		}else{
			var dd = $(tr).parent().parent();
			$(dd).remove();
			 $("#shopNumber").find("tr").each(function(i){
				 if(i>=1&&i<(lent-1)){
					$(this).find(':first').text('').text(i); 
			 	}
				 
			});
			//计算总金额、总数量
			decorePrice();
		}
		
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+'<td >'
				+'<input type="text" name="productItemNo" id="productItemNo'+size+'" onchange="autoProductItemByNo(\'productItemNo'+size+'\');autoProductKc(\'productItemNo'+size+'\')" class="media text" >'
				+'<input type="hidden" name="productItemDbid" id="productItemDbid'+size+'" >'
			+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text" readonly="readonly" name="productName" id="productName'+size+'" value=""  class="media text"/>'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="unit" id="unit'+size+'" class="small text"  >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="productType" id="productType'+size+'" class="small text" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly" name="price" id="price'+size+'" class="small text" onkeyup="decorePrice('+size+')" checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney'+size+'" class="small text"    checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="hidden" name="purchaseStorageDbid" id="purchaseStorageDbid'+size+'" class="small text"  >'
			+ '<input type="hidden" name="purchaseProductDbid" id="purchaseProductDbid'+size+'" class="small text"  >'
			+ '<input type="text" readonly="readonly"  name="purchasePrice" id="purchasePrice'+size+'" class="small text"   checkType="float,1" canEmpty="Y" tip="" >'
			+ '</td>'
			+ '<td >'
			+ '	<input type="text" name="note" id="note${i+1 }" class="mieda text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

function autoProductItemByNo(id){
		var id1 = "#"+id;
		var p=$(id1).val();
		if(p!=""&&p!=null){
			$.post('${ctx}/product/autoProductBySale?q='+p+"&dateTime="+new Date(),{},function (data){
				if(null!=data&&data!=undefined&&data!='1'){
					onRecordSelect(id,data,null);
					create($(id1));
					var sn=id.substring(13,id.length);
					sn=parseInt(sn);
					$("#productItemNo"+(sn+1)).focus();
				}
			})
		}
	//$(id1).result(onRecordSelect);
	//计算总金额
}
function onRecordSelect(event, data, formatted) {
	//var id=$(event.currentTarget).attr("id");
	var id=event;
	var sn=id.substring(13,id.length);
	//判断是否有重复的项目
	var productItemNos=$("#shopNumber input[name=productItemNo]");
	var status=false;
	for(var i=0;i<productItemNos.length;i++){
		var productItemNo=$(productItemNos[i]).val();
		if(id!=$(productItemNos[i]).attr("id")){
			if(data.productItemNo==productItemNo){
				status=true;
				break;
			}	
		}
	}
	if(status==true){
		alert("已经添加该商品，不能重复添加！");	
		return ;
	}
	$("#productItemNo"+sn).val(data.productItemNo);
	$("#productName"+sn).val(data.name);
	$("#productItemDbid"+sn).val(data.dbid);
	$("#productType"+sn).val(data.productType);
	if(null!=data.unit&&data.unit!=undefined){
		$("#unit"+sn).val(data.unit);
	}else{
		$("#unit"+sn).val(data.unit);
	}
	$("#price"+sn).val(data.price);
	$("#purchaseStorageDbid"+sn).val(data.purchaseStorageDbid);
	$("#purchaseProductDbid"+sn).val(data.purchaseProductDbid);
	$("#purchasePrice"+sn).val(data.purchasePrice);
	$("#totalMoney"+sn).val(data.price);
	$("#num"+sn).val(1);
	decorePrice();
}
function decorePrice(index){
	if(null!=index&&index!=undefined){
		var p=$("#price"+index).val();
		var num=$("#num"+index).val();
		var to=p*num;
		$("#totalMoney"+index).val(to);
	}
	var prices=$("input[name=totalMoney]");
	var totalA=0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		if(price==""||price==null){
			price=0;
		}else{
			price=parseInt(price);
		}
		totalA=totalA+price;
	}
	$("#purchaseMoney").val(totalA);
	
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
</script>
</html>