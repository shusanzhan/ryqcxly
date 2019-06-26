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
<title>活动申请</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/share/queryList'">申请管理</a>-
<a href="javascript:void(-1);">
	查看活动申请
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<s:token></s:token>
		<div style="line-height: 40px;">
			<div style="float: left;"><h3 style="padding: 0px;margin: 0px;">${shareAplay.name } 申请信息</h3></div>
			<div class="clear"></div>
		</div>
		<div class="line"></div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="shareAplay.name" id="name"
					value="${shareAplay.name }" class="largeX text" title="名称"	checkType="string,1,50" ></td>
				<td class="formTableTdLeft">手机号码:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="shareAplay.phone" id="phone"
					value="${shareAplay.phone }" class="largeX text" title="名称"	checkType="string,1,50" ></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车系:&nbsp;</td>
				<td ><input type="text" disabled="disabled" 
					value="${shareAplay.carSeriy.name }" class="largeX text" 	></td>
				<td class="formTableTdLeft">申请时间:&nbsp;</td>
				<td ><input type="text" disabled="disabled" name="shareAplay.applyDate" id="applyDate"
					value='<fmt:formatDate value="${shareAplay.applyDate }" pattern="yyyy-MM-dd HH:mm"/>' class="largeX text" 	></td>
			</tr>
		</table>
		<div style="line-height: 40px;"><h3 style="padding: 0px;margin: 0px;">处理信息</h3></div>
		<div class="line"></div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="dbid" id="dbid" value="${shareAplay.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 5px;">
			<tr height="120">
				<td class="formTableTdLeft">处理时间</td>
				<td>
					<input type="text" readonly="readonly"  name="operatorDate" id="operatorDate"
					value='<fmt:formatDate value="${shareAplay.dealDate }" pattern="yyyy-MM-dd HH:mm"/>' 	>
				</td>
				<td class="formTableTdLeft">登记时间</td>
				<td>
					<input type="text" readonly="readonly"  name="operatorDate" id="operatorDate"
					value='<fmt:formatDate value="${shareAplay.recordDate }" pattern="yyyy-MM-dd HH:mm"/>' >
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">处理人</td>
				<td>
					<input type="text" readonly="readonly"  name="operatorDate" id="operatorDate"
					value="${shareAplay.user.realName }" >
				</td>
				<td class="formTableTdLeft">备注</td>
				<td>
					<textarea rows="" readonly="readonly" cols="" class="largeXXX textarea" id="dealNote" name="dealNote" checkType="string,1,2000">${shareAplay.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
</html>