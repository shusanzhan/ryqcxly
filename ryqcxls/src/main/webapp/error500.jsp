<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="pages/commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<title>系统错误</title>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="">系统发生错误</a>
</div>
<div class="alert alert-error" style="margin-top: 12px;font-size: 14px;">
	<p><span style="font-size: 15px;">错误类型</span>：500</p>
	<p><span style="font-size: 15px;">错误信息</span>：${error }</p> 
</div>
</body>
</html>