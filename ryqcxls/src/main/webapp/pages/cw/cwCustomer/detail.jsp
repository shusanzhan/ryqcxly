<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<!-- 最新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link  type="text/css" href="${ctx }/css/common.css" rel="stylesheet">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
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
.bar {
    background-color: #eff7ff;
    border-bottom: 1px solid #d7e8f8;
    height: 40px;
    line-height: 40px;
}
.bar a {
	font-family: "微软雅黑",Helvetica,Arial,sans-serif;
    color: #2b7dbc;
    text-decoration: none;
    font-size: 14px;
    font-family: '宋体';
}
</style>
<title>财务客户明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cwCustomer/queryList'">客户明细</a>-
	<a href="javascript:void(-1);" onclick="">明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="bar">
	<a href="javascript:;" id="print" class="" onclick="window.history.go(-1)" style="margin-left: 5px;">返回</a>
</div>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ;">
	<c:set value="${customer.orderContract }" var="orderContract"></c:set>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">姓名：</td>
		<td width="38%" align="left">
			${customer.name }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">联系电话：</td>
		<td width="38%" align="left">
			${customer.mobilePhone }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${customerBussi.brand.name }
			${customerBussi.carSeriy.name }
			${customerBussi.carModel.name}
			${customer.carModelStr }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">销售员：</td>
		<td width="38%" align="left">
			${customer.user.realName }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">客户状态：</td>
		<td width="38%" align="left">
			<c:if test="${customer.lastResult==0 }">
				<span style="color:maroon;">创建</span>
			</c:if>
			<c:if test="${customer.lastResult==1 }">
				<span style="color: green;">提报订单</span>
			</c:if>
			<c:if test="${customer.lastResult>1 }">
				<span style="color: red;">客户流失</span>
			</c:if>
		</td>
		<td class="formTableTdLeft" width="12%" align="right">创建时间：</td>
		<td width="38%" align="left">
			<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
		</td>
	</tr>
	<tr>
			<td class="formTableTdLeft" align="right" width="12%">订单状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(orderContract) }">
					<c:if test="${customer.lastResult>1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
					<c:if test="${customer.lastResult==1 }">
						<span style="color: red;">待填写订单</span>
					</c:if>
				</c:if>
				<c:if test="${!empty(orderContract) }">
					<c:if test="${orderContract.status==0 }">
						<span style="color: red;">创建订单</span>
					</c:if>
					<c:if test="${orderContract.status==1 }">
						<span style="color: red;">审批中...</span>
					</c:if>
					<c:if test="${orderContract.status==2 }">
						<span style="color: green;">审批同意</span>
					</c:if>
					<c:if test="${orderContract.status==3 }">
						<span style="color: red;">审批驳回</span>
					</c:if>
					<c:if test="${orderContract.status==4 }">
						<span style="color: green;">合同已打印</span>
					</c:if>
						<a href="javascript:void();" onclick="window.location.href='/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> 
				</c:if>
			</td>
			<td class="formTableTdLeft" align="right" width="12%">交车状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(customerShoppingRecord) }">
					<c:if test="${customer.lastResult>1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
					<c:if test="${customer.lastResult==1 }">
						<span style="color: red;">待交车</span>
					</c:if>
				</c:if>
				<c:if test="${!empty(customerPidBookingRecord) }">
					<c:if test="${empty(customer.customerPidBookingRecord.pidStatus) }">
						<span style="color: red;">待交车</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
						<span style="color: green">发起交车</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
						<span style="color: #DD9A4B;">合同流失...</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==2 }">
						<span style="color: #DD9A4B;">已归档</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
						<span style="color: green;">合同流失同意</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
						<span style="color: red;">合同流失驳回</span>
					</c:if>
					(
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
						<span style="color: blue;">现车订单</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
						<span style="color:green;">在途订单</span>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
						<span style="color: red;">无车订单</span>
					</c:if>
					)
					<c:if test="${!empty(customerPidBookingRecord) }">
						<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customerPidBookingRecord.vinCode }&amp;type=1">${customerPidBookingRecord.vinCode }</a>
					</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" align="right" width="12%">按揭状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(finCustomer) }">
					客户无按揭资料
				</c:if>
				<c:if test="${!empty(finCustomer) }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=1'">按揭资料</a>
				</c:if>
			</td>
			<td class="formTableTdLeft" width="12%" align="right">保险状态：</td>
			<td width="38%" align="left">
				<c:if test="${empty(insCustomer) }">
					客户无保险资料
				</c:if>
				<c:if test="${!empty(insCustomer) }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">保险资料</a>
				</c:if>
			</td>
	</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#baseInfo" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#baseInfo" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		   <c:if test="${param.type==2 }" var="sta">
		  		<li class="active"><a href="#comeShop" role="tab" data-toggle="tab">预收记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  		<li><a href="#comeShop" role="tab" data-toggle="tab">预收收银记录</a></li>
		  </c:if>
		   <c:if test="${param.type==3 }" var="sta">
		  	<li class="active"><a href="#construct" role="tab" data-toggle="tab">车款收银记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#construct" role="tab" data-toggle="tab">车款收银记录</a></li>
		  </c:if>
		  <c:if test="${param.type==5 }" var="sta">
		  	<li  class="active"><a href="#insurance" role="tab" data-toggle="tab">保险收银</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#insurance" role="tab" data-toggle="tab">保险收银</a></li>
		  </c:if>
		   <c:if test="${param.type==6 }" var="sta">
		  	<li  class="active"><a href="#finance" role="tab" data-toggle="tab">金融收银</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#finance" role="tab" data-toggle="tab">金融收银</a></li>
		  </c:if>
		  <c:if test="${param.type==7 }" var="sta">
		  	<li  class="active"><a href="#factoryRebate" role="tab" data-toggle="tab">工厂返利收银</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#factoryRebate" role="tab" data-toggle="tab">工厂返利收银</a></li>
		  </c:if>
		  <c:if test="${param.type==8 }" var="sta">
		  	<li  class="active"><a href="#expenditure" role="tab" data-toggle="tab">支出明细</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#expenditure" role="tab" data-toggle="tab">支出明细</a></li>
		  </c:if>
		   <c:if test="${param.type==9 }" var="sta">
		  	<li  class="active"><a href="#bill" role="tab" data-toggle="tab">挂账明细</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#bill" role="tab" data-toggle="tab">挂账明细</a></li>
		  </c:if>
		  <c:if test="${param.type==4 }" var="sta">
		  	<li  class="active"><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carOperateLog" role="tab" data-toggle="tab">操作日志</a></li>
		  </c:if>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content" >
			<c:if test="${param.type==1 }" var="sta">
			  <div class="tab-pane active" id="baseInfo" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="baseInfo" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
		  			<tr>
				<td class="formTableTdLeft">制卡日期：</td>
				<td>
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td class="formTableTdLeft">编号：</td>
				<td>
					${customer.sn }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					${customer.name }&nbsp;&nbsp;${customer.sex }
				</td>
				<td class="formTableTdLeft">意向级别：</td>
				<td >
					${customer.customerPhase.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">生日：</td>
				<td>
					<fmt:formatDate value="${customer.nbirthday }"/> 
				</td>
				<td class="formTableTdLeft" >年龄：</td>
				<td >
					${customer.age }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">家用电话：</td>
				<td>
					${customer.phone }
				</td>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					${customer.mobilePhone }
				</td>
			</tr>
				<tr>
					<td class="formTableTdLeft">EMAIL：</td>
					<td>
						${customer.email }
					</td>
					<td class="formTableTdLeft">QQ/MSN：</td>
					<td>
						${customer.qq }
					</td>
				</tr>
			<tr>
			    <td class="formTableTdLeft">家庭情况：</td>
				<td>
					${customer.family }
				</td>
				<td>
					单位信息：
				</td>
				<td>
					${customer.companyName1 }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">证件信息：</td>
				<td>
					${ customer.paperwork.name}
				</td>
				<td class="formTableTdLeft">证件号码：</td>
				<td>
					${customer.icard }
				</td>
			</tr>
			
			<tr>
				<td class="formTableTdLeft">地域：</td>
				<td id="areaLabel">
					${customer.area.fullName }
				</td>
				<td class="formTableTdLeft">地址：</td>
				<td>
					${customer.address }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >邮编：</td>
				<td >
					${customer.zipCode }
				</td>
				<td class="formTableTdLeft">行业：</td>
				<td>
					${customer.industry.name}
				</td>
				
			</tr>
			<tr>
				<td class="formTableTdLeft">职业：</td>
				<td>
					${customer.profession.name}
				</td>
				<td class="formTableTdLeft">学历：</td>
				<td>
						${customer.educational.name}
				</td>
			</tr>
			<tr>
			    <td class="formTableTdLeft">业务员：</td>
				<td>
					${customer.bussiStaff }
				</td>
				<td class="formTableTdLeft">同城交叉客户：</td>
				<td >
					${customer.cityCrossCustomer.name}
				</td>
			</tr>
			<tr style="height: 30px;">
				<td class="formTableTdLeft">兴趣爱好：</td>
				<td  colspan="3">
					${customer.interests }
				</td>
			</tr>
			<tr >
				<td class="formTableTdLeft">备注：</td>
				<td  colspan="3">
					${customer.note }
				</td>
			</tr>
		</table>
	</div>
		<c:if test="${param.type==2 }" var="sta">
		  <div class="tab-pane active" id="comeShop" >
		</c:if>
		<c:if test="${sta==false }">
		  <div class="tab-pane" id="comeShop" >
		</c:if>
		<c:if test="${empty(advancePayments)||advancePayments==null }" var="status">
					<div class="alert alert-info">
						<strong>提示!</strong> 当前未添加数据.
					</div>
				</c:if>
		<c:if test="${!empty advancePayments}">
			<c:forEach var="advancePayment"  items="${advancePayments}">
				<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
					<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">预收记录</td>
					</tr>
					<tr  height="30">
				<td class="formTableTdLeft"  >客户姓名:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.custName}
				</td>
				<td class="formTableTdLeft" >客户电话:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.custTel}
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft" >创建来源:&nbsp;</td>
				<td>
					<c:if test ="${advancePayment.createSource==1}">
						订单创建
					</c:if>
					<c:if test = "${advancePayment.createSource==2}">
					   收款创建
					</c:if>
				</td>
				<td class="formTableTdLeft" >客户类型:&nbsp;</td>
				<td>
					<c:if test ="${advancePayment.custType==1}">
						展厅（网销客户）
					</c:if>
					<c:if test = "${advancePayment.custType==2}">
					  二网客户
					</c:if>
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft" >收款类别:&nbsp;</td>
				<td>
					${advancePayment.childReceivablesType.name}
				</td>
				<td class="formTableTdLeft">收款项目:&nbsp;</td>
				<td>
					${advancePayment.itemName }
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft">本笔总额:&nbsp;</td>
				<td>
					<span style="color: red;">
						<c:if test="${empty advancePayment.totalMoney}">
							0.0
						</c:if>
						<c:if test="${!empty advancePayment.totalMoney}">
							${advancePayment.totalMoney}
						</c:if>
					</span>
				</td>
				<td class="formTableTdLeft" >销售人员:&nbsp;</td>
				<td>
					${advancePayment.salesManName }
				</td>
			</tr>
			<tr height="30">
				<td class="formTableTdLeft" style="width:20%" >创建人:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.creator }
				</td>
				<td class="formTableTdLeft" style="width:20%">创建日期:&nbsp;</td>
				<td style="width:30%">
					<fmt:formatDate value="${advancePayment.createTime }"/>
				</td>	
			</tr>
		<tr  height="30">
			<td class="formTableTdLeft">备注:&nbsp;</td>
			<td colspan="3">
				${advancePayment.remarks }
			</td>
	</tr>
			<tr  height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">收费信息</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.cashier.receiptNumber}
				</td>
				<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.cashier.orderNo}
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
				<td style="width:30%">
					<span style="color: red;">
						<c:if test="${empty advancePayment.cashier.amountCollected}">
							0.0
						</c:if>
						<c:if test="${!empty advancePayment.cashier.amountCollected}">
							${advancePayment.cashier.amountCollected}
						</c:if>
					</span>
				</td>
				<td class="formTableTdLeft">开票金额:&nbsp;</td>
				<td>
					<span style="color: red;">
						<c:if test="${empty advancePayment.cashier.openBillingMoney}">
							0.0
						</c:if>
						<c:if test="${!empty advancePayment.cashier.openBillingMoney}">
							${advancePayment.cashier.openBillingMoney}
						</c:if>
					</span>
				</td>
			</tr>	
			<tr  height="30">
				<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
				<td style="width:30%">
					<c:if test="${empty(advancePayment.cashier.openBillingType) }">
						无
					</c:if>
					${advancePayment.cashier.openBillingType.name }
				</td>
				<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
				<td style="width:30%">
					${advancePayment.cashier.childBillingType.name }
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft">收银时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${advancePayment.cashier.cashierTime}"/> 
				</td>
				<td class="formTableTdLeft">收款人:&nbsp;</td>
				<td>
					${advancePayment.cashier.payee}
				</td>
			</tr>
			<tr  height="30">
				<td class="formTableTdLeft">创建时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${advancePayment.cashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
				</td>
				<td class="formTableTdLeft">修改时间:&nbsp;</td>
				<td>
					<fmt:formatDate value="${advancePayment.cashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
				</td>
			</tr>
		<tr>
			<td class="formTableTdLeft">支付方式:&nbsp;</td>
				<td colspan="3">
					<ystech:cashierPay orderNo="${advancePayment.cashier.orderNo }"/>
				</td>
		</tr>
		<tr  height="30">
			<td class="formTableTdLeft">摘要:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty advancePayment.cashier.abstract_}">
						无
					</c:if>
					<c:if test="${!empty advancePayment.cashier.abstract_}">
						${advancePayment.cashier.abstract_ }
					</c:if>
				</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty advancePayment.cashier.cashRemark}">
						无
					</c:if>
					<c:if test="${!empty advancePayment.cashier.cashRemark}">
						${advancePayment.cashier.cashRemark }
					</c:if>
				</td>
		</tr>
	</table>
			</c:forEach>
		</c:if>
		  </div>
		  
		  	<c:if test="${param.type==3 }" var="sta">
			   <div class="tab-pane active" id="construct" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="construct">
			</c:if>
				<c:if test="${empty(orderContractExpenses)||orderContractExpenses==null }" var="status">
					<div class="alert alert-info">
						<strong>提示!</strong> 当前没有车款收银数据.
					</div>
				</c:if>
				<c:if test="${!empty(orderContractExpenses)||orderContractExpenses!=null }" >
					<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
						<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">合同基础信息</td>
						</tr>
						<tr height = "30">
							<td style="width:20%">车型：&nbsp;</td>
							<td style="width:30%;color:red;" >
									${orderContractExpenses.customer.customerPidBookingRecord.brand.name}
									${orderContractExpenses.customer.customerPidBookingRecord.carSeriy.name}
									${orderContractExpenses.customer.customerPidBookingRecord.carModel.name}
									${orderContractExpenses.customer.customerPidBookingRecord.vinCode}</td>
							<td style="width:20%" >合同总金额：&nbsp;</td>
							<td style="width:30%;color:red;font-size: 20px" id="totalcontractAmount">${orderContractExpenses.totalPrice }</td>
						</tr>
						<tr height = "30">
							<td style="width:20%">客户姓名：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.customer.name }</td>
							<td style="width:20%" >电话号码：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.customer.mobilePhone }</td>
						</tr>
						<tr height = "30">
							<td style="width:20%">购车定金：&nbsp;</td>
							<td style="width:30%"  id="orderMoney">${orderContractExpenses.orderMoney }</td>
							<td style="width:20%" >销售代表：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.customer.user.realName }</td>
						</tr>
						<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">车辆费用信息</td>
						</tr>
						<tr height="30">
							<td style="width:20%">经销商报价：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.salePrice }</td>
							<td style="width:20%" >裸车销售顾问结算价：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
						</tr>
						<tr height="30">
							<td style="width:20%">颜色溢价：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.colorPrice}</td>
							<td style="width:20%" >裸车销售价：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
						</tr>
						<tr height="30"style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">优惠明细</td>
						</tr>
						<tr height="30">
							<td style="width:20%">裸车现金优惠：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.cashBenefit}</td>
							<td style="width:20%" >未这让权限：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.noWllowancePrice}</td>
						</tr>
						<tr height="30">
							<td style="width:20%">特殊权限：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.specialPermPrice}</td>
							<td style="width:20%" >特殊权限说明：&nbsp;</td>
							<td style="width:30%">		
								<c:if test="${empty orderContractExpenses.specialPermNote}">
									无
								</c:if>
								<c:if test="${!empty orderContractExpenses.specialPermNote}">
									${orderContractExpenses.specialPermNote}
								</c:if>
							</td>
						</tr>
						<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">保险明细</td>
						</tr>
						<tr height="30">
							<td style="width:20%">预收保费：&nbsp;</td>
							<td style="width:30%">0.0</td>
							<td style="width:20%" >续保押金：&nbsp;</td>
							<td style="width:30%">0.0</td>
						</tr>
						</table>
						<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
						<tr height="30"style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">金融明细</td>
						</tr>
						<tr height="30">
							<td style="width:20%">购车方式：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.buyCarType==1?'现款':'分付' }</td>
							<td style="width:20%" >付款方式：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.payWay==1?'现金':'转账' }</td>
						</tr>
						<tr height="30">
							<td style="width:20%">手续费：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.ajsxf }</td>
							<td style="width:20%" >首付款：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.sfk }</td>
						</tr>
						<tr height="30">
							<td style="width:20%">贷款金额：&nbsp;</td>
							<td colspan="3" id="daikuan">${orderContractExpenses.daikuan }</td>
						</tr>
						<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
								<td width="100%" colspan="4" style="">定金装饰</td>
						</tr>
						<tr height="30">
							<td style="width:20%">购车定金：&nbsp;</td>
							<td style="width:30%" id="orderMoney">${orderContractExpenses.orderMoney }</td>
							<td style="width:20%" >装饰款：&nbsp;</td>
							<td style="width:30%" id="decoreMoneyText"></td>
						</tr>
						<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
								<td width="100%" colspan="4" style="">总费用明细</td>
							</tr>
						<tr height="30">
							<td style="width:20%">预收款总额：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.advanceTotalPrice}</td>
							<td style="width:20%" >其他收费总额：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.otherFeePrice}</td>
						</tr>
						<tr height="30">
							<td style="width:20%">裸车销售价：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.carSalerPrice }</td>
							<td style="width:20%" >合同总金额：&nbsp;</td>
							<td style="width:30%">${orderContractExpenses.totalPrice }</td>
						</tr>
						<tr height="30">
							<td style="width:20%">应收总额：&nbsp;</td>
							<td style="width:30%;color:red;font-size:20px" id="totalReceivables1"></td>
							<td  colspan="2"  id="describe">&nbsp;</td>
						</tr>
				<c:forEach var="cashier" items="${carCashiers }">
					<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">${cashier.orderNo} 收费信息</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
						<td style="width:30%">
							${cashier.receiptNumber}
						</td>
						<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
						<td style="width:30%">
							${cashier.orderNo}
						</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
						<td style="width:30%">
							<span style="color: red;">
								<c:if test="${empty cashier.amountCollected}">
									0.0
								</c:if>
								<c:if test="${!empty cashier.amountCollected}">
									${cashier.amountCollected}
								</c:if>
							</span>
						</td>
						<td class="formTableTdLeft">开票金额:&nbsp;</td>
						<td>
							<span style="color: red;">
								<c:if test="${empty cashier.openBillingMoney}">
									0.0
								</c:if>
								<c:if test="${!empty cashier.openBillingMoney}">
									${cashier.openBillingMoney}
								</c:if>
							</span>
						</td>
					</tr>	
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
						<td style="width:30%">
							<c:if test="${empty(cashier.openBillingType) }">
								无
							</c:if>
							${cashier.openBillingType.name }
						</td>
						<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
						<td style="width:30%">
							${cashier.childBillingType.name }
						</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft">收银时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.cashierTime}"/> 
						</td>
						<td class="formTableTdLeft">收款人:&nbsp;</td>
						<td>
							${cashier.payee}
						</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft">创建时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
						<td class="formTableTdLeft">修改时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${cashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
					</tr>
				<tr height="30">
					<td class="formTableTdLeft">支付方式:&nbsp;</td>
						<td colspan="3">
							<ystech:cashierPay orderNo="${cashier.orderNo }"/>
						</td>
				</tr>
				<tr height="30">
					<td class="formTableTdLeft">摘要:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty cashier.abstract_}">
								无
							</c:if>
							<c:if test="${!empty cashier.abstract_}">
								${cashier.abstract_ }
							</c:if>
						</td>
				</tr>
				<tr height="30">
					<td class="formTableTdLeft">备注:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty cashier.cashRemark}">
								无
							</c:if>
							<c:if test="${!empty cashier.cashRemark}">
								${cashier.cashRemark }
							</c:if>
						</td>
				</tr>
				</c:forEach>
				<c:if test="${orderContractExpenses.isCorrect eq 2}">
					<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">修正记录</td>
					</tr>
					<tr height = "30">
						<td class="formTableTdLeft">修正金额:&nbsp;</td>
						<td>
							<span style="color:red">${orderContractExpenses.totalReceivables-orderContractExpenses.totalCollection }</span>
						</td>
						<td class="formTableTdLeft">修正备注:&nbsp;</td>
						<td>
							${orderContractExpenses.correctRemark }
						</td>
					</tr>
				</c:if>
			</table>
				</c:if>	
		  </div>
		  	<c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carTransfer" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carTransfer">
			</c:if>
				<c:if test="${empty(customertracks)||customertracks==null }" var="status">
						<div class="alert alert-info">
							<strong>提示!</strong> 当前未添加数据.
						</div>
					</c:if>
					<c:if test="${status==false }">
						<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
							<thead>
							<tr>
								<td style="width:80px;">跟进日期</td>
								<td style="width:40px;">跟进方法</td>
								<td style="width: 40px;">意向级别</td>
								<td style="width: 80px;">下次预约时间</td>
								<td style="width:120px;">跟进内容</td>
								<td style="width: 120px;">沟通结果</td>
								<td style="width: 80px;">客户反馈问题</td>
								<td style="width: 80px;">对应措施</td>
								<td style="width: 80px;">展厅经理意见</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${customertracks }" var="customerTrack">
							<tr>
								<td>
									<fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd HH:mm"/> 
								</td>
								<td>
									<c:if test="${customerTrack.trackMethod==1 }">
										电话
									</c:if>
									<c:if test="${customerTrack.trackMethod==2 }">
										到店
									</c:if>
									<c:if test="${customerTrack.trackMethod==3 }">
										短信
									</c:if>
									<c:if test="${customerTrack.trackMethod==4 }">
										回访
									</c:if>
								</td>
								<td>
									${customerTrack.beforeCustomerPhase.name}
								</td>
								<td>
									<fmt:formatDate value="${customerTrack.nextReservationTime}" pattern="yyyy-MM-dd HH:mm"/> 
								</td>
								
								<td style="text-align: left;">
										${customerTrack.trackContent }
								</td>
								<td style="text-align: left;">
										${customerTrack.result }
								</td>
								<td style="text-align: left;">
										${customerTrack.feedBackResult }
								</td>
								<td style="text-align: left;">
										${customerTrack.dealMethod }
								</td>
								<td style="text-align: left;">
										${customerTrack.showroomManagerSuggested }
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					</c:if>
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carOperateLog" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carOperateLog">
			</c:if>
		  		<c:if test="${fn:length(cwCustOperatorLogs)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无客户操作日志
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-bottom: 32px;">
						<thead>
							<tr>
								<td style="width: 40px;">
									序号		
								</td>
								<td style="width: 120px;">操作类型</td>
								<td style="width: 80px;">操作时间</td>
								<td style="width: 80px;">操作人</td> 
								<td style="width: 120px;">备注</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${cwCustOperatorLogs}" var="finOperatorLog" varStatus="i">
							<tr >
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td>
									${finOperatorLog.type }
								</td>
								<td>
									<fmt:formatDate value="${finOperatorLog.operateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	 
								</td>
								<td>
									${finOperatorLog.operator}
								</td>
								<td style="text-align: left;">
									${finOperatorLog.note}
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
		  </div>
		  <c:if test="${param.type==5 }" var="sta">
			   <div class="tab-pane active" id="insurance" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="insurance">
			</c:if>
		  		<c:if test="${empty(insuranceRecords)||insuranceRecords==null }" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无该客户保险收银记录
					</div>
				</c:if>
				<c:if test="${!empty(insuranceRecords)&&insuranceRecords!=null }" >
					<c:forEach var="insuranceRecord" items="${insuranceRecords}">
						<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
							<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
											<td width="100%" colspan="4" style="">客户信息</td>
							</tr>
							<tr height = "42px">
								<td style="width:20%">姓名：&nbsp;</td>
								<td style="width:30%;color:green;font-size:20px" >
										${insuranceRecord.insCustomer.name }
								<td>电话号码：&nbsp;</td>
								<td >
										${insuranceRecord.insCustomer.mobilePhone}
								</td>
							</tr>
						</table> 
				<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="40" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
				<td width="100%" colspan="4" style="">保险信息</td>
				</tr>
				<tr height="30">
					<td style="width:20%">购买日期:</td>
					<td style="width:30%">${insuranceRecord.buyDate}</td>	
					<td style="width:20%">起保日期:</td>
					<td style="width:30%">${insuranceRecord.beginDate}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">脱保日期:</td>
					<td style="width:30%">${insuranceRecord.endDate}</td>	
					<td style="width:20%">出单公司:</td>
					<td style="width:30%">${insuranceRecord.insuranceCompany.name}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">交强险项目:</td>
					<td style="width:30%">${insuranceRecord.strongRisk}</td>	
					<td style="width:20%">交强险金额:</td>
					<td style="width:30%">${insuranceRecord.strongRiskPrice}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">商业险项目:</td>
					<td style="width:30%">${insuranceRecord.busiRisk}</td>	
					<td style="width:20%">商业险金额:</td>
					<td style="width:30%">${insuranceRecord.busiRiskPrice}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">强制险返利金额:</td>
					<td style="width:30%">${insuranceRecord.strongRiskRebateMoney}</td>	
					<td style="width:20%">商业险返利金额:</td>
					<td style="width:30%">${insuranceRecord.busiRiskRebateMoney}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">返利总金额:</td>
					<td style="width:30%">${insuranceRecord.rebateMoney}</td>	
					<td style="width:20%">客户附件权益:</td>
					<td style="width:30%">${insuranceRecord.incidentalInterestMoney}</td>					
				</tr>
				<tr height="30">
					<td style="width:20%">保险记录 类型:</td>
					<td style="width:30%">
						<c:choose>
					<c:when test="${insuranceRecord.insType eq 1}">
						保有客户购买
					</c:when>
					<c:when test="${insuranceRecord.insType eq 2}">
						保有客户续保
					</c:when>
					<c:when test="${insuranceRecord.insType eq 3}">
						外来客户购买
					</c:when>
					<c:when test="${insuranceRecord.insType eq 4}">
						外来客户续保
					</c:when>
				</c:choose>
					</td>	
					<td style="width:20%">销售人员:</td>
					<td style="width:30%">${insuranceRecord.saler}</td>					
				</tr>
				<tr height="30"style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<td width="100%" colspan="4" style="">收费信息</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
						<td style="width:30%">
							${insuranceRecord.cashier.receiptNumber}
						</td>
						<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
						<td style="width:30%">
							${insuranceRecord.cashier.orderNo}
						</td>
					</tr>
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
						<td style="width:30%">
							<span style="color: red;">
								<c:if test="${empty insuranceRecord.cashier.amountCollected}">
									0.0
								</c:if>
								<c:if test="${!empty insuranceRecord.cashier.amountCollected}">
									${insuranceRecord.cashier.amountCollected}
								</c:if>
							</span>
						</td>
						<td class="formTableTdLeft">开票金额:&nbsp;</td>
						<td>
							<span style="color: red;">
								<c:if test="${empty insuranceRecord.cashier.openBillingMoney}">
									0.0
								</c:if>
								<c:if test="${!empty insuranceRecord.cashier.openBillingMoney}">
									${insuranceRecord.cashier.openBillingMoney}
								</c:if>
							</span>
						</td>
					</tr>	
					<tr height="30">
						<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
						<td style="width:30%">
							<c:if test="${empty(insuranceRecord.cashier.openBillingType) }">
								无
							</c:if>
							${insuranceRecord.cashier.openBillingType.name }
						</td>
						<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
						<td style="width:30%">
							${insuranceRecord.cashier.childBillingType.name }
						</td>
					</tr>
					<tr height = "30">
						<td class="formTableTdLeft">收银时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${insuranceRecord.cashier.cashierTime}"/> 
						</td>
						<td class="formTableTdLeft">收款人:&nbsp;</td>
						<td>
							${insuranceRecord.cashier.payee}
						</td>
					</tr>
					<tr height = "30">
						<td class="formTableTdLeft">创建时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${insuranceRecord.cashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
						<td class="formTableTdLeft">修改时间:&nbsp;</td>
						<td>
							<fmt:formatDate value="${insuranceRecord.cashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
						</td>
					</tr>
				<tr height = "30">
					<td class="formTableTdLeft">支付方式:&nbsp;</td>
						<td colspan="3">
							<ystech:cashierPay orderNo="${insuranceRecord.cashier.orderNo }"/>
						</td>
				</tr>
				<tr height = "30">
					<td class="formTableTdLeft">收银客户:&nbsp;</td>
					<td colspan="3">
						<%-- <c:forEach var="customerName" items="${customerNames }" >
							<span class="cust" style="">${customerName}</span>
						</c:forEach> --%>
						${insuranceRecord.cashier.customerNames}
					</td>
				</tr>
				<tr height = "30">
					<td class="formTableTdLeft">摘要:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty insuranceRecord.cashier.abstract_}">
								无
							</c:if>
							<c:if test="${!empty insuranceRecord.cashier.abstract_}">
								${insuranceRecord.cashier.abstract_ }
							</c:if>
						</td>
				</tr>
				<tr height = "30">
					<td class="formTableTdLeft">备注:&nbsp;</td>
						<td colspan="3">
							<c:if test="${empty insuranceRecord.cashier.cashRemark}">
								无
							</c:if>
							<c:if test="${!empty insuranceRecord.cashier.cashRemark}">
								${insuranceRecord.cashier.cashRemark }
							</c:if>
						</td>
				</tr>
			</table>
			</c:forEach>
			</c:if>
			</div>
			 <c:if test="${param.type==6}" var="sta">
			  <div class="tab-pane active" id="finance" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="finance">
			</c:if>
		  	<c:if test="${empty(finCustomer)||finCustomer==null }" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无该客户金融收银记录
					</div>
			</c:if>
			<c:if test="${!empty(finCustomer)&&finCustomer!=null }">
					<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
						<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
									<td width="100%" colspan="4" style="">贷款人信息</td>
						</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">申请人:&nbsp;</td>
								<td style="width:30%">${finCustomer.name }</td>
								<td class="formTableTdLeft" style="width:20%">申请人电话:&nbsp;</td>
								<td style="width:30%">${finCustomer.mobilePhone }</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">身份证号:&nbsp;</td>
								<td style="width:30%">${finCustomer.icard }</td>
								<td class="formTableTdLeft" style="width:20%">地址:&nbsp;</td>
								<td style="width:30%">
									${finCustomer.address }
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">共申人:&nbsp;</td>
								<td style="width:30%">${finCustomer.commName }</td>
								<td class="formTableTdLeft" style="width:20%">共申人电话:&nbsp;</td>
								<td style="width:30%">${finCustomer.commMobilePhone }</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">车型:&nbsp;</td>
								<td style="width:30%">
									${finCustomer.carSeriyName }
								</td>
								<td class="formTableTdLeft" style="width:20%">销售员:&nbsp;</td>
								<td style="width:30%">${finCustomer.saler }</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">销售员电话:&nbsp;</td>
								<td style="width:30%">${finCustomer.salerPhone }</td>
								<td class="formTableTdLeft" style="width:20%">车辆销售商：</td>
								<td  colspan="3">
									${finCustomer.distributor.name }
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">贷款金额：</td>
								<td style="width:30%">${finCustomer.finCustomerLoan.loanPrice }</td>
								<td class="formTableTdLeft" style="width:20%">贴息金额：</td>
								<td style="width:30%">
									<ystech:discountMoney custId="${finCustomer.customer.dbid }"/>
								</td>
							</tr>
						<tr>
							<td class="formTableTdLeft" style="width:20%">实际利息:&nbsp;</td>
							<td style="text-align:lcenter;">
								<span style="color: red;">${finCustomer.finCustomerLoan.actDiscountPrice}</span>
							</td>
							<td class="formTableTdLeft" style="width:20%">公司贴息:&nbsp;</td>
							<td style="text-align:lcenter;">
								${finCustomer.finCustomerLoan.companyDiscountPrice}
							</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft" style="width:20%">销售收取贴息：&nbsp;</td>
							<td 	colspan="3">
								${finCustomer.finCustomerLoan.salerDiscountPrice}
							</td>
						</tr>
						<c:forEach var="finCashier" items="${finCashiers }">
							<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
								<c:if test="${finCashier.typeId eq 5}">
									<td width="100%" colspan="4" style="">金融收费信息</td>
								</c:if>
								<c:if test="${finCashier.typeId eq 7}">
									<td width="100%" colspan="4" style="">金融贴息收费信息</td>
								</c:if>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
								<td style="width:30%">
									${finCashier.receiptNumber}
								</td>
								<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
								<td style="width:30%">
									${finCashier.orderNo}
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
								<td style="width:30%">
									<span style="color: red;">
										<c:if test="${empty finCashier.amountCollected}">
											0.0
										</c:if>
										<c:if test="${!empty finCashier.amountCollected}">
											${finCashier.amountCollected}
										</c:if>
									</span>
								</td>
								<td class="formTableTdLeft">开票金额:&nbsp;</td>
								<td>
									<span style="color: red;">
										<c:if test="${empty finCashier.openBillingMoney}">
											0.0
										</c:if>
										<c:if test="${!empty finCashier.openBillingMoney}">
											${finCashier.openBillingMoney}
										</c:if>
									</span>
								</td>
							</tr>	
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
								<td style="width:30%">
									<c:if test="${empty(finCashier.openBillingType) }">
										无
									</c:if>
									${finCashier.openBillingType.name }
								</td>
								<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
								<td style="width:30%">
									${finCashier.childBillingType.name }
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft">收银时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${finCashier.cashierTime}"/> 
								</td>
								<td class="formTableTdLeft">收款人:&nbsp;</td>
								<td>
									${finCashier.payee}
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft">创建时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${finCashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
								</td>
								<td class="formTableTdLeft">修改时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${finCashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
								</td>
							</tr>
						<tr height="30">
							<td class="formTableTdLeft">支付方式:&nbsp;</td>
								<td colspan="3">
									<ystech:cashierPay orderNo="${finCashier.orderNo }"/>
								</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft">摘要:&nbsp;</td>
								<td colspan="3">
									<c:if test="${empty finCashier.abstract_}">
										无
									</c:if>
									<c:if test="${!empty finCashier.abstract_}">
										${finCashier.abstract_ }
									</c:if>
								</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft">备注:&nbsp;</td>
								<td colspan="3">
									<c:if test="${empty finCashier.cashRemark}">
										无
									</c:if>
									<c:if test="${!empty finCashier.cashRemark}">
										${finCashier.cashRemark }
									</c:if>
								</td>
						</tr>
						</c:forEach>
					</table>
			</c:if>
			</div>
			 <c:if test="${param.type==7 }" var="sta">
			   <div class="tab-pane active" id="factoryRebate" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="factoryRebate">
			</c:if>
		  		<c:if test="${empty(rebateCashiers)||rebateCashiers==null }" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无该客户工厂返利收银记录
					</div>
				</c:if>
				<c:if test="${!empty(rebateCashiers)&&rebateCashiers!=null }">
					<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
						<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">车辆信息</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft" style="width:20%" >VIN码:&nbsp;</td>
							<td style="width:30%">
								<!-- <input type="text" name="bill.custName" id="custName" onfocus="autoInfo('custName')" placeholder="请输入车辆的VIN码" class="large text" title="vin码" checkType="string,1,30" tip="VIN码不能为空"/><span style="color:red;">*</span> -->
								${factoryOrder.vinCode }
							</td>
							<td class="formTableTdLeft" style="width:20%">车辆名称:&nbsp;</td>
							<td style="width:30%">
								<!-- <input type="text" name="carName" id="carName" class="large text" title="车辆名称" checkType="string,1,30" tip="车辆名称" readonly="readonly"> -->
								${factoryOrder.carSeriy.name}${factoryOrder.carModel.name }${factoryOrder.carColor.name }
							</td>	
						</tr>
						<c:forEach var="rebate" items="${factoryOrder.rebate}">
							<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
								<td width="100%" colspan="4" style="">工厂返利信息</td>
							</tr>
							<tr>
								<td class="formTableTdLeft">${rebate.name }金额：&nbsp;</td>
								<td>
									${rebate.rebateMoney }
								</td>
								<td class="formTableTdLeft">${rebate.name }实收金额：&nbsp;</td>
								<td>
									<c:if test="${empty rebate.realRebateMoney }">
										0.0
									</c:if>
									<c:if test="${!empty rebate.realRebateMoney }">
										${rebate.realRebateMoney }
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<c:forEach var="rebateCashier" items="${rebateCashiers }">
							<tr height="30" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
								<td width="100%" colspan="4" style="">收费信息</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%" >收据号:&nbsp;</td>
								<td style="width:30%">
									${rebateCashier.receiptNumber}
								</td>
								<td class="formTableTdLeft" style="width:20%" >订单号:&nbsp;</td>
								<td style="width:30%">
									${rebateCashier.orderNo}
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">收款金额:&nbsp;</td>
								<td style="width:30%">
									<span style="color: red;">
										<c:if test="${empty rebateCashier.amountCollected}">
											0.0
										</c:if>
										<c:if test="${!empty rebateCashier.amountCollected}">
											${rebateCashier.amountCollected}
										</c:if>
									</span>
								</td>
								<td class="formTableTdLeft">开票金额:&nbsp;</td>
								<td>
									<span style="color: red;">
										<c:if test="${empty rebateCashier.openBillingMoney}">
											0.0
										</c:if>
										<c:if test="${!empty rebateCashier.openBillingMoney}">
											${rebateCashier.openBillingMoney}
										</c:if>
									</span>
								</td>
							</tr>	
							<tr height="30">
								<td class="formTableTdLeft" style="width:20%">开票类型:&nbsp;</td>
								<td style="width:30%">
									<c:if test="${empty(rebateCashier.openBillingType) }">
										无
									</c:if>
									${rebateCashier.openBillingType.name }
								</td>
								<td class="formTableTdLeft" style="width:20%">发票类型:&nbsp;</td>
								<td style="width:30%">
									${rebateCashier.childBillingType.name }
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft">收银时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${rebateCashier.cashierTime}"/> 
								</td>
								<td class="formTableTdLeft">收款人:&nbsp;</td>
								<td>
									${rebateCashier.payee}
								</td>
							</tr>
							<tr height="30">
								<td class="formTableTdLeft">创建时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${rebateCashier.createTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
								</td>
								<td class="formTableTdLeft">修改时间:&nbsp;</td>
								<td>
									<fmt:formatDate value="${rebateCashier.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate>
								</td>
							</tr>
						<tr height="30">
							<td class="formTableTdLeft">支付方式:&nbsp;</td>
							<td colspan="3">
								<ystech:cashierPay orderNo="${rebateCashier.orderNo }"/>
							</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft">收银车辆返利:&nbsp;</td>
							<td colspan="3">
								${rebateCashier.customerNames }
							</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft">摘要:&nbsp;</td>
								<td colspan="3">
									<c:if test="${empty rebateCashier.abstract_}">
										无
									</c:if>
									<c:if test="${!empty rebateCashier.abstract_}">
										${rebateCashier.abstract_ }
									</c:if>
								</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft">备注:&nbsp;</td>
								<td colspan="3">
									<c:if test="${empty rebateCashier.cashRemark}">
										无
									</c:if>
									<c:if test="${!empty rebateCashier.cashRemark}">
										${rebateCashier.cashRemark }
									</c:if>
								</td>
						</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
			 <c:if test="${param.type==8}" var="sta">
			  <div class="tab-pane active" id="expenditure" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="expenditure">
			</c:if>
		  	<c:if test="${empty(expenditures)||expenditures==null }" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无该客户支出记录
					</div>
			</c:if>
			<c:if test="${!empty(expenditures)&&expenditures!=null }">
				<c:forEach var="expenditure" items="${expenditures }">
					<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
						<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
							<td width="100%" colspan="4" style="">支出信息</td>
						</tr>
						<tr height = "42px">
							<td style="width:20%">支出信息：&nbsp;</td>
							<td style="width:30%;color:green;font-size:20px" >
									${expenditure.custNames }
							</td>
							<td>电话号码：&nbsp;</td>
							<td >
									<c:if test="${empty expenditure.custTel }">
										无
									</c:if>
									<c:if test="${!empty expenditure.custTel}">
										${expenditure.custTel }
									</c:if>
							</td>
						</tr>
						<tr height = "42px">
							<td style="width:20%">支出单号：&nbsp;</td>
							<td style="width:30%" >
									${expenditure.expenditureSingleNumber }
							</td>
							<td style="width:20%">支出金额：&nbsp;</td>
							<td style="width:30%" >
									${expenditure.expenditureAmount }
							</td>
						</tr>
						<tr height = "42px">
							<td style="width:20%">支出项目：&nbsp;</td>
							<td style="width:30%" >
									${expenditure.expenditureItem }
							</td>
							<td style="width:20%">支出时间：&nbsp;</td>
							<td style="width:30%" >
									${expenditure.expenditureDate }
							</td>
						</tr>
						<tr height = "42px">
							<td style="width:20%">销售人员：&nbsp;</td>
							<td style="width:30%" >
									<c:if test="${empty expenditure.user.realName }">
										无
									</c:if>
									<c:if test="${empty expenditure.user.realName }">
										${expenditure.user.realName }
									</c:if>
							</td>
							<td style="width:20%">支出人：&nbsp;</td>
							<td style="width:30%" >
									${expenditure.payee }
							</td>
						</tr>
						<tr height = "42px">
							<td style="width:20%">备注</td>
							<td colspan="3">
								${expenditure.remarks}
								<c:if test="${empty expenditure.remarks }">
									无
								</c:if>
								<c:if test="${!empty expenditure.remarks }">
									${expenditure.remarks }
								</c:if>
							</td>
						</tr>
					</table> 
				</c:forEach>
			</c:if>
		</div>
			<c:if test="${param.type==9}" var="sta">
			  <div class="tab-pane active" id="bill" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="bill">
			</c:if>
		  	<c:if test="${empty(bills)||bills==null }" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>无该客户挂账记录
					</div>
			</c:if>
			<c:if test="${!empty(bills)&&bills!=null }">
				<c:forEach var="bill" items="${bills }"> 
					<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
						<tr height="30">
							<td class="formTableTdLeft" style="width:20%" >挂账单号:&nbsp;</td>
							<td style="width:30%">
								${bill.singleNumber}
							</td>
							<td class="formTableTdLeft" style="width:20%" >挂账人:&nbsp;</td>
							<td style="width:30%">
								${bill.agent}
							</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft" style="width:20%" >挂账信息:&nbsp;</td>
							<td style="width:30%">
								${bill.custName}
							</td>
							<td class="formTableTdLeft" style="width:20%">挂账类型:&nbsp;</td>
							<td style="width:30%">
								<c:if test="${bill.billType eq 1}">
									应收挂账
								</c:if>
								<c:if test="${bill.billType eq 2}">
									应付挂账
								</c:if>
							</td>	
						</tr>
						<tr height="30">
							<td class="formTableTdLeft" style="width:20%">挂账项目:&nbsp;</td>
							<td style="width:30%">
							 	<c:choose>
									<c:when test="${bill.billProject eq 1}">
										保险返利挂账
									</c:when>
									<c:when test="${bill.billProject eq 2}">
										金融应收挂账
									</c:when>
									<c:when test="${bill.billProject eq 3}">
										车辆成本应付挂账
									</c:when>
									<c:when test="${bill.billProject eq 4}">
										装饰成本应付挂账（无销售部）
									</c:when>
									<c:when test="${bill.billProject eq 5}">
										配件应付挂账
									</c:when>
									<c:when test="${bill.billProject eq 6}">
										工厂返利挂账
									</c:when>
									<c:when test="${bill.billProject eq 7}">
										装饰成本应付挂账（有销售部）
									</c:when>
								</c:choose> 
							</td>
							<td class="formTableTdLeft" style="width:20%">挂账单位名称:&nbsp;</td>
							<td style="width:30%">
								${bill.billCompany}
							</td>
						</tr>
						<tr height="30">
							<td class="formTableTdLeft" style="width:20%">挂账单位电话:&nbsp;</td>
							<td style="width:30%">
								<c:if test="${empty bill.companyTel}">
									无
								</c:if>
								<c:if test="${!empty bill.companyTel}">
									${bill.companyTel }
								</c:if>
							</td>
							<td class="formTableTdLeft">挂账日期:&nbsp;</td>
							<td>
								${bill.billDate }
							</td>
						</tr>	
						<tr height="30">
						<td class="formTableTdLeft" style="width:20%">
								<c:if test="${bill.billType eq 1}">
									应收款金额:&nbsp;
								</c:if>
								<c:if test="${bill.billType eq 2}">
									应付款金额&nbsp;
								</c:if>
							</td>
							<td style="width:30%">
								<c:if test="${empty bill.totalPayOrReceive}">
									0.0
								</c:if>
								<c:if test="${!empty bill.totalPayOrReceive}">
									${bill.totalPayOrReceive }
								</c:if>
							</td>
							<td class="formTableLeft" style="width:20%">挂账金额:&nbsp;</td>
							<td style="width:30%">
								<c:if test="${empty bill.billAmount}">
									0.0
								</c:if>
								<c:if test="${!empty bill.billAmount}">
									${bill.billAmount }
								</c:if>
							</td>
						</tr>
					<tr height="30">
					<td class="formTableTdLeft">
							<c:if test="${bill.billType eq 1}">
								是否到帐:&nbsp;
							</c:if>
							<c:if test="${bill.billType eq 2}">
								是否付款:&nbsp;
							</c:if>
						</td>
						<td>
								<c:if test="${bill.isToAccount eq 1}">
									是
								</c:if>
								<c:if test="${bill.isToAccount eq 2}">
									否
								</c:if>
						</td>
					<td class="formTableTdLeft">
						<c:if test="${bill.billType eq 1}">
								本次回款:&nbsp;
						</c:if>
						<c:if test="${bill.billType eq 2}">
								本次付款:&nbsp;
						</c:if>
					</td>
						<td>
								<c:if test="${empty bill.thisReturn }">
									0.0
								</c:if>
								<c:if test="${!empty bill.thisReturn }">
									${bill.thisReturn }
								</c:if>
						</td>
				</tr>
				<tr height="30">
					<td class="formTableTdLeft">
							<c:if test="${bill.billType eq 1}">
								累计回款:&nbsp;
							</c:if>
							<c:if test="${bill.billType eq 2}">
								累计付款:&nbsp;
							</c:if>
						</td>
						<td>
							<c:if test="${empty bill.accumulativeReturn }">
								0.0
							</c:if>
							<c:if test="${!empty bill.accumulativeReturn }">
								${bill.accumulativeReturn }
							</c:if>
						</td>
					<td class="formTableTdLeft">差额:&nbsp;</td>
						<td>
							<c:if test="${empty bill.difference}">
								0.0
							</c:if>
							<c:if test="${!empty bill.difference}">
								${bill.difference }
							</c:if>
						</td>
				
				</tr height="30">
					<tr>
						<td class="formTableTdLeft">付款期限(天):&nbsp;</td>
						<td>
							<c:if test="${empty bill.termOfPayment}">
								无
							</c:if>
							<c:if test="${!empty bill.termOfPayment}">
								${bill.termOfPayment }
							</c:if>
						</td>
						<td class="formTableTdLeft">是否销账:&nbsp;</td>
						<td>
							<c:if test="${bill.isWriteOff eq 1}">
								是
							</c:if>
							<c:if test="${bill.isWriteOff eq 2}">
								否
							</c:if>
						</td>
					</tr>
					<tr height="30">	
						<td class="formTableTdLeft">销账日期:&nbsp;</td>
						<td>
								<c:if test="${empty bill.writeOffDate}">
									未销账
								</c:if>
								<c:if test="${!empty bill.writeOffDate}">
									${bill.writeOffDate }
								</c:if>
						</td>
						<td >备注：&nbsp;</td>
						<td>
								<c:if test="${empty bill.remarks }">
									无
								</c:if>
								<c:if test="${empty bill.remarks }">
									${bill.remarks }
								</c:if>
						</td>
					</tr>
				</table>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
</body>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
