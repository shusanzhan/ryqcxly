<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<title>无可挂账保险</title>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/cashInsurance/queryList'">保险收银</a>-
	<a href="javascript:void(-1);" onclick="">无可挂账保险</a>
</div>
<div class="alert alert-error" style="margin-top: 12px;font-size: 24px;">
	<strong>该保险已挂帐，不可重复操作！</strong> 
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
</div>
</body>
</html>