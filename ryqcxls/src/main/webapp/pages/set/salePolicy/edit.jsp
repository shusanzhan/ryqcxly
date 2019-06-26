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
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<title>商务政策</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/salePolicy/queryList'">商务政策</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(salePolicy) }">添加商务政策</c:if>
	<c:if test="${!empty(salePolicy) }">编辑商务政策</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="salePolicy.dbid" id="dbid" value="${salePolicy.dbid }">
		<input type="hidden" name="salePolicy.createDate" id="createDate" value="${salePolicy.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">经销商类型:&nbsp;</td>
				<td id="carModelLabel">
					<select id="distributorTypeId" name="distributorTypeId" class="largeX text"  checkType="integer,1" tip="请选择品牌">
						<option value="">请选择...</option>
						<c:forEach var="distributorType" items="${distributorTypes }">
							<option value="${distributorType.dbid }" ${salePolicy.distributorType.dbid==distributorType.dbid?'selected="selected"':'' } >${distributorType.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="salePolicy.title" id="title"
					value="${salePolicy.title }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<!-- <tr height="42">
				<td class="formTableTdLeft">设置:&nbsp;</td>
				<td >
					<label> <input type="checkbox" value="1" id="" name="">销售顾问是否可见</label>
				<span style="color: red;">*</span></td>
			</tr> -->
			<tr height="32">
				<td class="formTableTdLeft">总政策:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="salePolicy.content" id="content">${salePolicy.content }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/salePolicy/save',true)"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
var saleContent=CKEDITOR.replace("content");
</script>
</html>