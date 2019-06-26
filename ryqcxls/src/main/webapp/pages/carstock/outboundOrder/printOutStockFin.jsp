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
		var no="${outboundOrder.no}";
		if(null==no||no==''){
			alert("请先点击右上角【生成出库单号】按钮");
			return false;
		}
		window.print();
		return false;
	});
});
function createNo(){
	$.post('${ctx }/outboundOrder/createNo?customerId=${customer.dbid}&dbid=${outboundOrder.dbid}&view=${param.view}&brandId=${factoryOrder.brand.dbid }',{},function (data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			alert(data[0].message);
			window.location.href = data[0].url
			// 保存数据成功时页面需跳转到列表页面
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			alert(data[0].message);
		}
		return;
	})
}
</script>
<title>打印出库单</title>
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
       <tr height="30" style=";">
	            <td colspan="9" height="28" align="center" style="border: 0;height:48px;font-size: 28px;font-weight: bold;">
	                出&nbsp; 库&nbsp; 单
	            </td>
        </tr>
        <tr height="20" style=";height:24px;" class="noneLine">
            <td colspan="2" height="24" width="41" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                出库时间：
            </td>
            <td colspan="3" width="176" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
               <fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> 
            </td>
            <td colspan="1"  align="right" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                No：
            </td>
            <td colspan="3" width="60"  style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                <c:if test="${empty(outboundOrder.no) }">
                	<a onclick="createNo()" style="color: blue;" href="javascript:void(-1)" title="生成出库单号">生成出库单号</a>
                </c:if>
                <c:if test="${!empty(outboundOrder.no) }">
                	${outboundOrder.no }
                </c:if>
            </td>
        </tr>
        <tr height="34" style=";height:34px">
            <td height="24" class="selectTdClass">
                客户姓名
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
                ${customer.name }
            </td>
            <td style="border-left:none" class="selectTdClass">
                联系电话
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
               ${customer.mobilePhone }
            </td>
            <td style="border-left:none" class="selectTdClass">
                身份证区域
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
                ${customer.area.fullName }
            </td>
        </tr>
        <tr height="34" style=";height:34px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                上户区域
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
               ${outboundOrder.shanghuArea.fullName }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                是否备案
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
               <c:if test="${outboundOrder.shifouBeian=='是' }">
            		需备案
            	</c:if>
            	<c:if test="${outboundOrder.shifouBeian=='否' }">
            		不备案
            	</c:if>
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                发票类型
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${outboundOrder.faPiaoType }
            </td>
            
        </tr>
        <tr height="34" style=";height:34px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                经销商类型
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
                  <c:if test="${empty(customer.distributor) }">
						自有店
					</c:if>
					<c:if test="${!empty(customer.distributor) }">
						${customer.distributor.shortName}
						(${customer.distributor.distributorType.name})
					</c:if>
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                提车单位
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
              ${customer.user.department.name}
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                销售权限
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
               ${outboundOrder.saleSecurity}
            </td>
        </tr>
        <tr height="34" style=";height:34px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                购车方式
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
            	<c:if test="${orderContractExpenses.buyCarType==1 }">
            		现款
            	</c:if>
            	<c:if test="${orderContractExpenses.buyCarType==2 }">
	                贷款--${ orderContractExpenses.loanType.name}
            	</c:if>
            	
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                付款方式
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
              <c:if test="${orderContractExpenses.payWay==1 }">
            		现金
            	</c:if>
            	<c:if test="${orderContractExpenses.payWay==2 }">
	                转账
            	</c:if>
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                销售顾问
            </td>
            <td  colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${customer.user.realName}
            </td>
        </tr>
        <tr height="10" style=";height:10px" id="lineSpache">
            <td colspan="9" height="10" class="selectTdClass"></td>
        </tr>
        <tr height="34" style=";height:34px">
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
        <tr height="34" style=";height:34px">
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
        <tr height="34" style=";height:34px">
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
        <tr height="34" style=";height:34px">
            <td height="24" style="border-top-style: none;" class="selectTdClass">
                单车奖励
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
                ${customerPidBookingRecord.rewardMoney }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                车辆管理公司
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${factoryOrder.carReceiving.storeCompany.name}
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
                原始进货商
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                 ${factoryOrder.sourceCompany.name }
            </td>
        </tr>
        <tr height="34" style=";height:34px">
        	 <td style="border-top:none;" class="selectTdClass">
                支付日期
            </td>
            <td colspan="4" style="border-top:none;border-left:none" class="selectTdClass">
               <fmt:formatDate value="${outboundOrder.invoiceDate }" pattern="yyyy/MM/dd"/>
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
               特殊权限
            </td>
            <td colspan="3" style="border-top:none;border-left:none" class="selectTdClass">
                ${orderContractExpenses.specialPermPrice}
            </td>
        </tr>
        <tr height="34" style=";height:34px">
        	 <td style="border-top:none;" class="selectTdClass">
                特殊权限说明
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
                ${orderContractExpenses.specialPermNote}
            </td>
            <td height="24" style="border-top-style: none;" class="selectTdClass">
              裸车现金优惠
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
              ${orderContractExpenses.cashBenefit }
            </td>
            <td style="border-top:none;border-left:none" class="selectTdClass">
               未折让权限
            </td>
            <td colspan="2" style="border-top:none;border-left:none" class="selectTdClass">
               <fmt:formatNumber value="${orderContractExpenses.noWllowancePrice }" pattern="￥###,###.00"></fmt:formatNumber>
            </td>
        </tr>
        <tr height="10" style=";height:10px" id="lineSpache">
            <td colspan="9" height="10" class="selectTdClass"></td>
        </tr>
        
        <tr height="34" style=";height:34px">
        	<td height="24" style="border-top-style: none;" class="selectTdClass">
                合同金额
            </td>
            <td colspan="2" style="border-left:none" class="selectTdClass">
               <fmt:formatNumber value="${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney }" pattern="￥###,###.00"></fmt:formatNumber>
            </td>
            <td colspan="1" height="24" class="selectTdClass">
                实收合计
            </td>
            <td colspan="5" style="border-left:none" class="selectTdClass">
            	<fmt:formatNumber value="${orderContractExpenses.carActurePrice+orderContractExpenses.masterDecoreMoney }" pattern="￥###,###.00"></fmt:formatNumber>
            </td>
        </tr>
         <tr height="35" style=";height:35px" class="noneLine">
            <td align="right" colspan="2">
            </td>
            <td align="left" colspan="2"> 制表：${outboundOrder.creator }</td>
            <td colspan="2"></td>
            <td>
                收银：
            </td>
            <td></td>
            <td></td>
        </tr>
    </tbody>
</table>

</div>
</body>
</html>