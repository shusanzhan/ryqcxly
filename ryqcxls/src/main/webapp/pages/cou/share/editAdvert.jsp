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
<title>添加推广活动</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/share/queryList'">分享内容管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(share) }">添加推广广告</c:if>
	<c:if test="${!empty(share) }">编辑推广广告</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="share.dbid" id="dbid" value="${share.dbid }">
		<input type="hidden" name="share.type" id="type" value="2">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="share.title" id="title"	value="${share.title }" class="largeX text" title="名称" placeholder="请输入分享标题"	checkType="string,1,50" tip="标题不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">简介:&nbsp;</td>
				<td >
					<textarea class="textarea text largeX" rows="" cols="" id="intro" name="share.intro">${share.intro }</textarea>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">赠送积分量:&nbsp;</td>
				<td ><input type="text" name="share.point" id="point"	value="${share.point }" class="largeX text" title="赠送积分量" placeholder="请输赠送积分量"	checkType="integer,0,50000" tip="赠送积分量不能为空"><span style="color: red;">*</span></td>
			</tr>
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
				<td class="formTableTdLeft">上传MP3:&nbsp;</td>
				<td >
					<div style="float: left;">
						<input type="text" name="share.music" id="fileUpload2" readonly="readonly" class="largeX text"	value="${ share.music }" />
						<%-- <img alt="" id="fileUploadImage2" src="${share.music }" width="60" height="60" style="float: left;"> --%>
					</div>
					<div id="div1" style="float: left;">
						<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder2"></span> <br />
						</div>
						<div id="uploadFileContent2" class="uploadFileContent" style="width: 220px"></div>
					</div>
					<div style="clear: both;"></div>
				</td>
			</tr>
		</table>
		 <div class="listOperate">
			<div class="operate">
				<a	class="but butSave" href="javascript:void(-1)" onclick="crateTr()">添加</a>
		   </div>
		   <div style="color: red;">
		   		图片大小：640*960:1,大小不超过100K
		   </div>
		</div>
			<!-- 商品图片tab        开始 -->
				<table width="100%" cellpadding="0" cellspacing="0"	class="mainTable" border="0">
					<thead class="TableHeader">
						<tr>
							<th style="width: 200px;">文件</th>
							<th style="width: 200px;">标题</th>
							<th style="width: 200px;">描述</th>
							<th style="width: 50px;">排序</th>
							<th style="width: 120px;" align="center">操作</th>
						</tr>
					</thead>
					<tbody id="attributeBodyTable">
						<c:if test="${!empty(sharePictureUrls)&&fn:length(sharePictureUrls)>0 }" var="status">
							<c:forEach var="sharePicureUrl" items="${ sharePictureUrls}"		varStatus="i">
								<tr id="tr1">
									<td align="left" style="text-align: left;">
											<input type="hidden" name="sharePictureUrlDbid"	id="sharePictureUrlDbid${i.index}" value="${sharePicureUrl.dbid }">
											<input	class="input-medium" type="hidden" name="url"	id="url${i.index}" value="${sharePicureUrl.url }" /> 
											<img alt="" title=""id="imgSource${i.index}" src="${sharePicureUrl.url }" height="100" width="100"></img>
											<a	href="#modal-add-event" class="aedit "	onclick="uploadFile('url${i.index}','imgSource${i.index }')">上传图片</a> 
									</td>
									<td>
										<input class="mideaX text" type="text" id="title${i.index}"	name="title" value="${sharePicureUrl.title }" />
									</td>
									<td>
										<input class="mideaX text" type="text" id="discription${i.index}"	name="discription" value="${sharePicureUrl.discription }" />
									</td>
									<td style="text-align: center;">
												<input class="midea text" id="orderNum${i.index}" type="text"	name="orderNum" value="${sharePicureUrl.orderNum }" />
									</td>
									<td align="center" style="text-align: center;">
										<a class="aedit" 	href="javascript:void(-1)" onclick="deleteTrAndValue(this,${sharePicureUrl.dbid})"> 删除</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${status==false }">
							<tr id="tr1">
								<td align="left" style="text-align: left;">
									<input type="hidden" name="sharePicureUrlDbid"		id="sharePicureUrlDbid0" value=""> 
									<input	class="input-medium" type="hidden" name="url"	id="url0" value="" /> 
									<img alt="" title=""id="imgSource0" src="" height="100" width="100"></img>
									<a	href="#modal-add-event" class="aedit "	onclick="uploadFile('source0','imgSource0')">上传图片</a> 
								</td>
								<td>
									<input class="mideaX text" type="text" id="title0"		name="title" value="" />
								</td>
								<td>
									<input class="mideaX text" type="text" id="discription0"		name="discription" value="" />
								</td>
								<td style="text-align: center;">
											<input class="midea text" id="orderNum0" type="text" name="orderNum" value="" />
								</td>
								<td align="center" style="text-align: center;">
									<a class="aedit" href="javascript:void(-1)"		onclick="deleteTr(this)"> 删除</a>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div> 
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/share/saveAdvert')"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
var upload1,upload2;
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
	upload2 = new SWFUpload(
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
				file_types : "*.mp3",
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
				button_placeholder_id : "spanButtonPlaceholder2",
				button_width : 61,
				button_height : 22,

				// Flash Settings
				flash_url : "${ctx}/widgets/SWFUpload/Flash/swfupload.swf",

				custom_settings : {
					progressTarget : "uploadFileContent2",
					cancelButtonId : "btnCancel",
					titlePicture : "fileUpload2",
					fileUploadImage : "fileUploadImage2"
				},
				// Debug Settings
				debug : false
			});

}
function deleteTr(tr) {
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
	}
}
function deleteTrAndValue(tr,dbid){
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		window.top.art.dialog({
			content : '您确定删除选择数据吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.post('${ctx}/share/deleteShareUrl?dbid='+dbid,{},function(data){
					if (data[0].mark == 1) {// 删除数据失败时提示信息
						$.utile.tips(data[0].message);
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
						var dd = $(tr).parent().parent();
						$(dd).remove();
					}
				})
			},
			cancel : true
		})
	}
}
function crateTr() {
	var size = $("#attributeBodyTable").find("tr").size();
	size = size + 1;
	var str = ' <tr style="height:110px;">'
			+ '<td style="text-align: left;">'
			+ '<input type="hidden" name="sharePicureUrlDbid" id="sharePicureUrlDbid'+size+'" value="">'
			+ '<input class="input-medium" type="hidden" name="url" id="url'+size+'" value="" />'
			+ '<img alt="" title="" id="imgSource'+size+'" src="" width="100" height="100"></img>'
			+ '<a  href="#modal-add-event" class="aedit" onclick="uploadFile(\'url'
			+ size
			+ '\',\'imgSource'
			+ size
			+ '\')">上传图片</a>'
			+ '</td>'
			+'<td>'
			+ '<input class="mideaX text" id="title" type="text" name="title"  />'
			+'</td>'
			+ '<td >'
			+ '<input class="mideaX text" id="discription" type="text" name="discription"  />'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input class="midea text" id="orderNum" type="text" name="orderNum"  />'
			+ '</td>'
			+ '<td align="center" style="text-align: center;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-white"></i> 删除</a>'
			+ '</td>' + '</tr>';
	$("#attributeBodyTable").append(str);
}
</script>
</html>