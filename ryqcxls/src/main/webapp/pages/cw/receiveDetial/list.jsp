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
<title>预收收银列表</title>
<style>
</style>
</head>
<body class="bodycolor" style="width:4500px">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">收银明细列表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%--  <a class="but button" href="${ctx}/advancePayment/queryCustList">添加挂账</a> 
		 <select class="text small" id="billProject" name="billProject" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billProject==1?'selected="selected"':'' }>保险</option>
  						<option value="2" ${param.billProject==2?'selected="selected"':'' }>金融</option>
  						<option value="3" ${param.billProject==3?'selected="selected"':'' }>车辆</option>
  						<option value="4" ${param.billProject==4?'selected="selected"':'' }>装饰</option>
  						<option value="5" ${param.billProject==5?'selected="selected"':'' }>配件</option>
  					</select> --%>
  			<%-- <label style="color:black">添加挂账：</label>
  			<select class="text middle" id="addBill" name="addBill" onchange="window.location.href=this.value">
  				<option value="0">请选择</option>
  				<option value="${ctx}/bill/addBill?val=1" >保险反利应收挂账</option>
  				<option value="${ctx}/bill/addBill?val=2">金融应收挂账</option>
  				<option value="${ctx}/bill/addBill?val=3">车辆成本应付挂帐</option>
  				<option value="${ctx}/bill/addBill?val=4">装饰成本应付挂账</option>
  				<option value="${ctx}/bill/addBill?val=5">配件应付挂账</option>
  			</select> --%>
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> 
   	<!-- <tr  style="display:block" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<td ><div style="display:block" id="pt1">支付宝:&nbsp;<input type="text" name="alipay" id=""alipay class="small text" title="支付宝" checkType="double,0" tip="支付宝金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt2" >微信:&nbsp;<input type="text" name="weChat" id="weChat" class="small text" title="微信" checkType="double,0" tip="微信支付金额不能为空，且为数字类型"></div></td>					
						<td ><div style="display:block" id="pt3">POS:&nbsp;<input type="text" name="POS" id="POS"  class="small text" title="POS" checkType="double,0" tip="POS支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt4" >现金:&nbsp;<input type="text" name="cash" id="cash" class="small text" title="现金" checkType="double,0" tip="现金支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt5" >支票:&nbsp;<input type="text" name="check" id="check" class="small text" title="支票" checkType="double,0" tip="支票支付金额不能为空，且为数字类型"></div></td>
					</tr>
					</table>
					</td>
			</tr>  -->
  <%-- 	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/bill/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>挂账类型：</label></td>
  				<td>
  					<select class="text small" id="billType" name="billType" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billType==1?'selected="selected"':'' }>应收挂账</option>
  						<option value="2" ${param.billType==2?'selected="selected"':'' }>应付挂账</option>
  					</select>
				</td>
				<td><label>挂账项目：</label></td>
  				<td>
  					<select class="text small" id="billProject" name="billProject" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.billProject==1?'selected="selected"':'' }>保险</option>
  						<option value="2" ${param.billProject==2?'selected="selected"':'' }>金融</option>
  						<option value="3" ${param.billProject==3?'selected="selected"':'' }>车辆</option>
  						<option value="4" ${param.billProject==4?'selected="selected"':'' }>装饰</option>
  						<option value="5" ${param.billProject==5?'selected="selected"':'' }>配件</option>
  					</select>
				</td>				
			</tr>
			<tr>
				<td><label>业务类型：</label></td>
  				<td>
  					<select class="text small" id="bussiType" name="bussiType" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.bussiType==1?'selected="selected"':'' }>销售</option>
  						<option value="2" ${param.bussiType==2?'selected="selected"':'' }>售后</option>
  					</select>
				</td>
  				<td><label>挂账单位：</label></td>
  				<td><input type="text" id="billCompany" name="billCompany" class="text small" value="${param.billCompany}"></input></td>
  				<td><label>挂账单号：</label></td>
  				<td><input type="text" id="singleNumber" name="singleNumber" class="text small" value="${param.singleNumber}"></input></td>
  				<td><label>是否销账：</label></td>
  				<td>
  					<select class="text small" id="isWriteOff" name="isWriteOff" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.isWriteOff==1?'selected="selected"':'' }>是</option>
  						<option value="2" ${param.isWriteOff==2?'selected="selected"':'' }>否</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>经办人：</label></td>
  				<td><input type="text" id="agent" name="agent" class="text small" value="${param.agent}"></input></td>
  				<td><label>销账日期：</label></td>
  				<td>
  					<input class="text small" id="startWriteOffDate" name="startWriteOffDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startWriteOffDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endWriteOffDate" name="endWriteOffDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endWriteOffDate }">
				</td>
				<td><label>挂账日期：</label></td>
  				<td>
  					<input class="text small" id="startBillDate" name="startBillDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startBillDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endBillDate" name="endBillDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endBillDate }">
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div> --%>
   		<div style="clear: both;"></div>
</div>
<table width="4500px"  cellpadding="0" cellspacing="0" class="mainTable" border="1">
	 <thead  class="TableHeader">
		<tr>
			<td colspan="4">
				客户信息
			</td>
			<td colspan="4">
				定金
			</td>
			<td colspan="6">
				优惠券
			</td>
			<td colspan="6">
				会员充值
			</td>
			<td colspan="4">
				押金
			</td>
			<td colspan="3">
				预收保费
			</td>
			<td colspan="3">
				支出
			</td>
			<td colspan="4">
				车款
			</td>
			<td colspan="3">	
				装饰
			</td>
			<td colspan="10">
				保险
			</td>
			<td colspan="2">
				金融
			</td>
			<td colspan="4">
				挂帐
			</td>
			<td colspan="2">
				总额
			</td>
			<td colspan="2">
				时间
			</td>
		</tr>
	</thead>
	<tr>
		<td class="span2">客户姓名</td>
		<td class="span2">客户电话</td>
		<td class="span2">客户类型</td>
		<td class="span2">车牌号</td>
		<td class="span2">定金收取状态</td>
		<td class="span2">定金金额</td>
		<td class="span2">定金收取时间</td>
		<td class="span2">定金收取操作人</td>
		<td class="span2">优惠券笔数</td>
		<td class="span2">优惠券实收总额</td>
		<td class="span2">优惠券优惠总额</td>
		<td class="span2">优惠券实用总额</td>
		<td class="span2">优惠券使用总额</td>
		<td class="span2">优惠券剩余总额</td>
		<td class="span2">会员充值次数</td>
		<td class="span2">会员实收总额</td>
		<td class="span2">会员充值优惠总额</td>
		<td class="span2">会员充值实用总额</td>
		<td class="span2">会员充值使用总额</td>	
		<td class="span2">会员充值剩余总额</td>
		<td class="span2">押金收取状态</td>
		<td class="span2">押金金额</td>
		<td class="span2">押金收取时间</td>	
		<td class="span2">押金收取操作人</td>
		<td class="span2">预收保费总金额</td>
		<td class="span2">预收保费使用总金额</td>
		<td class="span2">预收保费剩余金额</td>	
		<td class="span2">支出笔数</td>
		<td class="span2">支出总额</td>
		<td class="span2">支出人</td>	
		<td class="span2">车款合同总金额</td>
		<td class="span2">车款收款总金额</td>
		<td class="span2">车款结算差额</td>	
		<td class="span2">车款结算状态</td>
		<td class="span2">装饰结算次数</td>
		<td class="span2">装饰总金额</td>
		<td class="span2">装饰优惠总金额</td>	
		<td class="span2">本次强制险金额</td>	
		<td class="span2">本次商业险金额</td>
		<td class="span2">本次强制险返利金额</td>
		<td class="span2">本次商业险返利金额</td>
		<td class="span2">本次返利总额</td>	
		<td class="span2">强制险总金额</td>
		<td class="span2">商业险总金额</td>
		<td class="span2">强制险返利总金额</td>
		<td class="span2">商业险返利总金额</td>	
		<td class="span2">保险返利总金额</td>
		<td class="span2">金融贷款金额</td>	
		<td class="span2">金融收款金额</td>
		<td class="span2">挂帐应收总额</td>	
		<td class="span2">挂帐应收回款总额</td>
		<td class="span2">挂帐应付总额</td>	
		<td class="span2">挂帐付款总额</td>
		<td class="span2">消费总额</td>	
		<td class="span2">利润贡献总额</td>
		<td class="span3">创建时间</td>	
		<td class="span3">修改时间</td>
		</tr>
	 <c:forEach var="cwCwCustomer" items="${cwCwCustomers}">
			<tr height="32" align="center">
				<td style="text-align:lcenter;">
					${cwCwCustomer.custName}
				</td>
				<td style="text-align:lcenter;">
					${cwCwCustomer.mobilePhone}
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${cwCwCustomer.custType eq 1}">
						销售客户
					</c:if>
					<c:if test="${cwCwCustomer.custType eq 2}">
						售后客户
					</c:if>
				</td>
				<td style="text-align:lcenter;">		
					<c:if test="${empty cwCwCustomer.licenseNumber}">
						无
					</c:if>
					<c:if test="${!empty cwCwCustomer.licenseNumber}">
						${cwCwCustomer.licenseNumber}
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${cwCwCustomer.earnestStatus eq 1}">
						待收
					</c:if>
					<c:if test="${cwCwCustomer.earnestStatus eq 2}">
						已收
					</c:if>
					<c:if test="${empty cwCwCustomer.earnestStatus}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					
					<c:if test="${empty cwCwCustomer.eamestMoney}">
						0.0
					</c:if>
					<c:if test="${!empty cwCwCustomer.eamestMoney}">
						${cwCwCustomer.eamestMoney }
					</c:if>
				</td>
				<td style="text-align:lcenter;">				
					<c:if test="${!empty cwCwCustomer.eamestTime}">
						${cwCwCustomer.eamestTime}
					</c:if>
					<c:if test="${empty cwCwCustomer.eamestTime}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					
					<c:if test="${!empty cwCwCustomer.eamestPerson}">
						${cwCwCustomer.eamestPerson}
					</c:if>
					<c:if test="${empty cwCwCustomer.eamestPerson}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.advanceNumber}">
						${cwCwCustomer.advanceNumber}
					</c:if>
					<c:if test="${empty cwCwCustomer.advanceNumber}">
						0
					</c:if>
				</td>
				<td style="text-align:lcenter;">					
					<c:if test="${!empty cwCwCustomer.advanceTotal}">
						${cwCwCustomer.advanceTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.advanceTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">			
					<c:if test="${!empty cwCwCustomer.advanceTotalDiscount}">
						${cwCwCustomer.advanceTotalDiscount}
					</c:if>
					<c:if test="${empty cwCwCustomer.advanceTotalDiscount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">					
					<c:if test="${!empty cwCwCustomer.amountOfUtility}">
						${cwCwCustomer.amountOfUtility}
					</c:if>
					<c:if test="${empty cwCwCustomer.amountOfUtility}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalUse}">
						${cwCwCustomer.totalUse}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalUse}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">					
					<c:if test="${!empty cwCwCustomer.totalAmountOfSurplus}">
						${cwCwCustomer.totalAmountOfSurplus}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalAmountOfSurplus}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">				
					<c:if test="${!empty cwCwCustomer.rechargeTimes}">
						${cwCwCustomer.rechargeTimes}
					</c:if>
					<c:if test="${empty cwCwCustomer.rechargeTimes}">
						0
					</c:if>
				</td>
				<td style="text-align:lcenter;">					
					<c:if test="${!empty cwCwCustomer.totalRecharge}">
						${cwCwCustomer.totalRecharge}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalRecharge}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.vipTotalDiscount}">
						${cwCwCustomer.vipTotalDiscount}
					</c:if>
					<c:if test="${empty cwCwCustomer.vipTotalDiscount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.vipTotalAmountOfUtility}">
						${cwCwCustomer.vipTotalAmountOfUtility}
					</c:if>
					<c:if test="${empty cwCwCustomer.vipTotalAmountOfUtility}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.vipUserTotal}">
						${cwCwCustomer.vipUserTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.vipUserTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.viptotalAmountOfSurplus}">
						${cwCwCustomer.viptotalAmountOfSurplus}
					</c:if>
					<c:if test="${empty cwCwCustomer.viptotalAmountOfSurplus}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${cwCwCustomer.depositStatus eq 1}">
						待收
					</c:if>
					<c:if test="${cwCwCustomer.depositStatus eq 2}">
						已收
					</c:if>
					<c:if test="${empty cwCwCustomer.depositStatus}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.deposiToal}">
						${cwCwCustomer.deposiToal}
					</c:if>
					<c:if test="${empty cwCwCustomer.deposiToal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.depositTime}">
						${cwCwCustomer.depositTime}
					</c:if>
					<c:if test="${empty cwCwCustomer.depositTime}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.depositPerson}">
						${cwCwCustomer.depositPerson}
					</c:if>
					<c:if test="${empty cwCwCustomer.depositPerson}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.premiumTotal}">
						${cwCwCustomer.premiumTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.premiumTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.usePremiumTotal}">
						${cwCwCustomer.usePremiumTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.usePremiumTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.surplusPremiunTotal}">
						${cwCwCustomer.surplusPremiunTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.surplusPremiunTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.expenditureNumber}">
						${cwCwCustomer.expenditureNumber}
					</c:if>
					<c:if test="${empty cwCwCustomer.expenditureNumber}">
						0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.advanceExpenditureTotal}">
						${cwCwCustomer.advanceExpenditureTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.advanceExpenditureTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.advanceExpenditurePerson}">	
						${cwCwCustomer.advanceExpenditurePerson}		
					</c:if>	
					<c:if test="${empty cwCwCustomer.advanceExpenditurePerson}">	
						无		
					</c:if>		
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.totalcontractAmount}">
						${cwCwCustomer.totalcontractAmount}
					</c:if>
					<c:if test="${empty cwCwCustomer.totalcontractAmount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.payMoneyAmount}">
						${cwCwCustomer.payMoneyAmount}
					</c:if>
					<c:if test="${empty cwCwCustomer.payMoneyAmount}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.settlementBalance}">
						${cwCwCustomer.settlementBalance}
					</c:if>
					<c:if test="${empty cwCwCustomer.settlementBalance}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${cwCwCustomer.settlementState eq 1}">
						待收
					</c:if>
					<c:if test="${cwCwCustomer.settlementState eq 2}">
						已收
					</c:if>
					<c:if test="${empty cwCwCustomer.settlementState}">
						无
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.decoreNum}">
						${cwCwCustomer.decoreNum}
					</c:if>
					<c:if test="${empty cwCwCustomer.decoreNum}">
						0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.decoreMoney}">
						${cwCwCustomer.decoreMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.decoreMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.decoreDiscountTotal}">
						${cwCwCustomer.decoreDiscountTotal}
					</c:if>
					<c:if test="${empty cwCwCustomer.decoreDiscountTotal}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.compulsoryInsuranceMoney}">
						${cwCwCustomer.compulsoryInsuranceMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.compulsoryInsuranceMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.bussiInsuranceMoney}">
						${cwCwCustomer.bussiInsuranceMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.bussiInsuranceMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.compulsoryInsuranceProfileMoney}">
						${cwCwCustomer.compulsoryInsuranceProfileMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.compulsoryInsuranceProfileMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.bussiInsuranceProfileMoney}">
						${cwCwCustomer.bussiInsuranceProfileMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.bussiInsuranceProfileMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.insuranceProfileMoney}">
						${cwCwCustomer.insuranceProfileMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.insuranceProfileMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.compulsoryInsuranceTotalMoney}">
						${cwCwCustomer.compulsoryInsuranceTotalMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.compulsoryInsuranceTotalMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.bussiInsuranceTotalMoney}">
						${cwCwCustomer.bussiInsuranceTotalMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.bussiInsuranceTotalMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.compulsoryInsuranceProfileTotalMoney}">
						${cwCwCustomer.compulsoryInsuranceProfileTotalMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.compulsoryInsuranceProfileTotalMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.bussiInsuranceProfileTotalMoney}">
						${cwCwCustomer.bussiInsuranceProfileTotalMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.bussiInsuranceProfileTotalMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
					<c:if test="${!empty cwCwCustomer.insuranceProfileTotalMoney}">
						${cwCwCustomer.insuranceProfileTotalMoney}
					</c:if>
					<c:if test="${empty cwCwCustomer.insuranceProfileTotalMoney}">
						0.0
					</c:if>
				</td>
				<td style="text-align:lcenter;">
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
				</td>
			</tr>
		</c:forEach>
		<tr bgcolor="gray" >
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
		</tr>
</table>
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