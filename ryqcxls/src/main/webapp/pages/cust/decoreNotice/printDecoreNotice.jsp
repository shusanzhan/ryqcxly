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
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 16px;
    line-height: 22px;
    width: 100px;
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
<c:if test="${param.type==2 }" var="status">
</c:if>
<c:if test="${status==false }">
<div class="bar">
	<c:if test="${!empty(decoreNotice) }">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
	</c:if>
	<c:if test="${empty(decoreNotice) }">
		销售顾问未填写附加通知单！<a href="javascript:;"  class="btn btn-success " onclick="window.close()" style="margin-left: 5px;">关 闭</a>
	</c:if>
</div>
</c:if>
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
	<table cellpadding="0" cellspacing="0" border="1">
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
			${customerPidBookingRecord.carSeriy.name }${customerPidBookingRecord.carModel.name }
		</td>
		<td align="center" rowspan="2">车架号</td>
		<td colspan="" rowspan="2">
			${customerPidBookingRecord.vinCode }
		</td>	
		<td colspan="" align="center" rowspan="2">时间</td>
		<td colspan="" rowspan="2">
		<c:if test="${param.type==2 }" var="status">
			<fmt:formatDate value="${decoreNotice.createTime }" pattern="yyyy年MM月dd日 HH:mm"/>
		</c:if>
		<c:if test="${status==false }">
			<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日 HH:mm"/>
		</c:if>
		</td>
	</tr>
	<tr>
		<td align="center" >电话</td>
		<td colspan="">
			${customer.mobilePhone }
		</td>	
	</tr>
	<tr>
		<td align="center" colspan="4">&#12288;装饰项目1</td>
		<td  align="center" colspan="4">&#12288;装饰项目2</td>	
	</tr>
	<tr>
		<td align="center">序号</td>
		<td align="center">编号</td>
		<td align="center">项目</td>
		<td align="center">金额</td>
		<td align="center">序号</td>
		<td align="center">编号</td>
		<td align="center">项目</td>
		<td align="center">金额</td>
	</tr>
	<s:set value="0" var="size"></s:set>
	<c:forEach  var="decoreNoticeItem" items="${decoreNotice.decorenoticeitems }"  varStatus="i">
		<tr> 
			<td align="center">${i.index+1 } </td>
			<td align="center">
				${decoreNoticeItem.serNo1 }
			</td>
			<td align="center">
				${decoreNoticeItem.itemName1 }
			</td>
			<td align="center">
				${decoreNoticeItem.price1 }
			</td>
			<td align="center">${i.index+1 }</td>
			<td align="center">
				${decoreNoticeItem.serNo2}
			</td>
			<td align="center">
				${decoreNoticeItem.itemName2}
			</td>
			<td align="center">
				${decoreNoticeItem.price2}
			</td>
		</tr>
		<c:set value="${i.index+1 }" var="size"></c:set>
	</c:forEach>
	<c:forEach begin="${size+1 }" end="13" var="i">
		<tr>
			<td align="center">${i }</td>
			<td align="center">
			</td>
			<td align="center">
			</td>
			<td align="left">
			</td>
			<td align="center">${i }</td>
			<td align="center">
			</td>
			<td align="center">
			</td>
			<td align="left">
			</td>
		</tr>
		</c:forEach>
	<tr>
		<td align="center">装饰合计</td>
		<td colspan="3">
			${decoreNotice.decoreTotal1 }
		</td>
		<td align="center">装饰合计</td>
		<td  colspan="3">
			${decoreNotice.decoreTotal2 }
		</td>
	</tr>
	<tr>
		
		
		<td align="center" colspan="">装饰实收合计</td>
		<td  colspan="7">
			${decoreNotice.decoreTotal}
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