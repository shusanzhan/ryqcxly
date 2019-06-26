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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>绑车申请</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	 <div class="alert alert-error">
	 <c:if test="${factoryOrder.storeCompany.dbid==enterprise.dbid }">
		<strong>绑车申请流程：</strong>申请（销售商）—》审批（进货商）
	 </c:if>
	 <c:if test="${factoryOrder.storeCompany.dbid!=enterprise.dbid }">
		<strong>绑车申请流程：</strong>申请（销售商）—》审批（进货商）—》发车（进货商）—》收车（销售商）
	 </c:if>
	</div>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						${factoryOrder.brand.name }
						${factoryOrder.carSeriy.name }
						${factoryOrder.carModel.name }
						${factoryOrder.carColor.name }
					</td>
					<td class="formTableTdLeft">物料号:&nbsp;</td>
					<td id="carColorLable">
						${factoryOrder.materialNumber }
					</td>
				</tr>
				<tr  height="42" >
					<td class="formTableTdLeft">原始进货商:&nbsp;</td>
					<td id="carModelLabel">
						${factoryOrder.sourceCompany.name }
					</td>
					<td class="formTableTdLeft">管理公司:&nbsp;</td>
					<td id="carColorLable">
						${factoryOrder.storeCompany.name }
					</td>
				</tr>
				<tr  height="42" >
					<td class="formTableTdLeft">库存:&nbsp;</td>
					<td id="carModelLabel">
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
				</tr>
				<tr height="42" id="vinCodeTr" >
					<td class="formTableTdLeft">客户:&nbsp;</td>
					<td colspan="3">
							<input type="hidden" class="mediaX text" name="customerPidRecordId" id="customerPidRecordId" readonly="readonly"  />
							<input type="text" class="mediaX text" name="customerName" id="customerName" readonly="readonly" checkType="string,1,200000" tip="请选择客户！"/>
							<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择客户</a>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">申请备注:&nbsp;</td>
					<td colspan="3">
						<textarea  name="note" id="note" class="textarea largeXXX text" style="height: 70px;width: 540px;" title="" checkType="string,2" tip="请填写一点备注吧">${repaymentInfo.note }</textarea>	
						<span style="color: red">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">物流备注:&nbsp;</td>
					<td colspan="3">
						<textarea  name="wlNote" id="wlNote" class="textarea largeXXX text" style="height: 70px;width: 540px;" title="" checkType="string,2" tip="请填写一点备注吧"></textarea>	
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/orderBuySaler/saveApplaySale')"	class="but butSave">绑车申请</a>
		<a  href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a>  
	</div>

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