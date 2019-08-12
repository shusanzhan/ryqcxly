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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<style type="text/css">
	body{ font: 62.5% "Trebuchet MS", sans-serif;margin: 0 auto; }
	.demoHeaders { margin-top: 2em; }
	#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
	#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
	ul#icons {margin: 0; padding: 0;}
	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
	ul#icons span.ui-icon {float: left; margin: 0 4px;}
	.frmContent select{
		height: 300px;
	}
</style>
<script type="text/javascript">
function addValue(){
	var userSelected = $("#user option:selected");
	if(userSelected!=null&&userSelected.length>0){
		for(var i=0;i<userSelected.length;i++){
			var removeSelected =userSelected[i];
			//重新生成一个option用于append到左边栏的选项中
			var option="<option value='"+removeSelected.value+"'>"+removeSelected.text+"</option>";
			$("#user option[value='"+removeSelected.value+"']").remove();
			$("#resultSelected").append(option);
		}
	}
}
function remove(){
	//获取全部选中Select的option
	var options = $('#resultSelected option:selected');
	if(options.length>0){
		for(var i=0;i<options.length;i++){
			//遍历整个选择的option
			var removeSelected =options[i];
			//重新生成一个option用于append到左边栏的选项中
			var option="<option value='"+removeSelected.value+"'>"+removeSelected.text+"</option>";
			//删除选择中的option
			$("#resultSelected option[value='"+removeSelected.value+"']").remove();
			$("#user").append(option);
		}
	}else{
		return ;
	}
}
//双击添加选择了人员|部门信息到右边列表
function addClick(selectId){
	var options=$("#"+selectId+" option:selected");
	if(options.length>0){
		for(var i=0;i<options.length;i++){
			//遍历整个选择的option
			var removeSelected =options[i];
			//重新生成一个option用于append到左边栏的选项中
			var option="<option value='"+removeSelected.value+"'>"+removeSelected.text+"</option>";
			//删除选择中的option
			$("#"+selectId+" option[value='"+removeSelected.value+"']").remove();
			$("#resultSelected").append(option);
		}
	}
}
//双击已经选择用户进行用户删除操作
function removeClick(){
	//获取全部选中Select的option
	var options = $('#resultSelected option:selected');
	if(options.length>0){
		for(var i=0;i<options.length;i++){
			//遍历整个选择的option
			var removeSelected =options[i];
			//重新生成一个option用于append到左边栏的选项中
			var option="<option value='"+removeSelected.value+"'>"+removeSelected.text+"</option>";
			//删除选择中的option
			$("#resultSelected option[value='"+removeSelected.value+"']").remove();
			$("#user").append(option);
		}
	}else{
		return ;
	}
}
function ok(){
	var options=$("#resultSelected")[0];
	var resultIds="";
	var resultNames="";
	if(options.length>0){
		for(var i=0;i<options.length;i++){
			var removeSelected =options[i];
			resultIds+=removeSelected.value+",";
			resultNames+=removeSelected.text+",";
		}
	}else{
		alert("请选择会员标签后在保存");
		return false;
	}
	$("#resultIds").val(resultIds);
	$("#resultNames").val(resultNames);
	return true;
}
</script>
<title>大区管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">${member.name }会员设置标签</a>
</div>
<div class="line"></div>
<div class="frmContent" style="margin-bottom: 50px;">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_self">
		<input type="hidden" id="dbid" name="dbid" value="${member.dbid }">
		<input type="hidden" id="type" name="type" value="${param.type }">
		<input type="hidden" id="resultIds" name="resultIds" value="">
		<input type="hidden" id="resultNames" name="resultNames" >
		<table width="1024" style="border: 1px solid #68ADF5;margin-top: 5px;height: 380px;" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td width="200" align="center">
						<h3 id="link_01"  style=""><a href="#" id="aus" >备选标签</a></h3>
						<div id="medul_01" style="height: 300px;">
							<select id='user' name='user' style='width:100%;' ondblclick="addClick('user')" multiple='multiple' size="20">
								<c:forEach var="memTag" items="${memTags }">
									<option value="${memTag.dbid }">${memTag.name }</option>
								</c:forEach>
							</select>
						
						</div>
			</td>
			<td width="30" align="center">
				<div style="margin: 0 auto;width: 52px;">
					<table align="center">
						<tr>
							<td>
								<input type="button" id="add" onclick="addValue()" value=">">
							</td>
						</tr>
						<tr>
							<td><input type="button" id="remove" onclick="remove()" value="&lt;">
							</td>
						</tr>
					</table>
				</div></td>
			<td width="200" align="center">
				<h3 id="link_01" onclick="selectUserAll();" style=""><a href="#" id="aus" onclick="getAvalue(this);">已选标签</a></h3>
				<div style="margin: 0 auto;">
					<select id="resultSelected" name="resultSelected" multiple="multiple" ondblclick="removeClick()" size="20" style="width: 100%;">
						<c:forEach var="areaId" items="${areaIdArray }" varStatus="i">
							<option value="${areaId }">${areaNameArray[i.index] }</option>
						</c:forEach>
					</select>
				</div></td>
		</tr>
	</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="if(ok()){$.utile.submitForm('frmId','${ctx}/memMember/saveAddTag')}"	class="but butSave">保存</a> 
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)"	class="but butCancle">返回</a> 
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>