<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/swfupload.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.queue.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/plugins/swfupload.speed.js"></script>
<script type="text/javascript"	src="${ctx }/widgets/SWFUpload/js/fileupload.handlers.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<style type="text/css">
	.depDiv {
	    width: 320px;
	    overflow: hidden;
	}
</style>
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
				file_types : "*.jpg",
				file_types_description : "All Files",
				file_upload_limit : "1",
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
<title>用户添加</title>
</head>
<body class="bodycolor" style="">
	<div class="location">
       	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
       	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/userBussi/queryBussiList'">用户管理中心</a>
	</div>
	<div class="line"></div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="type" id="type" value="1">
		<s:token></s:token>
		<input type="hidden" name="user.dbid" id="dbid" value="">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" >用户ID:&nbsp;</td>
				<td ><input type="text" name="user.userId" id="userId"
					value="" url="${ctx }/user/validateUser" class="large text" title="用户ID"	checkType="string,3,20" tip="用户名不能为空,并且5-20个字符"><span style="color: red;">*</span></td>
				<td rowspan="5" colspan="2">
				<table  border="0" cellpadding="0" cellspacing="0" style="width: 500px;" height="200">
					<tr>
						<td height="200" width="360">
							<input type="hidden" name="staff.photo" id="fileUpload" readonly="readonly"	value="">
							<img alt="" id="fileUploadImage" src="" width="300" height="180">
						</td>
						<td height="40" width="140">
						<div id="div1">
							<div style="padding-left: 5px;">
							<span id="spanButtonPlaceholder1"></span> <br />
						</div>
						<div id="uploadFileContent" class="uploadFileContent" style="width: 200px"></div>
						</div>
					</td>
					</tr>
				</table>
				 </td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >姓名:&nbsp;</td>
				<td ><input type="text" name="user.realName" id="realName"
					value="" class="mideaX text" title="姓名"	checkType="string,1,10" tip="真实名称不能为空"><span style="color: red;">*</span>
					<input type="radio" id="sex1"  checked="checked" name="staff.sex" value="男"><label id="" for="sex1">男</label>
					<input type="radio" id="sex2"  name="staff.sex" value="女"><label id="" for="sex2">女</label>	
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >用户类型:&nbsp;</td>
				<td >	
					<select class="select text large" id="bussiType" name="user.bussiType"  checkType="integer,1" tip="用户类型">
						<option value="-1">请选择</option>
						<option value="1" ${user.bussiType==1?'selected="selected"':'' }>展厅</option>
						<option value="2" ${user.bussiType==2?'selected="selected"':'' }>网销</option>
						<option value="3" ${user.bussiType==3?'selected="selected"':'' }>区域</option>
						<option value="4" ${user.bussiType==4?'selected="selected"':'' }>后勤</option>
						<option value="5" ${user.bussiType==5?'selected="selected"':'' }>其他</option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft" >生日:&nbsp;</td>
				<td ><input type="text" name="staff.birthday" id="birthday"
					value="" readonly="readonly" class="large text" onFocus="WdatePicker({isShowClear:true,readOnly:true})"></td>

			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >微信号:&nbsp;</td>
				<td ><input type="text" name="user.wechatId" id="wechatId"	value="" class="large text" checkType="string,1"  tip="请输入微信号"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" >所在部门:&nbsp;</td>
				<td colspan="">
					<div class="depDiv">
						<div id="selectedDeptFill" class="fillBox" ids=" 5179943"> 
						</div>
						<a ck="addDeptDlg" style="line-height:28px;font-size:12px;text-decoration:underline;cursor: pointer;" onclick="getSelectedDepartment('selectedDeptFill');">添加</a>
				 	</div>
				</td>
				<td class="formTableTdLeft" >岗位:&nbsp;</td>
				<td colspan="">
					<div class="depDiv">
						<div id="selectedPositionFill" class="fillBox" ids=" 5179943"> 
						</div>
						<a ck="addDeptDlg" style="line-height:28px;font-size:12px;text-decoration:underline;cursor: pointer;" onclick="getSelectedPosition('selectedPositionFill');">添加</a>
				 	</div>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >所属公司:&nbsp;</td>
				<td>
					<select id="enterpriseId" name="enterpriseId" class="large text" checkType="integer,1" tip="请选择所属公司">
						<option>请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }">${enterprise.name }</option>
						</c:forEach>
					</select>
				</td>
				<td class="formTableTdLeft" >直属领导:&nbsp;</td>
				<td>
					<input type="hidden" name="parentId" id="parentId"	>
					<input type="text" name="parentName" id="parentName" value="" class="large text" title="直属领导" onfocus="autoUser('parentName')" checkType="string,1,10" tip="真实名称不能为空"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >手机:&nbsp;</td>
				<td><input type="text" name="user.mobilePhone" id="mobilePhone"
					value="" class="large text"  checkType="mobilePhone" canEmpty="Y" tip="请输入正确的手机号"></td>
				<td class="formTableTdLeft" >座机:&nbsp;</td>
				<td><input type="text" name="user.phone" id="phone"
					value="" class="large text"  checkType="phone"  canEmpty="Y" tip="请输入正确的座机号"></td>
			</tr>
			<tr height="42">
			    <td class="formTableTdLeft" >邮箱:&nbsp;</td>
				<td ><input type="text" name="user.email" id="email"
					value="" class="large text" title="邮箱"	checkType="email" canEmpty="Y" tip="请输入正确的邮箱"></td>
				<td class="formTableTdLeft" >QQ:&nbsp;</td>
				<td ><input type="text" name="user.qq" id="qq"
					value="" class="large text" title="QQ号"	checkType="string,3,20" canEmpty="Y" tip="请输入正确的QQ号"></td>
			</tr>
			<tr height="42">
			    <td class="formTableTdLeft" style="width: 120px;">现居住地地址:&nbsp;</td>
				<td ><input type="text" name="staff.nowAddress" id="nowAddress"
					value="${staff.nowAddress }" class="largeXX text" title="现居住地地址"	checkType="string,1,100" canEmpty="Y" tip="请输入正确的现居住地地址"></td>
			    <td class="formTableTdLeft" style="width: 120px;">户籍地址:&nbsp;</td>
				<td ><input type="text" name="staff.familyAddress" id="familyAddress"
					value="${staff.familyAddress }" class="largeXX text" title="户籍地址"	checkType="string,1,100" canEmpty="Y" tip="请输入正确的户籍地址"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft" style="width: 120px;">学历:&nbsp;</td>
					<td >
						<select class="select text" id="educationalBackground" name="staff.educationalBackground" style="width: 120px;">
							<option value="小学"  ${staff.educationalBackground=='小学'?'selected="selected"':'' } >小学</option>
							<option value="初中生" ${staff.educationalBackground=='初中生'?'selected="selected"':'' }>初中生</option>
							<option value="高中生" ${staff.educationalBackground=='高中生'?'selected="selected"':'' }>高中生</option>
							<option value="中专生" ${staff.educationalBackground=='中专生'?'selected="selected"':'' }>中专生</option>
							<option value="大专生" ${staff.educationalBackground=='大专生'?'selected="selected"':'' }>大专生</option>
							<option value="本科生" ${staff.educationalBackground=='本科生'?'selected="selected"':'' }>本科生</option>
							<option value="硕士生" ${staff.educationalBackground=='硕士生'?'selected="selected"':'' }>硕士生</option>
							<option value="博士生" ${staff.educationalBackground=='博士生'?'selected="selected"':'' }>博士生</option>
							<option value="其它" ${staff.educationalBackground=='其它'?'selected="selected"':'' }>其它</option>
						</select>
					</td>
				<td class="formTableTdLeft" style="width: 120px;">毕业学校:&nbsp;</td>
				<td ><input type="text" name="staff.graduationSchool" id="graduationSchool"
					value="${staff.graduationSchool }" class="largeXX text" title="毕业学校"></td>
			</tr>
		</table>
		</form>
		<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/userBussi/saveComm')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void()"	onclick="$('#type').val(2);$.utile.submitForm('frmId','${ctx}/userBussi/saveComm')"	class="but butSave">保存并分配权限</a> 
		    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
	</div>
</body>
<script type="text/javascript">
function autoUser(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/user/ajaxUser",{
			max: 20,      
	        width: 130,    
	        matchSubset:false,   
	        matchContains: true,  
			dataType: "json",
			parse: function(data) {   
		    	var rows = [];      
		        for(var i=0; i<data.length; i++){      
		           rows[rows.length] = {       
		               data:data[i]       
		           };       
		        }       
		   		return rows;   
		    }, 
			formatItem: function(row, i, total) {   
		       return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect2);
	//计算总金额
}

function onRecordSelect2(event, data, formatted) {
		$("#parentName").val(data.name);
		$("#parentId").val(data.dbid);
}
</script>
</html>