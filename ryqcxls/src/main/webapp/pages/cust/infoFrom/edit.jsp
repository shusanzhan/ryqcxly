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
<title>用户信息来源</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/infoFrom/queryList'">信息来源管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(infoFrom) }">添加信息来源</c:if>
	<c:if test="${!empty(infoFrom) }">编辑信息来源</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="infoFrom.dbid" id="dbid" value="${infoFrom.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="infoFrom.name" id="name"
					value="${infoFrom.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td>
					<select id="type" name="infoFrom.type" class="largeX text" checkType="string,1,50" tip="类型不能为空">
							<option value="">请选择</option>
							<option value="外展" ${infoFrom.type=='外展'?'selected="selected"':''} >外展</option>
							<option value="传统媒体" ${infoFrom.type=='传统媒体'?'selected="selected"':''} >传统媒体</option>
							<option value="垂直化媒体" ${infoFrom.type=='垂直化媒体'?'selected="selected"':''} >垂直化媒体</option>
							<option value="网络媒体" ${infoFrom.type=='网络媒体'?'selected="selected"':''} >网络媒体</option>
							<option value="其他渠道" ${infoFrom.type=='其他渠道'?'selected="selected"':''} >其他渠道</option>
						</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">品牌:&nbsp;</td>
				<td >
					<select id="brandId" name="brandId" class="largeX text" checkType="string,1,50" tip="品牌不能为空">
						<option value="">请选择</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${infoFrom.brand.dbid==brand.dbid?'selected="selected"':''} >${brand.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">应用场景:&nbsp;</td>
				<td >
					<c:if test="${empty(infoFrom) }">
						<label><input type="radio" id="self" name="infoFrom.self" value="1" checked="checked">厂商</label>
						<label><input type="radio" id="self1" name="infoFrom.self" value="2" >自有店</label>
					</c:if>
					<c:if test="${!empty(infoFrom) }">
						<label><input type="radio" id="self" name="infoFrom.self" value="1" ${infoFrom.self==1?'checked="checked"':'' } >厂商</label>
						<label><input type="radio" id="self1" name="infoFrom.self" value="2" ${infoFrom.self==2?'checked="checked"':'' }>自有店</label>
					</c:if>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="infoFrom.note" id="note">${infoFrom.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/infoFrom/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>