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
.smallX {
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #555;
    display: block;
    font-size: 14px;
    height: 34px;
    line-height: 1.42857;
    padding: 6px 12px;
    transition: border-color 0.15s ease-in-out 0s, box-shadow 0.15s ease-in-out 0s;
    width: 100%;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">订单-装饰明细</span>
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
<div style="margin: 0 auto;width: 98%;margin-top: 20px;">
	<div class="form-group">
		<label class="control-label" for="name">合同备注：</label>
		<div style="width: 100%" class="alert alert-danger">${orderContract.note }</div>
	</div>
	<form  method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" id="editType" name="editType" value="${param.editType}">
		<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
		<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid }">
		<input type="hidden" id="smtType" name="smtType" value="1">
		<input type="hidden" value="${orderContractDecore.dbid }" id="orderContractDecoreDbid" name="orderContractDecore.dbid">
		<input type="hidden" value="${orderContractExpense.dbid }" id="orderContractExpenseId" name="orderContractExpenseId">
		<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
			<thead>
				<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<th style="width: 30px;text-align: center;">序号</th>
					<th style="width: 200px;text-align: center;">项目名称</th>
					<th style="width: 80px;text-align: center;">类型</th>
					<th style="width: 120px;text-align: center;">编号</th>
					<th style="width: 80px;text-align: center;display: none;">品牌</th>
					<th style="width: 60px;text-align: center;display: none;">销售价格</th>
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
							<td style="text-align: center;display: none;">
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
							<td style="text-align: center;display: none;">
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
							<td style="text-align: center;display: none;">
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
				<div class="form-group">
					<label class="control-label" for="name">装饰款：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.acturePrice" id="acturePrice" value="${orderContractExpense.decoreMoney}"  />
				</div>
				<div class="form-group">
					<label class="control-label" for="name">销售装饰合计：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.decoreSaleTotalPrce" id="decoreSaleTotalPrce" value="${orderContractDecore.decoreSaleTotalPrce }"  />
				</div>
				<div class="form-group">
					<label class="control-label" for="name">赠送装饰合计：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.giveTotalPrice" id="giveTotalPrice" value="${orderContractDecore.giveTotalPrice }" />
				</div>
				<div class="form-group">
					<label class="control-label" for="name">折扣率：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.zkl" id="zkl" value="${orderContractDecore.zkl }" />
				</div>
				<div class="form-group">
					<label class="control-label" for="name">销售顾问结算：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.salerTotalPrice" id="salerTotalPrice" value="${orderContractDecore.salerTotalPrice}"  />
				</div>
				<div class="form-group">
					<label class="control-label" for="name">结算利润：</label>
						<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.salerGrofitPrice" id="salerGrofitPrice" value="${orderContractDecore.salerGrofitPrice}"/>
				</div>
				<div style="display: none;">
					<div class="form-group">
						<label class="control-label" for="name">装饰成本：</label>
							<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.costPrice" id="costPrice" value="${orderContractDecore.costPrice }"  />
					</div>
					<div class="form-group">
						<label class="control-label" for="name">装饰利润：</label>
							<input readonly="readonly" type="text" class="form-control" name="orderContractDecore.costGrofitPrice" id="costGrofitPrice" value="${orderContractDecore.costGrofitPrice }" />
					</div>
				</div>
		</form>
		<div class="formButton">
			<input type="button" name="mobileCommit" class="addbutton" value="保存草稿" onclick="if(valida()){smtFrm(1)}" >
			<input type="button" name="mobileCommit" class="addbutton" value="保存并提交审批"  onclick="if(valida()){smtFrm(2)}">
		</div>
</div>
<br>
<br>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
function smtFrm(value){
	$("#smtType").val(value);
	if(value==1){
		submitFrm('frmId','${ctx}/qywxOrderContractDecore/saveOrderContractDecore');
	}
	if(value==2){
	    var sts=confirm("请确认定单、附件通知单信息无误，点击【确定】提交数据！数据一旦提交审核后将不可更改！");
	    if(sts=true){
	    	submitFrm('frmId','${ctx}/qywxOrderContractDecore/saveOrderContractDecore');
	    }else{
	    	return false;
	    }
	}
}
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
		alert("必须至少保留一个规格值", 1);
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
			+ '<td  style="text-align: center;display: none;">'
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;序号： "+row.sn+"&nbsp;&nbsp;价格："+row.price+"&nbsp;&nbsp;&nbsp;&nbsp; </span>";   
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
	$("#zkl").val(formatFloat(src)+"%");
	
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
</body>
</html>
