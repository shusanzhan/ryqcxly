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
<title>优惠券</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/coupon/queryList'">优惠券管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(coupon) }">添加优惠券</c:if>
	<c:if test="${!empty(coupon) }">编辑优惠券</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="coupon.dbid" id="dbid" value="${coupon.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="coupon.name" id="name"
					value="${coupon.name }" class="largeX text" title="名称" placeholder="请输入优惠券名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">类型：&nbsp;</td>
				<td>
					<c:if test="${empty(coupon) }">
						<label style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
							<input type="radio" name="coupon.type" id="type1" onclick="dymoney(this.value)" value="1" checked="checked">折扣券</label>
						<label style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
							<input type="radio" name="coupon.type" id="type2" onclick="dymoney(this.value)" value="2">代金券</label>
					</c:if>
					<c:if test="${!empty(coupon) }">
						<label style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
							<input type="radio" name="coupon.type" id="type1" onclick="dymoney(this.value)" value="1" ${coupon.type==1?'checked="checked"':'' } >折扣券</label>
						<label style="float: left;padding-left:8px;width: 120px;line-height: 20px;">
							<input type="radio" name="coupon.type" id="type2" onclick="dymoney(this.value)" value="2" ${coupon.type==2?'checked="checked"':'' }>代金券</label>
					</c:if>
				</td>
			</tr>
			<tr>
				<%-- <td class="formTableTdLeft">消费金额满：&nbsp;</td>
				<td ><input type="text"  class="largeX text" name="coupon.conditions" id="conditions"  value="${coupon.conditions }" checkType="float"  tip="请输入优惠劵面额！"></td> --%>
				<td class="formTableTdLeft">
				<c:if test="${empty(coupon) }" var="status">
						<label class="control-label" id="rabatt">折扣率：</label>
						<label class="control-label" id="dymoney" style="display: none;">抵用金额：</label>
					</c:if>
					<c:if test="${!empty(coupon) }" >
						<c:if test="${coupon.type==1 }">
							<label class="control-label" id="rabatt">折扣率：</label>
							<label 	class="control-label" id="dymoney" style="display: none;" >抵用金额：</label>
						</c:if>
						<c:if test="${coupon.type==2 }"  >
							<label class="control-label" id="rabatt" style="display: none;" >折扣率：</label>
							<label 	class="control-label" id="dymoney" >抵用金额：</label>
						</c:if>
					</c:if>
				</td>
				<td>
					<input type="text"  class="midea text" name="coupon.moneyOrRabatt" id="moneyOrRabatt1"  value="${coupon.moneyOrRabatt }" checkType="float"  tip="优惠额度必须小于优惠劵面额！"  />
					<c:if test="${empty(coupon) }" var="status">
						<label for="showHiden" style="width: 100px;line-height: 20px;">
							<input type="checkbox" class="input-xlarge" name="coupon.showHiden" id="showHiden" checked="checked"  value="true" >是否显示金额
						</label>
					</c:if>
					<c:if test="${status==false }">
						<label for="showHiden" style="width: 120px;line-height: 20px;">
								<input type="checkbox" class="input-xlarge" name="coupon.showHiden" id="showHiden"  ${coupon.showHiden==true?'checked="checked" ':'' }  value="true" >是否显示金额
						</label>
					</c:if>		
				</td>
				<td class="formTableTdLeft">设置：&nbsp;</td>
				<td >
					<c:if test="${empty(coupon) }" var="status">
						<label for="enabled" style="float: left;width: 120px;line-height: 20px;">
								<input type="checkbox" class="input-xlarge" name="coupon.enabled" id="enabled" checked="checked"  value="true" >是否启用
						</label>
					</c:if>
					<c:if test="${status==false }">
						<label for="enabled" style="float: left;width: 120px;line-height: 20px;">
								<input type="checkbox" class="input-xlarge" name="coupon.enabled" id="enabled"  ${coupon.enabled==true?'checked="checked" ':'' }  value="true" >是否启用
						</label>
					</c:if>		
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">发行数量:&nbsp;</td>
				<td >
					<input type="text" class="largeX text" name="coupon.ausgabeCount" id="ausgabeCount"  value="${coupon.ausgabeCount }" checkType="integer"  tip="优惠额度必须小于优惠劵面额！"  />
				</td>
				<%-- <td class="formTableTdLeft">用户可领取数：&nbsp;</td>
				<td >
						<input type="text" class="largeX text" name="coupon.userReceiveNum" id="userReceiveNum"  value="${coupon.userReceiveNum }"  />
				</td> --%>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">生效时间：&nbsp;</td>
				<td ><input type="text" class="largeX text" name="coupon.startTime" id="startTime" readonly="readonly"  onFocus="WdatePicker({minDate:'%y-%M-%d'})"  value="${coupon.startTime }" /></td>
				<td class="formTableTdLeft">失效时间：&nbsp;</td>
				<td ><input type="text" class="largeX text" name="coupon.stopTime" id="stopTime" readonly="readonly"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}'})"  value="${coupon.stopTime }" /></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">发券理由：&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="8" cols="120" name="coupon.reason" checkType="string,1,2000" tip="发券理由必填，2000个字符内">${coupon.reason }</textarea><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">图片:&nbsp;</td>
				<td >
					<input type="hidden" name="coupon.image" id="fileUpload" readonly="readonly"	value="${coupon.image }" />
					<img alt="" id="fileUploadImage" src="${coupon.image }" width="50" height="30" >
					<div id="div1">
						<!-- <a href="javascript:void(-1)" onclick="uploadFile('fileUpload','fileUploadImage')">上传图片</a> -->
						<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
						<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
						图片：规格为50*50
					</div>
				</td>
			</tr>
			<tr height="42">
				<td colspan="4">
					<textarea  class="input-xlarge" name="coupon.description" id="content" >${coupon.description }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/coupon/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
var editor=CKEDITOR.replace("content");
var upload1;
window.onload = function() {
	upload1 = new SWFUpload(
			{
				// Backend Settings
				upload_url : "${ctx}/swfUpload/uploadFile",
				post_params : {
					"PHPSESSID" : "6a95034fff6ba3a6aa8a990ca3af42ee","userId":"${sessionScope.user.dbid}"
				},
				//上传文件的名称
				file_post_name : "file",

				// File Upload Settings
				file_size_limit : "5242880", // 200MB
				file_types : "*.*",
				file_types_description : "All Files",
				file_upload_limit : "100",
				file_queue_limit : "0",

				// Event Handler Settings (all my handlers are in the Handler.js file)
				file_dialog_start_handler : fileDialogStart,
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueErrorHandler,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,

				// Button Settings
				button_image_url : "${ctx}/widgets/SWFUpload/images/XPButtonUploadText_61x22.png",
				button_placeholder_id : "spanButtonPlaceholder1",
				button_width : 61,
				button_height : 22,

				// Flash Settings
				flash_url : "${ctx}/widgets/SWFUpload/Flash/swfupload.swf",

				custom_settings : {
					progressTarget : "uploadFileContent",
					cancelButtonId : "btnCancel1",
					titlePicture : "fileUpload",
					fileUploadImage : "fileUploadImage"
				},
				// Debug Settings
				debug : false
			});

}

function show(id){
	var check=$("#"+id)[0].checked;
	if(check){
		$('#exchangeNum').attr('disabled',false)
		$('#exchangeNumDiv').css('display',"")
	}
	else{
		$('#exchangeNum').text=null;
		$('#exchangeNum').attr('disabled',true)
		$('#exchangeNumDiv').css('display',"none")
	}
}

function dymoney(val){
	var value=val;
	///var value=$("#type").val();
	if(value==1){
		$("#dymoney").css("display","none");
		$("#rabatt").css("display","");
	}
	if(value==2){
		$("#dymoney").css("display","");
		$("#rabatt").css("display","none");
		
	}
	
}
</script>
</html>