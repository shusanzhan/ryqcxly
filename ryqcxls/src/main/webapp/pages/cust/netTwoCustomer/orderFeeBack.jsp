<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加装饰项目</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/select2.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap/unicorn.grey.css"	class="skin-color" />
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
body{
  background-color: #f1f1f1;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #F9F9F9;
    border: 1px solid #ccc;
    box-shadow: 0 0px 0px rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 10px;
}
.table th, .table td {
    border-top: 0;
    border-bottom: 1px solid #ddd;
    line-height: 20px;
    padding: 2px 5px;
    text-align: left;
    vertical-align: top;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 24px;
    line-height: 20px;
    margin-bottom: 0;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    box-shadow: 0 0 0 rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 0;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 0;
    padding:2px 0 2px 2px;
    vertical-align: middle;
}
.select{
	 height: 28px;
    line-height: 28px;
    margin-bottom: 0;
    padding:2px 0 2px 2px;
    display: block;
}
.program{
	width: 145px;
	background-image: url('${ctx}/images/program.png');
	background-repeat:no-repeat;
	height:14px;
	float:left;
	padding-top:18px;
	text-align: center;
	
}
.programActive{
	width: 147px;
	background-image: url('${ctx}/images/programActive.png');
	background-repeat:no-repeat;
	height:14px;
	float:left;
	padding-top:18px;
	text-align: center;
}
input[disabled], select[disabled], textarea[disabled], input[readonly], select[readonly], textarea[readonly] {
    background-color: #EEEEEE;
    cursor: not-allowed;
 }
.frmTitle{
	border-bottom: 1px solid #FF9F29;
	width: 100%;
	font-size: 16px;
	font-weight: bold;
	padding-bottom: 5px;
	margin-bottom: 12px;
	color: #FF9F29;
	margin-top: 12px;
	cursor: pointer;
}
.text{
height: 30px;
border: 1px solid #e3e3ee;
background-color: #FFF;
color: #555555;
display: inline-block;
font-size: 14px;
line-height: 30px;
padding-left: 5px
}
</style>
<script type="text/javascript">
</script>
</head>
<body>
<form action="" id="frmId" name="frmId" method="post">
<div class="container-fluid" style="margin-top: 0;padding-left: 0;">
	<div class="row-fluid" style="margin-top: 0;">
				<div class="span6">
					<div class="frmTitle" onclick="showOrHiden('contactTable')">优惠明细</div>
					<div class="widget-box">
						<div id='preferenceItemDiv' class="widget-content nopadding" style="height: 200px;overflow: scroll;padding-bottom: 20px;">
							<table id="preferenceItem" class="table table-bordered" >
								<thead>
									<tr>
										<th style="width: 30px;text-align: center;">序号</th>
										<th style="width: 80px;text-align: center;">优惠项目</th>
										<th style="width: 50px;text-align: center;">优惠金额</th>
										<th style="width: 160px;text-align: center;">备注</th>
										<th style="width: 40px;text-align: center;">操作</th>
									</tr>
								</thead>
								<tbody style="overflow: scroll;">
								<!-- 添加时展示页面 -->
									<c:forEach var="orderContractExpensesPreferenceItem" items="${orderContractExpensesPreferenceItems }" varStatus="inde">
										<tr id="tr${inde.index+1 }">
												<td style="text-align: center;">
													${inde.index+1 }
												</td>
												<td >
													<input type="text" name="preferenceItemName" id="preferenceItemName${inde.index+1 }" value="${orderContractExpensesPreferenceItem.preferenceItemName }" onFocus="autoPreferenceItemByName('preferenceItemName${inde.index+1 }');createPreferenceItem(this)" tip="输入优惠项目拼音码"  style="width: 100%;">
													<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid${inde.index+1}" value="${orderContractExpensesPreferenceItem.preferenceItemId }"  style="width: 100%;">
												</td>
												<td>
													<input type="text" name="preferencePrice" id="preferencePrice${inde.index+1 }" value="${orderContractExpensesPreferenceItem.price }" style="width: 92%;" onfocus="preferenceItemPrice()" onchange="preferenceItemPrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
												</td>
												<td style="text-align: center;">
													<input type="text"   name="preferenceNote" id="preferenceNote${inde.index+1 }" value="${orderContractExpensesPreferenceItem.note }" style="width: 92%;" >
												</td>
												
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
									</c:forEach>
									<c:if test="${fn:length(orderContractExpensesPreferenceItems)<4 }">
										<c:forEach var="i" begin="${fn:length(orderContractExpensesPreferenceItems) }" step="1" end="3">
											<tr id="tr${i+1 }">
												<td style="text-align: center;">
													${i+1 }
												</td>
												<td >
													<input type="text" name="preferenceItemName" id="preferenceItemName${i+1 }" onFocus="autoPreferenceItemByName('preferenceItemName${i+1 }');createPreferenceItem(this)" tip="输入优惠项目拼音码"  style="width: 100%;">
													<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid${i+1}"  style="width: 100%;">
												</td>
												<td>
													<input type="text" name="preferencePrice" id="preferencePrice${i+1 }" style="width: 92%;" onfocus="preferenceItemPrice()" onchange="preferenceItemPrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
												</td>
												<td style="text-align: center;">
													<input type="text"   name="preferenceNote" id="preferenceNote${i+1 }" style="width: 92%;" >
												</td>
												
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="span6">
					<div class="frmTitle" onclick="showOrHiden('contactTable')">附加收费明细</div>
					<div class="widget-box">
						<div id='chargeItemDiv' class="widget-content nopadding" style="height: 200px;overflow: scroll;padding-bottom: 20px;">
							<table id="chargeItem" class="table table-bordered" >
								<thead>
									<tr>
										<th style="width: 30px;text-align: center;">序号</th>
										<th style="width: 80px;text-align: center;">附加收费项目</th>
										<th style="width: 50px;text-align: center;">附加收费金额</th>
										<th style="width: 160px;text-align: center;">备注</th>
										<th style="width: 40px;text-align: center;">操作</th>
									</tr>
								</thead>
								<tbody style="overflow: scroll;">
								<!-- 添加时展示页面 -->
									<c:forEach var="orderContractExpensesChargeItem" items="${orderContractExpensesChargeItems }" varStatus="inde">
										<tr id="tr${inde.index+1 }">
												<td style="text-align: center;">
													${inde.index+1 }
												</td>
												<td >
													<input type="text"  name="chargeItemName" id="chargeItemName${inde.index+1 }" value="${orderContractExpensesChargeItem.chargeItemName }" onFocus="autoCharegeItemByName('chargeItemName${inde.index+1 }');createChargItem(this)"  style="width: 100%;">
													<input type="hidden" name="chargeItemDbid" id="chargeItemDbid${inde.index+1}" value="${orderContractExpensesChargeItem.chargeItemId }" onblur="create(this)" style="width: 100%;">
												</td>
												<td>
													<input type="text" name="chargeItemPrice" id="chargeItemPrice${inde.index+1 }" value="${orderContractExpensesChargeItem.price }" style="width: 92%;" onfocus="chargePrice()" onchange="chargePrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
												</td>
												<td style="text-align: center;">
													<input type="text"  name="chargeItemNote" id="chargeItemNote${inde.index+1 }" value="${orderContractExpensesChargeItem.note }" style="width: 92%;" >
												</td>
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
									</c:forEach>
									<c:if test="${fn:length(orderContractExpensesChargeItems)<4 }">
										<c:forEach var="i" begin="${fn:length(orderContractExpensesChargeItems) }" step="1" end="3">
											<tr id="tr${i+1 }">
												<td style="text-align: center;">
													${i+1 }
												</td>
												<td >
													<input type="text"  name="chargeItemName" id="chargeItemName${i+1 }" onFocus="autoCharegeItemByName('chargeItemName${i+1 }');createChargItem(this)"  style="width: 100%;">
													<input type="hidden" name="chargeItemDbid" id="chargeItemDbid${i+1}" onblur="create(this)" style="width: 100%;">
												</td>
												<td>
													<input type="text" name="chargeItemPrice" id="chargeItemPrice${i+1 }" style="width: 92%;" onfocus="chargePrice()" onchange="chargePrice()" checkType="float" canEmpty="Y" tip="请输入商品数量，必须为数字">
												</td>
												<td style="text-align: center;">
													<input type="text"  name="chargeItemNote" id="chargeItemNote${i+1 }" style="width: 92%;" >
												</td>
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">购车费用明细</div>
<input type="hidden" id="orderContractId" name="orderContract.dbid" value="${orderContract.dbid }">
 <input type="hidden" id="editType" name="editType" value="${param.editType}">
 <input type="hidden" name="customerId" id="customerId" value="${customer.dbid }" class="mideaX text"></input>
<input type="hidden" name="orderContractExpenses.decoreMoney" id="decoreMoney" value="${orderContractExpenses.decoreMoney }" class="mideaX text"></input>
<input type="hidden" name="orderContractExpenses.dbid" id="dbid" value="${orderContractExpenses.dbid }" class="mideaX text"></input>
<table border="0" align="center" cellpadding="0" cellspacing="0" width="92%">
		<tr height="42" >
			<td class="formTableTdLeft" >购车定金：&nbsp;</td>
				<td >
				<input type="text" name="orderContractExpenses.orderMoney" id="orderMoney" onfocus="target32(this.value)" onchange="target32(this.value)" value="${orderContractExpenses.orderMoney }" class="mideaX text" style="color: red;"></input>
				<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">大写：&nbsp;</td>
				<td >
				<input type="text" readonly="readonly" name="orderContractExpenses.bigOrderMoney"  id="bigOrderMoney" value="${orderContractExpenses.bigOrderMoney }" class="mideaX text" ></input>
				<span style="color: red">*</span>
			</td>
			
		</tr>
		<tr height="42">
			<td class="formTableTdLeft">经销商报价：&nbsp;</td>
			<td colspan="">
				
				<input type="text" readonly="readonly" value="${orderContractExpenses.salePrice }" onchange="countActMoney()" id="salePrice" name="orderContractExpenses.salePrice" class="mideaX text" ></input>
				<span style="color: red">*</span>
			</td>
			<td class="formTableTdLeft">车款优惠：</td>
			<td id="carColorId">
				<input type="text" readonly="readonly"    id="preferentialTogether" name="orderContractExpenses.preferentialTogether" value="${orderContractExpenses.preferentialTogether }" class="mideaX text enable" ></input>
				<span style="color: red">*说明：优惠明细合计</span>
			</td>
		</tr> 
	 <tr height="42">
	 	<td class="formTableTdLeft">合同总金额：&nbsp;</td>
		<td >
				<input type="text" readonly="readonly" name="orderContractExpenses.totalPrice" id="totalPrice" value="${orderContractExpenses.totalPrice}" class="mideaX text" style="color: red;"></input>
				<span style="color: red">*</span>
		</td>
		<td class="formTableTdLeft">附加总金额：&nbsp;</td>
		<td >
			<input type="text" readonly="readonly"  id="fjzje" name="orderContractExpenses.fjzje"class="mideaX text"  value="${orderContractExpenses.fjzje }"></input>
			<span style="color: red">*说明：附加明细合计</span>
		</td>
	</tr>
		<tr height="42">
			<td class="formTableTdLeft">购车方式：&nbsp;</td>
			<td >
				<label style="float: left;"><input type="radio" value="1" name="orderContractExpenses.buyCarType" id="buyCarType"   ${orderContractExpenses.buyCarType==1?'checked="checked"':'' } onclick="showOrHideBuyCarWay(this.value)">现款	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
			
				<label style="float: left;"><input type="radio" value="2" name="orderContractExpenses.buyCarType" id="buyCarType" ${orderContractExpenses.buyCarType==2?'checked="checked"':'' } onclick="showOrHideBuyCarWay(this.value)">分付</label>
				<span style="color: red">*</span>
				<label style="clear: both;"></label>
			</td>
			<td class="formTableTdLeft">付款方式：&nbsp;</td>
			<td >
				<label style="float: left;"><input type="radio" value="1" name="orderContractExpenses.payWay" id="payWay"   ${orderContractExpenses.payWay==1?'checked="checked"':'' }>现金&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<label style="float: left;"><input type="radio" value="2" name="orderContractExpenses.payWay" id="payWay"   ${orderContractExpenses.payWay==2?'checked="checked"':'' }>转账</label>
				<span style="color: red">*</span>
				<label style="clear: both;"></label>
			</td>
		</tr>
		<tr height="42" id="dakkuanTr" style="display: none;">
			<td class="formTableTdLeft">首付款：&nbsp;</td>
			<td >
				<input type="text"   id="sfk" name="orderContractExpenses.sfk" class="mideaX text" value="0.00"></input>
			</td>
			<td class="formTableTdLeft">贷款：&nbsp;</td>
			<td >
				<input type="text"  id="daikuan" name="orderContractExpenses.daikuan" class="mideaX text"  value="0.00"></input>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="left" style="padding-right: 12px;padding-top: 12px;">
				<a id="submit" class="btn btn-primary" href="javascript:void(-1)" onclick="if(validateFrmBeforeSmb()){$.utile.submitAjaxForm('frmId','${ctx}/netTwoCustomer/saveOrderContract')}">
				<i	class="icon-ok-sign icon-white"></i>保存并填写装饰项目</a>
				<a class="btn btn-inverse" onclick="window.history.go(-1)"><i class="icon-arrow-left icon-white"></i> 上一步</a>
			</td>
		</tr>
</table>
</form>	
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

////////////////////////////////优惠项目js模板////////////////////////////////////
//自动添加优惠项目
function autoPreferenceItemByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/preferenceItem/autoPreferenceItem",{
			extraParams:{customerType:"${customer.customerType}"},
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;默认金额："+row.defaultPrice+"&nbsp;&nbsp; </span>";   
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
//绑定数据
function onRecordSelect(event, data, formatted) {
	var id=$(event.currentTarget).attr("id");
	var sn=id.substring(18,id.length);
	//判断是否有重复的项目
	var names=$("#preferenceItem input[name=preferenceItemName]");
	var status=false;
	for(var i=0;i<names.length;i++){
		var name=$(names[i]).val();
		if(id!=$(names[i]).attr("id")){
			if(data.name==name){
				status=true;
				break;
			}	
		}
	}
	if(status==false){
		$("#preferenceItemName"+sn).val(data.name);
		$("#preferenceItemDbid"+sn).val(data.dbid);
		$("#preferencePrice"+sn).val(data.defaultPrice);
		preferenceItemPrice();
	}else{
		alert("已经添加该项目，不能重复添加！");
	}
}
//计算优惠金额
function preferenceItemPrice(){
	var prices=$("#preferenceItem input[name=preferencePrice]");
	var totalA=0.0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		if(null!=price&&price!=''){
			price=parseInt(price);
			if(!isNaN(price)){
				totalA=totalA+price;
			}else{
				totalA=totalA+0;
			}
		}
	}
	$("#preferentialTogether").val(formatFloat(totalA));
	orderContranctTotalPrice();
}
//删除表格行
function deletePreferenceTr(tr) {
	// 删除规格值
	if ($("#preferenceItem").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#preferenceItem").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		preferenceItemPrice();
	}
}
//商品表格编辑部分
function createPreferenceItem(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#preferenceItem tr").last().attr("id")){
		createPreferenceItemTr();
		$("#preferenceItemDiv").scrollTop($("#preferenceItem")[0].scrollHeight);
	}
}
//添加表格行
function createPreferenceItemTr() {
	var size = $("#preferenceItem").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="preferenceItemName" id="preferenceItemName'+size+'" value="" style="width: 100%;" onFocus=\'autoPreferenceItemByName("preferenceItemName'+size+'");createPreferenceItem(this)\'/>'
			+ '<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" name="preferencePrice" id="preferencePrice'+size+'" style="width: 92%;" onfocus="preferenceItemPrice()" onchange="preferenceItemPrice()"  checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="preferenceNote" id="preferenceNote'+size+'" style="width: 92%;" >'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#preferenceItem").append(str);
}
/////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////附件项目js模板////////////////////////////////////

//自动添加附件费用金额
function autoCharegeItemByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/chargeItem/autoChargeItem",{
			extraParams:{customerType:"${customer.customerType}"},
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;默认收款："+row.defaultPrice+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onCharegeItemSelect);
	//计算总金额
}

function onCharegeItemSelect(event, data, formatted) {
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(14,id.length);
		//判断是否有重复的项目
		var names=$("#chargeItem input[name=chargeItemName]");
		var status=false;
		for(var i=0;i<names.length;i++){
			var name=$(names[i]).val();
			if(id!=$(names[i]).attr("id")){
				if(data.name==name){
					status=true;
					break;
				}	
			}
		}
		if(status==false){
			$("#chargeItemName"+sn).val(data.name);
			if(data.name=='装饰款'){
				$("#decoreMoney").val(data.defaultPrice);
			}
			$("#chargeItemDbid"+sn).val(data.dbid);
			$("#chargeItemPrice"+sn).val(data.defaultPrice);
			chargePrice();
		}else{
			alert("已经添加该项目，不能重复添加！");
		}
		
}
//计算优惠金额
function chargePrice(){
	var prices=$("#chargeItem input[name=chargeItemPrice]");
	var names=$("#chargeItem input[name=chargeItemName]");
	var totalA=0.0;
	for(var i=0;i<prices.length;i++){
		var price=$(prices[i]).val();
		var name=$(names[i]).val()
		if(name=='装饰款'){
			$("#decoreMoney").val(price);
		}
		if(null!=price&&price!=''){
			price=parseInt(price);
			if(!isNaN(price)){
				totalA=totalA+price;
			}else{
				totalA=totalA+0;
			}
		}
	}
	
	$("#fjzje").val(formatFloat(totalA));
	orderContranctTotalPrice();
}
function deleteChareTr(tr) {
	// 删除规格值
	if ($("#chargeItem").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		var chargeItemPrice=$(tr).parent().parent().find("input[name=chargeItemPrice]").val();
		var chargeItemName=$(tr).parent().parent().find("input[name=chargeItemName]").val();
		if(chargeItemName=='装饰款'){
			$("#decoreMoney").val(0);
		}
		$(dd).remove();
		 $("#chargeItem").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		chargePrice();
	}
}
//商品表格编辑部分
function createChargItem(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#chargeItem tr").last().attr("id")){
		createChargItemTr();
		$("#chargeItemDiv").scrollTop($("#chargeItem")[0].scrollHeight);
	}
}
function createChargItemTr() {
	var size = $("#chargeItem").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="chargeItemName" id="chargeItemName'+size+'" value="" style="width: 100%;" onFocus=\'autoCharegeItemByName("chargeItemName'+size+'");createChargItem(this)\'/>'
			+ '<input type="hidden" name="chargeItemDbid" id="chargeItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="chargeItemPrice" id="chargeItemPrice'+size+'" style="width: 92%;" onfocus="chargePrice()" onchange="chargePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text"  name="chargeItemNote" id="chargeItemNote'+size+'" style="width: 92%;" >'
			+ '</td>'
		
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#chargeItem").append(str);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//计算合同金额
function orderContranctTotalPrice(){
   var totalPrice=$("#totalPrice").val();
   if(null!=totalPrice&&totalPrice!=''){
	   totalPrice=parseFloat(totalPrice);
	   if(isNaN(totalPrice)){
		   totalPrice=0; 
	   }
   }else{
	   totalPrice=0;
   }
   var salePrice=$("#salePrice").val();
   if(null!=salePrice&&salePrice!=''){
	   salePrice=parseFloat(salePrice);
	   if(isNaN(salePrice)){
		   salePrice=0; 
	   }
   }else{
	   salePrice=0;
   }
   var preferentialTogether=$("#preferentialTogether").val();
   if(null!=preferentialTogether&&preferentialTogether!=''){
	   preferentialTogether=parseFloat(preferentialTogether);
	   if(isNaN(preferentialTogether)){
		   preferentialTogether=0; 
	   }
   }else{
	   preferentialTogether=0;
   }
   var fjzje=$("#fjzje").val();
   if(null!=fjzje&&fjzje!=''){
	   fjzje=parseFloat(fjzje);
	   if(isNaN(fjzje)){
		   fjzje=0; 
	   }
   }else{
	   fjzje=0;
   }
   totalPrice=salePrice-preferentialTogether+fjzje;
   $("#totalPrice").val(formatFloat(totalPrice));
}

//计算贷款金额
function daikuanNum(){
	var totalPrice=$("#totalPrice").val();
	var sfk=$("#sfk").val();
	if(null!=sfk&&sfk!=''){
		 sfk=parseFloat(sfk);
	   if(isNaN(sfk)){
		   sfk=0; 
	   }
   }else{
	   sfk=0;
   }	
	if(null!=totalPrice&&totalPrice!=''){
		totalPrice=parseFloat(totalPrice);
	   if(isNaN(totalPrice)){
		   totalPrice=0; 
	   }
   }else{
	   totalPrice=0;
   }	
   var daikuan=totalPrice-sfk;
	$("#daikuan").val(formatFloat(daikuan));	
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

//显示隐藏贷款信息
function showOrHideBuyCarWay(value){
	if(value==2){
		$("#dakkuanTr").show();
	}
	if(value==1){
		$("#dakkuanTr").hide();
	}
}
//金额转为大写
function atoc(numberValue){  
	var numberValue=new String(Math.round(numberValue*100)); // 数字金额  
	var chineseValue=""; // 转换后的汉字金额  
	var String1 = "零壹贰叁肆伍陆柒捌玖"; // 汉字数字  
	var String2 = "万仟佰拾亿仟佰拾万仟佰拾元角分"; // 对应单位  
	var len=numberValue.length; // numberValue 的字符串长度  
	var Ch1; // 数字的汉语读法  
	var Ch2; // 数字位的汉字读法  
	var nZero=0; // 用来计算连续的零值的个数  
	var String3; // 指定位置的数值  
	if(len>15){  
	alert("超出计算范围");  
	return "";  
	}  
	if (numberValue==0){  
	chineseValue = "零元整";  
	return chineseValue;  
	}  
	String2 = String2.substr(String2.length-len, len); // 取出对应位数的STRING2的值  
	for(var i=0; i<len; i++){  
	String3 = parseInt(numberValue.substr(i, 1),10); // 取出需转换的某一位的值  
	if ( i != (len - 3) && i != (len - 7) && i != (len - 11) && i !=(len - 15) ){  
	if ( String3 == 0 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else if ( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else{  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	}  
	else{ // 该位是万亿，亿，万，元位等关键位  
	if( String3 != 0 && nZero != 0 ){  
	Ch1 = "零" + String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if ( String3 != 0 && nZero == 0 ){  
	Ch1 = String1.substr(String3, 1);  
	Ch2 = String2.substr(i, 1);  
	nZero = 0;  
	}  
	else if( String3 == 0 && nZero >= 3 ){  
	Ch1 = "";  
	Ch2 = "";  
	nZero = nZero + 1;  
	}  
	else{  
	Ch1 = "";  
	Ch2 = String2.substr(i, 1);  
	nZero = nZero + 1;  
	}  
	if( i == (len - 11) || i == (len - 3)){ // 如果该位是亿位或元位，则必须写上  
	Ch2 = String2.substr(i, 1);  
	}  
	}  
	chineseValue = chineseValue + Ch1 + Ch2;  
	}  
	if ( String3 == 0 ){ // 最后一位（分）为0时，加上“整”  
	chineseValue = chineseValue + "整";  
	}  
	return chineseValue;  
	}  
	
function target32(num){
	var num=atoc(num);
	$("#bigOrderMoney").val(num);
}



function validateFrmBeforeSmb(){
	//优惠
	var	preferentialTogether=$("#preferentialTogether").val(); 
	var	decoreMoney=$("#decoreMoney").val(); 
	var	orderMoney2=$("#orderMoney").val(); 
	var	totalPrice=$("#totalPrice").val(); 
	if(null==orderMoney2||orderMoney2==''){
		alert("请填写预付定金！");
		$("#orderMoney2").focus();
		return false;
	}
	if(null==preferentialTogether||preferentialTogether==''){
		alert("请填写车款优惠！");
		$("#preferentialTogether").focus();
		return false;
	}
	/* if(null==decoreMoney||decoreMoney==''){
		alert("请填写装饰款！");
		$("#decoreMoney").focus();
		return false;
	} */
	var payNowMoney=$('input:radio[name="orderContractExpenses.buyCarType"]:checked').val();
	if(null==payNowMoney||payNowMoney==''){
		alert("请选择购车方式！");
		return false;
	}
	var isCash=$('input:radio[name="orderContractExpenses.payWay"]:checked').val();
	if(null==isCash||isCash==''){
		alert("请选择付款方式！");
		return false;
	}
	return true;
}
</script>
</html>
