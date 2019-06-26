<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style type='text/css'>
		.fixcol { position: relative ; LEFT: expression(this.parentElement.offsetParent.parentElement.scrollLeft);
	white-space: nowrap; left:0;
	}
	</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>金融贴息批量收银</title>
</head>
<body class="bodycolor" >
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">金融贴息批量收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		 <a  href="javascript:void(-1)" class="but button"  onclick="batchCash()">批量收银</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashFinance/queryBatchDiscountCashList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable"  >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>出单人员：</label></td>
  				<td><input type="text" id=saleman name="saleman" class="text small" value="${param.saleman}"></input></td>
   			</tr>
   			<tr>
   				<td ><label>放款日期：</label></td>
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
		无贴息收银
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" onchange="sum()"/></td>
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
			<td class="span2">销售人员</td>
			<td class="span3">金融收银状态</td>
			<td class="span3">放款日期</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="finCustomer" items="${page.result }">
		<tr height="32" align="center">
		<td><input type='checkbox' name="id" value="${finCustomer.dbid }" onchange="sum()"/></td>
			<td style="text-align:left;" class="fixcol">
				<a style="color:#2b7dbc" href="${ctx }/finCustomer/finCustomerFile?finCustomerId=${finCustomer.dbid}&type=1">${finCustomer.name }
					<c:if test="${finCustomer.customerType eq 1}">
						（保有）
					</c:if>
					<c:if test="${finCustomer.customerType eq 2}">
						（多品牌）
					</c:if>
					<br>
					${finCustomer.mobilePhone }
					${finCustomer.customer.dbid }
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
				${finCustomer.finCustomerLoan.loanPrice}
			</td>
			<td style="text-align:center;">
				<span style="color:red">${finCustomer.finCustomerLoan.discountMony}</span>
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.actDiscountPrice}
			</td>
			<td style="text-align:center;">
				${finCustomer.finCustomerLoan.companyDiscountPrice}
			</td>
			<td style="text-align:center;">
				${finCustomer.saler}
			</td>
			<td style="text-align:center;">
				<c:if test="${finCustomer.cashStatus eq 2}">
					<span style="color: green;">未收</span>
				</c:if>
			</td>
			<td style="text-align:center;">
				<fmt:formatDate value="${finCustomer.loanDate }"/>
			</td>
			<td style="text-align:center">
				<a href="${ctx }/cashFinance/addDiscount?dbid=${finCustomer.dbid}" style="color:#2b7dbc">贴息收银</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<p id="total" style="display:none;font-size:20px;color:red;cursor:hand">总额:<span id="totals"></span></p>
</body>
<script type="text/javascript">
function batchCash(){
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择批量收银数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
		return false;
	}
	var dbids=getCheckBox();
	window.top.art.dialog({
		content : '确定对【'+length+'】客户,总金额<span style="color:red;">【￥'+sum()+'】</span>进行批量收银吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/cashFinance/batchCash?dbids="+dbids;
		},
		cancel : true
	});
}
function sum(){
	var len = $("input[name='id']:checked");
	var sum = 0;
	for(var i=0;i<len.size();i++){
		var check = len.eq(i);
		var tds = check.parent().siblings();
		if(tds.eq(7).text()!=null && tds.eq(7).text()!=''){
			sum = sum + parseFloat(tds.eq(7).text());
		}
	}
	$("#total").css("display","");
	$("#totals").text(sum);
	return sum;
}
</script>
</html>