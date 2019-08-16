<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>消息模板添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
	function showOrHidn(varCheck,id){
		var va=varCheck.checked;
		if(va){
			$("#"+id).attr("disabled",false);
		}else{
			$("#"+id).attr("disabled",true);
		}
	}
</script>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/messageTemplate/queryList'">消息模板类型</a>-
	<a href="javascript:void(-1)" class="current">
		<c:if test="${messageTemplate.dbid>0 }" var="status">编辑消息模板</c:if>
		<c:if test="${status==false }">添加消息模板</c:if>
	</a>
</div>
<div class="frmContent">
   <form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
   	<s:token></s:token>
	<input type="hidden" value="${messageTemplate.dbid }" id="dbid" name="messageTemplate.dbid">
   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<tr>
			<td class="formTableTdLeft">微信消息类型：</td>
			<td>
				<c:if test="${empty(messageTemplate.msgtype) }">
				<select class="largeX text" id="msgtype" name="messageTemplate.msgtype" checkType="string,1,20" >
						<option value="0" >请选择...</option>
						<option value="text" ${messageTemplate.msgtype=='text'?'selected="selected"':'' } >text消息</option>
						<option value="image" ${messageTemplate.msgtype=='image'?'selected="selected"':'' } >image消息</option>
						<option value="voice" ${messageTemplate.msgtype=='voice'?'selected="selected"':'' } >voice消息</option>
						<option value="file" ${messageTemplate.msgtype=='file'?'selected="selected"':'' } >file消息</option>
						<option value="video" ${messageTemplate.msgtype=='video'?'selected="selected"':'' } >video消息</option>
						<option value="news" selected="selected">news消息</option>
						<option value="mpnews" ${messageTemplate.msgtype=='mpnews'?'selected="selected"':'' } >mpnews消息</option>
				</select>
				</c:if>
				<c:if test="${!empty(messageTemplate.msgtype) }">
				<select class="largeX text" id="msgtype" name="messageTemplate.msgtype" checkType="string,1,20" >
						<option value="0" >请选择...</option>
						<option value="text" ${messageTemplate.msgtype=='text'?'selected="selected"':'' } >text消息</option>
						<option value="image" ${messageTemplate.msgtype=='image'?'selected="selected"':'' } >image消息</option>
						<option value="voice" ${messageTemplate.msgtype=='voice'?'selected="selected"':'' } >voice消息</option>
						<option value="file" ${messageTemplate.msgtype=='file'?'selected="selected"':'' } >file消息</option>
						<option value="video" ${messageTemplate.msgtype=='video'?'selected="selected"':'' } >video消息</option>
						<option value="news" ${messageTemplate.msgtype=='news'?'selected="selected"':'' } >news消息</option>
						<option value="mpnews" ${messageTemplate.msgtype=='mpnews'?'selected="selected"':'' } >mpnews消息</option>
				</select>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">应用类型：</td>
			<td id="carModelLabel">
				<select class="largeX text" id="messageTemplateTypeId" name="messageTemplateTypeId" checkType="string,1,20" >
						<option value="0" >请选择...</option>
						<c:forEach var="messageTemplateType" items="${messageTemplateTypes }">
						<option value="${messageTemplateType.dbid }" ${messageTemplate.messageTemplateType.dbid==messageTemplateType.dbid?'selected="selected"':'' } >${messageTemplateType.name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">应用：</td>
			<td>
				<select class="largeX text" id="appId" name="appId" checkType="integer,1" >
					<option value="0" >请选择...</option>
					<c:forEach var="app" items="${apps }">
						<option value="${app.dbid }" ${messageTemplate.app.dbid==app.dbid?'selected="selected"':'' } >${app.name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr id="logoDiv">
				<td class="formTableTdLeft">通知图片：</td>
				<td>
					<input type="hidden" name="messageTemplate.picurl" id="fileUpload" readonly="readonly"	value="${messageTemplate.picurl }">
					<img alt="" id="fileUploadImage" src="${messageTemplate.picurl }" width="100" height="50">
						<div id="div1">
							<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
							<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
							规格为640*320
						</div>
				</td>
		</tr>
</table>
</form>                            
<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/messageTemplate/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript">
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
</script>
</html>
