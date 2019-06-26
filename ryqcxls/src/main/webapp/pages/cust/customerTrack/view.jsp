<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>添加追踪记录-查看</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${not empty(customerTrack) }">
			<input type="hidden" name="customerId" value="${customerTrack.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerTrack) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerTrack.createTime" id="createTime" value="${customerTrack.createTime}">
		<input type="hidden" name="customerTrack.dbid" id="dbid" value="${customerTrack.dbid }">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">回访日期:&nbsp;</td>
				<td >
					<fmt:formatDate value="${customerTrack.trackDate }" pattern="yyyy年MM月dd日 HH:mm" />
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">跟进类型:&nbsp;</td>
				<td >
					<c:if test="${customerTrack.trackType==1 }">
						日常关系维护
					</c:if>
					<c:if test="${customerTrack.trackType==2 }">
						普通邀约到店
					</c:if>
					<c:if test="${customerTrack.trackType==3 }">
						活动邀约到店
					</c:if>
				</td>
				<td class="formTableTdLeft">跟进方法:&nbsp;</td>
				<td >
					<c:if test="${customer.lastResult==1 }">
						电话
					</c:if>
					<c:if test="${customer.lastResult==2 }">
						到店
					</c:if>
					<c:if test="${customer.lastResult==3 }">
						短信
					</c:if>
					<c:if test="${customer.lastResult==4 }">
						上门
					</c:if>
					<c:if test="${customer.lastResult==5 }">
						微信
					</c:if>
					<c:if test="${customer.lastResult==6 }">
						QQ
					</c:if>
				</td>
			</tr>
			<c:if test="${customerTrack.trackType==3 }">
				<tr height="42">
				<td class="formTableTdLeft">邀约活动:&nbsp;</td>
				<td >
					${customerTrack.custMarketingAct.name }
				</td>
				<td class="formTableTdLeft">邀约结果:&nbsp;</td>
				<td >
					<c:if test="${customerTrack.turnBackResult==1 }">
						<span style="color: green">接受</span>
					</c:if>
					<c:if test="${customerTrack.turnBackResult==2 }">
						<span style="color:orange;">待定</span>
					</c:if>
					<c:if test="${customerTrack.turnBackResult==3 }">
						<span style="color: red">拒绝</span>
					</c:if>
				</td>
			</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">更新级别:&nbsp;</td>
				<td >
					${customerTrack.beforeCustomerPhase.name}
				</td>
				<td>下次预约时间:</td>
				<td >
					<fmt:formatDate value="${customerTrack.nextReservationTime }" pattern="yyyy年MM月dd日 HH:mm" /> 
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">跟进内容:&nbsp;</td>
				<td colspan="3">${customerTrack.trackContent }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">沟通结果:&nbsp;</td>
				<td colspan="3">${customerTrack.result }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户反馈问题:&nbsp;</td>
				<td colspan="3">${customerTrack.feedBackResult }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">对应措施:&nbsp;</td>
				<td colspan="3">${customerTrack.dealMethod }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">展厅经理意见:&nbsp;</td>
				<td colspan="3">${customerTrack.showroomManagerSuggested }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">销售经理意见:&nbsp;</td>
				<td colspan="3">${customerTrack.salesNote } 审批时间：${customerTrack.salesDate }</td>
			</tr>
		</table>
	</form>
</div>
<div class="formButton">
			<a href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">关闭</a> 
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>