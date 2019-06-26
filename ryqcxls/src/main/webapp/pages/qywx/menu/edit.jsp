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
<title>应用管理-菜单管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="${ctx }/app/queryList" >应用管理</a>-
<a href="javascript:void(-1);" >菜单管理</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
			<input type="hidden" value="${appMenu.dbid }" id="dbid" name="appMenu.dbid">
			<input type="hidden" value="${app.dbid }" id="appDbid" name="appDbid">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">菜单名称:&nbsp;</td>
				<td ><input type="text" name="appMenu.name" id="name" 
					value="${appMenu.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			 <tr height="42">
				<td class="formTableTdLeft">上级菜单：&nbsp;</td>
				<td >
				<select id="parentId" name="parentId"  class="largeX text">
					<option value="0" >顶级分类</option>
						${productCateGorySelect }
				</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">动作设置：&nbsp;</td>
				<td >
						<select id="type" name="appMenu.type" checkType="string,1,20"  tip="请选择动作" class="largeX text" >
							<option value="click" ${appMenu.type=='click'?'selected="selected"':'' }>消息类触发</option>
							<option value="view" ${appMenu.type=='view'?'selected="selected"':'' }>网页链接类</option>
						</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">URL或触发关键词：&nbsp;</td>
				<td >
					<input type="text" class="largeXX text" name="appMenu.url" id="url"  value="${appMenu.url }" checkType="string,1,500" tip="请输入URL或触发关键词！"/>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">排序：&nbsp;</td>
				<td >
					<input type="text" class="largeX text" name="appMenu.orders" id="orders"  value="${appMenu.orders }" checkType="integer,1" tip="请输入排序号！"/>
				<span style="color: red;">*</span></td>
			</tr> 
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/appMenu/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>
