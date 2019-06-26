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
<title>收银明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">收银明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div id="container" style="min-width:400px;height:400px"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/cashMoneyDetail/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="custName" name=custName class="text small" value="${param.custName}"></input></td>
  				<td><label>电话号码：</label></td>
  				<td><input type="text" id="custTel" name="custTel" class="text small" value="${param.custTel}"></input></td>
  				<td><label>收据号：</label></td>
  				<td><input type="text" id="receiptNumber" name="receiptNumber" class="text small" value="${param.receiptNumber}"></input></td>
  				<td><label>收款类别：</label></td>
  				<td>
  					<select class="text middle" id="typeId"  name="typeId" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.typeId==1?'selected="selected"':'' }>预收收款</option>
  						<option value="2" ${param.typeId==2?'selected="selected"':'' }>车款收款</option>
  						<option value="3" ${param.typeId==3?'selected="selected"':'' }>装饰收款</option>
  						<option value="4" ${param.typeId==4?'selected="selected"':'' }>保险收款</option>
  						<option value="5" ${param.typeId==5?'selected="selected"':'' }>金融收款</option>
  						<option value="6" ${param.typeId==6?'selected="selected"':'' }>工厂返利收款</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>发票类型：</label></td>
  				<td>
  					<select class="text small" id="invoiceTypeId"  name="invoiceTypeId" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<c:forEach var="childBillingType" items="${childBillingTypes }">
  							<option value="${childBillingType.dbid}" ${param.invoiceTypeId==childBillingType.dbid?'selected="selected"':''}>${childBillingType.name }</option>
  						</c:forEach>
  					</select>
  				</td>				
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
	 无收银明细
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<!-- <td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td> -->
			<td class="span2">客户信息</td>
			<td class="span2">收据号</td>
			<td class="span2">收款类别</td>
			<td class="span2">收款金额</td>
			<td class="span2">开票金额</td>
			<td class="span2">发票类型</td>
			<td class="span2">收银时间</td>
			<td class="span2">收银人</td>
		</tr>
	</thead>
	<c:forEach var="cashier" items="${page.result }">
		<tr height="32" align="center">
			<%-- <td><input type='checkbox' name="id" id="id1" value="${settlementReceipts.dbid }"/></td> --%>
			<td style="text-align:lcenter;">
				${cashier.customer.name}
				${cashier.customer.mobilePhone }
			</td>
			<td style="text-align:center;">
				${cashier.receiptNumber}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${cashier.typeId eq 1}">
					预收收款
				</c:if>
				<c:if test="${cashier.typeId eq 2}">
					车款收款
				</c:if>
				<c:if test="${cashier.typeId eq 3}">
					装饰收款
				</c:if>
				<c:if test="${cashier.typeId eq 4}">
					保险收款
				</c:if>
				<c:if test="${cashier.typeId eq 5}">
					金融收款
				</c:if>
				<c:if test="${cashier.typeId eq 6}">
					工厂返利收款
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				${cashier.amountCollected }
			</td>
			<td style="text-align:lcenter;">
				${cashier.openBillingMoney }
			</td>
			<td style="text-align:lcenter;">
				${cashier.childBillingType.name }
			</td>
			<td style="text-align:lcenter;">
				<fmt:formatDate value="${cashier.cashierTime }" />
			</td>
			<td style="text-align:lcenter;">				
				${cashier.payee }
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
<script src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
<script src="https://img.hcharts.cn/highcharts/themes/grid-light.js"></script>
<script type="text/javascript">
var map = '<%=request.getAttribute("countCash")%>';
var obj = eval('('+map+')');
var data1 = "[";
for(var key in obj)
{
	data1=data1+"['"+key+"("+obj[key]+"元)',"+obj[key]+"],"
} 
data1 = data1 + "]";
var data2 = eval('(' + data1 + ')');
var chart = Highcharts.chart('container', {
    title: {
        text: '收款类别占比总揽'
    },
    tooltip: {
        headerFormat: '{series.name}<br>',
        pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: false
            },
            showInLegend: true // 设置饼图是否在图例中显示
        }
    },
    series: [{
        type: 'pie',
        name: '收款类别',
        data: data2
    }]
});
</script>
</html>