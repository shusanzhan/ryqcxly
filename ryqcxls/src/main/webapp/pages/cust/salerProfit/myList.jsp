<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
#shopNumber{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
	font-size: 12px;
}
#shopNumber th,#shopNumber td{
border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
.icon-remove {
    background-position: -312px 0;
}

.icon-ok {
    background-position: -288px 0;
}
</style>
<title>毛利统计</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">毛利统计</a>
</div>
<div class="line"></div>
<form action="${ctx }/salerProfit/queryMyList" name="frmId" id="frmId" method="post">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px;border: 0px;">
	<tr height="42">
		<td class="formTableTdLeft">统计日期:&nbsp;</td>
		<td width="200">
			<input readonly="readonly" type="text" name="startTime" id="startDate" value="${param.startTime }"  onfocus="new WdatePicker();" class="small text" >
			~
			<input readonly="readonly" type="text" name="endTime" id="endTime" value="${param.endTime }" onfocus="new WdatePicker();"  class="small text" >
		</td>
		<td>
			<a href="javascript:void(-1)"	onclick="$('#frmId')[0].submit()"	class="but butSave">查询</a> 
			<!-- <a href="javascript:void(-1)"	onclick="exportExcel('frmId')"	class="but butSave">导出excel</a> --> 
		</td>
	</tr>
</table>
</form>	
<div class="alert alert-error">
	利润计算公式：合同总金额-车辆结算价-预收款-装饰结算价-咨询服务费+按揭结算价+保险利润
</div>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 100%;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 60px;text-align: center;">客户姓名</th>
			<th style="width: 70px;text-align: center;" >联系电话</th>
			<th style="width: 60px;text-align: center;" >部门</th>
			<th style="width: 60px;text-align: center;" >销售顾问</th>
			<th style="width: 240px;text-align: center;" >车型</th>
			<th style="width: 60px;text-align: center;">合同总额</th>
			<th style="width: 70px;text-align: center;">车辆结算价</th>
			<th style="width: 60px;text-align: center;"  >预收款</th>
			<th style="width: 70px;text-align: center;"  >装饰结算价</th>
			<th style="width: 70px;text-align: center;"  >按揭结算价</th>
			<th style="width: 60px;text-align: center;"  >保险利润</th>
			<th style="width: 60px;text-align: center;" >利润</th>
	</tr>
	<c:set value="0.0" var="stotalPrice"></c:set>
	<c:set value="0.0" var="scarSalerPrice"></c:set>
	<c:set value="0.0" var="sadvanceTotalPrice"></c:set>
	<c:set value="0.0" var="ssalerTotalPrice"></c:set>
	<c:set value="0.0" var="ssalerPrice"></c:set>
	<c:set value="0.0" var="sinsSalerPrice"></c:set>
	<c:set value="0.0" var="sprofitMoney"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="salerProfit" items="${salerProfits }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${salerProfit.name}
			</td>
			<td style="text-align: center;">
					${salerProfit.mobilePhone}
			</td>
			<td style="text-align: center;">
				${salerProfit.depName}
			</td>
			<td style="text-align: center;">
				${salerProfit.bussiStaff}
			</td>
			<td style="text-align: center;">
				${salerProfit.brandName}
				${salerProfit.csName}
				${salerProfit.cmName}
				${salerProfit.carColorName}
			</td>
			<td style="text-align: center;">
				${salerProfit.totalPrice }
				<c:set value="${stotalPrice+salerProfit.totalPrice }" var="stotalPrice"></c:set>
			</td>
			<td style="text-align: center;">
				${salerProfit.carSalerPrice}
				<c:set value="${scarSalerPrice+salerProfit.carSalerPrice }" var="scarSalerPrice"></c:set>
			</td>
			<td style="text-align: center;">
				${salerProfit.advanceTotalPrice }
				<c:set value="${sadvanceTotalPrice+salerProfit.advanceTotalPrice }" var="sadvanceTotalPrice"></c:set>
			</td>
			<td style="text-align: center;padding-left: 0px;" >
				${salerProfit.salerTotalPrice }
				<c:set value="${ssalerTotalPrice+salerProfit.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${salerProfit.salerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
				<c:set value="${ssalerPrice+salerProfit.salerPrice }" var="ssalerPrice"></c:set>
			</td> 
			<td style="text-align: center;">
				<fmt:formatNumber value="${salerProfit.insSalerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
				<c:set value="${sinsSalerPrice+salerProfit.insSalerPrice }" var="sinsSalerPrice"></c:set>
			</td> 
			<td style="text-align: center;">
				<c:if test="${salerProfit.profitMoney<0 }">
					<span style="color: red;">
						<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0.00" ></fmt:formatNumber>

					</span>
				</c:if>
				<c:if test="${salerProfit.profitMoney>=0 }">
					<span style="color: green;">
						<fmt:formatNumber value="${salerProfit.profitMoney }" pattern="###,###,##0.00" ></fmt:formatNumber>
					</span>
				</c:if>
				<c:set value="${sprofitMoney+salerProfit.profitMoney }" var="sprofitMoney"></c:set>
			</td> 
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="6" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${stotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scarSalerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sadvanceTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sinsSalerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sprofitMoney }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
		</tr>
</table>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/profit/exportProfit?'+params;
 }
</script>
</html>