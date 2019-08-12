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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
}
</style>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42" id="vinCodeTr" >
				<td class="formTableTdLeft">车架号:&nbsp;</td>
				<td colspan="3">
					<input type="text" class="mediaX text" name="vinCode" id="vinCode" value="${factoryOrder.vinCode }" readonly="readonly" checkType="string,1,200000" tip="接受会员不能为空！"/>
				</td>
			</tr>
			<tr height="42" id="vinCodeTr" >
				<td class="formTableTdLeft">客户:&nbsp;</td>
				<td colspan="3">
						<input type="hidden" class="mediaX text" name="customerPidRecordId" id="customerPidRecordId" readonly="readonly"  />
						<input type="text" class="mediaX text" name="customerName" id="customerName" readonly="readonly" checkType="string,1,200000" tip="请选择客户！"/>
						<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择客户</a>
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3"><textarea   name="wlNote" id="wlNote"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.wlNote }</textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/saveWlbStock')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<div class="frmContent">
<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆基本信息</div>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;padding: 12px">
			<tr>
				<td class="formTableTdLeft">物料号：</td>
				<td colspan="3">
					${factoryOrder.materialNumber}&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">物料描述：</td>
				<td colspan="3">
					${factoryOrder.materialDes }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">工厂价：</td>
				<td>
					${factoryOrder.marketPrice }
				</td>
				<td class="formTableTdLeft">市场指导价：</td>
				<td>
					${factoryOrder.factoryPrice }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">工厂订单日期：</td>
				<td>
					${factoryOrder.factoryOrderDate }
				</td>
				<td class="formTableTdLeft">惠民：</td>
				<td>
					${factoryOrder.huimin }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">订单性质：</td>
				<td>
					${factoryOrder.orderAttr }
				</td>
				<td class="formTableTdLeft">订单种类：</td>
				<td>
					${factoryOrder.orderType }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >加装状态：</td>
				<td>
					<c:if test="${factoryOrder.isInstall==1 }">
						<span style="color: red;">未加装</span>
					</c:if> 
					<c:if test="${factoryOrder.isInstall==2 }">
						<span style="color: green;">未加装</span>
					</c:if> 
				</td>
				 <td class="formTableTdLeft"  >车辆状态：</td>
				<td>
					<c:if test="${factoryOrder.carStatus==1 }">
						<span style="color: red;">在途订单</span>
					</c:if>
					<c:if test="${factoryOrder.carStatus==2 }">
						<span style="color: green;">车辆在库</span>
					</c:if>
					<c:if test="${factoryOrder.carStatus==4 }">
						<span style="color: pink;">车辆出库</span>
					</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >还款状态：</td>
				<td>
					<c:if test="${factoryOrder.repaymentStatus==1}">
						<span style="color: blue;">无需还款</span>
					</c:if> 
					<c:if test="${factoryOrder.repaymentStatus==2}">
						<span style="color: red;">待还款</span>
					</c:if> 
					<c:if test="${factoryOrder.repaymentStatus==3}">
						<span style="color: green;">已还款</span>
					</c:if> 
				</td>
				<td class="formTableTdLeft">在库周期：</td>
				<td>
					${factoryOrder.stockCyle}
					${factoryOrder.stockAgeDate }
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">创建日期：</td>
				<td>
					${factoryOrder.createDate}
				</td>
			</tr>
		</table>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function validate(){
	var hasCarOrder=$("#customerName").val();
	if(customerName==''){
		alert("请先选客户！");
		return false;
	}
	return true;
}
function choice(){
	var hasCarOrder=$('#hasCarOrder').val();
	var url="${ctx}/customerPidBookingRecord/selectCustomerPidRecord?factoryOrderId=${factoryOrder.dbid }";
	if(validate()){
		commonSelect('请选交车预约',url,'customerPidRecordId','customerName','customerName',1024,450)
	}
}
</script>
</html>