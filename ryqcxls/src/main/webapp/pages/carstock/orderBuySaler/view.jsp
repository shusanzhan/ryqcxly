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
<title>绑车申请记录</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">
	绑车申请记录
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: left;">
						绑车申请
					</td>
			</tr>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">车型:&nbsp;</td>
				<td style='width:38%'>
					${factoryOrder.brand.name }
					${factoryOrder.carSeriy.name }
					${factoryOrder.carModel.name }
					${factoryOrder.carColor.name }
				</td>
				<td class="formTableTdLeft" style="width:12%">物料号:&nbsp;</td>
				<td style='width:38%'>
					${factoryOrder.materialNumber }
				</td>
			</tr>
			<tr  height="42" >
					<td class="formTableTdLeft" style="width:12%">原始进货商:&nbsp;</td>
					<td style='width:38%'>
						${factoryOrder.sourceCompany.name }
					</td>
					<td class="formTableTdLeft" style="width:12%">管理公司:&nbsp;</td>
					<td style='width:38%'>
						${factoryOrder.storeCompany.name }
					</td>
				</tr>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">库存:&nbsp;</td>
				<td style='width:38%'>
					<c:if test="${factoryOrder.carStatus==1 }">
						<span style="color: red;">在途</span>
					</c:if>
					<c:if test="${factoryOrder.carStatus==2 }">
						<span style="color: green;">
							${carReceiving.storeArea.name }
							${carReceiving.storeRoom.name }
							${carReceiving.storage.name }
						</span>
					</c:if>
				</td>
				<td class="formTableTdLeft" style="width:12%">工厂指导价:&nbsp;</td>
				<td style='width:38%'>
					${factoryOrder.factoryPrice }
				</td>
			</tr>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">单车成本:&nbsp;</td>
				<td style='width:38%'>
					${factoryOrder.purchasePrice}
				</td>
				<td class="formTableTdLeft" style="width:12%">执行价:&nbsp;</td>
				<td style='width:38%'>
					${factoryOrder.marketPrice }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:12%">申请方:&nbsp;</td>
				<td style='width:38%'>
					${orderBuySaler.buyCompany.name }
				</td>
				<td class="formTableTdLeft" style="width:12%">确认方:&nbsp;</td>
				<td style='width:38%'>
					${orderBuySaler.saleCompnay.name }
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width:12%">申请时间:&nbsp;</td>
				<td style='width:38%'>
					<fmt:formatDate value="${orderBuySaler.applayDate}"/>
				</td>
				<td class="formTableTdLeft" style="width:12%">申请人:&nbsp;</td>
				<td style='width:38%'>
					${orderBuySaler.applayPerson }
				</td>
			</tr>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">申请备注:&nbsp;</td>
				<td id="carModelLabel" colspan="3">
					${orderBuySaler.note }
				</td>
			</tr>
		</table>
		<br>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="text-align: left;">
						业务数据
					</td>
			</tr>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">确认状态:&nbsp;</td>
				<td  colspan="3">
					<c:if test="${orderBuySaler.confireStatus==1 }">
						<span style="color: red;">待确认...</span>
					</c:if>
					<c:if test="${orderBuySaler.confireStatus==2 }">
						<span style="color: green;">同意绑车</span>
					</c:if>
					<c:if test="${orderBuySaler.confireStatus==3 }">
						<span style="color: red;">驳回绑车</span>
					</c:if>
				</td>
			</tr>
			<c:if test="${orderBuySaler.confireStatus>1 }">
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">确认时间:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.confireDate }
					</td>
					<td class="formTableTdLeft" style="width:12%">确认人:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.confirePerson }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">确认备注:&nbsp;</td>
					<td id="carModelLabel" colspan="3">
						${orderBuySaler.confireNote }
					</td>
				</tr>
			</c:if>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">发车状态:&nbsp;</td>
				<td colspan="3">
					<c:if test="${orderBuySaler.sendCarStatus==1 }">
					<span style="color: red;">待发车</span>
				</c:if>
				<c:if test="${orderBuySaler.sendCarStatus==2 }">
					<span style="color: green;">已经发车</span>
				</c:if>
				</td>
			</tr>
			<c:if test="${orderBuySaler.sendCarStatus>1 }">
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">发车时间:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.sendCarDate }
					</td>
					<td class="formTableTdLeft" style="width:12%">发车人:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.sendCarPerson }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">发车备注:&nbsp;</td>
					<td  colspan="3">
						${orderBuySaler.sendCarNote }
					</td>
				</tr>
			</c:if>
			<tr  height="42" >
				<td class="formTableTdLeft" style="width:12%">收车状态:&nbsp;</td>
				<td colspan="3">
					<c:if test="${orderBuySaler.acceptStatus==1 }">
					<span style="color: red;">待收车</span>
				</c:if>
				<c:if test="${orderBuySaler.acceptStatus==2 }">
					<span style="color: green;">已收车</span>
				</c:if>
				</td>
			</tr>
			<c:if test="${orderBuySaler.acceptStatus>1 }">
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">收车时间:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.acceptDate }
					</td>
					<td class="formTableTdLeft" style="width:12%">收车人:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.acceptPerson }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">收车备注:&nbsp;</td>
					<td  colspan="3">
						${orderBuySaler.acceptNote }
					</td>
				</tr>
			</c:if>
			<c:if test="${orderBuySaler.applayTurnBackStatus>1 }">
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">申请状态:&nbsp;</td>
					<td style='width:38%'>
						<c:if test="${orderBuySaler.applayTurnBackStatus==2 }">
							<span style="color: red;">申请退车</span>
						</c:if>
						<c:if test="${orderBuySaler.applayTurnBackStatus==3 }">
							<span style="color: green;">同意退车</span>
						</c:if>
						<c:if test="${orderBuySaler.applayTurnBackStatus==4 }">
							<span style="color: red;">驳回</span>
						</c:if>
					</td>
					<td class="formTableTdLeft" style="width:12%">申请时间:&nbsp;</td>
					<td style='width:38%'>
						${orderBuySaler.applayTurnBackDate }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" style="width:12%">申请备注:&nbsp;</td>
					<td  colspan="3">
							${orderBuySaler.applayTurnBackNote }
					</td>
				</tr>
				<c:if test="${orderBuySaler.applayTurnBackStatus==3 }">
					<tr height="42">
						<td class="formTableTdLeft" style="width:12%">审批人:&nbsp;</td>
							<td style='width:38%'>
							${orderBuySaler.approvalPerson }
						</td>
						<td class="formTableTdLeft" style="width:12%">申请时间:&nbsp;</td>
						<td style='width:38%'>
							${orderBuySaler.approvalApplayDate }
						</td>
					</tr>
					<tr height="42">
					<td class="formTableTdLeft" style="width:12%">审批备注:&nbsp;</td>
					<td  colspan="3">
							${orderBuySaler.approvalNote }
					</td>
				</tr>
				</c:if>
			</c:if>
		</table>
	<div class="formButton" style="width: 100%;">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	</div>
	</div>
</body>
</html>