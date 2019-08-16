<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>微信红包-红包发送设置</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/factoryOrderSet/edit'">发送红包设置</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<div class="alert alert-error">
		<strong>提示:</strong>
			<p>【${enterprise.name }】 交车发红包状态：
				<c:if test="${enterprise.payStatus==1 }">
					<span style="color: red;font-size: 16px;font-weight: bold;">未开启</span>	
				</c:if>
				<c:if test="${enterprise.payStatus==2 }">
					 <span style="color: green;font-size: 16px;font-weight: bold;">已开启</span>
				</c:if>
			</p>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="enterpriseId" id="dbid" value="${enterprise.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">发红包状态:&nbsp;</td>
				<td >
					<label style="float: left;"><input type="radio" value="1" name="payStatus" id="payStatus"   ${enterprise.payStatus==1?'checked="checked"':'' }>停用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<label style="float: left;"><input type="radio" value="2" name="payStatus" id="payStatus"   ${enterprise.payStatus==2?'checked="checked"':'' }>启用</label>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/redBagSet/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		</div>
	</form>
	</div>
</body>
</html>