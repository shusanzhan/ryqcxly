<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
<a href="javascript:void(-1);">利润统计</a>
</div>
<div class="line"></div>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
           <li class="detail_tap3 detail_tap pull_left ${param.type==1?'select':''}" id="imgs_tap" onclick="window.location.href='${ctx}/cwProfitStatical/profit?role=${param.role }&type=1'">日报</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==2?'select':''}" style="border:1px solid #ff9f29 " id="pingjia_tap" onclick="window.location.href='${ctx}/cwProfitStatical/profit?role=${param.role }&type=2'">月报</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==3?'select':''}" id="pingjia_tap" onclick="window.location.href='${ctx}/cwProfitStatical/profit?role=${param.role }&type=3'">年报</li>
      	</ul>
     </div>
 </div>
<form class="form-inline" action="${ctx }/cwProfitStatical/profit" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label>
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
      	 		</td>
      	 		<td width="240">
      	 			<c:if test="${param.type==1 }">
	      	 			<c:if test="${!empty(param.day) }">
	      	 				<input type="date" class="large text" id="day" name="day" value="${param.day }">
	      	 				<%-- <input class="text small" id="day" name="day" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.day }" > --%>
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.day) }">
	      	 				<%-- <input class="text small" id="day" name="day" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.day }" > --%>
	      	 		   		<input type="date" class="large text" id="day" name="day" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==2 }">
	      	 			<c:if test="${!empty(param.month) }">
	      	 				<input type="month" class="large text" id="month" name="month" value="${param.month }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.month) }">
	      	 				<input type="month" class="large text" id="month" name="month" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==3 }">
	      	 			<select id="year" name="year" class="middle text">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.year==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
      	 			</c:if>
			    </td>
			    <td>
			    	<a href="javascript:void(-1)"	onclick="$('#frmId')[0].submit()"	class="but butSave">查询</a>
			    </td>
      	 	</tr>
      	 </table>
		</form>
<div style="clear: both;"></div>
<div class="frmTitle">
		收支统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center"  width="30%">序号</td>
				<td align="center"  width="35%">收支类别</td>
				<td align="center"  width="35%">金额</td>
			</tr>
			<tr height="24">
				<td align="center">1</td>
				<td align="center">收入</td>
				<td align="center">${sumCollect }</td>
			</tr>
			<tr height="24">
				<td align="center">2</td>
				<td align="center">支出</td>
				<td align="center">${sumPay }</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="frmTitle">
		支付渠道收入统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" width="30%">序号</td>
				<td align="center"  width="35%">支付方式类别</td>
				<td align="center"  width="35%">金额</td>
			</tr>
			<c:set value="0.0" var="sumPayment"></c:set>
			<c:forEach var="payment" items="${countPaymentType }" varStatus="i">
				<tr height="24" >
					<td align="center">
						${i.index+1 }
					</td>
					<td align="center">
						${payment.childPayTypeName }
					</td>
					<td align="center">
						${payment.receiveMoney }
						<c:set value="${sumPayment+payment.receiveMoney }" var="sumPayment"></c:set>
					</td>
				</tr>
			</c:forEach>
			<tr height="24">
				<td align="right" colspan="2">
					<span style="font-size: 18px;color:green">收入合计：</span>
				</td>
				<td align="center">
					<span style="font-size:18px;color:red">${sumPayment }</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="frmTitle">
		支付渠道支出统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center"  width="30%">序号</td>
				<td align="center"  width="35%">支付方式类别</td>
				<td align="center"  width="35%">金额</td>
			</tr>
			<c:set value="0.0" var="sumExpenditure"></c:set>
			<c:forEach var="expenditure" items="${countExpenditure }" varStatus="i">
				<tr height="24" >
					<td align="center">
						${i.index+1 }
					</td>
					<td align="center">
						${expenditure.childPayTypeName }
					</td>
					<td align="center">
						${expenditure.receiveMoney }
						<c:set value="${sumExpenditure+expenditure.receiveMoney }" var="sumExpenditure"></c:set>
					</td>
				</tr>
			</c:forEach>
			<tr height="24">
					<td align="right" colspan="2">
						<span style="font-size: 18px;color:green">支出合计：</span>
					</td>
					<td align="center">
						<span style="font-size: 18px;color:red">${sumExpenditure }</span>
					</td>
				</tr>
		</tbody>
	</table>
</div>
<div class="frmTitle">
		开票类型统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center"  width="30%">序号</td>
				<td align="center"  width="35%">开票类型</td>
				<td align="center"  width="35%">金额</td>
			</tr>
			<c:set value="0.0" var="sumOpenBillType"></c:set>
			<c:forEach var="countOpenBillType" items="${countOpenBillTypes }" varStatus="i">
				<tr height="24" >
					<td align="center">
						${i.index+1 }
					</td>
					<td align="center">
						${countOpenBillType.name }
					</td>
					<td align="center">
						${countOpenBillType.incomeMoney }
						<c:set value="${sumOpenBillType+countOpenBillType.incomeMoney }" var="sumOpenBillType"></c:set>
					</td>
				</tr>
			</c:forEach>
			<tr height="24">
					<td align="right" colspan="2">
						<span style="font-size: 18px;color:green">开票合计：</span>
					</td>
					<td align="center">
						<span style="font-size: 18px;color:red">${sumOpenBillType }</span>
					</td>
				</tr>
		</tbody>
	</table>
</div>
<div class="frmTitle">
		业务板块统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" >序号</td>
				<td align="center" >类型</td>
				<td align="center" >合同总金额</td>
				<td align="center" >车款金额</td>
				<td align="center" >装饰总额</td>
				<td align="center" >咨询服务费</td>
				<td align="center" >预收总额</td>
				<td align="center">车辆成本总额</td>
				<td align="center">单车利润</td>
				<td align="center" >综合利润</td>
				<td align="center" >综合税后利润</td>
			</tr>
				<c:forEach var="cwCarMoneyStatical" items="${cwCarMoneyStaticals }" varStatus="i">
					<tr height="24">
						<td align="center">
							${i.index+1 }
						</td>
						<td align="center">
							<span style="color:green">${cwCarMoneyStatical.name}</span>
						</td>
						<td align="center">
							<c:if test="${empty cwCarMoneyStatical.orderContractTotalMoney}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.orderContractTotalMoney}">
								${cwCarMoneyStatical.orderContractTotalMoney}
							</c:if>
						</td>
						<td align="center">
							<c:if test="${empty cwCarMoneyStatical.carActurePrice}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.carActurePrice}">
								${cwCarMoneyStatical.carActurePrice}
							</c:if>
						</td>
						<td align="center">
							<c:if test="${empty cwCarMoneyStatical.decoreMoney}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.decoreMoney}">
								${cwCarMoneyStatical.decoreMoney}
							</c:if>
						</td>
						<td align="center">
							<c:if test="${empty cwCarMoneyStatical.ajsxf}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.ajsxf}">
								${cwCarMoneyStatical.ajsxf}
							</c:if>
						</td>
						<td align="center"> 	
							<c:if test="${empty cwCarMoneyStatical.advanceMoney}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.advanceMoney}">
								${cwCarMoneyStatical.advanceMoney}
							</c:if>
						</td>
						<td align="center">
							<c:if test="${empty cwCarMoneyStatical.carCost}">
								0.0
							</c:if>
							<c:if test="${!empty cwCarMoneyStatical.carCost}">
								${cwCarMoneyStatical.carCost}
							</c:if>
						</td>
						<td align="center">
							<span style="color:red">
								<c:if test="${empty cwCarMoneyStatical.singCarProfit }">
									0.0
								</c:if>
								<c:if test="${!empty cwCarMoneyStatical.singCarProfit }">
									${cwCarMoneyStatical.singCarProfit}
								</c:if>
							</span>
						</td>
						<td align="center">
							<span style="color:red">
								<c:if test="${empty cwCarMoneyStatical.profit}">
									0.0
								</c:if>
								<c:if test="${!empty cwCarMoneyStatical.profit}">
									${cwCarMoneyStatical.profit}
								</c:if>
							</span>
						</td>
						<td align="center">
							<span style="color:red">
								<c:if test="${empty cwCarMoneyStatical.profitMinusTax}">
									0.0
								</c:if>
								<c:if test="${!empty cwCarMoneyStatical.profitMinusTax}">
									${cwCarMoneyStatical.profitMinusTax}
								</c:if>
							</span>
						</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center"  width="20%">序号</td>
				<td align="center"  width="20%">类型</td>
				<td align="center"  width="20%">商业险总金额</td>
				<td align="center"  width="20%">强制险总金额</td>
				<td align="center"  width="20%">总金额</td>
			</tr>
			<tr height="24">
				<td align="center">
					1
				</td>
				<td align="center">
					<span style="color:green">保险返利</span>
				</td>
				<td align="center">
					<c:if test="${empty countBusiRiskRebateMoney}">
						0.0
					</c:if>
					<c:if test="${!empty countBusiRiskRebateMoney}">
						${countBusiRiskRebateMoney}
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty countStrongRiskRebateMoney}">
						0.0
					</c:if>
					<c:if test="${!empty countStrongRiskRebateMoney}">
						${countStrongRiskRebateMoney}
					</c:if>
				</td>
				<td align="center">
					<span style="color:red">
						<c:if test="${empty countRebateMoney}">
							0.0
						</c:if>
						<c:if test="${!empty countRebateMoney}">
							${countRebateMoney}
						</c:if>
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center"  width="20%">序号</td>
				<td align="center"  width="20%">类型</td>
				<td align="center"  width="20%">销售总额</td>
				<td align="center"  width="20%">利润</td>
				<td align="center"  width="20%">税后利润</td>
			</tr>
			<tr height="24">
				<td align="center">
					1
				</td>
				<td align="center">
					<span style="color:green">销售装饰</span>
				</td>
				<td align="center">
					<c:if test="${empty decoreSaleTotalPrce}">
						0.0
					</c:if>
					<c:if test="${!empty decoreSaleTotalPrce}">
						${decoreSaleTotalPrce}
					</c:if>
				</td>
				<td align="center">
					<c:if test="${empty decoreProfit}">
						0.0
					</c:if>
					<c:if test="${!empty decoreProfit}">
						${decoreProfit}
					</c:if>
				</td>
				<td align="center">
					<span style="color:red">
						<c:if test="${empty decoreProfitMinusTax}">
							0.0
						</c:if>
						<c:if test="${!empty decoreProfitMinusTax}">
							${decoreProfitMinusTax}
						</c:if>
					</span>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="frmTitle">
		销售顾问统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" >序号</td>
				<td align="center" >销售员</td>
				<td align="center" >车款合同总金额</td>
				<td align="center" >保险返利总金额</td>
				<td align="center" >销售装饰总金额</td>
				<td align="center">咨询服务费</td>
				<td align="center" >利润</td>
				<td align="center" >税后利润</td>
			</tr>
			<c:set value="0.0" var="sumExpenditure"></c:set>
			<c:forEach var="cwUserStatical" items="${cwUserStaticals }" varStatus="i">
				<tr height="24" >
					<td align="center">
						${i.index+1 }
					</td>
					<td align="center">
						${cwUserStatical.userName }
					</td>
					<td align="center">
						<c:if test="${empty cwUserStatical.carMoney }">
							0.0
						</c:if>
						<c:if test="${!empty cwUserStatical.carMoney}">
							${cwUserStatical.carMoney }
						</c:if>
					</td>
					<td align="center">
						<c:if test="${empty cwUserStatical.insuranceMoney }">
							0.0
						</c:if>
						<c:if test="${!empty cwUserStatical.insuranceMoney }">
							${cwUserStatical.insuranceMoney }
						</c:if>
					</td>
					<td align="center">
						<c:if test="${empty cwUserStatical.decoreMoney}">
							0.0
						</c:if>
						<c:if test="${!empty cwUserStatical.decoreMoney}">
							${cwUserStatical.decoreMoney }
						</c:if>
					</td>
					<td align="center">
						<c:if test="${empty cwUserStatical.ajsxf}">
							0.0
						</c:if>
						<c:if test="${!empty cwUserStatical.ajsxf}">
							${cwUserStatical.ajsxf}
						</c:if>
					</td>
					<td align="center">
						<span style="color:red">${cwUserStatical.profit }</span>
					</td>
					<td align="center">
						<span style="color:red">${cwUserStatical.profitMinusTax }</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</div>
<br>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/grossProfitStatic/exportGrossProfit?'+params;
 }
</script>
</html>