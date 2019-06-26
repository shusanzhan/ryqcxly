<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywxb.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>合同流失审批记录明细</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a href="javascript:history.back()" id="back">
        <img class="return" src="/images/jm/NavButtonBack.png">
    </a>
    <span id="page_title">合同流失审批记录明细</span>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${customerPidBookingRecord.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerPidBookingRecord.dbid" id="dbid" value="${customerPidBookingRecord.dbid }">
		<input type="hidden" name="pidStatus" id="pidStatus" >
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%">
			<tr height="42">
				<td class="formTableTdLeft" width="120">客户姓名:&nbsp;
					${customer.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">联系电话:&nbsp;
					${customer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;
					 ${customerLastBussi.carSeriy.name}${customerLastBussi.carModel.name}
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">具体车型:&nbsp;
					${customerPidBookingRecord.carModelContent }
				</td>
			</tr>
			<tr>
				<td colspan="2">审批记录</td>
			</tr>
			<c:forEach var="customerPidCancel" items="${customerPidCancels }">
				<tr>
					<td colspan="2">
						合同申请流失创建时间：${customerPidCancel.createDate}&nbsp;&nbsp;&nbsp;&nbsp;
						申请理由:${customerPidCancel.note }
					</td>
				</tr>
				<c:forEach items="${customerPidCancel.approvalRecordPidBookingRecords }" var="approvalRecordPidBookingRecord"> 
					<tr>
						<td colspan="2">
						&nbsp;&nbsp;&nbsp;&nbsp;
						${approvalRecordPidBookingRecord.approvalName }&nbsp;&nbsp;于&nbsp;&nbsp;${approvalRecordPidBookingRecord.approvalTime } 审批，审批结果为：
						<c:if test="${approvalRecordPidBookingRecord.result==3 }">
							<span style="color: #DD9A4B;">等待展厅经理审批</span>
						</c:if>
						<c:if test="${approvalRecordPidBookingRecord.result==4 }">
							<span style="color: #DD9A4B;">展厅经理同意合同流失</span>
						</c:if>
						<c:if test="${approvalRecordPidBookingRecord.result==5 }">
							<span style="color: blue">总/副总经理同意合同流失</span>
						</c:if>
						<c:if test="${approvalRecordPidBookingRecord.result==6 }">
							<span style="color: red;">总/副总经理驳回合同流失</span>
						</c:if>
						<c:if test="${approvalRecordPidBookingRecord.result==7 }">
							<span style="color: red;">展厅经理驳回合同流失</span>
						</c:if>
						<br>
						审批意见：${approvalRecordPidBookingRecord.sugg }&nbsp;
						</td>
					</tr>
				</c:forEach>
			</c:forEach>
		</table>
		
	</form>
</div>
</body>
</html>