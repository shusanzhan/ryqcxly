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
<title>保险收银</title>
</head>
<body class="bodycolor" >
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">保险收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		 <a  href="javascript:void(-1)" class="but button"  onclick="batchCash()">批量收银</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashInsurance/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable"  >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name="custName" class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>出单人员：</label></td>
  				<td><input type="text" id="salesman" name="salesman" class="text small" value="${param.salesman}"></input></td>
  			</tr>
  			<tr>
  				<td><label>出单公司名：</label></td>
  				<td><input type="text" id="insuranceCompanyName" name="insuranceCompanyName" class="text small" value="${param.insuranceCompanyName}"></input></td>
  				<td><label>购买日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td style="text-align:center">
  					~
  				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
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
		无保险收银
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table   cellpadding="0" cellspacing="0" class="mainTable" border="0" style="width: 100%"> 
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')"  onchange="sum()"/></td>
			<td class="span2 fixcol" >客户姓名</td>
			<td class="span2">购买日期</td>
			<td class="span2">保险公司</td>
			<td class="span4">保费</td>
			<td class="span1">返利</td>
			<td class="span1">客户权益</td>
			<td class="span2">出单渠道</td>
			<td class="span2">客户类型</td>
			<td class="span2">投保店</td>
			<td class="span1">收银状态</td>
			<td class="span1">出单人员</td>
		</tr>
	</thead>
	<c:forEach var="insuranceRecord" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" value="${insuranceRecord.dbid }" onchange="sum()"/></td>
			<td style="text-align:left;" class="fixcol">
			<a href="${ctx }/insuranceRecord/insuranceRecordDetail?dbid=${insuranceRecord.dbid }" class="aedit" style="color: #2b7dbc;">
				${insuranceRecord.insCustomer.name }
				<br>
				${insuranceRecord.insCustomer.mobilePhone }
			</a>
			</td>
			<td style="text-align:center;">		
				<fmt:formatDate value="${insuranceRecord.buyDate}" />
			</td>
			<td style="text-align:center;">
				${insuranceRecord.insuranceCompany.name}
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.totalPrice }" pattern="#.00"></fmt:formatNumber>
				</span>
				=<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.strongRiskPrice}" pattern="#.00"></fmt:formatNumber>
				</span> +  
				<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.busiRiskPrice+insuranceRecord.nonDeductiblePrice }" pattern="#.00"></fmt:formatNumber>
				</span>
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">${insuranceRecord.rebateMoney }</span>
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">${insuranceRecord.incidentalInterestMoney }</span>
			</td>
			<td style="text-align:center;">
				${insuranceRecord.insuranceInfrom.name}
			</td>
			<td style="text-align:center;">
				<c:if test="${insuranceRecord.insType eq 1}">
					保有客户购买
				</c:if>
				<c:if test="${insuranceRecord.insType eq 2}">
					保有客户续保
				</c:if>
				<c:if test="${insuranceRecord.insType eq 3}">
					外来客户购买
				</c:if>
				<c:if test="${insuranceRecord.insType eq 4}">
					外来客户续保
				</c:if>
			</td>
			<td style="text-align:center;">
				${insuranceRecord.insEnterprise.name}
			</td>
			<td style="text-align:center;">
				<c:if test="${insuranceRecord.cashierStatus eq 1}">
					<span style="color: red;">待收</span>
				</c:if>
				<c:if test="${insuranceRecord.cashierStatus eq 2}">
					<span style="color: green">已收</span>
				</c:if>
			</td>
			<td style="text-align:center;">
				${insuranceRecord.saler}
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
			window.location.href="${ctx }/cashInsurance/batchCash?dbids="+dbids;
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
		if(tds.eq(4).text()!=null && tds.eq(4).text()!=''){
			sum = sum + parseFloat(tds.eq(4).text());
		}
	}
	$("#total").css("display","");
	$("#totals").text(sum);
	return sum;
}
</script>
</html>