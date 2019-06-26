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
</style>
<title>入库单添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/purchaseStorage/queryList'">入库单</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(purchaseStorage) }">添加入库单</c:if>
	<c:if test="${!empty(purchaseStorage) }">编辑入库单</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 30px;text-align: center;">序号</th>
						<th style="width: 120px;text-align: center;">品名规格</th>
						<th style="width: 60px;text-align: center;">单位</th>
						<th style="width: 60px;text-align: center;">货品类型</th>
						<th style="width: 60px;text-align: center;">数量</th>
						<th style="width: 60px;text-align: center;">单价</th>
						<th style="width: 60px;text-align: center;">金额</th>
						<th style="width: 200px;text-align: center;">备注</th>
						<th style="width: 40px;text-align: center;">操作</th>
				</tr>
				<!-- 添加时展示页面 -->
					<c:if test="${empty(purchaseStorage) }">
						<c:forEach var="i" begin="0" step="1" end="7">
							<tr id="tr${i+1 }">
								<td style="text-align: center;">
									${i+1 }
								</td>
								<td >
									<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)"  class="media text" >
									<input type="hidden" name="productDbid" id="productDbid${i+1}" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i+1 }" class="small text"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i+1 }" class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="num" id="num${i+1 }" class="small text"   onkeyup="decorePrice(${i+1 })" checkType="float,1" canEmpty="Y" tip="请输入进货数量，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i+1 }" class="small text"   onkeyup="decorePrice(${i+1 })" checkType="float,0" canEmpty="Y" tip="请输入商品单据，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" class="small text"   checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
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
					<c:if test="${!empty(purchaseStorage) }">
						<c:set value="${fn:length(purchaseProducts)}" var="itemLength"></c:set>
						<c:forEach var="purchaseProduct" items="${purchaseProducts }" varStatus="i">
							<tr id="tr${i.index+1 }">
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td >
									<input type="text" readonly="readonly" name="productName" id="productName${i.index+1 }" value="${purchaseProduct.product.name }" onFocus="autoProductByName('productName${i.index+1 }');create(this)"  class="media text" >
									<input type="hidden" name="productDbid" id="productDbid${i.index+1}" value="${purchaseProduct.product.dbid }" >
									<input type="hidden" name="purchaseProductDbid" id="purchaseProductDbid${i.index+1}" value="${purchaseProduct.dbid }" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i.index+1 }" class="small text" value="${purchaseProduct.product.unit }" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i.index+1 }" class="small text" value="${purchaseProduct.product.productcategory.name }">
								</td>
								<td style="text-align: center;">
									<input type="text"  name="num" id="num${i.index+1 }" class="small text"  value="${purchaseProduct.num}" onkeyup="decorePrice(${i.index+1 })" checkType="float,1" canEmpty="Y" tip="请输入进货数量，必须为数字" >
									<input type="hidden"  name="oldNum" id="oldNum${i.index+1 }" class="small text"  value="${purchaseProduct.num}" onkeyup="decorePrice(${i.index+1 })" checkType="float,1" canEmpty="Y" tip="请输入进货数量，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i.index+1 }" class="small text" value="${purchaseProduct.price}"  onkeyup="decorePrice(${i.index+1 })" checkType="float,0" canEmpty="Y" tip="请输入商品单据，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i.index+1 }" value="${purchaseProduct.totalMoney}" class="small text"   checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td>
									<input type="text" name="note" id="note${i.index+1 }" class="largeXX text" value="${purchaseProduct.note}"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<%-- <a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this,${purchaseProduct.dbid })" >
										<i class="icon-remove icon-black" > </i>
									</a> --%>
								</td>
							</tr>
						</c:forEach>
						<c:forEach var="i" begin="${itemLength }" step="1" end="7">
							<tr id="tr${i+1 }">
								<td style="text-align: center;">
									${i+1 }
								</td>
								<td >
									<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)"  class="media text" >
									<input type="hidden" name="productDbid" id="productDbid${i+1}" onblur="create(this)"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i+1 }" class="small text"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i+1 }" class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="num" id="num${i+1 }" class="small text"   onkeyup="decorePrice(${i+1 })" checkType="float,1" canEmpty="Y" tip="请输入进货数量，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text"  name="price" id="price${i+1 }" class="small text"   onkeyup="decorePrice(${i+1 })" checkType="float,0" canEmpty="Y" tip="请输入商品单据，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" class="small text"    checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >
								</td>
								<td>
									<input type="text" name="note" id="note${i+1 }" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >
								</td>
								<td style="text-align: center;padding-top: 8px;">
									<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
										<i class="icon-remove icon-black" > </i>
									</a>
								</td>
							</tr>
					</c:forEach>
					</c:if>
			</table>
		</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="9" style="text-align: right;padding-right: 12px;">
						应付款：
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
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px">
			<tr height="42">
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td >
					<input type="hidden" id="purchaseMoney" name=purchaseStorage.purchaseMoney value="${purchaseStorage.purchaseMoney }">
					<input type="hidden" id="dbid" name=purchaseStorage.dbid value="${purchaseStorage.dbid }">
					<input type="hidden" id="sn" name=purchaseStorage.sn value="${purchaseStorage.sn }">
					<input type="hidden" id="createDate" name=purchaseStorage.createDate value="${purchaseStorage.createDate }">
					<c:if test="${empty(purchaseStorage) }">
						<label><input type="radio" name="purchaseStorage.purchaseType" id="purchaseType1" value="1" checked="checked">采购进货</label>
						<label><input type="radio" name="purchaseStorage.purchaseType" id="purchaseType2" value="2">采购退货</label>
					</c:if>
					<c:if test="${!empty(purchaseStorage) }">
						<c:if test="${purchaseStorage.purchaseType==1}">
							<label><input type="radio" name="purchaseStorage.purchaseType" id="purchaseType1" value="1" ${purchaseStorage.purchaseType==1?'checked="checked"':'' } >采购进货</label>
						</c:if>
						<c:if test="${purchaseStorage.purchaseType==2}">
							<label><input type="radio" name="purchaseStorage.purchaseType" id="purchaseType2" value="2" ${purchaseStorage.purchaseType==2?'checked="checked"':'' } >采购退货</label>
						</c:if>
					</c:if>
				</td>
				<td class="formTableTdLeft">日期:&nbsp;</td>
				<td ><input type="text" name="purchaseStorage.kpDate" id="kpDate" value="${purchaseStorage.kpDate }" onfocus="new WdatePicker();" class="largeX text" title="日期"	checkType="string,1,50" tip="日期不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">折扣率:&nbsp;</td>
				<td ><input type="text" name="purchaseStorage.dis" id="dis" onkeyup="disMoneyDis(this.value)" value="${purchaseStorage.dis }" class="largeX text" title="折扣率" placeholder="100"	checkType="float,1" tip="折扣率不能为空">%<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">折扣后金额:&nbsp;</td>
				<td ><input type="text" name="purchaseStorage.disMoney" id="disMoney" value="${purchaseStorage.disMoney }" class="largeX text" title="折扣后金额" checkType="float,0" tip="折扣后金额不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				
				<td class="formTableTdLeft">供货商:&nbsp;</td>
				<td colspan="">
					<select id="supplierId" name="supplierId" class="largeX text"  checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="supplier" items="${suppliers }">
							<option value="${supplier.dbid }" ${purchaseStorage.supplier.dbid==supplier.dbid?'selected="selected"':'' } >${supplier.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">本次付款金额:&nbsp;</td>
				<td colspan="">
					<input type="text" name="purchaseStorage.payMoney" id="payMoney" value="${purchaseStorage.payMoney }"  placeholder="0.0" class="largeX text" title="本次付款金额"	checkType="float,0" tip="本次付款金额">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea name="purchaseStorage.note" id="note" title="内容简介"  class="largeXX text" style="height: 40px;width: 720px;">${purchaseStorage.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/purchaseStorage/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
function deleteTr(tr,purchaseProductDbid) {
	var lent=$("#shopNumber").find("tr").size();
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		if(null!=purchaseProductDbid&&purchaseProductDbid!=''&&purchaseProductDbid!=undefined){
			if(confirm("您确定要删除该商品吗？删除将修改该单据总价，商品库存量，并不可恢复。")){
				$.post("${ctx}/purchaseStorage/deletePurchaseStorageById?dbid="+purchaseProductDbid+"&date="+new Date(),{},function(data){
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
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="productName" id="productName'+size+'" value="" onFocus=\'autoProductByName("productName'+size+'");create(this)\' class="media text"/>'
			+ '<input type="hidden" name="productDbid" id="productDbid'+size+'" value="">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="unit" id="unit'+size+'" class="small text"  >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="productType" id="productType'+size+'" class="small text" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  name="num" id="num'+size+'" class="small text"   onkeyup="decorePrice('+size+')" checkType="float,1" canEmpty="Y" tip="请输入进货数量，必须为数字" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text"  name="price" id="price'+size+'" class="small text" onkeyup="decorePrice('+size+')" checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text" readonly="readonly"  name="totalMoney" id="totalMoney'+size+'" class="small text"    checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			+ '<td >'
			+ '	<input type="text" name="note" id="note${i+1 }" class="largeXX text"  checkType="string,1" canEmpty="Y" tip="请输入项目备注信息" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

function autoProductByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/product/autoProductByName",{
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
	$("#productType"+sn).val(data.productType);
	if(null!=data.unit&&data.unit!=undefined){
		$("#unit"+sn).val(data.unit);
	}else{
		$("#unit"+sn).val(data.unit);
	}
	$("#price"+sn).val(data.costPrice);
	$("#totalMoney"+sn).val(data.costPrice);
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
	
	var dis=$("#dis").val();
	if(null!=dis&&dis!=''){
		$("#disMoney").val(totalA*dis/100);
	}else{
		$("#disMoney").val(totalA);
	}
}
function disMoneyDis(dis){
	var purchaseMoney= $("#purchaseMoney").val();
	if(null!=purchaseMoney&&purchaseMoney!=''&&purchaseMoney!=undefined){
		if(null!=dis&&dis!=''){
			$("#disMoney").val(purchaseMoney*dis/100);
		}else{
			$("#disMoney").val(purchaseMoney);
		}
	}else{
		$("#disMoney").val(0);
	}
}
</script>
</html>