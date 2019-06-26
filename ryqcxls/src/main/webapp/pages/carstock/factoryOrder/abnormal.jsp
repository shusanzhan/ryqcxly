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
<title>标记异常车辆</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<div class="alert alert-info">
		<strong>提示：</strong>1、
	</div>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="factoryOrderId" id="factoryOrderId" value="${factoryOrder.dbid}">
		<input type="hidden" name="smtType" id="smtType" value="1">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 20px;">
			<tbody  >
				<tr  height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						${factoryOrder.carSeriy.name }
						${factoryOrder.carModel.name }
						${factoryOrder.carColor.name }
					</td>
					<td class="formTableTdLeft">物料号:&nbsp;</td>
					<td id="carColorLable">
						${factoryOrder.materialNumber }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3">
						<textarea  name="note" id="note" class="textarea largeXXX text" style="height: 120px;width: 540px;" title="" checkType="string,2" tip="请填写一点备注吧">${repaymentInfo.note }</textarea>	
						<span style="color: red">*</span>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="formButton">
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#smtType').val(2);$.utile.submitAjaxForm('frmId','${ctx}/factoryOrder/saveAbnormal')"	class="but butSave">标记为异常</a>
		<a id="saveButton" href="javascript:void(-1)"	onclick="$('#smtType').val(1);$.utile.submitAjaxForm('frmId','${ctx}/factoryOrder/saveAbnormal')"	class="but butSave">标记为正常</a>
		<a  href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a>  
	</div>

</div>

</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function showDialog(){
		window.top.art.dialog({
			content : '请确认收车信息是否正确，提交后将不可更改！',
			icon : 'question',
			width:"250px",
			height:"80px",
			window : 'top',
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.utile.submitAjaxForm(frmId,url);
			},
			cancel : true
		});
	}	
	function ajaxStoreRoom(val){
		if(null==val||val==''){
			$("#storeRoomId").remove();
			$("#storageId").remove();
			return false;
		}
		$("#storeRoomId").remove();
		$("#storageId").remove();
		$.post("${ctx}/storeRoom/ajaxStoreRoom?storeAreaId="+val+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#storeRoomLabel").append(data);
			}
		});
	}
	function ajaxStorage(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		if(value==''||value<=0){
			$("#storageId").remove();
			return;
		}
		$("#storageId").remove();
		$.post("${ctx}/storage/ajaxStorage?storeRoomId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#storeRoomLabel").append(data);
			}
		});
	}
</script>
</html>