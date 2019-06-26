<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>单车利润明细</title>
<style>
</style>
</head>
<body class="bodycolor" >
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">单车利润明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
   </div> 
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carCashMoneyDetail/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>vin码：</label></td>
  				<td><input type="text" id="vinCode" name="custTel" class="text small" value="${param.vinCode}"></td>
				<td><label>销售日期：</label></td>
  				<td>
  					<input class="text small" id="startDate" name="startDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="startDate" name="startDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startDate }">
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div> 
   		<div style="clear: both;"></div>
</div>
<div style="overflow:scroll;">
<c:if test="${empty(carCashMoneyDetails) }">
	<div class="alert alert-error">
		无单车利润明细
	</div>
</c:if>
<c:if test="${!empty(carCashMoneyDetails) }">
<table width="4500px"  cellpadding="0" cellspacing="0" class="mainTable" border="1" bordercolor="#D3D3D3">
	 <thead  class="TableHeader">
		<tr bgcolor="#F5F5F5">
			<td colspan="3">
				客户信息
			</td>
			<td colspan="16">
				车辆信息
			</td>
			<td colspan="8">
				工厂佣金
			</td>
			<td colspan="8">
				装饰信息
			</td>
			<td colspan="5">
				按揭信息
			</td>
			<td colspan="7">
				保险信息
			</td>
			<!-- <td colspan="3">
				原始进货商
			</td>
			<td colspan="4">
				系列
			</td>
			<td colspan="3">	
				公告名称
			</td>
			<td colspan="10">
				型号
			</td> -->
			<!-- <td colspan="2">
				颜色
			</td>
			<td colspan="4">
				物料号
			</td>
			<td colspan="2">
				总额
			</td>
			<td colspan="2">
				时间
			</td> -->
		</tr>
	</thead>
	<tr bgcolor="#F5F5F5" >
		<td class="span2" style="color:black">客户姓名</td>
		<td class="span2" style="color:black">客户电话</td>
		<td class="span4" style="color:black">客户地址</td>
		<td class="span2" style="color:black">销售网点</td>
		<td class="span2" style="color:black">销售部门</td>
		<td class="span2" style="color:black">序号</td>
		<td class="span2" style="color:black">原始进货商</td>
		<td class="span2" style="color:black">系列</td>
		<td class="span2" style="color:black">公告名称</td>
		<td class="span4" style="color:black">型号 </td>
		<td class="span2" style="color:black">颜色</td>
		<td class="span2" style="color:black">物料号</td>
		<td class="span6" style="color:black">车型 </td>
		<td class="span2" style="color:black">销售日期</td>
		<td class="span2" style="color:black">销售人员一</td>
		<td class="span2" style="color:black">销售人员二</td>
		<td class="span3" style="color:black">工厂提车日期</td>
		<td class="span2" style="color:black">市场指导价</td>
		<td class="span2" style="color:black">工厂指导价</td>	
		<td class="span3" style="color:black">开票返利金额</td>
		<td class="span3" style="color:black">月度返利金额</td>
		<td class="span3" style="color:black">销售类返利金额</td>
		<td class="span2" style="color:black">溢价</td>	
		<td class="span2" style="color:black">其他返利</td>
		<td class="span3" style="color:black">工厂应返利合计</td>
		<td class="span3" style="color:black">工厂返利总额</td>
		<td class="span3" style="color:black">整笔返利状态</td>	
		<td class="span2" style="color:black">实收总额</td>
		<td class="span2" style="color:black">折扣率</td>
		<td class="span2" style="color:black">赠送总额</td>	
		<td class="span2" style="color:black">销售装饰合计</td>
		<td class="span3" style="color:black">销售顾问结算总额</td>
		<td class="span3" style="color:black">销售顾问结算利润</td>
		<td class="span2" style="color:black">实际成本</td>
		<td class="span2" style="color:black">实际利润</td>
		<td class="span2" style="color:black">按揭渠道</td>	
		<td class="span2" style="color:black">咨询服务费</td>	
		<td class="span2" style="color:black">贴息</td>
		<td class="span2" style="color:black">按揭成本</td>
		<td class="span2" style="color:black">按揭毛利</td>
		<td class="span2" style="color:black">保险公司</td>	
		<td class="span2" style="color:black">交强险金额</td>
		<td class="span3" style="color:black">交强险返利金额</td>
		<td class="span2" style="color:black">商业险金额</td>
		<td class="span3" style="color:black">商业险返利金额</td>	
		<td class="span2" style="color:black">保险毛利</td>	
		<td class="span2" style="color:black">保险返利状态</td>
		<!-- <td class="span2">金融收款金额</td>
		<td class="span2">挂帐应收总额</td>	
		<td class="span2">挂帐应收回款总额</td>
		<td class="span2">挂帐应付总额</td>	
		<td class="span2">挂帐付款总额</td>
		<td class="span2">消费总额</td>	
		<td class="span2">利润贡献总额</td>
		<td class="span3">创建时间</td>	
		<td class="span3">修改时间</td> -->
		</tr>
	 <c:forEach var="carCashMoneyDetail" items="${carCashMoneyDetails}">
			<tr height="32" align="center" bgcolor="white">
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.custName}
				</td>
				<td style="text-align:lcenter;color:black" >
					${carCashMoneyDetail.custTel}
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.custAddress}
				</td>
				<td style="text-align:lcenter;color:black">		
					${carCashMoneyDetail.salesOutlets }
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.salesDepartment }
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.serialNumber }
				</td>
				<td style="text-align:lcenter;color:black">				
					${carCashMoneyDetail.originalSuppliers }
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.series }
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.bulletinName }
				</td>
				<td style="text-align:lcenter;color:black">					
					${carCashMoneyDetail.model }
				</td>
				<td style="text-align:lcenter;color:black">			
					${carCashMoneyDetail.carColor }
				</td>
				<td style="text-align:lcenter;color:black">					
					${carCashMoneyDetail.materialNumber }
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.carModel }
				</td>
				<td style="text-align:lcenter;color:black">					
					${carCashMoneyDetail.salesDate }
				</td>
				<td style="text-align:lcenter;color:black">				
					${carCashMoneyDetail.salerOne }
				</td>
				<td style="text-align:lcenter;color:black">					
					${carCashMoneyDetail.salerTwo}
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.factoryListCarDate }
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.marketPrice }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.marketPrice}">
						${carCashMoneyDetail.marketPrice}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.factoryCommission }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.factoryCommission }">
						${carCashMoneyDetail.factoryCommission }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.openBillRebateMoney }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.openBillRebateMoney}">
						${carCashMoneyDetail.openBillRebateMoney}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.monthlyRewardMoney }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.monthlyRewardMoney}">
						${carCashMoneyDetail.monthlyRebateMoney}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.saleRebateMoney }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.saleRebateMoney }">
						${carCashMoneyDetail.saleRebateMoney }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.premium}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.premium}">
						${carCashMoneyDetail.premium }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.otherCommission }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.otherCommission }">
						${carCashMoneyDetail.otherCommission }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.factoryRebateTotalYing}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.factoryRebateTotalYing}">
						${carCashMoneyDetail.factoryRebateTotalYing }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.factoryRebateTotal }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.factoryRebateTotal }">
						${carCashMoneyDetail.factoryRebateTotal }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.factoryRebateState}">
						默认
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.factoryRebateState}">
						${carCashMoneyDetail.factoryRebateState }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.decoreActurePrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.decoreActurePrice }">
						${carCashMoneyDetail.decoreActurePrice }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.decoreZkl}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.decoreZkl }">
						${carCashMoneyDetail.decoreZkl}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.decoreGiveTotalPrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.decoreGiveTotalPrice }">
						${carCashMoneyDetail.decoreGiveTotalPrice}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.decoreSaleTotalPrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.decoreSaleTotalPrice }">
						${carCashMoneyDetail.decoreSaleTotalPrice }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.salerTotalPrice }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.salerTotalPrice }">
						${carCashMoneyDetail.salerTotalPrice }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.salerGrofitPrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.salerGrofitPrice}">
						${carCashMoneyDetail.salerGrofitPrice }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMomeyDetail.costPrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.costPrice }">
						${carCashMoenyDetail.costPrice }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.costGrofitPrice}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.costGrofitPrice}">
						${carCashMoneyDetail.costGrofitPrice}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.buyCarChannel}
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.mortgageServiceCharge }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.mortgageServiceCharge}">
						${carCashMoneyDetail.mortgageServiceCharge}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail1.interestDiscount}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail1.interestDiscount}">
						${carCashMoneyDetail.interestDiscount}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.mortgageMaori }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.mortgageMaori }">
						${carCashMoneyDetail.mortgageMaori }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					${carCashMoneyDetail.insuranceCompany}
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.strongInsuranceMoney }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.strongInsuranceMoney}">
						${carCashMoneyDetail.strongInsuranceMoney}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.strongInsuranceRebateMoney }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.strongInsuranceRebateMoney }">
						${carCashMoneyDetail.strongInsuranceRebateMoney }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.commercialInsuranceMoney}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.commercialInsuranceMoney }">
						${carCashMoneyDetail.commercialInsuranceMoney }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.commercialInsuranceRebateMoney}">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.commercialInsuranceRebateMoney }">
						${carCashMoneyDetail.commercialInsuranceRebateMoney }
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.insuranceMaori }">
						0.0
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.insuranceMaori }">
						${carCashMoneyDetail.insuranceMaori}
					</c:if>
				</td>
				<td style="text-align:lcenter;color:black">
					<c:if test="${empty carCashMoneyDetail.insuranceState}">
						未收
					</c:if>
					<c:if test="${!empty carCashMoneyDetail.insuranceState}">
						已收
					</c:if>
				</td>
				<%-- <td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.loanAmount}">
						${cwCwCustomer.loanAmount}
					</c:if>
					<c:if test="${empty cwCwCustomer.loanAmount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.financialAmount}">
						${cwCwCustomer.financialAmount}
					</c:if>
					<c:if test="${empty cwCwCustomer.financialAmount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalReceivables}">
						${cwCwCustomer.totalReceivables}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalReceivables}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalReceivableReturn}">
						${cwCwCustomer.totalReceivableReturn}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalReceivableReturn}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalAmountOfAccountsPayable}">
						${cwCwCustomer.totalAmountOfAccountsPayable}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalAmountOfAccountsPayable}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalAmountPayable}">
						${cwCwCustomer.totalAmountPayable}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalAmountPayable}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalConsumptionMoney}">
						${cwCwCustomer.totalConsumptionMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalConsumptionMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalProfileMoney}">
						${cwCwCustomer.totalProfileMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalProfileMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					${cwCwCustomer.createTime}
				</td>
				<td style="text-align:lcenter;">
					${cwCwCustomer.modifyTime}
				</td> --%>
			</tr>
		</c:forEach>
		<%-- <tr bgcolor="#F5F5F5" >
		<td colspan="4" style="color:red">合计：${customerNum}</td>
		<td class="span2"></td>
		<td class="span2" style="color:red">${eamestMoneySum }</td>
		<td class="span2"></td>
		<td class="span2"></td>
		<td class="span2" style="color:red">${advanceNumberSum }</td>
		<td class="span2" style="color:red">${advanceTotalSum }</td>
		<td class="span2" style="color:red">${advanceTotalDiscountSum }</td>
		<td class="span2" style="color:red">${amountOfUtilitySum }</td>
		<td class="span2" style="color:red">${totalUseSum }</td>
		<td class="span2" style="color:red">${totaAmountOfSurplusSum }</td>
		<td class="span2" style="color:red">${rechargeTimesSum }</td>
		<td class="span2" style="color:red">${totalRechargeSum }</td>
		<td class="span2" style="color:red">${vipTotalDiscountSum }</td>
		<td class="span2" style="color:red">${vipTotalAmountOfUtilitySum }</td>
		<td class="span2" style="color:red">${vipUserTotalSum }</td>	
		<td class="span2" style="color:red">${viptotalAmountOfSurplusSum }</td>
		<td class="span2"></td>
		<td class="span2" style="color:red">${deposiToalSum }</td>
		<td class="span2"></td>	
		<td class="span2"></td>
		<td class="span2" style="color:red">${premiumTotalSum }</td>
		<td class="span2" style="color:red">${usePremiumTotalSum }</td>
		<td class="span2" style="color:red">${surplusPremiunTotalSum }</td>	
		<td class="span2" style="color:red">${expenditureNumberSum }</td>
		<td class="span2" style="color:red">${advanceExpenditureTotalSum }</td>
		<td class="span2"></td>	
		<td class="span2" style="color:red">${totalcontractAmountSum }</td>
		<td class="span2" style="color:red">${payMoneyAmountSum }</td>
		<td class="span2" style="color:red">${settlementBalanceSum }</td>	
		<td class="span2"></td>
		<td class="span2" style="color:red">${decoreNumSum }</td>
		<td class="span2" style="color:red">${decoreMoneySum }</td>
		<td class="span2" style="color:red">${decoreDiscountTotalSum }</td>	
		<td class="span2"></td>	
		<td class="span2"></td>
		<td class="span2"></td>
		<td class="span2"></td>
		<td class="span2"></td>	
		<td class="span2" style="color:red">${compulsoryInsuranceTotalMoneySum }</td>
		<td class="span2" style="color:red">${bussiInsuranceTotalMoneySum }</td>
		<td class="span2" style="color:red">${compulsoryInsuranceProfileTotalMoneySum }</td>
		<td class="span2" style="color:red">${bussiInsuranceProfileTotalMoneySum }</td>	
		<td class="span2" style="color:red">${insuranceProfileTotalMoneySum }</td>
		<td class="span2" style="color:red">${loanAmountSum }</td>	
		<td class="span2" style="color:red">${financialAmountSum }</td>
		<td class="span2" style="color:red">${totalReceivablesSum }</td>	
		<td class="span2" style="color:red">${totalReceivableReturnSum }</td>
		<td class="span2" style="color:red">${totalAmountOfAccountsPayableSum }</td>	
		<td class="span2" style="color:red">${totalAmountPayableSum }</td>
		<td class="span2" style="color:red">${totalConsumptionMoneySum }</td>	
		<td class="span2" style="color:red">${totalProfileMoneySum }</td>
		<td class="span2"></td>	
		<td class="span2"></td>
		</tr> --%>
</table>
</c:if>
</div>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
/* function billManage(){
	var val = $("#addBill").val();
	$.ajax({
		type:"GET",
		url:"${ctx}/bill/addBill?dbid="+val,
		dataType:"json",
	});
} */
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/advanceMangement/exportExcel?'+params;
}
</script>
</html>