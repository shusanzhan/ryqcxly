<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.enterprise.allName }销售主合同书打印</title>
<link rel="stylesheet" href="${ctx }/css/print.css?=1" />
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
<c:if test="${!empty(param.type)&&param.type==1 }" var="status">
	<a href="javascript:;" id="print2" onclick="window.open('${ctx}/orderContract/printFjContract?dbid=${orderContract.dbid }&type=1')" class="btn btn-success " style="margin-left: 5px;">查看附件合同</a>
</c:if>
<c:if test="${ status==false}">
	<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		|
		<a href="javascript:;" id="print2" onclick="window.open('${ctx}/orderContract/printFjContract?dbid=${orderContract.dbid }')" class="btn btn-success " style="margin-left: 5px;">打印附加合同</a>
	</div>
</c:if>

<c:set var="customer"  value="${orderContract.customer }" ></c:set>
<c:set var="enterprise"  value="${customer.enterprise}" ></c:set>
<div style="width: 100%;margin: 0px auto;font-size: 16px;">
<div style="margin:0px auto;width: 600px;text-align: center;padding: 20px 0px;">
	<c:if test="${customer.enterprise.bussiType==3 }" var="status">
		<h1>${customer.enterprise.allName }汽车销售合同书</h1>
	</c:if>
	<c:if test="${status==false }">
		<h1>${customer.customerBussi.brand.name }汽车销售有限公司授权销售服务中心</h1>
		<h2>${customer.enterprise.allName }汽车销售合同书</h2>
	</c:if>
</div>
<table width="99%"  cellpadding="0" cellspacing="0" >
  <tr>
    <td colspan="8" align="right" style="padding-right: 150px;border: 0 ;line-height: 20px;" >&nbsp;合同编号：<span style="font-weight: bold;">${orderContract.customer.sn }</span></td>
  </tr>
  <tr>
    <td class="labelTitle">需方</td>
    <td style="width: 300px;" colspan="3">&nbsp;${orderContract.name }</td>
    <td class="labelTitle">供方</td>
    <td colspan="3" style="width: 300px;">&nbsp;
	    ${customer.enterprise.allName }
    </td>
  </tr>
  <tr>
    <td class="labelTitle">身份证地址</td>
    <td colspan="3">&nbsp;${orderContract.address }</td>
    <td class="labelTitle">通讯地址</td>
    <td colspan="3">&nbsp;${enterprise.address }</td>
  </tr>
  <tr>
    <td class="labelTitle">联系电话</td>
    <td colspan="3">&nbsp;${customer.mobilePhone }</td>
    <td class="labelTitle">联系电话</td>
    <td colspan="3">&nbsp;${enterprise.phone }</td>
  </tr>
  <tr>
    <td class="labelTitle">证件类型</td>
    <td colspan="3">&nbsp;${customer.paperwork.name}</td>
    <td class="labelTitle">邮政编码</td>
    <td colspan="3">&nbsp;${enterprise.zipCode }</td>
  </tr>
  <tr>
    <td class="labelTitle">身份证号</td>
    <td colspan="3">&nbsp;${orderContract.icard }</td>
    <td class="labelTitle">开户银行</td>
    <td colspan="3">&nbsp;${enterprise.bank }</td>
  </tr>
  <tr>
    <td class="labelTitle">开票名称</td>
    <td colspan="3">&nbsp;${orderContract.bankNo }</td>
    <td class="labelTitle">银行账号</td>
    <td colspan="3">&nbsp;${enterprise.account }</td>
  </tr>
 <tr>
 	<td colspan="7" style="border: 0;">
 		<p style="line-height: 32px;color: #000000;padding-left: -12px;">1、供需方根据中华人民共和国《合同法》及相关法律、法规达成以下协议：</p>
 	</td>
 </tr>
  <tr>
    <th style="width: 120px;text-align: center;">项目</th>
    <th style="width: 150px;text-align: center;" width="150">产品系列</th>
    <th style="width: 150px;text-align: center;" width="150">车型代码</th>
    <th style="width: 150px;text-align: center;" width="150">油漆颜色</th>
    <th style="width: 120px;text-align: center;" width="120">实收合计（人民币：元）</th>
    <th style="width: 60px;text-align: center;" width="60">数量（台）</th>
    <th colspan="2" style="width: 200px;text-align: center;" width="300">备注</th>
  </tr>
  <c:if test="${customer.enterprise.bussiType==3 }" var="status">
  	<c:forEach var="orderContractProduct" items="${orderContractProducts }" varStatus="i">
		  <tr>
		  	 <th>明细</th>
		    <td>&nbsp;${customer.carModelStr}</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;${customer.carColorStr }</td>
		    <td>&nbsp;${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney }</td>
		    <td>&nbsp;${orderContractProduct.num }</td>
		    <td colspan="2" >&nbsp;${orderContractProduct.note }
		    	<c:if test="${orderContract.isShowNote==true }">
		   			车型颜色不换,定金不退只用于冲抵车款	
		   		</c:if>
		    </td>
		  </tr>
	  </c:forEach>
  </c:if>
  <c:if test="${status==false }">
	  <c:forEach var="orderContractProduct" items="${orderContractProducts }" varStatus="i">
		  <tr>
		   <th>明细</th>
		    <td>&nbsp;${orderContractProduct.carseriy.brand.name }&nbsp;&nbsp;${orderContractProduct.carseriy.name }</td>
		    <td>&nbsp;${orderContractProduct.carModel.name }</td>
		    <td>&nbsp;${orderContractProduct.carColor.name }</td>
		    <td>&nbsp;${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney }</td>
		    <td>&nbsp;${orderContractProduct.num }</td>
		    <td colspan="2" >&nbsp;${orderContractProduct.note }
		    	<c:if test="${orderContract.isShowNote==true }">
		   			车型颜色不换,定金不退只用于冲抵车款	
		   		</c:if>
		    </td>
		  </tr>
	  </c:forEach>
  </c:if>
</table>
<div style="color: #000000;line-height: 24px;">
<div >
	<div style="float: left;">2、购车成交单价金额大写：<span id="totalMoneyL" style="border-bottom: 1px solid #000000;"></span>，买卖双方签署合同书之后，买方即付购车定金RMB：
	<span  style="border-bottom: 1px solid #000000;">&nbsp;&nbsp;${orderContract.orderMoney }</span>（大写：人民币
	<span  style="border-bottom: 1px solid #000000;" I>&nbsp;&nbsp;${orderContract.bigOrderMoney }</span>
	），以充分保证买方及时提新车。</div>
	<div style="clear: both;"></div>
</div>

<p>3、在合同期内，若${customer.customerBussi.brand.name }汽车公司发车计划调整或变动，供方有责任和义务在第一时间内通知需方，由此原因造成需方无法合同期内提车，供方承诺无条件金额退还需方定金。</p>

<p>4、质量保证：需方享受“${customer.customerBussi.brand.name }保修手册”中所规定的保养、保修及售后服务权利。上述售后服务保证由${customer.customerBussi.brand.name }汽车有限公司的特约售后服务维修站按手册规定执行。</p>

<p>5、随车交付文件：产品合格证、使用说明书、保修手册、点烟器、随车工具等。</p>

<p>6、提货和验收：车辆验收应于当日于
		${customer.enterprise.allName }进行。验收完成后，供需双方共同签署验车交接单：如需方未在上述规定的期限内提车异议，则视为供方所交付的汽车完全符合本合同需要。</p>

<p><div style="float: left;">7、交货期：</div><div style="border-bottom: 1px solid #000000;margin-left: 60px; ">${ orderContract.handerOverCarDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></p>
<p>8、转让：非经另一方的事先书面许可，任何一方不得将在本合同项下的权利与义务转让或移交给其他任何第三方。</p>

<p>9、适合法律：本合同的订立、效力、解释、履行以及争议的解决均适用于中国法律。</p>

<p>10、本合同书如有未尽事宜，供需双方友好协商解决。</p>

<p>11、本合同书一式贰份，供需双方各执一份，签字盖章后生效。</p>

<p>12、供方为需方提供代办车辆上户手续（限本市）服务，所需费用由需方承担。</p>

<div>
	<div style="float: left;">13、备注：</div>
	<div style="margin-left: 60px;margin-top: -2px; "><u style="margin-bottom: 12px;padding-bottom: 12px;">&nbsp;&nbsp;&nbsp;&nbsp;${orderContract.note }&nbsp;&nbsp;&nbsp;&nbsp;</u></div>
	<div style="clear: both;"></div>
</div>

<p>特别提醒事项：</p>

<p>1、请购车客户在接到本公司销售顾问提车通知时，全款客户请务必在三个工作日内到我公司办理提车手续。若在上述期限内未能办理提车手续的，我们将很抱歉的取消你的优先认购权；</p>

<p>2、客户交款必须以我公司（
		${customer.enterprise.allName }
）收据或发票作为凭证依据，并进行相关手续办理；</p>

<p>3、此协议合同由销售顾问、销售经理签字并加盖公司销售专用章，该协议合同予以生效。</p>
</div>
<table width="100%" border="0" style="border: 0px solid;line-height: 24px;margin-bottom: 20px" class="nonlineTable" >
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
   		<div style="float: left;">销售经理：</div>
   		<div style="border-bottom: 1px solid #000000;width: 120px;float: left;margin-top: -12px;">&nbsp;&nbsp;${processFrom.taskUserName }</div>
   		<div style="clear: both;"></div>
   	</td>
  </tr>
  <tr>
    <td colspan="2">&nbsp;
    	<div style="border-bottom: 1px solid #000000;width: 220px;float: right ;margin-right: 80px;margin-top: -12px;">&nbsp;&nbsp;</div>
    	<div style="float: right;">日期：</div>
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

