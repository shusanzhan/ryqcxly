<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>快捷创建客户</title>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">添加客户资料</span>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post">
	<s:token></s:token>
	<div class="form-group">
	  <label class="control-label" for="inputSuccess1">姓名</label>
	  <input type="text" class="form-control" id="inputSuccess1" checkType="string,2,3">
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">电话</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="mobilePhone" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">email</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="email" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">整数</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="integer,1,20" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">浮点型</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="float,1,20" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">icard</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="IDCard" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">邮编</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="zipCode" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputWarning1">中文</label  >
	  <input type="text" class="form-control" id="inputWarning1" checkType="chinese" >
	</div>
	<div class="form-group">
	  <label class="control-label" for="inputError1">车型</label>
	  <input type="text" class="form-control" id="inputError1">
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="创建" id="tele_register" class="addbutton" onclick="submitFrm('frmId')">
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function submitFrm(frmId){
		validateForm(frmId);
	}
</script>
</html>