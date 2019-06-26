<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车款修正</title>
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
.dis{
	color:#DCDCDC;
}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashReceipt/queryList'">车款收银</a>-
   	<a href="javascript:void(-1)" class="current">修正</a>
</div>
<div class="line"></div>
<div class="frmContent">
<form action="" id="frmId" name="frmId" method="post">
<input type="hidden" readonly="readonly"    id="totalReceivables" name="settlementReceipts.totalReceivables" class="largeX text enable"></input>
<input type="hidden" readonly="readonly"    value="${orderContractExpenses.totalPrice }" name="settlementReceipts.totalcontractAmount" class="largeX text enable"></input>
<input type="hidden" name="orderContractExpenses.masterDecoreMoney" id="masterDecoreMoney" readonly="readonly" value="${orderContractExpenses.masterDecoreMoney }"   class="small text" style="color: red;" ></input>
<input type="hidden" name="orderContractExpenses.attachDecoreMoney" id="attachDecoreMoney" readonly="readonly" value="${orderContractExpenses.attachDecoreMoney }"  onkeyup="decoreTotal();orderContranctTotalPrice();" onfocus="orderContranctTotalPrice();" class="small text"  style="color: red;"></input>
<input type="hidden" readonly="readonly"    id="customerId" name="customerId" value="${orderContractExpenses.customer.dbid}"></input>
<input type="hidden" readonly="readonly"    id="orderContractExpensesId" name="orderContractExpensesId"  value="${orderContractExpenses.dbid}"></input>
<input type="hidden" readonly="readonly" id="totalCollection" name="totalCollection" value="${orderContractExpenses.totalCollection}"></input>
<div class="frmTitle" onclick="showOrHiden('contactTable')">合同基础信息</div>
<c:set value="${orderContractExpenses.customer}" var="customer"></c:set>
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42px">
		<td style="width:20%">车型：&nbsp;</td>
		<td style="width:30%;color:red;" >
				${customer.customerPidBookingRecord.brand.name}
				${customer.customerPidBookingRecord.carSeriy.name}
				${customer.customerPidBookingRecord.carModel.name}
				${customer.customerPidBookingRecord.vinCode}</td>
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td style="width:30%;color:red;font-size: 20px" id="totalcontractAmount">${orderContractExpenses.totalPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">客户姓名：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.name }</td>
		<td style="width:20%" >电话号码：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.mobilePhone }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%"  id="orderMoney">${orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >销售代表：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.customer.user.realName }</td>
	</tr>
	</table>
	
	<div class="frmTitle" onclick="showOrHiden('contactTable')">总费用明细</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">预收款总额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.advanceTotalPrice}</td>
		<td style="width:20%" >其他收费总额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.otherFeePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">裸车销售价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
		<td style="width:20%" >合同总金额：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.totalPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">开票金额：&nbsp;</td>
		<td style="width:30%;">${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney}</td>
		<td style="width:20%">应收总额：&nbsp;</td>
		<td style="width:30%;color:red;font-size:20px" id="totalReceivables1"></td>
	</tr>
	<tr height="42">
		<td  colspan="4"  id="describe" style="color:green">&nbsp;</td>
	</tr>
	</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">修正操作</div>
	<span style="color:red">注：车款出错时可利用此功能修正，修正后改订单为已收状态！</span>
	<h3>修正备注</h3>
	<textarea cols="150" rows="10" name="correctRemark" id="correctRemark" ></textarea>
	<span style="color: red">*</span>
	<div class="formButton" >
		<a id="correct" href="javascript:void(-1)"	onclick="$.utile.submitFrm('frmId','${ctx}/cashReceipt/saveCorrect')"  	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆费用信息</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">经销商报价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.salePrice }</td>
		<td style="width:20%" >裸车销售顾问结算价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">颜色溢价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.colorPrice}</td>
		<td style="width:20%" >裸车销售价：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
	</tr>
	</table>
	
	<div class="frmTitle" onclick="showOrHiden('contactTable')">优惠明细</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">裸车现金优惠卷：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.cashBenefit}</td>
		<td style="width:20%" >未这让权限：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.noWllowancePrice}</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">特殊权限：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.specialPermPrice}</td>
		<td style="width:20%" >特殊权限说明：&nbsp;</td>
		<td style="width:30%">		
			<c:if test="${empty orderContractExpenses.specialPermNote}">
				无
			</c:if>
			<c:if test="${!empty orderContractExpenses.specialPermNote}">
				${orderContractExpenses.specialPermNote}
			</c:if>
		</td>
	</tr>
	</table>
	
	<div class="frmTitle" onclick="showOrHiden('contactTable')">保险明细</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">预收保费：&nbsp;</td>
		<td style="width:30%">0.0</td>
		<td style="width:20%" >续保押金：&nbsp;</td>
		<td style="width:30%">0.0</td>
	</tr>
	</table>
	
	<div class="frmTitle" onclick="showOrHiden('contactTable')">金融明细</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">购车方式：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.buyCarType==1?'现款':'分付' }</td>
		<td style="width:20%" >付款方式：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.payWay==1?'现金':'转账' }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">手续费：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.ajsxf }</td>
		<td style="width:20%" >首付款：&nbsp;</td>
		<td style="width:30%">${orderContractExpenses.sfk }</td>
	</tr>
	<tr height = "42">
		<td style="width:20%">贷款金额：&nbsp;</td>
		<td colspan="3" id="daikuan">${orderContractExpenses.daikuan }</td>
	</tr>
	</table>

	<div class="frmTitle" onclick="showOrHiden('contactTable')">定金装饰</div>
	<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height = "42">
		<td style="width:20%">购车定金：&nbsp;</td>
		<td style="width:30%" id="orderMoney">${orderContractExpenses.orderMoney }</td>
		<td style="width:20%" >装饰款：&nbsp;</td>
		<td style="width:30%" id="decoreMoneyText"></td>
	</tr>
	</table>
	</form>
	</div>
	<br>
	<br>
	<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.packexp.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">

//文档一加载就计算应收总额和装饰款的合计（应收总额应提交订单时就计算好，现在还未做）
window.onload = function(){
if(($("#totalcontractAmount").text()!=null && $("#totalcontractAmount").text()!='')&&($("#orderMoney").text()!=null && $("#orderMoney").text()!='')&&($("#daikuan").text()!=null && $("#daikuan").text!='')){
	if($("#totalCollection").val()!=null && $("#totalCollection").val()!="")	{
		var totalReceivables = parseFloat($("#totalcontractAmount").text())-parseFloat($("#orderMoney").text())-parseFloat($("#daikuan").text())-parseFloat($("#totalCollection").val());
		$("#totalReceivables").val(parseFloat(totalReceivables));
		$("#totalReceivables1").text(parseFloat(totalReceivables));
	}else{
		var totalReceivables = parseFloat($("#totalcontractAmount").text())-parseFloat($("#orderMoney").text())-parseFloat($("#daikuan").text());
		$("#totalReceivables").val(parseFloat(totalReceivables));
		$("#totalReceivables1").text(parseFloat(totalReceivables));
	}
	
}else if(($("#orderMoney").text()==null && $("#orderMoney").text()=='')&&($("#totalcontractAmount").text()!=null && $("#totalcontractAmount").text()!='')&&($("#daikuan").text()!=null && $("#daikuan").text!='')){
	if($("#totalCollection").val()!=null && $("#totalCollection").val()!="")	{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text())-parseFloat($("#daikuan").text())-parseFloat($("#totalCollection").val()));
	}else{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text())-parseFloat($("#daikuan").text()));
	}
	
}else if(($("#orderMoney").text()!=null && $("#orderMoney").text()!='')&&($("#totalcontractAmount").text()==null && $("#totalcontractAmount").text()!='')&&($("#daikuan").text()==null && $("#daikuan").text=='')){
	if($("#totalCollection").val()!=null && $("#totalCollection").val()!="")	{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text())-parseFloat($("#orderMoney").text())-parseFloat($("#totalCollection").val()));
	}else{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text())-parseFloat($("#orderMoney").text()));
	}	
}else if(($("#orderMoney").text()==null && $("#orderMoney").text()=='')&&($("#totalcontractAmount").text()==null && $("#totalcontractAmount").text()!='')&&($("#daikuan").text()==null && $("#daikuan").text=='')){
	if($("#totalCollection").val()!=null && $("#totalCollection").val()!="")	{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text())-parseFloat($("#totalCollection").val()));
	}else{
		$("#totalReceivables").text(parseFloat($("#totalcontractAmount").text()));
	}
	
}


	if(($("#masterDecoreMoney").val()!=null && $("#masterDecoreMoney").val()!='')&&($("#attachDecoreMoney").val()!=null && $("#attachDecoreMoney").val()!=''))
	{
			var decoreMoneyText = parseFloat($("#masterDecoreMoney").val())+parseFloat($("#attachDecoreMoney").val());
			$("#decoreMoneyText").text(parseFloat(decoreMoneyText));
	} else if(($("#masterDecoreMoney").val()!=null && $("#masterDecoreMoney").val()!='')&&($("#attachDecoreMoney").val()==null && $("#attachDecoreMoney").val()=='')){
			$("#decoreMoneyText").text(parseFloat($("#masterDecoreMoney").val()));
	}else if(($("#masterDecoreMoney").val()==null && $("#masterDecoreMoney").val()=='')&&($("#attachDecoreMoney").val()==null && $("#attachDecoreMoney").val()=='')){
			$("#decoreMoneyText").text(parseFloat($("#decoreMoney").val()));
	}else if(($("#masterDecoreMoney").val()==null && $("#masterDecoreMoney").val()=='')&&($("#attachDecoreMoney").val()==null && $("#attachDecoreMoney").val()=='')){
			$("#decoreMoneyText").text(0.0);
		} 
	
	//应收总额描述
	var totalcontractAmount =$("#totalcontractAmount") .text();
	var orderMoney = $("#orderMoney").text();
	var daikuan = $("#daikuan").text()
	var totalReceivables1 = $("#totalReceivables1").text();
	var totalCollection1 = $("#totalCollection").val();
	if(totalCollection1==null || totalCollection1==''){
		totalCollection1 = 0.0;
	}
	var describe = "应收总额("+totalReceivables1+")=合同总金额("+totalcontractAmount+")-购车定金("+orderMoney+")-贷款金额("+daikuan+")-已收金额("+totalCollection1+")";
	$("#describe").text(describe);
}
//判断实收总额是否正确
function  collectionIsCorrect(s){
	var actureMoney = $("#totalMoney").val();
	var total=0;
	var lis = $(s).parent().siblings();
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
	if($(s).val()!=null && $(s).val()!=''){
		total = total + parseFloat($(s).val());
	}
	$("#correct").text("确定收银（￥"+total+"）");
	var attr=$("#correct").attr("class");
	if(parseFloat(actureMoney)==parseFloat(total)){
		$("#correct").removeClass("dis");
	}else{
		var attr=$("#correct").attr("class");
		if(attr.indexOf("dis")){
			$("#correct").addClass("dis");
		}
	}
	$("#countMoney").val(total);
}
//支付方式的文本的显示和实收总额的计算
function payMent(s){	
	if($("input[type='checkbox']").is(':checked')){
		$("#zf").show();
		if($(s).css("display")=="none"){
			$(s).css("display","");
		}else{
			$(s).css("display","none");
			if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
				var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
				/* $("#totalMoney").val(total); */
				$(s).children().eq(0).val("");
			}	
		}
	}else{
		$("#zf").hide();
		$(s).css("display","none");
		if($(s).children().eq(0).val()!=null && $(s).children().eq(0).val()!=''){
			var total = parseFloat($("#totalMoney").val())-parseFloat($(s).children().eq(0).val());
			/* $("#totalMoney").val(total); */
			$(s).children().eq(0).val("");
		}	
	}	
}
//计算实收总额
function totalAmount(s){
	var lis = $(s).parent().siblings();
	var total=0;
	for(var i=0;i<lis.size();i++){
		if(lis.eq(i).children().eq(0).val()!=null && lis.eq(i).children().eq(0).val()!=''){
			total = total + parseFloat(lis.eq(i).children().eq(0).val()); 
		}
	}
		if($(s).val()!=null && $(s).val()!=''){
			total = total + parseFloat($(s).val());
		}	
	/* 	$("#totalMoney").val(total); */
}
$.utile.submitFrm = function(frmId,url) {
	var validata = validateForm(frmId);
	if (validata == true) {
		window.top.art.dialog({
			content : '请确认费用信息无误，点击【确定】保存数据！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm(frmId,url);
			},
			cancel : true
		});
	}
}
</script>
</html>
