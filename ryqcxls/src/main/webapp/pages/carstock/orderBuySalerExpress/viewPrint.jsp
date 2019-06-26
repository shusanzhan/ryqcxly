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
}
.noneLine{
}
.noneLine td{
border: 0;
}
#lineSpache{
	height: 12px;
}
#lineSpache td{
	height: 12px;
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
<title>打印出库单</title>
</head>
<body class="bodycolor">
<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;&nbsp;&nbsp;回</a> 
</div>
	<div class="frmContent">
	<table cellpadding="0" cellspacing="0" width="100%">
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
    </colgroup>
    <tbody>
       <tr height="40" style=";">
	            <td colspan="9" height="28" align="center" style="border: 0;height:48px;font-size: 28px;font-weight: bold;">
	                经销商买卖结算单
	            </td>
        </tr>
        <tr height="20" style=";height:28px;" class="noneLine">
            <td colspan="2" height="24" width="41" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                时间：
            </td>
            <td colspan="3" width="176" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
               <fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> 
            </td>
            <td colspan="1"  align="right" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                No：
            </td>
            <td colspan="3" width="60"  style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                <c:if test="${empty(orderBuySalerExpress.expressNo) }">
                	未生成单号
                </c:if>
                <c:if test="${!empty(orderBuySalerExpress.expressNo) }">
                	${orderBuySalerExpress.expressNo }
                </c:if>
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" colspan="4" class="selectTdClass">
                收款方:
               ${orderBuySaler.saleCompnay.name }
            </td>
            <td  colspan="5" style="border-left:none" class="selectTdClass">
                付款方:
                ${orderBuySaler.buyCompany.name }
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                品牌
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
               ${factoryOrder.brand.name }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                系列
            </td>
            <td   colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${factoryOrder.carSeriy.introduction }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                车型
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${factoryOrder.carModel.name }${customer.carModelStr}
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                颜色
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
                 ${factoryOrder.carColor.name }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                执行价
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                <fmt:formatNumber value="${factoryOrder.marketPrice }" pattern="###,###.00#"></fmt:formatNumber> 
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                底盘号
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                 ${factoryOrder.vinCode }
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                车辆性质
            </td>
            <td colspan="2" colspan="2" style="border-left:none" class="selectTdClass">
                <c:if test="${factoryOrder.orderAttr=='自有资金' }">
	                ${factoryOrder.orderAttr} 
            	</c:if>
            	<c:if test="${factoryOrder.orderAttr=='金融贷款' }">
	                ${factoryOrder.orderAttr}
            	</c:if>
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                入库日期
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                 <fmt:formatDate value="${factoryOrder.carReceiving.stockInDate}" pattern="yyyy/MM/dd"/> 
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                库存等级
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${factoryOrder.storeAgeLevel.name }
            </td>
        </tr>
        <tr height="24" style=";height:24px">
            <td style="border-top-style: none;" class="selectTdClass">
                车辆管理公司
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${factoryOrder.carReceiving.storeCompany.name}
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                惠民政策
            </td>
            <td colspan="5" style="border-top:none;border-left:none" class="selectTdClass">
                 ${factoryOrder.huimin }
            </td>
        </tr>
        <tr height="14" style=";height:15px" id="lineSpache">
            <td colspan="9" height="15" class="selectTdClass"></td>
        </tr>
        <tr height="24" style=";height:24px">
            <td rowspan="5"  height="120" style="border-top-style: none;" class="selectTdClass">
                结算项目
            </td>
            <td align="center" style="border-top:none;border-left:none" class="selectTdClass">
                序号
            </td>
            <td align="center" colspan="2" style="border-left:none" class="selectTdClass">
                项目
            </td>
            <td align="center" colspan="2" style="border-left:none" class="selectTdClass">
                结算金额
            </td>
            <td align="center" colspan="3" style="border-left:none" class="selectTdClass">
                备注
            </td>
        </tr>
       		<tr height="24" style=";height:24px">
	            <td height="24" style="border-top-style: none; border-left-style: none;" class="selectTdClass">
	                1
	            </td>
	            <td colspan="2" style="border-left:none" class="selectTdClass">
	            	车辆
	            </td>
	            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">${orderBuySalerExpress.carStatementPrice }</td>
	            <td colspan="3" style="border-left:none" class="selectTdClass">${orderBuySalerExpress.carStatementNote }</td>
	        </tr>
       		<tr height="24" style=";height:24px">
	            <td height="24" style="border-top-style: none; border-left-style: none;" class="selectTdClass">
	                2
	            </td>
	            <td colspan="2" style="border-left:none" class="selectTdClass">
	            	装饰
	            </td>
	            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">${orderBuySalerExpress.decorePrice }</td>
	            <td colspan="3" style="border-left:none" class="selectTdClass">${orderBuySalerExpress.decoreNote }</td>
	        </tr>
       		<tr height="24" style=";height:24px">
	            <td height="24" style="border-top-style: none; border-left-style: none;" class="selectTdClass">
	                3
	            </td>
	            <td  colspan="2" style="border-left:none" class="selectTdClass">
	            	金融
	            </td>
	            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">${orderBuySalerExpress.finPrice }</td>
	            <td colspan="3" style="border-left:none" class="selectTdClass">${orderBuySalerExpress.finNote }</td>
	        </tr>
       		<tr height="24" style=";height:24px">
	            <td height="24" style="border-top-style: none; border-left-style: none;" class="selectTdClass">
	                4
	            </td>
	            <td colspan="2" style="border-left:none" class="selectTdClass">
	            	其他
	            </td>
	            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">${orderBuySalerExpress.otherPrice }</td>
	            <td colspan="3" style="border-left:none" class="selectTdClass">${orderBuySalerExpress.otherNote }</td>
	        </tr>
       
        <tr height="24" style=";height:24px">
            <td colspan="2" height="24" class="selectTdClass">
                结算总额
            </td>
            <td colspan="7" style="border-left:none" class="selectTdClass">
            	<fmt:formatNumber value="${orderBuySalerExpress.totalAmountPrice }" pattern="￥###,###.00"></fmt:formatNumber>
            </td>
        </tr>
           <tr height="35" style=";height:35px" >
            <td align="left" colspan="1">
            	备注
            </td>
            <td colspan="8">
            	${orderBuySalerExpress.note}
            </td>
          </tr>
         <tr height="35" style=";height:35px" class="noneLine">
            <td align="right" colspan="2">
            </td>
            <td align="left" colspan="2"> 制表：${sessionScope.user.realName }</td>
            <td colspan="2"></td>
            <td colspan="2">
                结算日期：${orderBuySalerExpress.statementDate }
            </td>
            <td></td>
        </tr>
    </tbody>
</table>

</div>
</body>
</html>