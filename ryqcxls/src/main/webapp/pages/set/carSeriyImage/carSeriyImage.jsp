<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加图片</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	#carSeriyId{
		width: 240px;
	}
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/carSeriy/queryList'">车系管理</a>-
   	<a href="javascript:void(-1)" class="current">
		上传图片
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${carSeriy.dbid }" id="carSeriyId" name="carSeriyId">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr>
					<td class="formTableTdLeft">车系：</td>
					<td id="carSeriyLabel">
						<select id="carSeriyId" class="large text" name="carSeriyId" onchange="sbm(this.value)">
							<option value="">请选择...</option>
							<c:forEach var="carM" items="${carSeriys }">
								<option value="${carM.dbid }" ${carM.dbid==carSeriy.dbid?'selected="selected"':'' }>${carM.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr id="logoDiv" > 
					<td class="formTableTdLeft">图片：</td>
					<td>
						<input type="hidden" name="url" id="fileUpload" readonly="readonly"	value="">
						<img alt="" id="fileUploadImage" src="" width="50" height="50" style="float: left;">
						<div id="div1">
							<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
							<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
							图片：规格为560*400
						</div>
					</td>
					</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/carSeriyImage/saveCarModelImage')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<c:if test="${empty(carSeriyImages)||carSeriyImages==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 未添照片
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead class="TableHeader">
		<tr>
			<td class="sn">
				序号
			</td>
			<td class="span4">图片</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${carSeriyImages }" var="carModelImage" varStatus="i">
			<tr height="110">
				<td style="text-align: center;">
					${i.index+1 }
				</td>
				<td style="text-align: left;">
					<img alt="" src="${carModelImage.url }" height="100" width="200">
				</td>
				<td>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.deleteById('${ctx}/carSeriyImage/delete?carSeriyId=${carSeriy.dbid}&dbid=${carModelImage.dbid }','searchPageForm')" title="删除">删除</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
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
	function sbm(value){
		window.location.href="${ctx}/carModelImage/carModelImages?carModelId="+value;
	}
</script>
</html>
