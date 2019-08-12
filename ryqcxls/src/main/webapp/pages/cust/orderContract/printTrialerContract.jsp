<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.enterprise.allName }购车合同书打印</title>
<link rel="stylesheet" href="${ctx }/css/print.css?2" />
<style type="text/css" media="print">
.bar {
	display: none;
}
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
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
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
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>

<c:set var="customer"  value="${orderContract.customer }" ></c:set>
<c:set var="enterprise"  value="${customer.enterprise}" ></c:set>
<div style="width: 85%;margin: 0px auto;font-size: 16px;line-height: 200%;">
<br></br>
<br></br>
<table width="99%"  cellpadding="0" cellspacing="0" style="margin-top: 12px;border: 0px;">
  <tr>
    <td colspan="8" align="right" style="padding-right: 150px;border: 0 ;line-height: 30px;" >&nbsp;合同编号：<span style="font-weight: bold;">${orderContract.customer.sn }</span></td>
  </tr>
  <tr>
  	<td colspan="8" align="right" style="border: 0 ;line-height: 30px;">
  		<div style="margin:0px auto;text-align: center;padding: 20px 0px;text-decoration: 20px;">
			<h2>购&#12288;&#12288;车&#12288;&#12288;合&#12288;&#12288;同</h2>
		</div>
  	</td>
  </tr>
  <tr>
    <td style="border: 0;width: 50%" colspan="4">甲方（供方）：
    	<span  style="border-bottom: 1px solid #000000;">
    		${customer.enterprise.allName }
	    	<c:forEach begin="${fn:length(customer.enterprise.allName)}" end="12">
	    		&#12288;
	    	</c:forEach>
	    	&nbsp;
    	</span>
    </td>
    <td style="border: 0;width: 50% " colspan="4">乙方：（需方）：&nbsp;
	   <span  style="border-bottom: 1px solid #000000;">&#12288;
	    	${orderContract.name }
	    	<c:forEach begin="${fn:length(orderContract.name)}" end="10">
	    		&#12288;
	    	</c:forEach>
	    </span>
    </td>
  </tr>
  <tr>
    <td style="border: 0;width: 50% "colspan="4" >购车人身份证号码：
    	<span  style="border-bottom: 1px solid #000000;">
    		${orderContract.icard }
    		<c:forEach begin="${fn:length(customer.enterprise.allName)/2}" end="4">
	    		&#12288;
	    	</c:forEach>
    	</span>
    </td>
    <td  style="border: 0;width: 50%" colspan="4">联系电话：
    	<span  style="border-bottom: 1px solid #000000;">
    		&#12288;${customer.mobilePhone }&#12288;&#12288;
    		<c:forEach begin="${fn:length(customer.mobilePhone)/2}" end="10">
	    		&#12288;
	    	</c:forEach>
	    	&nbsp; 	&nbsp;
    	</span>
    </td>
  </tr>
  <tr>
    <td  style="border: 0 " colspan="8">
    	地址：&nbsp;
    	<span  style="border-bottom: 1px solid #000000;">
    		${orderContract.address }
	    	<c:forEach begin="${fn:length(orderContract.address)}" end="17">
	    		&#12288;
	    	</c:forEach>
	    	&nbsp;
	    </span>
    </td>
  </tr>
 <tr>
 	<td colspan="8" style="border: 0;">
 		<p style="line-height: 32px;color: #000000;padding-left: -12px;">甲、乙供需方根据《中华人民共和国合同法》有关规定，经协商一致，特签订本合同：</p>
 	</td>
 </tr>
 <tr>
 	<td colspan="8" style="border: 0;">
 		<p style="line-height: 32px;color: #000000;padding-left: -12px;">一、购车方式：
 		<span  style="border-bottom: 1px solid #000000;">
 			<c:if test="${orderContractExpenses.buyCarType==1 }">
 				全款
 			</c:if>
 			<c:if test="${orderContractExpenses.buyCarType==2 }">
 				分期
 			</c:if>
 			<c:forEach begin="2" end="11">
	    		&#12288;
	    	</c:forEach>
	    	&nbsp;
	    </span></p>
 	</td>
 </tr>
 <tr>
 	<td colspan="8" style="border: 0;">
 		<p style="line-height: 32px;color: #000000;padding-left: -12px;">二、乙方所需车辆车型的具体情况如下：</p>
 	</td>
 </tr>
  <tr>
    <th style="width: 180px;text-align: center;" width="150" colspan="2">车型</th>
    <th style="width: 60px;text-align: center;" width="60" colspan="2">数量（台）</th>
    <th style="width: 120px;text-align: center;" width="120" colspan="2">价格</th>
    <th  style="width: 220px;text-align: center;" colspan="2">主要配置</th>
  </tr>
  <c:forEach var="orderContractProduct" items="${orderContractProducts }" varStatus="i">
	  <tr>
	    <td colspan="2">&nbsp;${orderContractProduct.carseriy.brand.name }&nbsp;&nbsp;${orderContractProduct.carseriy.name }&nbsp;&nbsp;</td>
	    <td colspan="2" style="text-align: center;">&nbsp;${orderContractProduct.num }</td>
	    <td colspan="2">&nbsp;
	    	<c:if test="${orderContractExpenses.specialPermPrice>0 }" var="status">
		    	${orderContractExpenses.carActurePrice-orderContractExpenses.specialPermPrice }
	    	</c:if>
	    	<c:if test="${status==false }">
		    	${orderContractExpenses.carActurePrice }
	    	</c:if>
	    </td>
	    <td colspan="2">&nbsp;
	    	${orderContractProduct.carModel.name }&nbsp;&nbsp;
	    	颜色：${orderContractProduct.carColor.name }
	    </td>
	  </tr>
	  <c:if test="${!empty(custCartrialer) }">
		   <tr>
		    <td colspan="2">${custCartrialer.brand.name } ${custCartrialer.carSeriy.name }</td>
		    <td colspan="2" style="text-align: center;">1</td>
		    <td colspan="2">${orderContractExpenses.trailerPrice }</td>
		    <td colspan="2">&nbsp;
		    	${custCartrialer.carModel.name }&nbsp;&nbsp;
		    	颜色：${custCartrialer.carColor.name }
		    </td>
		  </tr>
	  </c:if>
	  <c:if test="${empty(custCartrialer) }">
	  <tr>
	    <td colspan="2"></td>
	    <td colspan="2"></td>
	    <td colspan="2"></td>
	    <td colspan="2">&nbsp;
	    </td>
	  </tr>
	  </c:if>
  </c:forEach>
</table>
<div style="color: #000000;;margin-top: 12px;">
<p>三、结算方式：</p>
<div >
	<div style="float: left;text-align: 28px;margin-left: 28px;">乙方于
		<span  style="border-bottom: 1px solid #000000;">
			<fmt:formatDate value="${now}" pattern="  yyyy 年 MM 月 dd 日"/>
		</span>
		向甲方交纳购车定金（大写）：
		<span  style="border-bottom: 1px solid #000000;" >&nbsp;&nbsp;${orderContract.bigOrderMoney }</span>
		（以甲方出据的收据为准）。
	</div>
	<div style="clear: both;"></div>
</div>
<p>四、交车地点：<span style="border-bottom: 1px solid #000000;">${orderContract.handerOverCarDate }<c:forEach begin="0" end="40">&#12288;</c:forEach></span></p>
<c:if test="${fn:length(orderContract.note)>50 }">
	<p>五、合同备注：<span style="border-bottom: 1px solid #000000;">${orderContract.note }</span></p>
</c:if>
<c:if test="${fn:length(orderContract.note)<=50 }">
	<p>五、合同备注：<span style="border-bottom: 1px solid #000000;">${orderContract.note }<c:forEach begin="${fn:length(orderContract.note) }" end="40">&#12288;</c:forEach></span></p>
</c:if>
<p>六、违约责任：</p>
<p style="text-indent: 24px;">1、如乙方中途退车，所付定金甲方不予退还。</p>
<p style="text-indent: 24px;">2、车辆到货后，甲方应即时通知乙方，乙方接到甲方的通知后、必须在五个工作日内到甲方验车、提车，如乙方不按时验车、提车，甲方视乙方自动放弃购车，乙方交纳的购车定金甲方不予退还，甲方有权对该车辆另行销售。乙方当场验收车辆后，本合同履行完毕。</p>
<p style="text-indent: 24px;">3、如遇厂家价格调整，根据当时情况而定。</p>
<p>七、其他条款：</p>
<p style="text-indent: 24px;">乙方定车后，如以消费信贷分期付款方式购车，甲、乙双方按另行签订的《消费信贷分期付款买卖汽车合同》履行。</p>
<p>八、甲乙双方因履行本合同发生纠纷商定不成时，双方均可同意在甲方所在地人民法院提起诉讼。</p>
<p>九、本合同一式两份，甲乙双方各执一份，由甲乙双方签字、盖章（或按手印）之日起生效。</p>
</div>
<table width="100%" border="0" style="border: 0px solid;line-height: 24px;margin-bottom: 20px" class="nonlineTable" >
  <tr>
    <td style="width: 50%">甲方（供方）：
    	${customer.enterprise.allName }
    </td>
    <td style="width: 50%">
    	<div style="float: left;">乙方：</div>
    </td>
  </tr>
  <tr>
    <td style="width: 50%">
    	<p style="line-height: 30px;">销售代表：${orderContract.salesRepresentative }</p>
    	<p style="line-height: 30px;">内&#12288;&#12288;勤：</p>
   		<p style="line-height: 30px;">展厅经理：${orderContract.showRoomManager }</p>
   	</td>
    <td style="width: 50%">
    	<p style="line-height: 30px;"> &#12288;</p>
    	<p style="line-height: 30px;">&#12288;</p>
   		<p style="line-height: 30px;">日期：</p>
    </td>
  </tr>
  <c:set value="${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney }" var="bigMoney"></c:set>
</table>
</div>
<script type="text/javascript">
$().ready(function() {
	$("#totalMoneyL").text(atoc("${bigMoney}"));
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

