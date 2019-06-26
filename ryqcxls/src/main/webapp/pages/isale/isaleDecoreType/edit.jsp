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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<title>装饰基础设置</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">装饰基础设置</a>
</div>
<div class="line"></div>
<div class="frmContent" style="margin-bottom: 50px;">
	<div class="alert alert-error" id="message" style="display: none;">
	</div>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="isaleDecoreType.dbid" value="${isaleDecoreType.dbid }" id="dbid">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="60">
				<td class="formTableTdLeft" style='width:180px'>
					装饰业务模式
				</td>
				<td>
					<c:if test="${empty(isaleDecoreType.decoreType) }">
						<label>
							<input type="radio" id="decoreType" name="isaleDecoreType.decoreType" value="1" checked="checked">自有装饰部
						</label>
						<label>
							<input type="radio" id="decoreType"  name="isaleDecoreType.decoreType" value="2">第三方外包
						</label>
					</c:if>
					<c:if test="${!empty(isaleDecoreType.decoreType) }">
						<label>
							<input type="radio" id="grofitAprovalStatus1"  name="isaleDecoreType.decoreType" value="1" ${isaleDecoreType.decoreType==1?'checked="checked"':'' } >自有装饰部
						</label>
						<label>
							<input type="radio" id="grofitAprovalStatus2"  name="isaleDecoreType.decoreType" value="2" ${isaleDecoreType.decoreType==2?'checked="checked"':'' }>第三方外包
						</label>
					</c:if>
				</td>
			</tr>
			<tr height="60">
				<td class="formTableTdLeft" style='width:180px'>
					是否开启财务模块
				</td>
				<td>
					<c:if test="${empty(isaleDecoreType.finStatus) }">
						<label>
							<input type="radio" id="finStatus" name="isaleDecoreType.finStatus" value="1" checked="checked">默认
						</label>
						<label>
							<input type="radio" id="finStatus"  name="isaleDecoreType.finStatus" value="2">开启财务模块，装饰出库
						</label>
					</c:if>
					<c:if test="${!empty(isaleDecoreType.finStatus) }">
						<label>
							<input type="radio" id="finStatus"  name="isaleDecoreType.finStatus" value="1" ${isaleDecoreType.finStatus==1?'checked="checked"':'' } >默认
						</label>
						<label>
							<input type="radio" id="finStatus"  name="isaleDecoreType.finStatus" value="2" ${isaleDecoreType.finStatus==2?'checked="checked"':'' }>开启财务模块，装饰出库
						</label>
					</c:if>
					
					<span style="color: red">说明：默认为未开启财务模块，装饰可以正常出库；开启财务模块，装饰出库必须完成收银操作。</span>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/isaleDecoreType/save')"	class="but butSave">保存</a> 
	</div>
	</div>
</body>
</html>