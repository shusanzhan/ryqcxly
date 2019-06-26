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
<title>车款结算收银</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车款明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/settlementReceipts/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashReceipt/queryCashierList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select id="customerType" name="customerType" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.customerType==1?'selected="selected"':'' } >自有客户</option>
  						<option value="2" ${param.customerType==2?'selected="selected"':'' } >二网客户</option>
  					</select>
				</td>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="name" name=name class="text small" value="${param.name}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>订单状态：</label></td>
  				<td>
  					<select id="orderStatus" name="orderStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="2" ${param.orderStatus==2?'selected="selected"':'' }>已收款</option>
  						<option value="3" ${param.orderStatus==3?'selected="selected"':'' }>未结完</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>收据号：</label></td>
  				<td><input type="text" id="receiptNumber" name="receiptNumber" class="text small" value="${param.receiptNumber}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<td><label>订单开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>订单结束：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
   			</tr>
  			<tr>
  				<td><label>购车方式：</label></td>
  				<td>
  					<select id="buyCarType" name="buyCarType" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.buyCarType==1?'selected="selected"':'' } >全款</option>
  						<option value="2" ${param.buyCarType==2?'selected="selected"':'' } >分期</option>
  					</select>
				</td>
				<td><label>收银人员：</label></td>
  				<td><input type="text" id="payee" name="payee" class="text small" value="${param.payee}"></input></td>
  				<td><label>收银开始：</label></td>
  				<td>
  					<input class="small text" id="startCashTime" name="startCashTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startCashTime }" >
  				</td>
  				<td><label>收银结束：</label></td>
  				<td>
  					<input class="small text" id="endCashTime" name="endCashTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endCashTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无车款结算
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">客户姓名</td>
			<td class="span2">客户类型</td>
			<td class="span2">收据号</td>
			 <td class="span2">车型</td>
			<td class="span2">购车方式</td>
			<td class="span2">合同总金额</td>
			<td class="span2">贷款金额</td>
			<td class="span2">定金</td>
			<td class="span2">已收金额</td>
			<td class="span2">结算状态</td>
			<td class="span2">收款日期</td>
			<td class="span2">销售人员</td>
			<td class="span2">收银人员</td>
			<td class= "span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="cashReceipt" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:left;">
				${cashReceipt.customer.name }
				<br>
				<c:if test="${empty cashReceipt.customer.mobilePhone }">
					无
				</c:if>
				<c:if test="${!empty cashReceipt.customer.mobilePhone }">
					${cashReceipt.customer.mobilePhone }
				</c:if>
			</td>
			<td style="text-align:center;">
				<c:if test="${cashReceipt.customer.customerType eq 1}">
					自有店客户
				</c:if>
				<c:if test="${cashReceipt.customer.customerType eq 2}">
					二网客户
				</c:if>
			</td>
			<td style="text-align:center;">
				${cashReceipt.cashier.receiptNumber }
			</td>
			<td style="text-align:left;">
				${cashReceipt.customer.customerPidBookingRecord.brand.name}
				${cashReceipt.customer.customerPidBookingRecord.carSeriy.name}
				${cashReceipt.customer.customerPidBookingRecord.carModel.name}<br/>
				${cashReceipt.customer.customerPidBookingRecord.vinCode}
			</td>
			<td style="text-align:lcenter;">
				<c:choose>
					<c:when test="${cashReceipt.buyCarType eq 1}">
					全款
					</c:when>
					<c:when test="${cashReceipt.buyCarType eq 2}">
					分期
					</c:when>
				</c:choose>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${cashReceipt.totalPrice}</span>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">
					<c:if test="${cashReceipt.buyCarType==1 }">
						全款
					</c:if>
					<c:if test="${cashReceipt.buyCarType==2 }">
						${cashReceipt.daikuan}
					</c:if>
				</span>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${cashReceipt.orderMoney}</span>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${cashReceipt.totalCollection }</span>
			</td>
				<td style="text-align:lcenter;">
				 <c:choose>
					<c:when test="${cashReceipt.cashierStatus eq 1}">
					<span style="color: red;">待结算</span>	
					</c:when>
					<c:when test="${cashReceipt.cashierStatus eq 2}">
						<span style="color: green;">已收款</span>
					</c:when>
					<c:when test="${cashReceipt.cashierStatus eq 3}">
						<span style="color: red">未结完</span>
					</c:when>
				</c:choose>
			</td>
			<td style="text-align:lcenter;">
				<fmt:formatDate value="${cashReceipt.cashier.createTime}"/>
			</td>
			<td style="text-align:lcenter;">
				${cashReceipt.customer.bussiStaff}
			</td>
			<td style="text-align:center">
				${cashReceipt.cashier.payee }
			</td>
			<td style="text-align:lcenter;">
				<a  href="${ctx}/cashReceipt/cashierDetail?dbid=${cashReceipt.dbid}" style="color: #2b7dbc;">收银明细</a>
				<c:if test="${cashReceipt.cashierStatus eq 3}">
					| <a  href="${ctx}/cashReceipt/add?dbid=${cashReceipt.dbid}" style="color: #2b7dbc;"><span style="color:red">收银</span></a>
				</c:if>
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
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
	 function exportExcel(searchFrm){
			var params;
			if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
				params=$("#"+searchFrm).serialize();
			}
			window.location.href='${ctx}/settlementReceipts/exportExcel?'+params;
		}
</script>
</html>