<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>客户合同审批</title>
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
<script type="text/javascript">
	function validateDa(){
		var carGrofitPrice=$("#carGrofitPrice").val();
		var grofitAprovalStatus ="${systemInfo.grofitAprovalStatus}";
		var approvalMoney ="${user.approvalMoney}";
		if(grofitAprovalStatus==2){
			//-1为最大权限
			if(approvalMoney!=-1){
				if(null==approvalMoney||approvalMoney==""||approvalMoney=="0"){
					alert("您还未设置审批权限，请联系管理员设置后在审批");
					return false;
				}
				carGrofitPrice=parseInt(carGrofitPrice);
				approvalMoney=parseInt(approvalMoney);
				if(carGrofitPrice<approvalMoney){
					alert("您的审批权限是【"+approvalMoney+"】,销售顾问利润【"+carGrofitPrice+"】,审批超过权限，请提交上级审批");
					return false;
				}
			}
		}
		return true;
	}
</script>
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
	<a href="javascript:void(-1)" id="sbmId"	onclick="if(validateDa()){$('#approvalStatus').val('3');$.utile.submitAjaxForm('frmId','${ctx}/processRun/saveDealTask')}"	class="but butSave">同&nbsp;&nbsp;意</a> 
	<a href="javascript:void(-1)" id="sbmId"	onclick="$('#approvalStatus').val('2');$.utile.submitAjaxForm('frmId','${ctx}/processRun/saveDealTask')"	class="but butSave">驳&nbsp;&nbsp;回</a>
	<c:if test="${!empty(user.parent) }">
		<a href="javascript:void(-1)" id="sbmId"	onclick="$('#approvalStatus').val('4');$.utile.submitAjaxForm('frmId','${ctx}/processRun/saveDealTask')"	class="but butSave">提交上级审批</a>
	</c:if>
    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">返&nbsp;&nbsp;回</a>
</div>
<div id="frmContent" class="frmContent">
	<form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
		<c:set value="${orderContractExpenses.revenuePrice-orderContractExpenses.carSalerPrice-orderContractDecore.salerTotalPrice }" var="carGrofitPrice"></c:set>
		<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid}"/>
		<input type="hidden" id="processFromId" name="processFromId" value="${processFrom.dbid}"/>
		<input type="hidden" id="approvalStatus" name="approvalStatus" value=""/>
		<input type="hidden" id="carGrofitPrice" name="carGrofitPrice" value="${carGrofitPrice }"/>
	   <div id="baseInfor">
		  <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr style="height: 130px;">
				<td class="formTableTdLeft">审批意见：</td>
				<td style="margin: 5px;">
					<textarea type="text" class="largeX text" name="note" id="note"  style="height: 112px;width: 98%;" checkType="string,1" tip="请输入您意见！"></textarea>
				</td>				
			</tr>
		</table>
		</div>
	</form>
</div>
	<div class="frmContent">
		<br>
		<c:if test="${systemInfo.grofitAprovalStatus==2 }">
			<c:if test="${user.approvalMoney!=-1 }">
				<c:if test="${carGrofitPrice<user.approvalMoney }" var="status">
					<div class="alert alert-error">
						整车毛利为【${carGrofitPrice}】，超过审批权限。我的审批权限>${user.approvalMoney }
					</div>
				</c:if>
				<c:if test="${status==false }" var="status">
					<div class="alert alert-info">
						整车毛利为【${carGrofitPrice}】，在审批权限内。我的审批权限>${user.approvalMoney }
					</div>
				</c:if>
			</c:if>
		</c:if>
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
						 ${customer.customerLastBussi.carModel.name }${customer.carModelStr}
						${customer.customerLastBussi.carColor.name }
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
		<tr height="32">
			<td>附加备注：</td>
			<td colspan="3">
				${orderContract.additionalNote }
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
					<td width="100%" colspan="4" style="">合同费用明细</td>
			</tr>
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
					<span style="color: red;font-size: 18px;">${orderContractExpenses.totalPrice }</span>
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
					<td class="formTableTdLeft">咨询服务费：&nbsp;</td>
					<td >
						${orderContractExpenses.ajsxf }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">咨询服务费成本：&nbsp;</td>
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
					<td class="formTableTdLeft">颜色溢价：&nbsp;</td>
					<td colspan="1">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.colorPrice) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.colorPrice) }">
							${orderContractExpenses.colorPrice }
						</c:if>
						</span>
					</td>
					<td class="formTableTdLeft">未折让权限：&nbsp;</td>
					<td colspan="1">
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
						<td align="right" colspan="4" style="padding-right: 12px;">其他收费合计:<span style="color: red;">${orderContractExpenses.otherFeePrice }</span></td>
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
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 8px">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="10" style="">审批记录</td>
			</tr>
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td width="4%" style="text-align: center;">序号</td>
				<td width="15%" style="text-align: center;">任务名称</td>
				<td width="8%" style="text-align: center;">创建时间</td>
				<td width="8%" style="text-align: center;">处理时间</td>
				<td width="16%" style="text-align: center;">上个任务</td>
				<td  width="6%" style="text-align: center;">审批人</td>
				<td width="8%" style="text-align: center;">审批状态</td>
				<td  width="8%" style="text-align: center;">审批结果</td>
				<td width="16%" style="text-align: center;">审批意见</td>
				<td width="16%" style="text-align: center;">用时(小时)</td>
			</tr>
			<c:forEach var="processFrom" items="${processFroms }" varStatus="i">
				<tr height="42">
				<td align="center">${i.index+1 }</td>
				<td style="padding: 5px;">
					${processFrom.taskName }
				</td>
				<td align="center">
					<fmt:formatDate value="${processFrom.createTime }"/>
				</td>
				<td align="center">
					<fmt:formatDate value="${processFrom.finishTime }"/>
				</td>
				<td align="center">
					${processFrom.fromTaskName }
				</td>
				<td align="center">
					${processFrom.taskUserName }
				</td>
				<td align="center">
					<c:if test="${processFrom.status==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.status==2 }">
						<span style="color: green">已审批</span>
					</c:if>
				</td>
				<td align="center">
					<c:if test="${processFrom.approvalStatus==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==2 }">
						<span style="color: red">审批驳回</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==3 }">
						<span style="color: green;">通过</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==4 }">
						<span style="color: green;">提交上级审批</span>
					</c:if>
				</td>
				<td align="center">
					${processFrom.comments }
				</td>
				<td align="center">
					${processFrom.duringLong }
				</td>
			</c:forEach>
		</table>
			<br>
</div>
</body>
</html>

