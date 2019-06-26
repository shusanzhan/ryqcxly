<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车型 添加</title>
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
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/carModel/queryList'">品牌管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${carModel.dbid>0 }" var="status">编辑车型</c:if>
		<c:if test="${status==false }">添加车型</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${carModel.dbid }" id="dbid" name="carModel.dbid">
		<input type="hidden" value="${carModel.status }" id="status" name="carModel.status">
		<input type="hidden" value="${carModel.saleCSPrice }" id="historyCSPrice" name="carModel.historyCSPrice">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr>
					<td class="formTableTdLeft">品牌：</td>
					<td>
						<select id="type" class="large text" name="brandId" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${brand.dbid==carModel.brand.dbid?'selected="selected"':'' }>${brand.name }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">车系：</td>
					<td id="carModelLabel">
						<select id="carSeriyId" class="large text" name="carSeriyId" >
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${carSeriy.dbid==carModel.carseries.dbid?'selected="selected"':'' }>${carSeriy.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">名称：</td>
					<td>
						<input type="text" class="largeX text" name="carModel.name"	id="name" value="${carModel.name }" checkType="string,1,100"  tip="请输入车系名称！"  />
					</td>
					<td class="formTableTdLeft">年款：</td>
					<td>
						<select id="type" class="large text" name="carModel.yearModel" >
							<option value="">请选择...</option>
							<c:forEach var="year" items="${years }">
								<option value="${year }" ${year==carModel.yearModel?'selected="selected"':'' }>${year }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">官方指导价：</td>
					<td>
						<input type="text" class="largeX text" name="carModel.navPrice"	id="navPrice" value="${carModel.navPrice }" checkType="integer,1,100000000"  tip="请输入指导价格！"  />
					</td>
					<td class="formTableTdLeft">经销商报价：</td>
					<td>
						<input type="text" class="largeX text" name="carModel.salePrice"	id="salePrice" value="${carModel.salePrice }" checkType="integer,1,100000000"  tip="请输入经销商报价！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">销售结算价：</td>
					<td colspan="">
						<input type="text" class="largeX text" name="carModel.saleCSPrice"	id="saleCSPrice" value="${carModel.saleCSPrice }" checkType="integer,1,100000000"  tip="请输入销售顾问结算价！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">排量个数：</td>
					<td>
						<input class="largeX text" type="text" name="carModel.displacementNum" id="displacementNum"  value="${carModel.displacementNum}" checkType="integer,1" canEmpty="Y" tip="请输入排量个数！"/>
					</td>
					<td class="formTableTdLeft">档位个数：</td>
					<td>
						<input class="largeX text" type="text" name="carModel.gearNum" id="gearNum"  value="${carModel.gearNum}"  checkType="integer,1" canEmpty="Y" tip="请输入档位个数！"/>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">变速箱：</td>
					<td>
						<select name="carModel.transmission" id="transmission" class="largeX text">
					        <option value="1" ${carModel.transmission=='1'?'selected="selected"':'' } >自动变速箱(AT)</option>
					        <option value="2" ${carModel.transmission=='2'?'selected="selected"':'' } >手动变速箱(MT)</option>
					        <option value="3" ${carModel.transmission=='3'?'selected="selected"':'' } >手自一体 </option>
					        <option value="4" ${carModel.transmission=='4'?'selected="selected"':'' } >无级变速箱(CVT)</option>
					        <option value="5" ${carModel.transmission=='5'?'selected="selected"':'' } >无级变速(VDT)</option>
					        <option value="6" ${carModel.transmission=='6'?'selected="selected"':'' } >双离合变速箱(DCT)</option>
					        <option value="7" ${carModel.transmission=='7'?'selected="selected"':'' } >序列变速箱(AMT)</option>
					      </select>
					</td>
					<td class="formTableTdLeft">排序：</td>
					<td>
						<input type="text" class="largeX text" name="carModel.orderNum" id="orderNum"  value="${carModel.orderNum }" checkType="integer,1" canEmpty="Y" tip="请输入排序号！"/>
					</td>
				</tr>
				<c:if test="${!empty(carModel.picture)||fn:length(carModel.picture )>0  }" var="status">
				<tr id="logoDiv">
						<td class="formTableTdLeft">图片：</td>
						<td>
							<input type="hidden" name="carModel.picture" id="fileUpload" readonly="readonly"	value="${carModel.picture }">
							<img alt="" id="fileUploadImage" src="${carModel.picture }" width="50" height="30">
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
						<input type="hidden" name="carModel.picture" id="fileUpload" readonly="readonly"	value="${carModel.picture }">
						<img alt="" id="fileUploadImage" src="${carModel.picture }" width="50" height="30">
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
						<textarea name="carModel.content" id="content" title="内容简介"  >${carModel.content }</textarea>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/carModel/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
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
	function show(){
		var options=$("#type option:selected");
		var value=options[0].value;
		if(value=="图片"){
			$("#logoDiv").show();
		}else{
			$("#logoDiv").hide();
		}
	}
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
	function ajaxCarSeriy(val){
		if(null==val||val==''){
			alert("请选择品牌");
			return false;
		}
		$("#carSeriyId").remove();
		$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
	}
</script>
</html>
