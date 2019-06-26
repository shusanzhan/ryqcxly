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
<title>添加分享内容</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/share/queryList'">分享内容管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(share) }">添加添加分享内容</c:if>
	<c:if test="${!empty(share) }">编辑添加分享内容</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="share.dbid" id="dbid" value="${share.dbid }">
		<input type="hidden" name="share.type" id="type" value="1">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="share.title" id="title"	value="${share.title }" class="largeX text" title="名称" placeholder="请输入分享标题"	checkType="string,1,50" tip="标题不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">赠送积分量:&nbsp;</td>
				<td ><input type="text" name="share.point" id="point"	value="${share.point }" class="largeX text" title="赠送积分量" placeholder="请输赠送积分量"	checkType="integer,0,50000" tip="赠送积分量不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">中锐电话:&nbsp;</td>
				<td >
					<input type="text" name="share.phone1" id="phone1"	value="${share.phone1 }" class="midea text" title="中锐电话" placeholder="请输中锐电话">
					<input type="checkbox" id="show1" name="share.show1" value="1" ${share.show1==1?'checked="checked"':'' } >是否显示
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">精锐电话:&nbsp;</td>
				<td >
					<input type="text" name="share.phone2" id="phone2"	value="${share.phone2 }" class="midea text" title="精锐电话" placeholder="请输精锐电话">
					<input type="checkbox" id="show2" name="share.show2" value="1" ${share.show2==1?'checked="checked"':'' } >是否显示
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">红牌楼电话:&nbsp;</td>
				<td >
					<input type="text" name="share.phone3" id="phone3"	value="${share.phone3 }" class="midea text" title="红牌楼电话" placeholder="请输红牌楼电话">
					<input type="checkbox" id="show3" name="share.show3" value="1" ${share.show3==1?'checked="checked"':'' } >是否显示
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">简介:&nbsp;</td>
				<td >
					<textarea class="textarea text largeX" rows="" cols="" id="intro" name="share.intro">${share.intro }</textarea>
				</td>
			</tr>
			<%-- <tr height="42">
				<td class="formTableTdLeft">标题图片:&nbsp;</td>
				<td >
					<input type="hidden" name="share.titleImage" id="fileUpload" readonly="readonly"	value="${share.titleImage }" />
					<div style="float: left;">
						<img alt="" id="fileUploadImage" src="${share.titleImage }" width="60" height="60" style="float: left;">
					</div>
					<div id="div1" style="float: left;">
						<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
						<div id="uploadFileContent" class="uploadFileContent" style="width: 220px"></div>
					</div>
					请上传标题图片,图片规格为:700*320;
					<div style="clear: both;"></div>
				</td>
			</tr> --%>
			<tr height="42">
				<td class="formTableTdLeft">分享展示图片:&nbsp;</td>
				<td >
					<input type="hidden" name="share.shareImage" id="fileUpload" readonly="readonly"	value="${share.shareImage }" />
					<div style="float: left;">
						<img alt="" id="fileUploadImage" src="${share.shareImage }" width="60" height="60" style="float: left;">
					</div>
					<div id="div1" style="float: left;">
						<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
						<div id="uploadFileContent" class="uploadFileContent" style="width: 220px"></div>
					</div>
					请上传分享展示图片,图片规格为:60*60;
					<div style="clear: both;"></div>
				</td>
			</tr>
			<tr height="42">
				<td colspan="4">
					<textarea  class="input-xlarge" name="share.content" id="content" >${share.content }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/share/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
</script>
</html>