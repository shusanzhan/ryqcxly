<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>推荐客户无效原因</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/flowReason/queryList'">推荐客户无效原因</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${flowReason.dbid }" id="dbid" name="flowReason.dbid">
		<input type="hidden" value="${flowReason.createDate }" id="createDate" name="flowReason.createDate">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<tr height="42">
			<td class="formTableTdLeft" >名称：</td>
			<td>
			<input type="text" class="large text" name="flowReason.name"	id="name" value="${flowReason.name }" checkType="string,1,20"  tip="请输入名称！"  />
			</td>
		</tr>
		<tr>
			<td>排序：</td>
			<td>
				<input type="text" class="large text" name="flowReason.orderNum" id="orderNum"  value="${flowReason.orderNum }" checkType="integer,1"  tip="请输入排序号！"/>
			</td>
		</tr>
		<tr height="42">
			<td>备注：</td>
			<td>
				<textarea class="largeX text" style="width: 320px;height: 60px;" name="flowReason.note" id="note"  >${flowReason.note}</textarea>
			</td>
		</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/flowReason/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
</html>
