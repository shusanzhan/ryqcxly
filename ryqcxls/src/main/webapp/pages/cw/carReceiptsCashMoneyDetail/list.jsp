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
<title>车款收费明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车款收费明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carReceiptsCashMoneyDetail/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name=custName class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>付款方式：</label></td>
  				<td>
  					<select class="text small" id="payType"  name="payType" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择</option>
  						<option value="1" ${param.payType==1?'selected="selected"':'' }>全款</option>
  						<option value="2" ${param.payType==2?'selected="selected"':'' }>分期</option>
  					</select>
  				</td>
  				<td><label>订单状态：</label></td>
  				<td>
  					<select class="text small" id="orderStatus"  name="orderStatus" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择</option>
  						<option value="2" ${param.orderStatus==2?'selected="selected"':'' }>收款</option>
  						<option value="3" ${param.orderStatus==3?'selected="selected"':'' }>未结完</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="saler" name="saler" class="text small" value="${param.saler}"></input></td>
  				<td><label>收款人员：</label></td>
  				<td><input type="text" id="payee" name="payee" class="text small" value="${param.payee}"></input></td>
  				<td><label>收款日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endTime" name="endDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endDate }">
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)}">
	<div class="alert alert-error">
	 无车款收银明细
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<!-- <td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td> -->
			<td class="span3">客户信息</td>
			<td class="span5">车辆信息</td>
			<td class="span2">购车方式</td>
			<td class="span2">收据号</td>
			<td class="span2">合同总金额</td>
			<td class="span2">应收总额</td>
			<td class="span2">本笔总额</td>
			<td class="span2">订单状态</td>
			<td class= "span2">收银日期</td>
			<td class="span2">收银人员</td>
			<td class= "span2">销售人员</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="settlementReceipts" items="${page.result }">
		<tr height="32" align="center">
			<%-- <td><input type='checkbox' name="id" id="id1" value="${settlementReceipts.dbid }"/></td> --%>
			<td style="text-align:lcenter;">
				${settlementReceipts.custName }
				${settlementReceipts.custTel }
			</td>
			<td style="text-align:left;">
				${settlementReceipts.orderContractExpenses.customer.customerPidBookingRecord.brand.name}	
				${settlementReceipts.orderContractExpenses.customer.customerPidBookingRecord.carSeriy.name}
				${settlementReceipts.orderContractExpenses.customer.customerPidBookingRecord.carModel.name}<br/>
				${settlementReceipts.orderContractExpenses.customer.customerPidBookingRecord.vinCode}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${settlementReceipts.settlementType eq 1}">
					<span style="color:green">全款</span>
				</c:if>
				<c:if test="${settlementReceipts.settlementType eq 2}">
					<span style="color: red;">分期</span>
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.receiptNumber}
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.totalcontractAmount}
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.totalReceivables}
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.totalMoney}
			</td>
			<td style="text-align:lcenter;">				
				<c:if test="${settlementReceipts.orderStatus eq 1}">
					结算
				</c:if>
				<c:if test="${settlementReceipts.orderStatus eq 2}">
					<span style="color:green">收款</span>
				</c:if>
				<c:if test="${settlementReceipts.orderStatus eq 3}">
					<span style="color: red;">未结完</span>
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				<fmt:formatDate value="${settlementReceipts.settlementDate}" />
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.payee}
			</td>
			<td style="text-align:lcenter;">
				${settlementReceipts.salesman}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${settlementReceipts.orderStatus eq 3}">
					<a  href="${ctx}/cashReceipts/add?dbid=${settlementReceipts.orderContractExpenses.dbid}" style="color: red;">收银</a>
				</c:if>
				<a href="${ctx}/carReceiptsCashMoneyDetail/cashCarReceiptsDetail?custTel=${settlementReceipts.custTel}" style="color: #2b7dbc;">明细查询</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
</script>
</html>