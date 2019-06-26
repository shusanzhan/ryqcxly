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
	<a href="javascript:void(-1);" onclick="">车款收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/settlementReceipts/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashReceipt/queryList" method="post">
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
  					<select id="cashierStatus" name="cashierStatus" class="small text" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.cashierStatus==1?'selected="selected"':'' }>待结算</option>
  						<option value="3" ${param.cashierStatus==3?'selected="selected"':'' }>未结完</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  				<td><label>订单开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>订单结束</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
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
			 <td class="span2">车型</td>
			<td class="span2">购车方式</td>
			<td class="span2">合同总金额</td>
			<td class="span2">定金</td>
			<td class="span2">订单状态</td>
			<td class="span2">销售人员</td>
			<td class="span2">订单日期</td>
			<td class= "span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="orderContractExpenses" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:left;">
				<a style="color:#2b7dbc" href="${ctx }/orderContract/viewOrderContract?dbid=${orderContractExpenses.customer.orderContract.dbid }">
				${orderContractExpenses.customer.name }
				<br>
				<c:if test="${empty orderContractExpenses.customer.mobilePhone }">
					无
				</c:if>
				<c:if test="${!empty orderContractExpenses.customer.mobilePhone }">
					${orderContractExpenses.customer.mobilePhone }
				</c:if>
				</a>
			</td>
			<td style="text-align:center;">
				<c:if test="${orderContractExpenses.customer.customerType eq 1}">
					自有店客户
				</c:if>
				<c:if test="${orderContractExpenses.customer.customerType eq 2}">
					二网客户
				</c:if>
			</td>
			<td style="text-align:left;">
				${orderContractExpenses.customer.customerPidBookingRecord.brand.name}
				${orderContractExpenses.customer.customerPidBookingRecord.carSeriy.name}
				${orderContractExpenses.customer.customerPidBookingRecord.carModel.name}<br/>
				${orderContractExpenses.customer.customerPidBookingRecord.vinCode}
			</td>
			<td style="text-align:lcenter;">
				<c:choose>
					<c:when test="${orderContractExpenses.buyCarType eq 1}">
					全款
					</c:when>
					<c:when test="${orderContractExpenses.buyCarType eq 2}">
					分期
					</c:when>
				</c:choose>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${orderContractExpenses.totalPrice}</span>
			</td>
			<td style="text-align:lcenter;">
				<span style="color: red;">${orderContractExpenses.orderMoney}</span>
			</td>
			<td style="text-align:lcenter;">
				 <c:choose>
					<c:when test="${orderContractExpenses.cashierStatus eq 1}">
					<span style="color: red;">待结算</span>	
					</c:when>
					<c:when test="${orderContractExpenses.cashierStatus eq 2}">
						<span style="color: green;">已收款</span>
					</c:when>
					<c:when test="${orderContractExpenses.cashierStatus eq 3}">
						<span style="color: red">未结完</span>
					</c:when>
				</c:choose>
			</td>
			<td style="text-align:lcenter;">
				${orderContractExpenses.customer.bussiStaff}
			</td>
			<td style="text-align:lcenter;">
				<fmt:formatDate value="${orderContractExpenses.orderContract.createTime}"/>
			</td>
			<td style="text-align:lcenter;">
				<a  href="${ctx}/cashReceipt/add?dbid=${orderContractExpenses.dbid}" style="color: #2b7dbc;">收银</a>
				<c:if test="${orderContractExpenses.cashierStatus eq 3 }">
					&nbsp;|
					<a  href="${ctx}/cashReceipt/correct?dbid=${orderContractExpenses.dbid}" style="color: #2b7dbc;">修正</a>
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