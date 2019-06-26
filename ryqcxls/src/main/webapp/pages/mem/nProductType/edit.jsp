<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑商品类型</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx}/css/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/select2.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.grey.css"	class="skin-color" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a>
		<a href="javascript:void(-1)" class="current">
			<c:if test="${nProductType.dbid>0 }" var="status">编辑商品类型</c:if>
			<c:if test="${status==false }">添加商品类型</c:if>
		</a>
</div>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="widget-box">
				<div class="widget-content nopadding">
					<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
						<input type="hidden" value="${nProductType.dbid }" id="dbid" name="dbid">
						<div class="control-group">
							<label class="control-label">名称：</label>
							<div class="controls">
								<input type="text" class="input-xlarge" name="name"	id="name" value="${nProductType.name }" checkType="string,1,20"  tip="请输入商品类型名称！"  />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">上级分类：</label>
							<div class="controls">
								<select id="parentId" name="parentId" >
									<option value="0" >顶级分类</option>
									${nProductTypeSelect }
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">排序：</label>
							<div class="controls">
								<input type="text" class="input-xlarge" name="orderNum" id="orderNum"  value="${nProductType.orderNum }" checkType="integer" canEmpty="Y" tip="请输入排序号！"/>
							</div>
						</div>
						<div class="form-actions">
							<a href="javascript:void(-1)" class="btn btn-primary"	onclick="$.utile.submitForm('frmId','${ctx}/nProductType/save')">
								<i class="icon-ok-sign icon-white"></i>保存
							</a> <a class="btn btn-inverse" onclick="window.history.go(-1)">
							<i	class="icon-hand-left icon-white"></i>返回</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
});
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
</body>
</html>
