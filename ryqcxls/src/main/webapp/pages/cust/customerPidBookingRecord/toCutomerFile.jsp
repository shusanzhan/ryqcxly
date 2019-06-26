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
<title>客户归档跳转页面</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
	<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<tr>
				<td class="formTableTdLeft">客户姓名：</td>
				<td>
					<input type="text" readonly="readonly" class="mideaX text" name="customerName" id="name"  value="${customer.name }" />
				</td>
			<td class="formTableTdLeft">常用手机号：</td>
				<td>
					<input type="text" readonly="readonly" class="mideaX text" name="mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" />
				</td>
		</tr>
		<tr>
				<td class="formTableTdLeft">销售顾问：</td>
				<td>
					<input type="text" readonly="readonly" class="mideaX text" name="realName" id="realName"  value="${customer.user.realName }" />
				</td>
				<td class="formTableTdLeft">联系电话：</td>
				<td>
						<input type="text" readonly="readonly" class="mideaX text" name="moiblePhone" id="moiblePhone"  value="${customer.user.mobilePhone }" />	
				</td>
			</tr>
				<tr>
				<td class="formTableTdLeft">车型：</td>
				<td colspan="3">
					<c:set value="${customer.customerBussi.brand.name }${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }${customer.customerPidBookingRecord.carColor.name }" var="carModel"></c:set>
					${carModel}  ${customer.carModelStr}
				</td>
				
			</tr>
			<c:if test="${customerPidBookingRecord.kdStatus>1 }">
				<tr>
					<td class="formTableTdLeft">销售类型：</td>
					<td colspan="">
						跨店销售
					</td>
					<td class="formTableTdLeft">原始进货商：</td>
					<td colspan="">
						${factoryOrder.sourceCompany.name }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft" colspan="">经销商买卖状态：</td>
					<td colspan="3">
						<c:if test="${customerPidBookingRecord.kdStatus==2 }">
							<span style="color:yellow;">跨店邦车申请中</span>
						</c:if>
						<c:if test="${customerPidBookingRecord.kdStatus==3 }">
							<span style="color: red;">卖方同意邦车</span>
						</c:if>
						<c:if test="${customerPidBookingRecord.kdStatus==4 }">
							<span style="color: blue;">卖方已发车</span>
						</c:if>
						<c:if test="${customerPidBookingRecord.kdStatus==5 }">
							<span style="color: green;">买方已收车</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft" colspan="">DMS买卖状态：</td>
					<td colspan="3">
						<label style="float: left;"><input type="radio" value="1" name="dmsStatus" id="dmsStatus"   ${customer.dmsStatus==1?'checked="checked"':'' }>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<label style="float: left;"><input type="radio" value="2" name="dmsStatus" id="dmsStatus"   ${customer.dmsStatus==2?'checked="checked"':'' }>否</label>
						<span style="color: red">*</span>
						<span style="color: red;">说明：如有此操作，该车后续权益与责任由车辆买方承担</span>	
						<label style="clear: both;"></label>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="formTableTdLeft">VIN码：</td>
				<td>
						<input readonly="readonly" type="text"  class="mideaX text" name="vinCode" id="vinCode"  value="${customer.customerPidBookingRecord.vinCode}"/>	
				</td>
				<td class="formTableTdLeft" >归档日期：</td>
				<td colspan="3">
					<input  name="fileDate" class="mideaX text" id="fileDate" title="" value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>' onfocus="new WdatePicker()"></input>
				</td>
			</tr>
			</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="if(validateFrmBeforeSmb()){$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/customerFile')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">关&nbsp;&nbsp;闭</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function validateFrmBeforeSmb(){
	var kdStatus="${customerPidBookingRecord.kdStatus}";
	if(kdStatus>1){
		var dmsStatus=$('input:radio[name="dmsStatus"]:checked').val();
		if(null==dmsStatus||dmsStatus==''){
			alert("请选择DMS买卖状态");
			return false;
		}
	}
	return true;
}
</script>
</html>