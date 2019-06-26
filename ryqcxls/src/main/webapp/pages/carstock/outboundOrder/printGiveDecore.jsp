<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/print.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
body{
	font-family:微软雅黑;
	font-size: 13px;
}

table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height: 20px;
    padding-left: 2px;
    height: 24px;
    padding-right: 5px;
    width: auto;
}
.noneLine{
}
.noneLine td{
border: 0;
}
</style>
<style type="text/css" media="print">
.bar {
	display: none;
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
<title>随同销售赠送货物清单</title>
</head>
<body class="bodycolor">
<div class="bar">
		<c:if test="${param.view==1}">
			<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		</c:if>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(-1)" class="but butCancle" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> 
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;&nbsp;&nbsp;回</a> 
</div>

<div class="line"></div>
	<div class="frmContent">
		<table cellpadding="0" cellspacing="0" width="1080">
		    <colgroup>
		        <col width="120" style=";width:120px"/>
		        <col width="60" style=";width:60px"/>
		        <col width="200" style=";width:200px"/>
		        <col width="180" style=";width:180px"/>
		        <col width="90" style=";width:80px"/>
		        <col width="100" style=";width:100px"/>
		        <col width="80" style=";width:80px"/>
		        <col width="80" style=";width:80px"/>
		        <col width="70" style=";width:70px"/>
		        <col width="50" style=";width:50px"/>
		        <col width="50" style=";width:50px"/>
		    </colgroup>
		    <tbody>
		        <tr height="29" style=";height:29px" class="noneLine">
		            <td height="29" colspan="3" width="65">
		                附件：
		            </td>
		            <td width="96" style=""></td>
		            <td width="80" style=""></td>
		            <td width="64" style=""></td>
		            <td width="85" style=""></td>
		            <td width="76" style=""></td>
		            <td width="71" style=""></td>
		            <td width="51" style="">
		                No：
		            </td>
		            <td width="60" style="">
		                ${outboundOrder.no}
		            </td>
		        </tr>
		        <tr height="17" style=";height:17px">
		            <td colspan="11" height="28" align="center" style="border: 0;height:48px;font-size: 18px;">
		                随同销售赠送货物清单
		            </td>
		        </tr>
		        <tr height="20" style=";height:20px" class="noneLine">
		            <td colspan="3" height="20">
		                购买方名称：
		            </td>
		            <td colspan="3">
		              ${customer.name }
		            </td>
		            <td colspan="4">
		                ${customer.mobilePhone }
		            </td>
		            <td style="padding-right: 12px;">
		                ${factoryOrder.vinCode}
		            </td>
		        </tr>
		        <tr height="21" style=";height:21px" class="noneLine">
		            <td colspan="3" height="21">
		                销售方名称：
		            </td>
		            <td colspan="8" align="center">
		                ${customer.enterprise.allName }
		            </td>
		        </tr>
		        <tr height="26" style=";height:26px" class="noneLine">
		            <td height="26" colspan="3">
		                发票代码：&nbsp;&nbsp;
		            </td>
		            <td colspan="3">
		                ${outboundOrder.faPiaoDaiMa }
		            </td>
		            <td>
		                号码：
		            </td>
		            <td colspan="2">
		                ${outboundOrder.faPiaoHao }
		            </td>
		            <td></td>
		            <td></td>
		        </tr>
		        <tr height="24" style=";height:24px" class="noneLine">
		            <td height="24"></td>
		            <td></td>
		            <td></td>
		            <td></td>
		            <td>
		                共
		            </td>
		            <td>
		                1
		            </td>
		            <td>
		                页
		            </td>
		            <td>
		                页
		            </td>
		            <td>
		                第
		            </td>
		            <td>
		                1
		            </td>
		            <td>
		                页
		            </td>
		        </tr>
		        <tr height="21" style=";height:21px">
		            <td rowspan="14" height="255" width="31" align="center">
		                装饰项目
		            </td>
		            <td style="" align="center" width="35">
		                序号
		            </td>
		            <td style="" align="center">
		                货物名称
		            </td>
		            <td style="" align="center">
		                规格型号
		            </td>
		            <td style="" align="center">
		                单位
		            </td>
		            <td style="" align="center">
		                数量
		            </td>
		            <td style="" align="center">
		                单价
		            </td>
		            <td align="center">
		                金额
		            </td>
		            <td align="center">
		                税率
		            </td>
		            <td colspan="2" style="" align="center">
		                税额
		            </td>
		        </tr>
		        <c:set var="totalMoney" value="0"></c:set>
	        	<c:set var="totalShuiMoney" value="0"></c:set>
	        	<c:set var="totalShuiLvMoney" value="0"></c:set>
		        <c:if test="${empty(orderContractDecoreItems)||fn:length(orderContractDecoreItems)<=0 }" var="status">
	        	<c:forEach var="i" begin="1" end="12">	
	        		 <tr height="18" style=";height:18px">
				            <td height="18" style="border-top-style: none; ">
				                ${i }
				            </td>
				            <td style="border-top:none;">
				                0
				            </td>
				            <td style="border-top:none;"></td>
				            <td style="border-top:none;"></td>
				            <td style="border-top:none;"></td>
				            <td style="border-top:none;">
				                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
				            </td>
				            <td style="border-top:none">
				                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; -&nbsp;&nbsp;
				            </td>
				            <td align="right" style="border-top:none;">
				                17%
				            </td>
				            <td colspan="2" style="">
				                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
				            </td>
				        </tr>
        		</c:forEach>
	        </c:if>
	        <c:if test="${status==false }">
	        	<c:forEach var="orderContractDecoreItem" items="${orderContractDecoreItems }" varStatus="in">
	       			<tr height="16" style=";height:16px">
			            <td height="16" align="center" style="border-top-style: none; border-left-style: none;">
			                ${in.index+1 }
			            </td>
		            	<td style="border-top:none;">
			                ${orderContractDecoreItem.itemName }
			            </td>
			            <td style="border-top:none;">
			            	${orderContractDecoreItem.product.sn }
			            </td>
			            <td style="border-top:none;">
			            	${orderContractDecoreItem.product.unit }
			            </td>
			            <td align="center" style="border-top:none;">
			            	${orderContractDecoreItem.quality }
			            </td>
			            <td align="center" style="border-top:none;">
			               <fmt:formatNumber value="${orderContractDecoreItem.product.price }" pattern="#.00"></fmt:formatNumber>
			            </td>
			            <td align="center" style="border-top:none">
			            	<fmt:formatNumber value="${orderContractDecoreItem.product.price*orderContractDecoreItem.quality*0.8547 }" pattern="#.00"></fmt:formatNumber>
			            	<fmt:formatNumber var="shuiTotal" value="${orderContractDecoreItem.product.price*orderContractDecoreItem.quality*0.8547 }" pattern="#.00"></fmt:formatNumber>
			            	<c:set value="${orderContractDecoreItem.product.price*orderContractDecoreItem.quality+totalMoney }" var="totalMoney"></c:set>
			            	<c:set value="${shuiTotal+totalShuiMoney }" var="totalShuiMoney"></c:set>
			            </td>
			            <td align="right" style="border-top:none;">
			                17%
			            </td>
			            <td colspan="2" style="" align="right">
			                 <fmt:formatNumber  value="${orderContractDecoreItem.product.price*orderContractDecoreItem.quality*0.8547*0.17 }" pattern="#.00"></fmt:formatNumber>
			                 <fmt:formatNumber var="slTotal" value="${orderContractDecoreItem.product.price*orderContractDecoreItem.quality*0.8547*0.17 }" pattern="#.00"></fmt:formatNumber>
			                 <c:set var="totalShuiLvMoney" value="${slTotal+totalShuiLvMoney }"></c:set> 
			            </td>
			        </tr>
			        <c:set value="${ in.index+1 }" var="itemLength"></c:set>
	       		</c:forEach>
	        </c:if>
	        <c:if test="${itemLength<12 }">
	        	<c:forEach var="i" begin="${itemLength+1 }" end="12">
	       			<tr height="18" style=";height:18px">
			            <td align="center" height="18" style="border-top-style: none; ">
			                ${i }
			            </td>
			            <td style="border-top:none;">
			                0
			            </td>
			            <td style="border-top:none;"></td>
			            <td style="border-top:none;"></td>
			            <td style="border-top:none;"></td>
			            <td style="border-top:none;">
			                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
			            </td>
			            <td style="border-top:none">
			                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; -&nbsp;&nbsp;
			            </td>
			            <td align="right" style="border-top:none;">
			                17%
			            </td>
			            <td colspan="2" style="">
			                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
			            </td>
			        </tr>
	       		</c:forEach>
	        </c:if>
	     <tr height="18" style=";height:18px">
            <td align="center" height="18" style="border-top-style: none; ">
                合计
            </td>
            <td style="border-top:none;">
            </td>
            <td style="border-top:none;"></td>
            <td style="border-top:none;"></td>
            <td style="border-top:none;"></td>
            <td align="center" style="border-top:none;">
            	<fmt:formatNumber value="${ totalMoney}" pattern="0.00"></fmt:formatNumber>
            </td>
            <td align="center" style="border-top:none">
                <fmt:formatNumber value="${ totalShuiMoney}" pattern="0.00"></fmt:formatNumber>
            </td>
            <td style="border-top:none;">
            </td>
            <td align="right" colspan="2" style="">
                <fmt:formatNumber value="${ totalShuiLvMoney}" pattern="0.00"></fmt:formatNumber>
            </td>
        </tr>
        <tr height="28" style=";height:28px" class="noneLine">
            <td height="28"></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td colspan="2">
                填开日期：
            </td>
            <td colspan="4">
               <fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> 
            </td>
        </tr>
        <tr height="33" style=";height:33px" class="noneLine">
            <td colspan="11" height="33">
                注：本清单一式两联：第一联，销售方留存；第二联，购买方留存
            </td>
        </tr>
    </tbody>
</table>
<p>
    <br/>
</p>	
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelId").remove();
	$("#carSeriyId").remove();
	$.post("${ctx}/carSeriy/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	$("#carColorLable").children().remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
	$.post("${ctx}/carColor/ajaxCarColor?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColorLable").append(data);
		}
	});
}
</script>
</html>