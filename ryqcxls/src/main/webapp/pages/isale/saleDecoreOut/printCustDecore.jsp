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
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		|
	<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;&nbsp;&nbsp;回</a> 
</div>
<div class="line"></div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<table cellpadding="0" cellspacing="0" width="" border="1" style="width: %;" >
		    <colgroup>
		        <col width="40" style=";width:41px"/>
		        <col width="35" style=";width:35px"/>
		        <col width="96" style=";width:96px"/>
		        <col width="80" style=";width:80px"/>
		        <col width="64" style=";width:64px"/>
		        <col width="85" style=";width:85px"/>
		        <col width="76" style=";width:76px"/>
		        <col width="71" style=";width:71px"/>
		        <col width="80" style=";width:80px"/>
		        <col width="80" style=";width:80px"/>
		        <col width="77" style=";width:77px"/>
		    </colgroup>
	    <tbody>
	    	<tr height="40" style=";">
	            <td colspan="13" height="28" align="center" style="border: 0;height:48px;font-size: 28px;font-weight: bold;">
	                装&nbsp;饰&nbsp;销&nbsp;售&nbsp;出&nbsp; 库&nbsp; 单<c:if test="${decoreOut.copyStatus==2 }">(副本)</c:if>
	            </td>
	        </tr>
	        <tr height="20" style=";height:28px;" class="noneLine">
	            <td colspan="3" height="24" width="41" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
	                出库时间：
	            </td>
	            <td colspan="5" width="176" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
	               <fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> 
	            </td>
	            <td width="80"  align="right" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
	                No：
	            </td>
	            <td colspan="3" width="60"  style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
	                ${decoreOut.outNo}
	            </td>
	        </tr>
	          <tr height="22" style=";height:22px">
	            <td colspan="1" height="22">
	                客户姓名
	            </td>
	            <td colspan="2" style="border-left:none">
	              <c:if test="${decoreOut.type==1 }">
						${customer.name }
					</c:if>
					<c:if test="${decoreOut.type==2 }">
						零售客户
					</c:if>
	            </td>
	            <td style="border-top:none;border-left:none">
	               	车牌号
	            </td>
	            <td colspan="2" width="181" style="border-left-style: none;">
	                ${decoreOut.carPlateNo }
	            </td>
	            <td colspan="" height="22">
	                电话
	            </td>
	            <td colspan="1" style="border-left:none">
	              <c:if test="${decoreOut.type==1 }">
						${customer.mobilePhone }
					</c:if>
					<c:if test="${decoreOut.type==2 }">
						无
					</c:if>
	            </td>
	            <td colspan="" height="22">
	                车架号
	            </td>
	            <td colspan="2" style="border-left:none">
	              ${customer.customerPidBookingRecord.vinCode }
	            </td>
	        </tr>
	          <tr height="22" style=";height:22px">
	            <td style="border-top:none;">
	               	销售顾问
	            </td>
	            <td colspan="2" width="181" style="border-left-style: none;">
	                ${decoreOut.saler }
	            </td>
	            <td style="border-top:none;">
	             	销售部门
	            </td>
	            <td colspan="2" width="181" style="border-left-style: none;">
	                  ${customer.successDepartment.name }
	            </td>
	            <td style="border-top:none;">
	               	车型
	            </td>
	            <td colspan="4" width="181" style="border-left-style: none;">
	                ${customer.customerPidBookingRecord.brand.name }
	                ${customer.customerPidBookingRecord.carSeriy.name }
	                ${customer.customerPidBookingRecord.carModel.name }
	                ${customer.customerPidBookingRecord.carColor.name }
	            </td>
	        </tr>
	        <tr height="21" style=";height:21px" class="firstRow">
	         <c:if test="${empty(orderContractDecoreItems)||fn:length(orderContractDecoreItems)<=0 }" var="status">
	            <td rowspan="16" height="265" width="31">
	                装饰项目
	            </td>
            </c:if>
            <c:if test="${status==false }">
            	<c:if test="${fn:length(orderContractDecoreItems)<15 }">
            		<td rowspan="16" height="265" width="31">
	               		装饰项目
	            	</td>
            	</c:if>
            	<c:if test="${fn:length(orderContractDecoreItems)>=15 }">
            		<td rowspan="${fn:length(orderContractDecoreItems)+2}" height="265" width="31">
	               		装饰项目
	            	</td>
            	</c:if>
            </c:if>
            <td align="center" width="35" style="border-left-style: none;">
                序号
            </td>
            <td align="center" colspan="2" width="96" style="border-left-style: none;">
                编号
            </td>
            <td align="center" colspan="2" width="80" style="border-left-style: none;">
                项目
            </td>
            <td align="center" width="85" style="border-left-style: none;">
                数量
            </td>
            <td align="center" width="64" style="border-left-style: none;">
                价格
            </td>
            <td align="center" colspan="3" width="76" style="border-left-style: none;">
                金额
            </td>
        </tr>
        <c:if test="${empty(decoreOutProducts)||fn:length(decoreOutProducts)<=0 }" var="status">
       		<c:forEach var="i" begin="1" end="14">
       			<tr height="16" style=";height:16px">
		            <td align="center" height="16" style="border-top-style: none; border-left-style: none;">
		                ${i }
		            </td>
		            <td colspan="2" style="border-top:none;border-left:none"></td>
		            <td colspan="2" style="border-top:none;border-left:none"></td>
		            <td colspan="1" style="border-top:none;border-left:none"></td>
		            <td style="border-top:none;border-left:none"></td>
		            <td colspan="3" style="border-left:none">
		                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
		            </td>
		        </tr>
       		</c:forEach>
       	</c:if>
        <c:if test="${status==false }">
        	<c:forEach var="decoreOutProduct" items="${decoreOutProducts }" varStatus="in">
       			<tr height="16" style=";height:16px">
		            <td height="16" align="center" style="border-top-style: none; border-left-style: none;">
		                ${in.index+1 }
		            </td>
		            <td colspan="2" style="border-top:none;border-left:none">
		            	${decoreOutProduct.product.sn }
		            </td>
		            <td colspan="2" style="border-top:none;border-left:none">
		            	${decoreOutProduct.product.name }
		            </td>
		             <td align="center"  style="border-top:none;border-left:none">
		           		 ${decoreOutProduct.num }
		            </td>
		            <td align="right" style="border-top:none;border-left:none">
		            	<fmt:formatNumber value="${decoreOutProduct.price }" pattern="#.00"></fmt:formatNumber> 
		            </td>
		            <td align="right" colspan="3" style="border-left:none">
		                <fmt:formatNumber value="${decoreOutProduct.num*decoreOutProduct.price }" pattern="#.00"></fmt:formatNumber>  
		            </td>
		        </tr>
		        <c:set value="${ in.index+1 }" var="itemLength"></c:set>
       		</c:forEach>
        </c:if>
        <c:if test="${itemLength<14 }">
        	<c:forEach var="i" begin="${itemLength+1 }" end="14">
       			<tr height="16" style=";height:16px">
		            <td align="center" height="16" style="border-top-style: none; border-left-style: none;">
		                ${i }
		            </td>
		            <td colspan="2" style="border-top:none;border-left:none">&nbsp;</td>
		            <td colspan="2" style="border-top:none;border-left:none">&nbsp;</td>
		            <td style="border-top:none;border-left:none">&nbsp;</td>
		            <td style="border-top:none;border-left:none">&nbsp;</td>
		            <td colspan="3" style="border-left:none">
		                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;
		            </td>
		        </tr>
       		</c:forEach>
        </c:if>
        <tr height="16" style=";height:16px">
            <td  colspan="7" align="right" height="16" style="border-top-style: none; border-left-style: none;">
            合计:
            </td>
            <td colspan="4" style="border-left:none">
                ${decoreOut.decoreSaleTotalPrce }
            </td>
        </tr>
			<tr height="32" style=";height:32px">
	            <td align="right" colspan="2" height="32" style="border-top-style: none;">
	                销售合计
	            </td>
	            <td colspan="2" style="border-top:none;border-left:none">
	            	${decoreOut.decoreSaleTotalPrce }
	            </td>
	            <td align="right" style="border-top:none">
	                实收合计
	            </td>
	            <td  style="border-top:none;border-left:none" colspan="2">
	            	${decoreOut.acturePrice }
	            </td>
	            <td align="right" colspan="" width="181" style="border-right-width: 1px; border-right-color: black; border-left-style: none;">
	            	折扣率
	            </td>
	            <td  colspan="3" style="border-top:none">
	               ${decoreOut.zkl }%
	            </td>
	        </tr>
        
	        <tr height="42" style=";height:42px" class="noneLine">
	            <td align="right" colspan="2">
	            </td>
	            <td align="left" colspan="5"> 制表：${decoreOut.creator }</td>
	            <td colspan="2">
	                收银：${sessionScope.user.realName }
	            </td>
	            <td></td>
	        </tr>
	    </tbody>
	</table>
	<p>
	    <br/>
	</p>		
	</form>
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