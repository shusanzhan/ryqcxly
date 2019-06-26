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
<form action="${ctx }/profit/profit" name="frmId" id="frmId" method="post">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px;border: 0px;">
	<tr height="42">
		<td class="formTableTdLeft">统计日期:&nbsp;</td>
		<td width="200">
			<input readonly="readonly" type="text" name="startTime" id="startDate" value="${param.startTime }"  onfocus="new WdatePicker();" class="small text" >
			~
			<input readonly="readonly" type="text" name="endTime" id="endTime" value="${param.endTime }" onfocus="new WdatePicker();"  class="small text" >
			
		</td>
		<td class="formTableTdLeft">客户类型:&nbsp;</td>
		<td>
			<select class="text small" id="customerType" name="customerType"  onchange="$('#frmId')[0].submit()">
				<option value="0" >请选择...</option>
				<option value="1" ${param.customerType==1?'selected="selected"':'' } >保有</option>
				<option value="2" ${param.customerType==2?'selected="selected"':'' } >零售</option>
			</select>
		</td>
		<td>部门：
			<select class="midea text" id="departmentId" name="departmentId"  onchange="$('#frmId')[0].submit()" >
				<option value="0" >请选择...</option>
				${departmentSelect }
			</select>
			<a href="javascript:void(-1)"	onclick="$('#frmId')[0].submit()"	class="but butSave">查询</a> 
			<a href="javascript:void(-1)"	onclick="exportExcel('frmId')"	class="but butSave">导出excel</a> 
		</td>
	</tr>
</table>
</form>	
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 100%;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 60px;text-align: center;">出库单号</th>
			<th style="width: 70px;text-align: center;" >客户</th>
			<th style="width: 70px;text-align: center;" >部门</th>
			<th style="width: 70px;text-align: center;" >销售顾问</th>
			<th style="width: 60px;text-align: center;">实收</th>
			<th style="width: 100px;text-align: center;">成本</th>
			<th style="width: 80px;text-align: center;"  >顾问结算</th>
			<th style="width: 60px;text-align: center;"  >工资</th>
			<th style="width: 60px;text-align: center;" >利润</th>
	</tr>
	<c:set value="0.0" var="scountFee"></c:set>
	<c:set value="0.0" var="sdqxProfitPrice"></c:set>
	<c:set value="0.0" var="sdiscountMony"></c:set>
	<c:set value="0.0" var="sotherPrice"></c:set>
	<c:set value="0.0" var="sactDiscountPrice"></c:set>
	<c:set value="0.0" var="scompanyDiscountPrice"></c:set>
	<c:set value="0.0" var="sprofitPrice"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="decoreOut" items="${decoreOuts }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${decoreOut.outNo}
			</td>
			<td style="text-align: center;">
				<c:if test="${decoreOut.type==1 }">
					${decoreOut.customerName }
				</c:if>
				<c:if test="${decoreOut.type==2 }">
					零售客户
				</c:if>
			</td>
			<td style="text-align: center;">
				${decoreOut.department.name}
			</td>
			<td style="text-align: center;">
				${decoreOut.saler}
			</td>
			<td style="text-align: center;">
				${decoreOut.acturePrice }
				<c:set value="${sacturePrice+decoreOut.acturePrice }" var="sacturePrice"></c:set>
			</td>
			<td style="text-align: center;">
				${decoreOut.costTotalPrice}
				<c:set value="${scostTotalPrice+decoreOut.costTotalPrice }" var="scostTotalPrice"></c:set>
			</td>
			<td style="text-align: center;">
				<c:if test="${empty(decoreOut.salerTotalPrice) }">
					0
				</c:if>
				<c:if test="${!empty(decoreOut.salerTotalPrice) }">
					${decoreOut.salerTotalPrice }
				</c:if>
				<c:set value="${ssalerTotalPrice+decoreOut.salerTotalPrice }" var="ssalerTotalPrice"></c:set>
			</td>
			<td style="text-align: center;padding-left: 0px;" >
				<fmt:formatNumber value="${decoreOut.acturePrice-decoreOut.salerTotalPrice}" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${decoreOut.acturePrice-decoreOut.costTotalPrice}" pattern="###,###,##0.00"></fmt:formatNumber>
			</td> 
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="5" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sacturePrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${scostTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${ssalerTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sacturePrice-ssalerTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value="${sacturePrice-scostTotalPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
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