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
<title>车辆入库收车</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<input type="hidden" name="refundCar.dbid" id="dbid" value="${carReceiving.dbid}">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
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
					<td class="formTableTdLeft">退库原因:&nbsp;</td>
					<td colspan="3" id="storeRoomLabel">
						<input type="text" id=reason name="refundCar.reason" value="${refundCar.reason }" class="text largeX"  checkType="string,1,4000" tip="请输入退库理由，为1,4000个字符">
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3" id="storeRoomLabel">
						<textarea rows="" cols="" id="note" name="refundCar.note"  class="largeXXX text textarea">${refundCar.note }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="showDialog()"	class="but butSave">保存退库</a> 
		<a id="saveButton" href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">关&nbsp;&nbsp;闭</a> 
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function showDialog(){
		var reason=$("#reason").val();
		if(null==reason||reason.length<=0){
			alert("请填写退库原因！");
			$("#reason").focus();
			return false;
		}
		window.top.art.dialog({
			content : '【${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }】添加退库记录吗？填写退库记录将删除车辆档案信息，删除数据后不可恢复，请慎重操作！',
			icon : 'question',
			width:"320px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm('frmId','${ctx}/refundCar/save')
			},
			cancel : true
		});
	}	
</script>
</html>