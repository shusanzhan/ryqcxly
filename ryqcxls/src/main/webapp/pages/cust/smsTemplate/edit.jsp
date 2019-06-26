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
<title>添加短信模板</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/smsTemplate/queryList'">短信模板管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(smsTemplate) }">添加短信模板</c:if>
	<c:if test="${!empty(smsTemplate) }">编辑短信模板</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="smsTemplate.dbid" id="dbid" value="${smsTemplate.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td>
					<input id="name" name="smsTemplate.name" value="${smsTemplate.name }" class="large text" tip="请输入短信模板名称" checkType="string,1">
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td>
					<select id="type" name="smsTemplate.type" class="large text" checkType="integer,0" tip="请选择类型">
						<option>请选择类型...</option>
						<option value="1" ${smsTemplate.type==1?'selected="selected"':'' } >必发短信</option>
						<option value="2" ${smsTemplate.type==2?'selected="selected"':'' } >商务营销</option>
						<option value="3" ${smsTemplate.type==3?'selected="selected"':'' } >日常祝福</option>
						<option value="4" ${smsTemplate.type==4?'selected="selected"':'' } >生日祝福</option>
						<option value="5" ${smsTemplate.type==5?'selected="selected"':'' } >节日祝福</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft">短信内容:&nbsp;</td>
				<td colspan="3">
					<textarea   class="largeXX textarea" name="smsTemplate.content" id="content" onkeyup="jisuanc(this.value)" cols="60" rows="120" style="height: 120px;width: 420px;" tip="请输入短信内容,内容长度小于46" checkType="string,6,46">${smsTemplate.content }</textarea>
					<span id="sp" style="color: red;"></span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/smsTemplate/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
	function jisuanc(val){
		var s=46-val.length;
		if(s>=0){
			$("#sp").text("您还能输入"+s+"字符");
		}else{
			$("#content").val(val.substring(0,46));
		}
	}
</script>
</html>