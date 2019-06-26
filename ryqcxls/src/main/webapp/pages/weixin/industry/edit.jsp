<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>添加|编辑行业管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack4.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
      	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
      	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/industry/queryList'">行业管理</a>
</div>
<div class="frmContent">
<form  method="post" action="" 	name="frmId" id="frmId">
	<input type="hidden" value="${industry.dbid }" id="dbid" name="industry.dbid">
	<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
	<tr height="42">
		<td class="formTableTdLeft" >名称：</td>
		<td>
			<input type="text" class="largeX text" name="industry.name"	id="name" value="${industry.name }" checkType="string,1,20"  tip="请输入行业管理名称！"  />
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >上级分类：</td>
		<td>
			<select id="parentId" name="parentId" class="large text" checkType="integer,0" tip="请选择上级分类">
				<option value="0" >顶级分类</option>
				${cusString }
			</select>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >类型：</td>
		<td>
			<select id="industry.type" name="industry.type" class="large text" checkType="integer,1" tip="请选择类型">
				<option value="0" >行业分类</option>
				<option value="1" ${industry.type==1?'selected="selected"':'' } >主行业</option>
				<option value="2" ${industry.type==2?'selected="selected"':'' }>副行业</option>
			</select>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >代码：</td>
		<td>
			<input type="text" class="largeX text" name="industry.code" id="code"  value="${industry.code }" checkType="string,1"  tip="请输入排序号！"/>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >排序：</td>
		<td>
			<input type="text" class="largeX text" name="industry.num" id="num"  value="${industry.num }" checkType="integer" canEmpty="Y" tip="请输入排序号！"/>
		</td>
	</tr>
	<tr height="42">
		<td class="formTableTdLeft" >备注：</td>
		<td>
			<textarea class="largeX text" name="industry.note" id="note"  style="height: 60px;">${industry.note }</textarea>
		</td>
	</tr>
	</table>
</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/industry/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>
