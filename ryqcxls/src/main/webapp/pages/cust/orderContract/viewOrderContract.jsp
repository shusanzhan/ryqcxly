<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>销售合同书</title>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
	font-size: 14px;
	padding-left: 5px;
	height: 32px;
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
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1)" class="current">定单明细</a>
</div>
<div class="line"></div>
	<div class="formButton" style="width: 100%;padding-left: 0;">
	   		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle" >返回</a>
	</div>
<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">合同基础信息</td>
			</tr>
			<tr height="40">
				<td class="formTableTdLeft">车型：</td>
				<td>
					<span style="color: red;font-size: 15px;">
						${customer.customerLastBussi.brand.name }&nbsp;&nbsp;
						${customer.customerLastBussi.carSeriy.name }
						${customer.customerLastBussi.carModel.name }
						${customer.customerLastBussi.carColor.name }${customer.carColorStr}
					</span>
				</td>
				<td class="formTableTdLeft">合同总金额：</td>
				<td>
					<span style="color: red;font-size: 18px;">${orderContractExpenses.totalPrice }</span> 
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >需方：</td>
				<td>
					${orderContract.name }
				</td>
				<td class="formTableTdLeft">联系电话：</td>
				<td>
					${orderContract.contactPhone}
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">身份证地址：</td>
				<td>
					${orderContract.address }
				</td>
				<td class="formTableTdLeft">证件类型：</td>
				<td>
					${customer.paperwork.name}
				</td>
			</tr>
			<tr height="32">
				<td>证件号码：</td>
				<td>
					${orderContract.icard }
				</td>
				<td>开票名称：</td>
				<td>
					${orderContract.bankNo }
				</td>
			</tr>
			<tr height="32">
				<td>购车定金：</td>
				<td>
					${orderContract.orderMoney }
				</td>
				<td>大写：</td>
				<td>
					${orderContract.bigOrderMoney }
				</td>
			</tr>
		
		<tr style="height: 40px;">
			<td>交货日期：</td>
			<td colspan="3">
					${orderContract.handerOverCarDate }
			</td>
		</tr>
		<tr height="32">
			<td>备注：</td>
			<td colspan="3">
				${orderContract.note }
			</td>
		</tr>
		<c:if test="${empty(orderContract) }">
			<tr height="32">
				<td>需方：</td>
				<td>
					${customer.name}
				</td>
				<td>销售代表：</td>
				<td>
					${sessionScope.user.realName}
				</td>
			</tr>
		</c:if>
		<c:if test="${!empty(orderContract) }">
			<tr height="32">
				<td>需方：</td>
				<td>
					${customer.name }
				</td>
				<td>销售代表：</td>
				<td>
					${orderContract.salesRepresentative }
				</td>
			</tr>
		</c:if>
		</table>
		<br>
       	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">车辆费用信息</td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">经销商报价：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.salePrice }
					</td>
					<td class="formTableTdLeft" >车辆顾问结算价：</td>
					<td id="carColorId">
						${orderContractExpenses.carSalerPrice }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">颜色溢价：&nbsp;</td>
					<td colspan="">
						<c:if test="${empty(orderContractExpenses.colorPrice) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.colorPrice) }">
							${orderContractExpenses.colorPrice }
						</c:if>
					</td>
					<td class="formTableTdLeft" >裸车销售价：</td>
					<td id="carColorId">
						${orderContractExpenses.carActurePrice}
					</td>
				</tr>
				<c:if test="${customer.bussiType==2 }">
					<tr height="32">
						<td class="formTableTdLeft">挂车价格：&nbsp;</td>
						<td colspan="">
							${orderContractExpenses.trailerPrice }
						</td>
						<td class="formTableTdLeft" >车辆总价：</td>
						<td id="carColorId">
							${orderContractExpenses.carTotalPrice}
						</td>
					</tr>
				</c:if>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">优惠明细</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">裸车现金优惠：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.cashBenefit }
					</td>
					<td class="formTableTdLeft" >未折让权限：</td>
					<td id="carColorId">
						${orderContractExpenses.noWllowancePrice}
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">特殊权限：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.specialPermPrice}
					</td>
					<td class="formTableTdLeft" >特殊权限说明：</td>
					<td id="carColorId">
						${orderContractExpenses.specialPermNote}
					</td>
				</tr>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">保险明细</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">预收保费：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.preInsMoney }
					</td>
					<td class="formTableTdLeft" >续保押金：</td>
					<td id="carColorId">
						${orderContractExpenses.insaranceRenewalDepositPrice}
					</td>
				</tr>
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">金融明细</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">购车方式：&nbsp;</td>
					<td >
						
						<c:if test="${orderContractExpenses.buyCarType==1 }">
							<span style="color: green;">现款</span>
						</c:if>
						<c:if test="${customer.bussiType==1}">
							<c:if test="${orderContractExpenses.buyCarType==2 }">
								<span style="color: red;">分付</span>
							</c:if>
						</c:if>
						<c:if test="${customer.bussiType==2 }">
							<c:if test="${orderContractExpenses.buyCarType==2 }">
								<span style="color: red;">分付加挂</span>
							</c:if>
							<c:if test="${orderContractExpenses.buyCarType==3 }">
								<span style="color: red;">分付裸车</span>
							</c:if>
						</c:if>
					</td>
					<td class="formTableTdLeft">付款方式：&nbsp;</td>
					<td >
						<c:if test="${orderContractExpenses.payWay==1 }">
							<span style="color: green;">现金</span>
						</c:if>
						<c:if test="${orderContractExpenses.payWay==2 }">
							<span style="color: red;">转账</span>
						</c:if>
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">手续费：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.ajsxf }
					</td>
					<td class="formTableTdLeft" >首付比例：</td>
					<td id="carColorId">
						${orderContractExpenses.paymentPer}
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">首付款：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.sfk }
					</td>
					<td class="formTableTdLeft" >贷款金额：</td>
					<td id="carColorId">
						${orderContractExpenses.daikuan}
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">贷款车价：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.loanCarPrice }
					</td>
					<td class="formTableTdLeft" >D：</td>
					<td id="carColorId">
						${orderContractExpenses.lowInvoicePrice}
					</td>
				</tr>
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">定金装饰</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">购车定金：&nbsp;</td>
					<td colspan="">
						${orderContractExpenses.orderMoney }
					</td>
					<td class="formTableTdLeft" >装饰款：</td>
					<td id="carColorId">
						${orderContractExpenses.decoreMoney}
					</td>
				</tr>
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">总费用明细</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">预收款总额：&nbsp;</td>
					<td colspan="">
						<span style="font-size: 14px;">${orderContractExpenses.advanceTotalPrice }</span>
					</td>
					<td class="formTableTdLeft" >其他收费总额：</td>
					<td >
						${orderContractExpenses.otherFeePrice } 
					</td>
				</tr>
			<tr height="32">
				<td class="formTableTdLeft">裸车销售价：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.carActurePrice }</span>
				</td>
				<td class="formTableTdLeft">车辆总价：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.carTotalPrice }</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">合同总金额：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.totalPrice }</span>
				</td>
				<td class="formTableTdLeft">实收金额：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.actureCollectedPrice }</span>
				</td>
			</tr>
			 <%-- <tr height="32">
				<td class="formTableTdLeft">整车营收：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.revenuePrice }</span>
				</td>
				<td class="formTableTdLeft" >预估整车毛利：</td>
				<td >
					<c:set value="${orderContractExpenses.revenuePrice-orderContractExpenses.carSalerPrice-orderContractDecore.salerTotalPrice }" var="carGrofitPrice"></c:set>
					<c:if test="${carGrofitPrice>0 }">
						<span style="color: red;font-size: 20px;">
							<fmt:formatNumber value="${carGrofitPrice }" pattern="###.00"></fmt:formatNumber>
						</span>
					</c:if>
					<c:if test="${carGrofitPrice<=0 }">
						<span style="color: green;font-size: 20px;">
							<fmt:formatNumber value="${carGrofitPrice }" pattern="###.00"></fmt:formatNumber>
						</span>
					</c:if>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">裸车销售价：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.carActurePrice }</span>
				</td>
				<td class="formTableTdLeft" >预估裸车毛利：</td>
				<td >
					<c:set value="${orderContractExpenses.carActurePrice-orderContractExpenses.carSalerPrice }" var="carPrice"></c:set>
					<c:if test="${carPrice>0 }">
						<span style="color: red;font-size: 20px;">
							<fmt:formatNumber value="${carPrice }" pattern="###.00"></fmt:formatNumber>
						</span>
					</c:if>
					<c:if test="${carPrice<=0 }">
						<span style="color: green;font-size: 20px;">
							<fmt:formatNumber value="${carPrice }" pattern="###.00"></fmt:formatNumber>
						</span>
					</c:if> 
				</td>
			</tr> --%> 
		</table>
		<c:if test="${fn:length(orderContractExpensesChargeItems)>0||fn:length(orderContractExpensesPreferenceItems)>0 }">
			 	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;border-top: 0px;">
				<tr>
					<td align="center" colspan="4">&#12288;预收款明细</td>
					<td  align="center" colspan="4">&#12288;其他收费明细</td>	
				</tr>
				<tr style="border-bottom: 0;">
					<td colspan="4" style="border-bottom: 0;margin: 0;padding: 0" width="50%">
						<table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-top: 0px;border-left: 0px;">
							<tr class="tabletr">
								<td align="center" style="0">序号</td>
								<td align="center">项目</td>
								<td align="center">金额</td>
								<td align="center">备注</td>
							</tr>
							<c:set value="0" var="preLength"></c:set>
							<c:forEach var="orderContractExpensesPreferenceItem" items="${orderContractExpensesPreferenceItems }" varStatus="inde">
								<tr class="tabletr">
									<td align="center" style="0">${inde.index+1 }</td>
									<td align="center">${orderContractExpensesPreferenceItem.preferenceItemName }</td>
									<td align="center">${orderContractExpensesPreferenceItem.price }</td>
									<td align="center">${orderContractExpensesPreferenceItem.note }</td>
									<c:set value="${inde.index+1 }" var="preLength"></c:set>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(orderContractExpensesPreferenceItems)<fn:length(orderContractExpensesChargeItems) }"></c:if>
							<c:forEach begin="${preLength+1 }" end="${fn:length(orderContractExpensesChargeItems) }" varStatus="i">
								<tr class="tabletr">
									<td align="center" style="0">${i.index+1 }</td>
									<td align="center"></td>
									<td align="center"></td>
									<td align="center"></td>
								</tr>
							</c:forEach>
						</table>
					</td>
					<td colspan="4" style="border-bottom: 0;margin: 0;padding: 0" width="50%" >
						<table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-top: 0px;">
							<tr class="tabletr" style="border-left: 0px;">
								<td align="center" style="0">序号</td>
								<td align="center">项目</td>
								<td align="center">金额</td>
								<td align="center" style="border-left: 0px;">备注</td>
							</tr>
							<c:set value="0" var="charLength"></c:set>
							<c:forEach var="orderContractExpensesChargeItem" items="${orderContractExpensesChargeItems }" varStatus="itemB">
								<tr class="tabletr">
									<td align="center" style="0">${itemB.index+1 }</td>
									<td align="center">${orderContractExpensesChargeItem.chargeItemName }</td>
									<td align="center">${orderContractExpensesChargeItem.price }</td>
									<td align="center">${orderContractExpensesChargeItem.note }</td>
								</tr>
								<c:set value="${itemB.index+1 }" var="charLength"></c:set>
							</c:forEach>
							<c:if test="${fn:length(orderContractExpensesPreferenceItems)>fn:length(orderContractExpensesChargeItems) }"></c:if>
							<c:forEach begin="${charLength+1 }" end="${fn:length(orderContractExpensesPreferenceItems) }" varStatus="i">
								<tr class="tabletr">
									<td align="center" style="0">${i.index}</td>
									<td align="center"></td>
									<td align="center"></td>
									<td align="center"></td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
				<tr>
						<td align="right" colspan="4" style="padding-right: 12px;">预收合计：<span style="color: red;">${orderContractExpenses.advanceTotalPrice }</span></td>
						<td align="right" colspan="4" style="padding-right: 12px;">其他收费合同:<span style="color: red;">${orderContractExpenses.otherFeePrice }</span></td>
					</tr>
			</table>
	</c:if>
	<br>
		<c:if test="${empty(orderContractDecore) }">
			<div class="alert alert-error">
				<strong>提示：</strong> 
				该客户无附加通知单！				
			</div>
		</c:if>
		<c:if test="${!empty(orderContractDecore) }">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="8" style="">附加通知单</td>
					</tr>
					<tr>
						<td align="center" colspan="4">&#12288;销售装饰项目</td>
						<td  align="center" colspan="4">&#12288;赠送装饰项目</td>	
					</tr>
					<tr style="border-bottom: 0;">
						<td colspan="4" style="border-bottom: 0;" width="50%">
							<table cellpadding="0" cellspacing="0" width="100%" border="0" >
								<tr class="tabletr">
									<td align="center" style="0">序号</td>
									<td align="center">编号</td>
									<td align="center">项目</td>
									<td align="center">单价</td>
									<td align="center">数量</td>
								</tr>
								<c:set value="0" var="zs"></c:set>	
								<c:set value="0" var="xs"></c:set>	
								<c:set value="0" var="total"></c:set>	
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==1 }">
										<c:set value="${xs+1 }" var="xs"></c:set>
									</c:if>
									<c:if test="${decoreNoticeItem.type==2 }">
										<c:set value="${zs+1 }" var="zs"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${xs>zs }" var="status">
									<c:set value="${xs }" var="total"></c:set>
								</c:if>
								<c:if test="${status==false }">
									<c:set value="${zs }" var="total"></c:set>
								</c:if>
								<c:set value="1" var="indexVar"></c:set>
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==1 }">
										<tr> 
											<td align="center">${indexVar } </td>
											<td align="center">
												${decoreNoticeItem.serNo }
											</td>
											<td align="center">
												${decoreNoticeItem.itemName }
											</td>
											<td align="left">
												${decoreNoticeItem.price }
											</td>
											<td align="left">
												${decoreNoticeItem.quality }
											</td>
										</tr>
										<c:set value="${indexVar+1 }" var="indexVar"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${xs<zs }" var="status">
									<c:forEach var="ind" begin="${xs+1 }" end="${zs }">
										<tr> 
												<td align="center">${ind } </td>
												<td align="center">
												</td>
												<td align="center">
												</td>
												<td align="left">
												</td>
												<td align="left">
												</td>
											</tr> 
									</c:forEach>
								</c:if>
							</table>
						</td>
						<td colspan="4" style="border-bottom: 0;" width="50%">
							<table cellpadding="0" cellspacing="0" width="100%" border="0" >
								<tr class="tabletr">
									<td align="center" style="">序号</td>
									<td align="center">编号</td>
									<td align="center">项目</td>
									<td align="center">单价</td>
									<td align="center">数量</td>
								</tr>	
								<c:set value="1" var="indexVar"></c:set>
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==2 }">
										<tr> 
											<td align="center">${indexVar } </td>
											<td align="center">
												${decoreNoticeItem.serNo }
											</td>
											<td align="center">
												${decoreNoticeItem.itemName }
											</td>
											<td align="left">
												${decoreNoticeItem.price }
											</td>
											<td align="left">
												${decoreNoticeItem.quality }
											</td>
										</tr>
										<c:set value="${indexVar+1 }" var="indexVar"></c:set>
									</c:if> 
									<c:set value="${i.index+1 }" var="size"></c:set>
								</c:forEach>
								<c:forEach var="ind" begin="${zs+1 }" end="${xs }">
									<tr> 
											<td align="center">${ind }</td>
											<td align="center">
											</td>
											<td align="center">
											</td>
											<td align="left">
											</td>
											<td align="left">
											</td>
										</tr> 
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center">销售装饰合计</td>
						<td colspan="3">
							${orderContractDecore.decoreSaleTotalPrce }
						</td>
						<td align="center">赠送装饰合计</td>
						<td  colspan="3">
							${orderContractDecore.giveTotalPrice }
						</td>
					</tr>
					<tr>
						<td align="center">装饰实收合计</td>
						<td colspan="3">
							${orderContractDecore.acturePrice }
						</td>
						<td align="center">折扣率</td>
						<td  colspan="3">
							${orderContractDecore.zkl }
						</td>
					</tr>
					<tr>
						<td align="center">装饰顾问结算价</td>
						<td colspan="3">
							${orderContractDecore.salerTotalPrice }
						</td>
						<td align="center">装饰毛利</td>
						<td  colspan="3">
							${orderContractDecore.salerGrofitPrice }
						</td>
					</tr>
				</table>
			</c:if>
		<br>
</div>
<script type="text/javascript">
</script>
</body>
</html>
