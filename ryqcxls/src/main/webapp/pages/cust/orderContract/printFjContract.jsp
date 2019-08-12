<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.enterprise.allName }销售附加合同书打印</title>
<link rel="stylesheet" href="${ctx }/css/print.css?=1" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
		.bar {
			display: none;
		}
</style>
<style type="text/css">

body {
	font-size: 16px;
}
table td, table th {
	font-size: 16px;
}
.nonlineTable td {
	font-size: 16px;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
</head>
<body>
<c:if test="${!empty(param.type)&&param.type==1 }" var="status">
		<a href="javascript:;" id="print2" class="btn btn-success " style="margin-left: 5px;" onclick="window.open('${ctx}/orderContract/printContract?dbid=${orderContract.dbid }')">查看主合同</a>
</c:if>
<c:if test="${ status==false}">
	<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		|
		<a href="javascript:;" id="print2" class="btn btn-success " style="margin-left: 5px;" onclick="window.open('${ctx}/orderContract/printContract?dbid=${orderContract.dbid }')">打印主合同</a>
	</div>
</c:if>

<c:set var="customer"  value="${orderContract.customer }" ></c:set>
<c:set var="enterprise"  value="${customer.enterprise}" ></c:set>

<div style="width: 100%;margin: 0px auto;font-size: 14px;">
<div style="margin:0px auto;width: 600px;text-align: center;padding: 20px 0px;">
	<h1>${customer.customerBussi.brand.name }汽车销售有限公司授权销售服务中心</h1>
	<h2>${customer.enterprise.allName }销售附加合同书</h2>
</div>
<table width="99%"  cellpadding="0" cellspacing="0" style="font-size: 16px;">
  <tr>
    <td colspan="5" align="right" style="padding-right: 150px;border: 0 ;line-height: 20px;" >&nbsp;合同编号：<span style="font-weight: bold;">${orderContract.customer.sn }</span></td>
  </tr>
  <tr>
    <td class="labelTitle">需方</td>
    <td style="width: 300px;" colspan="2">&nbsp;${orderContract.name }</td>
    <td class="labelTitle">供方</td>
    <td style="width: 300px;">&nbsp;
	    ${customer.enterprise.allName }
    </td>
  </tr>
  <tr>
    <td class="labelTitle">身份证地址</td>
    <td colspan="2">&nbsp;${orderContract.address }</td>
    <td class="labelTitle">通讯地址</td>
    <td>&nbsp;${enterprise.address }</td>
  </tr>
  <tr>
    <td class="labelTitle">联系电话</td>
    <td colspan="2">&nbsp;${customer.mobilePhone }</td>
    <td class="labelTitle">联系电话</td>
    <td>&nbsp;${enterprise.phone }</td>
  </tr>
  <tr>
    <td class="labelTitle">证件类型</td>
    <td colspan="2">&nbsp;${customer.paperwork.name}</td>
    <td class="labelTitle">邮政编码</td>
    <td>&nbsp;${enterprise.zipCode }</td>
  </tr>
  <tr>
    <td class="labelTitle">身份证号</td>
    <td colspan="2">&nbsp;${orderContract.icard }</td>
    <td class="labelTitle">开户银行</td>
    <td>&nbsp;${enterprise.bank }</td>
  </tr>
  <tr>
    <td class="labelTitle">开票名称</td>
    <td colspan="2">&nbsp;${orderContract.bankNo }</td>
    <td class="labelTitle">银行账号</td>
    <td>&nbsp;${enterprise.account }</td>
  </tr>
  <tr>
  	<td style="border: 0" colspan="5">
		<p style="line-height: 32px;color: #000000;">1、供需方根据中华人民共和国《合同法》及相关法律、法规达成以下协议：</p>
  	</td>
  </tr>
  <tr>
    <th style="width: 20px;text-align: center;">项目</th>
    <th style="width: 150px;text-align: center;" width="150">产品系列</th>
    <th style="width: 150px;text-align: center;" width="150">车型代码</th>
    <th style="width: 150px;text-align: center;" width="150">油漆颜色</th>
    <th style="width: 300px;text-align: center;" width="300">备注</th>
  </tr>
   <c:set value="0" var="totalPrice"></c:set>
  <c:forEach var="orderContractProduct" items="${orderContractProducts }" varStatus="i">
	  <tr>
	   <th style="text-align: center;">明细</th>
	    <td>&nbsp;${orderContractProduct.carseriy.brand.name }&nbsp;&nbsp;${orderContractProduct.carseriy.name }</td>
	    <td>&nbsp;${orderContractProduct.carModel.name }</td>
	    <td>&nbsp;${orderContractProduct.carColor.name }</td>
	    <td>&nbsp;${orderContractProduct.note }
	    	<c:if test="${orderContract.isShowNote==true }">
	   			车型颜色不换,定金不退只用于冲抵车款	
	   		</c:if>
	    </td>
	    <c:set value="${ totalPrice+orderContractProduct.price}" var="totalPrice"></c:set>
	  </tr>
  </c:forEach>
 <tr>
 	<td style="border: 0" colspan="5">
		<div >
			<div style="float: left;">2、其他收费明细</div>
			<div style="clear: both;"></div>
		</div>
	</td>
</tr>
        <tr height="24" style=";height:24px">
            <td align="center" style="" class="selectTdClass">
                序号
            </td>
            <td align="center" colspan="2" style="" class="selectTdClass">
                项目
            </td>
            <td align="center" colspan="1" style="" class="selectTdClass">
                金额（元）
            </td>
            <td align="center" colspan="4" style="" class="selectTdClass">
                备注
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" style="text-align: center;" class="selectTdClass">
            	1
            </td>
            <td colspan="2" style="" class="selectTdClass">按揭手续费</td>
            <td  class="selectTdClass" style="text-align: center;">${orderContractExpenses.ajsxf }</td>
            <td colspan="4" style="border-left:none" class="selectTdClass"></td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" style="text-align: center;" class="selectTdClass">
            	2
            </td>
            <td colspan="2" style="" class="selectTdClass">装饰款</td>
            <td  class="selectTdClass" style="text-align: center;">
	            <c:if test="${empty(orderContractExpenses.attachDecoreMoney) }">
	            	0.0
	            </c:if>
	            <c:if test="${!empty(orderContractExpenses.attachDecoreMoney) }">
	            	${orderContractExpenses.attachDecoreMoney }
	            </c:if>
            </td>
            <td colspan="4" style="border-left:none" class="selectTdClass"></td>
        </tr>
        <c:set value="0" var="totalItemLength"></c:set>
       	<c:forEach var="orderContractExpensesPreferenceItem" items="${orderContractExpensesChargeItems }" varStatus="in">
       		<tr height="24" style=";height:24px">
	            <td height="24" style="text-align: center; " class="selectTdClass">
	                ${in.index +3}
	            </td>
	            <td colspan="2" style="border-left:none" class="selectTdClass">
	            	${orderContractExpensesPreferenceItem.chargeItemName }
	            </td>
	            <td style="text-align: center;" class="selectTdClass">
	            	${orderContractExpensesPreferenceItem.price }
	            </td>
	            <td colspan="4" style="border-left:none" class="selectTdClass">
	            	${orderContractExpensesPreferenceItem.note }
	            </td>
	        </tr>
	        <c:set value="${in.index+3 }" var="totalItemLength"></c:set>
       	</c:forEach>
        <c:forEach var="orderContractExpensesChargeItem" items="${orderContractExpensesPreferenceItems }" varStatus="in">
       			<tr height="24" style=";height:24px">
		           <td height="24" style="text-align: center; " class="selectTdClass">
		                ${in.index +1+totalItemLength}
		            </td>
		            <td colspan="2" style="border-left:none" class="selectTdClass">
		            	${orderContractExpensesChargeItem.preferenceItemName }
		            </td>
		            <td style="text-align: center;" class="selectTdClass">
		            	${orderContractExpensesChargeItem.price }
		            </td>
		            <td colspan="4" style="border-left:none" class="selectTdClass">
		            	${orderContractExpensesChargeItem.note }
		            </td>
		        </tr>
	        <c:set value="${in.index+totalItemLength }" var="totalItemLength"></c:set>
       	</c:forEach>
        <c:if test="${totalItemLength<5}">
        	<c:forEach var="i" begin="${totalItemLength+1 }" end="4">
        		<tr height="24" style=";height:24px">
		            <td height="24" style="text-align: center;" class="selectTdClass">
		                ${i+1 }
		            </td>
		            <td colspan="2" style="" class="selectTdClass"></td>
		            <td style="" class="selectTdClass"></td>
		            <td colspan="4" style="" class="selectTdClass"></td>
		        </tr>
        	</c:forEach>
        </c:if>
        <tr height="24" style=";height:24px">
            <td colspan="3" height="24" class="selectTdClass" style="text-align:right;font-weight:bold; " >
                合计
            </td>
            <td colspan="1" style="text-align:left;font-weight:bold;padding-left: 12px; " class="selectTdClass">
            	<fmt:formatNumber value="${orderContractExpenses.ajsxf+orderContractExpenses.advanceTotalPrice+orderContractExpenses.otherFeePrice+orderContractExpenses.attachDecoreMoney}" pattern="￥###,###.00"></fmt:formatNumber>
            </td>
            <td colspan="4" style="border-left:none" class="selectTdClass">
            </td>
        </tr>
 		<c:if test="${!empty(orderContract.additionalNote)}">
	        <tr>
			 	<td style="border: 0" colspan="5" height="60">
						<p style="font-size: 16px;">备注：${orderContract.additionalNote }</p>
				</td>
			</tr>
 		</c:if>
        <tr>
		 	<td style="border: 0" colspan="5" height="60">
		 		<c:if test="${orderContractExpenses.buyCarType==2}">
					<p style="font-size: 16px;font-weight: bold;">特别约定：贷款金额以贷款公司审批为准，如因客户自身原因或资料造假等造成本公司损失由客户承担</p>
		 		</c:if>
			</td>
		</tr>
</table>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
</div>
<table width="100%" border="0" style="border: 0px solid;line-height: 24px;margin-bottom: 20px;font-size: 16px;" class="nonlineTable" >
  <tr>
    <td style="width: 50%">
    	<div style="float: left;">需&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方：</div>
    	<div style="border-bottom: 1px solid #000000;width: 300px;float: left;margin-top: -12px;">&nbsp;&nbsp;</div>
    	<div style="clear: both;"></div>
    </td>
    <td style="width: 50%">供&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方：
    	${customer.enterprise.allName }
    </td>
  </tr>
  <tr>
    <td style="width: 50%">
    	<div style="float: left;">需方代表：</div>
    	<div style="border-bottom: 1px solid #000000;width: 300px;float: left;margin-top: -12px;">&nbsp;&nbsp;${orderContract.needRepresentative }</div>
    	<div style="clear: both;"></div>	
    </td>
    <td style="width: 50%">
    	<div style="float: left;">销售代表：</div>
    	<div style="border-bottom: 1px solid #000000;width: 120px;float: left;margin-top: -12px;">&nbsp;&nbsp;${orderContract.salesRepresentative }</div>
   		<div style="float: left;">展厅经理：</div>
   		<div style="border-bottom: 1px solid #000000;width: 120px;float: left;margin-top: -12px;">&nbsp;&nbsp;${orderContract.showRoomManager }</div>
   		<div style="clear: both;"></div>
   	</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;
    	<div style="border-bottom: 1px solid #000000;width: 220px;float: right ;margin-right: 80px;margin-top: -12px;">&nbsp;&nbsp;</div>
    	<div style="float: right;">日期：</div>
    </td>
  </tr>
</table>
<script type="text/javascript">
$().ready(function() {
	$("#totalMoneyL").text(atoc("${orderContract.totalPrice}"))
})
</script>
<script type="text/javascript">
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
</script>
</body>
</html>

