<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>财务日统计一览表</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	
	a:VISITED{
		text-decoration: none;
		border: none;
		
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);"  class="aedit">财务日统计一览表</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate" >
   <div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx }/cwProfitStatical/queryDateCwStatic" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="type" name="type" value='1'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				 <td><label>月份：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM'})" value="${param.startTime }" >
				</td>
  				<td><div  onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${company.name }财务日统计一览表</div>
<table width="2500px" border="1" class="mainTable" cellpadding="0" cellspacing="0" style="border: 1px solid #fff;">
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">收支统计</span></td>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:40px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td style="width:70px">${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumCollect"></c:set>
			<c:forEach items="${countCollect }" var="map">
				<c:set value="${map.key}" var="collectName"></c:set>
				<c:set value="${map.value}" var="collectDayCwStatics"></c:set>
				<td>
					1
				</td>
				<td>
					${collectName}
				</td>
				<c:forEach items="${collectDayCwStatics }" var="collectDayCwStatic">
					<td>
						${collectDayCwStatic.per }
						<c:set value="${sumCollect+collectDayCwStatic.per }" var="sumCollect"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumCollect}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumExpenditure"></c:set>
			<c:forEach items="${countExpenditure }" var="map">
				<c:set value="${map.key}" var="expenditureName"></c:set>
				<c:set value="${map.value}" var="expenditureCwStatics"></c:set>
				<td>
					2
				</td>
				<td>
					${expenditureName}
				</td>
				<c:forEach items="${expenditureCwStatics }" var="expenditureCwStatic">
					<td>
						${expenditureCwStatic.per }
						<c:set value="${sumExpenditure+expenditureCwStatic.per }" var="sumExpenditure"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumExpenditure}</span>
			</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">支付渠道收入统计</span></td>
			<c:set value="0.0" var="sumPaymentCollectTotal"></c:set>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<c:forEach items="${countPaymentCollect }" var="map"  varStatus="i">
			<tr>
				<c:set value="${map.key }" var="payment"></c:set>
				<c:set value="${map.value }" var="paymentCwStatics"></c:set>
				<c:set value="0.0" var="sumPayment"></c:set>
				<td>
					${i.index+1 }
				</td>
				<td>
					${payment.name }
				</td>
				<c:forEach  items="${paymentCwStatics }" var="paymentCwStatic">
					<td>
						${paymentCwStatic.per }
						<c:set value="${sumPayment+paymentCwStatic.per }" var="sumPayment"></c:set>
					</td>
				</c:forEach>
				<td>
					<span style="color:red">${sumPayment }</span>
					<c:set value="${sumPaymentCollectTotal+sumPayment }" var="sumPaymentCollectTotal"></c:set>
				</td>
			</tr>
		</c:forEach>
		<tr>
				<td colspan="${lastDayOfMonth+2 }" style="text-align: right;color:red;font-size: 22px">小计：</td>
				<td style="color:red;font-size: 22px">${sumPaymentCollectTotal }</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">支付渠道支出统计</span></td>
			<c:set value="0.0" var="sumPaymentExpenditureTotal"></c:set>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<c:forEach items="${countPaymentExpenditure }" var="map"  varStatus="i">
			<tr>
				<c:set value="${map.key }" var="paymentExpenditure"></c:set>
				<c:set value="${map.value }" var="paymentExpenditureCwStatics"></c:set>
				<c:set value="0.0" var="sumPayment"></c:set>
				<td>
					${i.index+1 }
				</td>
				<td>
					${paymentExpenditure.name }
				</td>
				<c:forEach  items="${paymentExpenditureCwStatics }" var="paymentExpenditureCwStatic">
					<td>
						${paymentExpenditureCwStatic.per }
						<c:set value="${sumPayment+paymentExpenditureCwStatic.per }" var="sumPayment"></c:set>
					</td>
				</c:forEach>
				<td>
					<span style="color:red">${sumPayment }</span>
					<c:set value="${sumPaymentExpenditureTotal+sumPayment }" var="sumPaymentExpenditureTotal"></c:set>
				</td>
			</tr>
		</c:forEach>
		<tr>
				<td colspan="${lastDayOfMonth+2 }" style="text-align: right;color:red;font-size: 22px">小计：</td>
				<td style="color:red;font-size: 22px">${sumPaymentExpenditureTotal }</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">开票类型统计</span></td>
			<c:set value="0.0" var="sumOpenBillingTypeTotal"></c:set>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<c:forEach items="${countOpenBillingType }" var="map"  varStatus="i">
			<tr>
				<c:set value="${map.key }" var="openBillingType"></c:set>
				<c:set value="${map.value }" var="openBillingTypeCwStatics"></c:set>
				<c:set value="0.0" var="sumOpenBillingType"></c:set>
				<td>
					${i.index+1 }
				</td>
				<td>
					${openBillingType.name }
				</td>
				<c:forEach  items="${openBillingTypeCwStatics }" var="openBillingTypeCwStatic">
					<td>
						${openBillingTypeCwStatic.per }
						<c:set value="${sumOpenBillingType+openBillingTypeCwStatic.per }" var="sumOpenBillingType"></c:set>
					</td>
				</c:forEach>
				<td>
					<span style="color:red">${sumOpenBillingType }</span>
					<c:set value="${sumOpenBillingTypeTotal+sumOpenBillingType }" var="sumOpenBillingTypeTotal"></c:set>
				</td>
			</tr>
		</c:forEach>
		<tr>
				<td colspan="${lastDayOfMonth+2 }" style="text-align: right;color:red;font-size: 22px">小计：</td>
				<td style="color:red;font-size: 22px">${sumOpenBillingTypeTotal }</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">车款统计</span></td>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalContract"></c:set>
			<c:forEach items="${countTotalContract }" var="map">
				<c:set value="${map.key}" var="contract"></c:set>
				<c:set value="${map.value}" var="totalContractDayCwStatics"></c:set>
				<td>
					1
				</td>
				<td>
					${contract}
				</td>
				<c:forEach items="${totalContractDayCwStatics }" var="totalContractDayCwStatic">
					<td>
						${totalContractDayCwStatic.per }
						<c:set value="${sumTotalContract+totalContractDayCwStatic.per }" var="sumTotalContract"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalContract}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalcar"></c:set>
			<c:forEach items="${countTotalCarMoney }" var="map">
				<c:set value="${map.key}" var="car"></c:set>
				<c:set value="${map.value}" var="totalCarDayCwStatics"></c:set>
				<td>
					2
				</td>
				<td>
					${car}
				</td>
				<c:forEach items="${totalCarDayCwStatics }" var="totalCarDayCwStatic">
					<td>
						${totalCarDayCwStatic.per }
						<c:set value="${sumTotalcar+totalCarDayCwStatic.per }" var="sumTotalcar"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalcar}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalDecore"></c:set>
			<c:forEach items="${countTotalDecore }" var="map">
				<c:set value="${map.key}" var="decore"></c:set>
				<c:set value="${map.value}" var="totalDecoreDayCwStatics"></c:set>
				<td>
					3
				</td>
				<td>
					${decore}
				</td>
				<c:forEach items="${totalDecoreDayCwStatics }" var="totalDecoreDayCwStatic">
					<td>
						${totalDecoreDayCwStatic.per }
						<c:set value="${sumTotalDecore+totalDecoreDayCwStatic.per }" var="sumTotalDecore"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalDecore}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalAjsxf"></c:set>
			<c:forEach items="${countTotalAjsxf }" var="map">
				<c:set value="${map.key}" var="ajsxf"></c:set>
				<c:set value="${map.value}" var="totalajsxfDayCwStatics"></c:set>
				<td>
					4
				</td>
				<td>
					${ajsxf}
				</td>
				<c:forEach items="${totalajsxfDayCwStatics }" var="totalajsxfDayCwStatic">
					<td>
						${totalajsxfDayCwStatic.per }
						<c:set value="${sumTotalAjsxf+totalajsxfDayCwStatic.per }" var="sumTotalAjsxf"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalAjsxf}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalAdvance"></c:set>
			<c:forEach items="${countTotalAdvance }" var="map">
				<c:set value="${map.key}" var="advance"></c:set>
				<c:set value="${map.value}" var="totalAdvanceDayCwStatics"></c:set>
				<td>
					5
				</td>
				<td>
					${advance}
				</td>
				<c:forEach items="${totalAdvanceDayCwStatics }" var="totalAdvanceDayCwStatic">
					<td>
						${totalAdvanceDayCwStatic.per }
						<c:set value="${sumTotalAdvance+totalAdvanceDayCwStatic.per }" var="sumTotalAdvance"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalAdvance}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalCarCost"></c:set>
			<c:forEach items="${countTotalCarCost }" var="map">
				<c:set value="${map.key}" var="carCost"></c:set>
				<c:set value="${map.value}" var="totalCarCostDayCwStatics"></c:set>
				<td>
					6
				</td>
				<td>
					${carCost}
				</td>
				<c:forEach items="${totalCarCostDayCwStatics }" var="totalCarCostDayCwStatic">
					<td>
						${totalCarCostDayCwStatic.per }
						<c:set value="${sumTotalCarCost+totalCarCostDayCwStatic.per }" var="sumTotalCarCost"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalCarCost}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalSingCarProfit"></c:set>
			<c:forEach items="${countTotalSingCarProfit }" var="map">
				<c:set value="${map.key}" var="singleCarProfit"></c:set>
				<c:set value="${map.value}" var="totalSingleCarProfitDayCwStatics"></c:set>
				<td>
					7
				</td>
				<td>
					${singleCarProfit}
				</td>
				<c:forEach items="${totalSingleCarProfitDayCwStatics }" var="totalSingleCarProfitDayCwStatic">
					<td>
						${totalSingleCarProfitDayCwStatic.per }
						<c:set value="${sumTotalSingCarProfit+totalSingleCarProfitDayCwStatic.per }" var="sumTotalSingCarProfit"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalSingCarProfit}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalProfit"></c:set>
			<c:forEach items="${countTotalProfit }" var="map">
				<c:set value="${map.key}" var="profit"></c:set>
				<c:set value="${map.value}" var="totalProfitDayCwStatics"></c:set>
				<td>
					8
				</td>
				<td>
					${profit}
				</td>
				<c:forEach items="${totalProfitDayCwStatics }" var="totalProfitDayCwStatic">
					<td>
						${totalProfitDayCwStatic.per }
						<c:set value="${sumTotalProfit+totalProfitDayCwStatic.per }" var="sumTotalProfit"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalProfit}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalTaxProfit"></c:set>
			<c:forEach items="${countTotalTaxProfit }" var="map">
				<c:set value="${map.key}" var="taxProfit"></c:set>
				<c:set value="${map.value}" var="totalTaxProfitDayCwStatics"></c:set>
				<td>
					9
				</td>
				<td>
					${taxProfit}
				</td>
				<c:forEach items="${totalTaxProfitDayCwStatics }" var="totalTaxProfitDayCwStatic">
					<td>
						${totalTaxProfitDayCwStatic.per }
						<c:set value="${sumTotalTaxProfit+totalTaxProfitDayCwStatic.per }" var="sumTotalTaxProfit"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalTaxProfit}</span>
			</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">保险返利统计</span></td>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalBusinessMoney"></c:set>
			<c:forEach items="${countTotalBusinessMoney }" var="map">
				<c:set value="${map.key}" var="businessMoney"></c:set>
				<c:set value="${map.value}" var="totalBusinessMoneyDayCwStatics"></c:set>
				<td>
					1
				</td>
				<td>
					${businessMoney}
				</td>
				<c:forEach items="${totalBusinessMoneyDayCwStatics }" var="totalBusinessMoneyDayCwStatic">
					<td>
						${totalBusinessMoneyDayCwStatic.per }
						<c:set value="${sumTotalBusinessMoney+totalBusinessMoneyDayCwStatic.per }" var="sumTotalBusinessMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalBusinessMoney}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalForceMoney"></c:set>
			<c:forEach items="${countTotalForceMoney }" var="map">
				<c:set value="${map.key}" var="forceMoney"></c:set>
				<c:set value="${map.value}" var="totalForceMoneyDayCwStatics"></c:set>
				<td>
					2
				</td>
				<td>
					${forceMoney}
				</td>
				<c:forEach items="${totalForceMoneyDayCwStatics }" var="totalForceMoneyDayCwStatic">
					<td>
						${totalForceMoneyDayCwStatic.per }
						<c:set value="${sumTotalForceMoney+totalForceMoneyDayCwStatic.per }" var="sumTotalForceMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalForceMoney}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalRebateMoney"></c:set>
			<c:forEach items="${countTotalRebateMoney }" var="map">
				<c:set value="${map.key}" var="rebateMoney"></c:set>
				<c:set value="${map.value}" var="totalrebateMoneyDayCwStatics"></c:set>
				<td>
					3
				</td>
				<td>
					${rebateMoney}
				</td>
				<c:forEach items="${totalrebateMoneyDayCwStatics }" var="totalrebateMoneyDayCwStatic">
					<td>
						${totalrebateMoneyDayCwStatic.per }
						<c:set value="${sumTotalRebateMoney+totalrebateMoneyDayCwStatic.per }" var="sumTotalRebateMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalRebateMoney}</span>
			</td>
		</tr>
		<tr>
			<td colspan="${lastDayOfMonth+3 }" style="text-align: left"><span style="color:green;font-size: 20px">销售装饰统计</span></td>
		</tr>
		<tr>
			<td style="width: 40px;" >序号</td>
			<td style="width:70px;" >类别</td>
			<c:forEach begin="1" var="dayNum" end="${lastDayOfMonth }" step="1">
				<td>${dayNum }</td>
			</c:forEach>
			<td style="width:40px;" >合计</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalSaleDecoreMoney"></c:set>
			<c:forEach items="${countTotalSaleDecoreMoney }" var="map">
				<c:set value="${map.key}" var="saleDecore"></c:set>
				<c:set value="${map.value}" var="totalSaleDecoreMoneyDayCwStatics"></c:set>
				<td>
					1
				</td>
				<td>
					${saleDecore}
				</td>
				<c:forEach items="${totalSaleDecoreMoneyDayCwStatics }" var="totalSaleDecoreMoneyDayCwStatic">
					<td>
						${totalSaleDecoreMoneyDayCwStatic.per }
						<c:set value="${sumTotalSaleDecoreMoney+totalSaleDecoreMoneyDayCwStatic.per }" var="sumTotalSaleDecoreMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalSaleDecoreMoney}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalSaleDecoreProfitMoney"></c:set>
			<c:forEach items="${countTotalSaleDecoreProfitMoney }" var="map">
				<c:set value="${map.key}" var="saleDecoreProfit"></c:set>
				<c:set value="${map.value}" var="totalSaleDecoreProfitMoneyDayCwStatics"></c:set>
				<td>
					2
				</td>
				<td>
					${saleDecoreProfit}
				</td>
				<c:forEach items="${totalSaleDecoreProfitMoneyDayCwStatics }" var="totalSaleDecoreProfitMoneyDayCwStatic">
					<td>
						${totalSaleDecoreProfitMoneyDayCwStatic.per }
						<c:set value="${sumTotalSaleDecoreProfitMoney+totalSaleDecoreProfitMoneyDayCwStatic.per }" var="sumTotalSaleDecoreProfitMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalSaleDecoreProfitMoney}</span>
			</td>
		</tr>
		<tr>
			<c:set value="0.0" var="sumTotalSaleDecoreTaxProfitMoney"></c:set>
			<c:forEach items="${countTotalSaleDecoreTaxProfitMoney }" var="map">
				<c:set value="${map.key}" var="saleDecoreTaxProfit"></c:set>
				<c:set value="${map.value}" var="totalSaleDecoreTaxProfitMoneyDayCwStatics"></c:set>
				<td>
					3
				</td>
				<td>
					${saleDecoreTaxProfit}
				</td>
				<c:forEach items="${totalSaleDecoreTaxProfitMoneyDayCwStatics }" var="totalSaleDecoreTaxProfitMoneyDayCwStatic">
					<td>
						${totalSaleDecoreTaxProfitMoneyDayCwStatic.per }
						<c:set value="${sumTotalSaleDecoreTaxProfitMoney+totalSaleDecoreTaxProfitMoneyDayCwStatic.per }" var="sumTotalSaleDecoreTaxProfitMoney"></c:set>
					</td>
				</c:forEach>
			</c:forEach>
			<td>
				<span style="color:red">${sumTotalSaleDecoreTaxProfitMoney}</span>
			</td>
		</tr>
</table>
</body>
<script src="${ctx }/widgets/highcharts/highcharts.js"></script>
<script src="${ctx }/widgets/highcharts/modules/exporting.js"></script>
<script type="text/javascript">
</script>
</html>
