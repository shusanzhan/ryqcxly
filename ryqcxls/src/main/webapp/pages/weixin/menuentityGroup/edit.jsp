<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑菜单</title>
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
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
			<div class="widget-box">
				<div class="widget-content nopadding">
					<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId" target="_parent">
						<input type="hidden" value="${weixinMenuentityGroup.dbid }" id="dbid" name="weixinMenuentityGroup.dbid">
						<input type="hidden" value="${weixinMenuentityGroup.createDate }" id="createDate" name="weixinMenuentityGroup.createDate">
						<input type="hidden" value="${weixinMenuentityGroupMatchRule.dbid }" id="weixinMenuentityGroupMatchRuleId" name="weixinMenuentityGroupMatchRule.dbid">
						<c:if test="${empty(weixinMenuentityGroup)}">
							<input type="hidden" value="2" id="type" name="weixinMenuentityGroup.type">
						</c:if>
						<c:if test="${!empty(weixinMenuentityGroup)}">
							<input type="hidden" value="${weixinMenuentityGroup.type }" id="type" name="weixinMenuentityGroup.type">
						</c:if>
						<div class="control-group">
							<label class="control-label">个性菜单名称：</label>
							<div class="controls">
								<input type="text" class="input-xlarge" name="weixinMenuentityGroup.name"	id="name" value="${weixinMenuentityGroup.name }" checkType="string,1,20"  tip="请输入菜单名称！"  />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">匹配性别：</label>
							<div class="controls">
									<select id="type" name="weixinMenuentityGroupMatchRule.sex" checkType="string,1,20"  tip="匹配性别">
										<option value="0" >请选择...</option>
										<option value="1" ${weixinMenuentityGroupMatchRule.sex=='1'?'selected="selected"':'' }>男</option>
										<option value="2" ${weixinMenuentityGroupMatchRule.sex=='2'?'selected="selected"':'' }>女</option>
									</select>
							</div>
						</div> 
						<div class="control-group">
							<label class="control-label">匹配客户端版本：</label>
							<div class="controls">
									<select id="type" name="weixinMenuentityGroupMatchRule.client_platform_type" checkType="string,1,20"  tip="匹配客户端版本">
										<option value="0" >请选择...</option>
										<option value="1" ${weixinMenuentityGroupMatchRule.client_platform_type=='1'?'selected="selected"':'' }>IOS</option>
										<option value="2" ${weixinMenuentityGroupMatchRule.client_platform_type=='2'?'selected="selected"':'' }>Android</option>
									</select>
							</div>
						</div> 
						<div class="control-group">
							<label class="control-label">匹配语言：</label>
							<div class="controls">
									<select id="language" name="weixinMenuentityGroupMatchRule.language" checkType="string,1,20"  tip="匹配客户端版本">
										<option value="0" >请选择...</option>
										<option value="zh_CN" ${weixinMenuentityGroupMatchRule.language=='zh_CN'?'selected="selected"':'' }>简体中文</option>
										<option value="zh_TW" ${weixinMenuentityGroupMatchRule.language=='zh_TW'?'selected="selected"':'' }>繁体中文TW </option>
										<option value="zh_HK" ${weixinMenuentityGroupMatchRule.language=='zh_HK'?'selected="selected"':'' }>繁体中文HK </option>
										<option value="en" ${weixinMenuentityGroupMatchRule.language=='en'?'selected="selected"':'' }>英文</option>
										<option value="id" ${weixinMenuentityGroupMatchRule.language=='id'?'selected="selected"':'' }>印尼 </option>
										<option value="ms" ${weixinMenuentityGroupMatchRule.language=='ms'?'selected="selected"':'' }>马来</option>
										<option value="es" ${weixinMenuentityGroupMatchRule.language=='es'?'selected="selected"':'' }>西班牙 </option>
										<option value="ko" ${weixinMenuentityGroupMatchRule.language=='ko'?'selected="selected"':'' }>韩国</option>
										<option value="it" ${weixinMenuentityGroupMatchRule.language=='it'?'selected="selected"':'' }>意大利</option>
										<option value="ja" ${weixinMenuentityGroupMatchRule.language=='ja'?'selected="selected"':'' }>日本</option>
										<option value="pl" ${weixinMenuentityGroupMatchRule.language=='pl'?'selected="selected"':'' }>波兰</option>
										<option value="pt" ${weixinMenuentityGroupMatchRule.language=='pt'?'selected="selected"':'' }>葡萄牙</option>
										<option value="ru" ${weixinMenuentityGroupMatchRule.language=='ru'?'selected="selected"':'' }>俄国</option>
										<option value="th" ${weixinMenuentityGroupMatchRule.language=='th'?'selected="selected"':'' }>泰文</option>
										<option value="vi" ${weixinMenuentityGroupMatchRule.language=='vi'?'selected="selected"':'' }>越南</option>
									</select>
							</div>
						</div> 
						<div class="control-group" >
							<label class="control-label">备注：</label>
							<div class="controls">
								<textarea  class="input-xlarge" name="weixinMenuentityGroup.note" id="note" style="height: 120px;width: 540px;"  checkType="string,1,500" tip="请输入URL或触发关键词！">${weixinMenuentityGroup.note }</textarea>
							</div>
						</div>
						<div class="form-actions">
							<a href="javascript:void(-1)" class="btn btn-primary"	onclick="$.utile.submitForm('frmId','${ctx}/weixinMenuentityGroup/save')">
								<i class="icon-ok-sign icon-white"></i>保存
							</a> <a class="btn btn-inverse" onclick="art.dialog.close()">
							<i	class="icon-hand-left icon-white"></i>取消</a>
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
