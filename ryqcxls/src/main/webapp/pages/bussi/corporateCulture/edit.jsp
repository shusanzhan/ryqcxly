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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<style type="text/css">
.formTableTdLeft{
	width: 60px;
}
</style>
<title>企业文化</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">企业文化</a>-
	<a href="javascript:void(-1);" onclick="">添加/编辑</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="corporateCulture.dbid" id="dbid" value="${corporateCulture.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">封面:<span style="color: red;">*</span></td>
				<td style="height:90px ">
					<input type="hidden" name="corporateCulture.picture" id="picture" readonly="readonly"	value="${corporateCulture.picture }">
					<img alt="" id="pictureImg" src="${corporateCulture.picture}" width="150" height="90" style="width: 150px;height:90px ">
					<a href="javascript:void(-1)" onclick="uploadFile('picture','pictureImg')">上传头像头像</a>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">类型:<span style="color: red;">*</span></td>
				<td>
					<select class="largeXX text" id="corporateCultureTypeId" name="corporateCultureTypeId" checkType="integer,1" style="width:326px; ">
						<option value="-1">请选择</option>
						<c:forEach var="corporateCultureType" items="${corporateCultureTypes }">
							<option value="${corporateCultureType.dbid }"  ${corporateCulture.corporateCultureType.dbid==corporateCultureType.dbid?'selected="selected"':''}>${corporateCultureType.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">标题:<span style="color: red;">*</span></td>
				<td>
					<input type="text" name="corporateCulture.title" id="title"	value="${corporateCulture.title }" class="largeXX text" title="biaot"	checkType="string,1,50" tip="标题不能为空,1-50个字符">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">作者:<span style="color: red;">*</span></td>
				<td>
					<input type="text" name="corporateCulture.creator" id="creator"	value="${corporateCulture.creator }" class="largeXX text" title="作者"	checkType="string,1,50" tip="作者不能为空">
					
				</td>
			</tr>
			<tr height="60" style="height: 70px;">
				<td class="formTableTdLeft">摘要<span style="color: red;">*</span></td>
				<td>
					<textarea name="corporateCulture.description" id="description" rows="6" class="largeXX text"  style="height: 60px;line-height: 100%;" title="摘要"	checkType="string,20,500" tip="摘要不能为空，20-500个字符">${corporateCulture.description}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea name="corporateCulture.content" id="content" title="内容简介"  >${corporateCulture.content }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/corporateCulture/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
	var editor=CKEDITOR.replace("content");
</script>
</html>