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
<title>库房管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/storeRoom/queryList'">库房管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(storeRoom) }">添加库房</c:if>
	<c:if test="${!empty(storeRoom) }">编辑库房</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="storeRoom.dbid" id="dbid" value="${storeRoom.dbid }">
		<input type="hidden" name="storeRoom.createDate" id="createDate" value="${storeRoom.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">区域：</td>
				<td>
					<select id="storeAreaId" class="large text" name="storeAreaId"  checkType="integer,0" tip="请选择品牌">
						<option value="0">请选择...</option>
						<c:forEach var="storeArea" items="${storeAreas }">
							<option value="${storeArea.dbid }" ${storeArea.dbid==storeRoom.storeArea.dbid?'selected="selected"':'' }>${storeArea.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">类型:&nbsp;</td>
				<td >
					<select id="type" class="large text" name="storeRoom.type"  checkType="integer,0" tip="请选类型" onchange="ctype(this.value)">
						<option value="0">请选择...</option>
						<option value="1" ${storeRoom.type==1?'selected="selected"':'' } >自有</option>
						<option value="2" ${storeRoom.type==2?'selected="selected"':'' }>分公司</option>
						<option value="3" ${storeRoom.type==3?'selected="selected"':'' }>二网</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<c:if test="${empty(storeRoom) }">
				<tr id="typeTr" height="42" style="display: none;">
					<td class="formTableTdLeft">分公司:&nbsp;</td>
					<td >
						<select id="shopId" class="large text" name="shopId"  checkType="integer,0" tip="请选分公司">
							<option value="0">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==storeRoom.enterprise.dbid?'selected="selected"':'' }>${enterprise.name }</option>
							</c:forEach>
						</select>
					<span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<c:if test="${!empty(storeRoom) }">
				<tr id="typeTr"  height="42" style="${storeRoom.type==2?'':'display: none;'}">
					<td class="formTableTdLeft">分公司:&nbsp;</td>
					<td >
						<select id="shopId" class="large text" name="shopId"  checkType="integer,0" tip="请选分公司">
							<option value="0">请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${enterprise.dbid==storeRoom.shop.dbid?'selected="selected"':'' }>${enterprise.name }</option>
							</c:forEach>
						</select>
					<span style="color: red;">*</span></td>
				</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="storeRoom.name" id="name"
					value="${storeRoom.name }" class="largex text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="storeRoom.note" id="note">${storeRoom.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/storeRoom/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
	function ctype(value){
		if(value==2){
			$("#typeTr").show();
		}else{
			$("#typeTr").hide();
			$("#shopId option[value='0']").attr("selected",true);
		}
	}
</script>
</html>