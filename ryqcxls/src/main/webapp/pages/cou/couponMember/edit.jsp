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
<title>添加定向优惠券</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/couponMember/queryList'">优惠券管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(couponMember) }">添加优惠券</c:if>
	<c:if test="${!empty(couponMember) }">编辑优惠券</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="couponMember.dbid" id="dbid" value="${couponMember.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">选择优惠券类型:&nbsp;</td>
				<td>
					<select id="couponMemberTemplateId" name="couponMemberTemplateId" class="largeX text" onchange="ajaxCouponMemberTemplate(this.value)" checkType="integer,1" tip="优惠券类型不能为空">
						<option>请选择优惠券...</option>
						<c:forEach var="couponMemberTemplate" items="${couponMemberTemplates }">
							<option value="${couponMemberTemplate.dbid }" ${couponMember.couponMemberTemplate.dbid==couponMemberTemplate.dbid?'selected="selected"':'' } >${couponMemberTemplate.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td><input type="text" name="couponMember.name" id="name"
					value="${couponMember.name }" class="largeX text" title="名称" placeholder="请输入优惠券名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr>
			<td class="formTableTdLeft">
				<c:if test="${empty(couponMember) }" var="status">
						<label class="control-label" id="rabatt">折扣率：</label>
						<label class="control-label" id="dymoney" style="display: none;">抵用金额：</label>
					</c:if>
					<c:if test="${!empty(couponMember) }" >
						<c:if test="${couponMember.type==1 }">
							<label class="control-label" id="rabatt">折扣率：</label>
							<label 	class="control-label" id="dymoney" style="display: none;" >抵用金额：</label>
						</c:if>
						<c:if test="${couponMember.type==2 }"  >
							<label class="control-label" id="rabatt" style="display: none;" >折扣率：</label>
							<label 	class="control-label" id="dymoney" >抵用金额：</label>
						</c:if>
					</c:if>
				</td>
				<td>
					<input type="text"  class="largeX text" name="couponMember.moneyOrRabatt" id="moneyOrRabatt1"  value="${couponMember.moneyOrRabatt }" checkType="float" canEmpty="Y"  tip="必须输入数字或为空!"  />
					
				</td>
				<c:if test="${empty(couponMember) }">
					<td class="formTableTdLeft">接受会员：&nbsp;</td>
					<td >
						<input type="hidden" class="largeX text" name="memberIds" id="memberIds" readonly="readonly"  />
						<input type="text" class="largeX text" name="memberNames" id="memberNames" readonly="readonly"  />
						<a href="javascript:void(-1)" class="aedit" onclick="memberSelect('memberIds','memberNames')">选择人员</a>
					</td>
				</c:if>
				<c:if test="${!empty(couponMember) }">
					<td class="formTableTdLeft">接受会员：&nbsp;</td>
					<td >
						<input type="text" class="largeX text" value="${couponMember.member.name }" readonly="readonly"  />
					</td>
				</c:if>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">劵类型：&nbsp;</td>
				<td >
					<select id="bussiType" name="couponMember.bussiType" class="largeX text" checkType="integer,1,2000" tip="发券类型不能为空"> 
						<option value="-1">请选择...</option>
						<option value="1" ${couponMember.bussiType==1?'selected="selected"':'' } >销售发放</option>
						<option value="2" ${couponMember.bussiType==2?'selected="selected"':'' }>售后发放</option>
						<option value="3" ${couponMember.bussiType==3?'selected="selected"':'' }>保险发放</option>
					</select>
				</td>
				<td class="formTableTdLeft">发放部门：&nbsp;</td>
				<td >
					<select id="departmentId" name="departmentId"  class="largeX text"  checkType="integer,1,2000">
						<option value="">请选择...</option>
						${departmentSelect }
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">生效时间：&nbsp;</td>
				<td ><input type="text" class="largeX text" name="couponMember.startTime" id="startTime" readonly="readonly"  onFocus="WdatePicker({minDate:'%y-%M-%d'})"  value="${couponMember.startTime }" /></td>
				<td class="formTableTdLeft">失效时间：&nbsp;</td>
				<td ><input type="text" class="largeX text" name="couponMember.stopTime" id="stopTime" readonly="readonly"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}'})"  value="${couponMember.stopTime }" /></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">发券理由：&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="8" cols="120" name="couponMember.reason" checkType="string,1,2000" tip="发券理由必填，2000个字符内">${couponMember.reason }</textarea><span style="color: red;">*</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/couponMember/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
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
function ajaxCouponMemberTemplate(val){
	$.post('${ctx}/couponMemberTemplate/queryByDbid?dbid='+val+"&temp="+new Date(),{},function(data){
		if(data!=="1"){
			dymoney(data.type);
			$("#name").val(data.name);
		}
	})	
}
</script>
</html>