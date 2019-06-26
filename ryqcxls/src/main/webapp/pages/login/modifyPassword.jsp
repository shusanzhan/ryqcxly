<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
	.sbutton{
		background-color: #FF5722;height: 38px;line-height: 38px;padding: 0 18px;display: inline-block;color: #FFF;border-radius: 2px;font-size:14px;
   		 cursor: pointer;;
	}
	a{}
</style>
<title>修改初始密码</title>
<script type="text/javascript">
var isExtendsValidate = true;	//如果要试用扩展表单验证的话，该属性一定要申明
function extendsValidate(){	//函数名称，固定写法
	var password=$('#password').val();
	if(!isNaN(password)){
		$('#password').validate_callback("密码不能为纯数字","failed");
		return false;
	}
	//密码匹配验证
	if( $('#password').val() == $('#repassword').val() ){	//匹配成功
		$('#repassword').validate_callback(null,"sucess");	//此次是官方提供的，用来消除以前错误的提示
		return true;
	}else{//匹配失败
		$('#repassword').validate_callback("密码不匹配","failed");	//此处是官方提供的API，效果则是当匹配不成功，pwd2表单 显示红色标注，并且TIP显示为“密码不匹配”
		return false;
	}
}
</script>
</head>
<body class="bodycolor">
<div class="location" style="text-align: center;line-height: 40px;margin-bottom: 10px;">
	<h1 style="font-size: 20px;color: #000;">修改初始密码<h1>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="" target="_self">
		<input type="hidden" name="dbid" id="dbid" value="${user2.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width:400px;text-align: center;margin: 0 auto;margin-top: 40px;">
			<tr height="42">
				<td class="formTableTdLeft" style="width: 60px;">新密码:&nbsp;</td>
				<td ><input type="password" name="password" id="password"
					value="" class="large text" title="新密码"	checkType="string,3,20" tip="新密码不能为空，字符长度为3,20"><span style="color: red;">*</span></td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft" style="width: 60px;">确认密码:&nbsp;</td>
				<td ><input type="password" name="repassword" id="repassword"
					 class="large text" checkType="string,3,20" tip="确认密码不能为空，字符长度为3,20"><span style="color: red;">*</span></td>
			</tr>
		</table>
	</form>
	<div style="width: 400px;margin: 0 auto;text-align: center;margin-top:20px;margin-bottom: 20px;">
		<a href="javascript:void(-1)"	onclick="submitForm('frmId','${ctx}/main/saveModifyPassword')"	class="sbutton" style="">保&nbsp;&nbsp;存</a> 
	</div>
	</div>
</body>
<script type="text/javascript">
function tips(content, time) {
	return art.dialog({
		id : 'Tips',
		title : false,
		cancel : false,
		lock : true,
		fixed : true
	}).content('<div style="padding: 0 1em;">' + content + '</div>').time(
			time || 1);
}
function submitForm(frmId, url, state) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId, state);
				$.post(url,params,function callBack(data) {
					if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
						tips(data[0].message);
						if (target == "_self") {
							setTimeout(
									function() {
										window.location.href = data[0].url
									}, 1000);
						}
						if (target == "_parent") {
							// 同时关闭弹出窗口
							var parent = window.parent;
							window.parent.frames["contentUrl"].location=data[0].url;
						}
						// 保存数据成功时页面需跳转到列表页面
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
						tips(data[0].message);
						// 保存失败时页面停留在数据编辑页面
					}
					return;
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		tips(e);
		return;
	}
}
</script>
</html>