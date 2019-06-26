<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>背景音乐添加/编辑</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId" target="_parent">
		<input type="hidden" value="${bussiCard.dbid }" id="dbid" name="bussiCard.dbid">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr id="logoDiv" height="100">
					<td class="formTableTdLeft">名片类型：</td>
					<td>
						<select  class="select text mideaX" id="type" name="bussiCard.type" checkType="integer,1" tip="请选择名片类型">
							<option value="-1">请选择</option>
							<option value="1" ${bussiCard.type==1?'selected="selected"':'' } >销售</option>
							<option value="2" ${bussiCard.type==2?'selected="selected"':'' }>售后</option>
						</select>
					</td>
				</tr>
				<tr id="logoDiv" height="100">
					<td class="formTableTdLeft">头像：</td>
					<td>
						<input type="hidden" name="bussiCard.picture" id="picture" readonly="readonly"	value="${bussiCard.picture }">
						<img alt="" id="pictureImg" src="${bussiCard.picture}" width="150" height="90">
						<a href="javascript:void(-1)" onclick="uploadFile('picture','pictureImg')">上传头像头像</a>
					</td>
					<td class="formTableTdLeft">二维码<span style="color: red">*</span>：</td>
					<td>
						<input type="hidden" name="bussiCard.wechatQrCode" id="wechatQrCode" readonly="readonly"	value="${bussiCard.wechatQrCode }">
						<img alt="" id="wechatQrCodeImg" src="${bussiCard.wechatQrCode}" width="150" height="90">
						<a href="javascript:void(-1)" onclick="uploadFile('wechatQrCode','wechatQrCodeImg')">微信关注二维码</a>
					</td>
				</tr>
				<tr id="logoDiv">
					<td class="formTableTdLeft">名称<span style="color: red">*</span>：</td>
					<td>
						<input type="text" name="bussiCard.name" id="name" class="text mideaX" value="${bussiCard.name }" checkType="string,1" tip="请输入客户名称">
					</td>
					<td class="formTableTdLeft">电话<span style="color: red">*</span>：</td>
					<td>
						<input type="text" name="bussiCard.mobilePhone" id="mobilePhone" class="text mideaX" value="${bussiCard.mobilePhone }" checkType="mobilePhone" tip="请输入联系电话">
					</td>
				</tr>
				<tr id="logoDiv">
					<td class="formTableTdLeft">职位<span style="color: red">*</span>：</td>
					<td>
						<input type="text" name="bussiCard.position" id="position" class="text mideaX" value="${bussiCard.position }" checkType="string,1" tip="请输入职位">
					</td>
					<td class="formTableTdLeft">职位（英文）<span style="color: red">*</span>：</td>
					<td>
						<input type="text" name="bussiCard.enPosition" id="enPosition" class="text mideaX" value="${bussiCard.enPosition }" checkType="string,1" tip="请输入职位（英文）">
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">电子邮箱：</td>
					<td>
						<input type="text" name="bussiCard.email" id="email" class="text mideaX" value="${bussiCard.email }" checkType="email" canEmpty="Y" tip="请输入电子邮箱,可为空">
					</td>
				</tr>
				<tr style="height: 50px;">
					<td class="formTableTdLeft">备注：</td>
					<td>
						<textarea class="largeX text" name="bussiCard.note" rows="5" style="height: 50px;"	id="note" >${bussiCard.note }</textarea>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/bussiCard/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
</html>
