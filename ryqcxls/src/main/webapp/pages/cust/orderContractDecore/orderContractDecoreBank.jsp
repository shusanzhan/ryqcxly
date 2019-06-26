<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附加通知单</title>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="${ctx }/css/print.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">

body {
    background: none repeat scroll 0 0 #F8F8F8;
    font-family: "微软雅黑",Helvetica,Arial,sans-serif;
    font-size: 14px;
    line-height: 20px;
    margin: 0;
    padding: 0;
}
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height: 20px;
    width: 100px;
}

input[disabled], select[disabled], textarea[disabled], input[readonly], select[readonly], textarea[readonly] {
    background-color: #F8F8F8;
    cursor: not-allowed;
}
</style>
</head>
<body>
<%-- <div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " onclick="if(validate()){$.utile.submitAjaxForm('frmId','${ctx}/orderContractDecore/saveOrderContractDecore')}"	 style="margin-left: 5px;">保存</a>
	<a href="javascript:;" id="print" class="btn btn-success " onclick="goBack()" style="margin-left: 5px;">返回</a>
</div> --%>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/orderContract/queryList'">订单记录</a>-
   	<a href="javascript:void(-1)" class="current">填写附加通知单</a>
</div>
<div class="line"></div>
<div class="alert alert-error">
	<strong>提示：</strong>
	<p>如无附加项目，请保持为空，点击【保存草稿】或【保存并提交审批】！</p>
</div>
 <div class="testDriverContent" style="width: 92%;">
 <form action="" name="frmId" id="frmId"  target="_self">
 <input type="hidden" id="dbid" name="orderContractDecore.dbid" value="${orderContractDecore.dbid}">
 <input type="hidden" id="editType" name="editType" value="${editType}">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid }">
<input type="hidden" id="smtType" name="smtType" value="1">
	<div class="frmTitle" onclick="showOrHiden('contactTable')">合同备注</div>
	<div>
		${orderContract.note }
	</div>
	<div class="frmTitle" onclick="showOrHiden('contactTable')" style="margin-top: 2px;">&nbsp;</div>
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;">
			</td>
			<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;">附加通知单</td>
			<td style="border: 0px solid #000000;" align="right">SN:${customer.sn }</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:100px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" colspan="4">&#12288;销售装饰项目</td>
		<td  align="center" colspan="4">&#12288;赠送装饰项目</td>	
	</tr>
	<tr>
		<td align="center">序号</td>
		<td align="center">编号</td>
		<td align="center">项目</td>
		<td align="center">金额</td>
		<td align="center">序号</td>
		<td align="center">编号</td>
		<td align="center">项目</td>
		<td align="center">金额</td>
	</tr>
	<c:if test="${empty(orderContractDecore) }">
		<c:forEach begin="1" end="13" var="i">
		<tr>
			<td align="center">${i }</td>
			<td align="center">
				<input type="hidden" value="1" name="type1" id="typeO${i }">
				<c:if test="${orderContract.decoreMoney>0 }" var="status">
					<input type="text" name="serNo1" id="serNoO1${i }" value="" onFocus="autoByName('serNoO1${i}');" >
				</c:if>
				<c:if test="${status==false }">
					<input type="text" readonly="readonly" name="serNo1" id="serNoO1${i }" value="" onFocus="autoByName('serNoO1${i}');" >
				</c:if>
			</td>
			<td align="center">
				<input type="text" readonly="readonly" name="itemName1" id="itemNameO1${i }" value="" >
			</td>
			<td align="left">
				<input type="text" readonly="readonly" name="price1" class="priceA" id="priceO1${i }" value=""  style="width: 60px;">
				<a href="javascript:void(-1)" onclick="onRecord('O1${i }')">清空</a>
			</td>
			<td align="center">${i }</td>
			<td align="center">
				<input type="hidden" value="2" name="type2" id="typeT${i }">
				<input type="text" name="serNo2" id="serNoT2${i }" value="" onFocus="autoByName('serNoT2${i}')" >
			</td>
			<td align="center">
				<input type="text" readonly="readonly" name="itemName2" id="itemNameT2${i }" value="" >
			</td>
			<td align="left">
				<input type="text" readonly="readonly" name="price2" class="priceB" id="priceT2${i }" value=""  style="width: 60px;">
				<a href="javascript:void(-1)" onclick="onRecord('T2${i }')">清空</a>
			</td>
		</tr>
		</c:forEach>
	</c:if>
	<s:set value="0" var="size"></s:set>
	<c:if test="${!empty(orderContractDecore) }" var="status">
			<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
				<tr> 
					<td align="center">${i.index+1 } </td>
					<td align="center">
						<input type="hidden" value="1" name="type1" id="typeO${i.index+1}">
						<input type="text" name="serNo1" id="serNoO${i.index+1}" value="${decoreNoticeItem.serNo1 }"  onFocus="autoByName('serNoO${i.index+1}');" >
					</td>
					<td align="center">
						<input type="text" readonly="readonly" name="itemName1" id="itemNameO${i.index+1}" value="${decoreNoticeItem.itemName1 }"  >
					</td>
					<td align="left">
						<input type="text" readonly="readonly" name="price1" class="priceA" id="priceO${i.index+1}" value="${decoreNoticeItem.price1 }"  style="width: 60px;">
						<a href="javascript:void(-1)" onclick="onRecord('O${i.index+1 }')">清空</a>
					</td>
					<td align="center">${i.index+1 }</td>
					<td align="center">
						<input type="hidden" value="2" name="type2" id="typeT${i.index+1}">
						<input type="text" name="serNo2" id="serNoT${i.index+1}" value="${decoreNoticeItem.serNo2}" onFocus="autoByName('serNoT${i.index+1}')" >
					</td>
					<td align="center">
						<input type="text" readonly="readonly" name="itemName2"  id="itemNameT${i.index+1}" value="${decoreNoticeItem.itemName2}" >
					</td>
					<td align="left">
						<input type="text" readonly="readonly" name="price2" class="priceB" id="priceT${i.index+1}" value="${decoreNoticeItem.price2}"  style="width: 60px;" >
						<a href="javascript:void(-1)" onclick="onRecord('T${i.index+1 }')">清空</a>
					</td>
				</tr>
				<c:set value="${i.index+1 }" var="size"></c:set>
				</c:forEach>
				
				<c:forEach begin="${size+1 }" end="13" var="i">
					<tr>
						<td align="center">${i }</td>
						<td align="center">
							<input type="hidden" value="1" name="type1" id="typeO${i }">
							<input type="text" name="serNo1" id="serNoO1${i }" value="" onFocus="autoByName('serNoO1${i}');" >
						</td>
						<td align="center">
							<input type="text" readonly="readonly" name="itemName1" id="itemNameO1${i }" value="" >
						</td>
						<td align="left">
							<input type="text" readonly="readonly" name="price1" class="priceA" id="priceO1${i }" value=""  style="width: 60px;">
							<a href="javascript:void(-1)" onclick="onRecord('O1${i }')">清空</a>
						</td>
						<td align="center">${i }</td>
						<td align="center">
							<input type="hidden" value="2" name="type2" id="typeT${i }">
							<input type="text" name="serNo2" id="serNoT2${i }" value="" onFocus="autoByName('serNoT2${i}')" >
						</td>
						<td align="center">
							<input type="text" readonly="readonly" name="itemName2" id="itemNameT2${i }" value="" >
						</td>
						<td align="left">
							<input type="text" readonly="readonly" name="price2" class="priceB" id="priceT2${i }" value=""  style="width: 60px;">
							<a href="javascript:void(-1)" onclick="onRecord('T2${i }')">清空</a>
						</td>
					</tr>
					</c:forEach>
	</c:if>
	
	<tr>
		
		<td align="center">销售装饰合计</td>
		<td colspan="3">
			<input readonly="readonly" type="text" name="orderContractDecore.decoreSaleTotalPrce" id="decoreSaleTotalPrce" value="${orderContractDecore.decoreSaleTotalPrce }" >
		</td>
		<td align="center">赠送装饰合计</td>
		<td  colspan="3">
			<input readonly="readonly" type="text" name="orderContractDecore.giveTotalPrice" id="giveTotalPrice" value="${orderContractDecore.giveTotalPrice }" >
		</td>
	</tr>
	<tr>
		<td align="center" colspan="">装饰实收合计</td>
		<td  colspan="8">
			<input type="text" readonly="readonly" name="orderContractDecore.acturePrice" id="acturePrice" value="${orderContract.decoreMoney}" > 
			折扣率
			<input type="text" readonly="readonly" name="orderContractDecore.zkl" id="zkl" value="${orderContractDecore.zkl }" > 
		</td>
	</tr>
</table>
</form>
	<div class="formButton">
			<a href="javascript:void(-1)"	onclick="smtFrm(1)"	class="but butSave">保存草稿</a> 
			<a href="javascript:void(-1)"	onclick="smtFrm(2)"	class="but butSave">保存并提交审批</a> 
	   		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript">
function autoByName(id){
	var id1 = "#"+id;
	$(document).ready(function(){
		$(id1).autocomplete("${ctx}/product/autoProduct?",{
			extraParams:{brandId:"${customer.customerBussi.carSeriy.brand.dbid}"},
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
		       return "<span>"+row.name+"&nbsp;&nbsp; "+row.sn+"&nbsp;&nbsp; "+row.price+"&nbsp;&nbsp; "+row.brand+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	});	
	$(id1).result(onRecordSelect);
	
}
function onRecordSelect(event, data, formatted) {
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(5,id.length);
		$("#"+id).val(data.sn);
		$("#itemName"+sn).val(data.name);
		$("#price"+sn).val(data.price);
		decorePrice();
	}
	
	
function decorePrice(){
	var priceA=$(".priceA");
	var priceB=$(".priceB");
	var totalA=0,totalB=0;
	for(var i=0;i<priceA.length;i++){
		var price=$(priceA[i]).val();
		if(null!=price&&price!=""){
			totalA=totalA+parseInt(price);
		}
	}
	for(var i=0;i<priceB.length;i++){
		var price=$(priceB[i]).val();
		if(null!=price&&price!=""){
			totalB=totalB+parseInt(price);
		}
	}
	$("#decoreSaleTotalPrce").val(totalA);
	$("#giveTotalPrice").val(totalB);
	var decoreTotal=parseInt($("#acturePrice").val());
	var src=parseFloat(decoreTotal/totalA)*100;
	$("#zkl").val(formatFloat(src)+"%");
}
/* function formatFloat(src, pos)
{
    return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
} */
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
function onRecord(num){
	var ss=$("#serNo"+num).val();
	$("#serNo"+num).val("");
	$("#itemName"+num).val("");
	$("#price"+num).val("");
	decorePrice();
}

function jisuanzshj(){
	var totalMoney=$("#acturePrice").val();
	var agsxf=$("#agssf").val();
	if(null==agsxf||agsxf==""){
		agsxf="0";
	}
	if(null!=totalMoney&&totalMoney!=""){
		totalMoney=parseInt(totalMoney);
		agsxf=parseInt(agsxf);
		$("#acturePrice").val(totalMoney-agsxf);
		
		var decoreTotal=parseInt($("#acturePrice").val());
		var src=parseFloat(decoreTotal/totalA);
		$("#zkl").val(formatFloat(src,4)*100+"%");
	}
}
function smtFrm(value){
	$("#smtType").val(value);
	if(value==1){
		$.utile.submitAjaxForm('frmId','${ctx}/orderContractDecore/saveOrderContractDecore');
	}
	if(value==2){
		window.top.art.dialog({
			content : '请确认定单、附件通知单信息无误，点击【确定】提交数据！数据一旦提交审核后将不可更改！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm('frmId','${ctx}/orderContractDecore/saveOrderContractDecore');
			},
			cancel : true
		});
	}
}
</script>
</html>