<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>销售合同书</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">

.contentTable{
	 border: 1px solid #767474;
 	border-collapse: collapse;
	border-spacing: 0px;
}
.contentTable td{
 border: 1px solid #767474;
}
.contentTable th{
 border: 1px solid #767474;
}
table { 
border-collapse:collapse; /* 关键属性：合并表格内外边框(其实表格边框有2px，外面1px，里面还有1px哦) */ 
} 
#orderDecore {
}
#orderDecore td,#orderDecore tr{
	height: 24px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">订单审核</a>
</div>
<div class="line"></div>
<c:set var="customer"  value="${orderContract.customer }" ></c:set>
<div class="formButton" style="margin-bottom: 12px;padding-left: 5px;width: 100%;">
		<c:if test="${param.type==1||param.type==4 }"> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#status').val('3');$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveApproval')"	class="but butSave">同&nbsp;&nbsp;意</a> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#status').val('2');$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveApproval')"	class="but butSave">驳&nbsp;&nbsp;回</a>
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#status').val('4');$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveApproval')"	class="but butSave">提交总经理审批</a>
		</c:if> 
		<c:if test="${param.type==2||param.type==3}"> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#status').val('6');$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveApproval')"	class="but butSave">同&nbsp;&nbsp;意</a> 
			<a href="javascript:void(-1)" id="sbmId"	onclick="$('#status').val('5');$.utile.submitAjaxForm('frmId','${ctx}/orderContract/saveApproval')"	class="but butSave">驳&nbsp;&nbsp;回</a>
		</c:if> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">返&nbsp;&nbsp;回</a>
</div>
<div id="frmContent" class="frmContent">
	<form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
		<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid}"/>
		<input type="hidden" id="status" name="status" value=""/>
		<input type="hidden" id="type" name="type" value="${param.type }"/>
	   <div id="baseInfor">
		   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr style="height: 120px;">
				<td class="formTableTdLeft">审批意见：</td>
				<td>
					<textarea type="text" class="largeX text" name="note" id="note"  style="height: 112px;width: 600px;" checkType="string,1" tip="请输入您意见！"></textarea>
				</td>				
			</tr>
		</table>
		</div>
	</form>
</div>
<div class="frmContent">
		<input type="hidden" value="${orderContract.dbid }" id="dbid" name="orderContract.dbid"></input>
		<input type="hidden" value="${orderContract.createTime }" id="createTime" name="orderContract.createTime"></input>
		<input type="hidden" value="${orderContract.status }" id="status" name="orderContract.status"></input>
		<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId"></input>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">合同基础信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="40">
				<td>车型：</td>
				<td>
					<span style="color: red;font-size: 15px;">
						${customer.customerLastBussi.brand.name }&nbsp;&nbsp;
						${customer.customerLastBussi.carSeriy.name }
						${customer.customerLastBussi.carModel.name }
						${customer.customerLastBussi.carColor.name }${customer.carColorStr}
					</span>
				</td>
				<td>合同总金额：</td>
				<td>
					<span style="color: red;font-size: 18px;">${orderContractExpenses.totalPrice }</span> 
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >需方：</td>
				<td>
					${orderContract.name }
				</td>
				<td>联系电话：</td>
				<td>
					${orderContract.contactPhone}
				</td>
			</tr>
			<tr height="42">
				<td>身份证地址：</td>
				<td>
					${orderContract.address }
				</td>
				<td>证件类型：</td>
				<td>
					${customer.paperwork.name}
				</td>
			</tr>
			<tr height="42">
				<td>证件号码：</td>
				<td>
					${orderContract.icard }
				</td>
				<td>开票名称：</td>
				<td>
					${orderContract.bankNo }
				</td>
			</tr>
			<tr height="42">
				<td>购车定金：</td>
				<td>
					${orderContract.orderMoney }
				</td>
				<td>大写：</td>
				<td>
					${orderContract.bigOrderMoney }
				</td>
			</tr>
		
		<tr style="height: 60px;">
			<td>交货日期：</td>
			<td colspan="3">
				<div style="margin: 8px 0px;">
					${orderContract.handerOverCarDate }
				</div>
			</td>
		</tr>
		<tr>
			<td>备注：</td>
			<td colspan="3">
			<div style="margin: 8px 0px;">
				${orderContract.note }
			</div>
			</td>
		</tr>
		<c:if test="${empty(orderContract) }">
			<tr height="42">
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
			<tr height="42">
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
		<div class="frmTitle" onclick="showOrHiden('contactTable')">合同费用明细</div>
       	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="32">
				<td class="formTableTdLeft">经销商报价：&nbsp;</td>
				<td colspan="">
					${orderContractExpenses.salePrice }
				</td>
				<td class="formTableTdLeft" style="font-size: 11px;">车辆顾问结算价：</td>
				<td id="carColorId">
					${orderContractExpenses.carSalerPrice }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">合同总金额：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.totalPrice }</span>
				</td>
				<td class="formTableTdLeft" >购车定金：</td>
				<td >
					${orderContractExpenses.orderMoney } 
				</td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">特殊优惠：&nbsp;</td>
					<td >
						${orderContractExpenses.specialPermPrice }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">特殊优惠备注：&nbsp;</td>
					<td >
						${orderContractExpenses.specialPermNote }
					</td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">优惠现金：&nbsp;</td>
					<td >
						${orderContractExpenses.cashBenefit }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">优惠总额：&nbsp;</td>
					<td >
						${orderContractExpenses.cashBenefit+orderContractExpenses.specialPermPrice }
					</td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">装饰款：&nbsp;</td>
					<td >
						${orderContractExpenses.decoreMoney }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">装饰顾问结算价：&nbsp;</td>
					<td >
						${orderContractDecore.salerTotalPrice }
					</td>
			</tr>
			<tr>
					<td class="formTableTdLeft">按揭手续费：&nbsp;</td>
					<td >
						${orderContractExpenses.ajsxf }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">按揭手续费成本：&nbsp;</td>
					<td >
						0
					</td>
			</tr>
			<tr height="32">
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
				<td class="formTableTdLeft">整车营收：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.revenuePrice }</span>
				</td>
				<td class="formTableTdLeft" >预估整车毛利：</td>
				<td >
					<c:set value="${orderContractExpenses.revenuePrice-orderContractExpenses.carSalerPrice-orderContractDecore.salerTotalPrice }" var="carGrofitPrice"></c:set>
					<c:if test="${carGrofitPrice>0 }">
						<span style="color: red;font-size: 20px;">${carGrofitPrice }</span>
					</c:if>
					<c:if test="${carGrofitPrice<=0 }">
						<span style="color: green;font-size: 20px;">${carGrofitPrice }</span>
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
						<span style="color: red;font-size: 20px;">${carPrice }</span>
					</c:if>
					<c:if test="${carPrice<=0 }">
						<span style="color: green;font-size: 20px;">${carPrice }</span>
					</c:if> 
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">购车方式：&nbsp;</td>
				<td >
					<c:if test="${orderContractExpenses.buyCarType==1 }">
						<span style="color: green;">现款</span>
					</c:if>
					<c:if test="${orderContractExpenses.buyCarType==2 }">
						<span style="color: red;">分付</span>
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
			<c:if test="${orderContractExpenses.buyCarType==2 }">
				<tr height="32">
					<td class="formTableTdLeft">首付款：&nbsp;</td>
					<td colspan="">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.sfk) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.sfk) }">
							${orderContractExpenses.sfk }
						</c:if>
						</span>
					</td>
					<td class="formTableTdLeft" >贷款：</td>
					<td >
						<c:if test="${empty(orderContractExpenses.daikuan) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.daikuan) }">
							${orderContractExpenses.daikuan }
						</c:if>
					</td>
				</tr>
			</c:if>
			<tr height="32">
					<td class="formTableTdLeft">未折让权限：&nbsp;</td>
					<td colspan="3">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.noWllowancePrice) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.noWllowancePrice) }">
							${orderContractExpenses.noWllowancePrice }
						</c:if>
						</span>
					</td>
				</tr>
		</table>
		<c:if test="${fn:length(orderContractExpensesChargeItems)>0||fn:length(orderContractExpensesPreferenceItems)>0 }">
			<table id="orderDecore" cellpadding="0" cellspacing="0" border="1" style="margin:0 auto;width: 92%;" class="table-c">
				<tr>
					<td align="center" colspan="4">&#12288;预收款明细</td>
					<td  align="center" colspan="4">&#12288;其他收费明细</td>	
				</tr>
				<tr style="border-bottom: 0;">
					<td colspan="4" style="border-bottom: 0;margin: 0;padding: 0" width="50%">
						<table cellpadding="0" cellspacing="0" width="100%" border="0" >
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
					<td colspan="4" style="border-bottom: 0;margin: 0;padding: 0" width="50%">
						<table cellpadding="0" cellspacing="0" width="100%" border="0" >
							<tr class="tabletr">
								<td align="center" style="0">序号</td>
								<td align="center">项目</td>
								<td align="center">金额</td>
								<td align="center">备注</td>
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
	<div class="frmTitle" onclick="showOrHiden('contactTable')">附加通知单</div>		
		<c:if test="${empty(orderContractDecore) }">
			<div class="alert alert-error">
				<strong>提示：</strong> 
				该客户无附加通知单！				
			</div>
		</c:if>
		<c:if test="${!empty(orderContractDecore) }">
			<table id="orderDecore" cellpadding="0" cellspacing="0" border="1" style="margin:0 auto;width: 92%;" class="table-c">
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
</div>
</body>
</html>

