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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
	padding-left: 5px;
	font-size: 14px;
	height: 32px;
}
.frmContent form table tr td {
    padding-left: 5px;
    font-size: 14px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
</style>
<title>审批记录</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">
	【${customer.name }】
	<c:if test="${processRun.type==1 }">
		订单审批
	</c:if>
	<c:if test="${processRun.type==2 }">
		合同流失审批
	</c:if>
	记录
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;color: red">
					<td width="100%" colspan="4" style="text-align: center;">
						<c:if test="${processRun.type==1 }">
							订单审批
						</c:if>
						<c:if test="${processRun.type==2 }">
							合同流失审批
						</c:if>
						客户资料
					</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td >${customer.name }</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${customer.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<td >
					<c:set value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
					${carModel} ${customer.carModelStr}
				</td>
				<td class="formTableTdLeft">部门:&nbsp;</td>
				<td >
					${customer.department.name }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">销售顾问:&nbsp;</td>
				<td >
					${customer.user.realName }
				</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					${customer.user.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">申请时间:&nbsp;</td>
				<td >
					<fmt:formatDate value="${processRun.createDate}"/>
				</td>
				<td class="formTableTdLeft">审批时间:&nbsp;</td>
				<td >
					<c:if test="${empty(processRun.finishDate) }">
						<span style="color: red">审批中...</span>
					</c:if>
					<c:if test="${!empty(processRun.finishDate) }">
						<fmt:formatDate value="${processRun.finishDate}"/>
					</c:if>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">审批结果:&nbsp;</td>
				<td >
					<c:if test="${processRun.runStatus==1 }">
						<span style="color: red">审批中...</span>
					</c:if>
					<c:if test="${processRun.runStatus==2 }">
						<span style="color: red">驳回</span>
					</c:if>
					<c:if test="${processRun.runStatus==3 }">
						<span style="color: green;">通过</span>
					</c:if>
				</td>
				<td class="formTableTdLeft">审批用时:&nbsp;</td>
				<td >
					${processRun.duringLong }(小时)
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 8px">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td width="4%" style="text-align: center;">序号</td>
				<td width="15%" style="text-align: center;">任务名称</td>
				<td width="8%" style="text-align: center;">创建时间</td>
				<td width="16%" style="text-align: center;">上个任务</td>
				<td  width="6%" style="text-align: center;">审批人</td>
				<td width="8%" style="text-align: center;">审批状态</td>
				<td  width="8%" style="text-align: center;">审批结果</td>
				<td width="8%" style="text-align: center;">处理时间</td>
				<td width="16%" style="text-align: center;">审批意见</td>
				<td width="16%" style="text-align: center;">用时(小时)</td>
			</tr>
			<c:forEach var="processFrom" items="${processFroms }" varStatus="i">
				<tr height="42">
				<td align="center">${i.index+1 }</td>
				<td style="padding: 5px;">
					${processFrom.taskName }
				</td>
				<td align="center">
					<fmt:formatDate value="${processFrom.createTime }"/>
				</td>
				<td align="center">
					${processFrom.fromTaskName }
				</td>
				<td align="center">
					${processFrom.taskUserName }
				</td>
				<td align="center">
					<c:if test="${processFrom.status==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.status==2 }">
						<span style="color: green">已审批</span>
					</c:if>
				</td>
				<td align="center">
					<c:if test="${processFrom.approvalStatus==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==2 }">
						<span style="color: red">审批驳回</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==3 }">
						<span style="color: green;">通过</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==4 }">
						<span style="color: green;">提交上级审批</span>
					</c:if>
				</td>
				<td align="center">
					<fmt:formatDate value="${processFrom.finishTime }"/>
				</td>
				<td align="center">
					${processFrom.comments }
				</td>
				<td align="center">
					${processFrom.duringLong }
				</td>
			</c:forEach>
		</table>
	<div class="formButton" style="width: 100%;">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	</div>
	</div>
</body>
</html>