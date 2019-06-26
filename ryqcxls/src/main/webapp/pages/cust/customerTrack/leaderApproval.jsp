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
<style type="text/css">
	
.frmContent form table tr {
    height: 28px;
}
</style>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="customerId" value="${customerTrack.customer.dbid }" id="customerId"></input>
		<input type="hidden" name="dbid" id="dbid" value="${customerTrack.dbid }">
		<input type="hidden" name="nextId" id="nextId" value="${next.dbid }">
		<input type="hidden" name="typeR" id="typeR" value="${param.typeR }">
		<c:if test="${param.type==3 }">
			<input type="hidden" name="type" id="type" value="${param.type }">
		</c:if>
		<c:if test="${param.type!=3 }">
			<input type="hidden" name="type" id="type" value="1">
		
		</c:if>
		<s:token></s:token>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">客户信息</div>
		<table border="0" class="tableCustomer" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr>
				<td class="formTableTdLeft">创建日期：</td>
				<td>
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td class="formTableTdLeft">意向车型：</td>
				<td>
					<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
					${carModel} ${customer.carModelStr}  
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<a href="javascript:void(-1)" class="dropDownContent" onclick="window.open('${ctx}/customerTrack/personCustomerTrackRecord?customerId=${customer.dbid}&redirect=1')">${customer.name }&nbsp;&nbsp;${customer.sex }</a>
				</td>
				<td class="formTableTdLeft">意向级别：</td>
				<td >
					${customer.customerPhase.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">常用手机号：</td>
				<td>
					${customer.mobilePhone }
				</td>
				<td class="formTableTdLeft">交叉客户：</td>
				<td>
					${customer.cityCrossCustomer.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">预计成交时间：</td>
				<td id="areaLabel">
					${customer.customerBussi.trackingPhase.name }
				</td>
				<td class="formTableTdLeft">客户来源：</td>
				<td id="areaLabel"> 
					${customer.customerBussi.infoFrom.name }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">销售顾问：</td>
				<td id="areaLabel">
					${customer.user.realName }
				</td>
				<td class="formTableTdLeft">联系电话：</td>
				<td id="areaLabel"> 
					${customer.user.mobilePhone }
				</td>
			</tr>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">跟踪明细</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">日期:&nbsp;</td>
				<td >
					<fmt:formatDate value="${customerTrack.trackDate }" pattern="yyyy年MM月dd日 HH:mm" />
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
			<tr height="42">
				<td class="formTableTdLeft">更新级别:&nbsp;</td>
				<td >
					${customerTrack.beforeCustomerPhase.name}
				</td>
				<td>下次预约时间:</td>
				<td ><fmt:formatDate value="${customerTrack.nextReservationTime }" pattern="yyyy年MM月dd日 HH:mm" /> </td>
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
				<td colspan="3">
				${customerTrack.dealMethod }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">展厅经理意见:&nbsp;</td>
				<td colspan="3">${customerTrack.showroomManagerSuggested }</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">销售经理意见:&nbsp;</td>
				<td colspan="3"><textarea  name="salesNote" id="salesNote"
					 class="textarea largeXXX text" title="销售经理意见"></textarea></td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerTrack/saveLeaderApproval')"	class="but butSave">保存</a> 
			<a href="javascript:void(-1)" class="but butCancle"	onclick="art.dialog.close()"	class="but butSave">关闭</a> 
		</div>
	</form>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>