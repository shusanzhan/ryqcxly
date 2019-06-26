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
<title>金融收银列表</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">金融收银</a>
</div>
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashFinance/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>销售人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  			</tr>
  			<tr>
  				 <td><label>放款状态：</label></td>
  				<td>
  					<select class="text small" id="loanStatus" name="loanStatus" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择</option>
  						<option value="1" ${param.loanStatus==1?'selected="selected"':'' }> 未放款</option>
  						<option value="2" ${param.loanStatus==2?'selected="selected"':'' }>放款</option>
  					</select>
  				</td>
  				<td ><label>放款时间：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align: center;"><label>~</label></td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
	无金融收银
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span4">客户信息</td>
			<td class="span2">车辆信息</td>
			<td class="span2">贷款产品</td>
			<td class="span1">车价</td>
			<td class="span1">开票价</td>
			<td class="span1">手续费</td>
			<td class="span2">放款金额</td>
			<td class="span2">贴息金额</td>
			<td class="span2">实际利息</td>
			<td class="span2">公司帖息</td>
			<td class="span2">放款日期</td>		
			<td class="span2">销售人员</td>
			<td class="span2">放款状态</td>
			<td class="span3">操作</td>
		</tr>
	</thead>
	<c:forEach var="finCustomer" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:left;">
				<a style="color:#2b7dbc" href="${ctx }/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=1">${finCustomer.name }
					<c:if test="${finCustomer.customerType eq 1}">
						（保有）
					</c:if>
					<c:if test="${finCustomer.customerType eq 2}">
						（多品牌）
					</c:if>
					<br>
					${finCustomer.mobilePhone }
				</a>
			</td>
			<td style="text-align:center;">
				${finCustomer.carSeriyName }
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.finProductName }
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.carPrice}
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.kaiPiaoPrice}
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.countFee}
			</td>
			<td style="text-align:center;">
				<span style="color:red">${finCustomer.finCustomerLoan.loanPrice}</span>
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.discountMony}
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.actDiscountPrice}
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.companyDiscountPrice}
			</td>
			<td style="text-align:center;">	
				<fmt:formatDate value="${finCustomer.loanDate}" />
			</td>
			<td style="text-align:center;">
				${finCustomer.saler}
			</td>
			<td style="text-align:center;">
				<c:if test="${finCustomer.loanStatus eq 1}">
					<span style="color: red">未放款</span>
				</c:if>
				<c:if test="${finCustomer.loanStatus eq 2}">
					<span style="color: green;">已放款</span>
				</c:if>
			</td>
			<td style="text-align:center;">
				<a  href="${ctx}/cashFinance/add?dbid=${finCustomer.dbid }" style="color: #2b7dbc;">收银</a>
				<%-- <c:if test="${finCustomer.loanStatus eq 2}">
					<c:if test="${finCustomer.cashStatus eq 1}">
						<a  href="${ctx}/cashFinance/add?dbid=${finCustomer.dbid }" style="color: #2b7dbc;">收银</a>
					</c:if>
					<c:if test="${finCustomer.cashStatus eq 2}">
						<span style="color:green">已收银</span>
					</c:if>
					<c:if test="${finCustomer.discountCashStatus eq 2}">
						<a href="${ctx }/cashFinance/addDiscount?dbid=${finCustomer.dbid}" style="color:#2b7dbc">贴息收银</a>
					</c:if>
					<c:if test="${finCustomer.discountCashStatus eq 3}">
						<span style="color:green">贴息已收银</span>
					</c:if>
				</c:if>
				<c:if test="${finCustomer.loanStatus eq 1}">
					<span style="color:gray">无操作</span>
				</c:if> --%>
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
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/advanceMangement/exportExcel?'+params;
}
</script>
</html>