<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>视频管理添加/编辑</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</head>
<body>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId" target="_parent">
		<input type="hidden" value="${bussiVideo.dbid }" id="dbid" name="bussiVideo.dbid">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr id="logoDiv">
					<td class="formTableTdLeft">标题：</td>
					<td>
						<input type="text" name="bussiVideo.title" id="title" value="${bussiVideo.title }">
					</td>
				</tr>
				<tr id="logoDiv">
					<td class="formTableTdLeft">图片:&nbsp;</td>
					<td>
						<input type="hidden" name="bussiVideo.pictrue" id="pictrue" readonly="readonly"	value="${bussiVideo.pictrue }">
						<img alt="" id="pictrueImg" src="${bussiVideo.pictrue}" width="150" height="90">
						<a href="javascript:void(-1)" onclick="uploadFile('pictrue','pictrueImg')">上传</a>
					</td>
				</tr>
				<tr id="logoDiv">
					<td class="formTableTdLeft">视频：</td>
					<td>
						<input type="hidden" name="bussiVideo.mideuUrl" id="fileUpload" readonly="readonly"	value="${bussiVideo.mideuUrl }">
						<div id="div1" >
							<div style="padding-left: 5px;">
								<span id="spanButtonPlaceholder1"></span> 
								<span style="color: red;font-size:10px;">文件不能超过5MB</span>
							</div>
							<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
						</div>
					</td>
				</tr>
				<tr style="height: 50px;">
					<td class="formTableTdLeft">描述：</td>
					<td>
						<textarea class="largeX text" name="bussiVideo.note" rows="5" style="height: 50px;"	id="note" >${bussiVideo.note }</textarea>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/bussiVideo/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
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
					file_size_limit : "20485760", // 10MB
					file_types : "*.MP4",
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
