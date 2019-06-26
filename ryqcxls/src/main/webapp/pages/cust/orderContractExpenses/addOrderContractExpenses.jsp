<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>订单填写-费用明细</title>
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
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1)" class="current">订单提报（费用明细）</a>
</div>
<div class="line"></div>
<div class="frmContent">
<form action="" id="frmId" name="frmId" method="post">
<input type="hidden" name="editType" id="editType" value="${param.editType }" class="largeX text"></input>
<input type="hidden" name="orderContractId" id="orderContractId" value="${orderContract.dbid }" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.dbid" id="dbid" value="${orderContractExpenses.dbid }" class="largeX text"></input>
<!-- 营收金额（出去预付款总额）车款+装饰+按揭+其他收费；合同总额-预售总额 -->
<input type="hidden" name="orderContractExpenses.revenuePrice" id="revenuePrice" value="0.0" class="largeX text"></input>
<!-- 车辆盈利预估(车辆实际销售价-销售顾问结算价） -->
<input type="hidden" name="orderContractExpenses.carGrofitPrice" id="carGrofitPrice" value="0.0" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.decoreCostMoney" id="decoreCostMoney" value="0.0" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.decoreGrofitPrice" id="decoreGrofitPrice" value="0.0" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.otherCostFeePrice" id="otherCostFeePrice" value="0.0" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.totalGrofitPrice" id="totalGrofitPrice" value="0.0" class="largeX text"></input>
<input type="hidden" name="orderContractExpenses.ajsxfGrofit" id="ajsxfGrofit" value="0.0" class="largeX text"></input>
<div class="frmTitle" onclick="showOrHiden('contactTable')">购车费用明细</div>
<table border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr height="42">
			<td class="formTableTdLeft">经销商报价：&nbsp;</td>
			<td colspan="">
				<c:if test="${enterprise.bussiType==3 }">
					<input type="text" readonly="readonly" value="${customer.navPrice}" onkeyup="orderContranctTotalPrice();" id="salePrice" name="orderContractExpenses.salePrice" class="midea text" ></input>
				</c:if>
				<c:if test="${enterprise.bussiType!=3 }">
					<input type="text" readonly="readonly" value="${customer.customerLastBussi.carModel.salePrice }" onkeyup="orderContranctTotalPrice();" id="salePrice" name="orderContractExpenses.salePrice" class="midea text" ></input>
				</c:if>
				<span style="color: red">*</span>
				颜色溢价：<input type="text" name="orderContractExpenses.colorPrice" id="colorPrice"   value="0.0" class="small text" onfocus="orderContranctTotalPrice();" onkeyup="orderContranctTotalPrice();" checkType="float,0" canEmpty="Y" style="color: red;width: 68px;" tip="请输入颜色溢价"></input>
			</td>
			<td class="formTableTdLeft" style="font-size: 12px;">裸车销售顾问结算价：&nbsp;</td>
			<td colspan="">
				<c:if test="${customer.user.bussiType==1 }">
					<input type="text" readonly="readonly" value="${carModelSalePolicy.saleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="largeX text" ></input>
				</c:if>
				<c:if test="${customer.user.bussiType==2 }">
					<input type="text" readonly="readonly" value="${carModelSalePolicy.netSaleCsprice }" onkeyup="countActMoney()" id="carSalerPrice" name="orderContractExpenses.carSalerPrice" class="largeX text" ></input>
				</c:if>
				<span style="color: red">*</span>
			</td>
		</tr>
	<tr height="42">
	 	<td class="formTableTdLeft">裸车现金优惠：&nbsp;</td>
		<td colspan="1">
				<input type="text"  name="orderContractExpenses.cashBenefit" id="cashBenefit" value="0.0" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="midea text" style="color: red;" checkType="float,0" canEmpty="Y" style="color: red;" tip="请输入裸车现金优惠,必须为数字,可不填写"></input>
				<span style="color: red">*</span>说明：不包含大客户、自有车等特殊权限优惠
		</td>
	 	<td class="formTableTdLeft">未折让权限：&nbsp;</td>
		<td colspan="1">
				<input type="text" readonly="readonly" name="orderContractExpenses.noWllowancePrice" id="noWllowancePrice" value="0.0" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="largeX text" style="color: red;"  tip="未折让权限"></input>
				<span style="color: red">*</span>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft">特殊政策优惠：&nbsp;</td>
			<td >
			<input type="text" name="orderContractExpenses.specialPermPrice" id="specialPermPrice" onfocus="orderContranctTotalPrice();" onkeyup="orderContranctTotalPrice();" value="0.0" class="largeX text"  checkType="float,0" canEmpty="Y" style="color: red;" tip="请输入特殊政策优惠,必须为数字,可不填写"></input>
			<span style="color: red">*</span>
		</td>
		<td class="formTableTdLeft">特殊政策优惠说明：&nbsp;</td>
			<td >
			<input type="text"  name="orderContractExpenses.specialPermNote" id="specialPermNote" value=""  class="largeX text" placeholder='如：大客户、二手车置换等特殊优惠政策'></input>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft">购车定金：&nbsp;</td>
				<td >
				<input type="text" name="orderContractExpenses.orderMoney" id="orderMoney" onfocus="target32(this.value)" onkeyup="target32(this.value)" value="" class="largeX text" style="color: red;" checkType="float,0" style="color: red;" tip="请输入购车定金,大于或等0"></input>
				<span style="color: red">*</span>
				<input type="hidden" readonly="readonly" name="orderContractExpenses.bigOrderMoney" id="bigOrderMoney" value="" class="largeX text" ></input>
			</td>
		<td class="formTableTdLeft">装饰款：&nbsp;</td>
		<td >
			主合同：
			<input type="text" name="orderContractExpenses.masterDecoreMoney" id="masterDecoreMoney" value="0.0"  onkeyup="decoreTotal();orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="small text" placeholder="计入主合同金额" checkType="float,0" canEmpty="Y" style="color: red;" tip="该款项计入主合同,大于或等0，可不填"></input>
			附加：
			<input type="text" name="orderContractExpenses.attachDecoreMoney" id="attachDecoreMoney" value="0.0"  onkeyup="decoreTotal();orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="small text" placeholder="计入附加同金额" checkType="float,0" canEmpty="Y" style="color: red;" tip="该款项计入附加合同,大于或等0，可不填"></input>
			<input type="hidden" name="orderContractExpenses.decoreMoney" id="decoreMoney" value="0.0" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="largeX text" checkType="float,0" canEmpty="Y" ></input>
			<span style="color: red">
				合计：<span id="decoreMoneyText">0.0</span>			
			</span>
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
		<tr height="42" id="dakkuanTr1" style="display: none;">
			<td class="formTableTdLeft">咨询服务费：&nbsp;</td>
			<td colspan="3">
				<input type="text"   id="ajsxf" name="orderContractExpenses.ajsxf" class="largeX text" value="0.00" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" checkType="float,0" canEmpty="Y" style="color: red;" tip="请输入咨询服务费"></input>
			</td>
		</tr>
		<tr height="42" id="dakkuanTr" style="display: none;">
			<td class="formTableTdLeft">首付款：&nbsp;</td>
			<td colspan="">
				<input type="text"   id="sfk" name="orderContractExpenses.sfk" class="largeX text" value="0.00" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" checkType="float,0" canEmpty="Y" style="color: red;" tip="请输入首付款"></input>
			</td>
			<td class="formTableTdLeft">贷款金额：&nbsp;</td>
			<td colspan="">
				<input type="text"   id="daikuan" name="orderContractExpenses.daikuan" class="largeX text" value="0.00" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" checkType="float,0" canEmpty="Y" style="color: red;" tip="请输入贷款金额"></input>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">其它收费总额：</td>
			<td id="carColorId">
				<input type="text" readonly="readonly"   onkeyup="countActMoney()"  id="otherFeePrice" name="orderContractExpenses.otherFeePrice" class="largeX text enable" value="0.0"></input>
				<span style="color: red">*</span>说明：其他收费合计
			</td>
			<td class="formTableTdLeft">预收款总额：</td>
			<td id="carColorId">
				<input type="text" readonly="readonly"   onkeyup="countActMoney()"  id="advanceTotalPrice" name="orderContractExpenses.advanceTotalPrice" class="largeX text enable" value="0.0"></input>
				<span style="color: red">*</span>说明：预收款项合计
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" style="font-size: 12px;">裸车销售价：</td>
			<td id="carColorId" colspan="3">
				<input type="text" readonly="readonly"   onkeyup="countActMoney()"  id="carActurePrice" name="orderContractExpenses.carActurePrice" class="largeX text enable" value="0.0"></input>
				<span style="color: red">*</span>
				裸车销售价=指导价+颜色溢价-裸车现金优惠-特殊政策优惠
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">合同总金额：&nbsp;</td>
			<td colspan="3">
					<input type="text" readonly="readonly" name="orderContractExpenses.totalPrice" id="totalPrice" value="0.0" onkeyup="orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="largeX text" style="color: red;" checkType="float,1" tip="请填写合同金额"></input>
					<span style="color: red">*</span>
					<span style="font-size: 12px;">说明：合同总金额=经销商报价+颜色溢价-裸车现金优惠-特殊政策优惠+其它收费总额+预收款总额+装饰款+咨询服务费</span>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">备注：&nbsp;</td>
			<td colspan="3">
					<textarea  name="orderContractExpenses.note" id="note"  class="largeX text" style="height: 120px;width: 95%;">${orderContractExpenses.note }</textarea>
			</td>
		</tr>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')">其他收费（<span style="color: red;font-size: 12px">如：高开票税费</span>）</div>
<div id='chargeItemDiv' style="width: 100%">
	<table id="chargeItem" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
		<thead>
			<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<th style="width: 30px;text-align: center;">序号</th>
				<th style="width: 80px;text-align: center;">其他收费项目</th>
				<th style="width: 50px;text-align: center;">其他收费金额</th>
				<th style="width: 160px;text-align: center;">备注</th>
				<th style="width: 40px;text-align: center;">操作</th>
			</tr>
		</thead>
		<tbody style="overflow: scroll;">
		<!-- 添加时展示页面 -->
				<c:forEach var="i" begin="0" step="1" end="3">
					<tr id="tr${i+1 }">
						<td style="text-align: center;">
							${i+1 }
						</td>
						<td >
							<input type="text"  name="chargeItemName" id="chargeItemName${i+1 }" onFocus="autoCharegeItemByName('chargeItemName${i+1 }');createChargItem(this)" class="smallX text" style="width: 92%;" >
							<input type="hidden" name="chargeItemDbid" id="chargeItemDbid${i+1}" onblur="create(this)" >
						</td>
						<td>
							<input type="text" name="chargeItemPrice" id="chargeItemPrice${i+1 }" class="smallX text" style="width: 92%;" onfocus="chargePrice()" onkeyup="chargePrice()" checkType="integer" canEmpty="Y" tip="请输入其他收费金额，必须为数字">
						</td>
						<td style="text-align: center;">
							<input type="text"  name="chargeItemNote" id="chargeItemNote${i+1 }" class="smallX text" style="width: 92%;" >
						</td>
						<td style="text-align: center;padding-top: 8px;">
							<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)" >
								<i class="icon-remove icon-black" > </i>
							</a>
						</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
	<table  border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;border-top: 0px;" >
		<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;border-top: 0px;">
			<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;border-top: 0px;">其他收费总额:<span style="font-size: 20px;color: red;margin:0 5px;" id="otherFeePriceText">0</span>元</td>
		</tr>
	</table>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">预收款项（<span style="color: red;font-size: 12px">如：惠民、二手车置换、大客户</span>）</div>
<div id='te' style="width: 100%">
		<table id="preferenceItem" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;" >
			<thead>
				<tr style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<th style="width: 30px;text-align: center;">序号</th>
					<th style="width: 80px;text-align: center;">预收项目</th>
					<th style="width: 50px;text-align: center;">预收金额</th>
					<th style="width: 160px;text-align: center;">备注</th>
					<th style="width: 40px;text-align: center;">操作</th>
				</tr>
			</thead>
			<tbody style="overflow: scroll;">
			<!-- 添加时展示页面 -->
					<c:forEach var="i" begin="0" step="1" end="3">
						<tr id="tr${i+1 }">
							<td style="text-align: center;">
								${i+1 }
							</td>
							<td >
								<input type="text" name="preferenceItemName" id="preferenceItemName${i+1 }" class="smallX text" style="width: 92%;" onFocus="autoPreferenceItemByName('preferenceItemName${i+1 }');createPreferenceItem(this)" tip="输入优惠项目拼音码"  >
								<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid${i+1}"  >
							</td>
							<td>
								<input type="text" name="preferencePrice" id="preferencePrice${i+1 }"  class="smallX text" style="width: 92%;" onfocus="preferenceItemPrice()" onkeyup="preferenceItemPrice()" checkType="integer" canEmpty="Y" tip="请输入预收项目金额，必须为数字">
							</td>
							<td style="text-align: center;">
								<input type="text"   name="preferenceNote" id="preferenceNote${i+1 }" class="smallX text" style="width: 92%;" >
							</td>
							
							<td style="text-align: center;padding-top: 8px;">
								<a class="aedit" href="javascript:void(-1)" onclick="deletePreferenceTr(this)" >
									<i class="icon-remove icon-black" > </i>
								</a>
							</td>
						</tr>
					</c:forEach>
			</tbody>
		</table>
		<table  border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;border-top: 0px;" >
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;border-top: 0px;">
				<td width="100%" colspan="5" style="text-align: right;padding-right: 12px;border-top: 0px;">预收款项:<span style="font-size: 20px;color: red;margin:0 5px;" id="advanceTotalPriceText">0</span>元</td>
			</tr>
		</table>
</div>
<div class="formButton">
	<a id="submit" class="but butSave" href="javascript:void(-1)" onclick="if(validateFrmBeforeSmb()){$.utile.submitAjaxForm('frmId','${ctx}/orderContractExpenses/saveOrderContractDecore')}">
		保存并填写装饰项目
	</a>
	<a class="but butCancle" onclick="window.history.go(-1)"><i class="icon-arrow-left icon-white"></i> 上一步</a>
</div>
</form>	
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.packexp.js"></script>
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
	$("#advanceTotalPrice").val(formatFloat(totalA));
	$("#advanceTotalPriceText").text(formatFloat(totalA));
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
			+ '<input type="text"  name="preferenceItemName" id="preferenceItemName'+size+'" value=""  onFocus=\'autoPreferenceItemByName("preferenceItemName'+size+'");createPreferenceItem(this)\' class="smallX text" style="width: 92%;"/>'
			+ '<input type="hidden" name="preferenceItemDbid" id="preferenceItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text" name="preferencePrice" id="preferencePrice'+size+'" class="smallX text" style="width: 92%;" onfocus="preferenceItemPrice()" onkeyup="preferenceItemPrice()"  checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="preferenceNote" id="preferenceNote'+size+'" class="smallX text" style="width: 92%;" >'
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
		if(null!=price&&price!=''){
			price=parseInt(price);
			if(!isNaN(price)){
				totalA=totalA+price;
			}else{
				totalA=totalA+0;
			}
		}
	}
	
	$("#otherFeePrice").val(formatFloat(totalA));
	$("#otherFeePriceText").text(formatFloat(totalA));
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
			+ '<input type="text"  name="chargeItemName" id="chargeItemName'+size+'" value=""  onFocus=\'autoCharegeItemByName("chargeItemName'+size+'");createChargItem(this)\' class="smallX text" style="width: 92%;"/>'
			+ '<input type="hidden" name="chargeItemDbid" id="chargeItemDbid'+size+'" value="">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="chargeItemPrice" id="chargeItemPrice'+size+'" class="smallX text" style="width: 92%;" onfocus="chargePrice()" onkeyup="chargePrice()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input  type="text"  name="chargeItemNote" id="chargeItemNote'+size+'" class="smallX text" style="width: 92%;" >'
			+ '</td>'
		
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteChareTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#chargeItem").append(str);
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function decoreTotal(){
	//主合同装饰
	   var masterDecoreMoney=$("#masterDecoreMoney").val();
	   if(null!=masterDecoreMoney&&masterDecoreMoney!=''){
		   masterDecoreMoney=parseFloat(masterDecoreMoney);
		   if(isNaN(masterDecoreMoney)){
			   masterDecoreMoney=0; 
		   }
	   }else{
		   masterDecoreMoney=0;
	   }
		//附加合同装饰
	   var attachDecoreMoney=$("#attachDecoreMoney").val();
	   if(null!=attachDecoreMoney&&attachDecoreMoney!=''){
		   attachDecoreMoney=parseFloat(attachDecoreMoney);
		   if(isNaN(attachDecoreMoney)){
			   attachDecoreMoney=0; 
		   }
	   }else{
		   attachDecoreMoney=0;
	   }
	   var decoreMoney=masterDecoreMoney+attachDecoreMoney;
	   $("#decoreMoneyText").text(decoreMoney);
	   $("#decoreMoney").val(decoreMoney);
}
//计算合同金额
function orderContranctTotalPrice(){
	//经销商报价
   var salePrice=$("#salePrice").val();
   if(null!=salePrice&&salePrice!=''){
	   salePrice=parseFloat(salePrice);
	   if(isNaN(salePrice)){
		   salePrice=0; 
	   }
   }else{
	   salePrice=0;
   }
	//现金优惠金额
   var cashBenefit=$("#cashBenefit").val();
   if(null!=cashBenefit&&cashBenefit!=''){
	   cashBenefit=parseFloat(cashBenefit);
	   if(isNaN(cashBenefit)){
		   cashBenefit=0; 
	   }
   }else{
	   cashBenefit=0;
   }
   //装饰款
   var decoreMoney=$("#decoreMoney").val();
   if(null!=decoreMoney&&decoreMoney!=''){
	   decoreMoney=parseFloat(decoreMoney);
	   if(isNaN(decoreMoney)){
		   decoreMoney=0; 
	   }
   }else{
	   decoreMoney=0;
   }
   //颜色溢价
   var colorPrice=$("#colorPrice").val();
   if(null!=colorPrice&&colorPrice!=''){
	   colorPrice=parseFloat(colorPrice);
	   if(isNaN(colorPrice)){
		   colorPrice=0; 
	   }
   }else{
	   colorPrice=0;
   }
   //特殊权限
   var specialPermPrice=$("#specialPermPrice").val();
   if(null!=specialPermPrice&&specialPermPrice!=''){
	   specialPermPrice=parseFloat(specialPermPrice);
	   if(isNaN(specialPermPrice)){
		   specialPermPrice=0; 
	   }
   }else{
	   specialPermPrice=0;
   }
   //咨询服务费
   var ajsxf=$("#ajsxf").val();
   if(null!=ajsxf&&ajsxf!=''){
	   ajsxf=parseFloat(ajsxf);
	   if(isNaN(ajsxf)){
		   ajsxf=0; 
	   }
   }else{
	   ajsxf=0;
   }
   //预收项目总金额
   var advanceTotalPrice=$("#advanceTotalPrice").val();
   if(null!=advanceTotalPrice&&advanceTotalPrice!=''){
	   advanceTotalPrice=parseFloat(advanceTotalPrice);
	   if(isNaN(advanceTotalPrice)){
		   advanceTotalPrice=0; 
	   }
   }else{
	   advanceTotalPrice=0;
   }
   //其他收费项目总额
   var otherFeePrice=$("#otherFeePrice").val();
   if(null!=otherFeePrice&&otherFeePrice!=''){
	   otherFeePrice=parseFloat(otherFeePrice);
	   if(isNaN(otherFeePrice)){
		   otherFeePrice=0; 
	   }
   }else{
	   otherFeePrice=0;
   }
   ///车辆销售顾问结算价
   var carSalerPrice=$("#carSalerPrice").val();
   if(null!=carSalerPrice&&carSalerPrice!=''){
	   carSalerPrice=parseFloat(carSalerPrice);
	   if(isNaN(carSalerPrice)){
		   carSalerPrice=0; 
	   }
   }else{
	   carSalerPrice=0;
   }
   
   //合同总金额
   var totalPrice=0;
   //车辆实际销售价格:carActurePrice,营收金额:revenuePrice,车辆盈利预估:carGrofitPrice
   var carActurePrice=0,revenuePrice=0,carGrofitPrice=0;
   //车辆实际销售价(指导价-现金优惠-特殊政策优惠+颜色溢价）   
   carActurePrice=salePrice-cashBenefit-specialPermPrice+colorPrice;
   $("#carActurePrice").val(formatFloat(carActurePrice));
   
   //合同总金额 （经销商报价-裸车现金优惠-特殊政策优惠+其它收费总额+预收款总额+装饰款+咨询服务费）
   totalPrice=carActurePrice+otherFeePrice+advanceTotalPrice+ajsxf+decoreMoney;
   $("#totalPrice").val(formatFloat(totalPrice));
   
   //车辆盈利预估(车款-销售顾问结算价）
   carGrofitPrice=carActurePrice-carSalerPrice;
   $("#carGrofitPrice").val(formatFloat(carGrofitPrice));
  
   //营收金额=合同总额-预收总额
   revenuePrice=totalPrice-advanceTotalPrice;
   $("#revenuePrice").val(formatFloat(revenuePrice));
   
   //销售顾问结算价（模板销售顾问结算价-特殊优惠）
   var ss="${carModelSalePolicy.saleCsprice }";
   carSalerPrice=ss-specialPermPrice;
   $("#carSalerPrice").val(formatFloat(carSalerPrice));
   
   //未折让权限=裸车实际销售价-销售顾问结算价
  var noWllowancePrice=carActurePrice-carSalerPrice;
   $("#noWllowancePrice").val(noWllowancePrice);
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
		$("#dakkuanTr1").show();
	}
	if(value==1){
		$("#dakkuanTr").hide();
		$("#dakkuanTr1").hide();
		$("#ajsxf").val("0.0");
		$("#sfk").val("0.0");
		$("#daikuan").val("0.0");
		preferenceItemPrice();
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
	var	specialPermPrice=$("#specialPermPrice").val(); 
	specialPermPrice=parseFloat(specialPermPrice);
	var	preferentialTogether=$("#preferentialTogether").val(); 
	var	decoreMoney=$("#decoreMoney").val(); 
	var	orderMoney2=$("#orderMoney").val(); 
	var	totalPrice=$("#totalPrice").val(); 
	if(isNaN(specialPermPrice)){
		alert("特殊权限金额填写错误");
		return false;
	}else{
		var specialPermNote=$("#specialPermNote").val();
		if(specialPermPrice>0){
			if(null==specialPermNote||specialPermNote==''||specialPermNote.length<2){
				alert("请填写特殊权限备注信息");
				return false;
			}
		}
	}
	if(null==orderMoney2||orderMoney2==''){
		alert("请填写预付定金！");
		$("#orderMoney2").focus();
		return false;
	}
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
