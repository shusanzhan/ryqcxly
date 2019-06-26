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
<title>金融收款明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">金融收款明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/settlementReceipts/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/financeCashMoneyDetail/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name=custName class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="saler" name="saler" class="text small" value="${param.saler}"></input></td>
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
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无金融收银明细
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<!-- <td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td> -->
			<td class="span2">客户信息</td>
			<td class="span2">车辆信息</td>
			<td class="span2">销售公司</td>
			<td class="span2">申请状态</td>
			<td class="span2">贷款金额</td>
			<td class="span2">收银金额</td>
			<td class="span2">收银日期</td>
			<td class="span2">收银人员</td>
			<td class="span2">销售人员</td>
			<td class="span3">操作</td>
		</tr>
	</thead>
	<c:forEach var="finCustomer" items="${page.result }">
		<tr height="32" align="center">
			<%-- <td><input type='checkbox' name="id" id="id1" value="${settlementReceipts.dbid }"/></td> --%>
			<td style="text-align:lcenter;">
				${finCustomer.name }<br/>
				${finCustomer.mobilePhone}
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.carSeriyName}
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.saleCompany.name}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${finCustomer.applyStatus eq 1}">
					默认
				</c:if>
				<c:if test="${finCustomer.applyStatus eq 2}">
					成功
				</c:if>
				<c:if test="${finCustomer.applyStatus eq 3}">
					失败
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.finCustomerLoan.loanPrice}
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.amountCollected}
			</td>
			<td style="text-align:lcenter;">	
				<%-- ${decoreOut.cashDate} --%>
				<fmt:formatDate value="${finCustomer.cashDate}"/>
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.saler}
			</td>
			<td style="text-align:lcenter;">
				${finCustomer.payee}
			</td>
			<td style="text-align:lcenter;">
				<a href="${ctx}/financeCashMoneyDetail/cashMoneyDetail?finCustomerDbid=${finCustomer.dbid}" style="color: #2b7dbc;">明细查询</a>
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