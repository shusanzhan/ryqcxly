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
<title>经销商负责人</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/distributorBrand/queryList'">经销商负责人管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(distributorBrand) }">添加经销商负责人</c:if>
	<c:if test="${!empty(distributorBrand) }">编辑经销商负责人</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<div style="width: 750px;height: 60px;text-align: center;margin: 0 auto;margin-top: 12px;">
		<div class="programActive">
			1、基本信息
		</div>
		<div class="programActive">
			2、项目负责人
		</div>
		<div class="programActive">
			3、销售员
		</div>
		<div class="programActive">
			4、经营其他品牌
		</div>
		<div class="program">
			5、三级网点
		</div>
		<div class="clear"></div>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="distributorBrand.dbid" id="dbid" value="${distributorBrand.dbid }">
		<c:if test="${ !empty(distributorBrand)}">
			<input type="hidden" name="distributorBrand.distributorId" id="distributorId" value="${distributorBrand.distributorId }">
		</c:if>
		<c:if test="${ empty(distributorBrand)}">
			<input type="hidden" name="distributorBrand.distributorId" id="distributorId" value="${param.distributorId }">
		</c:if>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">品牌:&nbsp;</td>
				<td >
					<select id="brandId" class="largeX text" name="brandId" checkType="integer,1" tip="请选品牌">
						<option>请选择...</option>
						<c:forEach items="${brands }" var="brand">
							<option  value="${brand.dbid }" ${brand.dbid==distributorBrand.brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">姓名:&nbsp;</td>
				<td ><input type="text" name="distributorBrand.contactName" id="contactName"
					value="${distributorBrand.contactName }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">手机号码:&nbsp;</td>
				<td ><input type="text" name="distributorBrand.mobilePhone" id="mobilePhone"
					value="${distributorBrand.mobilePhone }" class="largeX text" title="手机号码"	checkType="mobilePhone" tip="手机号码不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">座机:&nbsp;</td>
				<td ><input type="text" name="distributorBrand.phone" id="phone"
					value="${distributorBrand.phone }" class="largeX text" title="座机"	checkType="phone" canEmpty="Y" tip="座机可为空"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td ><input type="text" name="distributorBrand.address" id="address"
					value="${distributorBrand.address }" class="largeX text" title="地址"	checkType="string,1,50" tip="地址不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="distributorBrand.note" id="note">${distributorBrand.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/distributorBrand/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>