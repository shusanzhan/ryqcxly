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
<form action="${ctx }/finCustomerStatical/grossProfit" name="frmId" id="frmId" method="post">
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 12px;border: 0px;">
	<tr height="42">
		<td class="formTableTdLeft">物流归档日期:&nbsp;</td>
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
				<option value="2" ${param.customerType==2?'selected="selected"':'' } >多品牌</option>
			</select>
		</td>
		<td class="formTableTdLeft">销售顾问:&nbsp;</td>
		<td>
			<input  type="text" name="saler" id="saler" value="${param.saler }" class="small text" >
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
			<th style="width: 60px;text-align: center;">客户</th>
			<th style="width: 70px;text-align: center;"  >联系电话</th>
			<th style="width: 70px;text-align: center;"  >部门</th>
			<th style="width: 70px;text-align: center;"  >销售顾问</th>
			<th style="width: 80px;text-align: center;"  >车系</th>
			<th style="width: 240px;text-align: center;"  >贷款产品</th>
			<th style="width: 60px;text-align: center;"  >贷款成数</th>
			<th style="width: 60px;text-align: center;"  >手续费</th>
			<th style="width: 60px;text-align: center;"  >盗抢险产值</th>
			<th style="width: 60px;text-align: center;"  >其他费用</th>
			<th style="width: 60px;text-align: center;"  >实际利息</th>
			<th style="width: 60px;text-align: center;" >贴息金额</th>
			<th style="width: 60px;text-align: center;"  >公司承担利息</th>
			<th style="width: 60px;text-align: center;"  >保底基数</th>
			<th style="width: 60px;text-align: center;"  >顾问提成基数</th>
			<th style="width: 60px;text-align: center;"  >利润</th>
	</tr>
	<c:set value="0.0" var="scountFee"></c:set>
	<c:set value="0.0" var="sdqxProfitPrice"></c:set>
	<c:set value="0.0" var="sdiscountMony"></c:set>
	<c:set value="0.0" var="sotherPrice"></c:set>
	<c:set value="0.0" var="sactDiscountPrice"></c:set>
	<c:set value="0.0" var="scompanyDiscountPrice"></c:set>
	<c:set value="0.0" var="ssalerProfitPrice"></c:set>
	<c:set value="0.0" var="ssalerPrice"></c:set>
	<c:set value="0.0" var="sprofitPrice"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finCustomer" items="${finCustomers }" varStatus="i">
		<c:set value="${finCustomer.finCustomerLoan }" var="finCustomerLoan"></c:set>
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${finCustomer.name}
			</td>
			<td style="text-align: center;">
				${finCustomer.mobilePhone }
			</td>
			<td style="text-align: center;">
				${finCustomer.dep}
			</td>
			<td style="text-align: center;">
				${finCustomer.saler}
			</td>
			<td style="text-align: center;">
				${finCustomer.carSeriyName }
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.finProductName }/
				${finCustomerLoan.finProductItemName }
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.loanPer }
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.countFee }
				<c:set value="${scountFee+finCustomerLoan.countFee }" var="scountFee"></c:set>
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.dqxProfitPrice}
				<c:set value="${sdqxProfitPrice+finCustomerLoan.dqxProfitPrice }" var="sdqxProfitPrice"></c:set>
			</td>
			<td style="text-align: center;">
				<c:if test="${empty(finCustomerLoan.otherPrice) }">
					0
				</c:if>
				<c:if test="${!empty(finCustomerLoan.otherPrice) }">
					${finCustomerLoan.otherPrice }
				</c:if>
				<c:set value="${sotherPrice+finCustomerLoan.otherPrice }" var="sotherPrice"></c:set>
			</td>
			<td style="text-align: center;padding-left: 0px;" >
				${finCustomerLoan.actDiscountPrice}
				<c:set value="${sactDiscountPrice+finCustomerLoan.actDiscountPrice }" var="sactDiscountPrice"></c:set>
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.discountMony}
				<c:set value="${sdiscountMony+finCustomerLoan.discountMony }" var="sdiscountMony"></c:set>
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.companyDiscountPrice}
				<c:set value="${scompanyDiscountPrice+finCustomerLoan.companyDiscountPrice }" var="scompanyDiscountPrice"></c:set>
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.salerProfitPrice}
				<c:set value="${ssalerProfitPrice+finCustomerLoan.salerProfitPrice }" var="ssalerProfitPrice"></c:set>
			</td>
			<td style="text-align: center;">
				${finCustomerLoan.salerPrice}
				<c:set value="${ssalerPrice+finCustomerLoan.salerPrice }" var="ssalerPrice"></c:set>
			</td>
			
			<td style="text-align: center;">
				${finCustomerLoan.profitPrice}
				<c:set value="${sprofitPrice+finCustomerLoan.profitPrice }" var="sprofitPrice"></c:set>
			</td>
			
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="8" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${scountFee }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${sdqxProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${sotherPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${sactDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${sdiscountMony }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${scompanyDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${ssalerProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${ssalerPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;">
				<fmt:formatNumber value=" ${sprofitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
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
 	params=encodeURI(params);
 	window.location.href='${ctx}/finCustomerStatical/exportExcel?'+params;
 }
</script>
</html>