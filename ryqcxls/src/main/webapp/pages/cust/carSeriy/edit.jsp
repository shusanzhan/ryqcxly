<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车系添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/carSeriy/queryList'">品牌管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${carSeriy.dbid>0 }" var="status">编辑品牌</c:if>
		<c:if test="${status==false }">添加品牌</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${carSeriy.dbid }" id="dbid" name="carSeriy.dbid">
		<input type="hidden" value="${carSeriy.status }" id="status" name="carSeriy.status">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">品牌：</td>
					<td>
						<select id="type" class="large text" name="brandId">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${brand.dbid==carSeriy.brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">名称：</td>
					<td>
						<input type="text" class="largeX text" name="carSeriy.name"	id="name" value="${carSeriy.name }" checkType="string,1,20"  tip="请输入车系名称！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">简称：</td>
					<td>
						<input type="text" class="largeX text" name="carSeriy.introduction"	id="introduction" value="${carSeriy.introduction }" checkType="string,1,20"  tip="请输入车系简称！"  />
					</td>
					<td class="formTableTdLeft">官方指导价：</td>
					<td>
						<input type="text" class="largeX text" name="carSeriy.navPrice"	id="navPrice" value="${carSeriy.navPrice }" checkType="integer,1,100000000"  tip="请输入指导价格！"  />
					</td>
					
				</tr>
				<tr>
					<td class="formTableTdLeft">经销商报价：</td>
					<td>
						<input type="text" class="largeX text" name="carSeriy.salePrice"	id="salePrice" value="${carSeriy.salePrice }" checkType="integer,1,100000000"  tip="请输入经销商报价！"  />
					</td>
					<td class="formTableTdLeft">推荐价</td>
					<td colspan="">
						<input type="text" class="largeX text" name="carSeriy.saleCSPrice"	id="saleCSPrice" value="${carSeriy.saleCSPrice }" checkType="integer,1,100000000"  tip="请输入推荐价！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">价格区间：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.priceFrom"	id="priceFrom" value="${carSeriy.priceFrom }" checkType="string,1,500" canEmpty="Y"/>
					</td>
					<td class="formTableTdLeft">车辆级别：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.carLevel"	id="carLevel" value="${carSeriy.carLevel }"  checkType="string,1,500" canEmpty="Y"/>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">车辆颜色：</td>
					<td colspan=1>
						<input type="text" class="largeX text" name="carSeriy.carColors"	id="carColors" value="${carSeriy.carColors }" checkType="string,1,500" canEmpty="Y"/>
					</td>
					<td class="formTableTdLeft">动力类型：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.carDriverType"	id="carDriverType" value="${carSeriy.carDriverType }"  checkType="string,1,500" canEmpty="Y"/>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">变速箱类型：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.bianxueType"	id="bianxueType" value="${carSeriy.bianxueType }" checkType="string,1,500" canEmpty="Y" />
					</td>
					<td class="formTableTdLeft">排量大小：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.pailiang"	id="pailiang" value="${carSeriy.pailiang }" checkType="string,1,500" canEmpty="Y"/>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">是否进口：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.hasJk"	id="hasJk" value="${carSeriy.hasJk }" checkType="string,1,500" canEmpty="Y" />
					</td>
					<td class="formTableTdLeft">提车时间：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.handCarTime"	id="handCarTime" value="${carSeriy.handCarTime }" checkType="string,1,500" canEmpty="Y" />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">质保类型：</td>
					<td >
						<input type="text" class="largeX text" name="carSeriy.zbType"	id="zbType" value="${carSeriy.zbType }"  checkType="string,1,500" canEmpty="Y"/>
					</td>
					<td class="formTableTdLeft">排序：</td>
					<td>
						<input type="text" class="largeX text" name="carSeriy.orderNum" id="orderNum"  value="${carSeriy.orderNum }" checkType="integer,1" canEmpty="Y" tip="请输入排序号！"/>
					</td>
				</tr>
				<c:if test="${!empty(carSeriy.picture)||fn:length(carSeriy.picture )>0  }" var="status">
				<tr id="logoDiv">
						<td class="formTableTdLeft">图片：</td>
						<td>
							<input type="hidden" name="carSeriy.picture" id="fileUpload" readonly="readonly"	value="${carSeriy.picture }">
							<img alt="" id="fileUploadImage" src="${carSeriy.picture }" width="50" height="30">
							<div id="div1">
								<div style="padding-left: 5px;">
								<span id="spanButtonPlaceholder1"></span> <br />
							</div>
								<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
								图片：规格为560*400
							</div>
						</td>
				</tr>
				</c:if>
				<c:if test="${status==false }">
				<tr id="logoDiv" > 
					<td class="formTableTdLeft">图片：</td>
					<td>
						<input type="hidden" name="carSeriy.picture" id="fileUpload" readonly="readonly"	value="${carSeriy.picture }">
						<img alt="" id="fileUploadImage" src="${carSeriy.picture }" width="50" height="30">
						<div id="div1">
							<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
							<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
							图片：规格为560*400
						</div>
					</td>
					</tr>
				</c:if>
				<tr>
					<td colspan="4">
						<textarea name="carSeriy.description" id="content" title="内容简介"  >${carSeriy.description }</textarea>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/carSeriy/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
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
