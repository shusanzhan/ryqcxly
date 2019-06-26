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
<style type="text/css">
	#storeAreaId{
		width: 80px;
	}
	#storeRoomId{
		width: 80px;
	}
	#storageId{
		width: 80px;
	}
</style>
<title>车辆移交</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<input type="hidden" name="carHandOver.dbid" id="dbid" value="${carHandOver.dbid}">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">车辆信息</div>
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
					<td class="formTableTdLeft">VIN码:&nbsp;</td>
					<td id="carColorLable">
						${factoryOrder.vinCode }
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft">进货商:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.sourceCompany.name }
					</td>
					<td class="formTableTdLeft">管理公司:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.storeCompany.name }
					</td>
				</tr> 
				<tr height="42">
					<td class="formTableTdLeft">指导价:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.factoryPrice }
					</td>
					<td class="formTableTdLeft">执行价:&nbsp;</td>
					<td colspan="1">
						${factoryOrder.marketPrice}
					</td>
					
				</tr> 
			</tbody>
		</table>
		<div class="frmTitle" onclick="showOrHiden('contactTable')">客户信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr height="42">
					<td class="formTableTdLeft" >客户名称：</td>
					<td>
						${customer.name }&nbsp;&nbsp;&nbsp;&nbsp;（${customer.sex }） 
					</td>
					<td>销售顾问：</td>
					<td>
						${customer.mobilePhone}
					</td>
				</tr>
				<tr height="42">
					<td class="formTableTdLeft" >销售顾问：</td>
					<td>
						${customer.bussiStaff}&nbsp;&nbsp;&nbsp;&nbsp; 
					</td>
					<td>联系电话：</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						${customer.user.mobilePhone }
					</td>
				</tr>
			</table>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr height="42">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3">
						<textarea  name="note" id="note" class="textarea largeXXX text" style="height: 120px;width: 540px;" title="" checkType="string,2" tip="请填写一点备注吧">${carHandOver.note }</textarea>	
						<span style="color: red">*</span>
					</td>
				</tr>
			</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/carHandOver/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a id="" href="javascript:void(-1)"	onclick="art.dialog.close(-1)"	class="but butCancle">关闭</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>