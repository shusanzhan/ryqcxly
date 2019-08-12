<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附加通知单</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
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
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " onclick="if(validate()){$.utile.submitAjaxForm('frmId','${ctx}/decoreNotice/saveDecoreNotice')}"	 style="margin-left: 5px;">保存</a>
	<a href="javascript:;" id="print" class="btn btn-success " onclick="goBack()" style="margin-left: 5px;">返回</a>
</div>
 <div class="testDriverContent" style="width: 92%;">
 <form action="" name="frmId" id="frmId"  target="_self">
 <input type="hidden" id="dbid" name="decoreNotice.dbid" value="${decoreNotice.dbid}">
 <input type="hidden" id="dbid" name="decoreNotice.bussiStaff" value="${customer.bussiStaff }">
 <input type="hidden" id="dbid" name="decoreNotice.salesManager" value="${customer.showRoomManager }">
<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
<input type="hidden" id="totalPrice" name="totalPrice" value="${totalPrice }">
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;">
				<img src="${ctx }/images/xwqr/logo.png" width="80"></img>
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
		<td align="center" >客户姓名</td>
		<td colspan="">
		 <input type="text" readonly="readonly" name="decoreNotice.customerName" value="${customer.name }" id="" >
		</td>	
		<td colspan="" align="center" rowspan="2">车型</td>
		<td colspan="" rowspan="2">
			<input type="text" readonly="readonly" name="decoreNotice.carModel" value="${customerPidBookingRecord.carSeriy.name }${customerPidBookingRecord.carModel.name }" id="" >
		</td>
		<td align="center" rowspan="2">车架号</td>
		<td colspan="" rowspan="2">
			<input type="text" name="decoreNotice.vinCode" readonly="readonly" value="${customerPidBookingRecord.vinCode }" id="" >
		</td>	
		<td colspan="" align="center" rowspan="2">时间</td>
		<td colspan="" rowspan="2">
		<c:if test="${empty(decoreNotice) }">
			<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/>
		</c:if>
		<c:if test="${!empty(decoreNotice)  }">
			<fmt:formatDate value="${decoreNotice.createTime }" pattern="yyyy年MM月dd日 "/>
			<input type="hidden" value="${decoreNotice.createTime  }" id="createTime" name="decoreNotice.createTime">
		</c:if>
		</td>
	</tr>
	<tr>
		<td align="center" >电话</td>
		<td colspan="">
			<input readonly="readonly" type="text" name="decoreNotice.mobilePhone" value="${customer.mobilePhone }" id="" >
		</td>	
	</tr>
	<tr>
		<td align="center" colspan="4">&#12288;装饰项目1</td>
		<td  align="center" colspan="4">&#12288;装饰项目2</td>	
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
	<c:if test="${empty(decoreNotice) }">
		<c:forEach begin="1" end="13" var="i">
		<tr>
			<td align="center">${i }</td>
			<td align="center">
				<input type="hidden" value="1" name="type1" id="typeO${i }">
				<c:if test="${decoreMoney>0 }" var="status">
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
	<c:if test="${!empty(decoreNotice) }" var="status">
			<c:forEach  var="decoreNoticeItem" items="${decoreNotice.decorenoticeitems }"  varStatus="i">
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
		
		<td align="center">装饰合计</td>
		<td colspan="3">
			<input readonly="readonly" type="text" name="decoreNotice.decoreTotal1" id="decoreTotal1" value="${decoreNotice.decoreTotal1 }" >
		</td>
		<td align="center">装饰合计</td>
		<td  colspan="3">
			<input readonly="readonly" type="text" name="decoreNotice.decoreTotal2" id="decoreTotal2" value="${decoreNotice.decoreTotal2 }" >
		</td>
	</tr>
	<tr>
		<td align="center" colspan="">装饰实收合计</td>
		<td  colspan="8">
			<c:if test="${!empty(decoreNotice)}">
				<input type="text" readonly="readonly" name="decoreNotice.decoreTotal" id="decoreTotal" value="${decoreNotice.decoreTotal }" > 
			</c:if>
			<c:if  test="${empty(decoreNotice)}">
				<input type="text" readonly="readonly" name="decoreNotice.decoreTotal" id="decoreTotal" value="${decoreMoney}" > 
			</c:if>
			<!-- 合同金额：<span style="color: red;font-size: 18px;">12000.00</span>，
			交款确认单实收金额：<span style="color: red;font-size: 18px;">10000.00</span>；
			装饰实收合计=合同金额<span style="color: red;font-size: 18px;">-</span>交款确认单实收金额 -->
			折扣率
			<input type="text" readonly="readonly" name="decoreNotice.zkl" id="zkl" value="${decoreNotice.zkl }" > 
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="1" style="margin-bottom: 50px;">
	<tr>
		<td align="left" style="border: 0;">销售顾问：${customer.bussiStaff }</td>
		<td align="left"  style="border: 0;">物流部：</td>
		<td align="left" style="border: 0;">财务部：</td>
		<td align="left"  style="border: 0;">销售经理：${customer.salesConsultant }</td>
	</tr>
</table>
</form>
</div>
</body>
<script type="text/javascript">
function autoByName(id){
	var id1 = "#"+id;
	$(document).ready(function(){
		$(id1).autocomplete("${ctx}/product/autoProduct?",{
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
	$("#decoreTotal1").val(totalA);
	$("#decoreTotal2").val(totalB);
	var decoreTotal=parseInt($("#decoreTotal").val());
	var src=parseFloat(decoreTotal/totalA);
	$("#zkl").val(formatFloat(src,4)*100+"%");
}
function formatFloat(src, pos)
{
    return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}
function onRecord(num){
	var ss=$("#serNo"+num).val();
	$("#serNo"+num).val("");
	$("#itemName"+num).val("");
	$("#price"+num).val("");
	decorePrice();
}

function jisuanzshj(){
	var totalMoney=$("#totalMoney").val();
	var agsxf=$("#agssf").val();
	if(null==agsxf||agsxf==""){
		agsxf="0";
	}
	if(null!=totalMoney&&totalMoney!=""){
		totalMoney=parseInt(totalMoney);
		agsxf=parseInt(agsxf);
		$("#decoreTotal").val(totalMoney-agsxf);
		
		var decoreTotal=parseInt($("#decoreTotal").val());
		var src=parseFloat(decoreTotal/totalA);
		$("#zkl").val(formatFloat(src,4)*100+"%");
	}
}
function validate(){
	return true;
}
</script>
</html>