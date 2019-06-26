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
.ac_results{
	width: 460px;
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
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 40px;text-align: center;">序号</th>
						<th style="width: 120px;text-align: center;">品名规格</th>
						<th style="width: 40px;text-align: center;">数量</th>
						<th style="width: 80px;text-align: center;">进货单</th>
						<th style="width: 60px;text-align: center;">单位</th>
						<th style="width: 60px;text-align: center;">货品类型</th>
						<th style="width: 60px;text-align: center;">销售单价</th>
						<th style="width: 60px;text-align: center;">顾问结算</th>
						<th style="width: 60px;text-align: center;">进货价</th>
						<th style="width: 140px;text-align: center;">备注</th>
						<th style="width: 40px;text-align: center;">操作</th>
				</tr>
				<!-- 添加时展示页面 -->
					<c:if test="${empty(decoreOut) }">
						<c:forEach var="i" begin="0" step="1" end="7">
							<tr id="tr${i+1 }" onclick="">
								<td style="text-align: center;">
									${i+1 }
								</td>
								<td >
									<input type="text" name="productName" id="productName${i+1 }" onfocus="autoProductItemByNo('productName${i+1 }');create(this)"  onclick="ajaxPurchaseProduct('purchaseProductDbid${i+1}')" class="media text" >
									<input type="hidden" name="productDbid" id="productDbid${i+1}" >
									<input type="hidden" name="purchaseProductDbid" id="purchaseProductDbid${i+1}" >
								</td>
								<td>
									<input  type="text" name="num" id="num${i+1 }"  class="small text" onfocus="decorePrice(${i+1 })" onchange="decorePrice(${i+1 })">
									<input  type="hidden" name="overNum" id="overNum${i+1 }"  class="small text" >
								</td>
								<td>
									<input readonly="readonly" type="text" name="purchaseProductNo" id="purchaseProductNo${i+1 }"  class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="unit" id="unit${i+1 }" class="small text"  >
								</td>
								<td style="text-align: center;">
									<input type="text"  readonly="readonly" name="productType" id="productType${i+1 }" class="small text" >
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly" name="price" id="price${i+1 }" class="small text"   onkeyup="decorePrice(${i+1 })" checkType="float,0" canEmpty="Y" tip="请输入商品单价，必须为数字" >
								</td>
								<td style="text-align: center;">
									<input type="hidden" readonly="readonly"  name="totalMoney" id="totalMoney${i+1 }" class="small text"   checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >
									<input type="text" readonly="readonly" name="salerPrice" id="salerPrice${i+1 }" class="small text" class="small text"   checkType="float,1" canEmpty="Y" tip="请输入项目价值，必须为数字">
								</td>
								<td style="text-align: center;">
									<input type="text" readonly="readonly"  name="purchasePrice" id="purchasePrice${i+1 }" class="small text"   checkType="float,0" canEmpty="Y" tip="" >
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
			</table>
		</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td id="stockTip" width="50%" colspan="5" style="text-align: left;padding-right: 12px;border-right: 0;font-size: 14px;font-weight: normal;">
					
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
				<td colspan="3"><input type="text" name="decoreOut.carPlateNo" id="carPlateNo" value="${decoreOut.carPlateNo }" class="largeX text" title="车牌号"	checkType="string,6,7" canEmpty="Y" tip="车牌号可为空"></td>
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
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/saleDecoreOut/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
				+'<input type="text" name="productName" id="productName'+size+'" onchange="autoProductItemByNo(\'productName'+size+'\');create(this)" onclick="ajaxPurchaseProduct(\'purchaseProductDbid'+size+'\')" class="media text" >'
				+'<input type="hidden" name="productDbid" id="productDbid'+size+'" >'
				+'<input type="hidden" name="purchaseProductDbid" id="purchaseProductDbid'+size+'" >'
			+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text" name="num" id="num'+size+'" value=""  class="small text" onfocus="decorePrice('+size+')" onchange="decorePrice('+size+')"/>'
			+ '<input type="hidden"  name="overNum" id="overNum'+size+'" value=""  class="media text"/>'
			+ '</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text" readonly="readonly" name="purchaseProductNo" id="purchaseProductNo'+size+'" value=""  class="small text"/>'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="unit" id="unit'+size+'" class="small text"  >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  readonly="readonly" name="productType" id="productType'+size+'" class="small text" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" readonly="readonly" name="price" id="price'+size+'" class="small text" onkeyup="decorePrice('+size+')" checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="hidden" readonly="readonly"  name="totalMoney" id="totalMoney'+size+'" class="small text"    checkType="float,0" canEmpty="Y" tip="请输入项目价值，必须为数字" >'
				+' <input type="text" readonly="readonly" name="salerPrice" id="salerPrice'+size+'" class="small text"checkType="float,0" canEmpty="Y"  >'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" readonly="readonly"  name="purchasePrice" id="purchasePrice'+size+'" class="small text"   checkType="float,0" canEmpty="Y" tip="" >'
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
		$(id1).autocomplete("${ctx}/product/autoProductBySale",{
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
		       return "<span>商品名称："+row.name+"&nbsp;&nbsp;&nbsp;进货批号："+row.sn+"&nbsp;&nbsp;剩余数量："+row.overNum+"</span>";   
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
	//判断是否有重复的项目
	var purchaseProductDbids=$("#shopNumber input[name=purchaseProductDbid]");
	var status=false;
	//当前商品批号所在INputID
	var purchaseProductDbid="purchaseProductDbid"+sn;
	for(var i=0;i<purchaseProductDbids.length;i++){
		//所取目标商品批号数据
		var dbid=$(purchaseProductDbids[i]).val();
		//所取目标商品所在inputId
		var purchaseProductDbidls=$(purchaseProductDbids[i]).attr("id");
		
		if(null!=purchaseProductDbidls&&purchaseProductDbidls!=''){
			if(purchaseProductDbid!=purchaseProductDbidls){
				if(null!=dbid&&dbid!=''&&dbid!=undefined){
					if(data.dbid!=undefined&&data.dbid!=null){
						if(data.dbid==dbid){
							status=true;
							break;
						}	
					}
				}
			}
		}
	}
	if(status==true){
		alert("已经添加该商品，不能重复添加！");	
		return ;
	}
	$("#purchaseProductDbid"+sn).val(data.dbid);
	$("#productName"+sn).val(data.name);
	$("#purchaseProductNo"+sn).val(data.purchaseProductNo);
	$("#productDbid"+sn).val(data.productId);
	$("#productType"+sn).val(data.productType);
	if(null!=data.unit&&data.unit!=undefined){
		$("#unit"+sn).val(data.unit);
	}else{
		$("#unit"+sn).val(data.unit);
	}
	$("#price"+sn).val(data.price);
	$("#salerPrice"+sn).val(data.salerPrice);
	$("#purchasePrice"+sn).val(data.purchasePrice);
	$("#totalMoney"+sn).val(data.price);
	$("#overNum"+sn).val(data.overNum);
	$("#num"+sn).val(1);
	decorePrice();
	ajaxPurchaseProduct("purchaseProductDbid"+sn)
}
function decorePrice(index){
	if(null!=index&&index!=undefined){
		var p=$("#price"+index).val();
		var overNum=$("#overNum"+index).val();
		var num=$("#num"+index).val();
		overNum=parseInt(overNum);
		num=parseInt(num);
		if(num>overNum){
			alert("该批次商品剩余数量为【"+overNum+"】,销售数量大于剩余数量。请确认");
			$("#num"+index).val(overNum);
			num=overNum;
		}
		var to=p*num;
		$("#totalMoney"+index).val(to);
	}
	
	var prices=$("input[name=totalMoney]");
	var purchasePrices=$("input[name=purchasePrice]");
	var salerPrices=$("input[name=salerPrice]");
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
		
		var purchasePrice=$(purchasePrices[i]).val();
		if(purchasePrice==""||purchasePrice==null){
			purchasePrice=0;
		}else{
			purchasePrice=parseInt(purchasePrice);
		}
		costTotalPrice=costTotalPrice+purchasePrice;
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
		$("#userId").val(data.dbid);
}

function ajaxPurchaseProduct(purchaseProductId){
	var purchaseProductId=$("#"+purchaseProductId).val();
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

</script>
</html>