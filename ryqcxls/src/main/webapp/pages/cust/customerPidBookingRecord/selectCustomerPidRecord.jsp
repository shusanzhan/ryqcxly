<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>选择交车预约</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
<script type="text/javascript">
/** 获取checkBox的value* */
function getCheckBoxMember() {
	var array = new Array();
	var arrayNames = new Array();
	var checkeds = $("input[type='radio'][name='id']");
	var j=0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
			arrayNames.push($(checkbox).attr("tip"));
			j=j+1;
		}
	});
	if(j>1){
		alert("车架号只能选择一个");
		return;
	}
	$("#customerName").val(array.toString()+"|"+arrayNames.toString());
}
</script>
</head>
<body class="bodycolor">
<input type="hidden" id="customerName" name="customerName" value="">
 <!--location end-->
<div class="line"></div>
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;">
				姓名
			</td>
			<td style="width: 200px;">车型</td>
			<td style="width:50px;">销售顾问</td>
			<td style="width:60px;">顾问电话</td>
			<td style="width:60px;">交车时间</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${customerPidBookingRecords }" var="customerPidBookingRecord">
		<tr >
			<td style="text-align: left;">
				<label>
					<input type="radio"   name="id" id="id1" value="${customerPidBookingRecord.dbid }" tip="${customerPidBookingRecord.customer.name}" onclick="getCheckBoxMember()">
					&nbsp;&nbsp;
					${customerPidBookingRecord.customer.name}
					<c:set value="${customerPidBookingRecord.customer }" var="customer"></c:set> 
				</label>
			</td>
			<td class="tip" >
				<a href="javascript:void(-1)" class="" style="color: #46A0DE;" onclick="window.open('${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }')">
					${customerPidBookingRecord.carSeriy.name }
					${customerPidBookingRecord.carModel.name }
					${customerPidBookingRecord.carColor.name }
				</a>
			</td>
			<td >
				${customerPidBookingRecord.customer.user.realName }
			</td>
			<td>
				${customerPidBookingRecord.customer.user.mobilePhone }
			</td>
			<td>
				<fmt:formatDate value="${customerPidBookingRecord.bookingDate }" pattern="yyyy-MM-dd"/> 
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>
