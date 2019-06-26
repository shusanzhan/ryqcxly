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
<title>支付方式收银明细</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">支付方式明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div id="container" style="min-width:400px;height:400px"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/paymentCashMoneyDetail/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<input type="hidden" id="countPayType" name="countPayType" value="${countPayType}">
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>订单号：</label></td>
  				<td><input type="text" id="orderNo" name="orderNo" class="text small" value="${param.orderNo}"></input></td>
  				<td><label>支付方式：</label></td>
  				<td>
  					<select class="text small" id="childPayTypeId"  name="childPayTypeId" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<c:forEach var="childPayType" items="${childPayTypes }">
  							<option value="${childPayType.dbid}" ${param.childPayTypeId==childPayType.dbid?'selected="selected"':'' }>${childPayType.name }</option>
  						</c:forEach>
  					</select>
  				</td>
  				<td><label>订单类型：</label></td>
  				<td>
  					<select class="text small" id="orderTypeId"  name="orderTypeId" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择</option>
  						<option value="1" ${param.orderTypeId==1?'selected="selected"':'' }>购车定金(收)</option>
  						<option value="2" ${param.orderTypeId==2?'selected="selected"':'' }>预收款礼券(收)</option>
  						<option value="3" ${param.orderTypeId==3?'selected="selected"':'' }>会员充值(收)</option>
  						<option value="4" ${param.orderTypeId==4?'selected="selected"':'' }>押金(收)</option>
  						<option value="5" ${param.orderTypeId==5?'selected="selected"':'' }>预收保费(收)</option>
  						<option value="6" ${param.orderTypeId==6?'selected="selected"':'' }>车款(收)</option>
  						<option value="7" ${param.orderTypeId==7?'selected="selected"':'' }>装饰(收)</option>
  						<option value="8" ${param.orderTypeId==8?'selected="selected"':'' }>保险(收)</option>
  						<option value="9" ${param.orderTypeId==9?'selected="selected"':'' }>金融(收)</option>
  						<option value="11" ${param.orderTypeId==11?'selected="selected"':'' }>工厂返利(收)</option>		
  						<option value="14" ${param.orderTypeId==14?'selected="selected"':'' }>车辆成本</option>
  						<c:if test="${isaleDecoreType.decoreType eq 1}">
							<option value="13" ${param.orderTypeId==13?'selected="selected"':'' }>装饰成本(支)</option>
						</c:if>
						<c:if test="${isaleDecoreType.decoreType eq 2}">
							<option value="12" ${param.orderTypeId==12?'selected="selected"':'' }>装饰成本(支)</option>
						</c:if>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>收支类型：</label></td>
  				<td>
  					<select class="text small" id="type"  name="type" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择</option>
  						<option value="1" ${param.type==1?'selected="selected"':'' }>收款</option>
  						<option value="2" ${param.type==2?'selected="selected"':'' }>支款</option>
  					</select>
  				</td>
  				<td><label>收款人员：</label></td>
  				<td><input type="text" id="payee" name="payee" class="text small" value="${param.payee}"></input></td>
  				<td><label>收款日期：</label></td>
  				<td>
  					<input class="text small" id="startDate" name="startDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startDate }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endDate" name="endDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endDate }">
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
	 无支付方式收银明细
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<!-- <td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td> -->
			<td class="span2">订单号</td>
			<td class="span2">支付方式</td>
			<td class="span2">收支类型</td>
			<td class="span2">订单类型</td>
			<td class="span2">金额</td>
			<td class="span2">收款人</td>
			<td class="span2">创建日期</td>
		</tr>
	</thead>
	<c:forEach var="paymentTypeAndMoney" items="${page.result }">
		<tr height="32" align="center">
			<%-- <td><input type='checkbox' name="id" id="id1" value="${settlementReceipts.dbid }"/></td> --%>
			<td style="text-align:lcenter;">
				${paymentTypeAndMoney.orderNo}
			</td>
			<td style="text-align:center;">
				${paymentTypeAndMoney.childPayTypeName}
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${paymentTypeAndMoney.type eq 1}">
					收款
				</c:if>
				<c:if test="${paymentTypeAndMoney.type eq 2}">
					支款
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 1}">
					购车定金
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 2}">
					预收款礼券
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 3}">
					会员充值
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 4}">
					押金
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 5}">
					预收保费
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 6}">
					车款
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 7}">
					装饰
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 8}">
					保险
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 9}">
					金融
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 10}">
					预收
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 11}">
					工厂返利
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 12}">
					装饰成本
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 13}">
					装饰成本
				</c:if>
				<c:if test="${paymentTypeAndMoney.orderTypeId eq 14}">
					车款收银
				</c:if>
			</td>
			<td style="text-align:lcenter;">
				${paymentTypeAndMoney.receiveMoney}
			</td>
			<td style="text-align:lcenter;">
				${paymentTypeAndMoney.payee}
			</td>
			<td style="text-align:lcenter;">
				<fmt:formatDate value="${paymentTypeAndMoney.createDate }" />
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
var map = '<%=request.getAttribute("countPayType")%>';
 var obj = eval('(' + map + ')');
 var data1="[";
for(var key in obj)
{
	data1=data1+"['"+key+"("+obj[key]+"元)',"+obj[key]+"],"
} 
data1 = data1 + "]";
var data2 = eval('(' + data1 + ')');
var chart = Highcharts.chart('container', {
    title: {
        text: '支付方式占比总揽'
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
        name: '支付方式',
        data: data2
    }]
});
</script>
</html>