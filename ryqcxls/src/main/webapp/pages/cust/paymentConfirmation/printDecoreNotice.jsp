<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>附加通知单</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" >
table{
width: 100%;
}
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 16px;
    line-height: 22px;
    width: 100px;
}

.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
</head>
<body>
<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>
 <div class="testDriverContent" style="width: 92%;">
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;">
				<img src="${ctx }/images/xwqr/logo.png" width="80"></img>
			</td>
			<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;">附加通知单</td>
			<td style="border: 0px solid #000000;" align="right">SN:${customer.sn }</td>
		</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="1" class="table-c">
	<tr>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:100px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" >客户姓名</td>
		<td colspan="">
			${customer.name }
		</td>	
		<td colspan="" align="center" rowspan="2">车型</td>
		<td colspan="" rowspan="2">
			${customerPidBookingRecord.brand.name }
			${customerPidBookingRecord.carSeriy.name }
			${customerPidBookingRecord.carModel.name }
		</td>
		<td align="center" rowspan="2">车架号</td>
		<td colspan="" rowspan="2">
			${customerPidBookingRecord.vinCode }
		</td>	
		<td colspan="" align="center" rowspan="2">时间</td>
		<td colspan="" rowspan="2">
			<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/>
		</td>
	</tr>
	<tr>
		<td align="center" >电话</td>
		<td colspan="">
			${customer.mobilePhone }
		</td>	
	</tr>
	<tr>
		<td align="center" colspan="4">&#12288;销售装饰项目</td>
		<td  align="center" colspan="4">&#12288;赠送装饰项目</td>	
	</tr>
	<tr>
		<td colspan="4"  width="50%" style="border-top:0;border-bottom: 0; ">
			<table cellpadding="0" cellspacing="0"  border="0" >
				<tr class="tabletr">
					<td align="center" style="border-top:0;width: 40px;">序号</td>
					<td align="center" style="border-top:0;width: 80px;">编号</td>
					<td align="center" style="border-top:0;width: 120px;">项目</td>
					<td align="center" style="border-top:0;border-right: 0;width: 80px;">金额</td>
				</tr>
				<c:set value="0" var="zs"></c:set>	
				<c:set value="0" var="xs"></c:set>	
				<c:set value="0" var="total"></c:set>	
				<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
					<c:if test="${decoreNoticeItem.type==1 }">
						<c:set value="${xs+1 }" var="xs"></c:set>
					</c:if>
					<c:if test="${decoreNoticeItem.type==2 }">
						<c:set value="${zs+1 }" var="zs"></c:set>
					</c:if>
				</c:forEach>
				<c:if test="${xs>zs }" var="status">
					<c:set value="${xs }" var="total"></c:set>
				</c:if>
				<c:if test="${status==false }">
					<c:set value="${zs }" var="total"></c:set>
				</c:if>
				<c:set value="1" var="indexVar"></c:set>
				<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
					<c:if test="${decoreNoticeItem.type==1 }">
						<tr> 
							<td align="center">${indexVar } </td>
							<td align="center">
								${decoreNoticeItem.serNo }
							</td>
							<td align="center">
								${decoreNoticeItem.itemName }
							</td>
							<td align="center" style="border-right:0;">
								${decoreNoticeItem.price }
							</td>
						</tr>
						<c:set value="${indexVar+1 }" var="indexVar"></c:set>
					</c:if>
				</c:forEach>
				<c:forEach var="ind" begin="${xs+1 }" end="13">
					<tr> 
							<td align="center">${ind } </td>
							<td align="center">
							</td>
							<td align="center">
							</td>
							<td align="left" style="border-right: 0;">
							</td>
						</tr> 
				</c:forEach>
				<tr> 
					<td align="center">装饰合计 </td>
					<td align="left" colspan="3">
						${decoreNotice.decoreSaleTotalPrce }
					</td>
				</tr> 
			</table>
		</td>
		<td colspan="4" style="border-top:0;border-bottom: 0; ">
			<table cellpadding="0" cellspacing="0" width="100%" border="0" >
				<tr class="tabletr">
					<td align="center" style="border-top:0;width: 40px;">序号</td>
					<td align="center" style="border-top:0;width: 80px;">编号</td>
					<td align="center" style="border-top:0;width: 120px;">项目</td>
					<td align="center" style="border-top:0;border-right: 0;width: 80px;">金额</td>
				</tr>	
				<c:set value="1" var="indexVar"></c:set>
				<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
					<c:if test="${decoreNoticeItem.type==2 }">
						<tr> 
							<td align="center">${indexVar } </td>
							<td align="center">
								${decoreNoticeItem.serNo }
							</td>
							<td align="center">
								${decoreNoticeItem.itemName }
							</td>
							<td align="center" style="border-right: 0;">
								${decoreNoticeItem.price }
							</td>
						</tr>
						<c:set value="${indexVar+1 }" var="indexVar"></c:set>
					</c:if> 
					<c:set value="${i.index+1 }" var="size"></c:set>
				</c:forEach>
				<c:forEach var="ind" begin="${zs+1 }" end="${13}">
					<tr> 
							<td align="center">${ind }</td>
							<td align="center">
							</td>
							<td align="center">
							</td>
							<td align="left" style="border-right: 0;">
							</td>
						</tr> 
				</c:forEach>
				<tr> 
					<td align="center">装饰合计 </td>
					<td align="left" colspan="3">
						${decoreNotice.giveTotalPrice }
					</td>
				</tr> 
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="" style="border-top: 0;">装饰实收合计</td>
		<td  colspan="7" style="border-top: 0;">
			${decoreNotice.acturePrice}
			折扣率
			${decoreNotice.zkl }
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="1" style="margin-bottom: 50px;">
	<tr>
		<td align="left" style="border: 0;">销售顾问：${customer.bussiStaff }</td>
		<td align="left"  style="border: 0;">物流部：</td>
		<td align="left" style="border: 0;">财务部：</td>
		<td align="left"  style="border: 0;">销售经理：${customer.salesConsultant }</td>
	</tr>
</table>
</div>
</body>
</html>